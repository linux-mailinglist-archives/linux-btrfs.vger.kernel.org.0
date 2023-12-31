Return-Path: <linux-btrfs+bounces-1173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B30F820F84
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Dec 2023 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47F8B20CD6
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Dec 2023 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E54C15E;
	Sun, 31 Dec 2023 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V4Bbfdg/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E68C13B
	for <linux-btrfs@vger.kernel.org>; Sun, 31 Dec 2023 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccbc328744so62586461fa.3
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Dec 2023 14:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704060870; x=1704665670; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=opayyExnC7XOWu0TnpH+gpljH3h5as+cqnAOh/v4MsU=;
        b=V4Bbfdg/gXNOx3vnvKC2chJhbMIHwvJlAao4AcY4fkb0dQDnklVQ4JhVeJzoC3uoty
         VbKEeAmvYQtI+HSPXHBIqQ0e4GaQ9B9ndh3vh29QzvynpjUO/JIFG2ueYQ9heGknpDwl
         uqTa1nOl7QNj6kIOKNAH7II0AM9xEU8e2DUZWAGJurIhXPkCNTyXR4WC8MTExhaYDmlA
         ViDlAN/JhajSI9mHAJPzOu80V/Id38jWMAbpYX01Ol1QiHroVSDYNop8X0m2etQN1ZWv
         4sTTk63EJZ0i/edQKIHDlAZLAlGHE1J/VYPvqv3BnnpmCtiMDV2rZs/StCW4Z4GM0niq
         T5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704060870; x=1704665670;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opayyExnC7XOWu0TnpH+gpljH3h5as+cqnAOh/v4MsU=;
        b=aucJT5Pr8kobNKQIInqbBn9wZRmxzASEMpMNBodN6+4yD9gtajpdO76WXiXbyeii6x
         4h+XU9XM9FHDL+QQ1bhuJ0MqpinobsIROSI3uvcYQT5b11sr37SoZHAfKeXU0B7Sez90
         VCcLk6+0NWeHxxbFQUFC23lUJ93RSfBgtl/9HZaT6XcX7uZmVCz0ktp+oVfrZ14lmjvV
         kRuzxdfMkNG2rtZGGvD7NciazbLt0tHfXTjKEyc8DhvdTXim6XkaIg2UCElbDblyoWtA
         J2d6vCxvupmjmQrvrGglTIroHcL9d9Tr5LvTT9GTw5AlGtuP9YcJNTXSuPMJFCH5jGKl
         FnnQ==
X-Gm-Message-State: AOJu0YyKnGm1Y39o22r3RuKBnTEr18pgbQ9+8h6Sh+jnqT9AiHmPWiVM
	GDARgSJ4NCO9TAoWgvBEa+dsELJ/68/ITA==
X-Google-Smtp-Source: AGHT+IE+GUBAkOye4Jp8XePn755esy/yaoz+oq0/dqbANRPYKMPiWCX/OslKnsX19ZsSARaD0cNvxQ==
X-Received: by 2002:a2e:900d:0:b0:2cc:7a49:7f30 with SMTP id h13-20020a2e900d000000b002cc7a497f30mr6476004ljg.71.1704060870457;
        Sun, 31 Dec 2023 14:14:30 -0800 (PST)
Received: from ?IPV6:2001:4479:aa02:8c00::959? ([2001:4479:aa02:8c00::959])
        by smtp.gmail.com with ESMTPSA id b16-20020a170903229000b001cc1dff5b86sm18952313plh.244.2023.12.31.14.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 14:14:29 -0800 (PST)
Message-ID: <cea1fa09-df9c-4234-9b00-941d07afb706@suse.com>
Date: Mon, 1 Jan 2024 08:44:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: remove test case btrfs/131
Content-Language: en-US
To: Neal Gompa <neal@gompa.dev>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <f09fb4edd69cf42fbb816e806384f79340e9d2b4.1703979415.git.wqu@suse.com>
 <CAEg-Je9vT-VwVtkqj2pszP08kmk9npPkf-OsSwe3G93m0YsxXw@mail.gmail.com>
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
In-Reply-To: <CAEg-Je9vT-VwVtkqj2pszP08kmk9npPkf-OsSwe3G93m0YsxXw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pN4viZBgWEIy5ehQjRi0wyIp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pN4viZBgWEIy5ehQjRi0wyIp
Content-Type: multipart/mixed; boundary="------------GMqN1yY8xaC5SZK0v0mOstJ5";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: Neal Gompa <neal@gompa.dev>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <cea1fa09-df9c-4234-9b00-941d07afb706@suse.com>
Subject: Re: [PATCH] fstests: btrfs: remove test case btrfs/131
References: <f09fb4edd69cf42fbb816e806384f79340e9d2b4.1703979415.git.wqu@suse.com>
 <CAEg-Je9vT-VwVtkqj2pszP08kmk9npPkf-OsSwe3G93m0YsxXw@mail.gmail.com>
In-Reply-To: <CAEg-Je9vT-VwVtkqj2pszP08kmk9npPkf-OsSwe3G93m0YsxXw@mail.gmail.com>

--------------GMqN1yY8xaC5SZK0v0mOstJ5
Content-Type: multipart/mixed; boundary="------------ppjaGu1AHWRc9UvUmOI5eA2p"

--------------ppjaGu1AHWRc9UvUmOI5eA2p
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjQvMS8xIDAwOjQyLCBOZWFsIEdvbXBhIHdyb3RlOg0KPiBPbiBTYXQsIERl
YyAzMCwgMjAyMyBhdCA2OjM34oCvUE0gUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+IHdyb3Rl
Og0KPj4NCj4+IFRlc3QgY2FzZSBidHJmcy8xMzEgaXMgYSBxdWljayB0ZXN0cyBmb3IgdjEv
djIgZnJlZSBzcGFjZSByZWxhdGVkDQo+PiBiZWhhdmlvciwgaW5jbHVkaW5nIHRoZSBtb3Vu
dCB0aW1lIGNvbnZlcnNpb24gYW5kIGRpc2FibGluZyBvZiB2MiBzcGFjZQ0KPj4gY2FjaGUu
DQo+Pg0KPj4gSG93ZXZlciB0aGVyZSBhcmUgdHdvIHByb2JsZW1zLCBtb3N0bHkgcmVsYXRl
ZCB0byB0aGUgdjIgY2FjaGUgY2xlYXJpbmcuDQo+Pg0KPj4gLSBUaGVyZSBhcmUgc29tZSBm
ZWF0dXJlcyB3aXRoIGhhcmQgZGVwZW5kZW5jeSBvbiB2MiBmcmVlIHNwYWNlIGNhY2hlDQo+
PiAgICBJbmNsdWRpbmc6DQo+PiAgICAqIGJsb2NrLWdyb3VwLXRyZWUNCj4+ICAgICogZXh0
ZW50LXRyZWUtdjINCj4+ICAgICogc3VicGFnZSBzdXBwb3J0DQo+Pg0KPj4gICAgTm90ZSB0
aG9zZSBmZWF0dXJlcyBtYXkgZXZlbiBub3Qgc3VwcG9ydCBjbGVhcmluZyB2MiBjYWNoZS4N
Cj4+DQo+PiAtIFRoZSB2MSBmcmVlIHNwYWNlIGNhY2hlIGlzIGdvaW5nIHRvIGJlIGRlcHJl
Y2F0ZWQNCj4+ICAgIFNpbmNlIHY1LjE1IHRoZSBkZWZhdWx0IG1rZnMgaXMgYWxyZWFkeSBn
b2luZyB2MiBjYWNoZSBpbnN0ZWFkLg0KPj4gICAgSXQgd29uJ3QgYmUgbG9uZyBiZWZvcmUg
d2UgbWFyayB2MSBjYWNoZSBkZXByZWNhdGVkIGFuZCBmb3JjZSB0bw0KPj4gICAgZ28gdjIg
Y2FjaGUuDQo+Pg0KPj4gVGhpcyBtYWtlcyB0aGUgdGVzdCBjYXNlIHRvIGZhaWwgdW5uZWNl
c3NhcmlseSwgdGhlIGZhbHNlIGZhaWx1cmUgd291bGQNCj4+IG9ubHkgZ3JvdyB3aXRoIG5l
dyBmZWF0dXJlcyByZWx5aW5nIG9uIHYyIGNhY2hlLg0KPj4NCj4+IFNvIGhlcmUgbGV0J3Mg
cmVtb3ZpbmcgdGhlIHRlc3QgY2FzZSBjb21wbGV0ZWx5Lg0KPj4NCj4gDQo+IENhbiB3ZSBw
YWlyIHRoaXMgY2hhbmdlIHdpdGggYSBjb3JyZXNwb25kaW5nIGNoYW5nZSBpbiBidHJmcy1w
cm9ncw0KPiB0aGF0IGJsb2NrcyB1c2luZyB2MT8gSSBkb24ndCB0aGluayBpdCdzIGFjdHVh
bGx5IHdvcnRoIHNwbGl0dGluZyB0aGlzDQo+IGNoYW5nZSB1cCBpbiBwaGFzZXMsIGVzcGVj
aWFsbHkgd2hlbiB3ZSdyZSBleHBsaWNpdGx5IGRyb3BwaW5nIHRoZQ0KPiB0ZXN0cyBhcm91
bmQgaXQuDQoNClRoYXQgc291bmRzIHByZXR0eSByZWFzb25hYmxlLg0KDQpJJ2xsIGNyYWZ0
IG9uZSB0byBkZXByZWNhdGUgdjEgY2FjaGUgaW4gcHJvZ3MgdG9vLg0KDQpUaGFua3MsDQpR
dQ0KPiANCj4gDQo=
--------------ppjaGu1AHWRc9UvUmOI5eA2p
Content-Type: application/pgp-keys; name="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC23D91F3A125FEA8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SBugJZ66ww=3D=3D
=3D/5yp
-----END PGP PUBLIC KEY BLOCK-----

--------------ppjaGu1AHWRc9UvUmOI5eA2p--

--------------GMqN1yY8xaC5SZK0v0mOstJ5--

--------------pN4viZBgWEIy5ehQjRi0wyIp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEELd9y5aWlW6idqkLhwj2R86El/qgFAmWR58EFAwAAAAAACgkQwj2R86El/qhu
5gf8DGoRTqsyfZl/z+rGRcsCauNMloIOTjZZYNaePCH8rrOfuuhjzqSlU1rNSoLQ58eGDywrGzfn
nqD5YC0IKBPYU3Tkd4aAJXeGXIrcwxScnpPOdaCxhmTt4hCZyXOXEQxGYNQObHx9kLZZIISXuQdO
Kpkc1WoUPTu057Z8MQQbcni9GZReawnuiEXJ0Yb3f8fQMAGCkkcW/n38hHcVZ6j2ZhCBTA8dhv4A
so6EGFprxWeG7YyHQUS7/2ZQWDdhAh8s3IYgsnQsdudwkH+6jtud5wTgbpQqK6FV8WK+NTrdFKSP
YlVLJHRYrIUcNKqrTc7tKyNYr4OoiEXR3tLOTTt+Hw==
=wB+B
-----END PGP SIGNATURE-----

--------------pN4viZBgWEIy5ehQjRi0wyIp--

