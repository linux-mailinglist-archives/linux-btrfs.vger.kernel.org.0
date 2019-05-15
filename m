Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B821F8F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEOQvO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 12:51:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfEOQvO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 12:51:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A529BAF7D
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 16:51:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6DAEDA8E5; Wed, 15 May 2019 18:52:10 +0200 (CEST)
Date:   Wed, 15 May 2019 18:52:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/8] btrfs: Ensure replaced device doesn't have pending
 chunk allocation
Message-ID: <20190515165207.GU3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190514105445.23051-1-nborisov@suse.com>
 <20190514105445.23051-8-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514105445.23051-8-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 14, 2019 at 01:54:44PM +0300, Nikolay Borisov wrote:
> Recent FITRIM work, namely bbbf7243d62d ("btrfs: combine device update
> operations during transaction commit") combined the way certain
> operations are recoded in a transaction. As a result an ASSERT was
> added in dev_replace_finish to ensure the new code works correctly.
> Unfortunately I got reports that it's possible to trigger the assert,
> meaning that during a device replace it's possible to have an unfinished
> chunk allocation on the source device.
> 
> This is supposed to be prevented by the fact that a transaction is
> committed before finishing the replace oepration and alter acquiring
> the chunk mutex. This is not sufficient since by the time the
> transaction is committed and the chunk mutex acquired it's possible to
> allocate a chunk depending on the workload being executed on the
> replaced device. This bug has been present ever since device replace was
> introduced but there was never code which checks for it.
> 
> The correct way to fix is to ensure that there is no pending device
> modification operation when the chunk mutex is acquire and if there is
> repeat transaction commit. Unfortunately it's not possible to just
> exclude the source device from btrfs_fs_devices::dev_alloc_list since
> this causes ENOSPC to be hit in transaction commit.
> 
> Fixes: 391cd9df81ac ("Btrfs: fix unprotected alloc list insertion during the finishing procedure of replace")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/dev-replace.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index fb2bbc2a53a9..8ec9328609bd 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -599,17 +599,28 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>  	}
>  	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
>  
> -	trans = btrfs_start_transaction(root, 0);
> -	if (IS_ERR(trans)) {
> -		mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
> -		return PTR_ERR(trans);

Please add a comment that briefly explains why this is looping and not
the usual start/commit. Otherwise ok.

For the record, the other solution we discussed, removing the source
device from wrieable does not work due to enospc at the transaction
commit, and adding some extra conditions everywhere just to make sure
this special case is handled did not seem better than the looped commit.

The speciality is that the source device needs a point where no new
writes are accepted, but we still need to write the pending data plus
the final transaction commit. So the device is there but not really. The
commit could loop, but given how hard it was to reproduce that, it'll
almost never happen and overall runtime of dev-replace is high so this
won't cause noticeable delay.

> +	while (1) {
> +		trans = btrfs_start_transaction(root, 0);
> +		if (IS_ERR(trans)) {
> +			mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
> +			return PTR_ERR(trans);
> +		}
> +		ret = btrfs_commit_transaction(trans);
> +		WARN_ON(ret);
> +
> +		/* Prevent write_all_supers() during the finishing procedure */
> +		mutex_lock(&fs_info->fs_devices->device_list_mutex);
> +		/* Prevent new chunks being allocated on the source device */
> +		mutex_lock(&fs_info->chunk_mutex);
> +
> +		if (!list_empty(&src_device->post_commit_list)) {
> +			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> +			mutex_unlock(&fs_info->chunk_mutex);
> +		} else {
> +			break;
> +		}
>  	}
> -	ret = btrfs_commit_transaction(trans);
> -	WARN_ON(ret);
>  
> -	/* keep away write_all_supers() during the finishing procedure */
> -	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -	mutex_lock(&fs_info->chunk_mutex);
>  	down_write(&dev_replace->rwsem);
>  	dev_replace->replace_state =
>  		scrub_ret ? BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED
> @@ -658,7 +669,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>  	btrfs_device_set_disk_total_bytes(tgt_device,
>  					  src_device->disk_total_bytes);
>  	btrfs_device_set_bytes_used(tgt_device, src_device->bytes_used);
> -	ASSERT(list_empty(&src_device->post_commit_list));
>  	tgt_device->commit_total_bytes = src_device->commit_total_bytes;
>  	tgt_device->commit_bytes_used = src_device->bytes_used;
>  
> -- 
> 2.17.1
