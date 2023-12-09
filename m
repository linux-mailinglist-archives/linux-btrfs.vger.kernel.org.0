Return-Path: <linux-btrfs+bounces-788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF780B66C
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 22:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85D11F21056
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3611CA95;
	Sat,  9 Dec 2023 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="api9viFk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF759F4
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 13:09:39 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so26163891fa.0
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Dec 2023 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702156178; x=1702760978; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEejwOHD83hUSs+OJE4OJ+NSXjHJjuEFpor+Yo++fl0=;
        b=api9viFkms1r8BUHZdwq8ewZ2XMVThT/wJq2tfUK0IoafaYDncy37X9CpyK19qsfUv
         dpW38NmNqyoAzTqWp8nOKn4K0lHGzd4+2dRvjD2TOERANKbhFmheVKMzDmdNL4vq5yEg
         7V6QkFqEMVdXM21/5bsO0v1ejkqOeiPAwh4iQ+noLF3+TUaVhXkJR0layaontUYj5jKE
         XQz4FxC/MGARf6FBP40KPHZLSJIYuNSA/3Zeb0R7Vpf95NvY4XEBxuY8LKNiMbT7rsW8
         5m78TaB8ZaNhPiNIWYmpnlgt+LDLB+C46lefUN0Yt++z6Z1/TBHej/fPxdY6wc/vq1i/
         v/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702156178; x=1702760978;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GEejwOHD83hUSs+OJE4OJ+NSXjHJjuEFpor+Yo++fl0=;
        b=YpoN8yBISlS3k/A3erUBjWjy/NsB88vpfV4FGghNzvRlgWRAtOQsz760HCnYo09Zk7
         T2qV2xt+kkiTvG0GxzuuwDiDsl8ycyCgFzmhVxXwtkYIRzYnrT8EAnWJCxd6CbnSZupz
         Wu90lSu5va+fUk19eO3df96cOVOaUELHZJSCpzpZHChpKygQoAYXNrEJlAAIAkm1Bo/q
         pHskETf7UkknaGwB9i9j11E0QhDpdCtY4FzFHrdWwgVF/yYrhPfX7lXCEuepBbDlv6yL
         8fKOn2ZXO4Gmq4jdBLNcHEGoCjfCIobEAGYmvQEMLR9NM29iq7eDARZfdmtwYwz9cuYQ
         gskg==
X-Gm-Message-State: AOJu0YwRXbi987OIWKoMIIK5a47VMdGanaJjZ2Q164NO8/65fEqB5NRX
	jbex8kFkJJTS/JT49ZjPzzqfTg==
X-Google-Smtp-Source: AGHT+IFHgto4zmBkqoKhOK/Nwv5DDHNXW+R8lKAHdk33d7km6LBCVpRI3VUW1Jj4Mr7s2bvL2m9bdw==
X-Received: by 2002:a2e:6a01:0:b0:2ca:24c:e252 with SMTP id f1-20020a2e6a01000000b002ca024ce252mr945890ljc.91.1702156177918;
        Sat, 09 Dec 2023 13:09:37 -0800 (PST)
Received: from ?IPV6:2001:4479:a500:4d00::959? ([2001:4479:a500:4d00::959])
        by smtp.gmail.com with ESMTPSA id f16-20020aa782d0000000b006ce6878b274sm3612203pfn.216.2023.12.09.13.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 13:09:37 -0800 (PST)
Message-ID: <d8a5e127-25e6-44df-abe4-73776f43825f@suse.com>
Date: Sun, 10 Dec 2023 07:39:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] btrfs: scrub: Fix use of uninitialized variable
To: 'Guanjun' <guanjun@linux.alibaba.com>, wqu@suse.com, dsterba@suse.com,
 clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
References: <20231209082132.2690130-1-guanjun@linux.alibaba.com>
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
In-Reply-To: <20231209082132.2690130-1-guanjun@linux.alibaba.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IQ0eZQFN1TZ0gSR83IsG9gvN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IQ0eZQFN1TZ0gSR83IsG9gvN
Content-Type: multipart/mixed; boundary="------------9Xr5MdSjhRuokWfP3gziTlHe";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: 'Guanjun' <guanjun@linux.alibaba.com>, wqu@suse.com, dsterba@suse.com,
 clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Message-ID: <d8a5e127-25e6-44df-abe4-73776f43825f@suse.com>
Subject: Re: [PATCH 1/1] btrfs: scrub: Fix use of uninitialized variable
References: <20231209082132.2690130-1-guanjun@linux.alibaba.com>
In-Reply-To: <20231209082132.2690130-1-guanjun@linux.alibaba.com>

--------------9Xr5MdSjhRuokWfP3gziTlHe
Content-Type: multipart/mixed; boundary="------------GvcMG5VA8KZBddarWOy9hEdY"

--------------GvcMG5VA8KZBddarWOy9hEdY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjMvMTIvOSAxODo1MSwgJ0d1YW5qdW4nIHdyb3RlOg0KPiBGcm9tOiBHdWFu
anVuIDxndWFuanVuQGxpbnV4LmFsaWJhYmEuY29tPg0KPiANCj4gJ3JldCcgd2lsbCBiZSB1
bmluaXRpYWxpemVkIGluIGNhc2UgdGhhdCB0aGUgbG9naWNhbF9sZW5ndGgNCj4gaXMgMC4g
RXZlbiBpZiB0aGUgY2FsbGVyIGhhcyBhbHJlYWR5IGVuc3VyZWQgdGhhdCBsb2dpY2FsX2xl
bmd0aA0KPiBpcyBncmVhdGVyIHRoYW4gMCwgd2Ugc3RpbGwgbmVlZCB0byBmaXggdGhpcyBp
c3N1ZS4gRHVlIHRvIHRoZQ0KPiBjb21waWxlciBtYXkgY29tcGxhaW4gbGlrZSB0aGlzOg0K
PiANCj4gZnMvYnRyZnMvc2NydWIuYzogSW4gZnVuY3Rpb24g4oCYc2NydWJfc2ltcGxlX21p
cnJvci5jb25zdHByb3DigJk6DQo+IGZzL2J0cmZzL3NjcnViLmM6MjEyMzo5OiBlcnJvcjog
4oCYcmV04oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBb
LVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQ0KPiAgIDIxMjMgfCAgcmV0dXJuIHJldDsN
Cj4gICAgICAgIHwgICAgICAgICBefn4NCj4gDQoNCkNvbXBpbGVyIHZlcnNpb24gYW5kIGNv
bmZpZyBwbGVhc2UuDQoNCllvdSBrbm93IGJ0cmZzIGhhcyBlbmFibGVkIC1XbWF5YmUtdW5p
bml0aWFsaXplZCBhbHJlYWR5IGFuZCBhbGwgDQp3YXJuaW5ncyB3b3VsZCBiZSB0cmVhdGVk
IGFzIGVycm9yLg0KVGhpcyBtZWFucyBpZiB0aGlzIGlzIHJlYWxseSB2YWxpZCwgdG9ucyBv
ZiB0ZXN0ZXJzIHdvdWxkIGFscmVhZHkgaGl0IGl0Lg0KDQpUaHVzIEknbSB3b25kZXJpbmcg
aWYgaXQncyBzb21lIGludGVybmFsIG91dC1vZi1kYXRlIHRvb2xjaGFpbiBvbiB5b3VyIHNp
ZGUuDQoNCg0KRnVydGhlcm1vcmUsIGlmIHlvdSByZWFsbHkgd2FudCB0byBmaXggdGhlIHBy
b2JsZW0sIEkgc3Ryb25nbHkgDQpkaXNjb3VyYWdlIGZyb20gYmxpbmRseSBzZXR0aW5nIHRo
ZSBAcmV0IHRvIDAuDQoNCkJ1dCBjaGFuZ2UgYWxsIHRoZSBicmVhayBjYWxscyBvZiB0aGUg
bG9vcCB0byByZXR1cm4gZGlyZWN0bHksIHNvIHRoYXQgDQp0aGUgZmluYWwgcmV0dXJuIG91
dCBvZiB0aGUgbG9vcCBjYW4gYWx3YXlzIHJldHVybiAwLCBzbyB0aGF0IEByZXQgY2FuIA0K
YmUgZGVmaW5lZCBpbnNpZGUgdGhlIGxvb3AsIGFuZCBiZSBtdWNoIHNhZmVyLg0KDQpUaGFu
a3MsDQpRdQ0KDQo+IEZpeGVzOiAwOTAyMmIxNGZhZmMgKGJ0cmZzOiBzY3J1YjogaW50cm9k
dWNlIGRlZGljYXRlZCBoZWxwZXIgdG8gc2NydWIgc2ltcGxlLW1pcnJvciBiYXNlZCByYW5n
ZSkNCj4gU2lnbmVkLW9mZi1ieTogR3Vhbmp1biA8Z3Vhbmp1bkBsaW51eC5hbGliYWJhLmNv
bT4NCj4gLS0tDQo+ICAgZnMvYnRyZnMvc2NydWIuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9idHJmcy9zY3J1Yi5jIGIvZnMvYnRyZnMvc2NydWIuYw0KPiBpbmRleCBhMDE4MDdj
YmQ0ZDQuLjEzMDI0MTMxZjc3ZCAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvc2NydWIuYw0K
PiArKysgYi9mcy9idHJmcy9zY3J1Yi5jDQo+IEBAIC0yMDcxLDcgKzIwNzEsNyBAQCBzdGF0
aWMgaW50IHNjcnViX3NpbXBsZV9taXJyb3Ioc3RydWN0IHNjcnViX2N0eCAqc2N0eCwNCj4g
ICAJc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBzY3R4LT5mc19pbmZvOw0KPiAg
IAljb25zdCB1NjQgbG9naWNhbF9lbmQgPSBsb2dpY2FsX3N0YXJ0ICsgbG9naWNhbF9sZW5n
dGg7DQo+ICAgCXU2NCBjdXJfbG9naWNhbCA9IGxvZ2ljYWxfc3RhcnQ7DQo+IC0JaW50IHJl
dDsNCj4gKwlpbnQgcmV0ID0gMDsNCj4gICANCj4gICAJLyogVGhlIHJhbmdlIG11c3QgYmUg
aW5zaWRlIHRoZSBiZyAqLw0KPiAgIAlBU1NFUlQobG9naWNhbF9zdGFydCA+PSBiZy0+c3Rh
cnQgJiYgbG9naWNhbF9lbmQgPD0gYmctPnN0YXJ0ICsgYmctPmxlbmd0aCk7DQo=
--------------GvcMG5VA8KZBddarWOy9hEdY
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------GvcMG5VA8KZBddarWOy9hEdY--

--------------9Xr5MdSjhRuokWfP3gziTlHe--

--------------IQ0eZQFN1TZ0gSR83IsG9gvN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmV014sFAwAAAAAACgkQwj2R86El/qiH
ZAgAjGYy9rqns+I34Kwg0AK6dj3cDDdOfEkQ1XayvK7I2ZXtepCnlkdSLhlzK5692B+9mo6bJOX0
FpL2s+2ll2S1/z0wYb0N09ZOfRAO37fpXTwXgwihl1ldTV3/a6dmLQqTpyuCtgtmydTUd1s4qXVW
QeJvCroUz1zPZemwsbtc+x34LB9iSxW5cOjiq5oY5Z8RBCh639aElSMoNQD0JY/mg2dtlXml0Ncq
vCGAPH1/RZf6mqlms7EFTGlNLam0CU0Lm3nke2aX8Y1Y76+QJq4AeBoOQq3rNQG9OeSQDOtt4C0m
zZY6BEkam3tiWLSuoTq632cycSF2WdBIw1wycaApWA==
=4SYI
-----END PGP SIGNATURE-----

--------------IQ0eZQFN1TZ0gSR83IsG9gvN--

