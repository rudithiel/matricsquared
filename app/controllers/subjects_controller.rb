class SubjectsController < ApplicationController
  
  def edit 
    @subjects = Subject.all
  end  
  
  def remove
    @subject = Subject.where(code: params[:code])
    current_user.subjects.delete(@subject)
    respond_to do |format|
      format.html { render 'subjects/edit' }
    end
  end
  
  def add 
     @subject = Subject.where(code: params[:code]) 
     current_user.subjects.push(@subject)
      respond_to do |format|
        format.html { render 'subjects/edit' }
      end
  end
  
  def update
    
    subject = Subject.where(code: "AFHT")
    if params.has_key?(:AFHT) && current_user.subjects.exclude?(subject)
      subject = Subject.where(code: "AFHT")
      current_user.subjects.push(subject)
    else
      subject = Subject.where(code: "AFHT")
      current_user.subjects.delete(subject)
    end
    
    subject = Subject.where(code: "INFT")
    if params.has_key?(:INFT) && current_user.subjects.exclude?(subject)
      subject = Subject.where(code: "INFT")
      current_user.subjects.push(subject)
    else
      subject = Subject.where(code: "INFT")
      current_user.subjects.delete(subject)
    end
    
    subject = Subject.where(code: "LFSC")
    if params.has_key?(:LFSC) && current_user.subjects.exclude?(subject)
      subject = Subject.where(code: "LFSC")
      current_user.subjects.push(subject)
    else
      subject = Subject.where(code: "LFSC")
      current_user.subjects.delete(subject)
    end
    
    subject = Subject.where(code: "MATH")
    if params.has_key?(:MATH) && current_user.subjects.exclude?(subject)
      subject = Subject.where(code: "MATH")
      current_user.subjects.push(subject)
    else
      subject = Subject.where(code: "MATH")
      current_user.subjects.delete(subject)
    end
    
    subject = Subject.where(code: "PHSC")
    if params.has_key?(:PHSC) && current_user.subjects.exclude?(subject)
      subject = Subject.where(code: "PHSC")
      current_user.subjects.push(subject)
    else
      subject = Subject.where(code: "PHSC")
      current_user.subjects.delete(subject)
    end
    
    
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end
  
end
