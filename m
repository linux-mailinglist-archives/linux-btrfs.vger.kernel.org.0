Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF4B35116B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhDAJEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 05:04:30 -0400
Received: from mout.web.de ([217.72.192.78]:39843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233604AbhDAJE3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 05:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617267868;
        bh=/HHcEsm3CeIx/At1y2ssuRD24E/z+3s0gvlAXHXZAv0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=XupWMnSbidK5lJM4WUw25kmb2R2cdKKyIfs81slW0P0/bD2cQZHIptTHvW0+hzmu8
         4KcamOKtNvILTD04psPEzZNBm2BzysfoCaVuY3FQQWZ83UMvYpiTWadecdwddg9udw
         Bb2UbojsPbi8OzpKcVk4vZ5Y54ImH01V1LDjMOPg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko.fritz.box ([88.130.61.26]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzK61-1lenXO483t-014Vvi; Thu, 01
 Apr 2021 11:04:28 +0200
Date:   Thu, 1 Apr 2021 11:04:19 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Thierry Testeur <thierry.testeur@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Support demand on Btrfs crashed fs.
Message-ID: <20210401110419.53c8bfbc@gecko.fritz.box>
In-Reply-To: <CABDFzMiR=b6N+1mp_F4W1awig+kC2Qb3w18C6ev_S3jcQSKchQ@mail.gmail.com>
References: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
        <CABDFzMg1J_CDkNJ8JSvu2CkQT_ARHPw4_72C5BozbmYRxLKO6w@mail.gmail.com>
        <20210331142327.09af250d@gecko.fritz.box>
        <CABDFzMiR=b6N+1mp_F4W1awig+kC2Qb3w18C6ev_S3jcQSKchQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z8Xb+ZMW=IYKQNSh=UG+1Zb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:u1NizcqY8uIDpazHNqvDI409lws5og0jGQ/cmMXZTWgw8UdOLJt
 KhMIKFeTcKUeaUShp1vTWx/qCJv304pmEC+aY1ZbXKFHgDZh6L5mZJdBBcX+NMhK35JkaWn
 grghZlao/NCaAbssK4WHL9GfjV0ftFEmtHjVkRiRgHRYgTEg9TEUMzYDDWEr9Dueu+IwEp7
 7CyQJBntNUnmWsrvkXXxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZCUyc/k4UmA=:SKCotBilaZt9K/1xh8/3fm
 gh5j6VhyA31euurdSFI7a/gBh5cyeQwaPON778gp2kmtEFkY5d6Fz+SOuz4O8WjAEEwwUmR1J
 f+fM0cjBVGbJV0Z6qHw/jgt0qzlFaMoXduN06K9OawIHwuE80hdUgLgAx1sjs+pBJj04GReTj
 lI5MQKDLKZDh20ZRW3DgvztdbpCy2PMXwY0TGeNiOva558I4+5rRaYu/QoY4Tgx0TBFZeMpEc
 N+ieUsB5rS5VkkscSzm+e9gEbFMVs73ion2pj7+GhXGIV7/AdnENj0t3HNbcPvd1CeG9SUi/0
 rvN0xcqqsl011hf3IiUWLRHLZ2vesmyS4x6sB5HrvBvlsNb06df+ISBU+e5SdnCg927Sd8kTs
 840tHU3dguxHMQ3O9pI3miz8HK6UOkvpdDkW930/6YWrm4l8Q0Br13uOysSSlvNXATz/z5yfq
 EIykuqTRXT3Qdv+r8S0iWb/Lo7sq3xTJ46ErqvkTqsj9wmPexB3GsEMoZTNLHLfnhcks0aNCR
 IeZFphdziXu8PElv/GSbu03NTk9/ShtEp5puUsT0seAvQgK+9wJjLRzlRryCtn/ZZt8sBadPk
 QONNZeqHwFc32xRFMO1+aFdmZD3gHt53Q36mDiOT8+613WS/RoZuinlA6RET5j7Aj0uF/1MHn
 4CpqFalZQYwxGxcMibuF4q4rnKxTqaruxl7rQVLw4Lj6PTIoydtB7toz6tCWgZ5ZN6zL/b7cU
 iNwOvoZ4Al8/Nhq0FxoINpjjhc6+DG9CjeXY04RDxy5jcnS7l2O53Hf0FfabJHTwW1t5t6XRT
 OMSBj7t2LTk6zm72tYMr700/1yFPi5eTD8C/JojQh9Qgh4iWHwRx2yfhcsB1BNAQ7Ktbzf28f
 Ps/x1RrWMaxS/EQa7G6wC27GT+eI0aCR66dMtiAOR100qQoEQDqyN+mMI7PiJmz8fiydj7e0L
 N+hPGMSBgFA50f1b9e1unr2k5Z5tknJha5zJPsWc4e6KlZ7+mdEP8500MilY7VJvtOSJESkxd
 qbk6QSwiMjeq2leKO5e4gUX6qN/ip78LY+sJuYIBnRXBKtXPpJbSaxAWSPKwJpzj/8gw3pAti
 G5fYQsduSAK1Wr6vvrYsokbdXbHtDSHy16003PZ60Zz/B7f7qR7Fv/punsJV3anKm7TxQNQGp
 /RIjKd4qMQoaCtnsTJfi9tPpn7uSzOPY7gf/olywX9QeI9aPydoPCHf09SNYEwq6f9kk9ZSEb
 +13GF2DEGgoCVlH+1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/Z8Xb+ZMW=IYKQNSh=UG+1Zb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Mar 2021 23:44:28 +0200
Thierry Testeur <thierry.testeur@gmail.com> wrote:

> Yep, compression enabled (original fstab before having tried restore
> options): compress=3Dlzo

Okay, that explains why photorec couldn't recover a lot. If you want to
get your hands dirty, I guess you could write a program that does the
following:
For every 4k block/address on the filesystem, attempt to decompress it
using the btrfs lzo implementation (see fs/btrfs/lzo.c and
lib/lzo/lzo1x_decompress_safe.c in the kernel).
Do some sanity checks:

Like, check that the length of the compressed data is reasonable. The
decompressed size of an compressed extend can be a maximum of 128k, so
considering the case that data which doesn't compress well may take up
more space in compressed from, the maximum length of the compressed
data should be a bit larger than 128k. I'd say like 256k.

Also check that the length of the segments is reasonable, etc.

If all sanity checks passed and decompression worked, look at the
decompressed size:

If it is exactly 128k, it is likely part of a bigger file. Append all
such data to a output file.

If it is below 128k, chances are pretty good you just recovered a small
file, save it directly somewhere. You can use the file(1) utility later
to figure out the file-format.
Or it could be the last part of a large file, so always append it to
the output file as well and fill up with zeroes so the end is aligned
to 4k.

Finally, you can run photorec on the output file that you appended
everything to, to rescue files that are larger than 128k.

I wish you luck.

Regards,
Lukas Straub

> Best regards,
> Thierry
>=20
> Le mer. 31 mars 2021 =C3=A0 14:23, Lukas Straub <lukasstraub2@web.de> a
> =C3=A9crit :
> >
> > On Wed, 31 Mar 2021 02:17:48 +0200
> > Thierry Testeur <thierry.testeur@gmail.com> wrote:
> > =20
> > > Hello,
> > >
> > > if anyone can help me with the problem above?
> > > Have tried a Photorec (even if i know the chance are really
> > > poor), and have got some non-sens files, lkie pdf of 2Gb, ....
> > > most of them are unusable, except smal size file, like jpg pic...
> > >
> > > thanks for any help.
> > > Thierry =20
> >
> > Weird, I would have expected photorec to recover more. Did you have
> > compression enabled?
> >
> > Regards,
> > Lukas Straub
> >
> > --
> > =20



--=20


--Sig_/Z8Xb+ZMW=IYKQNSh=UG+1Zb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmBljJMACgkQNasLKJxd
sljlSg//b3PMmNHvoZwxvs4N14ePI/5shJHb8ETadDaiZPI+5TqrL/UCCjVx/6eB
6LClxcLsVdQNqqa+8gKq1Y+64ZM5e816lsImxQVgg6tevpZe+b+1kEQ7nFvZw0yY
9ZVPIQleqr7Vwqf0BDYJeBVxwlVUFQ2w7mui44vM7lzXAswNcSXjiecXLlOWwvIf
3nURTq+TktYdx15pYD3RdnAFKPvmI3K7BEODLgTbsPTMZSxmeEuLGthf0jWnMbb2
PrRBnajeLexNWfCju1EnP4vWoMrDnhrOpXE7NfD5LMhSHrNLECYIGHFnpUGXZwfp
R2SM8z8Dn9VuSgGovsvcifh/xKZ3uLoq6wSNiDlNgXejz6DRdUCJvnvuAU1PmNIw
9sQXclupMD3JEFv27vackDx1dF2oYrcsgZ6/hP5a1evJ/HMEniaN1z4dTM+56nWy
qJTe14upb21gbpVPNzzLc6Mke1vlLLHVdJi53bFsQjRr9AXWcYCGkBRUVqgUr0pB
YTHtRhkP4aKFv0iMWknteaTxyIFRcQigxnROHDDni02lsuje5Lql9IlA5BzBnPpR
FcWb4XS0m5Kq8mIEDUxG85xjNs4avFw/eCkE4vpyZtvBQdy83Ph88pPNslenh04q
hUEYlalZQRy5AcYQjeU3gK7p8yjy/3bvOo4csKDVyHdDQsRe8CM=
=Ry8i
-----END PGP SIGNATURE-----

--Sig_/Z8Xb+ZMW=IYKQNSh=UG+1Zb--
