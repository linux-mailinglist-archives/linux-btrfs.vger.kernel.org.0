Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4049573B00
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiGMQSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiGMQSu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 12:18:50 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81891641C
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657729124;
        bh=9xvM/Ve21D5q43tsCozIr3ku0rXPOxSUQhqR9jeJS58=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=VbjzD/lTPaYBtd5l37G2uuxkSd2/zwSf7+1+0t/c6MLMeFmwxG8NcXaSw1I3Gw+vR
         g6nVnVO+idpqT1rNcVjSCjObFDjUfpAEs/CgWDp5rVpjbaNXN3QhHd1pUR/oBx3O8A
         9ekAEoAhglgLaWfyIhRxN8j1HUn29NtG6t6m8eQE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.150.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrft2-1noNXM2dk4-00ncFQ; Wed, 13
 Jul 2022 18:18:44 +0200
Date:   Wed, 13 Jul 2022 16:18:35 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
Message-ID: <20220713161835.63ad1b00@gecko>
In-Reply-To: <cover.1657171615.git.wqu@suse.com>
References: <cover.1657171615.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ji=SrAmm51TMCwWTx77R.1r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:CQkIp3bq8FI3x6gQUTkEabUT4UqJMuRAjaKQ0pwrxdG6rFv4Tph
 yH12Op9bWCPYjm+jPdRvPYpZ8fCA9637Pdf42pQDekggXYtIsHXyXCb9C9BOhVlxRV/WsT8
 T74WKVyLvrTvqa0Y9+uwBkG+NHlT7fTFIrcVjxMoUR7szttDjejho1lKGltLhybw08b7fXk
 74M41qEkO/4sdKOxScpgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wQD268w8ijw=:8J3VxTjW5JY22e+iidxqGt
 /Qz2T92x4RJR5r7RaQf8Bnz0alO9jttob8rswZ0AcbPM1kBfLZ84G8H9kAmxusCwIhFuohqa0
 v/BUBv4Z75NepbWmjeSom1+0YDh5+Zt1AiKfJTuc89DVq4ZCjadHmYJDuhwxevLzVNPwNvsaD
 OLpBi6SgEX3aH11RqftriUEMbU3veJzXDD4IHmeqVr/70/iJTUVq3keft68DlYgNXiDqQaecK
 4V9iqmygq1PvnpHnpbttM+g3YMLkDVmFtOgeNWH5US1ko06f4MlnVKPsBjpo4hMtEjUnQKe8o
 lNJKjLEem89atXpyddA8AHzA79gGpZFKwDf4N6zkFkho6w+OQfewO40w8+42vPnaCrRhbP4Ss
 PsWf2pa8gUcktkMf+tJXLB1xkhV28vP2W9G6V+2fia64+leQA7JLkY7jXnEAK0CbOpGQBcETN
 3EUn1Wb4idj/3wE/d6952NTJpAAMIbBjQGT/eL90c6oZJd6Q2HooPo+ADBWC7dHM9htg7lhHX
 WxDN07VxOaBzh6J74rNuqxJgzau+pdno26GkaseDOSniUEscMw7CvHjtGmSjDuKS7m8VUryKn
 IwiQHdxUYYktbOheNOSz3Pl2cwfVigZfcW7abxhB1isIc6FiSWOzdkdzltpqBtzS6S75NuXf3
 XmGSxScfGlFg8OkSJ+87BKqe2Ghcx/Uw3yQ1qamAUTwk9g8bYgPkK5lsHIAk2iDzZZZ/v6Jvq
 mfn51/SKRRtctJCSXBTILqtyMBGfiAAo2Xo2I7bvG+4TwVc4i8+Z6k76rZ6fx7xS99PjkK8xw
 8ThRpQrlO5TT51qFCUbneMmR3k7Cu6HTYDtYp0kKCnJMnlO4knNoq0uw86QWlsuocWOjy5wE2
 lb5Bd1F1y4oZ5laJuxcFDeBYm9Q+mu+pIQ0rf9mLieLBmGq/at1i4+jtl5MmJnbJPn2r2qP46
 hfZksby/mfJbM+hTCTSZvK4M/eankrfrgcZSfXQ11+MuR98krNcXbCmUzZ8fVqxapS9X7rR1+
 19GoXpfex2tYZuJ6oklkqeafuXiuUKXT0hQ1pHl+idbHIE3TZHBU9466tjeJoNZF30IURQd9I
 AcquvAr2N9GAWvvh/amZw/ACjdxxwWvFZu2VgSgDaG05mXl4REk+PDwLQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/Ji=SrAmm51TMCwWTx77R.1r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Qu,

I think I mentioned it elsewhere, but could this be made general to all
raid levels (e.g. raid1/10 too)? This way, the bitmap can also be used
to fix the corruption of nocow files on btrfs raid. IMHO this is very
important since openSUSE and Fedora use nocow for certain files
(databases, vm images) by default and currently anyone using btrfs raid
there will be shot in the foot by this.

More comments below.

On Thu,  7 Jul 2022 13:32:25 +0800
Qu Wenruo <wqu@suse.com>=20
> [...]
> [OBJECTIVE]
>=20
> This patchset will introduce a btrfs specific write-intent bitmap.
>=20
> The bitmap will locate at physical offset 1MiB of each device, and the
> content is the same between all devices.
>=20
> When there is a RAID56 write (currently all RAID56 write, _including full
> stripe write_), before submitting all the real bios to disks,
> write-intent bitmap will be updated and flushed to all writeable
> devices.

You'll need to update the bitmap even with full stripe writes. I don't
know btrfs internals well, but this example should apply:

1. Powerloss happens during a full stripe write. If the bitmap wasn't set,
the whole stripe will contain inconsistent data:

	0		32K		64K
Disk 1	|iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (data stripe)
Disk 2  |iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (data stripe)
Disk 3	|iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (parity stripe)

2. Partial stripe write happens, only updates one data + parity:

	0		32K		64K
Disk 1	|XXiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (data stripe)
Disk 2  |iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (data stripe)
Disk 3	|XXiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (parity stripe)

3. We loose Disk 1. We try to recover Disk 1 data by using Disk 2 data
+ parity. Because Disk 2 is inconsistent we get invalid data.

Thus, we need to scrub the stripe even after a full stripe write to
prevent this.

> So even if a powerloss happened, at the next mount time we know which
> full stripes needs to check, and can start a scrub for those involved
> logical bytenr ranges.
>=20
> [...]
>=20
> [BITMAPS DESIGN]
>=20
> The bitmaps on-disk format looks like this:
>=20
>  [ super ][ entry 1 ][ entry 2 ] ... [entry N]
>  |<---------  super::size (4K) ------------->|
>=20
> Super block contains how many entires are in use.
>=20
> Each entry is 128 bits (16 bytes) in size, containing one u64 for
> bytenr, and u64 for one bitmap.
>=20
> And all utilized entries will be sorted in their bytenr order, and no
> bit can overlap.
>=20
> The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
> can contain at most 4MiB, and the whole bitmaps can contain 224 entries.

IMHO we can go much larger, mdraid for example uses a blocksize of
64MiB by default. Sure, we'll scrub many unrelated stripes on recovery
but write performance will be better.

Regards,
Lukas Straub

> For the worst case, it can contain 14MiB dirty ranges.
> (1 bits set per bitmap, also means 2 disks RAID5 or 3 disks RAID6).
>=20
> For the best case, it can contain 896MiB dirty ranges.
> (all bits set per bitmap)
>=20
> [WHY NOT BTRFS BTREE]
>=20
> Current write-intent structure needs two features:
>=20
> - Its data needs to survive cross stripe boundary
>   Normally this means write-intent btree needs to acts like a proper
>   tree root, has METADATA_ITEMs for all its tree blocks.
>=20
> - Its data update must be outside of a transaction
>   Currently only log tree can do such thing.
>   But unfortunately log tree can not survive across transaction
>   boundary.
>=20
> Thus write-intent btree can only meet one of the requirement, not a
> suitable solution here.
>=20
> [TESTING AND BENCHMARK]
>=20
> For performance benchmark, unfortunately I don't have 3 HDDs to test.
> Will do the benchmark after secured enough hardware.
>=20
> For testing, it can survive volume/raid/dev-replace test groups, and no
> write-intent bitmap leakage.
>=20
> Unfortunately there is still a warning triggered in btrfs/070, still
> under investigation, hopefully to be a false alert in bitmap clearing
> path.
>=20
> [TODO]
> - Scrub refactor to allow us to do proper recovery at mount time
>   Need to change scrub interface to scrub based on logical bytenr.
>=20
>   This can be a super big work, thus currently we will focus only on
>   RAID56 new scrub interface for write-intent recovery only.
>=20
> - Extra optimizations
>   * Skip full stripe writes
>   * Enlarge the window between btrfs_write_intent_mark_dirty() and
>     btrfs_write_intent_writeback()
>     So that we can merge more dirty bites and cause less bitmaps
>     writeback
>=20
> - Proper performance benchmark
>   Needs hardware/baremetal VMs, since I don't have any physical machine
>   large enough to contian 3 3.5" HDDs.
>=20
>=20
> Qu Wenruo (12):
>   btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVED
>   btrfs: introduce a new experimental compat RO flag,
>     WRITE_INTENT_BITMAP
>   btrfs: introduce the on-disk format of btrfs write intent bitmaps
>   btrfs: load/create write-intent bitmaps at mount time
>   btrfs: write-intent: write the newly created bitmaps to all disks
>   btrfs: write-intent: introduce an internal helper to set bits for a
>     range.
>   btrfs: write-intent: introduce an internal helper to clear bits for a
>     range.
>   btrfs: selftests: add selftests for write-intent bitmaps
>   btrfs: write back write intent bitmap after barrier_all_devices()
>   btrfs: update and writeback the write-intent bitmap for RAID56 write.
>   btrfs: raid56: clear write-intent bimaps when a full stripe finishes.
>   btrfs: warn and clear bitmaps if there is dirty bitmap at mount time
>=20
>  fs/btrfs/Makefile                           |   5 +-
>  fs/btrfs/ctree.h                            |  24 +-
>  fs/btrfs/disk-io.c                          |  54 ++
>  fs/btrfs/raid56.c                           |  16 +
>  fs/btrfs/sysfs.c                            |   2 +
>  fs/btrfs/tests/btrfs-tests.c                |   4 +
>  fs/btrfs/tests/btrfs-tests.h                |   2 +
>  fs/btrfs/tests/write-intent-bitmaps-tests.c | 247 ++++++
>  fs/btrfs/volumes.c                          |  34 +-
>  fs/btrfs/write-intent.c                     | 903 ++++++++++++++++++++
>  fs/btrfs/write-intent.h                     | 303 +++++++
>  fs/btrfs/zoned.c                            |   8 +
>  include/uapi/linux/btrfs.h                  |  17 +
>  13 files changed, 1610 insertions(+), 9 deletions(-)
>  create mode 100644 fs/btrfs/tests/write-intent-bitmaps-tests.c
>  create mode 100644 fs/btrfs/write-intent.c
>  create mode 100644 fs/btrfs/write-intent.h
>=20



--=20


--Sig_/Ji=SrAmm51TMCwWTx77R.1r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmLO8FsACgkQNasLKJxd
slgtpw/+IWtZB4ATFr3tEGpKtV+Jd69EscLvqz1C8IO6szi4l4ITJuNuiOj0sxxB
EYcw4WgxsPLTvIQC1A9yJHLLkFvwfYTsAYuE2svkPEZ7GgaWMV12ylWDd11BtvLT
QXZOP81MU+ZiML7A3DfoHpUK2ceIFBHDYsmzDSlAE/AHUbwvMupvD7egQ6KTmnr0
WVVZs1qEoImgxyM9KfCxPNU1YeUKHK/5Mlc4HiMPbKqTUqvq0fu3vuwmzCg1k15e
Jds4k6WFbu59OseQIywDXq4zDQGOD526orvzEasB063wAMdEEflDiqtbPHd+qKtM
GOe7p4fhqJzHa2IYECdwXuzVaOwQ3NXDfNBLzSC0qnAumCR5Oipxs8dzkEcnTKSX
tKr3097/lwjSqc5OSqrHx+eNJtccdAwFqG7QrjrF1m3yDUGPmCHIGhJHJo0gJOx9
hZ8IJG0YiGx6jfUOvW+cpuTG0QOwUQTDHske1pOgpe+rDjFkuFolhylYV/EBphUf
IpDcP4oG6sHw5KIFJB11JwO5uy1mRbfkO/gm8nh7ilsrSOS0O5BDIXkgH6oJO70u
qWAoBCeDW2ChwRNAhYz/xa1OFJferuw8PcRJk/xKTbTDepUsA+czGbQ7vCz9jwnJ
fE45HCF3tW7dYBYw655hjRNG9WkVg2rHGxXPiRH46cgJe1FjleQ=
=xBri
-----END PGP SIGNATURE-----

--Sig_/Ji=SrAmm51TMCwWTx77R.1r--
