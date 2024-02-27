Return-Path: <linux-btrfs+bounces-2831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC786886C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 05:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C06287887
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 04:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4A52F62;
	Tue, 27 Feb 2024 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="WFaOWZTf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD721EEEA
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709009983; cv=none; b=X5aN5kwlpQoxE0jlbu5Y6NQtkUAp3q+QEZlF9JGJdMjNFX8r8nb7NrTQDt5Q01qfCs6bemHRx8TjYGriL3sSRjexDhKmHuWwX8epbnJZyIILGmY5Up/paPUFPI2i/jOHVblXxVUJvJjUK7p3UN+cxb4vxV15QdJUpWkyHluANLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709009983; c=relaxed/simple;
	bh=jPjsjq451fO+BQfz9l+Pwh3pdAu0ijMrZHq9OeDK5RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RfEOT8lB15nA2NHtuXkOi9JOlFTyEWFZK40OgVUCfAPMcDwvDfs4Ce15AG8DWRUk5Dq+XjVJWcG503WfWcxJEA8pKHLYGkf/CYz+5HuDzg3ualAovTUy1+fy1XxxgmEDI4iV7YJ1X2lbXswjycZGV0AyWBvgcM+qhvqeoMX30vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=WFaOWZTf; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1709009975;
	bh=jPjsjq451fO+BQfz9l+Pwh3pdAu0ijMrZHq9OeDK5RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=WFaOWZTfbSc7c3uPVZRJ0anxBxR4zLXfkiKJ2YERviMLfxFQWlIDHIK5IUbd3CeTc
	 z1fShm5YudArw3qxZWQ9AMvwnyvYuyCwO66Md5S0QblvQruj+npdAKsLP5CFGTgjwp
	 7bpVrUBYHc79OqcuWfJyJkHxCVYl8k8X7EjbpX4A=
X-QQ-mid: bizesmtp88t1709009973tsy96dzs
X-QQ-Originating-IP: axOlPzbcD3PfsrksWPWLaLQC3P4t3RTzJ7iomhxcP5Y=
Received: from [192.168.1.136] ( [223.150.232.63])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 Feb 2024 12:59:32 +0800 (CST)
X-QQ-SSF: 01100000000000E0Z000000A0000000
X-QQ-FEAT: 5q30pvLz2icxaAAZyJ/0PSZg53ivR1J+MvK2ZGyazT2zH6TFg+S5HQMd9s4Ie
	kgCEjvyZ4AEVMUIDqBgtuGQ6qJNm7wLc3uqGf2KY83aIuWRTwRaHG6g78u3A50NUlDq4mhy
	DuNHecyvQyekOM9MUxtEx0fcOgZ++AquvAhZnVLdZl0j0DZe2/cM/jLdGXT9uQZYSqFou8e
	EzAaP4QcoQxL4oYf1ev5Lf0QHa9lSgBnQC1KHVzdFo2hEkGQB3XcpKQpV7gH3VvYxJwzyJO
	yl+kaqzACK9EiULm7YcQ0mNOM5k8a1812PYUroEtvs5tmyDGQOSLH9KsB6YOsBi/3OwTB12
	D8KockQmzBOG1c+HyMnNCehztb1dSHZq7e+2n/8wYlSXDqcK5RtmCn1rBs6sA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3239698662263899457
Message-ID: <425BE5D91F8099A5+e6a0c36f-3b56-4b3a-9459-6e2cc0918019@bupt.moe>
Date: Tue, 27 Feb 2024 12:59:30 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YVvFBP2Flka83lZzf0Vnu0w1"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YVvFBP2Flka83lZzf0Vnu0w1
Content-Type: multipart/mixed; boundary="------------xCk0ZGFpL6DnUnLhN1NcuZG4";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <e6a0c36f-3b56-4b3a-9459-6e2cc0918019@bupt.moe>
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
In-Reply-To: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
Autocrypt-Gossip: addr=wqu@suse.com; keydata=
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

--------------xCk0ZGFpL6DnUnLhN1NcuZG4
Content-Type: multipart/mixed; boundary="------------Szk00M691YTp5euxcqwYgnMc"

--------------Szk00M691YTp5euxcqwYgnMc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBbQlVHXQ0KPiBXaXRoIHRoZSBsYXRlc3Qga2VybmVsIHBhdGNoIHRvIHJlamVjdCBpbnZh
bGlkIHFncm91cGlkcyBpbg0KPiBidHJmc19xZ3JvdXBfaW5oZXJpdCBzdHJ1Y3R1cmUsICJi
dHJmcyBzdWJ2b2x1bWUgY3JlYXRlIiBvciAiYnRyZnMNCj4gc3Vidm9sdW1lIHNuYXBzaG90
IiBjYW4gbGVhZCB0byB0aGUgZm9sbG93aW5nIG91dHB1dDoNCj4NCj4gICAjIG1rZnMuYnRy
ZnMgLU8gcXVvdGEgLWYgJGRldg0KPiAgICMgbW91bnQgJGRldiAkbW50DQo+ICAgIyBidHJm
cyBzdWJ2b2x1bWUgY3JlYXRlIC1pIDIvMCAkbW50L3N1YnYxDQo+ICAgQ3JlYXRlIHN1YnZv
bHVtZSAnL21udC9idHJmcy9zdWJ2MScNCj4gICBFUlJPUjogY2Fubm90IGNyZWF0ZSBzdWJ2
b2x1bWU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4NCj4gVGhlICJidHJmcyBzdWJ2
b2x1bWUiIGNvbW1hbmQgb3V0cHV0IHRoZSBmaXJzdCBsaW5lLCBzZWVtaW5nbHkgdG8NCj4g
aW5kaWNhdGUgYSBzdWNjZXNzZnVsIHN1YnZvbHVtZSBjcmVhdGlvbiwgdGhlbiBmb2xsb3dl
ZCBieSBhbiBlcnJvcg0KPiBtZXNzYWdlLg0KPg0KPiBUaGlzIGNhbiBiZSBhIGxpdHRsZSBj
b25mdXNpbmcgb24gd2hldGhlciBpZiB0aGUgc3Vidm9sdW1lIGlzIGNyZWF0ZWQgb3INCj4g
bm90Lg0KPg0KPiBbRklYXQ0KPiBGaXggdGhlIG91dHB1dCBieSBvbmx5IG91dHB1dHRpbmcg
dGhlIHJlZ3VsYXIgbGluZSBpZiB0aGUgaW9jdGwNCj4gc3VjY2VlZGVkLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4gLS0tDQo+ICAgY21kcy9z
dWJ2b2x1bWUuYyB8IDIxICsrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2NtZHMvc3Vidm9sdW1lLmMgYi9jbWRzL3N1YnZvbHVtZS5jDQo+IGluZGV4IDAwYzVl
YWNmYTY5NC4uMTU0OWFkYWNhNjQyIDEwMDY0NA0KPiAtLS0gYS9jbWRzL3N1YnZvbHVtZS5j
DQo+ICsrKyBiL2NtZHMvc3Vidm9sdW1lLmMNCj4gQEAgLTIyOSw3ICsyMjksNiBAQCBzdGF0
aWMgaW50IGNyZWF0ZV9vbmVfc3Vidm9sdW1lKGNvbnN0IGNoYXIgKmRzdCwgc3RydWN0IGJ0
cmZzX3Fncm91cF9pbmhlcml0ICppbg0KPiAgIAkJZ290byBvdXQ7DQo+ICAgCX0NCj4gICAN
Cj4gLQlwcl92ZXJib3NlKExPR19ERUZBVUxULCAiQ3JlYXRlIHN1YnZvbHVtZSAnJXMvJXMn
XG4iLCBkc3RkaXIsIG5ld25hbWUpOw0KPiAgIAlpZiAoaW5oZXJpdCkgew0KPiAgIAkJc3Ry
dWN0IGJ0cmZzX2lvY3RsX3ZvbF9hcmdzX3YyCWFyZ3M7DQo+ICAgDQo+IEBAIC0yNTMsNiAr
MjUyLDcgQEAgc3RhdGljIGludCBjcmVhdGVfb25lX3N1YnZvbHVtZShjb25zdCBjaGFyICpk
c3QsIHN0cnVjdCBidHJmc19xZ3JvdXBfaW5oZXJpdCAqaW4NCj4gICAJCWVycm9yKCJjYW5u
b3QgY3JlYXRlIHN1YnZvbHVtZTogJW0iKTsNCj4gICAJCWdvdG8gb3V0Ow0KPiAgIAl9DQo+
ICsJcHJfdmVyYm9zZShMT0dfREVGQVVMVCwgIkNyZWF0ZSBzdWJ2b2x1bWUgJyVzLyVzJ1xu
IiwgZHN0ZGlyLCBuZXduYW1lKTsNCj4gICANCg0KDQpIb3cgYWJvdXQgc2F5aW5nICJDcmVh
dGVkIHN1YnZvbHVtZSAlcy8lcyIgPw0KDQoNCj4gICBvdXQ6DQo+ICAgCWNsb3NlKGZkZHN0
KTsNCj4gQEAgLTc1NCwxNiArNzU0LDggQEAgc3RhdGljIGludCBjbWRfc3Vidm9sdW1lX3Nu
YXBzaG90KGNvbnN0IHN0cnVjdCBjbWRfc3RydWN0ICpjbWQsIGludCBhcmdjLCBjaGFyICoN
Cj4gICAJaWYgKGZkIDwgMCkNCj4gICAJCWdvdG8gb3V0Ow0KPiAgIA0KPiAtCWlmIChyZWFk
b25seSkgew0KPiArCWlmIChyZWFkb25seSkNCj4gICAJCWFyZ3MuZmxhZ3MgfD0gQlRSRlNf
U1VCVk9MX1JET05MWTsNCj4gLQkJcHJfdmVyYm9zZShMT0dfREVGQVVMVCwNCj4gLQkJCSAg
ICJDcmVhdGUgYSByZWFkb25seSBzbmFwc2hvdCBvZiAnJXMnIGluICclcy8lcydcbiIsDQo+
IC0JCQkgICBzdWJ2b2wsIGRzdGRpciwgbmV3bmFtZSk7DQo+IC0JfSBlbHNlIHsNCj4gLQkJ
cHJfdmVyYm9zZShMT0dfREVGQVVMVCwNCj4gLQkJCSAgICJDcmVhdGUgYSBzbmFwc2hvdCBv
ZiAnJXMnIGluICclcy8lcydcbiIsDQo+IC0JCQkgICBzdWJ2b2wsIGRzdGRpciwgbmV3bmFt
ZSk7DQo+IC0JfQ0KPiAgIA0KPiAgIAlhcmdzLmZkID0gZmQ7DQo+ICAgCWlmIChpbmhlcml0
KSB7DQo+IEBAIC03ODQsNiArNzc2LDE1IEBAIHN0YXRpYyBpbnQgY21kX3N1YnZvbHVtZV9z
bmFwc2hvdChjb25zdCBzdHJ1Y3QgY21kX3N0cnVjdCAqY21kLCBpbnQgYXJnYywgY2hhciAq
DQo+ICAgDQo+ICAgCXJldHZhbCA9IDA7CS8qIHN1Y2Nlc3MgKi8NCj4gICANCj4gKwlpZiAo
cmVhZG9ubHkpDQo+ICsJCXByX3ZlcmJvc2UoTE9HX0RFRkFVTFQsDQo+ICsJCQkgICAiQ3Jl
YXRlIGEgcmVhZG9ubHkgc25hcHNob3Qgb2YgJyVzJyBpbiAnJXMvJXMnXG4iLA0KPiArCQkJ
ICAgc3Vidm9sLCBkc3RkaXIsIG5ld25hbWUpOw0KPiArCWVsc2UNCj4gKwkJcHJfdmVyYm9z
ZShMT0dfREVGQVVMVCwNCj4gKwkJCSAgICJDcmVhdGUgYSBzbmFwc2hvdCBvZiAnJXMnIGlu
ICclcy8lcydcbiIsDQo+ICsJCQkgICBzdWJ2b2wsIGRzdGRpciwgbmV3bmFtZSk7DQo+ICsN
Cj4gICBvdXQ6DQo+ICAgCWNsb3NlKGZkZHN0KTsNCj4gICAJY2xvc2UoZmQpOw0K
--------------Szk00M691YTp5euxcqwYgnMc
Content-Type: application/pgp-keys; name="OpenPGP_0xCC7801A4C3E3A368.asc"
Content-Disposition: attachment; filename="OpenPGP_0xCC7801A4C3E3A368.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYd2CwRYJKwYBBAHaRw8BAQdA+Cjl7faceXuI8bf4TOInbIgM8RRMSrlNqkJM
iX6XUOjNLUhBTiBZdXdlaSAoaGFueXV3ZWk3MCkgPGhhbnl1d2VpNzBAZ21haWwu
Y29tPsKQBBMWCAA4FiEE5jAMjRwseUJjIHytzHgBpMPjo2gFAmHdg0QCGwEFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQzHgBpMPjo2huYQD+IBK5NHWTngw/Ujcf
wnTmjXVBqJdrjC8XSHoMQepgwE4BALosq8/PFwesiQjXRo5a7dGyvswgkWtr0LMo
Bp5SQXkKzSXpn6nkuo7mg58gKGhhbnl1d2VpNzApIDxocnhAYnVwdC5tb2U+wpAE
ExYIADgWIQTmMAyNHCx5QmMgfK3MeAGkw+OjaAUCYd2CwQIbAQULCQgHAgYVCgkI
CwIEFgIDAQIeAQIXgAAKCRDMeAGkw+OjaLlDAP9Wh3ee0/6NIL76n6qx9jvM3EKm
51/AzDdLEz1T26b+fwEAg9vWtLc8gPfjVGsKsXMBJAv57qkz+kws/229mux51wHN
HemfqeS6juaDnyA8aGFueXV3ZWk3MEBxcS5jb20+wpAEExYIADgWIQTmMAyNHCx5
QmMgfK3MeAGkw+OjaAUCYd2DJAIbAQULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
CRDMeAGkw+OjaIxvAP9PxxZKTM60lDb/SbyDbfP8Bzi4LfZSa8T6GcBK5gUbGQD/
cw7hCEHEYdqIa1HATmXIsWozofsrlc4nRVeOjBm7SAbOMwRh3YXMFgkrBgEEAdpH
DwEBB0BjhXs3EEqaQMMe+y6eQPrN/iijsRn0+V7Yfxgv3LZNMsLANQQYFggAJhYh
BOYwDI0cLHlCYyB8rcx4AaTD46NoBQJh3YXMAhsCBQkJZgGAAIEJEMx4AaTD46No
diAEGRYIAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCYd2FzAAKCRBLkKfpYfpB
U/OHAP98maDWlKN7WlOaIlIuL4nnmeeKlW1zRweQ4nbngJWTZQD+IZ07dJMb41M7
3k3jPaT+uspGa+D3HivKAvnYGogLAw14AQEAywpAA/ze6ujATllsN9bQFOMThnaC
FYS3fYEVucLp57sA/RBfjnsQxA4ADe1EJaE0YYwDMo5UKga/wT9Wk90a5LIPzjgE
Yd2DUhIKKwYBBAGXVQEFAQEHQObBEtGrlnW9aBtHCkwYROmOqVF9AZuLZnAyJotA
j/4KAwEIB8J+BBgWCAAmFiEE5jAMjRwseUJjIHytzHgBpMPjo2gFAmHdg1ICGwwF
CQlmAYAACgkQzHgBpMPjo2jG2gD+LkrU5GPlDTUEYxBYBEyfd4igkf2TyeGbwFU5
pUwrFtgA/0tbB+3oaUUI3jwAbGWlUpXn2+iROFfqokr+fGa4SSUM
=3D/880
-----END PGP PUBLIC KEY BLOCK-----

--------------Szk00M691YTp5euxcqwYgnMc--

--------------xCk0ZGFpL6DnUnLhN1NcuZG4--

--------------YVvFBP2Flka83lZzf0Vnu0w1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZd1sMgAKCRBLkKfpYfpB
UyfrAP9wIMXLzFnF7z+DbqyTInDxjO/EXyhJ0lKeuC3/FxmVZwD9FpyYtWD33Jtw
/yoisl3//WT2IB6F1YO7bOLpP1vOdgE=
=Rwx4
-----END PGP SIGNATURE-----

--------------YVvFBP2Flka83lZzf0Vnu0w1--

