<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

	<!-- Access the bootstrap Css like this, 
		Spring boot will handle the resource mapping automcatically -->
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/4.1.0/css/bootstrap.min.css" />

	<!-- 
	<spring:url value="/css/main.css" var="springCss" />
	<link href="${springCss}" rel="stylesheet" />
	 -->
	<c:url value="/css/main.css" var="jstlCss" />
	<link href="${jstlCss}" rel="stylesheet" />

</head>
<body>

	<nav class="navbar navbar-inverse navbar navbar-dark bg-dark">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">${title}</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">About</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container" style="padding-top:20px;">
		<div class="row">
			<div class="col-sm">
				<div class="card">
					<div class="card-header">
						<h1>Formulario de Facturas</h1>
					</div>
					<div class="card-body">
						<div class="container">
							<form class="needs-validation">
								<div class="form-group">
							    	<label for="companyName">Nombre de la Empresa</label>
							    	<input type="text" class="form-control mandatory" id="companyName" placeholder="Empresa" >
							    	<div class="invalid-feedback">
							          Este campo es obligatorio
							        </div>
							  	</div>
							  	<div class="form-group">
							    	<label for="clientName">Nombre del Cliente</label>
							    	<input type="text" class="form-control  mandatory" id="clientName" placeholder="Cliente" >
							    	<div class="invalid-feedback">
							          Este campo es obligatorio
							        </div>
							  	</div>
							  	<div class="form-group">
							    	<label for="description">Descripcion</label>
							    	<input type="text" class="form-control  mandatory" id="description" placeholder="Descripcion" >
							    	<div class="invalid-feedback">
							          Este campo es obligatorio
							        </div>
							  	</div>
							  	<div class="form-group form-inline">
							  		<div class="form-group col-sm-6" style="padding-left:0px !important;">
								    	<label for="subTotal">Subtotal</label>
								    	<input type="number" class="form-control  mandatory" id="subTotal" placeholder="Subtotal" onchange="calculateTotal()" >
								    	<div class="invalid-feedback">
								          Este campo es obligatorio
								        </div>
								  	</div>
								  	<div class="form-group col-sm-6" style="padding-right:0px !important;">
								    	<label for="iva">Iva</label>
								    	<input type="number" class="form-control  mandatory" id="iva" placeholder="Iva" style="width:100% !important;" onchange="calculateTotal()" >
								    	<div class="invalid-feedback">
								          Este campo es obligatorio
								        </div>
								  	</div>
							  	</div>
							  	<div class="form-group">
							    	<label for="total">Total</label>
							    	<input type="text" class="form-control" id="total" placeholder="Total" disabled>
							  	</div>
							  	<button type="button" class="btn btn-success btn-block" onclick="addReceipt()">Agregar</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm">
				<div class="card" style="max-height: 583px;">
					<div class="card-header">
						<h1 id="receiptTitle">Facturas</h1>
					</div>
					<div class="card-body" style="overflow-y:scroll;">
						<div>
							<table id="receiptTable" class="col-sm-12">
								<thead>
									<tr>
										<th>Cliente</th>
										<th>Descripcion</th>
										<th>Total</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
					<div class="card-footer">
						<button type="button" class="btn btn-primary btn-block" onclick="addReceipt()">Generar XML</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="webjars/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		var company= null;
	
		function calculateTotal(){
			var subtotal = Number(document.getElementById("subTotal").value);
			var iva = Number(document.getElementById("iva").value);
				 
			if( !isNaN(subtotal) && !isNaN(iva)){
				document.getElementById("total").value = parseFloat(subtotal) + parseFloat(iva);
			}
		}
		
		function addReceipt(){
			if(!checkMandatory()){
				return;
			}
			if ( (company == null || company == undefined) 
					&& document.getElementById("companyName").value.trim() != ''){
				
				company = document.getElementById("companyName");
				document.getElementById("companyName").setAttribute("disabled","");
				document.getElementById("receiptTitle").innerHTML = "Facturas "+companyName.value;
			}
			var tableRef = document.getElementById('receiptTable').getElementsByTagName('tbody')[0];

			// Insert a row in the table at the last row
			var newRow   = tableRef.insertRow(tableRef.rows.length);
			newRow.innerHTML = "<td>"+document.getElementById("clientName").value+"</td>"
							+	"<td>"+document.getElementById("description").value+"</td>"
							+	"<td>"+document.getElementById("total").value+"</td>"
			
		}
		
		function checkMandatory(){
			var isValid = true;
			var fields = document.getElementsByClassName("mandatory");
			for(var i=0; i<fields.length; i++){
				var value = fields[i].value;
				if(value === undefined || value === null || value.trim() == ''){
					fields[i].classList.add("is-invalid");
					isValid = false;
				}
			}
			return isValid;
		}
	</script>
</body>

</html>