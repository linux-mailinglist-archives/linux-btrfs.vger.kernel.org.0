Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C453C7AE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243071AbiFCJi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiFCJiY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 05:38:24 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Jun 2022 02:38:22 PDT
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB3275FE
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654249100;
        bh=0EKNm/kgtDxWkT2990aIuJRbOV6FouGDdmysuE0pbTM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=lQYldukFWx85GGfxxqGaWfSuZeJ/x0fGQILuvGx8a3BR75jjQmtIx1r1Y1Io620qI
         BmptBZOgLyfNf2FjVCCoUnnbdBEgCiSPznV8Ib3bXvDnlJKKySnPLLI25rR3Ib8ZGR
         UWeEpKTPJv0F/NJA4IXE11nzziVLdFNGmKvyEfjo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.150.163]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QQD-1niIag2TZV-017KZd; Fri, 03
 Jun 2022 11:32:55 +0200
Date:   Fri, 3 Jun 2022 09:32:07 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Martin Raiber <martin@urbackup.org>,
        Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Message-ID: <20220603093207.6722d77a@gecko>
In-Reply-To: <f56d4b11-1788-e4b5-35fa-d17b46a46d00@gmx.com>
References: <20220601102532.D262.409509F4@e16-tech.com>
        <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
        <20220601170741.4B12.409509F4@e16-tech.com>
        <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
        <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
        <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
        <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
        <f56d4b11-1788-e4b5-35fa-d17b46a46d00@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yEFHaFRZ_eENIT2LKtFeMRI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:xbWhLTN8yfqx50ubL8B3ZGfwQBwcbqgcNNguNVMrKCvepcCUhA1
 vx66qqOnbvLfxJtpng5xKSkqQ4VaP74bEl77lW1MaDYjBIS4PY1bSAMqAVL+/N8EtPFu+UO
 4rlrOpZx7lFfj9r+GpSBHIJlO6+vCH8q35CQi9adjf2pkE72DI8gB+u8iWDONkLnpXa+JJG
 xpQuqTNhOj8SzuSSYBLkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q+c4hr8kwGo=:5z/gObv3Ko3Wz3L/FQxYLn
 Hciyl4PmqJH+c/pD9mwStbDGyEXX5ygzZSzSOgqnIjzG/VwH0wfMTJcq5Ua8lK/Evst7Q46En
 rGL1gYHfkEabf7IjS8YcNMXQo1nrFu3mgWygzFMxboqQ7Idc62Jo9bO6+rGtvb38tLx6BzLhB
 l3oR2chYFVNQfg4Wn7V58qQlpfJdX0YTfBatFz5DgQQP+Z7HtkwuZ0VPH0/wN+nD1vUrw3uwn
 34+Wk188Hb7LQ4kEd2aK0Ds3Pu97nMTsg11fFO2AgCdpDGBuWNtbw3HGQRhu0ZnoJK2p2NS5H
 xmdv28cQnLO3LP7qxes4jZDs8ShiXT81oeSVdOHsR/EzMnE/I6najhcb0aY5LyVFB6fl2YmX9
 w76CEwSJ4tDqxzj6dg+mFqlLFt5AWigJzWWetkgr+NWqhV4GoWRpiE9pQmmJmu1U+AxCB7GwF
 lOZb+yIpYv30Q3Kt1ajlRDGI5HebbS2ezgmfJmZNe1f5vkxkUAKNcDfM2B9b0rMsMwBdRwVUQ
 K4HMNksmT044RGBLqUZV0b0bNsbk7gDJl4yO2qYORKRA+jouakYvSUh8LaHqqQJdcUzxzG4Os
 mfWJ+MlNa1032CLUefG9wWO+JIwm+sI2b6vsw0loTfZ54IbtamZ2xmzIPz8WjpmNxI4bmy/eG
 svRczN+Z6MExiD47QoZ6nXV6IloVpxV4SK1I3n6USK+SIm11QFuMzUuSzmEx6h8pums6MU3Rm
 9e5QKJ957Jxt/OkDvqfExiAukXGtJ3+7NFivoTPKVuT0Ly9Mu3SOVu9AMLRYfvZlIPXkeaRsT
 Vvlha6qeprE1QEaxNytbO1LlwLHpaj/+1T9DMAwztxi/OlWZounqpaimtDOHkMZaLIwOoTMXl
 VCguzhgpqSBF2uoSZSEq4mrq7SOFktl1IlvysKA3OSRECNrKPgO8n8D8lxmemmMZhJEHqN6x6
 dWViVuTuECOeFNWHshp+JM+oxaCGefN1z9bhGxaGmjCpsIqvc9OPJqk3/cFSzG5kTYOXwTk4q
 fcnlsRZ5EL9eF9mVS3+BmSRwYFeUJcf2fl9jbth/R5kePkTaWXK3da0MBT+O8hro2uncPuOMh
 tgoPMzdTmuHd+8cCePiwALjBCC0gz8491mwMHcY2oZikcioFmEDdQGWtw==
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

--Sig_/yEFHaFRZ_eENIT2LKtFeMRI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Jun 2022 05:37:11 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> On 2022/6/2 02:49, Martin Raiber wrote:
> > On 01.06.2022 12:12 Qu Wenruo wrote: =20
> >>
> >>
> >> On 2022/6/1 17:56, Paul Jones wrote: =20
> >>> =20
> >>>> -----Original Message-----
> >>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> >>>> Sent: Wednesday, 1 June 2022 7:27 PM
> >>>> To: Wang Yugui <wangyugui@e16-tech.com>
> >>>> Cc: linux-btrfs@vger.kernel.org
> >>>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format dra=
ft
> >>>>
> >>>> =20
> >>> =20
> >>>>>>> If we save journal on every RAID56 HDD, it will always be very sl=
ow,
> >>>>>>> because journal data is in a different place than normal data, so
> >>>>>>> HDD seek is always happen?
> >>>>>>>
> >>>>>>> If we save journal on a device just like 'mke2fs -O journal_dev' =
or
> >>>>>>> 'mkfs.xfs -l logdev', then this device just works like NVDIMM?=C2=
=A0 We
> >>>>>>> may not need
> >>>>>>> RAID56/RAID1 for journal data. =20
> >>>>>>
> >>>>>> That device is the single point of failure. You lost that device,
> >>>>>> write hole come again. =20
> >>>>>
> >>>>> The HW RAID card have 'single point of failure'=C2=A0 too, such as =
the
> >>>>> NVDIMM inside HW RAID card.
> >>>>>
> >>>>> but=C2=A0 power-lost frequency > hdd failure frequency=C2=A0 > NVDI=
MM/ssd
> >>>>> failure frequency =20
> >>>>
> >>>> It's a completely different level.
> >>>>
> >>>> For btrfs RAID, we have no special treat for any disk.
> >>>> And our RAID is focusing on ensuring device tolerance.
> >>>>
> >>>> In your RAID card case, indeed the failure rate of the card is much =
lower.
> >>>> In journal device case, how do you ensure it's still true that the j=
ournal device
> >>>> missing possibility is way lower than all the other devices?
> >>>>
> >>>> So this doesn't make sense, unless you introduce the journal to some=
thing
> >>>> definitely not a regular disk.
> >>>>
> >>>> I don't believe this benefit most users.
> >>>> Just consider how many regular people use dedicated journal device f=
or
> >>>> XFS/EXT4 upon md/dm RAID56. =20
> >>>
> >>> A good solid state drive should be far less error prone than spinning=
 drives, so would be a good candidate. Not perfect, but better.
> >>>
> >>> As an end user I think focusing on stability and recovery tools is a =
better use of time than fixing the write hole, as I wouldn't even consider =
using Raid56 in it's current state. The write hole problem can be alleviate=
d by a UPS and not using Raid56 for a busy write load. It's still good to b=
rainstorm the issue though, as it will need solving eventually. =20
> >>
> >> In fact, since write hole is only a problem for power loss (and explic=
it
> >> degraded write), another solution is, only record if the fs is
> >> gracefully closed.
> >>
> >> If the fs is not gracefully closed (by a bit in superblock), then we
> >> just trigger a full scrub on all existing RAID56 block groups.
> >>
> >> This should solve the problem, with the extra cost of slow scrub for
> >> each unclean shutdown.
> >>
> >> To be extra safe, during that scrub run, we really want user to wait f=
or
> >> the scrub to finish.
> >>
> >> But on the other hand, I totally understand user won't be happy to wait
> >> for 10+ hours just due to a unclean shutdown... =20
> > Would it be possible to put the stripe offsets/numbers into a journal/c=
ommit them before write? Then, during mount you could scrub only those afte=
r an unclean shutdown. =20
>=20
> If we go that path, we can already do full journal, and only replay that
> journal without the need for scrub at all.

Hello Qu,

If you don't care about the write-hole, you can also use a dirty bitmap
like mdraid 5/6 does. There, one bit in the bitmap represents for
example one gigabyte of the disk that _may_ be dirty, and the bit is left
dirty for a while and doesn't need to be set for each write. Or you
could do a per-block-group dirty bit.

And while you're at it, add the same mechanism to all the other raid
and dup modes to fix the inconsistency of NOCOW files after a crash.

Regards,
Lukas Straub

> Thanks,
> Qu
>=20
> >>
> >> Thanks,
> >> Qu
> >> =20
> >>>
> >>> Paul. =20
> >
> > =20



--=20


--Sig_/yEFHaFRZ_eENIT2LKtFeMRI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmKZ1RcACgkQNasLKJxd
sljFxQ/+KP0mC4rg8cJ76gsdXKFSGRN2n/wOK6fKxsxrNHBLCbPgXhixw+GlRNhJ
3kfHw6074ohKXiWLTdR0a6ucQZqMcYDlWbT5gPMoI54IEOGAbmxj6KGt6Ybqvu2M
/ySbnRwzXr8JlnuPi+n/LU7oVdM4VZtTY0LLOLQ+6nVq2JotLsvvb+x1rfRbJzll
1cghXV0S6BvFKnKtMa/YoAh5wTRIv6axdPzFbv6z7+mPobrHRJjAlgqROMJEqwgc
S/9gBHn5N6q0p02IiDYIlZjaQ6r8y89/ZjSZIvx71NfIcyo2BngrNtKQzvdSd7Pq
Ba3CzaQAq5Hzgf+cyhD0Qps6TO6ARNjV2eSkVPuT9zs2boZwuuvO1u44jdhtwJ4L
tqqlpSiHvhdYTO7C00c9MpfglWxdYruKFKGQiKe14M//nmge5iZFmMzfKW/0tkel
Cteag/F/cvryyl7o2geDpAy385HBBS5i6qzu/lXVo1goklQAt2YRlDKExqGNd0V9
bg4EHL+Sv451qs9FirhgWOBqG3NoLXvsL1kEHYKgQTc8AWNmnbry4YpNLe7/Rot2
0KQsKD9zRHSuH9obe/xxh+AhUT3dEaaiNlEGTTEi3Y0A47QZxqrO4/yZWAW+b2+Z
0pypZFw7GL5gdnyQ5aZjOPZJGU4xeAjh4gfKvjqANSVtdby7SXY=
=7SIa
-----END PGP SIGNATURE-----

--Sig_/yEFHaFRZ_eENIT2LKtFeMRI--
