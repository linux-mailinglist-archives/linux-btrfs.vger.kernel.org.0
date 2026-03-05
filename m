Return-Path: <linux-btrfs+bounces-22249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IdEOyN6qWl77wAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22249-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 13:42:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7133B211DCD
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 13:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C34CE30B71AF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6D26D4E5;
	Thu,  5 Mar 2026 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctBgLv92"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F7248F66
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714289; cv=none; b=W0gHnemnD9zXpi+qEA6bd2mX+BYbws+2SggOzduMJvAkiK+rdfqInnsnJCuKNI7XJBbgqRnA4Fg6cTbZXp97fWrayXhdjvOZdaGqVlWdWj18AhVwQ52MZ9DYEupfuE/8e00bLhdgVG7X8xqyyNAap9FYGblinNzTYrUZeYlE848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714289; c=relaxed/simple;
	bh=J7mMZLgMSW5OchGOQpHsakaNiZQtjN4+Bl4eO+V4Bfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5Qmb/Fbclif/dxeCc3G3m7udIIz1sG2tvf//EHPkgkTRWKUG3LEltGoR3MGJtfH6+91l6DcgkLzX9XKNunZwo+DqV9ANgQV8aVUcfTCg+FMV4EnUUnWv1A2DApALzOPHSQwy1wBLp5M3awxMolSDjWE0+GBw/WnyTYKmwpmmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctBgLv92; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3597a2fc2beso288057a91.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2026 04:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772714287; x=1773319087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iu6WDjYdH4tmzQcCQbUibUyITLzNU0wEbdVnpKZxX+0=;
        b=ctBgLv92HEmFJymYhv5gll9U1N44tnAhSz2W/8V8oVEMrBzX51ceKLRzGKkqsVDNCZ
         wO1qF+sJG5NxVVEcRqnR0QzL9g0/xc26uHEpK7gHCMuLveFqvJxEBilyYXk3oZhZgyTy
         gg/C9jyh33qdwHCaqR4R4kQ/eFvz2At5fy6Vp3JaErfRNHkk4Sct9t1tzd6sl3Z94BCd
         keT3w3xE3WFK0/X0VoJJQTvt35t1TYRQMcXMvTXSZJLsJdZ+s/VbjDpKCrNlUMd8M5Sa
         RJKkLS6e6x2UELM3xpviVErKyGPE+ciSdopdo97HqJQOY+L8/aPcBElw1Nq2E9/VqsL7
         1BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714287; x=1773319087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu6WDjYdH4tmzQcCQbUibUyITLzNU0wEbdVnpKZxX+0=;
        b=LUXrvRVHSvBzUKj5KAEdygl2e91Wn7lvRUegjiOg4xXVgUrM+o365bwwhDmkbDQ3gA
         Z0ZuX4fhP7yj/8lb4eQys/lsKtj7DergYIo6IpoFYHiDMzT1X8XoKseRuyChRW4SCM9S
         wxR/5ZFLrOxPAAyUEwZf1Jq1a0DIyc4GylVNw2ZYUJF5g7h6vWXxd9QAotTYJidZQ+y9
         vmQ5YIzFyIvF5pNBFRbX7SFWjMmJ4VwfnKETaxfU1xXrK4fw6w8BhotDI8U/I919dOol
         E2dgZT5Ip2vuE6vpeLtXeTLXBL2LVzcJYjPzA2kvyPCrAuQeDp6RHFbA0Q2gX9pZHoZx
         39ew==
X-Forwarded-Encrypted: i=1; AJvYcCVzFw3ZEVljB4UJqc3LsDfMTps3R7N9H9886Wxu2evVLYB5j8BXwPi1tGPBwjP6f+THfCg71wi8oFXSIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXOlyrVaSSwVYRInqZ+FPehfLHOCWpSeVIS8mIPGeMrrjPJF0
	PdGyXAAQfxJiR2yfa5c7ZJDDcaxe6arNeyzRRhUvj0V8+1wg/Ui857E7
X-Gm-Gg: ATEYQzwQhMFQ6tIpmgKv7OFC/IHRcQLVn2gtKdrbq2ACaA3bGqA4wBLo11sO/nQpNqo
	Yy63e5ih3ZfdIqAS+AbnAViAg9CK+ZMVGzqWI4EL/5A0KZ6INgvCIjPBO1All8ItLF9jR88PTus
	BFz4x5djT/4dlXNbrfnwKGj9rBvDLly/CPp07Ka234bqdjOWdrZ2GZ7Lni2vNZ58kEvP1PBeG91
	UG3hlrmwouno6kP2rVAFsd3bsEgg9Pt9IWHAhCLHrO/WZR2Xb+10t2zdWuI+dYNPU5f2d41ONGL
	wZDuvsfObbY75CwKWFbQ3V2OzWQlJejrYEnWvRBEs5uEw1TVH21Zj52/JAY1/7qrdJhXtpn4rFh
	iMZZMMP5IQMFykTRU0i3M6Au3oncA/vQfrmDjFrJZ4ugWYkhAMbZii6V6FMtSC2DsNO9Z8ejyS6
	4NAJAlTUSb5o4ZVlwmdi7X84Lx3qIRSg6TduZL/A==
X-Received: by 2002:a17:90b:510f:b0:359:8d95:4a57 with SMTP id 98e67ed59e1d1-359a6a5bcf7mr3831104a91.6.1772714287215;
        Thu, 05 Mar 2026 04:38:07 -0800 (PST)
Received: from [192.168.1.13] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa40c1bbsm1527196a91.14.2026.03.05.04.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 04:38:06 -0800 (PST)
Message-ID: <0bb1f7b9-18d0-4fe6-96a4-88a6082c3342@gmail.com>
Date: Thu, 5 Mar 2026 20:38:01 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: zoned: limit number of zones reclaimed in
 flush_space
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>,
 Boris Burkov <boris@bur.io>
References: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
 <20260305100644.356177-4-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <20260305100644.356177-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7133B211DCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22249-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wdc.com:email]
X-Rspamd-Action: no action

Hi Johannes,

Thank you for the patch! The analysis of the hung task in generic/551 is 
very clear.

I have a few minor suggestions/questions.

On 2026/3/5 18:06, Johannes Thumshirn wrote:
> Limit the number of zones reclaimed in flush_space()'s RECLAIM_ZONES
> state.
> 
> This prevents possibly long running reclaim sweeps to block other tasks in
> the system, while the system is under pressure anyways, causing the
> tasks to hang.
> 
> An example of this can be seen here, triggered by fstests generic/551:
> 
> generic/551        [   27.042349] run fstests generic/551 at 2026-02-27 11:05:30
>   BTRFS: device fsid 78c16e29-20d9-4c8e-bc04-7ba431be38ff devid 1 transid 8 /dev/vdb (254:16) scanned by mount (806)
>   BTRFS info (device vdb): first mount of filesystem 78c16e29-20d9-4c8e-bc04-7ba431be38ff
>   BTRFS info (device vdb): using crc32c checksum algorithm
>   BTRFS info (device vdb): host-managed zoned block device /dev/vdb, 64 zones of 268435456 bytes
>   BTRFS info (device vdb): zoned mode enabled with zone size 268435456
>   BTRFS info (device vdb): checking UUID tree
>   BTRFS info (device vdb): enabling free space tree
>   INFO: task kworker/u38:1:90 blocked for more than 120 seconds.
>         Not tainted 7.0.0-rc1+ #345
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:kworker/u38:1   state:D stack:0     pid:90    tgid:90    ppid:2      task_flags:0x4208060 flags:0x00080000
>   Workqueue: events_unbound btrfs_async_reclaim_data_space
>   Call Trace:
>    <TASK>
>    __schedule+0x34f/0xe70
>    schedule+0x41/0x140
>    schedule_timeout+0xa3/0x110
>    ? mark_held_locks+0x40/0x70
>    ? lockdep_hardirqs_on_prepare+0xd8/0x1c0
>    ? trace_hardirqs_on+0x18/0x100
>    ? lockdep_hardirqs_on+0x84/0x130
>    ? _raw_spin_unlock_irq+0x33/0x50
>    wait_for_completion+0xa4/0x150
>    ? __flush_work+0x24c/0x550
>    __flush_work+0x339/0x550
>    ? __pfx_wq_barrier_func+0x10/0x10
>    ? wait_for_completion+0x39/0x150
>    flush_space+0x243/0x660
>    ? find_held_lock+0x2b/0x80
>    ? kvm_sched_clock_read+0x11/0x20
>    ? local_clock_noinstr+0x17/0x110
>    ? local_clock+0x15/0x30
>    ? lock_release+0x1b7/0x4b0
>    do_async_reclaim_data_space+0xe8/0x160
>    btrfs_async_reclaim_data_space+0x19/0x30
>    process_one_work+0x20a/0x5f0
>    ? lock_is_held_type+0xcd/0x130
>    worker_thread+0x1e2/0x3c0
>    ? __pfx_worker_thread+0x10/0x10
>    kthread+0x103/0x150
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x20d/0x320
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
>   Showing all locks held in the system:
>   1 lock held by khungtaskd/67:
>    #0: ffffffff824d58e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x194
>   2 locks held by kworker/u38:1/90:
>    #0: ffff8881000aa158 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x3c4/0x5f0
>    #1: ffffc90000c17e58 ((work_completion)(&fs_info->async_data_reclaim_work)){+.+.}-{0:0}, at: process_one_work+0x1c0/0x5f0
>   5 locks held by kworker/u39:1/191:
>    #0: ffff8881000aa158 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x3c4/0x5f0
>    #1: ffffc90000dfbe58 ((work_completion)(&fs_info->reclaim_bgs_work)){+.+.}-{0:0}, at: process_one_work+0x1c0/0x5f0
>    #2: ffff888101da0420 (sb_writers#9){.+.+}-{0:0}, at: process_one_work+0x20a/0x5f0
>    #3: ffff88811040a648 (&fs_info->reclaim_bgs_lock){+.+.}-{4:4}, at: btrfs_reclaim_bgs_work+0x1de/0x770
>    #4: ffff888110408a18 (&fs_info->cleaner_mutex){+.+.}-{4:4}, at: btrfs_relocate_block_group+0x95a/0x20f0
>   1 lock held by aio-dio-write-v/980:
>    #0: ffff888110093008 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: btrfs_inode_lock+0x51/0xb0
> 
>   =============================================
> 
> To prevent these long running reclaims from blocking the system, only
> reclaim 5 block_groups in the RECLAIM_ZONES state of flush_space(). Also
> as these reclaims are now constrained, it opens up the use for a
> synchronous call to brtfs_reclaim_block_groups(), eliminating the need
> to place the reclaim task on a workqueue and then flushing the workqueue
> again.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/block-group.c | 13 +++++++++----
>   fs/btrfs/block-group.h |  1 +
>   fs/btrfs/space-info.c  |  3 +--
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 72fc9b3b6dc0..fa6e49a4ba37 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1909,7 +1909,7 @@ static bool should_reclaim_block_group(const struct btrfs_block_group *bg, u64 b
>   	return true;
>   }
>   
> -static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
> +static int btrfs_reclaim_block_group(struct btrfs_block_group *bg, int *reclaimed)
>   {
>   	struct btrfs_fs_info *fs_info = bg->fs_info;
>   	struct btrfs_space_info *space_info = bg->space_info;
> @@ -2036,15 +2036,18 @@ static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
>   	if (space_info->total_bytes < old_total)
>   		btrfs_set_periodic_reclaim_ready(space_info, true);
>   	spin_unlock(&space_info->lock);
> +	if (!ret)
> +		(*reclaimed)++;

We take the address, pass the pointer to this function and just for a 
conditional increase operation so I wonder if it would make sense to put 
this into the caller side. I think this will make the code easier to follow.

>   	return ret;
>   }
>   
> -static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
> +void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info, unsigned int limit)
>   {
>   	struct btrfs_block_group *bg;
>   	struct btrfs_space_info *space_info;
>   	LIST_HEAD(retry_list);
> +	int reclaimed = 0;
>   
>   	if (!btrfs_should_reclaim(fs_info))
>   		return;
> @@ -2080,7 +2083,7 @@ static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
>   
>   		space_info = bg->space_info;
>   		spin_unlock(&fs_info->unused_bgs_lock);
> -		ret = btrfs_reclaim_block_group(bg);
> +		ret = btrfs_reclaim_block_group(bg, &reclaimed);
>   
>   		if (ret && !READ_ONCE(space_info->periodic_reclaim))
>   			btrfs_link_bg_list(bg, &retry_list);
> @@ -2099,6 +2102,8 @@ static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
>   		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
>   			goto end;
>   		spin_lock(&fs_info->unused_bgs_lock);
> +		if (reclaimed >= limit)

Type of reclaimed is int and type of limit is unsigned int. Would it 
make sense to use both unsigned int here to make sure we're comparing 
variables with the same type and the behavior is expected?

> +			break;
>   	}
>   	spin_unlock(&fs_info->unused_bgs_lock);
>   	mutex_unlock(&fs_info->reclaim_bgs_lock);
> @@ -2114,7 +2119,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>   	struct btrfs_fs_info *fs_info =
>   		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
>   
> -	btrfs_reclaim_block_groups(fs_info);
> +	btrfs_reclaim_block_groups(fs_info, -1);
>   }
>   
>   void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index c03e04292900..0504cb357992 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -350,6 +350,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>   			     struct btrfs_chunk_map *map);
>   void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
>   void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
> +void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info, unsigned int limit);
>   void btrfs_reclaim_bgs_work(struct work_struct *work);
>   void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
>   void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 0e5274c3b988..57b74d0608ae 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -918,8 +918,7 @@ static void flush_space(struct btrfs_space_info *space_info, u64 num_bytes,
>   		if (btrfs_is_zoned(fs_info)) {
>   			btrfs_reclaim_sweep(fs_info);
>   			btrfs_delete_unused_bgs(fs_info);
> -			btrfs_reclaim_bgs(fs_info);
> -			flush_work(&fs_info->reclaim_bgs_work);
> +			btrfs_reclaim_block_groups(fs_info, 5);

Would it make sense to define this as a named constant like 
BTRFS_ZONED_SYNC_RECLAIM_BATCH instead of a magic number 5 here?

>   			ASSERT(current->journal_info == NULL);
>   			ret = btrfs_commit_current_transaction(root);
>   		} else {

Thanks again for the fix!

Best regards,
Sun YangKai


