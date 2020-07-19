Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D01722544D
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 23:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgGSVmM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 17:42:12 -0400
Received: from mailrelay3-3.pub.mailoutpod1-cph3.one.com ([46.30.212.12]:49972
        "EHLO mailrelay3-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgGSVmM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 17:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:message-id:to:
         from:date:from;
        bh=n9/o52VDq2r1Rp01Dx0/JeVLMoNVB1QHDX+s+nTKr3M=;
        b=rpWZDo55DGlndXRFpzf+qoRw8ClHqyqVkc3dE6vJqg2CiGlImPeeDWmbvaVbM4S4AWidcjUggCFDY
         f1JNAlDCUaOoENi9v5/SqlM2CKHoFiEOxYOaGu9nu7DURDaOSg9coEFC6UMJt2mykLw6k6gSTrX7Gm
         oh4NZSAXNnIm4FS1dMEAO2wnPj3Mk6Ibt/Fsri/k6y3q7haSDPvT8AHgIBWKScs/aTUG1kkigIWnhq
         1qgr2iaO3nPyyh2FM3xuEhbJr2RDg9wgKw26Z+yaBN+BWlEXnOfG/LJhu5UOayxZXAcC+gO8akKDPo
         gMEkUTcJx6L16wc524rJx0iZyqY2C8Q==
X-HalOne-Cookie: bdd2cb80c086dfb34066a6422dd71ae12a121541
X-HalOne-ID: b2f160bc-ca08-11ea-86e9-d0431ea8bb03
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id b2f160bc-ca08-11ea-86e9-d0431ea8bb03;
        Sun, 19 Jul 2020 21:42:10 +0000 (UTC)
Date:   Sun, 19 Jul 2020 23:42:09 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     Falk Bay <falkartis@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <a85c20.e6b39479.1736906f225@lechevalier.se>
Subject: Re: Possible bug detected, need help
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Falk Bay <falkartis@gmail.com> -- Sent: 2020-07-19 - 22:24 ----

> Hi,
>=20
> First of all I want to thank you for this great piece of software,
> I've been using it for a long time and it perfectly suits my needs.
>=20
> After a unclean shutdown, with a balancing in progress and very little
> free space in my RAID1 filesystem I ended up with a btrfs filesystem
> that only works in ro mode.
> If I try to mount it as normal, any read or write operation will hang
> forever, not even "umount" will return.
> As a side note, if I mount it as normally I have to force my machine
> to power off since the normal shutdown will wait until any filesystem
> is unmounted.
>=20
> Here are my technical details:
>=20
> uname -a
> Linux poloni 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9 20:32:34 UTC
> 2020 x86_64 x86_64 x86_64 GNU/Linux
>=20
> btrfs --version
> btrfs-progs v4.15.1
>=20
> sudo btrfs fi show
> Label: none  uuid: aa1f67a3-8cd3-4d1b-87de-a04b48efbcfd
>     Total devices 2 FS bytes used 27.58GiB
>     devid    1 size 32.00GiB used 31.00GiB path /dev/sda7
>     devid    2 size 32.00GiB used 31.00GiB path /dev/sdb7
>=20
> Label: 'my-btrfs'  uuid: 5ea692ab-c7b1-4618-be39-d82eaf5c6b34
>     Total devices 2 FS bytes used 888.89GiB
>     devid    3 size 891.51GiB used 891.51GiB path /dev/sda5
>     devid    5 size 891.51GiB used 891.51GiB path /dev/sdb5
>=20
> this aa1f67a3-8cd3-4d1b-87de-a04b48efbcfd works fine.
> this 5ea692ab-c7b1-4618-be39-d82eaf5c6b34, my-btrfs is the one that
> causes problems
>=20
> btrfs fi df /mnt/
> Data, RAID1: total=3D888.48GiB, used=3D886.92GiB
> System, RAID1: total=3D32.00MiB, used=3D208.00KiB
> Metadata, RAID1: total=3D3.00GiB, used=3D1.97GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> I was willing, but unable, to remove some large files to have enough
> free space to operate normally.
>=20
> I add the dmesg.log file in the attachment.
>=20
> I wonder if I should try to fix it or if I should format the partition
> and recover a backup.
>=20
> Thanks in advance,
> Falk

The dmesg suggest a balance in running. The skip_balance is a good option h=
ere.

I'd to see the output of `btrfs fi us /mnt/` as it will show the allocation=
s better. You may have a situation with not enough space to allocate a new =
data or metadata block and the balance is not very good at handling this.

A note is that deleting files actually can increase metadata usage.

To solve that youd have to do very specific balancing options. But the sugg=
ested memtest is good! Do you have earlier kernel outputs with errors to sh=
are?=20

https://wiki.tnonline.net/w/Btrfs/ENOSPC shows a high level on how block al=
location work..=20
Official FAQ is here: https://btrfs.wiki.kernel.org/index.php/FAQ#Help.21_I=
_ran_out_of_disk_space.21

I suggest you do look for those earlier logs and do the testing suggested b=
y Chris Murphy.=20

Good luck!=20

/Anders=20


