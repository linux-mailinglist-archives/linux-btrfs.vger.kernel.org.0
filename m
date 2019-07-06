Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C9660F0C
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 07:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfGFFNc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jul 2019 01:13:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39126 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGFFNc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Jul 2019 01:13:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so11469493wma.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 22:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=uS+cgZykdHI4s5jpjw3QHyjWHuH4Gl9UskMiHMpsIfQ=;
        b=vJZzMeyD05Bigu9q9kVAt+n5FzU/nZGUTd9ahsm/7ddZMupyqXP5MgiUhnXKPVp2kQ
         peKlPvOYEXUa7BDa9exsKY4qmYyIrtp7mjYd8DyKk7nEBrrult7ox1YlziGuzl8x0cTf
         /D1N3cPBswGv0NH6s8l2nyKn426Vv+wjROvQUut/4/znS4Yjk3rne21hBlXFaqY/mxI3
         MmUd0qWv33tVtyWcScL0mq79PghtFH+gsz1U323TgQPqoq1u0z77oqHS+8h1nZfYI/HT
         0Gk7QMH8Ran/7aHEYcD0eRXlAli7K83p4IOEnxNj8ZXaAzo7U0iZPFSDx95f0oQm/A0N
         y+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=uS+cgZykdHI4s5jpjw3QHyjWHuH4Gl9UskMiHMpsIfQ=;
        b=ARJvnc8xvEOjwJbEc2+FnZXCL2MlBl4umHHUUIZP6RRXraR74/7a7CBq67LKLoeJwL
         D89uz62Dg0UgSSsbG8x6r0PKgUZ/fWjUh1z0TiKEkAd6C9iK4X72LUuMxFVw1uFfvRxa
         HFObn/GQGOHMlAJYHEgH02nIj/W3ZUwvgL2ZgYCVZ9DWZTqIOZ3nnwzHNyhnVVzkhkdB
         TJuJKiOstGlP7Qvft1LOkyqmwAIsbO1n63XsHF59ePpcskFsInb45SYo0Qy+8zoouiTC
         af3TSQz1hc7QPCiP/iX67PCH0zTUuNAZD/JtpbRBoGGtkEClaJmaV6GVcy2YBkMeqbRM
         FYqQ==
X-Gm-Message-State: APjAAAXC29Nlx3WBkyzBvJ915MxDbijI095N5XbM7m3kuBpgLrH2Sae5
        dkTp3h9ah6uUW1/Bov6zuYrTVwK80WQ=
X-Google-Smtp-Source: APXvYqyH9vHyNDZ/qbH+fIuB2Y4YmQ7sl/3G88yxYoer/HVIf7kuN62EyJ5H2QWXYi0Y6GvESR4/vQ==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr5971079wml.157.1562390008673;
        Fri, 05 Jul 2019 22:13:28 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id h6sm11333607wre.82.2019.07.05.22.13.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 22:13:27 -0700 (PDT)
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
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
Message-ID: <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
Date:   Sat, 6 Jul 2019 05:13:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9PZyF3ZJhNGNm7L7EHr41n4KL1nC93pmB"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9PZyF3ZJhNGNm7L7EHr41n4KL1nC93pmB
Content-Type: multipart/mixed; boundary="8qIYkbt2CCjZkrWIElZp88do1vB1eZjh8";
 protected-headers="v1"
From: Vladimir Panteleev <thecybershadow@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
In-Reply-To: <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>

--8qIYkbt2CCjZkrWIElZp88do1vB1eZjh8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/07/2019 05.01, Qu Wenruo wrote:
>> After stubbing out btrfs_check_rw_degradable (because btrfs currently
>> can't realize when it has all drives needed for RAID10),
>=20
> The point is, btrfs_check_rw_degradable() is already doing per-chunk
> level rw degradable checking.
>=20
> I would highly recommend not to comment out the function completely.
> It has been a long (well, not that long) way from old fs level toleranc=
e
> to current per-chunk tolerance check.

Very grateful for this :)

> I totally understand for RAID10 we can at most drop half of its stripes=

> as long as we have one device for each substripe.
> If you really want that feature to allow RAID10 to tolerate more missin=
g
> devices, please do proper chunk stripe check.

This was my understanding of the situation as well; in any case, it was=20
a temporary patch just so I could rebalance the RAID10 blocks to RAID1.

> The fs should have enough space to allocate new metadata chunk (it's
> metadata chunk lacking space and caused ENOSPC).
>=20
> I'm not sure if it's the degraded mount cause the problem, as the
> enospc_debug output looks like reserved/pinned/over-reserved space has
> taken up all space, while no new chunk get allocated.

The problem happens after replace-ing the missing device (which succeeds =

in full) and then attempting to remove it, i.e. without a degraded mount.=


> Would you please try to balance metadata to see if the ENOSPC still hap=
pens?

The problem also manifests when attempting to rebalance the metadata.

Thanks!

--=20
Best regards,
  Vladimir


--8qIYkbt2CCjZkrWIElZp88do1vB1eZjh8--

--9PZyF3ZJhNGNm7L7EHr41n4KL1nC93pmB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEu+0bCIztf5WJF/voUATw+tBRV20FAl0gLfYACgkQUATw+tBR
V23KoQgAmrYreh9EXaoeP5T8hUHQrH/mLL5Xz8/DYqFpJFS/gz0jIB9hLqdNgZVx
GzaQn11QTORy1wVR+kyzaffATD52kDjS5kStsPP5AHKa29TzIk4W520IUfr6lzjo
xRwAxnk4/myhbHKqrQwg4gBf0OppDclX9sU5n3AGRa7z4vMsp7NS2gh2aOici7Ig
RuyiCDIyV/DlCWx46CP1Wtial2XmkM/XuvjlOT84W9xnpe7q55FqlxnQ/guTGv8H
cdw8lkng+QS3QrEIkXRzWxogcKSKXJPTcl4CbeVHEbnw0Sn207pQRzzo7WAqCS0x
LbNOLHEbyAlq0v3tR6BDzQG7tfmSag==
=fju9
-----END PGP SIGNATURE-----

--9PZyF3ZJhNGNm7L7EHr41n4KL1nC93pmB--
