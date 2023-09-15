Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4077A2238
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 17:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjIOPWM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjIOPWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 11:22:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B6B10D9
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 08:21:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA93D218F0;
        Fri, 15 Sep 2023 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694791312;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MI++Q0j30s8FdCy7gV2tuu62j4gNiBFqtw5092SGFTk=;
        b=ZlaG25mPeuZ29/VIJlQ7O8SKQ0f92AcgjngllO4wKGvEHSx6Qbrm57nRnkM3AOebvUVJdH
        F7FU70QfHVzhmrLg3+ls0mawhPFjo6A5D7705KKMUyGSaO/brZI8RpX9sVBgviDvst4/gP
        PYCq2k2fSFp+cM3PvCYvx+XeXaqwAaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694791312;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MI++Q0j30s8FdCy7gV2tuu62j4gNiBFqtw5092SGFTk=;
        b=I2Vg06lVZ5O52vX832BrCTqa/kUC5UUlBw6NPD/3psTlGTHjtzA/rUAh6P6BHen4MaepkZ
        fNIlKnXs1QmvJUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D35C1358A;
        Fri, 15 Sep 2023 15:21:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NFHAHZB2BGWnGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Sep 2023 15:21:52 +0000
Date:   Fri, 15 Sep 2023 17:15:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Lee Trager <lee@trager.us>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Allow online resize to use "min" shortcut
Message-ID: <20230915151518.GD2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230825010542.4158944-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825010542.4158944-1-lee@trager.us>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 06:05:42PM -0700, Lee Trager wrote:
> btrfs already supports online resize and has a "max" shortcut to expand to
> all available space on the disk. This creates a "min" shortcut which shrinks
> the filesystem to allocated space.
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
>  fs/btrfs/ioctl.c   |  10 ++--
>  fs/btrfs/volumes.c | 123 ++++++++++++++++++++++++++++++++++++---------
>  fs/btrfs/volumes.h |   3 +-
>  3 files changed, 109 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a895d105464b..c2bb6e18d80f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1108,6 +1108,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>  	int ret = 0;
>  	int mod = 0;
>  	bool cancel;
> +	bool to_min = false;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -1165,9 +1166,12 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>  		goto out_finish;
>  	}
>  
> -	if (!strcmp(sizestr, "max"))
> +	if (!strcmp(sizestr, "max")) {
>  		new_size = bdev_nr_bytes(device->bdev);
> -	else {
> +	} else if (!strcmp(sizestr, "min")) {
> +		to_min = true;
> +		new_size = SZ_256M;
> +	} else {
>  		if (sizestr[0] == '-') {
>  			mod = -1;
>  			sizestr++;
> @@ -1223,7 +1227,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>  		ret = btrfs_grow_device(trans, device, new_size);
>  		btrfs_commit_transaction(trans);
>  	} else if (new_size < old_size) {
> -		ret = btrfs_shrink_device(device, new_size);
> +		ret = btrfs_shrink_device(device, &new_size, to_min);
>  	} /* equal, nothing need to do */
>  
>  	if (ret == 0 && new_size != old_size)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 733842136163..257e7f004ce7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2145,7 +2145,8 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  		mutex_unlock(&fs_info->chunk_mutex);
>  	}
>  
> -	ret = btrfs_shrink_device(device, 0);
> +	u64 size = 0;
> +	ret = btrfs_shrink_device(device, &size, false);
>  	if (ret)
>  		goto error_undo;
>  
> @@ -4816,12 +4817,74 @@ int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info)
>  	return 0;
>  }
>  
> +u64 btrfs_get_allocated_space(struct btrfs_fs_info *fs_info)
> +{
> +	u64 ret = 0;
> +	u64 metadata_ratio = 1;
> +	static const u64 types[] = {
> +		BTRFS_BLOCK_GROUP_DATA,
> +		BTRFS_BLOCK_GROUP_SYSTEM,
> +		BTRFS_BLOCK_GROUP_METADATA,
> +		BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_METADATA
> +	};
> +
> +	for (int i = 0; i < 4; i++) {
> +		struct btrfs_space_info *tmp = NULL;
> +		struct btrfs_space_info *info = NULL;
> +
> +		list_for_each_entry(tmp, &fs_info->space_info, list) {
> +			if (tmp->flags == types[i]) {
> +				info = tmp;
> +				break;
> +			}
> +		}
> +
> +		if (!info)
> +			continue;
> +
> +		down_read(&info->groups_sem);
> +		for (int c = 0; c < BTRFS_NR_RAID_TYPES; c++) {
> +			if (list_empty(&info->block_groups[c]))
> +				continue;
> +
> +			struct btrfs_block_group *bg;
> +			list_for_each_entry(bg, &info->block_groups[c], list) {
> +				enum btrfs_raid_types i;
> +				u64 ratio;
> +				i = btrfs_bg_flags_to_raid_index(bg->flags);
> +				ratio = btrfs_raid_array[i].ncopies;
> +				if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
> +					ret += bg->length * ratio;
> +				if (bg->flags & BTRFS_BLOCK_GROUP_METADATA) {
> +					metadata_ratio = max(metadata_ratio, ratio);
> +					ret += bg->length * ratio;
> +				}
> +				if (bg->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +					ret += bg->length * ratio;
> +			}
> +		}
> +		up_read(&info->groups_sem);
> +	}
> +	/*
> +	* btrfs_shrink_device relocates chunks to shrink the filesystem. In
> +	* order to do so extra space must be reserved for metadata operations
> +	* which require 3 + num of devices with a minimum of metadata
> +	* duplication(default 2) as discovered above. See comment in
> +	* btrfs_trans_handle for a full explination.
> +	*/
> +	ret += btrfs_calc_insert_metadata_size(
> +		fs_info,
> +		3 + max(metadata_ratio, fs_info->fs_devices->total_devices));
> +
> +	return ret;
> +}
> +
>  /*
>   * shrinking a device means finding all of the device extents past
>   * the new size, and then following the back refs to the chunks.
>   * The chunk relocation code actually frees the device extent
>   */
> -int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
> +int btrfs_shrink_device(struct btrfs_device *device, u64 *new_size, bool to_min)
>  {
>  	struct btrfs_fs_info *fs_info = device->fs_info;
>  	struct btrfs_root *root = fs_info->dev_root;
> @@ -4842,10 +4905,6 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  	u64 diff;
>  	u64 start;
>  
> -	new_size = round_down(new_size, fs_info->sectorsize);
> -	start = new_size;
> -	diff = round_down(old_size - new_size, fs_info->sectorsize);
> -
>  	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
>  		return -EINVAL;
>  
> @@ -4855,6 +4914,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  
>  	path->reada = READA_BACK;
>  
> +again:
>  	trans = btrfs_start_transaction(root, 0);
>  	if (IS_ERR(trans)) {
>  		btrfs_free_path(path);
> @@ -4863,28 +4923,45 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  
>  	mutex_lock(&fs_info->chunk_mutex);
>  
> -	btrfs_device_set_total_bytes(device, new_size);
> -	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> -		device->fs_devices->total_rw_bytes -= diff;
> -		atomic64_sub(diff, &fs_info->free_chunk_space);
> -	}
> -
>  	/*
> -	 * Once the device's size has been set to the new size, ensure all
> -	 * in-memory chunks are synced to disk so that the loop below sees them
> -	 * and relocates them accordingly.
> +	 * Ensure all in-memory chunks are synced to disk before calculating the
> +	 * new size to ensure the loop below can relocate them.
>  	 */
> -	if (contains_pending_extent(device, &start, diff)) {
> +	start = 0;
> +	if (contains_pending_extent(device, &start, old_size)) {
>  		mutex_unlock(&fs_info->chunk_mutex);
>  		ret = btrfs_commit_transaction(trans);
> -		if (ret)
> -			goto done;
> +		if (ret) {
> +			btrfs_free_path(path);
> +			return PTR_ERR(trans);
> +		}
> +		mutex_lock(&fs_info->chunk_mutex);
>  	} else {
> -		mutex_unlock(&fs_info->chunk_mutex);
>  		btrfs_end_transaction(trans);
>  	}
>  
> -again:
> +	if (to_min)
> +		*new_size = btrfs_get_allocated_space(fs_info);
> +
> +	*new_size = round_down(*new_size, fs_info->sectorsize);
> +	diff = round_down(old_size - *new_size, fs_info->sectorsize);
> +
> +	trans = btrfs_start_transaction(root, 0);

For the record, the transaction is started and ended under chunk_mutex
which leads to a lockdep warning due to lock inversion, can be
reproduced by btrfs/003:

[   63.359090] ======================================================
[   63.359687] WARNING: possible circular locking dependency detected
[   63.360278] 6.6.0-rc1-default+ #185 Not tainted
[   63.360735] ------------------------------------------------------
[   63.361320] btrfs/31777 is trying to acquire lock:
[   63.361798] ffffa1b800a0e648 (sb_internal#2){.+.+}-{0:0}, at: btrfs_shrink_device+0x153/0x680 [btrfs]
[   63.362680] 
[   63.362680] but task is already holding lock:
[   63.363260] ffffa1b82efdc9b0 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_shrink_device+0xff/0x680 [btrfs]
[   63.364194] 
[   63.364194] which lock already depends on the new lock.
[   63.364194] 
[   63.364975] 
[   63.364975] the existing dependency chain (in reverse order) is:
[   63.365688] 
[   63.365688] -> #3 (&fs_info->chunk_mutex){+.+.}-{3:3}:
[   63.366326]        __lock_acquire+0x4f5/0xb50
[   63.366772]        lock_acquire+0xb3/0x290
[   63.367195]        __mutex_lock+0x91/0xb70
[   63.367619]        btrfs_chunk_alloc+0x14a/0x330 [btrfs]
[   63.368171]        flush_space+0xc6/0x2c0 [btrfs]
[   63.368673]        btrfs_async_reclaim_data_space+0x55/0x160 [btrfs]
[   63.369296]        process_one_work+0x1e1/0x4c0
[   63.369752]        worker_thread+0x1d5/0x3c0
[   63.370189]        kthread+0xd3/0x100
[   63.370582]        ret_from_fork+0x28/0x40
[   63.371010]        ret_from_fork_asm+0x11/0x20
[   63.371459] 
[   63.371459] -> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
[   63.372136]        __lock_acquire+0x4f5/0xb50
[   63.372585]        lock_acquire+0xb3/0x290
[   63.373006]        join_transaction+0xf5/0x570 [btrfs]
[   63.373618]        start_transaction+0x1ab/0x920 [btrfs]
[   63.374258]        btrfs_uuid_scan_kthread+0x2b3/0x3c0 [btrfs]
[   63.374948]        kthread+0xd3/0x100
[   63.375403]        ret_from_fork+0x28/0x40
[   63.375925]        ret_from_fork_asm+0x11/0x20
[   63.376458] 
[   63.376458] -> #1 (btrfs_trans_num_writers){++++}-{0:0}:
[   63.377239]        __lock_acquire+0x4f5/0xb50
[   63.377756]        lock_acquire+0xb3/0x290
[   63.378251]        join_transaction+0xc8/0x570 [btrfs]
[   63.378867]        start_transaction+0x1ab/0x920 [btrfs]
[   63.379497]        btrfs_uuid_scan_kthread+0x2b3/0x3c0 [btrfs]
[   63.380167]        kthread+0xd3/0x100
[   63.380614]        ret_from_fork+0x28/0x40
[   63.381105]        ret_from_fork_asm+0x11/0x20
[   63.381627] 
[   63.381627] -> #0 (sb_internal#2){.+.+}-{0:0}:
[   63.382311]        check_prev_add+0xf4/0xcd0
[   63.382820]        validate_chain+0x560/0x800
[   63.383334]        __lock_acquire+0x4f5/0xb50
[   63.383853]        lock_acquire+0xb3/0x290
[   63.384349]        start_transaction+0x459/0x920 [btrfs]
[   63.384972]        btrfs_shrink_device+0x153/0x680 [btrfs]
[   63.385618]        btrfs_rm_device+0x1c0/0x8a0 [btrfs]
[   63.386270]        btrfs_ioctl_rm_dev_v2+0x1c2/0x260 [btrfs]
[   63.386989]        __x64_sys_ioctl+0x85/0xa0
[   63.387531]        do_syscall_64+0x2c/0x50
[   63.388083]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   63.388785] 
[   63.388785] other info that might help us debug this:
[   63.388785] 
[   63.389746] Chain exists of:
[   63.389746]   sb_internal#2 --> btrfs_trans_num_extwriters --> &fs_info->chunk_mutex
[   63.389746] 
[   63.391239]  Possible unsafe locking scenario:
[   63.391239] 
[   63.392037]        CPU0                    CPU1
[   63.392653]        ----                    ----
[   63.393255]   lock(&fs_info->chunk_mutex);
[   63.393820]                                lock(btrfs_trans_num_extwriters);
[   63.394637]                                lock(&fs_info->chunk_mutex);
[   63.395446]   rlock(sb_internal#2);
[   63.395936] 
[   63.395936]  *** DEADLOCK ***
[   63.395936] 
[   63.396742] 2 locks held by btrfs/31777:
[   63.397247]  #0: ffffa1b800a0e428 (sb_writers#10){.+.+}-{0:0}, at: btrfs_ioctl_rm_dev_v2+0xce/0x260 [btrfs]
[   63.398386]  #1: ffffa1b82efdc9b0 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_shrink_device+0xff/0x680 [btrfs]
[   63.399643] 
[   63.399643] stack backtrace:
[   63.400215] CPU: 2 PID: 31777 Comm: btrfs Not tainted 6.6.0-rc1-default+ #185
[   63.401041] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[   63.402377] Call Trace:
[   63.402744]  
[   63.403102]  dump_stack_lvl+0x46/0x70
[   63.403637]  check_noncircular+0x130/0x150
[   63.408308]  ? check_prev_add+0x106/0xcd0
[   63.408874]  ? add_chain_cache+0x110/0x450
[   63.409395]  check_prev_add+0xf4/0xcd0
[   63.409910]  ? alloc_chain_hlocks+0xd6/0x220
[   63.410451]  ? add_chain_cache+0x110/0x450
[   63.410997]  validate_chain+0x560/0x800
[   63.411524]  ? __lock_acquire+0x4f5/0xb50
[   63.412067]  __lock_acquire+0x4f5/0xb50
[   63.412592]  ? fs_reclaim_acquire+0x48/0xd0
[   63.413150]  lock_acquire+0xb3/0x290
[   63.413648]  ? btrfs_shrink_device+0x153/0x680 [btrfs]
[   63.414347]  ? lock_is_held_type+0x84/0xf0
[   63.414900]  start_transaction+0x459/0x920 [btrfs]
[   63.415534]  ? btrfs_shrink_device+0x153/0x680 [btrfs]
[   63.416213]  btrfs_shrink_device+0x153/0x680 [btrfs]
[   63.416891]  ? __mutex_unlock_slowpath+0x35/0x290
[   63.417508]  btrfs_rm_device+0x1c0/0x8a0 [btrfs]
[   63.418151]  ? exclop_start_or_cancel_reloc+0x34/0xd0 [btrfs]
[   63.418871]  ? lock_release+0x61/0x100
[   63.419388]  btrfs_ioctl_rm_dev_v2+0x1c2/0x260 [btrfs]
[   63.420083]  __x64_sys_ioctl+0x85/0xa0
[   63.420600]  do_syscall_64+0x2c/0x50
[   63.421098]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   63.421747] RIP: 0033:0x7fe48ba622cf
[   63.424421] RSP: 002b:00007ffcba63b420 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   63.425398] RAX: ffffffffffffffda RBX: 00007ffcba63b4a0 RCX: 00007fe48ba622cf
[   63.426265] RDX: 00007ffcba63b4a0 RSI: 000000005000943a RDI: 0000000000000003
[   63.427108] RBP: 0000000000000000 R08: 0000000000000073 R09: 0000000000000001
[   63.427949] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcba63d660
[   63.428776] R13: 0000000000000003 R14: 0000000000000000 R15: 00007ffcba63d668
[   63.429596]  
[   63.430106] BTRFS info (device vdb): relocating block group 30408704 flags metadata|raid1
[   63.448670] BTRFS info (device vdb): found 10 extents, stage: move data extents
[   63.461651] BTRFS info (device vdb): relocating block group 22020096 flags system|raid1
[   63.474134] BTRFS info (device vdb): found 1 extents, stage: move data extents
[   63.512126] BTRFS info (device vdb): device deleted: /dev/vdi


> +	if (IS_ERR(trans)) {
> +		mutex_unlock(&fs_info->chunk_mutex);
> +		btrfs_free_path(path);
> +		return PTR_ERR(trans);
> +	}
> +
> +	btrfs_device_set_total_bytes(device, *new_size);
> +	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> +		device->fs_devices->total_rw_bytes -= diff;
> +		atomic64_sub(diff, &fs_info->free_chunk_space);
> +	}
> +
> +	btrfs_end_transaction(trans);
> +	mutex_unlock(&fs_info->chunk_mutex);
> +
>  	key.objectid = device->devid;
>  	key.offset = (u64)-1;
>  	key.type = BTRFS_DEV_EXTENT_KEY;
> @@ -4920,7 +4997,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
>  		length = btrfs_dev_extent_length(l, dev_extent);
>  
> -		if (key.offset + length <= new_size) {
> +		if (key.offset + length <= *new_size) {
>  			mutex_unlock(&fs_info->reclaim_bgs_lock);
>  			btrfs_release_path(path);
>  			break;
> @@ -4973,10 +5050,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  
>  	mutex_lock(&fs_info->chunk_mutex);
>  	/* Clear all state bits beyond the shrunk device size */
> -	clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
> +	clear_extent_bits(&device->alloc_state, *new_size, (u64)-1,
>  			  CHUNK_STATE_MASK);
>  
> -	btrfs_device_set_disk_total_bytes(device, new_size);
> +	btrfs_device_set_disk_total_bytes(device, *new_size);
>  	if (list_empty(&device->post_commit_list))
>  		list_add_tail(&device->post_commit_list,
>  			      &trans->transaction->dev_update_list);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 2128a032c3b7..db8000b4cf94 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -636,7 +636,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
>  		      struct btrfs_device *device, u64 new_size);
>  struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
>  				       const struct btrfs_dev_lookup_args *args);
> -int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
> +int btrfs_shrink_device(struct btrfs_device *device, u64 *new_size, bool to_min);
>  int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
>  int btrfs_balance(struct btrfs_fs_info *fs_info,
>  		  struct btrfs_balance_control *bctl,
> @@ -648,6 +648,7 @@ int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
>  int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
>  int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
>  int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
> +u64 btrfs_get_allocated_space(struct btrfs_fs_info *fs_info);
>  int btrfs_uuid_scan_kthread(void *data);
>  bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
>  void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
> -- 
> 2.34.1
