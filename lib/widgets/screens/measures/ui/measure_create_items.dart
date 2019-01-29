import 'package:flutter/material.dart';
import 'package:tailor_made/constants/mk_style.dart';
import 'package:tailor_made/models/measure.dart';
import 'package:tailor_made/widgets/_views/slide_down.dart';

class MeasureCreateItems extends StatelessWidget {
  const MeasureCreateItems({
    Key key,
    @required this.grouped,
    @required this.measurements,
  }) : super(key: key);

  final Map<String, List<MeasureModel>> grouped;
  final Map<String, double> measurements;

  @override
  Widget build(BuildContext context) {
    final slides = <SlideDownItem>[];

    grouped.forEach((key, data) {
      slides.add(SlideDownItem(
        title: key,
        body: JobMeasureBlock(
          measures: data.toList(),
          measurements: measurements,
        ),
        // isExpanded: true,
      ));
    });

    return Column(
      children: slides.toList(),
    );
  }
}

class JobMeasureBlock extends StatelessWidget {
  const JobMeasureBlock({
    Key key,
    @required this.measures,
    @required this.measurements,
  }) : super(key: key);

  final List<MeasureModel> measures;
  final Map<String, double> measurements;

  @override
  Widget build(BuildContext context) {
    final length = measures.length;
    return Theme(
      data: ThemeData(primaryColor: kPrimaryColor),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: MkBorderSide(),
          ),
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: measures.map((MeasureModel measure) {
            final index = measures.indexOf(measure);

            final _value = measurements.containsKey(measure.id)
                ? measurements[measure.id]
                : 0;
            final value = _value != null && _value > 0 ? _value.toString() : "";
            final _controller = TextEditingController(text: value);

            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final removeBorder =
                    (length % 2 != 0 && (index == length - 1)) ||
                        (length % 2 == 0 &&
                            (index == length - 1 || index == length - 2));
                return Container(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: MkBorderSide(
                        style:
                            removeBorder ? BorderStyle.none : BorderStyle.solid,
                      ),
                      right: MkBorderSide(
                        style: index % 2 == 0
                            ? BorderStyle.solid
                            : BorderStyle.none,
                      ),
                    ),
                  ),
                  width: constraints.maxWidth / 2,
                  child: TextFormField(
                    // initialValue: value,
                    controller: _controller,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      labelText: measure.name,
                      border: InputBorder.none,
                      labelStyle: TextStyle(fontSize: 14.0),
                    ),
                    onFieldSubmitted: (value) =>
                        measurements[measure.id] = double.tryParse(value),
                    onSaved: (value) =>
                        measurements[measure.id] = double.tryParse(value),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}