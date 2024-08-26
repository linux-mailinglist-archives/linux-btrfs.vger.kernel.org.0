Return-Path: <linux-btrfs+bounces-7533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9992795FDCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 01:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6FB1C21086
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 23:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD5519A2BD;
	Mon, 26 Aug 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8pxPKpC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YeQ3Hm6S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDg30KxG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RtJ4NYE0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544B7DA92
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724715089; cv=none; b=YZp829p3LsHDfWiElzlIVHQUOF+SSyzuSzTtQotIs7G7O+snixXOIUWJGfYV655VnKcc9RzWn+mzpGx+VovGT8rWbOa8vVmqLApXTi5fSbEcyFhX2Y0kwVVWZu50qi1VDjyhmBSG4vVdcM2egW26UGDnRJEo1RBkpdDdfEkYLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724715089; c=relaxed/simple;
	bh=MhHa0cptwQRBVEbA2o9ezOmM9JyVpL8pp26vk94+ELs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRTghO/iQ2G2UEE4o/MFWFkAcXy2dpBRNKVSlzIg4KKgvBRmKaYt3Ek7m7HimVhQzMLLJZiXtDFKUAL2Q+66TZNRoEo5GGp9F+SLWbSTjq/MbFPQiVagoNpJGmvCUS2zbeFSVhrebnefvwElK5r3vlW/k8fpvGiPnTYrl/iQCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8pxPKpC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YeQ3Hm6S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDg30KxG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RtJ4NYE0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECFF721AEE;
	Mon, 26 Aug 2024 23:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724715086;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xCNRb6r4CnZau+Ephjvu391xhBbA9UbTZL2mcEwAxPo=;
	b=i8pxPKpC1X2HuYfR2mm6lqtzDRGsIO9EvUlEQAxY4N+bymqbHBKybMyVlqZ4y8dL1mt6no
	rkp5jZMGlSeJRcvsge7jXnRAPS2tlnTIXbjJQXnPIC1bbSQ/TMMZysgExPcfAdn4U9L0W9
	BbqNP2oj5I13oUYVpan0wY5vWL6I2m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724715086;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xCNRb6r4CnZau+Ephjvu391xhBbA9UbTZL2mcEwAxPo=;
	b=YeQ3Hm6ScITaJlTxeufl2Ahh0O01+30QiIuip8pKKjV9kdof39u/Y+7QEAM/lYyrUQ4nIb
	BIFffbkwxRmhIxCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724715085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xCNRb6r4CnZau+Ephjvu391xhBbA9UbTZL2mcEwAxPo=;
	b=oDg30KxGbO//XAMCG7AuKaJybrUPTs4rasnKhUMBF8qMjYMEh4P9iJnoWYOYcIqVzXlaYg
	5wiqxxbGaTcz1tlQFlPGo+JWTWAt2y16fpJGVV/nY9jUTRpofWSTnxhZagAy5ZRyPlmhUr
	GpPTMjE0j/T+CFBbQO9oCfQ2Mauhfe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724715085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xCNRb6r4CnZau+Ephjvu391xhBbA9UbTZL2mcEwAxPo=;
	b=RtJ4NYE0x4B6vL8OZYHP7fmM4B15x9xfw7xIm6UZldoNe4kf9Z1ME8W+DW59iBIxEu5B6T
	Mn4pzZrwVJ6+ZOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEBEE1398D;
	Mon, 26 Aug 2024 23:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ivsULk0QzWYceQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 26 Aug 2024 23:31:25 +0000
Date: Tue, 27 Aug 2024 01:31:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v4] btrfs: fix a use-after-free bug when hitting errors
 inside btrfs_submit_chunk()
Message-ID: <20240826233116.GT25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f4f916352ddf3f80048567ec7d8cc64cb388dc09.1724493430.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f916352ddf3f80048567ec7d8cc64cb388dc09.1724493430.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,opensuse.org:url];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, Aug 24, 2024 at 07:28:23PM +0930, Qu Wenruo wrote:
> [BUG]
> There is an internal report that KASAN is reporting use-after-free, with
> the following backtrace:
> 
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in btrfs_check_read_bio+0xa68/0xb70 [btrfs]
>  Read of size 4 at addr ffff8881117cec28 by task kworker/u16:2/45
>  CPU: 1 UID: 0 PID: 45 Comm: kworker/u16:2 Not tainted 6.11.0-rc2-next-20240805-default+ #76
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>  Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x61/0x80
>   print_address_description.constprop.0+0x5e/0x2f0
>   print_report+0x118/0x216
>   kasan_report+0x11d/0x1f0
>   btrfs_check_read_bio+0xa68/0xb70 [btrfs]
>   process_one_work+0xce0/0x12a0
>   worker_thread+0x717/0x1250
>   kthread+0x2e3/0x3c0
>   ret_from_fork+0x2d/0x70
>   ret_from_fork_asm+0x11/0x20
>   </TASK>
> 
>  Allocated by task 20917:
>   kasan_save_stack+0x37/0x60
>   kasan_save_track+0x10/0x30
>   __kasan_slab_alloc+0x7d/0x80
>   kmem_cache_alloc_noprof+0x16e/0x3e0
>   mempool_alloc_noprof+0x12e/0x310
>   bio_alloc_bioset+0x3f0/0x7a0
>   btrfs_bio_alloc+0x2e/0x50 [btrfs]
>   submit_extent_page+0x4d1/0xdb0 [btrfs]
>   btrfs_do_readpage+0x8b4/0x12a0 [btrfs]
>   btrfs_readahead+0x29a/0x430 [btrfs]
>   read_pages+0x1a7/0xc60
>   page_cache_ra_unbounded+0x2ad/0x560
>   filemap_get_pages+0x629/0xa20
>   filemap_read+0x335/0xbf0
>   vfs_read+0x790/0xcb0
>   ksys_read+0xfd/0x1d0
>   do_syscall_64+0x6d/0x140
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
>  Freed by task 20917:
>   kasan_save_stack+0x37/0x60
>   kasan_save_track+0x10/0x30
>   kasan_save_free_info+0x37/0x50
>   __kasan_slab_free+0x4b/0x60
>   kmem_cache_free+0x214/0x5d0
>   bio_free+0xed/0x180
>   end_bbio_data_read+0x1cc/0x580 [btrfs]
>   btrfs_submit_chunk+0x98d/0x1880 [btrfs]
>   btrfs_submit_bio+0x33/0x70 [btrfs]
>   submit_one_bio+0xd4/0x130 [btrfs]
>   submit_extent_page+0x3ea/0xdb0 [btrfs]
>   btrfs_do_readpage+0x8b4/0x12a0 [btrfs]
>   btrfs_readahead+0x29a/0x430 [btrfs]
>   read_pages+0x1a7/0xc60
>   page_cache_ra_unbounded+0x2ad/0x560
>   filemap_get_pages+0x629/0xa20
>   filemap_read+0x335/0xbf0
>   vfs_read+0x790/0xcb0
>   ksys_read+0xfd/0x1d0
>   do_syscall_64+0x6d/0x140
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [CAUSE]
> Although I can not reproduce the error, the report itself is good enough
> to pin down the cause.
> 
> The call trace is the regular endio workqueue context, but the
> free-by-task trace is showing that during btrfs_submit_chunk() we
> already hit a critical error, and is calling btrfs_bio_end_io() to error
> out.
> And the original endio function called bio_put() to free the whole bio.
> 
> This means a double freeing thus causing use-after-free, e.g:
> 
> 1. Enter btrfs_submit_bio() with a read bio
>    The read bio length is 128K, crossing two 64K stripes.
> 
> 2. The first run of btrfs_submit_chunk()
> 
> 2.1 Call btrfs_map_block(), which returns 64K
> 2.2 Call btrfs_split_bio()
>     Now there are two bios, one referring to the first 64K, the other
>     referring to the second 64K.
> 2.3 The first half is submitted.
> 
> 3. The second run of btrfs_submit_chunk()
> 
> 3.1 Call btrfs_map_block(), which by somehow failed
>     Now we call btrfs_bio_end_io() to handle the error
> 
> 3.2 btrfs_bio_end_io() calls the original endio function
>     Which is end_bbio_data_read(), and it calls bio_put() for the
>     original bio.
> 
>     Now the original bio is freed.
> 
> 4. The submitted first 64K bio finished
>    Now we call into btrfs_check_read_bio() and tries to advance the bio
>    iter.
>    But since the original bio (thus its iter) is already freed, we
>    trigger the above use-after free.
> 
>    And even if the memory is not poisoned/corrupted, we will later call
>    the original endio function, causing a double freeing.
> 
> [FIX]
> Instead of calling btrfs_bio_end_io(), call btrfs_orig_bbio_end_io(),
> which has the extra check on split bios and do the proper refcounting
> for cloned bios.
> 
> Furthermore there is already one extra btrfs_cleanup_bio() call, but
> that is duplicated to btrfs_orig_bbio_end_io() call, so remove that
> tag completely.
> 
> Reported-by: David Sterba <dsterba@suse.cz>
> Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v4:
> - Fix a case where the endio function is never called
>   If we have split the bbio and hit a critical error, we have to end
>   both the current and the remaining bbio.
>   As the remaining one will never be submitted, thus pending_ios will
>   never reach 0.

The tests now pass, thanks.

Reviewed-by: David Sterba <dsterba@suse.com>

