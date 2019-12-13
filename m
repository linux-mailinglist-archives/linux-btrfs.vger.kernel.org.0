Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9031811E6ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 16:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfLMPss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 10:48:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:51682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727920AbfLMPss (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 10:48:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04731AFB2;
        Fri, 13 Dec 2019 15:48:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 94169DA82A; Fri, 13 Dec 2019 16:48:46 +0100 (CET)
Date:   Fri, 13 Dec 2019 16:48:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Kyle Ambroff-Kao <kyle@ambroffkao.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] btrfs: Allow replacing device with a smaller one if
 possible
Message-ID: <20191213154845.GY3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Kyle Ambroff-Kao <kyle@ambroffkao.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191208093045.43433-1-kyle@ambroffkao.com>
 <20191208093045.43433-2-kyle@ambroffkao.com>
 <CAL3q7H60gNBC_zzU8gjZ_s=7MnN23yFzQqYxanhvzMO50qtXJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H60gNBC_zzU8gjZ_s=7MnN23yFzQqYxanhvzMO50qtXJg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 09, 2019 at 10:26:52AM +0000, Filipe Manana wrote:
> 2) A simple solution, but often less efficient: before starting the
> actual replace operation, shrink the source device to the size of the
> target device - just use the existing btrfs_shrink_device(), which
> will relocate chunks beyond the new size, and if there's not enough
> space it just returns -ENOSPC.  This means no changes to the actual
> way replace copies data - it does extra IO, due to the relocation but
> keeps things simple, and it should still be significantly more
> efficient then doing a device remove + device add operation, maybe
> except if all or most of the allocated chunks (in the device to be
> replaced) cross or start beyond an offset matching the new device's
> size.
> 
>    Also, since the shrink can take some time due to relocation of
>    chunks, we would need to teach btrfs_shrink_device() to check for
>    device replace cancel requests as well.  And such request is
>    detected, restore the device's size to the original value.

The shrinking can be done completely in userspace, calling one more
ioctl before device replace. Handling the error cases will be simplified
(and not necessarily done in kernel at all).

So something like that:

  $ btrfs device replace 2 /dev/sdx /mnt
  (fail because the device is too small, print a message that the target
  device needs to be shrunk manually or there's an option eg.
  --shrink-target that will do that in one go)

  $ btrfs device replace --shrink-target 2 /dev/sdx /mnt
  Shrink device 2 from 12345678 to 123456 (you can cancel that by 'btrfs resize --cancel)
  Done
  Starting devicr replace

> I think option 2 may actually be acceptable for an initial version. Option 1 is
> complex and increases the risk for data loss. Also, for option 2, there's the
> possible downside of requiring writes to the source device - one might
> be replacing
> it because the device is not healthy, writes into some regions are
> failing, which
> can prevent the shrink/relocation process from suceeding, in that case only
> a device remove followed by a device add operation would work.

That's a good point and giving user more options how to replace the
device sounds a like a better option than implementing all of that in
kernel.
