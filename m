Return-Path: <linux-btrfs+bounces-2373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BC285436D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4331F23EB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7973A11716;
	Wed, 14 Feb 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pSAZHF22";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJm1BrRA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pSAZHF22";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJm1BrRA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93511706;
	Wed, 14 Feb 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895763; cv=none; b=tQO1rEYUwORY06mn2GnCaBAbMbPQLIF8YP09oQlAN2X6CtIek34W/TWg2x77RlhhuhpP82+KuJgAarFivdAEj6U2KIpGl78Seijq8A4qoToPjSrHx0sQQx0qhV2r04aEpMfl1zAux0O2huioQjcKp8U99jp2mZ3oVkg44yugyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895763; c=relaxed/simple;
	bh=TeCxF15kULsWU5I+DAj4S00x9YDF9aI9s1jQFFOAQSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9LnvdfsdQP8acjZEXfhnDvHPpGzvxag8ryCnZQtlxcBSJ0lFePiSUd84ubqfnAApiGl+ecW8sZumN0Dx0YUmL7rXuqUi7gci8XwAnvHAq9ga7t9dQIPuHfnDYLO5fLNuF9ObTts23f/8nxNtcxhqf11s9rtwCNBgnq+9xVSm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pSAZHF22; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJm1BrRA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pSAZHF22; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJm1BrRA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C99C71F7DF;
	Wed, 14 Feb 2024 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707895759;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxfufwcXCmeT8jy7d2emFGeByqvLVWQBezvzM4KJwno=;
	b=pSAZHF22XxCwGXpi1S6/w/AzG7dNFg/zrfzQ7f1tlkuvX/QQaRkztoH+pt2LlCm49AFja9
	dlInV2hAWbloCml5ufCCZv8ZhmK6JH9TKoBlLX000pUsTfXw7G1udsHCzY3aYW9lVUVyb3
	ZWy3dj3UoazhBTz95yP4R8HNw2rrpyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707895759;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxfufwcXCmeT8jy7d2emFGeByqvLVWQBezvzM4KJwno=;
	b=LJm1BrRA+YOySnSyAL/leOUwTKfBkqCpvXr4Kc38brqnngeoXB/mVqDLY+Xw6Y2R8ILR6X
	Fw3Epy2UEHbRfBCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707895759;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxfufwcXCmeT8jy7d2emFGeByqvLVWQBezvzM4KJwno=;
	b=pSAZHF22XxCwGXpi1S6/w/AzG7dNFg/zrfzQ7f1tlkuvX/QQaRkztoH+pt2LlCm49AFja9
	dlInV2hAWbloCml5ufCCZv8ZhmK6JH9TKoBlLX000pUsTfXw7G1udsHCzY3aYW9lVUVyb3
	ZWy3dj3UoazhBTz95yP4R8HNw2rrpyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707895759;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxfufwcXCmeT8jy7d2emFGeByqvLVWQBezvzM4KJwno=;
	b=LJm1BrRA+YOySnSyAL/leOUwTKfBkqCpvXr4Kc38brqnngeoXB/mVqDLY+Xw6Y2R8ILR6X
	Fw3Epy2UEHbRfBCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A09D813A1A;
	Wed, 14 Feb 2024 07:29:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wg17Js9rzGUcLgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 14 Feb 2024 07:29:19 +0000
Date: Wed, 14 Feb 2024 08:28:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, HAN Yuwei <hrx@bupt.moe>,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
Message-ID: <20240214072846.GM355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon, Feb 12, 2024 at 03:46:15PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that with zoned device and sectorsize is smaller
> than page size (aka, subpage), btrfs would crash with a very basic
> workload:
> 
>  # getconfig PAGESIZE
>  16384
>  # mkfs.btrfs -f $dev -s 4k
>  # mount $dev $mnt
>  # $fsstress -w -n 8 -s 1707820327 -v -d $mnt
>  # umount $mnt
> 
> The crash would look like this (with CONFIG_BTRFS_ASSERT enabled):
> 
>  assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1384
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/extent_io.c:1384!
>  CPU: 0 PID: 872 Comm: kworker/u9:2 Tainted: G           OE      6.8.0-rc3-custom+ #7
>  Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20231122-12.fc39 11/22/2023
>  Workqueue: writeback wb_workfn (flush-btrfs-8)
>  pc : __extent_writepage_io+0x404/0x460 [btrfs]
>  lr : __extent_writepage_io+0x404/0x460 [btrfs]
>  Call trace:
>   __extent_writepage_io+0x404/0x460 [btrfs]
>   extent_write_locked_range+0x16c/0x460 [btrfs]
>   run_delalloc_cow+0x88/0x118 [btrfs]
>   btrfs_run_delalloc_range+0x128/0x228 [btrfs]
>   writepage_delalloc+0xb8/0x178 [btrfs]
>   __extent_writepage+0xc8/0x3a0 [btrfs]
>   extent_write_cache_pages+0x1cc/0x460 [btrfs]
>   extent_writepages+0x8c/0x120 [btrfs]
>   btrfs_writepages+0x18/0x30 [btrfs]
>   do_writepages+0x94/0x1f8
>   __writeback_single_inode+0x4c/0x388
>   writeback_sb_inodes+0x208/0x4b0
>   wb_writeback+0x118/0x3c0
>   wb_do_writeback+0xbc/0x388
>   wb_workfn+0x80/0x240
>   process_one_work+0x154/0x3c8
>   worker_thread+0x2bc/0x3e0
>   kthread+0xf4/0x108
>   ret_from_fork+0x10/0x20
>  Code: 9102c021 90000be0 91378000 9402bf53 (d4210000)
>  ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> There are several factors causing the problem:
> 
> 1. __extent_writepage_io() requires all dirty ranges to have delalloc
>    executed
>    This can be solved by adding @start and @len parameter to only submit
>    IO for a subset of the page, and update several involved helpers to
>    do subpage checks.
> 
>    So this is not a big deal.
> 
> 2. Subpage only accepts for full page aligned ranges for
>    extent_write_locked_range()
>    For zoned device, regular COW is switched to utilize
>    extent_write_locked_range() to submit the IO.
> 
>    But the caller, run_delalloc_cow() can be called to run on a subpage
>    range, e.g.
> 
>    0     4K     8K    12K     16K
>    |/////|      |/////|
> 
>    Where |///| is the dirtied range.
> 
>    In that case, btrfs_run_delalloc_range() would call run_delalloc_cow(),
>    which would call extent_write_locked_range() for [0, 4K), and unlock
>    the whole [0, 16K) page.
> 
>    But btrfs_run_delalloc_range() would again be called for range [8K,
>    12K), as there are still dirty range left.
>    In that case, since the whole page is already unlocked by previous
>    iteration, and would cause different ASSERT()s inside
>    extent_write_locked_range().
> 
>    That's also why compression for subpage cases require fully page
>    aligned range.
> 
> [WORKAROUND]
> A proper fix requires some big changes to delalloc workload, to allow
> extent_write_locked_range() to handle multiple different entries with
> the same @locked_page.
> 
> So for now, disable read-write support for subpage zoned btrfs.
> 
> The problem can only be solved if subpage btrfs can handle subpage
> compression, which need quite some work on the delalloc procedure for
> the @locked_page handling.
> 
> Reported-by: HAN Yuwei <hrx@bupt.moe>
> Link: https://lore.kernel.org/all/1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe/
> CC: stable@vger.kernel.org # 5.10+
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c3ab268533ca..85cd23aebdd6 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3193,7 +3193,8 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
>  	 * part of @locked_page.
>  	 * That's also why compression for subpage only work for page aligned ranges.
>  	 */
> -	if (fs_info->sectorsize < PAGE_SIZE && btrfs_is_zoned(fs_info) && is_rw_mount) {
> +	if (fs_info->sectorsize < PAGE_SIZE &&
> +	    btrfs_fs_incompat(fs_info, ZONED) && is_rw_mount) {
>  		btrfs_warn(fs_info,
>  	"no zoned read-write support for page size %lu with sectorsize %u",
>  			   PAGE_SIZE, fs_info->sectorsize);

This does not match any code I see in usual branches and it also does
not apply so it can't be picked as a fix.

