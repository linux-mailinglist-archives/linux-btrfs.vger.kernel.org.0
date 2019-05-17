Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E421C99
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfEQRhw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 17 May 2019 13:37:52 -0400
Received: from voltaic.bi-co.net ([134.119.3.22]:40329 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbfEQRhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 13:37:51 -0400
Received: from lass-mb.fritz.box (aftr-95-222-30-100.unity-media.net [95.222.30.100])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id 0A06920987;
        Fri, 17 May 2019 19:37:50 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
From:   =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
In-Reply-To: <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
Date:   Fri, 17 May 2019 19:37:49 +0200
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Am 17.05.2019 um 01:42 schrieb Chris Murphy <lists@colorremedies.com>:
> 
> Btrfs balance is supposed to be COW. So a block group is not
> dereferenced until it is copied successfully and metadata is updated.
> So it sounds like the fstrim happened before the metadata was updated.
> But I don't see how that's possible in normal operation even without a
> sync, let alone with the sync.

Balance is indeed not to blame here. See below.

> The most reliable way to test it, ideally keep everything the same, do
> a new mkfs.btrfs, and try to reproduce the problem. And then do a
> bisect. That for sure will find it, whether it's btrfs or something
> else that's changed in the kernel. But it's also a bit tedious.
> 
> I'm not sure how to test this with any other filesystem on top of your
> existing storage stack instead of btrfs, to see if it's btrfs or
> something else. And you'll still have to do a lot of iteration. So it
> doesn't make things that much easier than doing a kernel bisect.
> Neither ext4 nor XFS have block group move like Btrfs does. LVM does
> however, with pvmove. But that makes the testing more complicated,
> introduces more factors. So...I still vote for bisect.
> 
> But even if you can't bisect, if you can reproduce, that might help
> someone else who can do the bisect.

I tried to reproduce this issue: I recreated the btrfs file system, set up a minimal system and issued fstrim again. It printed the following error message:

fstrim: /: FITRIM ioctl failed: Input/output error

Now it gets iteresting: After this, the btrfs file system was fine. However, two other LVM logical volumes that are partitioned with ext4 were destroyed. I cannot reproduce this issue with an older Linux 4.19 live CD. So I assume that it is not an issue with the SSD itself. I’ll start bisecting now. It could take a while since every “successful” (i.e., destructive) test requires me to recreate the system.

> Your stack looks like this?
> 
> Btrfs
> LUKS/dmcrypt
> LVM
> Samsung SSD

To be precise, there’s an MBR partition in the game as well:

Btrfs
LUKS/dmcrypt
LVM
MBR partition
Samsung SSD

Cheers,
Michael
