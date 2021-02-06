Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58350311B43
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Feb 2021 06:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhBFFBd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Feb 2021 00:01:33 -0500
Received: from mail.mailmag.net ([5.135.159.181]:41970 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhBFFBI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 6 Feb 2021 00:01:08 -0500
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 70813EC0365;
        Fri,  5 Feb 2021 20:00:25 -0900 (AKST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1612587625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLiM6+HVOw3ecZqZNehdC7AaFLwnMH7AQAC1gnqs+FU=;
        b=Mu7Kgk7ja7g04AobZHaDaQvoaxOSaY3J2uyvDXfhZ6p+iY+clzIUA9QZY97tVmBvHiFUW/
        y/gl4aLr+sumJXfnHxhPBlKhcO/Z+/HEl8+26BckzZ6OR/ngL8VYkfgqovf0bb8npMIghW
        BruA9PFNZCTmeviP8Q+Nvjzp1K3BzTw=
MIME-Version: 1.0
Date:   Sat, 06 Feb 2021 05:00:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Joshua" <joshua@mailmag.net>
Message-ID: <4ea56b2ba7077892079754c2449e923f@mailmag.net>
Subject: Re: Large multi-device BTRFS array (usually) fails to mount on 
 boot.
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <45064ba0-08e5-f311-1f9e-9a4ec62abaab@gmx.com>
References: <45064ba0-08e5-f311-1f9e-9a4ec62abaab@gmx.com>
 <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1612587625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLiM6+HVOw3ecZqZNehdC7AaFLwnMH7AQAC1gnqs+FU=;
        b=N9sOtqlGduWgvkeHWB3oOCxLJ9i3u+2A6dQurtfoeohIzRPMgaA5y4Dp/2cNKsEPE7De8V
        nG7wzTIf2Vu9ifvm0WeL0orBHlHBk4kXY/uLGe5IzoLNGbFPcdnjEXSZbDYjGI2WoEpfIM
        yjFCe3E49tGt0tJ+/iCqXw6+T9rMWPs=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1612587625; a=rsa-sha256; cv=none;
        b=EeTXfxoFdwJb5z9718pfYE7RpXSVNaT78JFClwBLtPAQY6fHCcToS08XpiNpHTvoYLSR1h
        Uvy0r0/Mc0xd+Luzw8shSrucmPELFrYFbH8JXGzU5taZY2hdODWUxvcil8vcGSu3wZLe/s
        wxtHNuihHWd1yeVI3YqqhOVeC5PLrYM=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

February 3, 2021 4:56 PM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:=0A=
=0A> On 2021/2/4 =E4=B8=8A=E5=8D=885:54, joshua@mailmag.net wrote:=0A> =
=0A>> Good Evening.=0A>> =0A>> I have a large BTRFS array, (14 Drives, ~1=
00 TB RAW) which has been having problems mounting on=0A>> boot without t=
iming out. This causes the system to drop to emergency mode. I am then ab=
le to mount=0A>> the array in emergency mode and all data appears fine, b=
ut upon reboot it fails again.=0A>> =0A>> I actually first had this probl=
em around a year ago, and initially put considerable effort into=0A>> ext=
ending the timeout in systemd, as I believed that to be the problem. Howe=
ver, all the methods I=0A>> attempted did not work properly or caused the=
 system to continue booting before the array was=0A>> mounted, causing al=
l sorts of issues. Eventually, I was able to almost completely resolve it=
 by=0A>> defragmenting the extent tree and subvolume tree for each subvol=
ume. (btrfs fi defrag=0A>> /mountpoint/subvolume/) This seemed to reduce =
the time required to mount, and made it mount on boot=0A>> the majority o=
f the time.=0A>> =0A>> Recently I expanded the array yet again by adding =
another drive, (and some more data) and now I am=0A>> having the same iss=
ue again. I've posted the relevant entries from my dmesg, as well as some=
=0A>> information on my array and system below. I ran a defrag as mention=
ed above on each subvolume, and=0A>> was able to get the system to boot s=
uccessfully. Any ideas on a more reliable and permanent=0A>> solution thi=
s this? Thanks much!=0A>> =0A>> dmesg entries upon boot:=0A>> [ 22.775439=
] BTRFS info (device sdh): use lzo compression, level 0=0A>> [ 22.775441]=
 BTRFS info (device sdh): using free space tree=0A>> [ 22.775442] BTRFS i=
nfo (device sdh): has skinny extents=0A>> [ 124.250554] BTRFS error (devi=
ce sdh): open_ctree failed=0A>> =0A>> dmesg entries after running 'mount =
-a' in emergency mode:=0A>> [ 178.317339] BTRFS info (device sdh): force =
zstd compression, level 2=0A>> [ 178.317342] BTRFS info (device sdh): usi=
ng free space tree=0A>> [ 178.317343] BTRFS info (device sdh): has skinny=
 extents=0A>> =0A>> uname -a:=0A>> Linux HOSTNAME 5.10.0-2-amd64 #1 SMP D=
ebian 5.10.9-1 (2021-01-20) x86-64 GNU/Linux=0A>> =0A>> btrfs --version:=
=0A>> btrfs-progs v5.10=0A>> =0A>> btrfs fi show /mountpoint:=0A>> Label:=
 'DATA' uuid: {snip}=0A>> Total devices 14 FS bytes used 41.94TiB=0A>> de=
vid 1 size 2.73TiB used 2.46TiB path /dev/sdh=0A>> devid 2 size 7.28TiB u=
sed 6.87TiB path /dev/sdm=0A>> devid 3 size 2.73TiB used 2.46TiB path /de=
v/sdk=0A>> devid 4 size 9.10TiB used 8.57TiB path /dev/sdj=0A>> devid 5 s=
ize 9.10TiB used 8.57TiB path /dev/sde=0A>> devid 6 size 9.10TiB used 8.5=
7TiB path /dev/sdn=0A>> devid 7 size 7.28TiB used 4.65TiB path /dev/sdc=
=0A>> devid 9 size 9.10TiB used 8.57TiB path /dev/sdf=0A>> devid 10 size =
2.73TiB used 2.21TiB path /dev/sdl=0A>> devid 12 size 2.73TiB used 2.20Ti=
B path /dev/sdg=0A>> devid 13 size 9.10TiB used 8.57TiB path /dev/sdd=0A>=
> devid 15 size 7.28TiB used 6.75TiB path /dev/sda=0A>> devid 16 size 7.2=
8TiB used 6.75TiB path /dev/sdi=0A>> devid 17 size 7.28TiB used 6.75TiB p=
ath /dev/sdb=0A> =0A> With such a large array, the extent tree is conside=
rably large.=0A> =0A> And that's causing the mount time problem, as at mo=
unt we need to load=0A> each block group item into memory.=0A> When exten=
t tree goes large, the read is mostly random read which is=0A> never a go=
od thing for HDD.=0A> =0A> I was pushing skinny block group tree for btrf=
s, which arrange block=0A> group items into a very compact tree, just lik=
e chunk tree.=0A> =0A> This should greatly improve the mount performance,=
 but there are several=0A> problems:=0A> - The feature is not yet merged=
=0A> - The feature needs to convert existing fs to the new tree=0A> For y=
our fs, it may take quite some time=0A> =0A> So unfortunately, no good sh=
ort term solution yet.=0A> =0A> THanks,=0A> Qu=0A=0AThanks for the inform=
ation, that's more or less what I was wondering, but didn't really know.=
=0A=0ALuckily the solution proposed by Graham appears to be working, and =
'solved' the problem for me, allowing my system to boot reliably.=0A=0ATh=
e only remaining issue is the annoyance of boot times (mount times) being=
 so long, but luckily that's not a very big deal for my situation, and I =
don't need to reboot (mount) very frequently.=0A=0A=0AThanks,=0A--Joshua =
Villwock=0A=0A=0A>> btrfs fi usage /mountpoint:=0A>> Overall:=0A>> Device=
 size: 92.78TiB=0A>> Device allocated: 83.96TiB=0A>> Device unallocated: =
8.83TiB=0A>> Device missing: 0.00B=0A>> Used: 83.94TiB=0A>> Free (estimat=
ed): 4.42TiB (min: 2.95TiB)=0A>> Free (statfs, df): 3.31TiB=0A>> Data rat=
io: 2.00=0A>> Metadata ratio: 3.00=0A>> Global reserve: 512.00MiB (used: =
0.00B)=0A>> Multiple profiles: no=0A>> =0A>> Data,RAID1: Size:41.88TiB, U=
sed:41.877TiB (99.99%)=0A>> {snip}=0A>> =0A>> Metadata,RAID1C3: Size:68Gi=
B, Used:63.79GiB (93.81%)=0A>> {snip}=0A>> =0A>> System,RAID1C3: Size:32M=
iB, Used:6.69MiB (20.90%)=0A>> {snip}=0A>> =0A>> Unallocated:=0A>> {snip}
