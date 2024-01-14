Return-Path: <linux-btrfs+bounces-1442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A582D207
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 21:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0031A1C209D6
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC21134A2;
	Sun, 14 Jan 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bpZ4HK34"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A28107A6
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jan 2024 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso89721511fa.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jan 2024 12:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705262473; x=1705867273; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1UNK604mpMBNq59zORlWBBKL9HNnG70v1O9+71XPibM=;
        b=bpZ4HK344dw8tluLzGYI/qZQU33IuAMP0MSqnAKYUfWZawEbSBiQ/AE9UO80wqk9UN
         NmEgk319wseLDuArSieLODpeotAtfPr+c092XlhI3Xc5H4fl5k86u8fbQkLNBcQL8PQ/
         Ird+oFr96Vp4y46RqvhFepVdaf9qlKUI0XAe1BfR5Y5hq/LvWXvQBff8KAf+ImzMhGUg
         rLjFQh8OGuvgQ/iuY/WLqnQDkH/EoXfsPIstLhlWXJ0OyI9mHm6b3x0hJXTzU9TvbS9V
         ZxklOFNFw8AlUOKTIrcDyb5pnLOpXGf8oSHkEta3IoM91RaCxJwoGF37rdSr+5xaagaq
         MKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705262473; x=1705867273;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UNK604mpMBNq59zORlWBBKL9HNnG70v1O9+71XPibM=;
        b=w5nvJnrxvyqO0Kzq59D2Yzc9iRk/oUPJ2P9unbWxKiJsM8MNWH/WFMGiR9X3G0+Mdr
         Dz0vrJrUZwTGBo3kWNIIaKReq79PGjL1P5z/rXOUMqnB70irJfVSjBJaIq8p5UsegkVy
         A/AJCJ0rW4JMefkwX9adyBWHP3+c2xdYB81y2lnbrS5roevo+jZxDmFe+0lL7hKzGkTs
         /SDmPyRNki5R/9+xvvIJJm5Gx8BWgVFf7VpEwbNLUDZfejg6L6x3xqVT7TuTO0pVT0kv
         gssFmuRXzJfMhOVFqX22eoKr1J7EDDVy/Cg5JUjzUt1Y7RWG4r2fSf0LdMeN7Wz+dF4P
         PaoA==
X-Gm-Message-State: AOJu0YxKR7nFzdgzAs39Qt4hbqdWAkNKStJITUqpeBl/tIZHPUKOwyXP
	MUTtWpbaNVX+7qnXObd7y73iz7TGDbOHTw==
X-Google-Smtp-Source: AGHT+IHvT+wxm8ZcAsFuxzrGcdvt36anO6CLrHMLJTicwxFptGN7gJFNiSDMU9QVFPCAIsIS5xClnA==
X-Received: by 2002:a2e:9014:0:b0:2cc:cf5f:b83f with SMTP id h20-20020a2e9014000000b002cccf5fb83fmr870567ljg.19.1705262472648;
        Sun, 14 Jan 2024 12:01:12 -0800 (PST)
Received: from ?IPV6:2403:580d:bef6::959? (2403-580d-bef6--959.ip6.aussiebb.net. [2403:580d:bef6::959])
        by smtp.gmail.com with ESMTPSA id jw6-20020a170903278600b001d5084a353fsm6369599plb.37.2024.01.14.12.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 12:01:12 -0800 (PST)
Message-ID: <a85ba39e-74cb-4dce-b8df-0416df5b28e0@suse.com>
Date: Mon, 15 Jan 2024 06:31:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] kstrtox: introduce memparse_safe()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 David.Laight@aculab.com, ddiss@suse.de, geert@linux-m68k.org
References: <cover.1704324320.git.wqu@suse.com>
 <ZZllAi_GbsoDF5Eg@smile.fi.intel.com>
 <7708fc8b-738c-4d58-b89e-801ce6a4832a@gmx.com>
 <ZaPkz7gU42Eahf4L@smile.fi.intel.com>
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
In-Reply-To: <ZaPkz7gU42Eahf4L@smile.fi.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FTesodJnE2taup6vFGjPnABs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FTesodJnE2taup6vFGjPnABs
Content-Type: multipart/mixed; boundary="------------t98N7caD7WO5cj7dzHxIMbp2";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 David.Laight@aculab.com, ddiss@suse.de, geert@linux-m68k.org
Message-ID: <a85ba39e-74cb-4dce-b8df-0416df5b28e0@suse.com>
Subject: Re: [PATCH v3 0/4] kstrtox: introduce memparse_safe()
References: <cover.1704324320.git.wqu@suse.com>
 <ZZllAi_GbsoDF5Eg@smile.fi.intel.com>
 <7708fc8b-738c-4d58-b89e-801ce6a4832a@gmx.com>
 <ZaPkz7gU42Eahf4L@smile.fi.intel.com>
In-Reply-To: <ZaPkz7gU42Eahf4L@smile.fi.intel.com>

--------------t98N7caD7WO5cj7dzHxIMbp2
Content-Type: multipart/mixed; boundary="------------JZkM01Ev4ozrrxIN9jXyYXqt"

--------------JZkM01Ev4ozrrxIN9jXyYXqt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8xNSAwMDoxMiwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBT
dW4sIEphbiAwNywgMjAyNCBhdCAwNzoyODoyN0FNICsxMDMwLCBRdSBXZW5ydW8gd3JvdGU6
DQo+PiBPbiAyMDI0LzEvNyAwMTowNCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+IE9u
IFRodSwgSmFuIDA0LCAyMDI0IGF0IDA5OjU3OjQ3QU0gKzEwMzAsIFF1IFdlbnJ1byB3cm90
ZToNCj4gDQo+IC4uLg0KPiANCj4+PiBIYXZpbmcgdGVzdCBjYXNlcyBpcyBxdWl0ZSBnb29k
LCB0aGFua3MhDQo+Pj4gQnV0IGFzIEkgdW5kZXJzdG9vZCB3aGF0IEFsZXhleSB3YW50ZWQs
IGlzIG5vdCB1c2luZyB0aGUga3N0cnRveCBmaWxlcyBmb3IgdGhpcy4NCj4+PiBZb3UgY2Fu
IGludHJvZHVjZSBpdCBpbiB0aGUgY21kbGluZS5jLCBjb3JyZWN0PyBKdXN0IGluY2x1ZGUg
bG9jYWwgImtzdHJ0b3guaCIuDQo+Pg0KPj4gTm90IHJlYWxseSBwb3NzaWJsZSwgYWxsIHRo
ZSBuZWVkZWQgcGFyc2luZyBoZWxwZXJzIGFyZSBpbnRlcm5hbCBpbnNpZGUNCj4+IGtzdHJ0
b3guYy4NCj4gDQo+IEknbSBub3Qgc3VyZSBJIGZvbGxvdy4gVGhlIGZ1bmN0aW9ucyBhcmUg
YXZhaWxhYmxlIHRvIG90aGVyIGxpYnJhcnkgKGJ1aWx0LWluKQ0KPiBtb2R1bGVzLg0KDQpE
aWQgSSBtaXNzIHNvbWV0aGluZz8NCg0KRmlyc3RseSBuZWl0aGVyIF9wYXJzZV9pbnRlZ2Vy
X2ZpeHVwX3JhZGl4KCkgbm9yIF9wYXJzZV9pbnRlZ2VyX2xpbWl0KCkgDQppcyBleHBvcnRl
ZCB0byBtb2R1bGVzLiAoTm8gRVhQT1JUX1NZTUJPTCgpIGNhbGwgb24gdGhlbSkuDQoNClNl
Y29uZGx5IF9wYXJzZV9pbnRlZ2VyX2ZpeHVwX3JhZGl4KCkgYW5kIF9wYXJzZV9pbnRlZ2Vy
X2xpbWl0IGhhdmUgIl8iIA0KcHJlZml4LCBhbmQgaXMgb25seSBkZWNsYXJlZCBpbiAibGli
L2tzdHJ0b3guaCIsIHdoaWNoIG1lYW5zIHRoZXkgYXJlIA0KZGVzaWduZWQgb25seSBmb3Ig
aW50ZXJuYWwgdXNhZ2UuDQpJZiBwdXR0aW5nIG1lbXBhcnNlX3NhZmUoKSBpbnRvIGNtZGxp
bmUuYywgYXQgbGVhc3Qgd2Ugd291bGQgbmVlZCB0byANCmluY2x1ZGUgbG9jYWwgaGVhZGVy
ICJrc3RydG94LmgiLCBhbmQgSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgYW55IGJldHRlciAN
CnRoYW4gcHV0dGluZyBtZW1wYXJzZV9zYWZlKCkgaW50byBrc3RydG94LltjaF0uDQoNCkZp
bmFsbHksIEkganVzdCB0cmllZCBwdXR0aW5nIG1lbXBhcnNlX3NhZmUoKSBpbnRvIGNtZGxp
bmUuYywgYW5kIGl0IA0KZmFpbGVkIGF0IGxpbmthZ2Ugc3RhZ2UsIGV2ZW4gaWYgdGhhdCBv
ZmZlbmRpbmcgZmlsZSBoYXMgbm8gY2FsbCB0byANCm1lbXBhcnNlX3NhZmUoKToNCg0KICAg
bGQ6IGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9rYXNsci5vOiBpbiBmdW5jdGlvbiBgbWVt
cGFyc2Vfc2FmZSc6DQprYXNsci5jOigudGV4dCsweGJiMSk6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8gYF9wYXJzZV9pbnRlZ2VyX2ZpeHVwX3JhZGl4Jw0KICAgbGQ6IGthc2xyLmM6KC50
ZXh0KzB4YmM1KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX3BhcnNlX2ludGVnZXInDQog
ICBsZDogYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL3ZtbGludXg6IGhpZGRlbiBzeW1ib2wg
YF9wYXJzZV9pbnRlZ2VyJyANCmlzbid0IGRlZmluZWQNCg0KSSBjYW4gdHJ5IGFnYWluIGJ1
dCBJJ20gbm90IHN1cmUgaWYgaXQncyBwb3NzaWJsZSB0byBtb3ZlIA0KbWVtcGFyc2Vfc2Fm
ZSgpIHRvIGNtZGxpbmUuW2NoXS4NCg0KPiANCj4+IEZ1cnRoZXJtb3JlLCB0aGlzIGFsc28g
bWVhbnMgbWVtcGFyc2UoKSBjYW4gbm90IGJlIGVuaGFuY2VkIGR1ZSB0bzoNCj4+DQo+PiAt
IExhY2sgb2Ygd2F5cyB0byByZXR1cm4gZXJyb3JzDQo+IA0KPiBXaGF0IGRvZXMgdGhpcyBt
ZWFuPw0KDQpJZiB5b3Ugd2FudCB0byBrZWVwIHRoZSBwcm90b3R5cGUgb2YgbWVtcGFyc2Uo
KSAoYWthLCBhIGRyb3AtaW4gDQplbmhhbmNlbWVudCksIHRoZW4gdGhlcmUgaXMgbm8gZ29v
ZCB3YXkgdG8gaW5kaWNhdGUgdGhlIGVycm9ycyBsaWtlIA0Kb3ZlcmZsb3cgYXQgYWxsLg0K
DQo+IA0KPj4gLSBVbmFibGUgdG8gY2FsbCB0aGUgcGFyc2luZyBoZWxwZXJzIGluc2lkZSBj
bWRsaW5lLmMNCj4gDQo+ID8/PyAoc2VlIGFib3ZlKQ0KPiANClNlZSBhYm92ZS4NCg0KVGhh
bmtzLA0KUXUNCg==
--------------JZkM01Ev4ozrrxIN9jXyYXqt
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------JZkM01Ev4ozrrxIN9jXyYXqt--

--------------t98N7caD7WO5cj7dzHxIMbp2--

--------------FTesodJnE2taup6vFGjPnABs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWkPYEFAwAAAAAACgkQwj2R86El/qiA
MwgAkEwzwB5E60yMZF2XsTjNcvEItjlhDdb6JsizHHafr1PyTez1XIG/EIJon2eg32QT8z2PSSqH
Of3AYip+5M42ZTfsA+WpZIchh6OzdOJLNu7pP75zeFii0pcq2tZ0VkbMfXv9huKYvmP0p6haX7vg
aVi2LEWXu9OVXzhVS/mf67sYR3R1gsJNdZu4bb9BrBSBotHWA5n9j/Pv4D/n5M31HkdP4JwbJ0RF
phWNnLu8XcCXC00KhtAzCGl/oagFvXGs9flTCxUqaTffWs8nDX4qxLfPzQcqJiHEc0lF9SCQ14P8
3KYb7PZCFq0oWScyp5wrX9+ky4fzKZu3bQ/iS6gW2g==
=EkvN
-----END PGP SIGNATURE-----

--------------FTesodJnE2taup6vFGjPnABs--

