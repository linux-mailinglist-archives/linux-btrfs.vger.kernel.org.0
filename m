Return-Path: <linux-btrfs+bounces-1013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD388167DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 09:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4BA1C224E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 08:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4F107A7;
	Mon, 18 Dec 2023 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B2koNKAa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E710786
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e2ce4fb22so1594405e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 00:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702887107; x=1703491907; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ScwQIo8z1KH7IAK5sFNxuOYwASUW1lC+HWoeLP45C8=;
        b=B2koNKAaPpbLU5H/7R4WIu33AhgMdIjyYkqZnNutcPNg+VqCVGWoEI4yqw3xgjg9M/
         Y//fsh3Xaud5KLU/3dX1QEBTjcVK2RW7OoU3ciH+3B3Q060LBWTp0RE66e7+4AqcsQg7
         RA9Tfk2NoMm0UnWv8GZI2BgMow6x9kplWcNtJtcFKl/pBrfrRYuXJKsfZ0dm2ejYiAI0
         3bTZxaWYoi4CMtwHqZroopIedOXqsbFOnfhCpu5DXzFJX3Ov8CMPPaRrsLZY8KMUWtb9
         rrTrW5UZxLQ4Jzqixtrin13AiqVQWjgsCcQbw/tHSAp5uGF5Ela4VUADrUDRJQtAi70g
         MXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887107; x=1703491907;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ScwQIo8z1KH7IAK5sFNxuOYwASUW1lC+HWoeLP45C8=;
        b=KLePsrtaaX+pM3o0i8R5q4FzOscnDKUeldMUkzun3x5xYEiKfUcjN2+RiJZvzX2WTj
         W+btVdq5dCtzIRXqkiy7IRtmnCxsUgMlnf5VFpg85DtdguHtAssbe3zSWzZzlYFKAs4U
         jYMvkEJoMDCfwgbV4/tr9APXcFJ/JLtIwsYSDX7TLoCuhqwQmoZMssZY/By9VF3oHZHa
         zvlwETRc99fBJolH9q0sha/r/tYsk8AZOqY+ptFLcbeh8kxDq7OyF3j6FtlBFInySWuf
         ueUN5rG0QHqDJaHdvViH7Z8dsOqnWCTaPyAfiI9bbrmAeTG+GPNIsxYsjuCx41JuYEK4
         NHHw==
X-Gm-Message-State: AOJu0YzdNX4PbsaGSaZNEH6Q4anzjLZPiS02qqTl2HN4yoL9H9r7ESw/
	zzMlW7H5Wh2wVMBXON77GYR+UmlEto1sUWIG93Y=
X-Google-Smtp-Source: AGHT+IEhQWKPq1T+4vUa+hKB7gP0QNzBNHwiVYj3DpWNacwi6leER7nzr1yXdYzk/ep6iSLa5e9cPw==
X-Received: by 2002:a2e:730f:0:b0:2cc:5a76:212f with SMTP id o15-20020a2e730f000000b002cc5a76212fmr1621977ljc.99.1702887107223;
        Mon, 18 Dec 2023 00:11:47 -0800 (PST)
Received: from ?IPV6:2001:4479:a605:cd00::d2f? ([2001:4479:a605:cd00::d2f])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b006cde2090154sm17592482pff.218.2023.12.18.00.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 00:11:46 -0800 (PST)
Message-ID: <7c0704de-12ca-4869-b793-88a67a146bd4@suse.com>
Date: Mon, 18 Dec 2023 18:41:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: sysfs: use kstrtoull_suffix() to replace
 memparse()
To: David Disseldorp <ddiss@suse.de>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1702628925.git.wqu@suse.com>
 <2693b00ca850b0f604e03c836e71d0ad8a93ffee.1702628925.git.wqu@suse.com>
 <20231218184917.064e105e@echidna>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20231218184917.064e105e@echidna>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Rcj8nXYVYoI6JO3WEcQ9n0KH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Rcj8nXYVYoI6JO3WEcQ9n0KH
Content-Type: multipart/mixed; boundary="------------lJHmY19aISCZDgxA791l4WTh";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <7c0704de-12ca-4869-b793-88a67a146bd4@suse.com>
Subject: Re: [PATCH 2/2] btrfs: sysfs: use kstrtoull_suffix() to replace
 memparse()
References: <cover.1702628925.git.wqu@suse.com>
 <2693b00ca850b0f604e03c836e71d0ad8a93ffee.1702628925.git.wqu@suse.com>
 <20231218184917.064e105e@echidna>
In-Reply-To: <20231218184917.064e105e@echidna>

--------------lJHmY19aISCZDgxA791l4WTh
Content-Type: multipart/mixed; boundary="------------0n5DvLd4jwKHHacK5tXLrKw8"

--------------0n5DvLd4jwKHHacK5tXLrKw8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjMvMTIvMTggMTg6MTksIERhdmlkIERpc3NlbGRvcnAgd3JvdGU6DQo+IEhp
IFF1LA0KPiANCj4gT24gRnJpLCAxNSBEZWMgMjAyMyAxOTowOToyNCArMTAzMCwgUXUgV2Vu
cnVvIHdyb3RlOg0KPiANCj4+IFNpbmNlIG1lbXBhcnNlKCkgaXRzZWxmIGNhbiBub3QgaGFu
ZGxlIG92ZXJmbG93IGF0IGFsbCwgdXNlDQo+PiBtZW1wYXJzZV91bGwoKSB0byBiZSBleHRy
YSBzYWZlLg0KPiANCj4gcy9tZW1wYXJzZV91bGwva3N0cnRvdWxsX3N1ZmZpeC8NCj4gDQo+
PiBOb3cgb3ZlcmZsb3cgdmFsdWVzIGNhbiBiZSBwcm9wZXJseSBkZXRlY3RlZC4NCj4gDQo+
IFBsZWFzZSBkb2N1bWVudCBob3cgdGhlIHN5c2ZzIEFQSSBjaGFuZ2VzIHdpdGggdGhpcywg
aW4gYWRkaXRpb24gdG8NCj4gb3ZlcmZsb3cgaGFuZGxpbmc6DQo+IC0gc3VwcG9ydCBmb3Ig
J0UnIC8gJ2UnIHN1ZmZpeGVzIGRyb3BwZWQNCj4gLSBvbmx5IG9uZSB0cmFpbGluZyAnXG4n
IGFjY2VwdGVkLCBpbnN0ZWFkIG9mIG1hbnkgaXNzcGFjZSgpDQoNCldlbGwsIG11bHRpcGxl
IHNwYWNlcyBhcmUgYWxyZWFkeSBhbiBhYnVzZSwgYW5kIEkgZG9uJ3QgYmVsaWV2ZSBzYW5l
IA0Kc2NyaXB0cyBzaG91bGQgZ28gbXVsdGlwbGUgc3BhY2VzL25ld2xpbmVzLg0KDQpBcyBh
bGwgdGhlIG90aGVyIGNhbGwgc2l0ZXMgYXJlIGdvaW5nIGtzdHJ0b3gsIHdoaWNoIG9ubHkg
YWNjZXB0IG9uZSANCm5ld2xpbmUuDQoNCkFsdGhvdWdoIHRoZSBjaGFuZ2UgaXMgaW5kZWVk
IHdvcnRoeSBhIGRvY3VtZW50IHVwZGF0ZS4NCg0KVGhhbmtzLA0KUXUNCj4gDQo+IFRoZSBs
YXR0ZXIgbWlnaHQgYnJlYWsgYSBmZXcgc2NyaXB0cy4NCj4gDQo+IENoZWVycywgRGF2aWQN
Cj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+
PiAtLS0NCj4+ICAgZnMvYnRyZnMvc3lzZnMuYyB8IDIwICsrKysrKysrLS0tLS0tLS0tLS0t
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9zeXNmcy5jIGIvZnMvYnRyZnMvc3lz
ZnMuYw0KPj4gaW5kZXggODRjMDUyNDZmZmQ4Li4wODljM2ZjMTIzZmUgMTAwNjQ0DQo+PiAt
LS0gYS9mcy9idHJmcy9zeXNmcy5jDQo+PiArKysgYi9mcy9idHJmcy9zeXNmcy5jDQo+PiBA
QCAtNzYwLDcgKzc2MCw3IEBAIHN0YXRpYyBzc2l6ZV90IGJ0cmZzX2NodW5rX3NpemVfc3Rv
cmUoc3RydWN0IGtvYmplY3QgKmtvYmosDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBidHJmc19z
cGFjZV9pbmZvICpzcGFjZV9pbmZvID0gdG9fc3BhY2VfaW5mbyhrb2JqKTsNCj4+ICAgCXN0
cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gdG9fZnNfaW5mbyhnZXRfYnRyZnNfa29i
aihrb2JqKSk7DQo+PiAtCWNoYXIgKnJldHB0cjsNCj4+ICsJaW50IHJldDsNCj4+ICAgCXU2
NCB2YWw7DQo+PiAgIA0KPj4gICAJaWYgKCFjYXBhYmxlKENBUF9TWVNfQURNSU4pKQ0KPj4g
QEAgLTc3NiwxMSArNzc2LDkgQEAgc3RhdGljIHNzaXplX3QgYnRyZnNfY2h1bmtfc2l6ZV9z
dG9yZShzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4+ICAgCWlmIChzcGFjZV9pbmZvLT5mbGFn
cyAmIEJUUkZTX0JMT0NLX0dST1VQX1NZU1RFTSkNCj4+ICAgCQlyZXR1cm4gLUVQRVJNOw0K
Pj4gICANCj4+IC0JdmFsID0gbWVtcGFyc2UoYnVmLCAmcmV0cHRyKTsNCj4+IC0JLyogVGhl
cmUgY291bGQgYmUgdHJhaWxpbmcgJ1xuJywgYWxzbyBjYXRjaCBhbnkgdHlwb3MgYWZ0ZXIg
dGhlIHZhbHVlICovDQo+PiAtCXJldHB0ciA9IHNraXBfc3BhY2VzKHJldHB0cik7DQo+PiAt
CWlmICgqcmV0cHRyICE9IDAgfHwgdmFsID09IDApDQo+PiAtCQlyZXR1cm4gLUVJTlZBTDsN
Cj4+ICsJcmV0ID0ga3N0cnRvdWxsX3N1ZmZpeChidWYsIDAsICZ2YWwsIEtTVFJUT1VMTF9T
VUZGSVhfREVGQVVMVCk7DQo+PiArCWlmIChyZXQgPCAwKQ0KPj4gKwkJcmV0dXJuIHJldDsN
Cj4+ICAgDQo+PiAgIAl2YWwgPSBtaW4odmFsLCBCVFJGU19NQVhfREFUQV9DSFVOS19TSVpF
KTsNCj4+ICAgDQo+PiBAQCAtMTc3OSwxNCArMTc3NywxMiBAQCBzdGF0aWMgc3NpemVfdCBi
dHJmc19kZXZpbmZvX3NjcnViX3NwZWVkX21heF9zdG9yZShzdHJ1Y3Qga29iamVjdCAqa29i
aiwNCj4+ICAgew0KPj4gICAJc3RydWN0IGJ0cmZzX2RldmljZSAqZGV2aWNlID0gY29udGFp
bmVyX29mKGtvYmosIHN0cnVjdCBidHJmc19kZXZpY2UsDQo+PiAgIAkJCQkJCSAgIGRldmlk
X2tvYmopOw0KPj4gLQljaGFyICplbmRwdHI7DQo+PiAgIAl1bnNpZ25lZCBsb25nIGxvbmcg
bGltaXQ7DQo+PiArCWludCByZXQ7DQo+PiAgIA0KPj4gLQlsaW1pdCA9IG1lbXBhcnNlKGJ1
ZiwgJmVuZHB0cik7DQo+PiAtCS8qIFRoZXJlIGNvdWxkIGJlIHRyYWlsaW5nICdcbicsIGFs
c28gY2F0Y2ggYW55IHR5cG9zIGFmdGVyIHRoZSB2YWx1ZS4gKi8NCj4+IC0JZW5kcHRyID0g
c2tpcF9zcGFjZXMoZW5kcHRyKTsNCj4+IC0JaWYgKCplbmRwdHIgIT0gMCkNCj4+IC0JCXJl
dHVybiAtRUlOVkFMOw0KPj4gKwlyZXQgPSBrc3RydG91bGxfc3VmZml4KGJ1ZiwgMCwgJmxp
bWl0LCBLU1RSVE9VTExfU1VGRklYX0RFRkFVTFQpOw0KPj4gKwlpZiAocmV0IDwgMCkNCj4+
ICsJCXJldHVybiByZXQ7DQo+PiAgIAlXUklURV9PTkNFKGRldmljZS0+c2NydWJfc3BlZWRf
bWF4LCBsaW1pdCk7DQo+PiAgIAlyZXR1cm4gbGVuOw0KPj4gICB9DQo+IA0KPiANCj4gDQo+
IA0K
--------------0n5DvLd4jwKHHacK5tXLrKw8
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------0n5DvLd4jwKHHacK5tXLrKw8--

--------------lJHmY19aISCZDgxA791l4WTh--

--------------Rcj8nXYVYoI6JO3WEcQ9n0KH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmV//r4FAwAAAAAACgkQwj2R86El/qj1
DAf/aaee6HjuttQRRXzTNzvWWnwYh9QSBnlP1W4QZQ14Uoel0RepjM8X9jWo5+H5vC914ECJSpis
dhl6I8EBiE66jULAuNuzGK6T+9QaBGTOsmOqbBUhE3D+NdWoirL7UyZ7CY05a97Z78r3Crx9q/vQ
R5PNuCWrw/EWVJh9W9Gp/1TnHrQRMNJbYK3pJK4c270nrjVfQekoY44tdZqxVKbfoUY3uQYywzA+
fej6m3JifSFiVmdkxMWfiqVV8Hk4QVPFAKojCaZfn575JAq5kCjTxXY4kBuYfiL9WmhVviZXQf+z
5/xtiLUAZTepaiwVkMEM3XtAqCBf3PACwig2MjGoZg==
=OD8J
-----END PGP SIGNATURE-----

--------------Rcj8nXYVYoI6JO3WEcQ9n0KH--

