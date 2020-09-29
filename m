Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1004727D222
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgI2PHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 11:07:48 -0400
Received: from mailrelay4-3.pub.mailoutpod1-cph3.one.com ([46.30.212.13]:16931
        "EHLO mailrelay4-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgI2PHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 11:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:references:
         in-reply-to:message-id:to:from:date:from;
        bh=jSbFM0eNwWPKYPm0aBbEH/A9SZG5mcCZyc69PSbSesE=;
        b=RjhhRnX37fZA1j2579iF6W6JaYbI6wiSufd64M/+TJcEIJuV2921B+0JL6FkCmFKkOn0qq5oq540c
         HTrBftKMMPbmMS2zJAA9JMTTajTh/xQNzKiYtJ1tB3+13ywDfArDquXEK9iuZSivD2IfZp6V9Vadg/
         UwpGwX1OURYvzHeGl8DEyyd5VAXn8JFhg+lbYutfIRHXkVduQiuUPs0tn1qVi64hnUiom6aTKACw0W
         ZeRbRiNB+a7CeKy3sgA0Cu9HbI28dVtwrCeQpy07yg1Tqb+n44dyMbwRQUF+3a55Xta+FBqTjXvPIY
         QEYCbnqo2XwyXmOFpF4zqSaxC8gluDw==
X-HalOne-Cookie: e18d57bd31efcc247adc72faea2ae413515c78a7
X-HalOne-ID: 867869b9-0265-11eb-a2ae-d0431ea8bb10
Received: from m37-2-11-190.cust.tele2.se (unknown [2a00:801:2d0:7871::677:350])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 867869b9-0265-11eb-a2ae-d0431ea8bb10;
        Tue, 29 Sep 2020 15:07:44 +0000 (UTC)
Date:   Tue, 29 Sep 2020 17:07:42 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     Giovanni Biscuolo <g@xelera.eu>, linux-btrfs@vger.kernel.org
Message-ID: <9063a16.9d7d1dfc.174da67af85@lechevalier.se>
In-Reply-To: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
References: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: how to recover from "enospc errors during balance"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Giovanni Biscuolo <g@xelera.eu> -- Sent: 2020-09-29 - 16:25 ----

> Hello,
>=20
> please also reply to me since I'm not subscribed to linux-btrfs, thanks!
>=20
> My BTRFS filesystem is full, I got ENOSPC during a (scheduled) balance:
>=20
> --8<---------------cut here---------------start------------->8---
>=20
> [6928066.755704] BTRFS info (device sda3): balance: start -dusage=3D50 -m=
usage=3D70 -susage=3D70
> [6928066.760485] BTRFS info (device sda3): relocating block group 1394490=
73664 flags metadata|raid1
> [6928075.142462] BTRFS: error (device sda3) in btrfs_drop_snapshot:5421: =
errno=3D-28 No space left
> [6928075.146566] BTRFS info (device sda3): forced readonly
> [6928075.150851] BTRFS info (device sda3): 2 enospc errors during balance
> [6928075.155422] BTRFS info (device sda3): balance: ended with status: -3=
0
> [6928083.483820] BTRFS info (device sda3): delayed_refs has NO entry
>=20
> --8<---------------cut here---------------end--------------->8---
>=20
> and now it's mounted read-only:
>=20
> --8<---------------cut here---------------start------------->8---
>=20
> /dev/sda3 on / type btrfs (ro,relatime,ssd,space_cache,subvolid=3D5,subvo=
l=3D/)
> /dev/sda3 on /gnu/store type btrfs (ro,relatime,ssd,space_cache,subvolid=
=3D5,subvol=3D/gnu/store)
>=20
> --8<---------------cut here---------------end--------------->8---
>=20
> If I try to remount rw (to try to free space) I get:
>=20
> --8<---------------cut here---------------start------------->8---
>=20
> [7323937.312122] BTRFS info (device sda3): disk space caching is enabled
> [7323937.316478] BTRFS error (device sda3): Remounting read-write after e=
rror is not allowed
>=20
> --8<---------------cut here---------------end--------------->8---
>=20
> I tried to add a new device (I have 2 spare disks) but it does not work
> with a read-only filesystem.
>=20
> Please how can I remount the filesystem read-write and free some space
> deleting some files?
>=20
> Additional data:
>=20
> --8<---------------cut here---------------start------------->8---
>=20
> ~$ uname -a
> Linux myhost 5.4.50-gnu #1 SMP 1 x86_64 GNU/Linux
>=20
> ~$ btrfs --version
> btrfs-progs v5.6
>=20
> ~$ sudo btrfs balance status /
> No balance found on '/'
>=20
> ~$ btrfs fi df /
> Data, RAID1: total=3D446.50GiB, used=3D446.42GiB
> System, RAID1: total=3D32.00MiB, used=3D80.00KiB
> Metadata, RAID1: total=3D3.00GiB, used=3D2.11GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D5.53MiB
>=20
> ~$ sudo btrfs fi usage /
> Overall:
>     Device size:                 899.07GiB
>     Device allocated:            899.07GiB
>     Device unallocated:            2.01MiB
>     Device missing:                  0.00B
>     Used:                        897.05GiB
>     Free (estimated):             85.87MiB      (min: 85.87MiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 5.53MiB)
>=20
> Data,RAID1: Size:446.50GiB, Used:446.42GiB (99.98%)
>    /dev/sda3     446.50GiB
>    /dev/sdb3     446.50GiB
>=20
> Metadata,RAID1: Size:3.00GiB, Used:2.11GiB (70.22%)
>    /dev/sda3       3.00GiB
>    /dev/sdb3       3.00GiB
>=20
> System,RAID1: Size:32.00MiB, Used:80.00KiB (0.24%)
>    /dev/sda3      32.00MiB
>    /dev/sdb3      32.00MiB
>=20
> Unallocated:
>    /dev/sda3       1.00MiB
>    /dev/sdb3       1.00MiB
>=20
> ~$ sudo btrfs device stats /
> [/dev/sda3].write_io_errs    0
> [/dev/sda3].read_io_errs     0
> [/dev/sda3].flush_io_errs    0
> [/dev/sda3].corruption_errs  0
> [/dev/sda3].generation_errs  0
> [/dev/sdb3].write_io_errs    0
> [/dev/sdb3].read_io_errs     0
> [/dev/sdb3].flush_io_errs    0
> [/dev/sdb3].corruption_errs  0
> [/dev/sdb3].generation_errs  0
>=20
> --8<---------------cut here---------------end--------------->8---
>=20
> Thank you for any useful hint!
> Best regards, Giovanni
>=20
> --=20
> Giovanni Biscuolo
>=20
> Xelera IT Infrastructures


Hi,

I think you need to mount with -o skip_balance to get it back into rw mode.

Then you may need to add two new disks, because raid1 profile allocates two=
 chunks (1GiB each) on two disks. At the moment you don't have space for an=
y additional data or metadata chunks.

You can also as for help on irc channel #btrfs on Freenode.

Good luck!=20

