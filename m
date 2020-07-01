Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22A3210F02
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgGAPWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 11:22:32 -0400
Received: from mout.web.de ([212.227.15.3]:53559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbgGAPWb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 11:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593616946;
        bh=v8WJFBNpT6BhnAykQiyUJtYM8/Z/brgsL9i1UF6AV1A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=nKeo4UkctoFpakaNWYVWuJd+GWBvRgVmPeNZXe1V210gYCOC8a6EbqczAHgQOXwXy
         OREWbpgEUpkXci8wtPc4MKqTul/cTjcgiDR3JzxoWfHJfWJea+irOFwsSfQLyaiAT8
         tGcy+YYpUt7xhUoiJZY+yY/qmtI52kcUCJT4qwdw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.87]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MX0q4-1jKoMQ1pmG-00W1FW; Wed, 01
 Jul 2020 17:22:26 +0200
Date:   Wed, 1 Jul 2020 17:22:18 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200701172218.01c0197d@luklap>
In-Reply-To: <20200701144438.7613-1-josef@toxicpanda.com>
References: <20200701144438.7613-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J05N2Mn/.EOk1X3yJ71RjRI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:HeLYVRjKQq017C4bDeVh+y5IH9Wq+cB3TBQ2SD9CqrOtXE/5RP9
 rcQju855W2YTWj/8X8OZr0GhfuqHEq3c4xRLS/aMXNi/6vGc5nyT5NjE5aX+qycit148Vg7
 xESXMjYMYZLPdN3QUR8oblIwFFwKKeb+QcxzkS9MmIGXpu/EEGHlLVzZ3+e795InFFf9kq9
 nu0Vif6Rjv9kIH1aukNng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gzf+66Z1TKg=:4POwR8zUOuwiZd6PvXnYm0
 NsGheAvJP61PKvsf5sqqLXGWBNGLLuO6kNJCORldSykzTBlU6KgeuQ1GRGdew14JK0ZycvWqM
 n/td7jzWlat34Wc0/+h+53Bu124n13oCY/TVdEy6p5lp/qiMZtdNKwK+vlQQVZyY80Obj1r1C
 ICaav1QMqgkTpbjVxag7DameNPfN7tbbjw98jshDbRysk7c7Jici9xLDMAkZlfjcc1oigWszd
 HmJZYbjYu4fFq9Gwcs+v6dYEEICxRqA4TqtQvqM0UpDl5LKBa2YXth/g6susAefU8SYQiFt87
 dU8oMyiJOhLCxEIcg38GG6T7IkgbThBy/LbAZOaLzym/8K6TnW5khcU3hWKs1v1J7zRbp062w
 2L7OdYgz+SJFefNrOlOXM6XZDUUVJ6aQcgHx1708gQc9nwpt4qM6RTA8X9kbCmozlXBuerBK9
 sKSnnBAnCBYHrNm0vckamT4sVGKiHonN1zxV037Hhvj4fbhBpW6dhXm2Zm1KR1AwoYYZOEqZl
 v6Oh2RwrC8cAzGL0AjqZtvazh9/Z4OnWRWmysHGKPuoIiWQISHvOKqluYJAkDdtVdEIYjrHu3
 qtD6J+AA1nh271REmotzEmKqH0W2oDmA0CtB4mJJ0I7+IoqZjcwlMwH4Z7CW60rXSBf/tIvxY
 uzMivGKSThP2OfNknRY2kOshryuE4juoV87YvUG+lGve6s6a7fnKxPnkLJbCATY+wn19uEsR6
 8ToFtLDn5D+ooUTFpTkXy2W5P2qGwmZUfoMqLyOKSpr12S6No27FOzsLbYd0ruUBMxQ4ZS+5d
 PcsvDoYjZJfes8nGQuJmDHZMAtccGNx7GcihYR62HA3c+b9NJzlOzuPt+b+Oz8ywER5uRC4JM
 saIV6fv2IN3uZfwozMYs0lblAY7qalLn9vHW73cycrgNX4MzH2TTHf62pLrqbd6frLj+irTQk
 NS8EDrWEM3Nyky6zc6KtlOGb7yEp1SslqoDyK90C32yYJ653+lxNzWG+4l5W/y8eW/1vdDd2t
 Jc5sIiD6oFLCvQdAmhr0wcaonlF6Q8gMeCHGrV1x+wMK5C2QyFghPgIIxvkqJZPiZt8nr/3pX
 /XSIHa/2fS/WXTscidnLWgo/Adfp2YjeKCrW1SP47x93OYL6sZpGM1tMfre7LFZHVdLCpd0Vh
 m39IYPn6Em5eXaVdXKb33Q97jAoo9IgIgspNIDJXVDGfP7f6aYh7mSvz/LGYJgm4b8LctR+MA
 GXC1R8ZHiZ9Kq5Bii
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/J05N2Mn/.EOk1X3yJ71RjRI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  1 Jul 2020 10:44:38 -0400
Josef Bacik <josef@toxicpanda.com> wrote:

> One of the things that came up consistently in talking with Fedora about
> switching to btrfs as default is that btrfs is particularly vulnerable
> to metadata corruption.  If any of the core global roots are corrupted,
> the fs is unmountable and fsck can't usually do anything for you without
> some special options.
>=20
> Qu addressed this sort of with rescue=3Dskipbg, but that's poorly named as
> what it really does is just allow you to operate without an extent root.
> However there are a lot of other roots, and I'd rather not have to do
>=20
> mount -o rescue=3Dskipbg,rescue=3Dnocsum,rescue=3Dnofreespacetree,rescue=
=3Dblah
>=20
> Instead take his original idea and modify it so it just works for
> everything.  Turn it into rescue=3Donlyfs, and then any major root we fail
> to read just gets left empty and we carry on.
>=20
> Obviously if the fs roots are screwed then the user is in trouble, but
> otherwise this makes it much easier to pull stuff off the disk without
> needing our special rescue tools.  I tested this with my TEST_DEV that
> had a bunch of data on it by corrupting the csum tree and then reading
> files off the disk.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>=20
> I'm not married to the rescue=3Donlyfs name, if we can think of something=
 better
> I'm good.

Maybe you could go a step further and automatically switch to rescue mode i=
f something is corrupt. This is easier for the user than having to remember=
 the mount flags.

Regards,
Lukas Straub

> Also rescue=3Dskipbg is currently only sitting in misc-next, which is why=
 I'm
> killing it with this patch, we haven't sent it upstream so we're good to =
change
> it now before it lands.
>=20
>  fs/btrfs/block-group.c |  2 +-
>  fs/btrfs/ctree.h       |  2 +-
>  fs/btrfs/disk-io.c     | 76 ++++++++++++++++++++++--------------------
>  fs/btrfs/inode.c       |  6 +++-
>  fs/btrfs/super.c       | 27 +++++++--------
>  fs/btrfs/volumes.c     |  4 +--
>  6 files changed, 63 insertions(+), 54 deletions(-)
> ...

--Sig_/J05N2Mn/.EOk1X3yJ71RjRI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl78qioACgkQNasLKJxd
slih7g//Ylou0bwWII+I1im2j1L7KL6Zp5vBYFCWMpxAOLvXN4JG0MJVsPvNnd4r
nwUGtLfqqsou0M8BCCNgXqAtbOlNGuCdOMhuplWh3oSpDEPDGEeWBj7sJmzk0ond
UNFoMirXG0+BNRDdHrHFNDyVD5CA2Nj4wvCY0nEP46yvFn3Ztp0GLtPadE1ZzMeE
c3UzkYaGfS04gNMhHDpNsYcJbvnUSkQHBtfH3L0f+/bZibGKyiqAP2rV15WESnqN
oJHJgsJKIJoWxNdpeMVAxfKXyL/CkZVjeHKoKTJsU4Em2KjmYBtS4YkgX3sxmiVE
OxtmQlHbQ0qqpV41D7Kr9pMZU8UMEEc0eNIoqHOU/uT2YUO3u4M4LDKN/I2q3esi
6ykkRd0q2oDrtD4M78X6ICGlf220Nye6751gBb2H8VtlSS6gb7xAcR/lGIV4Ga8I
JP3UJNw4u2To0tYJMszzI2HlVJH1+9t0GbJGNkoH6bmeEtVkKvrBIBm8Vw5j+oEn
yIrd+TB2pBBpjMe322mK/peml8bnZ3YBGfci9KAhZcyPAcVYxyc0QPenVQzQm25S
iI7PXJwdoQAbJ8x9kLY8Y7eFzu2KPv4cwjU2hVxXQPC9kFIWLg+2EMdeYwpheRsK
j+RfLN0ahbDlXzEHNSaLwWKSVGCF49q4qfgcwr90BGQIvRtCOUQ=
=ncCG
-----END PGP SIGNATURE-----

--Sig_/J05N2Mn/.EOk1X3yJ71RjRI--
