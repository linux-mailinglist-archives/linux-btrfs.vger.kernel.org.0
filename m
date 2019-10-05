Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D046CCD41
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Oct 2019 01:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfJEXSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 19:18:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:36405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJEXSN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 5 Oct 2019 19:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570317487;
        bh=6aWKI2ZK881ulpUMpxAU7ckKFtoYzGOAJsP1lcVauNU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=f9a9BigOafv0G6wxf0A+lo/xRmL6eXLGQJ2BsfvLJJhtwL1g5Fi8Xp+N8mKxlRFDm
         Jiu4ki9TZ9Q8WCbbmsB78/RYWU4VXDRAeR9GZK2voqWldCqNBIkXEqMfyxwmccEKCl
         fQHrJPoxjm2TClUnXglkpws/gC6v6nE9wAAoxjfI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkYXs-1hq3Ga0yuk-00m4FU; Sun, 06
 Oct 2019 01:18:06 +0200
Subject: Re: BTRFS corruption, mounts but comes read-only
To:     Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
 <44df5407-b7c9-bbd1-eae0-d5ebf6ad75d8@georgianit.com>
 <6022d6c9-3022-01fd-3b97-67bd08ce36f1@gmx.com>
 <fe22fa62-7b13-f417-1af8-3ed12bf082f8@georgianit.com>
 <8d765abc-b9f6-066f-8327-bcfc9a156177@gmx.com>
 <e546074f-4292-32c5-fe6b-170ace2f63f7@georgianit.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7f0f3aea-febe-022c-400a-8e846b0b17da@gmx.com>
Date:   Sun, 6 Oct 2019 07:18:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e546074f-4292-32c5-fe6b-170ace2f63f7@georgianit.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="By9RijJZLeviTQuMF1tqOkZgowQjqJ3ec"
X-Provags-ID: V03:K1:g5wOFLYtawsTxwN6I5OuZUuOFlP4iO5dR5hviCEv4R6lk6Zvg++
 2wzzWIx84s+pYFbcvDCVAP+4XY765Kr3FT2Vsku5YKoEyeQNq9o77H5MwWJHDWHtv5ooHJz
 Q5mSv7R71Z9Rc2ofoS31NrJXeGIC5saFW5J1bE0/ASUDc4MRtRjsFAVCsH7bjTyMlFxG5LC
 Ih3o6SK4ctkrzPMuSfmEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7q4vc2aDkdg=:YeA2yxbxEE4ydMo9cPF8ur
 AZli7BgZeuGHdYr0bPaKx+G7Z8UdlwWTVSqEEVS3cytCWgVDYEN2u163D4zl+cMdPFpupgQaD
 vhgHlig0BRVp51BsT04aPsiopn2EUCcXcCZOML3qsgVDUryBQY6QzvMwkXm1/b4rI/iKHCWW1
 2EhRUh0lmK/gfaU24ZGatyhA39nt6h0WZqiE3Kynv2R5hfEJQO7MyIWwgcTDTqeBtukD2c/uk
 1oqtQjDtUe6b8c6qcdCf/vzSEye96UHlEyM9V/oBePvtQM32vxveJecO/fnjEeHdLP6MnrpfP
 5HCDFBXJLj26XGwHPigUJhZ2G8qjfiYOoemQlu0MqHROWf0iSOS6R1Kbfcmw8JloYtP6e4nr6
 i+EO9SxGc6ziIOwxXHMugszYla30AtVqv1LqIAHguPTfn3E+f7lXLu2NjoLdWDgmK4QR803hK
 +NDV3xN2Axz1wbNoUGCrv72IKaFzQvvTMCCWF87FA7Cnyl+QoS7tMXtqohBI4lRG16mR1+XeT
 x92/aoQMcMZYvn6/XbXFADlfeRlXfMAnRqj2q7NFDPYFP7cGhF4v3lb7JSkREAhPbxntD7Zuv
 rIwaRzb/86K7xog8L5NokATN8lGWA1Q7hTiznsoBcRAvfauyDwILcLXVYZKz94jQuoHBQNsRX
 /tisIqeqqk/z9AxsYf4qb7s+8ZZR99dwKa3bchDkLd8OYUGefi9NxeGpUTXJHRrdAowubqoTY
 F9dgK+O/T3fPWMNrGg91m9SyG8fCtDS7rt3nGfV6id8ScthQJelwd1BFHqAtQkBvz6ALRM0xG
 2oJT6kavS1eihtHzK1mHm9qZ9IDckQLc7HE2vJbK74kQFsICqIl9C+QyxJvkPQCFbiZ5kw3Vv
 yA6gBHS2DUHyOPJLNAYU7kH1c9ORPJb4BVDiayJPYkjUNrW48eLYG/o3vraLSticS+JomHefS
 7p6xyvsjob9bd46bX2G92QyrtWQLQxojuKt10k4h8q7/TSUziRiG8TJ8MkatxPpz1uYmQRtcq
 z+0y1fTA4QIqIvXQ+HqdKp2oOHuxqG7YmYPby2UhctOuqJE/KExGxKDJTPzHNGxi6im/0cUZn
 9k3x7hP72k5e0Pak5xgb7kU10nAPMKGixccXo8Uj5c5pLp0CxJeOm0iIkFD62WzVZPLBdB3ZB
 ndLxBNo8U4wVZkxRYSjvTm8pGHoTR4ZGpK1NYopO00u1Rorc8oQJpGrHaCSrs/KI+WF8qPidG
 qcZpZPoLaFzv8XRLQIhcbxuWsSRzpQ3hvJc+y+gnbytxixV+Ogn0QLTl6WvI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--By9RijJZLeviTQuMF1tqOkZgowQjqJ3ec
Content-Type: multipart/mixed; boundary="7CVpniWDmMN8U8M37OqKlMPxic0DLoBvi"

--7CVpniWDmMN8U8M37OqKlMPxic0DLoBvi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/6 =E4=B8=8A=E5=8D=881:14, Remi Gauvin wrote:
> On 2019-09-30 9:53 p.m., Qu Wenruo wrote:
>=20
>>
>> It's indeed a symptom of btrfs kernel module bug. But at least looks
>> repairable.
>>
>=20
> As advertised, btrfs --check repair restored the FS to full function.

Yep, btrfs check --repair is getting better and better.

As long as btrfs check (no --repair) after --repair reports no error,
you're completely OK to go.

But as you already found, btrfs check (by default) only cares metadata,
while ignores all data, so you still need another scrub to fix data error=
=2E

In fact you can use --check-data-csum to make btrfs check to
check/repair data csum error too. (kinda like scrub).

>=20
> A follow-up scrub even found and corrected some corrupt data on one of
> the disks, that went  completely unreported by the disk itself.  So,
> despite this hiccup, BTRFS did it's job admirably.
>=20
>=20
> Whenever I do any further btrfs check after cleanly unmounting the
> filesystem, I get this error:
>=20
> cache and super generation don't match, space cache will be invalidated=


It's not an error, just a warning.
Kernel will just discard that cache.

>=20
> Even mounting with clear_cache,nospace_cache , (then mounting again wit=
h
> space_cache=3Dv2) does not remove this warning.  But it doesn't seem to=
 be
> causing any problems.. There are no warnings about the space cache in
> the dmesg log when the filesystem is mounted.

Clear cache doesn't really clear the cache.
Only block group got modified will delete its cache file.

To fully clear the cache, you can go btrfs check --clear-space-cache v1.

Thanks,
Qu


--7CVpniWDmMN8U8M37OqKlMPxic0DLoBvi--

--By9RijJZLeviTQuMF1tqOkZgowQjqJ3ec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2ZJKoXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgpswf+LKmd7wcnyCMdiuUnrWti51Wq
tCOnXWX645ovLHUbc3PCA7VNttdEpfMGMUdLITcKZ6MXHUnZwwctiu0vucPckoqs
Kyj1An6iWCrd/D5XfBMP0HTD9DintdvSOWcinZRqiRsTILTMlA4nNFmjk0qeNlih
thd/GSzjc8R2vtmA+LZYGQ4t5Zs2nem3nj8Nr/o/o6YS+5T4CmPMPTx0/+17TKd7
Z8NgdvdgXhtgGodEXhKgSSgnrbzZjVDfvtewroGs/XqRHc9qa6i1Blb/EnJrl56c
01wzqSGlebyOgV2teO2xRNh9qEKAoFvF3UXUMAh4yKADZnHRvkGeWf0AGAxPEQ==
=v9W9
-----END PGP SIGNATURE-----

--By9RijJZLeviTQuMF1tqOkZgowQjqJ3ec--
