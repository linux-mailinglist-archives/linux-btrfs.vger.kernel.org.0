Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5999DFBAB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 22:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKMV3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 16:29:54 -0500
Received: from briare1.fullpliant.org ([78.227.24.35]:50896 "HELO
        briare1.fullpliant.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726162AbfKMV3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 16:29:53 -0500
From:   Hubert Tonneau <hubert.tonneau@fullpliant.org>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Avoiding BRTFS RAID5 write hole
Date:   Wed, 13 Nov 2019 22:29:49 GMT
Message-ID: <0JGAX5Q12@briare1.fullpliant.org>
X-Mailer: Pliant 114
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goffredo Baroncelli wrote:
>
> > What I am suggesting is to write it as RAID1 instead of RAID5, so that if it's changed a lot of times, you pay only once.
> I am not sure to understand what are you saying. Could you elaborate ?

The safety problem with RAID5 is that between the time you start to overwrite a stripe and the time you finish, disk safety is disabled because parity is broken.
On the other hand, with RAID1, disk safety more or less remains all the time, so overwriting is no issue.

There are several possible strategies to keep RAID5 disk safety all the time:

1) Use a journal
This is the MDADM solution because it's the only resonable one if the RAID layer is separated from the filesystem (because you don't whan to add another sectors mapping layer).
The problem is that it's IO expensive.
This is the solution implemented in Liu Bo 2017 patch, as far as I can understand it.

2) Never overwrite the RAID5 stripe
This is stripe COW. The new stripe is stored at different disks positions.
The problem is that it's even more IO expensive.
This is the solution you are suggesting, as far as I can understand it.

What I'm suggesting is to use your COW solution, but also write the new (set of) stripe(s) as RAID1.
Let me call this operation stripe COW RAID5 to RAID1.
The key advantage is that if you have to overwrite it again a few seconds (or hours) later, then it can be fast, because it's already RAID1.

Morever, new stripes resulting from writing a new file, or appending, would be created as RAID1, even if the filesystem DATA is configured as RAID5, each time the stripe is not full or is likely to be modified soon.
This will reduce the number of stripe COW RAID5 to RAID1 operations.

The final objective is to have few stripe COW operations, because they are IO expensive, and many RAID1 stripe overwrite operations.
The price to pay for the reduced number of stripe COW operations is consuming more disk space, because RAID1 stripes consumes more disk space than RAID5 ones, and that is why we would have a background process that does stripe COW from RAID1 to RAID5 in order to reclaim disk space, and we could make it more aggressive when we lack disk space.

What I'm trying to provide is the idea that seeing the DATA as RAID1 or RAID5 is not a good idea when we have BTRFS flexibility. We should rather see it as RAID1 and RAID5, RAID5 beeing just a way to reclaim disk space (same for RAID1C3 and RAID6).
Having METADATA as RAID1 and DATA as RAID5 was a first step, but BTRFS flexibility probably allows to do more.

Please notice that I understand the BTRFS and RAID principles, but on the other hand, I have not read the code, so can hardly say what is easy to implement.
Sorry about that. I've written a full new operating system (see www.fullpliant.org) but the kernel :-)
