Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F400940155E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 06:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhIFEJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 00:09:08 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:52150 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIFEJH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 00:09:07 -0400
Date:   Mon, 06 Sep 2021 04:07:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1630901280; bh=qCHnNXoQV1mPjCF2vBbytJR1nDRLH8Sf9bHZye8mKCQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=IRlhaZnohQOKu1T4KxaTb+a2f++vHN3nqy0crdIm8zez74qa6gGbPHRUZuOlvgFii
         0Ig4NUk7fnrZxMoqTPzUyVXRVsc/bgIQyKkf2im9fBSNK6SnfqFHeLIC3YDbqOsfgq
         gkUrydCz03cOgIZFhlGxheZZLjKFMYv45ueFvNJCe0CteAKmFSuqyPZeouTzEV7uM7
         Jht5C4IjLUKi5w1UvrSWjN3AFEp21abAvTvnr14wFVVu9Od5DtlwLba7H+ctZgUZmT
         fAUSeZs8woBBcsWPY5eMn30w+otLZ9tR7qaWAJXqhNiFzqCe6b/H2UpNIntqKIW3JK
         oNQNP2OHvcW7Q==
To:     Qu Wenruo <wqu@suse.com>
From:   ahipp0 <ahipp0@pm.me>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: ahipp0 <ahipp0@pm.me>
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <nlXbBH0TVIiMesk038DMLcR8tUOPa5gWVCWyxtyMLXSgC0l-MItGpoGQQSzXKNC1ZHcj1NXtZqU2czoEA-BTgSgWY6fwv-HPClN7D0PTxIc=@pm.me>
In-Reply-To: <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me> <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com> <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me> <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com> <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me> <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------5dc4c5d640ce5132871903c7932fec378d66bb164de4d9fcd813df5c7ffe4ca6"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5dc4c5d640ce5132871903c7932fec378d66bb164de4d9fcd813df5c7ffe4ca6
Content-Type: multipart/mixed;boundary=---------------------106c28cdb4c495bae700ef4c7efb2d8b

-----------------------106c28cdb4c495bae700ef4c7efb2d8b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, September 5th, 2021 at 11:36 PM, Qu wrote:

> On 2021/9/6 =E4=B8=8A=E5=8D=8811:05, ahipp0 wrote:
> =


> [...]
> =


> > > see the result of regular --repair.
> > =


> > $ btrfs check --repair /dev/nvme0n1p4
> > =


> > enabling repair mode
> > =


> > WARNING:
> > =


> > Do not use --repair unless you are advised to do so by a developer
> > =


> > or an experienced user, and then only after having accepted that no
> > =


> > fsck can successfully repair all types of filesystem corruption. Eg.
> > =


> > some software or hardware bugs can fatally damage a volume.
> > =


> > The operation will start in 10 seconds.
> > =


> > Use Ctrl-C to stop it.
> > =


> > 10 9 8 7 6 5 4 3 2 1
> > =


> > Starting repair.
> > =


> > Opening filesystem to check...
> > =


> > Checking filesystem on /dev/nvme0n1p4
> > =


> > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > =


> > [1/7] checking root items
> > =


> > Fixed 0 roots.
> > =


> > [2/7] checking extents
> > =


> > ref mismatch on [3111260160 8192] extent item 0, found 1
> > =


> > data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3111260160 root 257 owner 488963 offs=
et 0 found 1 wanted 0 back 0x55d56b1ea2f0
> > =


> > backpointer mismatch on [3111260160 8192]
> > =


> > adding new data backref on 3111260160 root 257 owner 488963 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3111260160
> > =


> > ref mismatch on [3111411712 12288] extent item 0, found 1
> > =


> > data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 n=
ot found in extent tree
> > =


> > incorrect local backref count on 3111411712 root 257 owner 488887 offs=
et 4096 found 1 wanted 0 back 0x55d56c18ca50
> > =


> > backpointer mismatch on [3111411712 12288]
> > =


> > adding new data backref on 3111411712 root 257 owner 488887 offset 409=
6 found 1
> > =


> > Repaired extent references for 3111411712
> > =


> > ref mismatch on [3111436288 16384] extent item 0, found 1
> > =


> > data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 n=
ot found in extent tree
> > =


> > incorrect local backref count on 3111436288 root 257 owner 488889 offs=
et 4096 found 1 wanted 0 back 0x55d576d8e290
> > =


> > backpointer mismatch on [3111436288 16384]
> > =


> > adding new data backref on 3111436288 root 257 owner 488889 offset 409=
6 found 1
> > =


> > Repaired extent references for 3111436288
> > =


> > ref mismatch on [3111489536 8192] extent item 0, found 1
> > =


> > data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3111489536 root 257 owner 488964 offs=
et 0 found 1 wanted 0 back 0x55d5699f2700
> > =


> > backpointer mismatch on [3111489536 8192]
> > =


> > adding new data backref on 3111489536 root 257 owner 488964 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3111489536
> > =


> > ref mismatch on [3111616512 638976] extent item 25, found 26
> > =


> > data backref 3111616512 root 257 owner 488965 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3111616512 root 257 owner 488965 offs=
et 0 found 1 wanted 0 back 0x55d56c17dc00
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3111616512,=
 ref bytenr=3D3112091648
> > =


> > backref bytes do not match extent backref, bytenr=3D3111616512, ref by=
tes=3D638976, backref bytes=3D8192
> > =


> > backpointer mismatch on [3111616512 638976]
> > =


> > attempting to repair backref discrepancy for bytenr 3111616512
> > =


> > ref mismatch on [3111260160 8192] extent item 0, found 1
> > =


> > data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3111260160 root 257 owner 488963 offs=
et 0 found 1 wanted 0 back 0x55d578005140
> > =


> > backpointer mismatch on [3111260160 8192]
> > =


> > adding new data backref on 3111260160 root 257 owner 488963 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3111260160
> > =


> > ref mismatch on [3111411712 12288] extent item 0, found 1
> > =


> > data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 n=
ot found in extent tree
> > =


> > incorrect local backref count on 3111411712 root 257 owner 488887 offs=
et 4096 found 1 wanted 0 back 0x55d577576b70
> > =


> > backpointer mismatch on [3111411712 12288]
> > =


> > adding new data backref on 3111411712 root 257 owner 488887 offset 409=
6 found 1
> > =


> > Repaired extent references for 3111411712
> > =


> > ref mismatch on [3111436288 16384] extent item 0, found 1
> > =


> > data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 n=
ot found in extent tree
> > =


> > incorrect local backref count on 3111436288 root 257 owner 488889 offs=
et 4096 found 1 wanted 0 back 0x55d56a2e5c40
> > =


> > backpointer mismatch on [3111436288 16384]
> > =


> > adding new data backref on 3111436288 root 257 owner 488889 offset 409=
6 found 1
> > =


> > Repaired extent references for 3111436288
> > =


> > ref mismatch on [3111489536 8192] extent item 0, found 1
> > =


> > data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3111489536 root 257 owner 488964 offs=
et 0 found 1 wanted 0 back 0x55d56b770820
> > =


> > backpointer mismatch on [3111489536 8192]
> > =


> > adding new data backref on 3111489536 root 257 owner 488964 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3111489536
> > =


> > ref mismatch on [3111616512 638976] extent item 25, found 26
> > =


> > data backref 3111616512 root 257 owner 488965 offset 18446744073709076=
480 num_refs 0 not found in extent tree
> > =


> > incorrect local backref count on 3111616512 root 257 owner 488965 offs=
et 18446744073709076480 found 1 wanted 0 back 0x55d576f3cab0
> > =


> > backpointer mismatch on [3111616512 638976]
> > =


> > repair deleting extent record: key [3111616512,168,638976]
> > =


> > adding new data backref on 3111616512 root 257 owner 31924 offset 5496=
832 found 25
> > =


> > adding new data backref on 3111616512 root 257 owner 488965 offset 184=
46744073709076480 found 1
> > =


> > Repaired extent references for 3111616512
> > =


> > ref mismatch on [3123773440 8192] extent item 0, found 1
> > =


> > data backref 3123773440 root 257 owner 488966 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3123773440 root 257 owner 488966 offs=
et 0 found 1 wanted 0 back 0x55d56bb7b6e0
> > =


> > backpointer mismatch on [3123773440 8192]
> > =


> > adding new data backref on 3123773440 root 257 owner 488966 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3123773440
> > =


> > ref mismatch on [3124051968 12288] extent item 0, found 1
> > =


> > data backref 3124051968 root 257 owner 488895 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3124051968 root 257 owner 488895 offs=
et 0 found 1 wanted 0 back 0x55d56ac11990
> > =


> > backpointer mismatch on [3124051968 12288]
> > =


> > adding new data backref on 3124051968 root 257 owner 488895 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3124051968
> > =


> > ref mismatch on [3124080640 8192] extent item 0, found 1
> > =


> > data backref 3124080640 root 257 owner 488967 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3124080640 root 257 owner 488967 offs=
et 0 found 1 wanted 0 back 0x55d577900d10
> > =


> > backpointer mismatch on [3124080640 8192]
> > =


> > adding new data backref on 3124080640 root 257 owner 488967 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3124080640
> > =


> > ref mismatch on [3124252672 208896] extent item 12, found 13
> > =


> > data backref 3124252672 root 257 owner 488902 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3124252672 root 257 owner 488902 offs=
et 0 found 1 wanted 0 back 0x55d56b005980
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3124252672,=
 ref bytenr=3D3124428800
> > =


> > backref bytes do not match extent backref, bytenr=3D3124252672, ref by=
tes=3D208896, backref bytes=3D12288
> > =


> > backpointer mismatch on [3124252672 208896]
> > =


> > attempting to repair backref discrepancy for bytenr 3124252672
> > =


> > ref mismatch on [3111260160 8192] extent item 0, found 1
> > =


> > data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3111260160 root 257 owner 488963 offs=
et 0 found 1 wanted 0 back 0x55d576dbdef0
> > =


> > backpointer mismatch on [3111260160 8192]
> > =


> > adding new data backref on 3111260160 root 257 owner 488963 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3111260160
> > =


> > ref mismatch on [3111411712 12288] extent item 0, found 1
> > =


> > data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 n=
ot found in extent tree
> > =


> > incorrect local backref count on 3111411712 root 257 owner 488887 offs=
et 4096 found 1 wanted 0 back 0x55d56b68d090
> > =


> > backpointer mismatch on [3111411712 12288]
> > =


> > adding new data backref on 3111411712 root 257 owner 488887 offset 409=
6 found 1
> > =


> > Repaired extent references for 3111411712
> > =


> > ref mismatch on [3111436288 16384] extent item 0, found 1
> > =


> > data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 n=
ot found in extent tree
> > =


> > incorrect local backref count on 3111436288 root 257 owner 488889 offs=
et 4096 found 1 wanted 0 back 0x55d576c0fb70
> > =


> > backpointer mismatch on [3111436288 16384]
> > =


> > adding new data backref on 3111436288 root 257 owner 488889 offset 409=
6 found 1
> > =


> > Repaired extent references for 3111436288
> > =


> > ref mismatch on [3111489536 8192] extent item 0, found 1
> > =


> > data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3111489536 root 257 owner 488964 offs=
et 0 found 1 wanted 0 back 0x55d56ab85320
> > =


> > backpointer mismatch on [3111489536 8192]
> > =


> > adding new data backref on 3111489536 root 257 owner 488964 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3111489536
> > =


> > ref mismatch on [3123773440 8192] extent item 0, found 1
> > =


> > data backref 3123773440 root 257 owner 488966 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3123773440 root 257 owner 488966 offs=
et 0 found 1 wanted 0 back 0x55d56ab937e0
> > =


> > backpointer mismatch on [3123773440 8192]
> > =


> > adding new data backref on 3123773440 root 257 owner 488966 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3123773440
> > =


> > ref mismatch on [3124051968 12288] extent item 0, found 1
> > =


> > data backref 3124051968 root 257 owner 488895 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3124051968 root 257 owner 488895 offs=
et 0 found 1 wanted 0 back 0x55d576c155b0
> > =


> > backpointer mismatch on [3124051968 12288]
> > =


> > adding new data backref on 3124051968 root 257 owner 488895 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3124051968
> > =


> > ref mismatch on [3124080640 8192] extent item 0, found 1
> > =


> > data backref 3124080640 root 257 owner 488967 offset 0 num_refs 0 not =
found in extent tree
> > =


> > incorrect local backref count on 3124080640 root 257 owner 488967 offs=
et 0 found 1 wanted 0 back 0x55d56b031700
> > =


> > backpointer mismatch on [3124080640 8192]
> > =


> > adding new data backref on 3124080640 root 257 owner 488967 offset 0 f=
ound 1
> > =


> > Repaired extent references for 3124080640
> > =


> > ref mismatch on [3124252672 208896] extent item 12, found 13
> > =


> > data backref 3124252672 root 257 owner 488902 offset 18446744073709375=
488 num_refs 0 not found in extent tree
> > =


> > incorrect local backref count on 3124252672 root 257 owner 488902 offs=
et 18446744073709375488 found 1 wanted 0 back 0x55d5773b8b20
> > =


> > backpointer mismatch on [3124252672 208896]
> > =


> > repair deleting extent record: key [3124252672,168,208896]
> > =


> > adding new data backref on 3124252672 root 257 owner 31924 offset 7163=
904 found 12
> > =


> > adding new data backref on 3124252672 root 257 owner 488902 offset 184=
46744073709375488 found 1
> > =


> > Repaired extent references for 3124252672
> > =


> > No device size related problem found
> > =


> > [3/7] checking free space cache
> > =


> > [4/7] checking fs roots
> > =


> > root 257 inode 31924 errors 1000, some csum missing
> > =


> > ERROR: errors found in fs roots
> > =


> > found 427087040512 bytes used, error(s) found
> > =


> > total csum bytes: 415797096
> > =


> > total tree bytes: 1277558784
> > =


> > total fs tree bytes: 682033152
> > =


> > total extent tree bytes: 89456640
> > =


> > btree space waste bytes: 252979190
> > =


> > file data blocks allocated: 516356227072
> > =


> > referenced 424745533440
> > =


> > $ btrfs check /dev/nvme0n1p4
> > =


> > Opening filesystem to check...
> > =


> > Checking filesystem on /dev/nvme0n1p4
> > =


> > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > =


> > [1/7] checking root items
> > =


> > [2/7] checking extents
> > =


> > extent item 3109511168 has multiple extent items
> > =


> > ref mismatch on [3109511168 2105344] extent item 1, found 5
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111489536
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111260160
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111411712
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D12288
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111436288
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D16384
> > =


> > backpointer mismatch on [3109511168 2105344]
> > =


> > extent item 3121950720 has multiple extent items
> > =


> > ref mismatch on [3121950720 2220032] extent item 1, found 4
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3124080640
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3123773440
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3124051968
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D12288
> > =


> > backpointer mismatch on [3121950720 2220032]
> =


> Those offending blocks are some data extents.

$ sudo ./btrfs inspect-internal logical-resolve 3109511168 /mnt/hippo/
/mnt/hippo/home-andrey/.config/SpiderOakONE/tss_external_blocks_pandora_sq=
liite_database/00000011

$ sudo ./btrfs inspect-internal logical-resolve 3121950720 /mnt/hippo/
/mnt/hippo/home-andrey/.config/SpiderOakONE/tss_external_blocks_pandora_sq=
liite_database/00000011

I remember it was complaining about the file when I was backing things up.
This file can be easily dropped -- I already rebuilt SpiderOak database an=
yway since I couldn't back it up.

> Can you use some newer btrfs-progs and run check on it again? (not yet
> repair)
> =


> This time in both original and lowmem mode.
> =


> As the involved btrfs-progs is pretty old, thus newer btrfs-progs (the
> newer the better) may cause some difference.
> (Sorry, I should mention it earlier)

No worries.

Just built the latest tag from btrfs-progs repository with
./configure --prefix=3D"${PWD}/_install" --disable-documentation --disable=
-shared --disable-convert --disable-python --disable-zoned


$ ./btrfs --version
btrfs-progs v5.13.1


$ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 257 EXTENT_DATA[31924 5689344] csum missing, have: 36864, expe=
cted: 40960
ERROR: errors found in fs roots
found 71181221888 bytes used, error(s) found
total csum bytes: 69299516
total tree bytes: 212942848
total fs tree bytes: 113672192
total extent tree bytes: 14925824
btree space waste bytes: 42179056
file data blocks allocated: 86059712512
 referenced 70790922240


$ sudo ./btrfs check /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
extent item 3109511168 has multiple extent items
ref mismatch on [3109511168 2105344] extent item 1, found 5
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111489536
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111260160
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111411712
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D12288
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111436288
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D16384
backpointer mismatch on [3109511168 2105344]
extent item 3121950720 has multiple extent items
ref mismatch on [3121950720 2220032] extent item 1, found 4
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3124080640
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3123773440
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3124051968
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D12288
backpointer mismatch on [3121950720 2220032]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
root 257 inode 31924 errors 1000, some csum missing
ERROR: errors found in fs roots
found 71181148160 bytes used, error(s) found
total csum bytes: 69299516
total tree bytes: 212942848
total fs tree bytes: 113672192
total extent tree bytes: 14925824
btree space waste bytes: 42179056
file data blocks allocated: 86059712512
 referenced 70790922240


> Thanks,
> =


> Qu
-----------------------106c28cdb4c495bae700ef4c7efb2d8b--

--------5dc4c5d640ce5132871903c7932fec378d66bb164de4d9fcd813df5c7ffe4ca6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmE1lA8AIQkQansmvPyL2SsWIQSmC4s1WhXLLzG+OkVqeya8
/IvZK5vLAP9y/md7hSFF5cTh/tSBpOt1PqsSevwLPRP/e/3Yq3a5LwD+JWPZ
9QM+iWk8cM5aIxeKhOw60h5+IrlFPkr0nKTSpww=
=/Fhk
-----END PGP SIGNATURE-----


--------5dc4c5d640ce5132871903c7932fec378d66bb164de4d9fcd813df5c7ffe4ca6--

