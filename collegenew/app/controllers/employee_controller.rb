class EmployeeController < ApplicationController


def newemployee
  @cities=City.all
  @roles=Role.all
@employee=Employee.new
end

def createemployee
#raise params[:employee].inspect
 # params[:employee][role_id]=0
@employee=Employee.new(params[:employee])
#raise @employee.inspect
#raise @employee.valid?.inspect
#@employee.valid?

if @employee.save
 flash[:notice] = 'Employee Registered successfully.'
        redirect_to :action => 'showemployee'
else
  redirect_to :action => 'newemployee'
  
end
end

def showemployee
@employees=Employee.find(:all)
end

def editemployee
  @cities=City.find(:all)
   @roles=Role.find(:all)
  @employee=Employee.find(params[:id])
end

def updateemployee
  @employee = Employee.find_employee(params[:id])
     if @employee.update_attributes(params[:employee])
       flash[:notice] = 'Employee Updated  successfully.'
     else
       redirect_to :action => 'editemployee'
     end
     
end

end
