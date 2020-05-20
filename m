Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272891DB770
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgETOvO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 10:51:14 -0400
Received: from mailrelay1-3.pub.mailoutpod1-cph3.one.com ([46.30.212.10]:52893
        "EHLO mailrelay1-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbgETOvN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 10:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:references:
         in-reply-to:message-id:to:from:date:from;
        bh=wDnWs2D+sXzjAN2aHhNmyA5CX+RsQghfuk3bp2ufxWs=;
        b=NqE6blk5HUsxj/JjbmvD/iT0ufE2CSlrfqAqSxtjJ9ZzCRPWKRSFZBHct2alG/gHAp0fDKxaFHYkW
         huUwfXxNRV/fB0Gv1xpkoi04GkM0nubMjj7sREBxSRNm824+QJk9gxAcexiMRcVKfdmpsMlpmSFcJ0
         L4B7kGFPlefqJC5JJbJB0lLr+G3xbu2R7N4+a3WhOaYN06rZJ3/8ucyN+W/IIB7waLZCylAVZyVk7N
         ZuEx02+vjj9ouswrfjDc3rYv5HMQtJGLkVLatgJnGAEZ9mpyiAhHcOZL7fCOXHQopdZSGIaGVzsyuZ
         ZWIpcl+jkxmjzL+ORBnkYNTm6ZUKpuA==
X-HalOne-Cookie: e6c167244d61672054fc1834328abe6a8a42268d
X-HalOne-ID: 579521be-9aa9-11ea-be5e-d0431ea8a283
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 579521be-9aa9-11ea-be5e-d0431ea8a283;
        Wed, 20 May 2020 14:51:10 +0000 (UTC)
Date:   Wed, 20 May 2020 16:51:08 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     Panicx <panicx@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <fec9597.90271dac.172329113d2@lechevalier.se>
In-Reply-To: <CAHzb4voyyBxOPNV0b72XTNTP6jNGibki+UMF31U_HqumUSMfSg@mail.gmail.com>
References: <CAHzb4voyyBxOPNV0b72XTNTP6jNGibki+UMF31U_HqumUSMfSg@mail.gmail.com>
Subject: Re: BTRFS RAID 5 Array looks clean in some states, but cannot mount
 and cannot recover
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I suggest you check on #btrfs on freenode irc. They are very helpful th=
ere. Don't try to recover more before you get advice.=20

Good luck!=20

---- From: Panicx <panicx@gmail.com> -- Sent: 2020-05-20 - 16:46 ----

> Hello all,
>=20
> I had a recovery event a few days ago that completed, and as far as I
> can tell, the array is clean.
> root@xubuntu:/mnt/md0# mdadm -D /dev/mapper/vg0-lv0
> /dev/mapper/vg0-lv0:
>         Version : 1.2
>   Creation Time : Mon Mar 30 19:44:30 2020
>      Raid Level : raid5
>      Array Size : 17571291136 (16757.29 GiB 17993.00 GB)
>   Used Dev Size : unknown
>    Raid Devices : 4
>   Total Devices : 4
>     Persistence : Superblock is persistent
>=20
>   Intent Bitmap : Internal
>=20
>     Update Time : Tue May 19 19:04:43 2020
>           State : clean
>  Active Devices : 4
> Working Devices : 4
>  Failed Devices : 0
>   Spare Devices : 0
>=20
>          Layout : left-symmetric
>      Chunk Size : 128K
>=20
>            Name : TNAS-2CC8E6:UTOSUSER-X86-S64
>            UUID : cc80e7cd:c6b902c4:ef36b897:409e8f96
>          Events : 18518
>=20
>     Number   Major   Minor   RaidDevice State
>        0       8       20        0      active sync   /dev/sdb4
>        1       8       36        1      active sync   /dev/sdc4
>        2       8       52        2      active sync   /dev/sdd4
>        4       8        4        3      active sync   /dev/sda4
>=20
> I cannot mount it:
> root@xubuntu:/mnt/md0# mount -t btrfs /dev/mapper/vg0-lv0 /mnt/md0/
> mount: /mnt/md0: wrong fs type, bad option, bad superblock on
> /dev/mapper/vg0-lv0, missing codepage or helper program, or other
> error.
>=20
> I cannot check it:
> root@xubuntu:/mnt/md0# btrfsck /dev/mapper/vg0-lv0
> bytenr mismatch, want=3D441707118592, have=3D0
> Couldn't read tree root
> ERROR: cannot open file system
>=20
> I cannot mount it readonly with the backuproot option, either:
> root@xubuntu:/mnt/md0# mount -t btrfs -o ro,usebackuproot
> /dev/mapper/vg0-lv0 /mnt/md0/
> mount: /mnt/md0: wrong fs type, bad option, bad superblock on
> /dev/mapper/vg0-lv0, missing codepage or helper program, or other
> error.
>=20
> Please help :)  I'd like to get some baby photos/vids out of that
> array before I call it a lost cause.  Some of the photos are for
> babies that aren't here anymore, and they are all I have.
>=20
> root@xubuntu:/mnt/md0#   uname -a
> Linux xubuntu 4.15.0-20-generic #21-Ubuntu SMP Tue Apr 24 06:15:38 UTC
> 2018 i686 i686 i686 GNU/Linux
> root@xubuntu:/mnt/md0#   btrfs --version
> btrfs-progs v4.15.1
> root@xubuntu:/mnt/md0#   btrfs fi show
> Label: none  uuid: 9ef00e00-ea8a-4b29-b8b1-4ce6e85a7e7f
>         Total devices 1 FS bytes used 5.59TiB
>         devid    1 size 16.36TiB used 5.64TiB path /dev/mapper/vg0-lv0
> ## Note: I cannot mount the filesystem:
> root@xubuntu:/mnt/md0# btrfs fi df /mnt/md0
> ERROR: not a btrfs filesystem: /mnt/md0


