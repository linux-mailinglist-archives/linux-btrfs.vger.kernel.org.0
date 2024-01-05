Return-Path: <linux-btrfs+bounces-1275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24843825B66
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 21:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03DB285F0E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53763608A;
	Fri,  5 Jan 2024 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WvohAYuY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF635F16
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so28707251fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jan 2024 12:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704485522; x=1705090322; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P0dMAvjXD9rxETxF9Lc8K5lmR1bx0hydbFxbY/Vg5jI=;
        b=WvohAYuYEprsTAa/GyZ6f4pnhXNgBP01sNGIeD4hgp+80Izk/WFvwcuHgqRk/3aTjO
         cMBnRC1AP8Xqv7tVaaErH+pstLWcw3TEsHihiCn6cMBELY9mOd1mD+K/rieRrI/6sQW3
         1PNBWMrswerrUSrrEbMH+Czx8g31VE1s6V4owssTH90E07O1QGCdVoPXRkKHO283vIiO
         BQN21rAhCiSZhTPKDtKBV/ONf8XWQEjWunNLGIf3L7dsLLIsW9JUILd9KMQXl5iMeDtH
         uZsfVc8KEenNnuVyQnIqTuEOa9ymowpwm8BxqskCBDmEtwp42vVfKXLVJk+TeU9/gwnI
         yi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704485522; x=1705090322;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0dMAvjXD9rxETxF9Lc8K5lmR1bx0hydbFxbY/Vg5jI=;
        b=vMseL+zoxGeQMA5VI2ujtXufstyN/iFmD4ZJZdhR+bhTn2WPDM/3sxfwcleaQbh9Vu
         6iCSQicZd7gqJYf/7U73LQbM7f7Vb9kZq80JB5kqzue7zV7gEnOnSz1I9T+2FZmP4YrW
         oOcxNghpaH4pRghlKjFNkcUjlIaQkDsK1q4esY9Z1jLxVYygr5YY/98HYsSHT5ksBG6t
         09FCANkewNmm326F+zEx1QdHdXgdl3ueL9dawoZlvPf10p/7q2qr/RLGEdz5z0Mlwc+x
         nETGuaVhuXCoipT/pzhiBoIMIWnwesXl+oO3HUiOkhs5ThvAo9aZ595J0yQ4we5Zxwmv
         FekQ==
X-Gm-Message-State: AOJu0YyR6aTIEFPNNlaawHRYv5RxAby+w7YML37cEIrmytadqnBRSbK2
	c3S8jsMBkf1S5d25P95keZGC50zvbsq/B4Rca28SI9tWPZI=
X-Google-Smtp-Source: AGHT+IFUbQRrdscZfSRvq2i/kiwp15mGWzE8LU946jH77YRyXmQYGLsoZhwbYo1kKwrhudIA3/ICkQ==
X-Received: by 2002:a2e:a99e:0:b0:2cd:3300:bde8 with SMTP id x30-20020a2ea99e000000b002cd3300bde8mr777521ljq.98.1704485522110;
        Fri, 05 Jan 2024 12:12:02 -0800 (PST)
Received: from ?IPV6:2001:4479:aa02:8c00::959? ([2001:4479:aa02:8c00::959])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090a49cc00b0028be0ec6e76sm1641446pjm.28.2024.01.05.12.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:12:01 -0800 (PST)
Message-ID: <a83cb94c-df03-446c-ab20-93f252d95724@suse.com>
Date: Sat, 6 Jan 2024 06:41:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
Content-Language: en-US
To: Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Cc: Christoph Anton Mitterer <calestyo@scientia.org>
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <dd314b94-6c45-4c3d-9c6e-4def5b67aafe@gmail.com>
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
In-Reply-To: <dd314b94-6c45-4c3d-9c6e-4def5b67aafe@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xqJTdrgw7u56C2z91tQGuPNk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xqJTdrgw7u56C2z91tQGuPNk
Content-Type: multipart/mixed; boundary="------------gHW0szKDrm895q3vLJ0YGx6Z";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Cc: Christoph Anton Mitterer <calestyo@scientia.org>
Message-ID: <a83cb94c-df03-446c-ab20-93f252d95724@suse.com>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <dd314b94-6c45-4c3d-9c6e-4def5b67aafe@gmail.com>
In-Reply-To: <dd314b94-6c45-4c3d-9c6e-4def5b67aafe@gmail.com>

--------------gHW0szKDrm895q3vLJ0YGx6Z
Content-Type: multipart/mixed; boundary="------------Gj7EaIahcwp9t83wSvP4CTAf"

--------------Gj7EaIahcwp9t83wSvP4CTAf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS82IDAzOjE1LCBBbmRyZWkgQm9yemVua292IHdyb3RlOg0KPiBPbiAw
NS4wMS4yMDI0IDEwOjMzLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBbQlVHXQ0KPj4gVGhlIGZv
bGxvd2luZyBzY3JpcHQgY2FuIGxlYWQgdG8gYSB2ZXJ5IHVuZGVyIHV0aWxpemVkIGV4dGVu
dCBhbmQgd2UNCj4+IGhhdmUgbm8gd2F5IHRvIHVzZSBkZWZyYWcgdG8gcHJvcGVybHkgcmVj
bGFpbSBpdHMgd2FzdGVkIHNwYWNlOg0KPj4NCj4+IMKgwqAgIyBta2ZzLmJ0cmZzIC1mICRk
ZXYNCj4+IMKgwqAgIyBtb3VudCAkZGV2ICRtbnQNCj4+IMKgwqAgIyB4ZnNfaW8gLWYgLWMg
InB3cml0ZSAwIDEyOE0iICRtbnQvZm9vYmFyDQo+PiDCoMKgICMgc3luYw0KPj4gwqDCoCAj
IGJ0cmZzIGZpbGVzeXN0ZW0gZGVmcmFnICRtbnQvZm9vYmFyDQo+PiDCoMKgICMgc3luYw0K
Pj4NCj4+IEFmdGVyIHRoZSBhYm92ZSBvcGVyYXRpb25zLCB0aGUgZmlsZSAiZm9vYmFyIiBp
cyBzdGlsbCB1dGlsaXppbmcgdGhlDQo+PiB3aG9sZSAxMjhNOg0KPj4NCj4+IMKgwqDCoMKg
wqDCoMKgwqAgaXRlbSA0IGtleSAoMjU3IElOT0RFX0lURU0gMCkgaXRlbW9mZiAxNTg4MyBp
dGVtc2l6ZSAxNjANCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdlbmVy
YXRpb24gNyB0cmFuc2lkIDggc2l6ZSA0MDk2IG5ieXRlcyA0MDk2DQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibG9jayBncm91cCAwIG1vZGUgMTAwNjAwIGxpbmtz
IDEgdWlkIDAgZ2lkIDAgcmRldiAwDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzZXF1ZW5jZSAzMjc3MCBmbGFncyAweDAobm9uZSkNCj4+IMKgwqDCoMKgwqDCoMKg
wqAgaXRlbSA1IGtleSAoMjU3IElOT0RFX1JFRiAyNTYpIGl0ZW1vZmYgMTU4NjkgaXRlbXNp
emUgMTQNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZGV4IDIgbmFt
ZWxlbiA0IG5hbWU6IGZpbGUNCj4+IMKgwqDCoMKgwqDCoMKgwqAgaXRlbSA2IGtleSAoMjU3
IEVYVEVOVF9EQVRBIDApIGl0ZW1vZmYgMTU4MTYgaXRlbXNpemUgNTMNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdlbmVyYXRpb24gNyB0eXBlIDEgKHJlZ3VsYXIp
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleHRlbnQgZGF0YSBkaXNr
IGJ5dGUgMjk4ODQ0MTYwIG5yIDEzNDIxNzcyOCA8PDwNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGV4dGVudCBkYXRhIG9mZnNldCAwIG5yIDQwOTYgcmFtIDEzNDIx
NzcyOA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXh0ZW50IGNvbXBy
ZXNzaW9uIDAgKG5vbmUpDQo+Pg0KPj4gTWVhbmluZyB0aGUgZXhwZWN0ZWQgZGVmcmFnIHdh
eSB0byByZWNsYWltIHRoZSBzcGFjZSBpcyBub3Qgd29ya2luZy4NCj4+DQo+PiBbQ0FVU0Vd
DQo+PiBUaGUgZmlsZSBleHRlbnQgaGFzIG5vIGFkamFjZW50IGV4dGVudCBhdCBhbGwsIHRo
dXMgYWxsIGV4aXN0aW5nIGRlZnJhZw0KPj4gY29kZSBjb25zaWRlciBpdCBhIHBlcmZlY3Rs
eSBnb29kIGZpbGUgZXh0ZW50LCBldmVuIGlmIGl0J3Mgb25seQ0KPj4gdXRpbGl6aW5nIGEg
dmVyeSB0aW55IGFtb3VudCBvZiBzcGFjZS4NCj4+DQo+PiBbRklYXQ0KPj4gQWRkIGEgc3Bl
Y2lhbCBoYW5kbGluZyBmb3IgdW5kZXIgdXRpbGl6ZWQgZXh0ZW50cywgY3VycmVudGx5IHRo
ZSByYXRpbw0KPj4gaXMgNi4yNSUgKDEvMTYpLg0KPj4NCj4+IFRoaXMgd291bGQgYWxsb3cg
dXMgdG8gYWRkIHN1Y2ggZXh0ZW50IHRvIG91ciBkZWZyYWcgdGFyZ2V0IGxpc3QsDQo+PiBy
ZXN1bHRpbmcgaXQgdG8gYmUgcHJvcGVybHkgZGVmcmFnZ2VkLg0KPj4NCj4gDQo+IFRoaXMg
c291bmRzIGxpa2UgdGhlIHZlcnkgd3JvbmcgdGhpbmcgdG8gZG8gdW5jb25kaXRpb25hbGx5
LiBZb3UgaGF2ZSBubyANCj4ga25vd2xlZGdlIG9mIGFwcGxpY2F0aW9uIEkvTyBwYXR0ZXJu
IGFuZCBkbyBub3Qga25vdyB3aGV0aGVyIGFwcGxpY2F0aW9uIA0KPiBpcyBnb2luZyB0byBm
aWxsIHRoaXMgZXh0ZW50IG9yIG5vdC4gSW5zdGVhZCBvZiBkZS1mcmFnbWVudGluZyB5b3Ug
YXJlIA0KPiBlZmZlY3RpdmVseSBmcmFnbWVudGluZy4NCg0KVGhpcyBpcyBub3QgZXhhY3Rs
eSB0cnVlLg0KDQpJZiB5b3UgaGF2ZSBvbmUgZmlsZSBleHRlbnQgb25seSByZWZlcnJpbmcg
MS8xNiBvZiBhIGxhcmdlciBleHRlbnQsIGl0IA0KYWxyZWFkeSBtZWFucyB0aGUgZXh0ZW50
IGl0c2VsZiBpcyBmcmFnbWVudGVkLg0KDQpFaXRoZXIgdGhyb3VnaCB0cnVuY2F0ZSAodGhl
IGNhc2Ugd2UncmUgZ2V0dGluZyBpbnRvKSwgb3IgdG9ucyBvZiBsYXRlciANCkNPVyBsZWFk
aW5nIHRvIHRoaXMgc2l0dWF0aW9uICh3aGljaCB3b3VsZCBhbHNvIGJlIGRlZnJhZ2dlZCBi
eSB0aGUgDQpleGlzdGluZyBkZWZyYWcgY29uZGl0aW9ucykNCg0KSWYgeW91IHdhbnQgdG8g
cHJvdmUgaXQgd3JvbmcsIHBsZWFzZSBnaXZlIG1lIGEgY291bnRlciBleGFtcGxlLg0KDQpU
aGFua3MsDQpRdQ0KPiANCj4gVGhpcyBzb3VuZHMgbW9yZSBsaWtlIGEgdGFyZ2V0IGZvciBh
IGRpZmZlcmVudCBvcGVyYXRpb24sIHdoaWNoIG1heSBiZSANCj4gY2FsbGVkICJnYXJiYWdl
IGNvbGxlY3Rpb24iLiBCdXQgaXQgc2hvdWxkIGJlIGV4cGxpY2l0IG9wZXJhdGlvbiBub3Qg
DQo+IHRpZWQgdG8gZGVmcmFnbWVudGF0aW9uIChvciBhdCBsZWFzdCBleHBsaWNpdCBvcHQt
aW4gZm9yIGRlZnJhZ21lbnRhdGlvbikuDQo+IA0KPj4gUmVwb3J0ZWQtYnk6IENocmlzdG9w
aCBBbnRvbiBNaXR0ZXJlciA8Y2FsZXN0eW9Ac2NpZW50aWEub3JnPg0KPj4gU2lnbmVkLW9m
Zi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+PiAtLS0NCj4+IMKgIGZzL2J0cmZz
L2RlZnJhZy5jIHwgMTEgKysrKysrKysrKysNCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2RlZnJhZy5jIGIv
ZnMvYnRyZnMvZGVmcmFnLmMNCj4+IGluZGV4IGMyNzZiMTM2YWI2My4uY2MzMTkxOTBiNmZi
IDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvZGVmcmFnLmMNCj4+ICsrKyBiL2ZzL2J0cmZz
L2RlZnJhZy5jDQo+PiBAQCAtMTA3MCw2ICsxMDcwLDE3IEBAIHN0YXRpYyBpbnQgZGVmcmFn
X2NvbGxlY3RfdGFyZ2V0cyhzdHJ1Y3QgDQo+PiBidHJmc19pbm9kZSAqaW5vZGUsDQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFuZXh0X21lcmdlYWJsZSkgew0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRlZnJhZ190YXJnZXRfcmFuZ2UgKmxhc3Q7DQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIFNwZWNpYWwgZW50cnkgcG9pbnQgdXRpbGl6YXRpb24gcmF0aW8gdW5kZXIgMS8x
NiAob25seQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJlZmVycmluZyAxLzE2
IG9mIGFuIG9uLWRpc2sgZXh0ZW50KS4NCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBUaGlzIGNhbiBoYXBwZW4gZm9yIGEgdHJ1bmNhdGVkIGxhcmdlIGV4dGVudC4NCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJZiB3ZSBkb24ndCBhZGQgdGhlbSwgdGhlbiBm
b3IgYSB0cnVuY2F0ZWQgZmlsZQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqICht
YXkgYmUgdGhlIGxhc3QgNEsgb2YgYSAxMjhNIGV4dGVudCkgaXQgd2lsbCBuZXZlcg0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGJlIGRlZnJhZ2VkLg0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVt
LT5yYW1fYnl0ZXMgPCBlbS0+b3JpZ19ibG9ja19sZW4gLyAxNikNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBhZGQ7DQo+PiArDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKiBFbXB0eSB0YXJnZXQgbGlzdCwgbm8gd2F5IHRvIG1lcmdlIHdp
dGggbGFzdCBlbnRyeSAqLw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxp
c3RfZW1wdHkodGFyZ2V0X2xpc3QpKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBnb3RvIG5leHQ7DQo+IA0K
--------------Gj7EaIahcwp9t83wSvP4CTAf
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------Gj7EaIahcwp9t83wSvP4CTAf--

--------------gHW0szKDrm895q3vLJ0YGx6Z--

--------------xqJTdrgw7u56C2z91tQGuPNk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWYYowFAwAAAAAACgkQwj2R86El/qgX
qAgApsBt4AEGXddFwqJCKAVmveTD/IONi7VMrAG1aBqOWLsXILmuAn1Nt2TbpAZ+I5kgdoC1lZrf
PN1xinyDm1FdZT5ZfRsNCN/wo17Q8H/qLcqJlTUGoNfCewUdQTQcEqh+h8EuySxkY1MNJtFte+A7
CcXTXIkfY/ETQnOuOeWrd2Hdj0QQZO1Z9jpDxUJytzwmdMi4Rk/uAn411yezDZiwcNMiCuuJV9A5
sIHcHrvfsYkCoALF6xTK4lN37GPgGNEanyt9gifl4alB6O94fgnKDeMgqD+ag9xPR0Bt1WNfdqfU
VWf9aLS1ewRNzUszz4NEgAdPclb2hSLjtVwMs5Pz+w==
=ryB6
-----END PGP SIGNATURE-----

--------------xqJTdrgw7u56C2z91tQGuPNk--

