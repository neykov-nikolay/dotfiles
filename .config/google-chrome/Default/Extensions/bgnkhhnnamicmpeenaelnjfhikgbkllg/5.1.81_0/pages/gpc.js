/******/ (() => { // webpackBootstrap
/******/ 	"use strict";

;// ./node_modules/.pnpm/@adguard+tswebextension@3.1.0-alpha.0_@adguard+re2-wasm@1.2.0/node_modules/@adguard/tswebextension/dist/common/stealth-helper.js
// Disable vi coverage for this file, because it will insert
// line comments, and code to count lines covered by tests, for example:
// /* istanbul ignore next */
// cov_uqm40oh03().f[0]++;
// cov_uqm40oh03().s[2]++;
// And we cannot test these strings correctly, because the names of these
// functions with counters are generated at runtime
/* istanbul ignore file */
/**
 * This module applies stealth actions in page context.
 */
class StealthHelper {
    /**
     * Sends a Global Privacy Control DOM signal.
     */
    static setDomSignal() {
        try {
            if ('globalPrivacyControl' in Navigator.prototype) {
                return;
            }
            Object.defineProperty(Navigator.prototype, 'globalPrivacyControl', {
                get: () => true,
                configurable: true,
                enumerable: true,
            });
        }
        catch (ex) {
            // Ignore
        }
    }
    /**
     * Hides document referrer.
     */
    static hideDocumentReferrer() {
        const origDescriptor = Object.getOwnPropertyDescriptor(Document.prototype, 'referrer');
        if (!origDescriptor || !origDescriptor.get || !origDescriptor.configurable) {
            return;
        }
        const returnEmptyReferrerFunc = () => '';
        // Protect getter from native code check
        returnEmptyReferrerFunc.toString = origDescriptor.get.toString.bind(origDescriptor.get);
        Object.defineProperty(Document.prototype, 'referrer', {
            get: returnEmptyReferrerFunc,
        });
    }
}



;// ./node_modules/.pnpm/@adguard+tswebextension@3.1.0-alpha.0_@adguard+re2-wasm@1.2.0/node_modules/@adguard/tswebextension/dist/gpc.mv3.js


/**
 * @typedef {import('../background/services/stealth-service').StealthService} StealthService
 */
/**
 * @file
 * IMPORTANT: This file should be listed inside 'sideEffects' field
 * in the package.json, because it has side effects: we do not export anything
 * from it outside, just evaluate the code (via injection).
 *
 * We will inject this script dynamically via `scripting.registerContentScripts`
 * inside {@link StealthService.setContentScript}.
 */
StealthHelper.setDomSignal();

;// ./Extension/pages/gpc/index.ts
/**
 * @file
 * This file is part of AdGuard Browser Extension (https://github.com/AdguardTeam/AdguardBrowserExtension).
 *
 * AdGuard Browser Extension is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * AdGuard Browser Extension is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with AdGuard Browser Extension. If not, see <http://www.gnu.org/licenses/>.
 */ /**
 * We do not inject this scripts manually from extension, because it will be
 * dynamically registered and unregistered by the tswebextension when the
 * stealth option is enabled/disabled.
 */ 

/******/ })()
;