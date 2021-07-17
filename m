Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB083CC1BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhGQICx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jul 2021 04:02:53 -0400
Received: from mx1.simplelogin.co ([94.237.111.15]:38264 "EHLO
        mx1.simplelogin.co" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhGQICw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jul 2021 04:02:52 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Jul 2021 04:02:51 EDT
X-SimpleLogin-Client-IP: 94.237.111.15
Received: from [172.17.0.3] (mx1.simplelogin.co [94.237.111.15])
        by mx1.simplelogin.co (Postfix) with ESMTP id 96A4260F3E
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 07:51:04 +0000 (UTC)
Subject: Re: Read time tree block corruption detected
In-Reply-To: <162650555086.7.16811903270475408953.10183708@simplelogin.co>
References: <162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com>
 <162650555086.7.16811903270475408953.10183708@simplelogin.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   pepperpoint@mb.ardentcoding.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <162650826457.7.3646945653543351510.10184549@mb.ardentcoding.com>
Date:   Sat, 17 Jul 2021 07:51:04 -0000
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 10184549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;  d=mb.ardentcoding.com;
 i=@mb.ardentcoding.com; q=dns/txt; s=dkim;  t=1626508264; h=from : to;
  bh=2uIuQP7FANIPeCAjSQ6bGLnNt3jMjW9vunP9yXWkjbM=;
  b=xwJGiquFDHms1wXEkiOu3parFql2AlxDM9tbUGz0jR+cvr4HNBfvhoQgqIdougExtwdJn
  83c4At8HJMkEHGnMXBdTzoNlmZkORdO7zcJ30P7YVXFX+IqHAk1w20BGDiujWCvhFPVXHrA
  JN1JZUG7jsGMwkq7fLtpAFMWCsQ/0FE= 
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Please see below for the dump.

btrfs-progs v5.12.1
leaf 174113599488 items 18 free space 2008 generation 1330906 owner 363
leaf 174113599488 flags 0x1(WRITTEN) backref revision 1
fs uuid a7d327c4-8594-4116-a6f8-8aa2a4162063
chunk uuid f885f49e-14a0-4c80-9c12-c2302b9a0229
=09item 0 key (5471 INODE_ITEM 0) itemoff 3835 itemsize 160
=09=09generation 2063 transid 27726 size 40 nbytes 40
=09=09block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
=09=09sequence 1501 flags 0x0(none)
=09=09atime 1386484844.468769570 (2013-12-08 14:40:44)
=09=09ctime 1386484844.468769570 (2013-12-08 14:40:44)
=09=09mtime 1386484844.468769570 (2013-12-08 14:40:44)
=09=09otime 0.0 (1970-01-01 08:00:00)
=09item 1 key (5471 INODE_REF 4399) itemoff 3824 itemsize 11
=09=09index 12 namelen 1 name: 8
=09item 2 key (5471 EXTENT_DATA 0) itemoff 3763 itemsize 61
=09=09generation 27726 type 0 (inline)
=09=09inline extent data size 40 ram_bytes 40 compression 0 (none)
=09item 3 key (5645 INODE_ITEM 0) itemoff 3603 itemsize 160
=09=09generation 2542 transid 61261 size 40 nbytes 40
=09=09block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
=09=09sequence 24769 flags 0x0(none)
=09=09atime 1394335806.351857522 (2014-03-09 11:30:06)
=09=09ctime 1394335827.344389955 (2014-03-09 11:30:27)
=09=09mtime 1394335827.344389955 (2014-03-09 11:30:27)
=09=09otime 0.0 (1970-01-01 08:00:00)
=09item 4 key (5645 INODE_REF 4399) itemoff 3592 itemsize 11
=09=09index 13 namelen 1 name: 7
=09item 5 key (5645 EXTENT_DATA 0) itemoff 3531 itemsize 61
=09=09generation 61261 type 0 (inline)
=09=09inline extent data size 40 ram_bytes 40 compression 0 (none)
=09item 6 key (7222 INODE_ITEM 0) itemoff 3371 itemsize 160
=09=09generation 5754 transid 5767 size 307 nbytes 307
=09=09block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
=09=09sequence 7 flags 0x0(none)
=09=09atime 1379834835.428558020 (2013-09-22 15:27:15)
=09=09ctime 1379834835.428558020 (2013-09-22 15:27:15)
=09=09mtime 1379834835.428558020 (2013-09-22 15:27:15)
=09=09otime 0.0 (1970-01-01 08:00:00)
=09item 7 key (7222 INODE_REF 287) itemoff 3344 itemsize 27
=09=09index 6 namelen 17 name: dhcpcd-eth0.lease
=09item 8 key (7222 EXTENT_DATA 0) itemoff 3016 itemsize 328
=09=09generation 5767 type 0 (inline)
=09=09inline extent data size 307 ram_bytes 307 compression 0 (none)
=09item 9 key (7415 INODE_ITEM 0) itemoff 2856 itemsize 160
=09=09generation 5904 transid 1330906 size 180 nbytes 0
=09=09block group 0 mode 40755 links 2 uid 0 gid 0 rdev 0
=09=09sequence 177 flags 0x0(none)
=09=09atime 1483277713.141980592 (2017-01-01 21:35:13)
=09=09ctime 1563162901.234656246 (2019-07-15 11:55:01)
=09=09mtime 1406534032.158605559 (2014-07-28 15:53:52)
=09=09otime 0.0 (1970-01-01 08:00:00)
=09item 10 key (7415 INODE_REF 260) itemoff 2837 itemsize 19
=09=09index 28 namelen 9 name: backlight
=09item 11 key (7415 INODE_REF 286) itemoff 2818 itemsize 19
=09=09index 3 namelen 9 name: backlight
=09item 12 key (7415 DIR_ITEM 3128336373) itemoff 2746 itemsize 72
=09=09location key (120417 INODE_ITEM 0) type FILE
=09=09transid 117279 data_len 0 name_len 42
=09=09name: pci-0000:00:02.0:backlight:intel_backlight
=09item 13 key (7415 DIR_ITEM 3218198317) itemoff 2705 itemsize 41
=09=09location key (7487 INODE_ITEM 0) type FILE
=09=09transid 5992 data_len 0 name_len 11
=09=09name: acpi_video0
=09item 14 key (7415 DIR_ITEM 3582254411) itemoff 2638 itemsize 67
=09=09location key (55325 INODE_ITEM 0) type FILE
=09=09transid 63351 data_len 0 name_len 37
=09=09name: platform-VPC2004:00:backlight:ideapad
=09item 15 key (7415 DIR_INDEX 2) itemoff 2597 itemsize 41
=09=09location key (7487 INODE_ITEM 0) type FILE
=09=09transid 5992 data_len 0 name_len 11
=09=09name: acpi_video0
=09item 16 key (7415 DIR_INDEX 4) itemoff 2530 itemsize 67
=09=09location key (55325 INODE_ITEM 0) type FILE
=09=09transid 63351 data_len 0 name_len 37
=09=09name: platform-VPC2004:00:backlight:ideapad
=09item 17 key (7415 DIR_INDEX 5) itemoff 2458 itemsize 72
=09=09location key (120417 INODE_ITEM 0) type FILE
=09=09transid 117279 data_len 0 name_len 42
=09=09name: pci-0000:00:02.0:backlight:intel_backlight


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Saturday, July 17th, 2021 at 3:05 PM, Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:

> On 2021/7/17 =E4=B8=8A=E5=8D=889:45, pepperpoint@mb.ardentcoding.com wrot=
e:
>
> > Hello,
> >
> > I see this message on dmesg:
> >
> > [ 2452.256756] BTRFS critical (device dm-0): corrupt leaf: root=3D363 b=
lock=3D174113599488 slot=3D9 ino=3D7415, invalid nlink: has 2 expect no mor=
e than 1 for dir
> >
> > [ 2452.256776] BTRFS error (device dm-0): block=3D174113599488 read tim=
e tree block corruption detected
>
> Please provide the following dump:
>
> btrfs ins dump-tree -b 174113599488 /dev/dm-0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thanks,
>
> Qu
>
> > When I run btrfs scrub and btrfs check, no error was detected.
> >
> > I am running Linux 5.12.15-arch1-1 and btrfs-progs v5.12.1
> >
> > How should I fix this error?
