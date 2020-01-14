Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E537E13B3DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 21:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANU41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 15:56:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:39336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANU41 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 15:56:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A122AC65;
        Tue, 14 Jan 2020 20:56:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1408ADA795; Tue, 14 Jan 2020 21:56:11 +0100 (CET)
Date:   Tue, 14 Jan 2020 21:56:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: check rw_devices, not num_devices for
 restriping
Message-ID: <20200114205609.GL3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200110161128.21710-1-josef@toxicpanda.com>
 <20200110161128.21710-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110161128.21710-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 10, 2020 at 11:11:24AM -0500, Josef Bacik wrote:
> While running xfstests with compression on I noticed I was panicing on
> btrfs/154.  I bisected this down to my inc_block_group_ro patches, which
> was strange.

Do you have stacktrace of the panic?

> What was happening is with my patches we now use btrfs_can_overcommit()
> to see if we can flip a block group read only.  Before this would fail
> because we weren't taking into account the usable un-allocated space for
> allocating chunks.  With my patches we were allowed to do the balance,
> which is technically correct.

What patches does "my patches" mean?

> However this test is testing restriping with a degraded mount, something
> that isn't working right because Anand's fix for the test was never
> actually merged.

Which patch is that?

> So now we're trying to allocate a chunk and cannot because we want to
> allocate a RAID1 chunk, but there's only 1 device that's available for
> usage.  This results in an ENOSPC in one of the BUG_ON(ret) paths in
> relocation (and a tricky path that is going to take many more patches to
> fix.)
> 
> But we shouldn't even be making it this far, we don't have enough
> devices to restripe.  The problem is we're using btrfs_num_devices(),
> which for some reason includes missing devices.  That's not actually
> what we want, we want the rw_devices.

The wrapper btrfs_num_devices takes into account an ongoing replace that
temporarily increases num_devices, so the result returned to balance is
adjusted.

That we need to know the correct number of writable devices at this
point is right. With btrfs_num_devices we'd have to subtract missing
devices, but in the end we can't use more than rw_devices.

> Fix this by getting the rw_devices.  With this patch we're no longer
> panicing with my other patches applied, and we're in fact erroring out
> at the correct spot instead of at inc_block_group_ro.  The fact that
> this was working before was just sheer dumb luck.
> 
> Fixes: e4d8ec0f65b9 ("Btrfs: implement online profile changing")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/volumes.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7483521a928b..a92059555754 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3881,7 +3881,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>  		}
>  	}
>  
> -	num_devices = btrfs_num_devices(fs_info);
> +	/*
> +	 * rw_devices can be messed with by rm_device and device replace, so
> +	 * take the chunk_mutex to make sure we have a relatively consistent
> +	 * view of the fs at this point.

Well, what does 'relatively consistent' mean here? There are enough
locks and exclusion that device remove or replace should not change the
value until btrfs_balance ends, no?

> +	 */
> +	mutex_lock(&fs_info->chunk_mutex);
> +	num_devices = fs_info->fs_devices->rw_devices;
> +	mutex_unlock(&fs_info->chunk_mutex);
>  
>  	/*
>  	 * SINGLE profile on-disk has no profile bit, but in-memory we have a
> -- 
> 2.24.1
