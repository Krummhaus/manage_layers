import psycopg2 as pg
from qgis.core import Qgis
import re

orp_dict = {434:'Blatná',
            302:'České Budějovice',
            329:'Český Krumlov',
            345:'Jindřichův Hradec',
            337:'Dačice',
            311:'Kaplice',
            369:'Milevsko',
            418:'Prachatice',
            400:'Pisek',
            469:'Sobeslav',
            442:'Strakonice',
            281:'Trhové Sviny',
            477:'Tábor',
            353:'Třeboň',
            299:'Týn nad Vltavou',
            426:'Vimperk',
            451:'Vodňany'}

def pick_orp():
    '''
    Picks name of ORP from "orp" dictionary
    Returns tuple with (ORP name, return status)
    '''
    i_orp, i_ok = QInputDialog.getItem(parent, "ORP", "Vyber ORP", orp, editable=False)
    if i_ok:
        return i_orp
    else:
        iface.messageBar().pushMessage("Error", "Nepodařilo se vybrat ORP",
                                        level=Qgis.Critical, duration=9)


def pick_obec(obec):
    '''
    Takes input form  and returns list of Obci to pick form.
    Then returns selected OBEC
    '''
    i_obec, i_ok = QInputDialog.getItem(parent, "Obec", "Vyber obec",
    obec, editable=False)
    return i_obec
    
    
def querry(command):
    conn = None
    try:
        # Connection
        conn = pg.connect(
                    host="10.2.1.11",
                    database="postgis",
                    user="editor",
                    password="Ee2022")
        
        # DB Cursor
        cur = conn.cursor()
        # Commans execution
        cur.execute(command)
        # Fetch all items
        result = cur.fetchall()
        cur.close()
        conn.commit()
        return result
        
    except (Exception, pg.DatabaseError) as error:
        print(error)
    
    finally:
        if conn is not None:
            conn.close()


def field_to_value_map(lyr_fields, layer, field, list_values):
    ''' Funkce která nic nevrací, akorát provede vytvoření
    pick-listů dle zadaných parametrů

    Vstupy:
    ---
    lyr_fields = objekt s atributy polí(fields) ve vrstvě(layer)<class 'qgis._core..'>
    layer = objekt vrstvy(layer)<class 'qgis._core..'>
    field = název atr. pole <class 'str'>
    list_values = vkládané hodnoty pick-listu <class 'dict'>
    '''
    config = {'map' : list_values}
    widget_setup = QgsEditorWidgetSetup('ValueMap',config)
    field_idx = lyr_fields.indexFromName(field)
    layer.setEditorWidgetSetup(field_idx, widget_setup)
    
    
def qgs_set_default_atr(lyr, atr_field, def_f_val):
    fields = lyr.fields()
    f_idx = fields.indexFromName(atr_field)
    lyr.setDefaultValueDefinition(f_idx,QgsDefaultValue(def_f_val, True))
    
    
parent =  iface.mainWindow()
mc = iface.mapCanvas()# iface = celý interface # mapcanvas() = map. okno
lyrs = mc.layers()

def main():
    # Zjistit v tabulce "step5_zps_bdef_objekty_dtmcr" na jakém ORP se práve pracuje
    orp_fetch = querry("""select distinct(orp) from step5_zps_bdef_objekty_dtmcr""")
    # Cislo ORP
    orp_num = int(orp_fetch[0][0])
    # Na zaklade cisla ORP vybrat prislusne OBCE
    obce_fetch = querry(f"""select distinct(obec) from step5_zps_bdef_objekty_dtmcr
                            where orp = {orp_num}""")
    # Kontajner pro nazvy OBCI                        
    obce_list = [obec[0] for obec in obce_fetch]
    # Serazene podle nazvu
    sorted_obce = sorted(obce_list, key=lambda x: re.split("_|-", x)[-1])
    
    orp_aktual = {orp_dict[orp_num]:orp_num}
    
    obec_aktual = {}
    for obec in sorted_obce:
        obec_aktual.update({obec:obec})
    
    # Dialg. okno. pro vyber default hodnot
    input_obec = pick_obec(obec_aktual)
    input_obec = f"'{input_obec}'"
    
    # Nastaveni Picklistu dle aktualniho ORP
    for lyr in lyrs: # pro každou vrstvu v map. okn. Qgisu
        if isinstance(lyr, QgsVectorLayer):
            lyr_name = lyr.sourceName() # jméno vrstvy
            if lyr_name.startswith('s_'):
                # qgis.core objekt vrstvy dle výše získaného jména
                layer = QgsProject.instance().mapLayersByName(lyr_name)[0]
                lyr_fields = lyr.fields()
                for field in lyr_fields.names():
                    if field == 'orp': # pokud je atribut ve slovníku
                        # PICKLIST
                        field_to_value_map(lyr_fields, layer, field, orp_aktual)
                        # DEFAULT VAL.
                        qgs_set_default_atr(lyr, field, str(orp_num))
                    if field == 'obec': # pokud je atribut ve slovníku
                        # PICKLIST
                        field_to_value_map(lyr_fields, layer, field, obec_aktual)
                        # DEFAULT VAL.
                        qgs_set_default_atr(lyr, field, input_obec)
    
    iface.messageBar().pushMessage("Hotovo", f"Pick-listy pro ORP: {orp_aktual} vytvořeny.",
                                    level=Qgis.Success, duration=9)
                                    
    iface.messageBar().pushMessage("Hotovo", f"Defaultní nastavení ORP={orp_num}, OBEC={input_obec}.",
                                    level=Qgis.Info, duration=9)
    

    
    
main()
