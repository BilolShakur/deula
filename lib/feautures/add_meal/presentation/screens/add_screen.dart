import 'package:deula/core/constants/app_colors.dart';
import 'package:deula/feautures/home/domain/models/meal_model.dart';

import 'package:deula/feautures/home/presentation/screens/bloc/meal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();
  final _sugarController = TextEditingController();

  void _saveMeal() {
    if (_formKey.currentState!.validate()) {
      final meal = MealData(
        title: _titleController.text,
        calories: double.tryParse(_caloriesController.text) ?? 0,
        protein: double.tryParse(_proteinController.text),
        fat: double.tryParse(_fatController.text),
        sugar: double.tryParse(_sugarController.text),
      );

      context.read<MealBloc>().add(AddMeal(meal));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MealBloc, MealState>(
      listener: (context, state) {
        if (state is MealLoaded) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(tr("meal_added_success"))));

          _formKey.currentState?.reset();
          _titleController.clear();
          _caloriesController.clear();
          _proteinController.clear();
          _fatController.clear();
          _sugarController.clear();
        } else if (state is MealError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr("add_meal")),
          backgroundColor: AppColors.primary,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildField(
                  controller: _titleController,
                  label: tr("label_title"),
                  hint: tr("hint_meal_name"),
                  validator: (val) => val == null || val.isEmpty
                      ? tr("validation_required")
                      : null,
                ),
                _buildField(
                  controller: _caloriesController,
                  label: tr("label_calories"),
                  hint: "e.g. 400",
                  inputType: TextInputType.number,
                  validator: (val) => val == null || val.isEmpty
                      ? tr("validation_required")
                      : null,
                ),
                _buildField(
                  controller: _proteinController,
                  label: tr("label_protein"),
                  hint: "optional",
                  inputType: TextInputType.number,
                ),
                _buildField(
                  controller: _fatController,
                  label: tr("label_fat"),
                  hint: "optional",
                  inputType: TextInputType.number,
                ),
                _buildField(
                  controller: _sugarController,
                  label: tr("label_sugar"),
                  hint: "optional",
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: _saveMeal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(tr("save"), style: TextStyle(fontSize: 16.sp)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? Function(String?)? validator,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
      ),
    );
  }
}
