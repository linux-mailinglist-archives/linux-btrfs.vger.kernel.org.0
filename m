Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518FE1396F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 18:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMRGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 12:06:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgAMRGQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 12:06:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 174A8AD1A;
        Mon, 13 Jan 2020 17:06:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70B81DA78B; Mon, 13 Jan 2020 18:06:02 +0100 (CET)
Date:   Mon, 13 Jan 2020 18:06:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, jth@kernel.org, dsterba@suse.de
Subject: Re: [PATCH] btrfs: Fix UAF during concurrent mount and device scan
Message-ID: <20200113170601.GY3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, jth@kernel.org, dsterba@suse.de
References: <20200109110210.30671-1-nborisov@suse.com>
 <20200109144443.GO3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109144443.GO3929@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 09, 2020 at 03:44:44PM +0100, David Sterba wrote:
> On Thu, Jan 09, 2020 at 01:02:10PM +0200, Nikolay Borisov wrote:
> > This log shows how an fs  is being unmounted which causes device close
> > routine to be invoked. It sets bdev to NULL but doesn't reset fs_info.
> > Afterwards the fs_info itself is freed from btrfs_kill_super at the same
> > time the device is still anchored at fs_devices list. Subsequently a
> > mount is triggered which sets btrfs_fs_device::bdev to a valid value, yet
> > btrfs_fs_device::fs_info is still stale/freed. Before btrfs_fill_super
> > is called and re-initializes btrfs_fs_device::fs_info a concurrent device
> > scan is triggered, it finds the device with its ->bdev pointer set to
> > valid value and eventually calls btrfs_info_in_rcu in device_list_add
> > which causes the crash.
> > 
> > Simply setting btrfs_fs_device::fs_info to NULL prevents the crash but
> > doesn't fix the race. In fact the race cannot be solved because device
> > scan is asynchronous in its nature so it makes no sense to try and
> > synchronize it with pending mounts.
> 
> We've had bugs when mount and scan raced, I don't see why you think this
> cannot be fixed and synchronized in this case. At minimum I'd think that
> the device_list_mutex should be enough as it's the one thing that
> excludes mount and scan for the new and removed members of the device
> lists etc.
> 
> > Fixes: cc1824fcd334 ("btrfs: reset device back to allocation state when removing")
> 
> That's still it misc-next so I'd rather fold it into the patch than to
> have this split fix.

Now folded to "btrfs: reset device back to allocation state when
removing" and pushed.
