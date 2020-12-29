Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA82E6FD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 12:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgL2LJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 06:09:13 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:36542 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726061AbgL2LJN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 06:09:13 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 22E0F452;
        Tue, 29 Dec 2020 12:08:31 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609240111;
        bh=zVa7qChReT3SUBDPjTQG4uiVK49n7v9sGMUMctegQ44=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=ZgrOfRgE/Xf8I0x2QMcPXe8NGrVhyedHw9uCW3qIn/hvJ54Ca4whTqS74OJgLHC49
         Vq1mOkszxQ3mSakTvWwtprMomirAj+AyDqs+aDyBpapGvNdc5jXUPL3sEl31r1exEX
         SFBOIivLsbWp5lVgSfN4cSxF98livwvq/uEgBQGQ=
MIME-Version: 1.0
Date:   Tue, 29 Dec 2020 11:08:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
Subject: Re: [PATCH] btrfs: relocation: output warning message for
 leftover v1 space cache before aborting current data balance
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Qu Wenruo" <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
References: <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
 <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

December 29, 2020 11:31 AM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:=
=0A=0A>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep=
 EXTENT_DA=0A>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 5=
3=0A>> item 12 key (72271 EXTENT_DATA 0) itemoff 14310 itemsize 53=0A>> i=
tem 25 key (74907 EXTENT_DATA 0) itemoff 12230 itemsize 53=0A> =0A> Mind =
to dump all those related inodes?=0A> =0A> E.g:=0A> =0A> $ btrfs ins dump=
-tree -t root <dev> | gerp 51933 -C 10=0A=0ASure. I added -w to avoid gre=
pping big numbers just containing the digits 51933:=0A=0A# btrfs ins dump=
-tree -t root /dev/mapper/luks-tank-mdata | grep 51933 -C 10 -w=0A       =
         generation 2614632 root_dirid 256 bytenr 42705449811968 level 2 =
refs 1=0A                lastsnap 2614456 byte_limit 0 bytes_used 1011548=
16 flags 0x1(RDONLY)=0A                uuid 1100ff6c-45fa-824d-ad93-869c9=
4a87c7b=0A                parent_uuid 8bb8a884-ea4f-d743-8b0c-b6fdecbc397=
c=0A                ctransid 1337630 otransid 1249372 stransid 0 rtransid=
 0=0A                ctime 1554266422.693480985 (2019-04-03 06:40:22)=0A =
               otime 1547877605.465117667 (2019-01-19 07:00:05)=0A       =
         drop key (0 UNKNOWN.0 0) level 0=0A        item 25 key (51098 RO=
OT_BACKREF 5) itemoff 10067 itemsize 42=0A                root backref ke=
y dirid 534 sequence 22219 name 20190119_070006_hourly.7=0A        item 2=
6 key (51933 INODE_ITEM 0) itemoff 9907 itemsize 160=0A                ge=
neration 0 transid 1517381 size 262144 nbytes 30553407488=0A             =
   block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0=0A               =
 sequence 116552 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)=0A  =
              atime 0.0 (1970-01-01 01:00:00)=0A                ctime 156=
7904822.739884119 (2019-09-08 03:07:02)=0A                mtime 0.0 (1970=
-01-01 01:00:00)=0A                otime 0.0 (1970-01-01 01:00:00)=0A    =
    item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53=0A        =
        generation 1517381 type 2 (prealloc)=0A                prealloc d=
ata disk byte 34626327621632 nr 262144=0A                prealloc data of=
fset 0 nr 262144=0A        item 28 key (52262 ROOT_ITEM 0) itemoff 9415 i=
temsize 439=0A                generation 2618893 root_dirid 256 bytenr 42=
677048360960 level 3 refs 1=0A                lastsnap 2618893 byte_limit=
 0 bytes_used 5557338112 flags 0x0(none)=0A                uuid d0d4361f-=
d231-6d40-8901-fe506e4b2b53=0A                ctransid 2618893 otransid 1=
277275 stransid 0 rtransid 0=0A                ctime 1609211576.181355141=
 (2020-12-29 04:12:56)=0A                otime 1550343531.349394412 (2019=
-02-16 19:58:51)=0A=0A> The point here is to show if we have INODE_ITEM h=
ere for the inode number.=0A=0AI think we do, if I understand the output =
correctly!=0A=0A> Although above ins dump should work, I just want to be =
extra sure about=0A> where the -ENOENT comes from.=0A> =0A> Would you min=
d to test the following debug output?=0A=0AHere you go:=0A=0A[  438.26048=
3] BTRFS info (device dm-10): balance: start -dvrange=3D34625344765952..3=
4625344765953=0A[  438.269018] BTRFS info (device dm-10): relocating bloc=
k group 34625344765952 flags data|raid1=0A[  450.439609] BTRFS info (devi=
ce dm-10): found 167 extents, stage: move data extents=0A[  451.026349] d=
elete_v1_space_cache: no FILE_EXTENT found, leaf start=3D42676709441536 d=
ata_bytenr=3D34626327621632=0A[  451.026353] BTRFS warning (device dm-10)=
: leftover v1 space cache found, please use btrfs-check --clear-space-cac=
he v1 to clean it up=0A[  463.501781] BTRFS info (device dm-10): balance:=
 ended with status: -2=0A=0ARegards,=0A=0ASt=C3=A9phane.
