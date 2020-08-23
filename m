Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBD24EDE8
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 17:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHWPby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 11:31:54 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:29441 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgHWPbx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 11:31:53 -0400
Date:   Sun, 23 Aug 2020 15:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598196710;
        bh=2YP7mAX7EJUxHvxUnwaHq+/vuN6pk1iwMwtw7pHbCjg=;
        h=Date:To:From:Reply-To:Subject:From;
        b=sMQ6SHWLkmg8dg4o5jMN7ykINqx94LKQpXlohhLAzonmEnn70JgRSHlNwTYR0RSWi
         ImlQaCgOrXBFlaFKmsIYavwb12JCa+Tti6fp8Di7TeozdoUumEcjVUnw3fisJ/2eQi
         TR7py+lAfuMLxZIewcq2GYykTJfC6rNTSB6OcGX0=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello! I've lost the ability to log in to my systemd-homed user account, an=
d after some investigation on Systemd mailing list I was directed here. I w=
ould be very grateful for any help!

My root partition is ~475GiB with BTRFS, my home partition is a ~400GiB LUK=
S-encrypted partition on a loopback file (also BTRFS) created by systemd-ho=
med (residing at /home/azymohliad.home). Which leaves ~75GiB for the rest o=
f the root FS.

Recently I've lost the ability to log in to that user account, because duri=
ng authentication systemd does fallocate call for the image. CLI alternativ=
e for my case (suggested on systemd mailing list, I don't really know what =
is it) is:

    fallocate -l 403G -n /home/azymohliad.home

Which fails:

    fallocate: fallocate failed: No space left on device

My first idea was that I occupied all those ~75GiB on a root partition, but=
 cleaning didn't help (I definitely released more space than I could occupy=
 during the last working session).

Here are some details about my system:

uname -a

    Linux az-wolf-pc 5.8.3-arch1-1 #1 SMP PREEMPT Fri, 21 Aug 2020 16:54:16=
 +0000 x86_64 GNU/Linux

btrfs --version

    btrfs-progs v5.7


I can mount my home manually like this:

    losetup -fP /home/azymohliad.home
    cryptsetup open /dev/loop0p1
    mount /dev/mapper/home /mnt

and then,

btrfs fi show

    Label: none  uuid: b68411ce-702a-4259-9121-ac21c9119ddf
    =09Total devices 1 FS bytes used 299.71GiB
    =09devid    1 size 476.44GiB used 476.44GiB path /dev/nvme0n1p2

    Label: 'azymohliad'  uuid: 4ffae38b-42c9-4e53-89a1-3d21cd862938
    =09Total devices 1 FS bytes used 221.92GiB
    =09devid    1 size 402.72GiB used 258.02GiB path /dev/mapper/home


btrfs fi df /

    Data, single: total=3D475.43GiB, used=3D299.28GiB
    System, single: total=3D4.00MiB, used=3D80.00KiB
    Metadata, single: total=3D1.01GiB, used=3D437.05MiB
    GlobalReserve, single: total=3D61.03MiB, used=3D0.00B


btrfs fi df /mnt

    Data, single: total=3D256.01GiB, used=3D221.18GiB
    System, single: total=3D4.00MiB, used=3D48.00KiB
    Metadata, single: total=3D2.01GiB, used=3D749.92MiB
    GlobalReserve, single: total=3D297.11MiB, used=3D0.00B

dmesg.log: https://gitlab.com/-/snippets/2007155

What's interesting to me from above, the partition size on /home/azymohliad=
.home is 402.72GiB, but the file system size is 256.01GiB, and the image fi=
le size is 256.64GiB (from btrfs fi du /home, although ls -lh reports 403Gi=
B). I'm not really sure, but iirc the fs and image sizes were around 403GiB=
 too earlier. Could it be that it somehow got automatically reduced?

Could I do anything to make that fallocate call (with -l 403G) working? It =
will allow me to authenticate to homectl and resize the home partition from=
 there.

If not, what is the safe way to shrink that LUKS-partition size? Maybe then=
 systemd-homed would do fallocate for less space and it would work.

If from my assumptions you could tell that I'm looking in the wrong directi=
on, please give me a hint. Thanks for taking time to read it!

