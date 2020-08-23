Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFFF24EDEE
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgHWPhp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 11:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgHWPhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 11:37:45 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16FC061573
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 08:37:44 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1k9s42-0004yg-8W; Sun, 23 Aug 2020 16:37:46 +0100
Date:   Sun, 23 Aug 2020 16:37:46 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
Message-ID: <20200823153746.GB1093@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Andrii Zymohliad <azymohliad@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 23, 2020 at 03:31:47PM +0000, Andrii Zymohliad wrote:
> Hello! I've lost the ability to log in to my systemd-homed user account, and after some investigation on Systemd mailing list I was directed here. I would be very grateful for any help!
> 
> My root partition is ~475GiB with BTRFS, my home partition is a ~400GiB LUKS-encrypted partition on a loopback file (also BTRFS) created by systemd-homed (residing at /home/azymohliad.home). Which leaves ~75GiB for the rest of the root FS.
> 
> Recently I've lost the ability to log in to that user account, because during authentication systemd does fallocate call for the image. CLI alternative for my case (suggested on systemd mailing list, I don't really know what is it) is:
> 
>     fallocate -l 403G -n /home/azymohliad.home
> 
> Which fails:
> 
>     fallocate: fallocate failed: No space left on device
> 
> My first idea was that I occupied all those ~75GiB on a root partition, but cleaning didn't help (I definitely released more space than I could occupy during the last working session).
> 
> Here are some details about my system:
> 
> uname -a
> 
>     Linux az-wolf-pc 5.8.3-arch1-1 #1 SMP PREEMPT Fri, 21 Aug 2020 16:54:16 +0000 x86_64 GNU/Linux
> 
> btrfs --version
> 
>     btrfs-progs v5.7
> 
> 
> I can mount my home manually like this:
> 
>     losetup -fP /home/azymohliad.home
>     cryptsetup open /dev/loop0p1
>     mount /dev/mapper/home /mnt
> 
> and then,
> 
> btrfs fi show
> 
>     Label: none  uuid: b68411ce-702a-4259-9121-ac21c9119ddf
>     	Total devices 1 FS bytes used 299.71GiB
>     	devid    1 size 476.44GiB used 476.44GiB path /dev/nvme0n1p2
> 
>     Label: 'azymohliad'  uuid: 4ffae38b-42c9-4e53-89a1-3d21cd862938
>     	Total devices 1 FS bytes used 221.92GiB
>     	devid    1 size 402.72GiB used 258.02GiB path /dev/mapper/home
> 
> 
> btrfs fi df /
> 
>     Data, single: total=475.43GiB, used=299.28GiB
>     System, single: total=4.00MiB, used=80.00KiB
>     Metadata, single: total=1.01GiB, used=437.05MiB
>     GlobalReserve, single: total=61.03MiB, used=0.00B
> 
> 
> btrfs fi df /mnt
> 
>     Data, single: total=256.01GiB, used=221.18GiB
>     System, single: total=4.00MiB, used=48.00KiB
>     Metadata, single: total=2.01GiB, used=749.92MiB
>     GlobalReserve, single: total=297.11MiB, used=0.00B
> 
> dmesg.log: https://gitlab.com/-/snippets/2007155

   The / filesystem is a clear case of needing a data balance. See
this link for what to do:

https://btrfs.wiki.kernel.org/index.php/FAQ#if_your_device_is_large_.28.3E16GiB.29

and see also this link for how to read the data you've pasted here:

https://btrfs.wiki.kernel.org/index.php/FAQ#or_My_filesystem_is_full.2C_and_I.27ve_put_almost_nothing_into_it.21

> What's interesting to me from above, the partition size on /home/azymohliad.home is 402.72GiB, but the file system size is 256.01GiB, and the image file size is 256.64GiB (from btrfs fi du /home, although ls -lh reports 403GiB). I'm not really sure, but iirc the fs and image sizes were around 403GiB too earlier. Could it be that it somehow got automatically reduced?
> 
> Could I do anything to make that fallocate call (with -l 403G) working? It will allow me to authenticate to homectl and resize the home partition from there.
> 
> If not, what is the safe way to shrink that LUKS-partition size? Maybe then systemd-homed would do fallocate for less space and it would work.
> 
> If from my assumptions you could tell that I'm looking in the wrong direction, please give me a hint. Thanks for taking time to read it!

   The /mnt filesystem (LABEL=azymohliad) looks OK. Are you seeing
problems with that one at all?

   Hugo.

-- 
Hugo Mills             | Sometimes, when I'm alone, I Google myself.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
