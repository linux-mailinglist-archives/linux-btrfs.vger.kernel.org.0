Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362171A5D9C
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Apr 2020 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgDLI5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Apr 2020 04:57:18 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:33335 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLI5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Apr 2020 04:57:18 -0400
Received: by mail-qt1-f182.google.com with SMTP id x2so4993762qtr.0
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Apr 2020 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6pD3nrZnTMZ7AVuyl49L1slWpdN/MQYroJhleW81+V8=;
        b=oWRZDqFHpNTdnUH2diNJrhj5eCIkc48TZzFPnpRfpW+au/VSNJMpcb1RxeqbYt97U1
         rDxg9JZ45IAqZXwwZTVS1rxq11yLH/3siHEwWfPLtq8z/oa8Jsi+VW3NygpokkYTUQWA
         cxAuqYLkdESaV7mfGZKomDjZBYuxxbLCZvChwMtTEu5igDHlCtprFSXL4sphDb0H+DlK
         6uAi40/4aXXqYCzULTFFM4BkRTniv61l3GjlrNC35zcTj/s/K9GS5lVTgPBHNaKHG7Dt
         TVK1MSBLWvjg/SdzUOdpbVhEhaRCynWHWXL32cVKmpooR2ckMmv2NrwJ+1lvrvp0LUFb
         qwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6pD3nrZnTMZ7AVuyl49L1slWpdN/MQYroJhleW81+V8=;
        b=tEu0JI9kZR23abJMyq/tlBOva4xVDsOme/iWi/OCpAjvGGhVBpA1rz9xCrfm281IqN
         ZOTBUABR0X0TbigtRMfIJeuAfB4i4/bRJRVk2eJLB6n1W2f8Ox+Cxu0F/TlxLcxVBWp2
         Q66w4ULuhNoTcc92ToRBAFOr0sXcHbX2PLiGOwFvj47uZJvfw3k8Ftq2oH8n1MZmZWlG
         4jVyG1P9xDdtrdwJbHm9CrM7SsVg2SNsP8vTSArmuKXDKHcV9EMt5pP9PRUbfT4uruBA
         q7ENjPZNxu3iwespMp+oDTeluvpXrRLKmAkwIM7EtsYtvSykxhr9Pn2VDCQ9CME5P3Th
         bLpQ==
X-Gm-Message-State: AGi0PubWyprucEYXlYOn40MiA27AzW6ZFN20kG4gtFiNtFJQ0cqzvUtA
        +V3HKQQ/7rUjpDya8zYxcnoPWnTTPWM9EJoyfxV0hB5eTXk=
X-Google-Smtp-Source: APiQypI8QXsKaMlqzQLoCbJ+4/GF2UEP11+4w236PXQvdGHC0XRzyRgm8DIchAPNo96Zvv7zmP4or1t+o3ParIPiRC8=
X-Received: by 2002:ac8:1b70:: with SMTP id p45mr6656749qtk.258.1586681835206;
 Sun, 12 Apr 2020 01:57:15 -0700 (PDT)
MIME-Version: 1.0
From:   stijn rutjens <rutjensstijn@gmail.com>
Date:   Sun, 12 Apr 2020 10:57:03 +0200
Message-ID: <CA+UfgrWR1rn-VbHHcK0+2cN08m0C529NtY-ofUMNX3mM4NoTaw@mail.gmail.com>
Subject: [PATCH] btrfs: allow setting per extent compression
To:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000028e51e05a3142712"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000028e51e05a3142712
Content-Type: text/plain; charset="UTF-8"

Hi all,
As mentioned in https://github.com/kdave/btrfs-progs/issues/184 it
would be nice to be able to set the compression level per extent (or
file) from the IOCTL interface.
I'm not sure how submitting patches to mailing lists works, but I have
attached a patch which implements this. Any and all feedback is
appreciated.
Kind regards,
Stijn Rutjens

--00000000000028e51e05a3142712
Content-Type: text/x-patch; charset="US-ASCII"; name="allow-per-extent-compression.patch"
Content-Disposition: attachment; 
	filename="allow-per-extent-compression.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8wta1rr0>
X-Attachment-Id: f_k8wta1rr0

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2ZpbGUtaXRlbS5jIGIvZnMvYnRyZnMvZmlsZS1pdGVtLmMK
aW5kZXggYmIzNzQwNDJkLi5lMTYwM2UxY2YgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2ZpbGUtaXRl
bS5jCisrKyBiL2ZzL2J0cmZzL2ZpbGUtaXRlbS5jCkBAIC02Nyw3ICs2Nyw3IEBAIGludCBidHJm
c19pbnNlcnRfZmlsZV9leHRlbnQoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsCiAJ
YnRyZnNfc2V0X2ZpbGVfZXh0ZW50X3JhbV9ieXRlcyhsZWFmLCBpdGVtLCByYW1fYnl0ZXMpOwog
CWJ0cmZzX3NldF9maWxlX2V4dGVudF9nZW5lcmF0aW9uKGxlYWYsIGl0ZW0sIHRyYW5zLT50cmFu
c2lkKTsKIAlidHJmc19zZXRfZmlsZV9leHRlbnRfdHlwZShsZWFmLCBpdGVtLCBCVFJGU19GSUxF
X0VYVEVOVF9SRUcpOwotCWJ0cmZzX3NldF9maWxlX2V4dGVudF9jb21wcmVzc2lvbihsZWFmLCBp
dGVtLCBjb21wcmVzc2lvbik7CisJYnRyZnNfc2V0X2ZpbGVfZXh0ZW50X2NvbXByZXNzaW9uKGxl
YWYsIGl0ZW0sIGNvbXByZXNzaW9uICYgMHhGKTsKIAlidHJmc19zZXRfZmlsZV9leHRlbnRfZW5j
cnlwdGlvbihsZWFmLCBpdGVtLCBlbmNyeXB0aW9uKTsKIAlidHJmc19zZXRfZmlsZV9leHRlbnRf
b3RoZXJfZW5jb2RpbmcobGVhZiwgaXRlbSwgb3RoZXJfZW5jb2RpbmcpOwogCmRpZmYgLS1naXQg
YS9mcy9idHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUuYwppbmRleCBkYmM5YmNhZjUuLjMy
ODVkNGJkMyAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvaW5vZGUuYworKysgYi9mcy9idHJmcy9pbm9k
ZS5jCkBAIC0yMjcsNyArMjI3LDcgQEAgc3RhdGljIGludCBpbnNlcnRfaW5saW5lX2V4dGVudChz
dHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywKIAkJCWNvbXByZXNzZWRfc2l6ZSAtPSBj
dXJfc2l6ZTsKIAkJfQogCQlidHJmc19zZXRfZmlsZV9leHRlbnRfY29tcHJlc3Npb24obGVhZiwg
ZWksCi0JCQkJCQkgIGNvbXByZXNzX3R5cGUpOworCQkJCQkJICBjb21wcmVzc190eXBlICYgMFhG
KTsKIAl9IGVsc2UgewogCQlwYWdlID0gZmluZF9nZXRfcGFnZShpbm9kZS0+aV9tYXBwaW5nLAog
CQkJCSAgICAgc3RhcnQgPj4gUEFHRV9TSElGVCk7CkBAIC01NzMsMTQgKzU3MywzMSBAQCBzdGF0
aWMgbm9pbmxpbmUgaW50IGNvbXByZXNzX2ZpbGVfcmFuZ2Uoc3RydWN0IGFzeW5jX2NodW5rICph
c3luY19jaHVuaykKIAkJfQogCiAJCS8qIENvbXByZXNzaW9uIGxldmVsIGlzIGFwcGxpZWQgaGVy
ZSBhbmQgb25seSBoZXJlICovCi0JCXJldCA9IGJ0cmZzX2NvbXByZXNzX3BhZ2VzKAotCQkJY29t
cHJlc3NfdHlwZSB8IChmc19pbmZvLT5jb21wcmVzc19sZXZlbCA8PCA0KSwKLQkJCQkJICAgaW5v
ZGUtPmlfbWFwcGluZywgc3RhcnQsCi0JCQkJCSAgIHBhZ2VzLAotCQkJCQkgICAmbnJfcGFnZXMs
Ci0JCQkJCSAgICZ0b3RhbF9pbiwKLQkJCQkJICAgJnRvdGFsX2NvbXByZXNzZWQpOwotCisJCS8q
CisJCSAqIENoZWNrIGlmIHRoZSB1cHBlciBiaXRzIGFyZSBzZXQsIGFuZCBpZiBzbywKKwkJICog
dGFrZSB0aGVtIGFzIHRoZSBjb21wcmVzc2lvbiBsZXZlbC4KKwkJICogdGhlIGlub2RlIGNvbXBy
ZXNzaW9uIGxldmVsIHRha2VzIHByZWNlbmRlbmNlLCBpZiBzZXQKKwkJICovCisJCWlmICgoY29t
cHJlc3NfdHlwZSAmIDB4RikgPT0gY29tcHJlc3NfdHlwZSkgeworCQkJcmV0ID0gYnRyZnNfY29t
cHJlc3NfcGFnZXMoCisJCQkJY29tcHJlc3NfdHlwZSB8IChmc19pbmZvLT5jb21wcmVzc19sZXZl
bCA8PCA0KSwKKwkJCQkJCWlub2RlLT5pX21hcHBpbmcsIHN0YXJ0LAorCQkJCQkJcGFnZXMsCisJ
CQkJCQkmbnJfcGFnZXMsCisJCQkJCQkmdG90YWxfaW4sCisJCQkJCQkmdG90YWxfY29tcHJlc3Nl
ZCk7CisJCX0gZWxzZSB7CisJCQlpbnQgY29tcHJlc3NfbGV2ZWwgPSBidHJmc19jb21wcmVzc19z
ZXRfbGV2ZWwoCisJCQkJCQljb21wcmVzc190eXBlICYgMHhGLAorCQkJCQkJY29tcHJlc3NfdHlw
ZT4+NCk7CisJCQlyZXQgPSBidHJmc19jb21wcmVzc19wYWdlcygKKwkJCQljb21wcmVzc190eXBl
IHwgKGNvbXByZXNzX2xldmVsIDw8IDQpLAorCQkJCWlub2RlLT5pX21hcHBpbmcsIHN0YXJ0LAor
CQkJCXBhZ2VzLAorCQkJCSZucl9wYWdlcywKKwkJCQkmdG90YWxfaW4sCisJCQkJJnRvdGFsX2Nv
bXByZXNzZWQpOworCQl9CiAJCWlmICghcmV0KSB7CiAJCQl1bnNpZ25lZCBsb25nIG9mZnNldCA9
IG9mZnNldF9pbl9wYWdlKHRvdGFsX2NvbXByZXNzZWQpOwogCQkJc3RydWN0IHBhZ2UgKnBhZ2Ug
PSBwYWdlc1tucl9wYWdlcyAtIDFdOwpAQCAtMjM2Miw3ICsyMzc5LDcgQEAgc3RhdGljIGludCBp
bnNlcnRfcmVzZXJ2ZWRfZmlsZV9leHRlbnQoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJh
bnMsCiAJYnRyZnNfc2V0X2ZpbGVfZXh0ZW50X29mZnNldChsZWFmLCBmaSwgMCk7CiAJYnRyZnNf
c2V0X2ZpbGVfZXh0ZW50X251bV9ieXRlcyhsZWFmLCBmaSwgbnVtX2J5dGVzKTsKIAlidHJmc19z
ZXRfZmlsZV9leHRlbnRfcmFtX2J5dGVzKGxlYWYsIGZpLCByYW1fYnl0ZXMpOwotCWJ0cmZzX3Nl
dF9maWxlX2V4dGVudF9jb21wcmVzc2lvbihsZWFmLCBmaSwgY29tcHJlc3Npb24pOworCWJ0cmZz
X3NldF9maWxlX2V4dGVudF9jb21wcmVzc2lvbihsZWFmLCBmaSwgY29tcHJlc3Npb24gJiAweEYp
OwogCWJ0cmZzX3NldF9maWxlX2V4dGVudF9lbmNyeXB0aW9uKGxlYWYsIGZpLCBlbmNyeXB0aW9u
KTsKIAlidHJmc19zZXRfZmlsZV9leHRlbnRfb3RoZXJfZW5jb2RpbmcobGVhZiwgZmksIG90aGVy
X2VuY29kaW5nKTsKIApkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvaW9jdGwuYyBiL2ZzL2J0cmZzL2lv
Y3RsLmMKaW5kZXggMGZhMWMzODZkLi4yYTljMWYzMTIgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2lv
Y3RsLmMKKysrIGIvZnMvYnRyZnMvaW9jdGwuYwpAQCAtMTQxNCw3ICsxNDE0LDExIEBAIGludCBi
dHJmc19kZWZyYWdfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSwK
IAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlpZiAoZG9fY29tcHJlc3MpIHsKLQkJaWYgKHJhbmdlLT5j
b21wcmVzc190eXBlID49IEJUUkZTX05SX0NPTVBSRVNTX1RZUEVTKQorCQkvKgorCQkqIFRoZSBi
b3R0b20gNCBiaXRzIG9mIGNvbXByZXNzX3R5cGUgYXJlIGZvciB1c2VkIGZvciB0aGUKKwkJKiBj
b21wcmVzc2lvbiB0eXBlLCB0aGUgb3RoZXIgYml0cyBmb3IgdGhlIGNvbXByZXNzaW9uIGxldmVs
CisJCSovCisJCWlmICgocmFuZ2UtPmNvbXByZXNzX3R5cGUgJiAweEYpID49IEJUUkZTX05SX0NP
TVBSRVNTX1RZUEVTKQogCQkJcmV0dXJuIC1FSU5WQUw7CiAJCWlmIChyYW5nZS0+Y29tcHJlc3Nf
dHlwZSkKIAkJCWNvbXByZXNzX3R5cGUgPSByYW5nZS0+Y29tcHJlc3NfdHlwZTsKQEAgLTE1NzIs
OSArMTU3Niw5IEBAIGludCBidHJmc19kZWZyYWdfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBz
dHJ1Y3QgZmlsZSAqZmlsZSwKIAkJCWZpbGVtYXBfZmx1c2goaW5vZGUtPmlfbWFwcGluZyk7CiAJ
fQogCi0JaWYgKHJhbmdlLT5jb21wcmVzc190eXBlID09IEJUUkZTX0NPTVBSRVNTX0xaTykgewor
CWlmICgocmFuZ2UtPmNvbXByZXNzX3R5cGUgJiAweEYpID09IEJUUkZTX0NPTVBSRVNTX0xaTykg
ewogCQlidHJmc19zZXRfZnNfaW5jb21wYXQoZnNfaW5mbywgQ09NUFJFU1NfTFpPKTsKLQl9IGVs
c2UgaWYgKHJhbmdlLT5jb21wcmVzc190eXBlID09IEJUUkZTX0NPTVBSRVNTX1pTVEQpIHsKKwl9
IGVsc2UgaWYgKChyYW5nZS0+Y29tcHJlc3NfdHlwZSAmIDB4RikgPT0gQlRSRlNfQ09NUFJFU1Nf
WlNURCkgewogCQlidHJmc19zZXRfZnNfaW5jb21wYXQoZnNfaW5mbywgQ09NUFJFU1NfWlNURCk7
CiAJfQogCg==
--00000000000028e51e05a3142712--
