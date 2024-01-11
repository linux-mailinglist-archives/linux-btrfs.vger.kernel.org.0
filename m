Return-Path: <linux-btrfs+bounces-1386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D1A82A78B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 07:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B3E1C2545A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BAD2591;
	Thu, 11 Jan 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CugtKurQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085423C3
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd0c17e42bso55903051fa.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704954293; x=1705559093; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=apm/OcGY8eRacO8WwQ8h2G2o8JqZY30vsh7yKNy09hA=;
        b=CugtKurQsGp0o9vao7dR+Z3lzNDRqGCiyDyPX7XwUog+lN3f75RS+K5xWdSSX7jSLj
         CLKox73+woEsF4muga4E8Eb9p75+D3n4UdE+O41VBZ/MEwjW+uAsc5UP2z9Hku4dofH5
         whBNEL0pYxYzoo7ZFggdkJhMlXfmzFEqSAilBwpo+pXp646JC2ncyM8okV8yPqu+Cpnv
         NKBdFg6JlwJ6Nx6hfaaUwRFYcBvou9a4+WUTIdd9Q03/39GCsHynbjICsuyGU8vf9vxP
         5Lhhh4mAZJbGupDyDiU//XX55UkPOwSVsx+ZA+EgGgxiWJaXNAxDiV+FEZjEaZ3qy+zz
         ydPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704954293; x=1705559093;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apm/OcGY8eRacO8WwQ8h2G2o8JqZY30vsh7yKNy09hA=;
        b=JzuObJXWutksLChzHqv+npdZAwac8X3ytsRJTAzFNXRTCHs5JSne5OfAGaCEsyt0DJ
         M/+1UF/69aR1dWojtbXAD+5tZIRAlzMc8NpG764XiiIW0QeJwbdCE5JocnMZZd4sd7Fc
         dXp/P/otJxMHR8SNmO38y7sl39pGcwobvepoTXGU8kCSfAhFZ86DNc0xDCmPjDmzb8B7
         PMiQrWUqTh7UspY3zwNKeSoFvx9Ma6CkPU2TI1USXP0oXmY806EoxLWw3vh5upbSJ68q
         4ntvbek0HsJRqRu7TeDhSvki1eRzLnsgPLPARET+CVLGR8fvaZsaXj8sEddughiMyXwW
         CBbQ==
X-Gm-Message-State: AOJu0YxHFI4M8epy/cQreEJ5UdMQ+x670zUeI4l+7Thtr3uncWZ0Vzli
	jTkcAtzUmlGS0XWdq4hY5T5mLAMUwH2uEg==
X-Google-Smtp-Source: AGHT+IEwTx0avLI5Qiyrlh7Xg9tOaHayYnPoVdOEe2LSiHJTwgAd4On53efG5sdvBn83GT8MKUBZBA==
X-Received: by 2002:a2e:920e:0:b0:2cd:3141:5d59 with SMTP id k14-20020a2e920e000000b002cd31415d59mr91554ljg.16.1704954293400;
        Wed, 10 Jan 2024 22:24:53 -0800 (PST)
Received: from [192.168.153.88] (pa49-178-149-31.pa.nsw.optusnet.com.au. [49.178.149.31])
        by smtp.gmail.com with ESMTPSA id x188-20020a6263c5000000b006d995146bcbsm366461pfb.180.2024.01.10.22.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 22:24:52 -0800 (PST)
Message-ID: <a033550b-9300-42bd-9ec2-74f9ee15cad3@suse.com>
Date: Thu, 11 Jan 2024 16:54:47 +1030
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
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
 Christoph Anton Mitterer <calestyo@scientia.org>
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <20240110170941.GA31555@twin.jikos.cz>
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
In-Reply-To: <20240110170941.GA31555@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QeZQoj7hciikZpF2uFe3I7dn"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QeZQoj7hciikZpF2uFe3I7dn
Content-Type: multipart/mixed; boundary="------------mLfJ3nj08QKtJbPQ6EgNrNjU";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
 Christoph Anton Mitterer <calestyo@scientia.org>
Message-ID: <a033550b-9300-42bd-9ec2-74f9ee15cad3@suse.com>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <20240110170941.GA31555@twin.jikos.cz>
In-Reply-To: <20240110170941.GA31555@twin.jikos.cz>

--------------mLfJ3nj08QKtJbPQ6EgNrNjU
Content-Type: multipart/mixed; boundary="------------aa06AkHBF6wO0qwJ5mX9PFOx"

--------------aa06AkHBF6wO0qwJ5mX9PFOx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8xMSAwMzozOSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBGcmks
IEphbiAwNSwgMjAyNCBhdCAwNjowMzo0MFBNICsxMDMwLCBRdSBXZW5ydW8gd3JvdGU6DQo+
PiBbQlVHXQ0KPj4gVGhlIGZvbGxvd2luZyBzY3JpcHQgY2FuIGxlYWQgdG8gYSB2ZXJ5IHVu
ZGVyIHV0aWxpemVkIGV4dGVudCBhbmQgd2UNCj4+IGhhdmUgbm8gd2F5IHRvIHVzZSBkZWZy
YWcgdG8gcHJvcGVybHkgcmVjbGFpbSBpdHMgd2FzdGVkIHNwYWNlOg0KPj4NCj4+ICAgICMg
bWtmcy5idHJmcyAtZiAkZGV2DQo+PiAgICAjIG1vdW50ICRkZXYgJG1udA0KPj4gICAgIyB4
ZnNfaW8gLWYgLWMgInB3cml0ZSAwIDEyOE0iICRtbnQvZm9vYmFyDQo+PiAgICAjIHN5bmMN
Cj4+ICAgICMgYnRyZnMgZmlsZXN5c3RlbSBkZWZyYWcgJG1udC9mb29iYXINCj4+ICAgICMg
c3luYw0KPiANCj4gSSBkb24ndCBzZWUgd2hhdCdzIHdyb25nIHdpdGggdGhpcyBleGFtcGxl
LCBhcyBGaWxpcGUgbm90ZWQgdGhlcmUncyBhDQo+IHRydW5jYXRlIG1pc3NpbmcsIGJ1dCBz
dGlsbCB0aGlzIHNob3VsZCBiZSBleHBsYWluZWQgYmV0dGVyLg0KDQpTb3JyeSwgdGhlIGZ1
bGwgZXhwbGFuYXRpb24gbG9va3MgbGlrZSB0aGlzOg0KDQpBZnRlciBhYm92ZSB0cnVuY2F0
aW9uLCB3ZSB3aWxsIGdvdCB0aGUgZm9sbG93aW5nIGZpbGUgZXh0ZW50IGxheW91dDoNCg0K
CWl0ZW0gNiBrZXkgKDI1NyBFWFRFTlRfREFUQSAwKSBpdGVtb2ZmIDE1ODEzIGl0ZW1zaXpl
IDUzDQoJCWdlbmVyYXRpb24gNyB0eXBlIDEgKHJlZ3VsYXIpDQoJCWV4dGVudCBkYXRhIGRp
c2sgYnl0ZSAyOTg4NDQxNjAgbnIgMTM0MjE3NzI4DQoJCWV4dGVudCBkYXRhIG9mZnNldCAw
IG5yIDQwOTYgcmFtIDEzNDIxNzcyOA0KCQlleHRlbnQgY29tcHJlc3Npb24gMCAobm9uZSkN
Cg0KVGhhdCB3b3VsZCBiZSB0aGUgbGFzdCA0SyByZWZlcnJpbmcgdGhhdCAxMjhNIGV4dGVu
dCwgYWthLCB3YXN0ZWQgDQooMTI4TS00SykgYnl0ZXMsIG9yIDk5LjY5NSUgb2YgdGhlIGV4
dGVudC4NCg0KTm9ybWFsbHkgd2UgZXhwZWN0IGRlZnJhZyB0byBwcm9wZXJseSByZS1kaXJ0
eSB0aGUgZXh0ZW50IHNvIHRoYXQgd2UgY2FuIA0KZnJlZSB0aGF0IDEyOE0gZXh0ZW50Lg0K
QnV0IGRlZnJhZyB3b24ndCB0b3VjaCBpdCBhdCBhbGwsIG1vc3RseSBkdWUgdG8gdGhlcmUg
aXMgbm8gbmV4dCBleHRlbnQgDQp0byBtZXJnZS4NCg0KPiANCj4gSXMgdGhpcyB0aGUgcHJv
YmxlbSB3aGVuIGFuIG92ZXJ3cml0dGVuIGFuZCBzaGFyZWQgZXh0ZW50IGlzIHBhcnRpYWxs
eQ0KPiBvdmVyd3JpdHRlbiBidXQgc3RpbGwgb2NjdXB5aW5nIHRoZSB3aG9sZSByYW5nZSwg
YWthLiBib29rZW5kIGV4dGVudD8NCj4gSWYgeWVzLCBkZWZyYWcgd2FzIG5ldmVyIG1lYW50
IHRvIGRlYWwgd2l0aCB0aGF0LCB0aG91Z2ggd2UgY291bGQgdXNlDQo+IHRoZSBpbnRlcmZh
Y2UgZm9yIHRoYXQuDQoNCklmIHdlIGRvbid0IGdvIGRlZnJhZywgdGhlcmUgaXMgcmVhbGx5
IG5vIGdvb2Qgd2F5IHRvIGRvIGl0IHNhZmVseS4NCg0KU3VyZSB5b3UgY2FuIGNvcHkgdGhl
IGZpbGUgdG8gYW5vdGhlciBub24tYnRyZnMgbG9jYXRpb24gb3IgZGQgaXQuDQpCdXQgdGhh
dCdzIG5vdCBzYWZlIGlmIHRoZXJlIGlzIHN0aWxsIHNvbWUgcHJvY2VzcyBhY2Nlc3Npbmcg
aXQgZXRjLg0KDQo+IA0KPiBBcyBBbmRyZWkgcG9pbnRlZCBvdXQsIHRoaXMgaXMgbW9yZSBs
aWtlIGEgZ2FyYmFnZSBjb2xsZWN0aW9uLCBnZXQgcmlkDQo+IG9mIGV4dGVudCB0aGF0IGlz
IHBhcnRpYWxseSB1bnJlYWNoYWJsZS4gRGV0ZWN0aW5nIHN1Y2ggZXh0ZW50IHJlcXVpcmVz
DQo+IGxvb2tpbmcgZm9yIHRoZSB1bnJlZmVyZW5jZWQgcGFydCBvZiB0aGUgZXh0ZW50IHdo
aWxlIGRlZnJhZ21lbnRhdGlvbg0KPiBkZWFscyB3aXRoIGxpdmUgZGF0YS4gVGhpcyBjb3Vs
ZCBiZSBhIG5ldyBpb2N0bCBlbnRpcmVseSB0b28uIEJ1dCBmaXJzdA0KPiBJJ2QgbGlrZSB0
byBrbm93IGlmIHdlJ3JlIHRhbGtpbmcgYWJvdXQgdGhlIHNhbWUgdGhpbmcuDQoNClllcywg
d2UncmUgdGFsa2luZyBhYm91dCB0aGUgYm9va2VuZCBwcm9ibGVtLg0KQXMgSSB3b3VsZCBl
eHBlY3QgZGVmcmFnIHRvIGZyZWUgbW9zdCwgaWYgbm90IGFsbCwgc3VjaCBib29rZW5kIGV4
dGVudHMuDQooQW5kIHRoYXQncyBleGFjdGx5IHdoYXQgSSByZWNvbW1lbmQgdG8gdGhlIGlu
aXRpYWwgcmVwb3J0KQ0KDQpUaGFua3MsDQpRdQ0K
--------------aa06AkHBF6wO0qwJ5mX9PFOx
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------aa06AkHBF6wO0qwJ5mX9PFOx--

--------------mLfJ3nj08QKtJbPQ6EgNrNjU--

--------------QeZQoj7hciikZpF2uFe3I7dn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWfia8FAwAAAAAACgkQwj2R86El/qi/
jwf9H83H6pbckL5fP53/ngD+cbe8KPlwVlUb6mGRnJv3UIyZof+DloZY9Un9RFTJ9sHdTnu8XA8M
ohUcbJsi5lIs5LPajsR/N3g0WHRErZxdCQtlBG4/d2I/lgVTA87da2dh8OzPIJHkiFaf6vCtVW86
F+7Ltf0n+szeDV/K4nyxbdfPQraClXGC9OHjAPMAC5v/I9RiaiUBKOJo8a4poxFTHo8m5Ek+zS1o
Og+oLDyDfqFm2C55uN0DwzKF3EpMRqommcNUXLnXl0GMG4muSK5fKA/S7a8ElbDpMfOx8xwc51fP
L2HVxigjMldBW8g4nIe77uOfoUBG1bpCb3+upR72Ig==
=yFZX
-----END PGP SIGNATURE-----

--------------QeZQoj7hciikZpF2uFe3I7dn--

