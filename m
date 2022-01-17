Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A5490AAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 15:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiAQOkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 09:40:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiAQOkw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 09:40:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 19B3A1F399;
        Mon, 17 Jan 2022 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642430451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/DqjXsjic4WlVdBvh/1RqmX3Jd7JhNIQ7GI9vuo42c=;
        b=g6x6+WnZGgePPniYLxioiQwUEuq4T8ECClNvPJxtKuFCEpO6R5VN0kpvRZSYkOHK4ykNP/
        xeoBYR1+4Bd4C8SdYnqXyfyhZf+ko6W5L70KM3M6J5xmvkGIM0uyt7GLbcPqGGxPFZO5VO
        AQ85xgipuOvkYkQ6n2ZPsGi+dkFhRso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642430451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/DqjXsjic4WlVdBvh/1RqmX3Jd7JhNIQ7GI9vuo42c=;
        b=P6hpX1kGE2MsAb/Pk3HMJR9cPow6Bs4YKlLwDnyusgYqR7rqUgG3AMD3EeYQHAeSW71hJy
        n9RMhaijc8sxn5Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D9FDCA3B81;
        Mon, 17 Jan 2022 14:40:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7CAADA781; Mon, 17 Jan 2022 15:40:14 +0100 (CET)
Date:   Mon, 17 Jan 2022 15:40:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com
Subject: Re: [PATCH] btrfs: zoned: mark relocation as writing
Message-ID: <20220117144014.GI14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com
References: <e935669f435882ba179812a955bcbb89d964db26.1642401849.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e935669f435882ba179812a955bcbb89d964db26.1642401849.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 03:56:52PM +0900, Naohiro Aota wrote:
> There is a hung_task issue with running generic/068 on an SMR
> device. The hang occurs while a process is trying to thaw the
> filesystem. The process is trying to take sb->s_umount to thaw the
> FS. The lock is held by fsstress, which calls btrfs_sync_fs() and is
> waiting for an ordered extent to finish. However, as the FS is frozen,
> the ordered extent never finish.
> 
> Having an ordered extent while the FS is frozen is the root cause of
> the hang. The ordered extent is initiated from btrfs_relocate_chunk()
> which is called from btrfs_reclaim_bgs_work().
> 
> This commit add sb_*_write() around btrfs_relocate_chunk() call
> site. For the usual "btrfs balance" command, we already call it with
> mnt_want_file() in btrfs_ioctl_balance().
> 
> Additionally, add an ASSERT in btrfs_relocate_chunk() to check it is
> properly called.
> 
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> Cc: stable@vger.kernel.org # 5.13+
> Link: https://github.com/naota/linux/issues/56
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.c | 3 +++
>  fs/btrfs/volumes.c     | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 68feabc83a27..913fee0daafd 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1516,11 +1516,13 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
>  		return;
>  
> +	sb_start_write(fs_info->sb);
>  	/*
>  	 * Long running balances can keep us blocked here for eternity, so
>  	 * simply skip reclaim if we're unable to get the mutex.
>  	 */
>  	if (!mutex_trylock(&fs_info->reclaim_bgs_lock)) {
> +		sb_end_write(fs_info->sb);

Should this be some sort of try lock as well? IIRC sb_start_write can
block, so this would block the whole thread.

>  		btrfs_exclop_finish(fs_info);
>  		return;
>  	}
> @@ -1595,6 +1597,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	}
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  	mutex_unlock(&fs_info->reclaim_bgs_lock);
> +	sb_end_write(fs_info->sb);
>  	btrfs_exclop_finish(fs_info);
>  }
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b07d382d53a8..3975511f3201 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3251,6 +3251,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>  	u64 length;
>  	int ret;
>  
> +	/* Assert we called sb_start_write(), not to race with FS freezing */
> +	lockdep_assert_held_read(fs_info->sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1);

This seems to be peeking into the internals and I can't say if this is
a good idea or not, some wrappe would make more sense.

> +
>  	/*
>  	 * Prevent races with automatic removal of unused block groups.
>  	 * After we relocate and before we remove the chunk with offset
> @@ -8306,6 +8309,7 @@ static int relocating_repair_kthread(void *data)
>  		return -EBUSY;
>  	}
>  
> +	sb_start_write(fs_info->sb);

I was wondering if the trylock semantics should be here as well but
proably not, because the next lock is a big one too.

>  	mutex_lock(&fs_info->reclaim_bgs_lock);
>  
>  	/* Ensure block group still exists */
> @@ -8329,6 +8333,7 @@ static int relocating_repair_kthread(void *data)
>  	if (cache)
>  		btrfs_put_block_group(cache);
>  	mutex_unlock(&fs_info->reclaim_bgs_lock);
> +	sb_end_write(fs_info->sb);
>  	btrfs_exclop_finish(fs_info);
>  
>  	return ret;
> -- 
> 2.34.1
