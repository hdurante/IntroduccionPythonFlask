from flask import Flask,jsonify,request
from flask_cors import CORS

app=Flask(__name__)
CORS(app)

idEntity=2
People = [{"Id":1,"Nombre": "Fulano", "ApellidoPaterno": "De", "ApellidoMaterno": "Tal"},
          {"Id":2,"Nombre": "Jhon", "ApellidoPaterno": "Doe", "ApellidoMaterno": "Unkkown"}]

@app.route('/api/status', methods=['GET'])
def status():
    return jsonify({"Status":"Ok"}),200

@app.route('/api/listpeople', methods=['GET'])
def listpeople():
    return jsonify(People),200

@app.route('/api/getperson', methods=['GET'])
def getperson():
    args=request.args
    id=args.get('id')
    for person in People:
        if person['Id']==int(id):
            return jsonify(person),200
    return None ,204

@app.route('/api/deleteperson', methods=['DELETE'])
def deleteperson():
    args=request.args
    id=args.get('id')
    index=0
    for person in People:
        if person['Id']==int(id):
            del People[index]
            return jsonify({"Status":f"Se elimino el id {id}"}),200
    index+=1
    return jsonify({"Status":f"El Resgitro: {id} no existe"}) ,204

@app.route('/api/addperson', methods=['POST'])
def addperson():
   data=request.get_json()
   global idEntity
   idEntity+=1
   data['Id']=idEntity
   People.append(data)
   return jsonify(idEntity),200

@app.route('/api/updateperson', methods=['POST'])
def updateperson():
    data=request.get_json()
    id=data['Id']
    index=0
    for person in People:
        if person['Id']==int(id):
            People[index]=data
            return jsonify({"Status":f"Se modifico el registro {id}"})
        index+=1
    return jsonify({"Status":f"No se pudo localizar el {id}"})
    

if __name__=='__main__':
    app.run(host='0.0.0.0')