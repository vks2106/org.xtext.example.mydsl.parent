/*
 * generated by Xtext 2.26.0
 */
package org.xtext.example.mydsl.formatting2

import com.google.inject.Inject
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument
import org.xtext.example.mydsl.services.MyDslGrammarAccess
import org.xtext.example.mydsl.myDsl.MyDslPackage
import org.eclipse.xtext.formatting2.internal.AbstractTextReplacer
import org.eclipse.xtext.formatting2.ITextReplacerContext
import org.xtext.example.mydsl.myDsl.Greeting

class MyDslFormatter extends AbstractFormatter2 {

	@Inject extension MyDslGrammarAccess

	def dispatch void format(Greeting model, extension IFormattableDocument document) {

		model.prepend[newLine]
		val region = model.regionFor.feature(MyDslPackage.Literals.GREETING__NAME)
		val r = new AbstractTextReplacer(document, region) {
			override createReplacements(ITextReplacerContext it) {

				var text = region.text.replace("\t", " ").replace("\n", " ")
				if (System.getProperty("os.name").toLowerCase().contains("win")) {
					text = text.replace("\r", " ")
				}

				val offset = region.offset
				var int index = text.indexOf(" ");
				while (index >= 0) {
					it.addReplacement(region.textRegionAccess.rewriter.createReplacement(offset + index, 1, ""))
					index = text.indexOf(" ", index + 1);
				}

				it
			}
		}

		addReplacer(r)
	}

}
