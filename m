Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763D5573A11
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiGMPZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiGMPZN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 11:25:13 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CDC4C62C
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657725907;
        bh=qonBphcVG7skbkmsuEjXn6vXc+w6quD/R/M98yFmRqQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=RjVIcgShqPr4IA6/+OEbUQ0yMbiPwlWj3mLgRNdEU+cS4LNxqilIi1PNy2+QbUUj2
         AnmY8gqGYbEI58SdC0TpyLFvHRRDd619CDefF8ALQj2rqBr3WZTgB/hhB9gpTWhAT+
         t4wSkMwGT2LmA5oMY1OHCIOU/SWZ3l910x6Zg43Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.150.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSFO-1o5Vx70Zew-00WdBs; Wed, 13
 Jul 2022 17:25:07 +0200
Date:   Wed, 13 Jul 2022 15:24:24 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Message-ID: <20220713152424.0d93e5fd@gecko>
In-Reply-To: <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
        <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
        <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
        <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
        <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
        <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
        <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/87fmQp3GuUUv4HhzFw+_YGs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:RqToNvcdsDDgdMb9/Rp2VPyxMxeIob4QEgCAYiOE/zKtwFzWAyN
 cRzQzafUjNTpuTR7zTeIGDaijQBUi7IY53IcGWsRP/ShNZ3NOhKRqZ19icJ4yzLvAgVSuZo
 /oNbQzL8P+SVTZNukiW38Str2HoOlbYcHY85HfYFVzU8bX+NlOXRgZPOFiMetL3epwJ1wcl
 80uKzINWMOSt4aM/9w2wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/mCCeLnCtI8=:FP2UmvCDoReZrAIIPcEC/Q
 Vss62Yo7r/DW93e2Qg2YgRbVQLsGT9wII8zqH2LSVYqQN1uHQ5TUheXSdSpPDmPsrYuomtb5f
 TaOb168j181Qw614THDw1ILcmKtdir5bAQFWnXVT9taiM8rLYTYdr8iyj4lPaW1ADq6tP/v/Q
 3OuxGBYhRZ6sOg5giF3/2U60uqcv3y7RSTlNkrEVqYi9W6J4E+4wSdkHFgyv1fGs/2nwUL0g4
 BpT9L7/1CCFQpOgOUmVF/Pn1DLlaA407ymW9rzIRDrROQQiG/MzIogKXkv/oxXTYjo9d5c04T
 AQmTrD+s3hcytakvmvk/7BayFM4P69K5Cs9lc+ivD6MGMvDAwJyIrdo0bN7Hrt9uqzU42uzB0
 6pF3rx1UnyKIAKl/GcPOBxg2LNse1ql6fB0lb2C7AQUawCT5e+R+3ec3etiJELRRCjem9ExpZ
 VHpSJaS4b9DiqP7zf12YtXmiMEAtMj2NloNyShDQ6969a8+CUxGWrq7joRx3Sb969g6sIgLdq
 MjmwYiW3cW/GKUnApaZpD6B+g7PWAE3am8d0N0xPfkL5Q0oQSe56SFHs0oJskYUabtYOjA7Ck
 PFPrHt5AeBhHPSvsUKfN4F+7LRUTV0BQkx7+7GD0+t/Aoxsg4aZqc7n6jklHvkO71W4iBwWSI
 vDDYgM5k5b0qvAQfRPUEyws+WTARH4Df8FlG9X1iAjlK6w333nziXe6xQW/rUGG27AvBFyi4Y
 KV0CCYfjJyiKwaiMQRyAdwwRrYj6xnmP/HMh7fRjs4VgdouTduNezzoXZQ997Y26lDJSQwtsJ
 PI42cgd7J5F4o6fTPUC2SHqjaaTy+RmkljMdItMOM7WyU+B/8n9cncBC4/MbRYCeRST+/C2rk
 WPMc8NNmvxRxZNVFHM7q2A1z9aj0VwVhPp4tSKWM9wjRdSMjdn2lr4qT5TgjQZr7XY35X3NVw
 hXauj4ms9/Z78FN5vx9hPK0CFqjuxR5gnHmyXuauy3cJHOa01I9G0B5r8kDRtIjYcy1eTtXii
 nCbqGcTpq7agQCzwKeW1tQik3v3vnS8b/b2VVWnk3ky8kkfdLyG949qcpj1qeIpiIgAVKn31T
 LprYCiFff1v9fKMAy48WHN8nX0h0UmCGsJ7Ioq8ZSf6la46Zu1F+oM+csivigRSOIfVhm2u/T
 v4nDrCIzOPGmo9gj7z+3vje87skliLUJ8yEv6vegKpWtEyRnw6OaSvPaqmUUDB7fUZsmQlciX
 RgPZrhI/uo1aWHqdv
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

--Sig_/87fmQp3GuUUv4HhzFw+_YGs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Jul 2022 14:01:32 +0000
Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:

> On 13.07.22 15:47, Qu Wenruo wrote:
> >=20
> >=20
> > On 2022/7/13 20:42, Johannes Thumshirn wrote: =20
> >> On 13.07.22 14:01, Qu Wenruo wrote: =20
> >>>
> >>>
> >>> On 2022/7/13 19:43, Johannes Thumshirn wrote: =20
> >>>> On 13.07.22 12:54, Qu Wenruo wrote: =20
> >>>>>
> >>>>>
> >>>>> On 2022/5/16 22:31, Johannes Thumshirn wrote: =20
> >>>>>> Introduce a raid-stripe-tree to record writes in a RAID environmen=
t.
> >>>>>>
> >>>>>> In essence this adds another address translation layer between the=
 logical
> >>>>>> and the physical addresses in btrfs and is designed to close two g=
aps. The
> >>>>>> first is the ominous RAID-write-hole we suffer from with RAID5/6 a=
nd the
> >>>>>> second one is the inability of doing RAID with zoned block devices=
 due to the
> >>>>>> constraints we have with REQ_OP_ZONE_APPEND writes. =20
> >>>>>
> >>>>> Here I want to discuss about something related to RAID56 and RST.
> >>>>>
> >>>>> One of my long existing concern is, P/Q stripes have a higher update
> >>>>> frequency, thus with certain transaction commit/data writeback timi=
ng,
> >>>>> wouldn't it cause the device storing P/Q stripes go out of space be=
fore
> >>>>> the data stripe devices? =20
> >>>>
> >>>> P/Q stripes on a dedicated drive would be RAID4, which we don't have=
. =20
> >>>
> >>> I'm just using one block group as an example.
> >>>
> >>> Sure, the next bg can definitely go somewhere else.
> >>>
> >>> But inside one bg, we are still using one zone for the bg, right? =20
> >>
> >> Ok maybe I'm not understanding the code in volumes.c correctly, but
> >> doesn't __btrfs_map_block() calculate a rotation per stripe-set?
> >>
> >> I'm looking at this code:
> >>
> >> 	/* Build raid_map */
> >> 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
> >> 	    (need_full_stripe(op) || mirror_num > 1)) {
> >> 		u64 tmp;
> >> 		unsigned rot;
> >>
> >> 		/* Work out the disk rotation on this stripe-set */
> >> 		div_u64_rem(stripe_nr, num_stripes, &rot);
> >>
> >> 		/* Fill in the logical address of each stripe */
> >> 		tmp =3D stripe_nr * data_stripes;
> >> 		for (i =3D 0; i < data_stripes; i++)
> >> 			bioc->raid_map[(i + rot) % num_stripes] =3D
> >> 				em->start + (tmp + i) * map->stripe_len;
> >>
> >> 		bioc->raid_map[(i + rot) % map->num_stripes] =3D RAID5_P_STRIPE;
> >> 		if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> >> 			bioc->raid_map[(i + rot + 1) % num_stripes] =3D
> >> 				RAID6_Q_STRIPE;
> >>
> >> 		sort_parity_stripes(bioc, num_stripes);
> >> 	} =20
> >=20
> > That's per full-stripe. AKA, the rotation only kicks in after a full st=
ripe.
> >=20
> > In my example, we're inside one full stripe, no rotation, until next
> > full stripe.
> >  =20
>=20
>=20
> Ah ok, my apologies. For sub-stripe size writes My idea was to 0-pad up t=
o =20
> stripe size. Then we can do full CoW of stripes. If we have an older gene=
ration
> of a stripe, we can just override it on regular btrfs. On zoned btrfs this
> just accounts for more zone_unusable bytes and waits for the GC to kick i=
n.
>=20

Have you considered variable stripe size? I believe ZFS does this.
Should be easy for raid5 since it's just xor, not sure for raid6.

PS: ZFS seems to do variable-_width_ stripes
https://pthree.org/2012/12/05/zfs-administration-part-ii-raidz/

Regards,
Lukas Straub

--=20


--Sig_/87fmQp3GuUUv4HhzFw+_YGs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmLO46gACgkQNasLKJxd
sljS2xAArLa6VtFNfF1B+b/E+cjy/o5F2kFucS4iBkTHK4FyXolgAti3G2JbWLw4
QPGoykKYDsbsr1UnwV8keHE2DNQy7I3VJD5HrYZuUWPd6LL/y5pDAFgL7F072kAW
+5S2jyyGus/gH2ujjox/6WeUXULtHir3zDTHYRPmJTsdwh7WenYaRJWhNeJ8JNVb
0qa3AzTxYZTuf+3X7r4M+8yMiJY3sErBCsWvAtGd5kDt/puyINAoYtFjR7mDVAR3
ncxHy6wmU/hLHSR2iw0V01WoNNOa6qoB2Ggdc4UtXdMZLnXa7dE1qv/jIEy0s/fs
zqYHRbcW+ne7JBbpMYpmFWzxQNXZgK2yndRM7NXeRFzpeiaZLBIAShYlI6CV+zuM
fV+ai8yRBJA1MRXeZLzwtLkWatyS9aYBeeAEJDunQvZc9DCM7UXYx0ygRBxo1lRJ
8IOORlO0bZAYJdn5CHB3ZIF2/Oo6/MR59CxEuXtcZZ5UbK/eSKFyhVN8fVehPbdT
H8DRaRV5fGEG6xe19q8C4Ve5XBp7qrivl2oZZB/oDtdo0dn83g8HBMr+lEpjcePX
5D5JTs6GG+g4dfAjquypSTiH0QL9G8KtDXY9KAkMKQBEV1wMqCuu0syDaFQtb4NK
4ciCCQ52jsPTw7beAqooL1jfpeVIMNilQzGLN+3J0AyCaK8qGbs=
=XY39
-----END PGP SIGNATURE-----

--Sig_/87fmQp3GuUUv4HhzFw+_YGs--
