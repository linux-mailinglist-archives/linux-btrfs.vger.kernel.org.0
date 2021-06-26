Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104603B4DB9
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFZIv7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 26 Jun 2021 04:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFZIv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 04:51:59 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261EBC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jun 2021 01:49:37 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a52:5a00:19da:1263:b56c:4c4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 9A4C327AF7D;
        Sat, 26 Jun 2021 10:49:31 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-block@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search Baloo
Date:   Sat, 26 Jun 2021 10:49:30 +0200
Message-ID: <2009039.b04VgvrTqe@ananda>
In-Reply-To: <fe83dadc-bbcf-2f85-6664-bad3fcd83553@gmx.com>
References: <41661070.mPYKQbcTYQ@ananda> <fe83dadc-bbcf-2f85-6664-bad3fcd83553@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 26.06.21, 02:27:54 CEST:
> On 2021/6/26 上午3:06, Martin Steigerwald wrote:
> > Hi!
> > 
> > I found repeatedly that Baloo indexes the same files twice or even
> > more often after a while.
> > 
> > I reported this upstream in:
> > 
> > Bug 438434 - Baloo appears to be indexing twice the number of files
> > than are actually in my home directory
> > 
> > https://bugs.kde.org/show_bug.cgi?id=438434
> > 
> > And got back that if the device number changes, Baloo will think it
> > has new files even tough the path is still the same. And found over
> > time that the device number for the single BTRFS filesystem on a
> > NVMe SSD in a ThinkPad T14 Gen1 AMD can change. It is not (maybe
> > yet) RAID 1. I do have BTRFS RAID 1 in another laptop and there I
> > also had this issue already.
> 
> Since btrfs has multi-device support by default, it reports anonymous
> device number, just as if you use a filesystem over LVM.

Ah, this!

I forgot to mention that: I use BTRFS on top of LVM on top of LUKS based 
dm-crypt on a partition on the NVMe SSD. Sorry, somehow I forgot to 
mention that here. I mentioned it in the bug report. I'd use a different 
approach if there would be one that give me full disk encryption. I am 
not willing to use ecryptfs on top of BTRFS and as far as I know BTRFS 
cannot yet encrypt by itself.

I still think this could give a fixed order of loading:

1. Unlock LUKS.

2. Activate LVM logical volumes. No idea whether that happens in a fixed 
order though or whether it can have a different order on each boot.

3. Mount BTRFS. /home is always on the same subvolume. So that should 
not change.

> The problem is why the anonymous device number change.

Good question. Maybe I have an idea about that. See below.

> > I argued that a desktop application has no business to rely on a
> > device number and got back that search/indexing is in the middle
> > between an application and system software. And that Baloo needs an
> > "invariant" for a file. See comment #11 of that bug report:
> > 
> > https://bugs.kde.org/show_bug.cgi?id=438434#c11
> 
> Well, a lot of tools relies on device number to distinguish filesystem
> boundary, like find.
> Thus it's a little hard to argue.
> 
> But on the other hand, it also means baloo can't handle regular fs
> over LVM cases well neither.

Yes. Also it could not handle the case of a driver loading race 
condition with two or more different controllers in a desktop machine.

> > I got the suggestion to try to find a way to tell the kernel to use
> > a fixed device number.
> 
> I don't think it's possible for btrfs, as each subvolume get its
> anonymous device number assigned when it gets first read.
> 
> Thus it's really hard to make it fixed, as the reason for anonymous
> device number is to avoid conflicts.

Fair enough.

> > I still think, an application or an infrastructure service for a
> > desktop environment or even anything else in user space should not
> > rely on a device number to be fixed and never change upon reboots.
> 
> Well, LVM/device mapper is doing the same thing, a lot of behavior
> change is never a good idea for the kernel.
> 
> Thus for use cases where we really need a proper mapping, we use
> hashes, not just device number, like what we did in dupremover.

I think I suggested that some time ago.

> > Another question would be whether I could somehow make sure that the
> > device number does not change, even if just as a work-around.
> 
> If you really just want a fixed device number, you can ensure that by:
> 
> - Make sure all users of anonymous devices get fixed sequence
>    Things like device mapper/LVM, btrfs should get loaded/initialized
>    in a fixed order.

Ah, I see.

> - Make sure the subvolume you care always get mounted/read before any
>    other subvolumes
>    So that the target subvolume always get the first device number in
> the pool.

Hmm, that may be a pointer. This is what I currently have in fstab:

/dev/nvme/home /home btrfs lazytime,compress=zstd 0 0
/dev/nvme/home /zeit/home btrfs subvol=zeit 0 0

In the first line the default subvolume is used which I changed 
accordingly after creating this BTRFS. I use the approach to keep 
(temporary) snapshots separated from the directory tree in /home.

Could it be that this order between these two mounts is not the same on 
every boot? I use Devuan with Runit, so the mounting would happen by 
some init scripts (instead of Systemd).

I am not aware of an option for fstab to mount this one first and then 
the other second, but I could set the second mount to noauto and mount 
it when I need it.

>    But this also means, all later subvolumes not in the fixed
> mount/read sequence can not get a fixed number.

I somehow thought this would get complicated.

Best,
-- 
Martin


