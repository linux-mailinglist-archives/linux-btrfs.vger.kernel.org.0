Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9952E3113
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Dec 2020 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgL0MWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Dec 2020 07:22:47 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:58654 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726039AbgL0MWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Dec 2020 07:22:46 -0500
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Dec 2020 07:22:44 EST
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id CF3751ED
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Dec 2020 13:11:44 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609071104;
        bh=EfMtUT1IBfOh/ym578Zg0NnQ/vbZZcCpo7H/Qjy14GU=;
        h=Date:From:Subject:To;
        b=aEPB1ECQbyMLZ/Pg8awsnpO8ukKdORK6uDFQuKQhORtVbmVpTDhIEIh7DCBHMykK/
         ZqhbEQNeBgPNZeUZLyRZj+iBpajk/lnX7IkYd9mj6JbSv5sAcIusn7ThIr0a3pylW+
         iaFve/28SM74vsjgtYZXDXMxXGxOrIAYkT/iCsZk=
MIME-Version: 1.0
Date:   Sun, 27 Dec 2020 12:11:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
Subject: 5.6-5.10 balance regression?
To:     linux-btrfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,=0A=0AAs part of the maintenance routine of one of my raid1 FS, a f=
ew days ago I was in the process=0Aof replacing a 10T drive with a 16T on=
e.=0ASo I first added the new 16T drive to the FS (btrfs dev add), then s=
tarted a btrfs dev del.=0A=0AAfter a few days of balancing the block grou=
ps out of the old 10T drive,=0Athe balance aborted when around 500 GiB of=
 data was still to be moved=0Aout of the drive:=0A=0ADec 21 14:18:40 nas =
kernel: BTRFS info (device dm-10): relocating block group 11115169841152 =
flags data|raid1=0ADec 21 14:18:54 nas kernel: BTRFS info (device dm-10):=
 found 6264 extents, stage: move data extents=0ADec 21 14:19:16 nas kerne=
l: BTRFS info (device dm-10): balance: ended with status: -2=0A=0AOf cour=
se this also cancelled the device deletion, so after that the=0Adevice wa=
s still part of the FS. I then tried to do a balance manually,=0Ain an at=
tempt to reproduce the issue:=0A=0ADec 21 14:28:16 nas kernel: BTRFS info=
 (device dm-10): balance: start -ddevid=3D5,limit=3D1=0ADec 21 14:28:16 n=
as kernel: BTRFS info (device dm-10): relocating block group 111151698411=
52 flags data|raid1=0ADec 21 14:28:29 nas kernel: BTRFS info (device dm-1=
0): found 6264 extents, stage: move data extents=0ADec 21 14:28:46 nas ke=
rnel: BTRFS info (device dm-10): balance: ended with status: -2=0A=0ATher=
e were of course still plenty of room on the FS, as I added a new 16T dri=
ve=0A(a btrfs fi usage is further down this email), so it struck me as od=
d.=0ASo, I tried to lower the reduncancy temporarily, expecting the balan=
ce of this block group to=0Acomplete immediately given that there were al=
ready a copy of this data present on another drive:=0A=0ADec 21 14:38:50 =
nas kernel: BTRFS info (device dm-10): balance: start -dconvert=3Dsingle,=
soft,devid=3D5,limit=3D1=0ADec 21 14:38:50 nas kernel: BTRFS info (device=
 dm-10): relocating block group 11115169841152 flags data|raid1=0ADec 21 =
14:39:00 nas kernel: BTRFS info (device dm-10): found 6264 extents, stage=
: move data extents=0ADec 21 14:39:17 nas kernel: BTRFS info (device dm-1=
0): balance: ended with status: -2=0A=0AThat didn't work.=0AI also tried =
to mount the FS in degraded mode, with the drive I wanted to remove missi=
ng,=0Ausing btrfs dev del missing, but the balance still failed with the =
same error on the same block group.=0A=0ASo, as I was running 5.10.1 just=
 for a few days, I tried an older kernel: 5.6.17,=0Aand retried the balan=
ce once again (with still the drive voluntarily missing):=0A=0A[ 413.1888=
12] BTRFS info (device dm-10): allowing degraded mounts=0A[ 413.188814] B=
TRFS info (device dm-10): using free space tree=0A[ 413.188815] BTRFS inf=
o (device dm-10): has skinny extents=0A[ 413.189674] BTRFS warning (devic=
e dm-10): devid 5 uuid 068c6db3-3c30-4c97-b96b-5fe2d6c5d677 is missing=0A=
[ 424.159486] BTRFS info (device dm-10): balance: start -dconvert=3Dsingl=
e,soft,devid=3D5,limit=3D1=0A[ 424.772640] BTRFS info (device dm-10): rel=
ocating block group 11115169841152 flags data|raid1=0A[ 434.749100] BTRFS=
 info (device dm-10): found 6264 extents, stage: move data extents=0A[ 47=
7.703111] BTRFS info (device dm-10): found 6264 extents, stage: update da=
ta pointers=0A[ 497.941482] BTRFS info (device dm-10): balance: ended wit=
h status: 0=0A=0AThe problematic block group was balanced successfully th=
is time.=0A=0AI balanced a few more successfully (without the -dconvert=
=3Dsingle option),=0Athen decided to reboot under 5.10 just to see if I w=
ould hit this issue again.=0AI didn't: the btrfs dev del worked correctly=
 after the last 500G or so data=0Awas moved out of the drive.=0A=0AThis i=
s the output of btrfs fi usage after I successfully balanced the=0Aproble=
matic block group under the 5.6.17 kernel. Notice the multiple=0Adata pro=
file, which is expected as I used the -dconvert balance option,=0Aand als=
o the fact that apparently 3 chunks were allocated on new16T for=0Athis, =
even if only 1 seem to be used. We can tell because this is the=0Afirst a=
nd only time the balance succeeded with the -dconvert option,=0Ahence the=
se chunks are all under "data,single":=0A=0AOverall:=0ADevice size:      =
  41.89TiB=0ADevice allocated:   21.74TiB=0ADevice unallocated: 20.14TiB=
=0ADevice missing:      9.09TiB=0AUsed:               21.71TiB=0AFree (es=
timated):   10.08TiB (min: 10.07TiB)=0AData ratio:             2.00=0AMet=
adata ratio:         2.00=0AGlobal reserve:    512.00MiB (used: 0.00B)=0A=
Multiple profiles:       yes (data)=0A=0AData,single: Size:3.00GiB, Used:=
1.00GiB (33.34%)=0A/dev/mapper/luks-new16T     3.00GiB=0A=0AData,RAID1: S=
ize:10.83TiB, Used:10.83TiB (99.99%)=0A/dev/mapper/luks-10Ta       7.14Ti=
B=0A/dev/mapper/luks-10Tb       7.10TiB=0Amissing                   482.0=
0GiB=0A/dev/mapper/luks-new16T     6.95TiB=0A=0AMetadata,RAID1: Size:36.0=
0GiB, Used:23.87GiB (66.31%)=0A/dev/mapper/luks-10Tb      36.00GiB=0A/dev=
/mapper/luks-ssd-mdata 36.00GiB=0A=0ASystem,RAID1: Size:32.00MiB, Used:1.=
77MiB (5.52%)=0A/dev/mapper/luks-10Ta      32.00MiB=0A/dev/mapper/luks-10=
Tb      32.00MiB=0A=0AUnallocated:=0A/dev/mapper/luks-10Ta       1.95TiB=
=0A/dev/mapper/luks-10Tb       1.96TiB=0Amissing                     8.62=
TiB=0A/dev/mapper/luks-ssd-mdata 11.29GiB=0A/dev/mapper/luks-new16T     7=
.60TiB=0A=0AI wasn't going to send an email to this ML because I knew I h=
ad nothing=0Ato reproduce the issue noww that it was "fixed", but now I t=
hink I'm bumping=0Ainto the same issue on another FS, while rebalancing d=
ata after adding a drive,=0Awhich happens to be the old 10T drive of the =
FS above.=0A=0AThe btrfs fi usage of this second FS is as follows:=0A=0AO=
verall:=0ADevice size:        25.50TiB=0ADevice allocated:   22.95TiB=0AD=
evice unallocated:  2.55TiB=0ADevice missing:        0.00B=0AUsed:       =
        22.36TiB=0AFree (estimated):    3.14TiB (min: 1.87TiB)=0AData rat=
io:             1.00=0AMetadata ratio:         2.00=0AGlobal reserve:    =
512.00MiB (used: 0.00B)=0AMultiple profiles:        no=0A=0AData,single: =
Size:22.89TiB, Used:22.29TiB (97.40%)=0A/dev/mapper/luks-12T        10.91=
TiB=0A/dev/mapper/luks-3Ta         2.73TiB=0A/dev/mapper/luks-3Tb        =
 2.73TiB=0A/dev/mapper/luks-10T         6.52TiB=0A=0AMetadata,RAID1: Size=
:32.00GiB, Used:30.83GiB (96.34%)=0A/dev/mapper/luks-ssd-mdata2 32.00GiB=
=0A/dev/mapper/luks-10T        32.00GiB=0A=0ASystem,RAID1: Size:32.00MiB,=
 Used:2.44MiB (7.62%)=0A/dev/mapper/luks-3Tb        32.00MiB=0A/dev/mappe=
r/luks-10T        32.00MiB=0A=0AUnallocated:=0A/dev/mapper/luks-12T      =
  45.00MiB=0A/dev/mapper/luks-ssd-mdata2  4.00GiB=0A/dev/mapper/luks-3Ta =
        1.02MiB=0A/dev/mapper/luks-3Tb         2.97GiB=0A/dev/mapper/luks=
-10T         2.54TiB=0A=0AI can reproduce the problem reliably:=0A=0A# bt=
rfs bal start -dvrange=3D34625344765952..34625344765953 /tank=0AERROR: er=
ror during balancing '/tank': No such file or directory=0AThere may be mo=
re info in syslog - try dmesg | tail=0A=0A[145979.563045] BTRFS info (dev=
ice dm-10): balance: start -dvrange=3D34625344765952..34625344765953=0A[1=
45979.585572] BTRFS info (device dm-10): relocating block group 346253447=
65952 flags data|raid1=0A[145990.396585] BTRFS info (device dm-10): found=
 167 extents, stage: move data extents=0A[146002.236115] BTRFS info (devi=
ce dm-10): balance: ended with status: -2=0A=0AIf anybody is interested i=
n looking into this, this time I can leave the FS in this state.=0AThe is=
sue is reproducible, and I can live without completing the balance for th=
e next weeks=0Aor even months, as I don't think I'll need the currently u=
nallocatable space soon.=0A=0AI also made a btrfs-image of the FS, using =
btrfs-image -c 9 -t 4 -s -w.=0AIf it's of any use, I can drop it somewher=
e (51G).=0A=0AI could try to bisect manually to find which version betwee=
n 5.6.x and 5.10.1 started to behave=0Alike this, but on the first succes=
s, I won't know how to reproduce the issue a second time, as=0AI'm not 10=
0% sure it can be done solely with the btrfs-image.=0A=0ANote that anothe=
r user seem to have encoutered a similar issue in July with 5.8:=0Ahttps:=
//www.spinics.net/lists/linux-btrfs/msg103188.html=0A=0ARegards,=0A=0ASt=
=C3=A9phane Lesimple.
