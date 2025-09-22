Return-Path: <linux-btrfs+bounces-17096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EDB92972
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD02A533E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F131961F;
	Mon, 22 Sep 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5JkgbW5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3B3191D9
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758565494; cv=none; b=B+jyr1tLSQbT+MFFaQHqChyVwl2Vs/aVaMVZVf5x1HyrdUR1koko9Uz1Cb4sNkv/sxKud6PuldNRgPhPsnTVVs5cR+jXluaqgZYIsJNQ+14AfgQ4CDdAFACT/rhPJt2VDSNCI5VkLcX8LF49O55kbOAT7FFn8eBm2w492mubg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758565494; c=relaxed/simple;
	bh=zAQ4dJulK65P6h0p9xWy59DpngqmesaV4Nos8H5HOM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mg5Q4NIyN70iPBJTwgwb0L/ryQHgcSKhaz5ebIAMFzJxmgos9MduIsFIbamEH0JddqR/wdppgBT8p8TX106cioDl2tcdiFSl7mhG9mOe128APcZAtZ2iglMJtfP/qigLP9yl40AZIpFY2uehT48RhVyy6TS0EYniqeZIM/oLl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5JkgbW5; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-635380a4a67so965956d50.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758565492; x=1759170292; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crZ9pRCtuSD0nm7Wfp2VN9g0EeUiHwpKlZdOVpn+LyY=;
        b=V5JkgbW5MOqk8TwxCugQyAMj/VOkyUljIaVgZ34poPwyPb0JNGefFCFxjbsI1IlBhd
         tUvUUWEMvqC68+7LeZ4X5afvEsF0QRn929NuLGHwbAlXMcub3EO3SoM9/KgSOdUaJvT3
         U17887cYZ8O8M37p23qhbjcFMSkWReO8SwV3HVrNqrdpNBs4DZLn3ALOSWQu9SEJyMvW
         z83zDXKkX5JMaUORMoyJro8VGlAxNjGesu3QMpaatmiSJWcDab6vc7eppYZCwReP7YuM
         XH+esST8HGJPLVoVhJOR3RrEcofjm/1uawB89bKrzIfRReSdMJ90ZeCUOXUt2uDPnIqe
         u7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758565492; x=1759170292;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=crZ9pRCtuSD0nm7Wfp2VN9g0EeUiHwpKlZdOVpn+LyY=;
        b=DDNl40zmA8xxSR9SUbLMoI7rmswLLroK028ckO8ZoR+apzV78vvLSFnWJt1uBf2gho
         4dY2Wa2WBo2m3fVms2YLhr2jUkai9aeU7Q8KTBYk0u+zNdPmb0dxg2EKyEzlyjGV5r5/
         8BN/r3U9g77xOZU4RbqxsFTrwsvim4ER0RFWK749K39GhqMamYJAZwEA0uRzfe1Hgsu/
         eRCJHbN4A6oSxayLqTrsK+BpZkyF89QMEd6BVMRjVs5pYSTp15HQOAbY66pTI0kn8SfL
         m5zpYP0+sFXd4L+Ceqod82BKk8URV3UVyZWNePeD3wa/l5OLABRdhZu8T45x033wdWIu
         udig==
X-Forwarded-Encrypted: i=1; AJvYcCUcP4IjP/I4wX0WzSSr2jbbshtEjNEwyBC+l0vMsKGMavjYY8Jf5CtAMlgT/VUCiIK4N9ldepNzEo8N4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Kux9oM01+n6mANOoTD7+u+tbYHAlXEDGf+rRFMrUskBiqumm
	i4tk52iNOxX7UmKbv9Z8tvuK7a+rEe8eq7ag7IQSHrzGZROr0M9pSrKMRsNnQQ==
X-Gm-Gg: ASbGnctsLGPEA8HIDeDbRGKR0fK7ElQEFZfeeYsNV2BCq99UZdtwr3faeS+hOI1YnGY
	RKb9UMOmmDgBS4fe3aKChp7lGtDz115bi5tl38Zibk6w2uM3mfdual6/EcrpZjrl9udwwZHbBbo
	lxbGvNFEWKX6NHGFQpYb8bP1ig4vJvNizWlAxRlsVjhW9RPh6+cSil0GXZNjDHU0PTX8zVIhYrs
	nO/5au+BS36iNPce7BE7AIEDjfAnHJUxhMgc8IptBHcTal9XSB6RPGr/54A73rKYqlJw7R2brle
	+zLrOcMwc6BJSAeux3VGtqkr1WwePtHvNns9ebjbdwIUyTf3QaKOVc8HBec6oxYUnGivhm/tRHH
	xDUkqQjZnPoTyz8PmPaBa+Y5Ho910lqEeiBHu57Kwxb5bMVr8vqXWMzaoiEikEx85OH01hSuUo6
	04cQEvCWg4tGYDitabwlWwcE6oIvpRDLl/X3g=
X-Google-Smtp-Source: AGHT+IF2EPbslkay6NZTY7QLYr4RN9J47VAzsb3/YkJ1S43jyy09jQTBWgV1Ov6rUC783p2ZumyxRw==
X-Received: by 2002:a05:690e:255c:b0:635:4ed0:5714 with SMTP id 956f58d0204a3-63604664ca0mr9319d50.46.1758565491793;
        Mon, 22 Sep 2025 11:24:51 -0700 (PDT)
Received: from [10.138.34.110] (h96-60-249-169.cncrtn.broadband.dynamic.tds.net. [96.60.249.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73971700944sm36002407b3.28.2025.09.22.11.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 11:24:51 -0700 (PDT)
Message-ID: <e4423bc0-38e8-4f61-9cd9-c3d9c00308ab@gmail.com>
Date: Mon, 22 Sep 2025 14:24:45 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <62a97fb7-75e3-4832-b97c-90763b287a5c@gmx.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <62a97fb7-75e3-4832-b97c-90763b287a5c@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RKb4RqVOMWHmJZGmaPNUyFA0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RKb4RqVOMWHmJZGmaPNUyFA0
Content-Type: multipart/mixed; boundary="------------IU0ZKVykLT76rD0V09lI7G4F";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <e4423bc0-38e8-4f61-9cd9-c3d9c00308ab@gmail.com>
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <62a97fb7-75e3-4832-b97c-90763b287a5c@gmx.com>
In-Reply-To: <62a97fb7-75e3-4832-b97c-90763b287a5c@gmx.com>

--------------IU0ZKVykLT76rD0V09lI7G4F
Content-Type: multipart/mixed; boundary="------------tB25og42jT00ZLWuuZDVmAa8"

--------------tB25og42jT00ZLWuuZDVmAa8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/21/25 20:50, Qu Wenruo wrote:
>=20
>=20
> =E5=9C=A8 2025/9/22 09:37, Demi Marie Obenour =E5=86=99=E9=81=93:
>> Wyng Backup (https://codeberg.org/tasket/wyng-backup) relies on FIEMAP=

>> to determine which parts of a file have not changed since it was last
>> backed up.  Specifically, the output of filefrag -v is passed to sort =
and
>> then to uniq, and differences between the outputs for the file and
>> the previous version (a reflink copy) determine what gets backed up.
>>
>> Is this safe under BTRFS,
>=20
> No. There are several factors affecting this, some are minor some are n=
ot:
>=20
> - Inlined extents
>    The returned bytenr is unreliable in that case.
>    Although the fiemap flags should indicate that, with 'inline' flag
>    set.
>=20
> - Balance
>    Btrfs can balance the data extents, which will result the change of
>    the fiemap.
>=20
>    E.g.
>    ## Before balance
>    # md5sum  /mnt/btrfs/foobar
>    27c9068d1b51da575a53ad34c57ca5cc  /mnt/btrfs/foobar
>    # filefrag -v /mnt/btrfs/foobar
>    Filesystem type is: 9123683e
>    File size of /mnt/btrfs/foobar is 65536 (8 blocks of 8192 bytes)
>     ext:     logical_offset:        physical_offset: length:   expected=
:=20
> flags:
>       0:        0..       7:       1664..      1671:      8:=20
> last,eof
>    /mnt/btrfs/foobar: 1 extent found
>=20
>    ## Do data balance
>    # btrfs balance start -d /mnt/btrfs/
>    Done, had to relocate 1 out of 3 chunks
>=20
>    ## After data balannce
>    # filefrag -v /mnt/btrfs/foobar
>    Filesystem type is: 9123683e
>    File size of /mnt/btrfs/foobar is 65536 (8 blocks of 8192 bytes)
>      ext:     logical_offset:        physical_offset: length:=20
> expected: flags:
>       0:        0..       7:      36480..     36487:      8:=20
> last,eof
>    /mnt/btrfs/foobar: 1 extent found
>=20
>=20
> - NODATACOW cases.
>    In that case new data is written into the same location, without any=

>    extra new data extents. This completely breaks the assumption.
>=20
> - Dirty data that is not yet written into the disk
>    In that case fiemap won't show those data but only the ones that are=

>    on the disk.
>=20
>> or can it result in data loss due to data
>> not being backed up that should be?  In other words, can it result
>> in data being considered unchanged when it really is?
>=20
> Dirty data and NODATACOW will result data being considered unchanged=20
> using fiemap only.
>=20
> And balance will make the unchanged data to be considered changed.
>=20
> So overall, fiemap based solution on btrfs is unreliable.

Can one implement this reliably with TREE_SEARCH_V2 or by parsing
the output of `btrfs send`?  Using `btrfs receive` to apply deltas
might work, but the backups must be encrypted with a key the
destination doesn't have, and that means the backups must be
opaque to the remote.  Therefore, I think periodic full backups
with incremental backups on top of them (each containing the hash
of the last) is the best that could be done.  This means that old
backups cannot be garbage-collected without taking a full backup
first.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------tB25og42jT00ZLWuuZDVmAa8
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------tB25og42jT00ZLWuuZDVmAa8--

--------------IU0ZKVykLT76rD0V09lI7G4F--

--------------RKb4RqVOMWHmJZGmaPNUyFA0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmjRlG4ACgkQszaHOrMp
8lNj+BAAoSQ6MEBbWH91rTYqT4WlvCBgciEe5Vq7kdmG2ooLgb0nlZaiq/DJt8Ju
RqocRVVkjjPCsjdpT/ChttlQ5NTqgGoTOQJROdCmQjL6SzbM2pIeh7xmQC0GZZB2
4k/ihov7abidFLqyWezRs9FxiP49DB6aGn9gfMTezM4wK5UsNHi60WmVv6/AgN3n
JAiwBRAHIA7r0DEuVJLBMdUWXu8DbMKMLupCxLP1BDsQqoWLJYeBr/6QfRdQBhol
CCIf8rH63NmQlcormYvyGDhEPlmoSelg/z7b3bRMvRoiaZbqzDYQAQnyyDbXY2wO
5OCk0EUUB6EYdHIvVF4RmD+d0XaRhqw2tl/7Gx+86UBHy9Uc5jQAeVvg9OFgz8Yc
K6owk/OtjGoaHJehyz4qw4T5okcSUPm3GmNchOlP3cvpC57rOnL/o0qyM+eKVWEg
0pTzF6jOeEZ/cNUbBFgd0jZgz1DCsdyQSvEsXBcIsnNdQbkUDmbLcb/E4Z4OY7Q+
rN6FT/fL8uneO7V3AIW029K1v5AcFSCmEQGgXH4RCJK2eIAXZEyUDOwDE2ijc6e+
CmcKcHojE2QA2fGOPwmlyKP7R55nQ0I9bCaPFO6GeBsjXgI+YSeCI0k6TwJCxtGh
2I5SzXg/zphxyBgQ1ss+rYS7VdhcCj8wk0KF/Mt1xJptrhPIyRU=
=jZSh
-----END PGP SIGNATURE-----

--------------RKb4RqVOMWHmJZGmaPNUyFA0--

