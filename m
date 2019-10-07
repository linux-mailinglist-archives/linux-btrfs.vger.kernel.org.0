Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D70CEAC2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfJGRgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 13:36:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:38924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728028AbfJGRgW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 13:36:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DC2AAF11;
        Mon,  7 Oct 2019 17:36:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3AEBCDA7FB; Mon,  7 Oct 2019 19:36:36 +0200 (CEST)
Date:   Mon, 7 Oct 2019 19:36:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] btrfs: fix issues due to alien device
Message-ID: <20191007173635.GJ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007094515.925-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 05:45:10PM +0800, Anand Jain wrote:
> v3: Fix alien device is due to wipefs in Patch4.
>     Fix a nit in Patch3.
>     Patches are reordered.
> 
> Alien device is a device in fs_devices list having a different fsid than
> the expected fsid or no btrfs_magic. This patch set fixes issues found due
> to the same.

The definition of alien device should be in some of the patches, I see
it only in the cover letter.

So the sequence of actions

	mkfs A
	mount A
	mkfs B C
	add B to A
	mount C

leaves the scanned devices in a state that does not match the reality.
At the time when B is scanned again, the ownership in the in-memory
structures should be transferred to A (ie. removing B from BC). So far I
understand the problem.

The fix I'd expect is to fix up the devices at the first occasion, like
when the device is scanned or attempted for mount.

> Patch1: is a cleanup patch, not related.
> Patch2: fixes failing to mount a degraded RAIDs (RAID1/5/6/10), by
> 	hardening the function btrfs_free_extra_devids().
> Patch3: fixes the missing device (due to alien btrfs-device) not missing in
> 	the userland, by hardening the function btrfs_open_one_device().
> Patch4: fixes the missing device (due to alien device) not missing in
> 	the userland, by returning EUCLEAN in btrfs_read_dev_one_super().
> Patch5: eliminates the source of the alien device in the fs_devices.

I'm a bit lost in the way it's being fixed. The userspace part is IMO
irrelevant, the change must happen on the kernel side using the
information provided (scan, mount).

The error conditions should be propagated in a more fine grained way,
similar to what you propose with EUCLEAN, but not with EUCLEAN. That has
a very specific meaning, as has been pointed out.

The distinctions should be like:

 < 0 - error
   0 - all ok, take the device
 > 0 - device ok, but not ours

And the callers will decide what to do (remove or ignore).

> PS: Fundamentally its wrong approach that btrfs-progs deduces the device
> missing state in the userland instead of obtaining it from the kernel.
> I remember objecting on the btrfs-progs patch which did that, but still
> it got merged, bugs in p3 and p4 are its side effects. I wrote
> patches to read device_state from the kernel using ioctl, procfs and
> sysfs but it didn't get the due attention till a merger.

The state has to be ultimately decided by kernel, userspace can read the
information from anything but at the time this gets processed, it might
be stale again. It's been probably very long ago when the above was
discussed and I don't recall the details, it may be a good idea to
revisit if there are still things to address.
