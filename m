Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238C449303D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 22:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbiARV4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 16:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbiARV4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 16:56:14 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD6BC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 13:56:13 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JdjJp2VMgzQlb9;
        Tue, 18 Jan 2022 22:56:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1642542968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0M2hr4mvLXV85jBMIiZw5kg9t5qSgoIcLLnbPAp2YFE=;
        b=OMcBIe/ssoXpb5pL1oEVxlmNQdvQP9tozI8yEifMkdp9FrESJ2pwPVuzPOmLtcFaT7m5If
        xOwrxOfDv0u0O1dxTSHbGDTr2lo9zxM5h3HT6l4+CEW/3zcQj37TJof0BFAIsitd9K+5Cy
        gYkK3Dk7xYlEmvkUWPoeHXs0Y3sYIq+P6prghPX0Gg1Hw2rM/Yhc6BMUDoZn+6FgM3e4/M
        nFTkDqzOH99g5kEsUZHNFS/vI2ld3FV5oO48OJqswFivDyOZywWm2DhWabL69BcRWCMAzC
        R2L0PwLzHe/vFnj9aaOwPgT2f9RHMMnocj2ri9HfLB2Wmf6/B1OuIqZN3uAvJQ==
Message-ID: <aa3a30dc-7979-756b-642e-4d6d706904a9@mailbox.org>
Date:   Tue, 18 Jan 2022 22:56:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] btrfs: defrag: fix the wrong number of defragged
 sectors
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220118071904.29991-1-wqu@suse.com>
 <YebPqrBwFcqD3oUe@debian9.Home>
From:   Anthony Ruhier <aruhier@mailbox.org>
In-Reply-To: <YebPqrBwFcqD3oUe@debian9.Home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gry7PR9EDro0Fu0CowRezd61"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gry7PR9EDro0Fu0CowRezd61
Content-Type: multipart/mixed; boundary="------------5QV0MvKvS6zKIhN9000ix00V";
 protected-headers="v1"
From: Anthony Ruhier <aruhier@mailbox.org>
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <aa3a30dc-7979-756b-642e-4d6d706904a9@mailbox.org>
Subject: Re: [PATCH v2] btrfs: defrag: fix the wrong number of defragged
 sectors
References: <20220118071904.29991-1-wqu@suse.com>
 <YebPqrBwFcqD3oUe@debian9.Home>
In-Reply-To: <YebPqrBwFcqD3oUe@debian9.Home>

--------------5QV0MvKvS6zKIhN9000ix00V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SnVzdCB0byBnaXZlIHlvdSBhbiB1cGRhdGUsIEkgdGVzdGVkIHRoZSAzIHBhdGNoZXMsIGFu
ZCB0aGlzIHRpbWUgaXQgDQpzZWVtcyB0byBjb21wbGV0ZWx5IGZpeCB0aGUgaXNzdWUuDQoN
ClRoYW5rcyBhIGxvdCwgRmlsaXBlIGFuZCBRdSENCkFudGhvbnkNCg0KTGUgMTgvMDEvMjAy
MiDDoCAxNTozMywgRmlsaXBlIE1hbmFuYSBhIMOpY3JpdMKgOg0KPiBPbiBUdWUsIEphbiAx
OCwgMjAyMiBhdCAwMzoxOTowNFBNICswODAwLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBbQlVH
XQ0KPj4gVGhlcmUgYXJlIHVzZXJzIHVzaW5nIGF1dG9kZWZyYWcgbW91bnQgb3B0aW9uIHJl
cG9ydGluZyBvYnZpb3VzIGluY3JlYXNlDQo+PiBpbiBJTzoNCj4+DQo+Pj4gSWYgSSBjb21w
YXJlIHRoZSB3cml0ZSBhdmVyYWdlIChpbiB0b3RhbCwgSSBkb24ndCBoYXZlIGl0IHBlciBw
cm9jZXNzKQ0KPj4+IHdoZW4gdGFraW5nIGlkbGUgcGVyaW9kcyBvbiB0aGUgc2FtZSBtYWNo
aW5lOg0KPj4+ICAgICAgTGludXggNS4xNjoNCj4+PiAgICAgICAgICB3aXRob3V0IGF1dG9k
ZWZyYWc6IH4gMTBLaUIvcw0KPj4+ICAgICAgICAgIHdpdGggYXV0b2RlZnJhZzogYmV0d2Vl
biAxIGFuZCAyTWlCL3MuDQo+Pj4NCj4+PiAgICAgIExpbnV4IDUuMTU6DQo+Pj4gICAgICAg
ICAgd2l0aCBhdXRvZGVmcmFnOn4gMTBLaUIvcyAoYXJvdW5kIHRoZSBzYW1lIGFzIHdpdGhv
dXQNCj4+PiBhdXRvZGVmcmFnIG9uIDUuMTYpDQo+PiBbQ0FVU0VdDQo+PiBXaGVuIGF1dG9k
ZWZyYWcgbW91bnQgb3B0aW9uIGlzIGVuYWJsZWQsIGJ0cmZzX2RlZnJhZ19maWxlKCkgd2ls
bCBiZQ0KPj4gY2FsbGVkIHdpdGggQG1heF9zZWN0b3JzID0gQlRSRlNfREVGUkFHX0JBVENI
ICgxMDI0KSB0byBsaW1pdCBob3cgbWFueQ0KPj4gc2VjdG9ycyB3ZSBjYW4gZGVmcmFnIGlu
IG9uZSB0cnkuDQo+Pg0KPj4gQW5kIHRoZW4gdXNlIHRoZSBudW1iZXIgb2Ygc2VjdG9ycyBk
ZWZyYWdnZWQgdG8gZGV0ZXJtaW5lIGlmIHdlIG5lZWQgdG8NCj4+IHJlLWRlZnJhZy4NCj4+
DQo+PiBCdXQgY29tbWl0IGIxOGMzYWIyMzQzZCAoImJ0cmZzOiBkZWZyYWc6IGludHJvZHVj
ZSBoZWxwZXIgdG8gZGVmcmFnIG9uZQ0KPj4gY2x1c3RlciIpIHVzZXMgd3JvbmcgdW5pdCB0
byBpbmNyZWFzZSBAc2VjdG9yc19kZWZyYWdnZWQsIHdoaWNoIHNob3VsZA0KPj4gYmUgaW4g
dW5pdCBvZiBzZWN0b3IsIG5vdCBieXRlLg0KPj4NCj4+IFRoaXMgbWVhbnMsIGlmIHdlIGhh
dmUgZGVmcmFnZ2VkIGFueSBzZWN0b3IsIHRoZW4gQHNlY3RvcnNfZGVmcmFnZ2VkDQo+PiB3
aWxsIGJlID49IHNlY3RvcnNpemUgKG5vcm1hbGx5IDQwOTYpLCB3aGljaCBpcyBsYXJnZXIg
dGhhbg0KPj4gQlRSRlNfREVGUkFHX0JBVENILg0KPj4NCj4+IFRoaXMgbWFrZXMgdGhlIEBt
YXhfc2VjdG9ycyBjaGVjayBpbiBkZWZyYWdfb25lX2NsdXN0ZXIoKSB0byB1bmRlcmZsb3cs
DQo+PiByZW5kZXJpbmcgdGhlIHdob2xlIEBtYXhfc2VjdG9ycyBjaGVjayB1c2VsZXNzLg0K
Pj4NCj4+IFRodXMgY2F1c2luZyB3YXkgbW9yZSBJTyBmb3IgYXV0b2RlZnJhZyBtb3VudCBv
cHRpb25zLCBhcyBub3cgdGhlcmUgaXMNCj4+IG5vIGxpbWl0IG9uIGhvdyBtYW55IHNlY3Rv
cnMgY2FuIHJlYWxseSBiZSBkZWZyYWdnZWQuDQo+Pg0KPj4gW0ZJWF0NCj4+IEZpeCB0aGUg
cHJvYmxlbXMgYnk6DQo+Pg0KPj4gLSBVc2Ugc2VjdG9yIGFzIHVuaXQgd2hlbiBpbmNyZWFz
ZWluZyBAc2VjdG9yc19kZWZyYWdnZWQNCj4+DQo+PiAtIEluY2x1ZGUgQHNlY3RvcnNfZGVm
cmFnZ2VkID4gQG1heF9zZWN0b3JzIGNhc2UgdG8gYnJlYWsgdGhlIGxvb3ANCj4+DQo+PiAt
IEFkZCBleHRyYSBjb21tZW50IG9uIHRoZSByZXR1cm4gdmFsdWUgb2YgYnRyZnNfZGVmcmFn
X2ZpbGUoKQ0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBBbnRob255IFJ1aGllciA8YXJ1aGllckBt
YWlsYm94Lm9yZz4NCj4+IEZpeGVzOiBiMThjM2FiMjM0M2QgKCJidHJmczogZGVmcmFnOiBp
bnRyb2R1Y2UgaGVscGVyIHRvIGRlZnJhZyBvbmUgY2x1c3RlciIpDQo+PiBTaWduZWQtb2Zm
LWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4gTG9va3MgZ29vZCwgdGhhbmtzLg0K
Pg0KPiBSZXZpZXdlZC1ieTogRmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+
DQo+IFBsZWFzZSwgaW4gdGhlIGZ1dHVyZSBhbHNvIGFkZCBhIGxpbmsgdG8gdGhlIHRocmVh
ZCByZXBvcnRpbmcgdGhlIGlzc3VlLg0KPiBUaGlzIG1ha2VzIGl0IG11Y2ggZWFzaWVyIHRv
IGZpbmQgbW9yZSBkZXRhaWxzLCBpbnN0ZWFkIG9mIGdyZXBwaW5nIGluDQo+IGEgbWFpbGJv
eCBvciBsb3JlIGZvciB0aGUgcmVwb3J0ZXIncyBuYW1lLi4uDQo+DQo+IExpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzBhMjY5NjEyLWU0M2YtZGEyMi1jNWJj
LWIzNGIxYjU2ZWJlOEBtYWlsYm94Lm9yZy8NCj4NCj4+IC0tLQ0KPj4gQ2hhbmdlbG9nOg0K
Pj4gdjI6DQo+PiAtIFVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gaW5jbHVkZSB0aGUg
cm9vdCBjYXVzZSBvZiBleHRyYSBJTw0KPj4NCj4+IC0gS2VlcCBAc2VjdG9yc19kZWZyYWdn
ZWQgdXBkYXRlIHdoZXJlIGl0IGlzDQo+PiAgICBTaW5jZSB0aGUgb3Zlci1yZXBvcnRlZCBA
c2VjdG9yc19kZWZyYWdnZWQgaXMgbm90IHRoZSByZWFsIHJlYXNvbiwNCj4+ICAgIGtlZXAg
dGhlIHBhdGNoIHNtYWxsZXIuDQo+PiAtLS0NCj4+ICAgZnMvYnRyZnMvaW9jdGwuYyB8IDEw
ICsrKysrKystLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvaW9jdGwuYyBiL2Zz
L2J0cmZzL2lvY3RsLmMNCj4+IGluZGV4IDZhZDJiYzJlNWFmMy4uMmE3NzI3M2Q5MWZlIDEw
MDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvaW9jdGwuYw0KPj4gKysrIGIvZnMvYnRyZnMvaW9j
dGwuYw0KPj4gQEAgLTE0NDIsOCArMTQ0Miw4IEBAIHN0YXRpYyBpbnQgZGVmcmFnX29uZV9j
bHVzdGVyKHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsDQo+PiAgIAlsaXN0X2Zvcl9lYWNo
X2VudHJ5KGVudHJ5LCAmdGFyZ2V0X2xpc3QsIGxpc3QpIHsNCj4+ICAgCQl1MzIgcmFuZ2Vf
bGVuID0gZW50cnktPmxlbjsNCj4+ICAgDQo+PiAtCQkvKiBSZWFjaGVkIHRoZSBsaW1pdCAq
Lw0KPj4gLQkJaWYgKG1heF9zZWN0b3JzICYmIG1heF9zZWN0b3JzID09ICpzZWN0b3JzX2Rl
ZnJhZ2dlZCkNCj4+ICsJCS8qIFJlYWNoZWQgb3IgYmV5b25kIHRoZSBsaW1pdCAqLw0KPj4g
KwkJaWYgKG1heF9zZWN0b3JzICYmICpzZWN0b3JzX2RlZnJhZ2dlZCA+PSBtYXhfc2VjdG9y
cykNCj4+ICAgCQkJYnJlYWs7DQo+PiAgIA0KPj4gICAJCWlmIChtYXhfc2VjdG9ycykNCj4+
IEBAIC0xNDY1LDcgKzE0NjUsOCBAQCBzdGF0aWMgaW50IGRlZnJhZ19vbmVfY2x1c3Rlcihz
dHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLA0KPj4gICAJCQkJICAgICAgIGV4dGVudF90aHJl
c2gsIG5ld2VyX3RoYW4sIGRvX2NvbXByZXNzKTsNCj4+ICAgCQlpZiAocmV0IDwgMCkNCj4+
ICAgCQkJYnJlYWs7DQo+PiAtCQkqc2VjdG9yc19kZWZyYWdnZWQgKz0gcmFuZ2VfbGVuOw0K
Pj4gKwkJKnNlY3RvcnNfZGVmcmFnZ2VkICs9IHJhbmdlX2xlbiA+Pg0KPj4gKwkJCQkgICAg
ICBpbm9kZS0+cm9vdC0+ZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzOw0KPj4gICAJfQ0KPj4g
ICBvdXQ6DQo+PiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZW50cnksIHRtcCwgJnRh
cmdldF9saXN0LCBsaXN0KSB7DQo+PiBAQCAtMTQ4NCw2ICsxNDg1LDkgQEAgc3RhdGljIGlu
dCBkZWZyYWdfb25lX2NsdXN0ZXIoc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwNCj4+ICAg
ICogQG5ld2VyX3RoYW46CSAgIG1pbmltdW0gdHJhbnNpZCB0byBkZWZyYWcNCj4+ICAgICog
QG1heF90b19kZWZyYWc6IG1heCBudW1iZXIgb2Ygc2VjdG9ycyB0byBiZSBkZWZyYWdnZWQs
IGlmIDAsIHRoZSB3aG9sZSBpbm9kZQ0KPj4gICAgKgkJICAgd2lsbCBiZSBkZWZyYWdnZWQu
DQo+PiArICoNCj4+ICsgKiBSZXR1cm4gPDAgZm9yIGVycm9yLg0KPj4gKyAqIFJldHVybiA+
PTAgZm9yIHRoZSBudW1iZXIgb2Ygc2VjdG9ycyBkZWZyYWdnZWQuDQo+PiAgICAqLw0KPj4g
ICBpbnQgYnRyZnNfZGVmcmFnX2ZpbGUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZp
bGVfcmFfc3RhdGUgKnJhLA0KPj4gICAJCSAgICAgIHN0cnVjdCBidHJmc19pb2N0bF9kZWZy
YWdfcmFuZ2VfYXJncyAqcmFuZ2UsDQo+PiAtLSANCj4+IDIuMzQuMQ0KPj4NCg==

--------------5QV0MvKvS6zKIhN9000ix00V--

--------------gry7PR9EDro0Fu0CowRezd61
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTNQhfAcx4Jlo6lbanXMzk8hoTszwUCYec3cQAKCRDXMzk8hoTs
z+tLAQD6xqErw8gG397Z5I7+GZLuoNLB/71+UGXZR4FPtFu3YQD/dppxGjUXv8rA
/idNntAOtAkWOf47sH/sQ1fw+IMK9wY=
=j8Z1
-----END PGP SIGNATURE-----

--------------gry7PR9EDro0Fu0CowRezd61--
