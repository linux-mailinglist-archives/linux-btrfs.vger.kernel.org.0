Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8B14AAFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgA0UId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 15:08:33 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:55622 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgA0UId (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 15:08:33 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 1F1A31121;
        Mon, 27 Jan 2020 21:08:30 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1580155710;
        bh=Sh6QXhJHS593ekIREezojKyYv1v963rYWi+qJbY6M00=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References;
        b=lkCfQmxp14PTWdQeJ4/ho9+dnDTpLOlNb4Avz6ep/mbRxaWa72ReYRmNCxZzFvgMX
         vYyvuipk664zsfjkvL7cxXI7MUB+sWFGn7EdjOu13U2UUp5fHsimdPNUYFxjiCdSko
         +n2cIbcn6OD9XytjQS4cxq1PIBBt97rK9j2GdKwI=
MIME-Version: 1.0
Date:   Mon, 27 Jan 2020 20:08:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <0a47ec399b812248c20be4933eaa6195@lesimple.fr>
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of
 memory
To:     fdmanana@gmail.com
Cc:     "Craig Andrews" <candrews@integralblue.com>,
        "linux-btrfs" <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H4-3Mg2GUf2JMMFem77sSQR5opN9dxdvHz2kk1Qd=RD=A@mail.gmail.com>
References: <CAL3q7H4-3Mg2GUf2JMMFem77sSQR5opN9dxdvHz2kk1Qd=RD=A@mail.gmail.com>
 <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz>
 <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
 <8254df450ca61dd4cbc455f19ee28c01@lesimple.fr>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>> # btrfs send -v /tank/backups/.snaps/incoming/sendme/ | pv 2>/dev/pts/=
23 | btrfs rec -E 0 /newfs/=0A>> At subvol /tank/backups/.snaps/incoming/=
sendme/=0A>> At subvol sendme=0A>> ERROR: failed to clone extents to retr=
oarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid=0A>> argument=0A=
>> ERROR: failed to clone extents to retroarch/x86_64/cores/mednafen_satu=
rn_libretro.dll: Invalid=0A>> argument=0A> =0A> This is probably the same=
 case for which I sent a fix last week:=0A> =0A> https://patchwork.kernel=
.org/patch/11350129=0A=0AThis seems very likely, as there is indeed a hol=
e in the middle of the file:=0A=0A         0: ram    80000 disk(0) 25871f=
b42000:00000000-00080000 disk_sz    80000=0A     80000: ram    80000 disk=
(0) 258720475000:00000000-00080000 disk_sz    80000=0A    100000: ram    =
80000 disk(0) 2587215d4000:00000000-00080000 disk_sz    80000=0A    18000=
0: ram    80000 disk(0) 258721654000:00000000-00080000 disk_sz    80000=
=0A    200000: ram    80000 disk(0) 25872177c000:00000000-00080000 disk_s=
z    80000=0A    280000: ram    80000 disk(0) 258722383000:00000000-00080=
000 disk_sz    80000=0A    300000: ram    80000 disk(0) 258722544000:0000=
0000-00080000 disk_sz    80000=0A    380000: ram    80000 disk(0) 25871c3=
a8000:00000000-00080000 disk_sz    80000=0A    400000: ram    80000 disk(=
0) 25871c428000:00000000-00080000 disk_sz    80000=0A    480000: ram    8=
0000 disk(0) 25871c548000:00000000-00080000 disk_sz    80000=0A    500000=
: ram    80000 disk(0) 25871cf02000:00000000-00080000 disk_sz    80000=0A=
    580000: ram    80000 disk(0) 25871cf82000:00000000-00080000 disk_sz  =
  80000=0A    600000: ram    80000 disk(0) 25871d41f000:00000000-00080000=
 disk_sz    80000=0A    680000: ram    80000 disk(0) 25871d833000:0000000=
0-00080000 disk_sz    80000=0A    700000: ram     b000 disk(0)  b9e86aeb0=
00:00000000-0000b000 disk_sz     b000=0A    70b000: ram    11000 disk(0) =
           0:00000000-00011000 disk_sz        0 -- hole=0A    71c000: ram=
    80000 disk(0) 25871eb75000:00000000-00080000 disk_sz    80000=0A    7=
9c000: ram     1000 disk(0)  a00b6523000:00000000-00001000 disk_sz     10=
00=0A    79d000: ram     1000 disk(0)  a00b6cf5000:00000000-00001000 disk=
_sz     1000=0A    79e000: ram     1000 disk(0)  a00b6cf5000:00000000-000=
01000 disk_sz     1000=0A    79f000: ram     1000 disk(0)  a00b6cf5000:00=
000000-00001000 disk_sz     1000=0A    7a0000: ram     1000 disk(0)  a00b=
6d42000:00000000-00001000 disk_sz     1000=0A    7a1000: ram     1000 dis=
k(0)  a9573bfa000:00000000-00001000 disk_sz     6000=0A    7a2000: ram   =
  1000 disk(0)  a9573bfa000:00000000-00001000 disk_sz     6000=0A    7a30=
00: ram     6000 disk(0)  a9573bfa000:00000000-00006000 disk_sz     6000=
=0A    7a9000: ram     1000 disk(0)  af4f6240000:00000000-00001000 disk_s=
z    2d000=0A    7aa000: ram     1000 disk(0)  af4f6240000:00000000-00001=
000 disk_sz    2d000=0A    7ab000: ram    2d000 disk(0)  af4f6240000:0000=
0000-0002d000 disk_sz    2d000=0A    7d8000: ram     1000 disk(0) 1c8d313=
ba000:0001d000-0001e000 disk_sz    80000=0A    7d9000: ram    43000 disk(=
0)  a983253d000:00000000-00043000 disk_sz    43000=0A    81c000: ram    8=
0000 disk(0) 258721f18000:00000000-00080000 disk_sz    80000=0A    89c000=
: ram    80000 disk(0) 258721f98000:00000000-00080000 disk_sz    80000=0A=
    91c000: ram    80000 disk(0) 258722018000:00000000-00080000 disk_sz  =
  80000=0A    99c000: ram    80000 disk(0) 2587229a2000:00000000-00080000=
 disk_sz    80000=0A    a1c000: ram     d000 disk(0)  bfa6df44000:0000000=
0-0000d000 disk_sz     e000=0A    a29000: ram     1000 disk(0) 130963b990=
00:00a29000-00a2a000 disk_sz   a2a000=0Afile: mednafen_saturn_libretro.dl=
l extents 29 disk size 21741568 logical size 10653836 ratio 0.49=0A=0ATha=
nks!=0A=0A-- =0ASt=C3=A9phane.
