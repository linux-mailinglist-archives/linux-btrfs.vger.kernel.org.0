Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6E54372E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbiFHPVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 11:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343721AbiFHPUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 11:20:45 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F47E1F3
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654701468;
        bh=aXgcX1vos1PZO9Adq1pFJFDyJZeN4guv2+M5mEX91cM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=VkUCSaNLmB/jTRSUHfKqHR7IEYj4bzM2fCPZ8THngy06tNAT/4y/SFEU2R2Tz6LPp
         GCbR0Owx3GQtmR26d26MHXSKC9JqGTe2sOVVkMjxg68RaP4xu1y3E9S+hj54dcQc0S
         JyPAf2meJX8Kpkaw8oE65hWjGv2/U14IfdRRzCXA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([93.95.236.146]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m59-1nzmeW3EKB-000mUL; Wed, 08
 Jun 2022 17:17:47 +0200
Date:   Wed, 8 Jun 2022 15:17:36 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Martin Raiber <martin@urbackup.org>,
        Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Message-ID: <20220608151736.6731b1d9@gecko>
In-Reply-To: <8c318892-0d36-51bb-18e0-a762dd75b723@gmx.com>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
 <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
 <f56d4b11-1788-e4b5-35fa-d17b46a46d00@gmx.com>
 <20220603093207.6722d77a@gecko>
 <8c318892-0d36-51bb-18e0-a762dd75b723@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LyR5PUoTI6a6P0Y+.QBqCXX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:qJffzErdDR1dr+SAA5WC1BqZKeF2fNe3IZyzmeFfnmHzPDcZHZL
 pl7Hgiqvi7NRsLB0TxiEFqzwcaX+SeWe7stunsXOU8jSAuvFB0rGU0hU3KDjKK7GI8KI40T
 IXOaDK0HwbgSHCXvZ7mZSRy/D8tEWLqEl0SKHhQPY7GwoFdgoRDY9o/wZC/cq/Svrj0jsJz
 3YS+XWyH5j2lGqLv1knTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U1YWNDgRpEY=:YECcxJPRAFlA1ioASDRJyb
 gVe+XKYQp7j7aaEr0ZNtK3JEljQBj1Is6vCIKI0Lj1oi2LT/iu38ymiRBE5rueoeQwiEIzw8a
 xlbgFFcc80QH8CqH/N+Pr8nilPYJop7kgOBdpN5mX9yCExs+jbubKr7grSEn0IAb7+OMm0Gr/
 TV7IQEQ8NFilJ0ZoeVW08KfvT0T6xhaL3gVuM/6wSL6PJCqkZAtHywDI8sqsS5mT19nhUnAO5
 KXBq1EEuspWsUBD0lXS/a0qlZekw9gILsZTfR8kEbs/xltjuCmfqN7/37UVoR1fopyKUM70zS
 asaFk5ixwhauR8xvobYJF0ZZLnka4c2s75AOhO1sT8CgQFjJ0bQ0lke3e4S0te+zvexT2vVdb
 6ILHQ/SieQLZd0BfZjxBN3qL7VCwJaYf/Rj+RvcVDfYMwNDwjbztAWQVxfAGRGtbwUgGyI5vz
 SVygaal0VjvcaA+9dg4Rxfnji6jTMF7iJHl2X5hXWzxuBuqRv5U8h08ac/jxTBsm+BU7I8ODL
 vbcHF5S9lHbc8kGMLhKzasiWnrjcPA0qH9XzaFIZ7/iOiFAnEK9aPPiagXaG67WSyGfVL2865
 Vd1FT+o4YCfhtKvESMbkHC3ig52cQSFWiV7eUWMprlXZ8qxMx0IdzxFxmvQCJefh8vGQ9yRlB
 YR9TfoV6fmLDQ6BPe44bb6UGdNleCPM67WU0tBQ99jVKSTctJG+YC9X1l5v3KIlxD66+96To5
 DEKYeLg6G39ewD2uRGGSNuvLMr8spAVOEGxW1eiSbCe9ykKCD4ukdK55KMI8ekD+hscizIVIo
 onS7F2ciOPY7nOh94/mSqfXVmImp6DdXQU7JmC79L49EIGOWziZX5bbteRxVE9JXfyJuQFGj7
 65LqMErUXQxxcotGBP8+Ppw06aW43uoAyL7A6AJ820iv8gVhV6jWQgA9lAvYXoLOsb1JtFTos
 74klhBiW6UBYEoQaw/Jc98qD3wiM02RoqACiRFgLvdC5PyOGDkxuRQ4jpEa6a3mC/LTMcH7oo
 1XwGhUHicpF4bt97DoMss5sVYSPOtRTvpnSHxT3kuQrmqxk08Sdr1a/tgYAKdV4ZuL3sWPg/F
 nzhSKSoJhXkL2XT44y27dG2oFz90vn61dW5VGcfgLOJTrWz/kVNRDPgqw==
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

--Sig_/LyR5PUoTI6a6P0Y+.QBqCXX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jun 2022 17:59:59 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> On 2022/6/3 17:32, Lukas Straub wrote:
> > On Thu, 2 Jun 2022 05:37:11 +0800
> > Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > =20
> >> On 2022/6/2 02:49, Martin Raiber wrote: =20
> >>> On 01.06.2022 12:12 Qu Wenruo wrote: =20
> >>>>
> >>>>
> >>>> On 2022/6/1 17:56, Paul Jones wrote: =20
> >>>>> =20
> >>>>>> -----Original Message-----
> >>>>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> >>>>>> Sent: Wednesday, 1 June 2022 7:27 PM
> >>>>>> To: Wang Yugui <wangyugui@e16-tech.com>
> >>>>>> Cc: linux-btrfs@vger.kernel.org
> >>>>>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format d=
raft
> >>>>>>
> >>>>>> =20
> >>>>> =20
> >>>>>>>>> If we save journal on every RAID56 HDD, it will always be very =
slow,
> >>>>>>>>> because journal data is in a different place than normal data, =
so
> >>>>>>>>> HDD seek is always happen?
> >>>>>>>>>
> >>>>>>>>> If we save journal on a device just like 'mke2fs -O journal_dev=
' or
> >>>>>>>>> 'mkfs.xfs -l logdev', then this device just works like NVDIMM?=
=C2=A0 We
> >>>>>>>>> may not need
> >>>>>>>>> RAID56/RAID1 for journal data. =20
> >>>>>>>>
> >>>>>>>> That device is the single point of failure. You lost that device,
> >>>>>>>> write hole come again. =20
> >>>>>>>
> >>>>>>> The HW RAID card have 'single point of failure'=C2=A0 too, such a=
s the
> >>>>>>> NVDIMM inside HW RAID card.
> >>>>>>>
> >>>>>>> but=C2=A0 power-lost frequency > hdd failure frequency=C2=A0 > NV=
DIMM/ssd
> >>>>>>> failure frequency =20
> >>>>>>
> >>>>>> It's a completely different level.
> >>>>>>
> >>>>>> For btrfs RAID, we have no special treat for any disk.
> >>>>>> And our RAID is focusing on ensuring device tolerance.
> >>>>>>
> >>>>>> In your RAID card case, indeed the failure rate of the card is muc=
h lower.
> >>>>>> In journal device case, how do you ensure it's still true that the=
 journal device
> >>>>>> missing possibility is way lower than all the other devices?
> >>>>>>
> >>>>>> So this doesn't make sense, unless you introduce the journal to so=
mething
> >>>>>> definitely not a regular disk.
> >>>>>>
> >>>>>> I don't believe this benefit most users.
> >>>>>> Just consider how many regular people use dedicated journal device=
 for
> >>>>>> XFS/EXT4 upon md/dm RAID56. =20
> >>>>>
> >>>>> A good solid state drive should be far less error prone than spinni=
ng drives, so would be a good candidate. Not perfect, but better.
> >>>>>
> >>>>> As an end user I think focusing on stability and recovery tools is =
a better use of time than fixing the write hole, as I wouldn't even conside=
r using Raid56 in it's current state. The write hole problem can be allevia=
ted by a UPS and not using Raid56 for a busy write load. It's still good to=
 brainstorm the issue though, as it will need solving eventually. =20
> >>>>
> >>>> In fact, since write hole is only a problem for power loss (and expl=
icit
> >>>> degraded write), another solution is, only record if the fs is
> >>>> gracefully closed.
> >>>>
> >>>> If the fs is not gracefully closed (by a bit in superblock), then we
> >>>> just trigger a full scrub on all existing RAID56 block groups.
> >>>>
> >>>> This should solve the problem, with the extra cost of slow scrub for
> >>>> each unclean shutdown.
> >>>>
> >>>> To be extra safe, during that scrub run, we really want user to wait=
 for
> >>>> the scrub to finish.
> >>>>
> >>>> But on the other hand, I totally understand user won't be happy to w=
ait
> >>>> for 10+ hours just due to a unclean shutdown... =20
> >>> Would it be possible to put the stripe offsets/numbers into a journal=
/commit them before write? Then, during mount you could scrub only those af=
ter an unclean shutdown. =20
> >>
> >> If we go that path, we can already do full journal, and only replay th=
at
> >> journal without the need for scrub at all. =20
> >
> > Hello Qu,
> >
> > If you don't care about the write-hole, you can also use a dirty bitmap
> > like mdraid 5/6 does. There, one bit in the bitmap represents for
> > example one gigabyte of the disk that _may_ be dirty, and the bit is le=
ft
> > dirty for a while and doesn't need to be set for each write. Or you
> > could do a per-block-group dirty bit. =20
>=20
> That would be a pretty good way for auto scrub after dirty close.
>=20
> Currently we have quite some different ideas, but some are pretty
> similar but at different side of a spectrum:
>=20
>      Easier to implement        ..     Harder to implement
> |<- More on mount time scrub   ..     More on journal ->|
> |					|	|	\- Full journal
> |					|	\--- Per bg dirty bitmap
> |					\----------- Per bg dirty flag
> \--------------------------------------------------- Per sb dirty flag
>=20
> In fact, the dirty bitmap is just a simplified version of journal (only
> record the metadata, without data).
> Unlike dm/dm-raid56, with btrfs scrub, we should be able to fully
> recover the data without problem.
>=20
> Even with per-bg dirty bitmap, we still need some extra location to
> record the bitmap. Thus it needs a on-disk format change anyway.
>=20
> Currently only sb dirty flag may be backward compatible.
>=20
> And whether we should wait for the scrub to finish before allowing use
> to do anything into the fs is also another concern.
>=20
> Even using bitmap, we may have several GiB data needs to be scrubbed.
> If we wait for the scrub to finish, it's the best and safest way, but
> users won't be happy at all.
>=20

Hmm, but it doesn't really make a difference in safety whether we allow
use while scrub/resync is running: The disks have inconsistent data and
if we now loose one disk, write-hole happens.

The only thing to watch out for while scrub/resync is running and a
write is submitted to the filesystem, is to scrub the stripe before
writing to it.


Regards,
Lukas Straub

> If we go scrub resume way, it's faster but still leaves a large window
> to allow write-hole to reduce our tolerance.
>=20
> Thanks,
> Qu
> >
> > And while you're at it, add the same mechanism to all the other raid
> > and dup modes to fix the inconsistency of NOCOW files after a crash.
> >
> > Regards,
> > Lukas Straub
> > =20
> >> Thanks,
> >> Qu
> >> =20
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>> =20
> >>>>>
> >>>>> Paul. =20
> >>>
> >>> =20
> >
> >
> > =20



--=20


--Sig_/LyR5PUoTI6a6P0Y+.QBqCXX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmKgvZAACgkQNasLKJxd
sliHkA/+IeZqBNFyAdFnrDzIXyRqqaVWYqe/QJQPqDPgy6ePt0pXxdMEXmOzj7VI
+fp14bs/qrHd7k9lnhmMvkedCyrs8P9BZTEysOFJISEjXVQzFDIhdI/mYbcdowMA
ytdgLd8v12/QE+FPEndcbN+r0PoRdSQYcLgrHFxK38/LJsSXugJbaAHoY/D+c5ls
7/susTiIfXHz6D3Yc3dyUM8h4sbenNuhoNqr/I/7ngWVESFCPiUobmWyEL+jhUZV
NTccim0kmrJNBJGKeMPx7AAVAOz7Qw84aNQUTNmeujnr4Lo2npnQefAi4YHJ+8iB
r86Gk9XRA6MXKyR1nOb+V7pZTflroV1Jpknsxglh8LoRgUbWcV9vF/bWadzH30P0
KHEB4p+d2s1lyvRLqtDAEVQ3gqtmVe6MDxTNLv8Y7tmMP2CFtfSAL8w3okrKaOvV
tQnaYDKuxIgJByQ4LWplFTHC1T+tBQ3jQqsIbqWndNQNYxcVv7iF+hz2dEMeOlEX
UsPg/08vhpoCG0dTYeaevAH5Jio3ZewsQvO13jQrD5Dlib2SpH4ZW+uOjfkeMzBy
GxZKkiMUVlKn4fPAeK/euYGLm/K7NHk7TQOU7G9nkVOX1EA9OBDbbB4H2+3oEkcQ
V7dRiq3AQGGbTGwmxNGMUWQXJ/we+rbHHs19Iml6eZoCGtb/u9A=
=TeZ+
-----END PGP SIGNATURE-----

--Sig_/LyR5PUoTI6a6P0Y+.QBqCXX--
