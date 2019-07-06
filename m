Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2C611CF
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfGFPJu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jul 2019 11:09:50 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44476 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfGFPJu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Jul 2019 11:09:50 -0400
Received: by mail-wr1-f41.google.com with SMTP id p17so1486405wrf.11
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jul 2019 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=nFuWTybZy2vQP8v8dunWE/7o7Mn2pW44q081UQuU/CY=;
        b=lKtWXShX6wK5aObiceIX/h65kGKGNX1FS9oP4ugmPAZBc3LXCHgKk35oG8MlcRnWez
         lNqs0Ee6p7xIHu1Gga408XqDcUK/t/yRQKtHq/GMi1Pxc3WRswerbzCDeOsgh9jPXGoH
         jvMuVb9qKossWYr5Egviq5o2rznB5K4X4PQ8n1pVBiCgNX7icD29PHsPhfr6mki13IP3
         n6yvkbhJWNKJFxElq5hRrVoeV7gl0svBDVHNanvayjLz1yLtoFxG8WjTDyDOz+1lPDcx
         oTU+uhWtoznWHiyCl8WzkQ+AOOLaWa+4ped9XybhX9PXdQnU0Z+Pbx+jmFzxhPJBDXWf
         fZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=nFuWTybZy2vQP8v8dunWE/7o7Mn2pW44q081UQuU/CY=;
        b=jfxsKDM0r/W51gSqhPJz02Zohh3zGJqBEkh9B+EXeqvWcVfumVbTAUnR0Oi1g3VEFi
         G3pynWG4ZyB61wIE2wVFmXrJkh9jITYQyRe93vHwgnfPOkuvtt7sjk+HBZ+ZY2H1Vtoa
         P7Y4L71Lk0J11540Y6lIft2pK3rTLKziUFDiD6LDP4snU35n0+/qP2OxPyW97qG2x4uM
         77Z0vCumQk01SuScVrAGO6/GkzqBkIHFZ8N4cwG1AXnyVvrCdt63innoRzIbpGL0f6Ma
         sL1XxX58zhNPTs6rdHaX8bnTgJV/EOLFVJSqpy6OuLoro1fFe4JITGMM0gfMX+CmsC/n
         RjcQ==
X-Gm-Message-State: APjAAAWFGeo2e5Q0ChkIrLwXcXGGcaW8XfVwEObXP4WxwvCk1YJRBO0u
        zznMS0KtJJgQy0MgfLYVuY4kbflkTi8=
X-Google-Smtp-Source: APXvYqzSZZjblESYUmFXwwQRChCioHoqLqGe21xwSooF3VOna7vACwYXb+LOn31d/VlyJ2sVFAwscg==
X-Received: by 2002:a05:6000:145:: with SMTP id r5mr320223wrx.208.1562425787476;
        Sat, 06 Jul 2019 08:09:47 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id s10sm15481070wmf.8.2019.07.06.08.09.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 08:09:46 -0700 (PDT)
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
 <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
 <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thecybershadow@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFar2yQBCADWo1C5Ir1smytf7+vWGCEoZgb/4XKkxrp+GUO7eJO8iYCWHTmCPZpi6p/z
 y6eh+NYcDQSRzKA99ffgdN+aT8/L6d63pYdsgtDmX/yrFWyLOVgW62LQpC/To4MTJAIgY/Rg
 /VjdifOJtYFvr+BKJwFCTfcviy4EQjsfHLnyJjvL9BiCXfSBXASc/Gn9WOTL5ZNpk4TStGXO
 +/2PIKeg228LtJ5vc/vemBo4hcjJv9ttX7dCebpSAbNo7GgOs8XNgJU2mEcra3IMT15dGk0/
 KpGMx7bMinTIlxx/BAGt5M5w8OnNi4p2AcKzvH18OTE7Lssn5ub8Ains32hbUFf18hJbABEB
 AAG0K1ZsYWRpbWlyIFBhbnRlbGVldiA8Z3BnQHRoZWN5YmVyc2hhZG93Lm5ldD6JAVEEEwEI
 ADsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AWIQS77RsIjO1/lYkX++hQBPD60FFXbQUC
 WJ9eKQIZAQAKCRBQBPD60FFXbX0yB/9PEcY3H9mEZtU1UVqxLzPMVXUX5Khk6RD3Jt8/V7aA
 vu8VO4qwmnhadRPHXxVwnnVotao9d5U1zHw0gDhvJWelGRm52mKAPtyPwtBy4y3oXzymLfOM
 RIZxwxMY5RkbqdgWNEY7tCplABnWmaUMm5qDIjzkbEabpiqGySMy2gy6lQHUdRHcgFqO+ceZ
 R7IOPEh2fnVuQc5t1V56OHHRQZMQLgGupInST+svryv2sfr5+ZJqtwWL3nn8aFER6eIWzDDu
 m9y2RZnykbfwd56c81bpY6qqZtHkyt0hImkOwOiBj3UWtJvgZ95WnJ8NBPHPcttgL3vQTsXu
 BRYEjQZln81tuQENBFar2yQBCADFGh8NqHMtBT8F4m/UzQx0QAMDyPQN3CjKn67gW//8gd5v
 TmZCws2TwjaGlrJmwhGseUkZ368dth5vZLPu95MVSo2TBGf+XIVPsGzX6cuIRNtvQOT5YSUz
 uOghU0wh5gjw7evg7d0qfZRTZ2/JAuWmeTvPl66dasUoqKxVrq5o2MXdYkI6KoSxTsal3/36
 ii5cl2GfzE+bVAj3MB8B0ktdIZCHAJT8n+8h10/5TD5oEkWjhWdATeWMrC2bZwFykgSKjY/3
 jUvmfeyJp56sw5w3evZLQdQCo+NWoFGHdHBm0onyZbgbWS+2DEQI+ee0t6q6/iR1tf8VPX2U
 LY0jjiZ7ABEBAAGJAR8EGAEIAAkFAlar2yQCGwwACgkQUATw+tBRV200GQf8CaQxTy7OhWQ5
 O47G3+yKuBxDnYoP9h+T/sKcWsOUgy7i/vbqfkJvrqME8rRiO9YB/1/no1KqXm+gq0rSeZjy
 DA3mk9pNKvreHX9VO1md4r/vZF6jTwxNI7K97T34hZJGUQqsGzd8kMAvrgP199tXGG2+NOXv
 ih44I0of/VFFklNmO87y/Vn5F8OfNzwiHLNleBXZ1bMp/QBMd3HtahZVk7xRMNAKYqkyvI/C
 z0kgoHYP9wKpSmbPXJ5Qq0ndAJ7KIRcIwwDcbh3/F9Icj/N3v0SpxuJO7l0KlXQIWQ7TSpaO
 liYT2ARnGHHYcE2OhA0ixGV3Y3suUhk+GQaRQoiytw==
Message-ID: <961c2cca-8e06-fb74-2462-d2d1eb014193@gmail.com>
Date:   Sat, 6 Jul 2019 15:09:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BDFVxH2YkZpPWqGyRqWTaPG5rQemDq50q"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BDFVxH2YkZpPWqGyRqWTaPG5rQemDq50q
Content-Type: multipart/mixed; boundary="EHfwkUcZm4BOcn5t2hCwgu5CnHSTl8Y5u";
 protected-headers="v1"
From: Vladimir Panteleev <thecybershadow@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <961c2cca-8e06-fb74-2462-d2d1eb014193@gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
 <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
 <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>
In-Reply-To: <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>

--EHfwkUcZm4BOcn5t2hCwgu5CnHSTl8Y5u
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/07/2019 05.51, Qu Wenruo wrote:
>> The problem also manifests when attempting to rebalance the metadata.
>=20
> Have you tried to balance just one or two metadata block groups?
> E.g using -mdevid or -mvrange?

If I use -mdevid with the device ID of the device I'm trying to remove=20
(2), I see the crash.

If I use -mvrange with a range covering one byte past a problematic=20
virtual address, I see the crash.

Not sure if you had anything else / specific in mind. Here is a log of=20
my experiments so far:

https://dump.thecybershadow.net/da241fb4b6e743b01a7e9f8734f70d6e/scratch.=
txt

> And did the problem always happen at the same block group?

Upon reviewing my logs, it looks like for "device remove" it always=20
tries to move block group 1998263943168 first, upon which it crashes.

For "balance", it seems to vary - looks like there is at least one other =

problematic block group at 48009543942144.

Happy to do more experiments or test kernel patches. I have a VM set up=20
with a COW view of the devices, so I can do destructive tests too.

--=20
Best regards,
  Vladimir


--EHfwkUcZm4BOcn5t2hCwgu5CnHSTl8Y5u--

--BDFVxH2YkZpPWqGyRqWTaPG5rQemDq50q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEu+0bCIztf5WJF/voUATw+tBRV20FAl0gubkACgkQUATw+tBR
V23ADQgArNrC8r7VV2MEt0bwLAnMZMoM8cdnCAdUYAcVaXG5yw5GCgkyDpDr7MlV
NHsd8x6Mhp5W7myiQmCU7jvJIT6iECnN04xp0mOMhdA9EdCkrRtlbtUBcQ4pj5l0
M9Xcbjm0szTVJzSREK2ItScDTO+zUGsx4a23N9wrkzcvKsNGQVgrNuGC3pXb+fa6
LJj7amPmoE3+kjhBAht6gJFtSnhik6RFdwq1wPqgQZxWXcHW0GmN2W33PfBExCGe
cZy1WFvp8igrR9eh4Vf459AYLzjyDmxN70duzp4ZwA+FiJTVk1no0wULFGdBNJa4
6vr+3s089EtAQ6xG72vYPoB5XUKfKw==
=rAJU
-----END PGP SIGNATURE-----

--BDFVxH2YkZpPWqGyRqWTaPG5rQemDq50q--
