Return-Path: <linux-btrfs+bounces-2375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A03854387
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C02EB210A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE011715;
	Wed, 14 Feb 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ugxhjz7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/ttg/ZC+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ugxhjz7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/ttg/ZC+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113211706
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896373; cv=none; b=gaa0ulYx5migfYkyFSArPOFwyKnGVfOxQRkXOJL/rR5y6X+4nm5ILMusjWykMWNWdyYkhUrZNKz0iwqhRc7Tkwn0A5LXWdWwaktArVpMDM33SLmlLSUIGVLGYK3XcJ0LrXkRW2lEDnTB2zHpXpMelBil2jvlvQ6IBrj2DTbippg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896373; c=relaxed/simple;
	bh=I/698zWjGv6OjZpYjbXQ5rJxUFudxeJndmIu1L5Wn9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4MXinNNJLPosB235IgbWffrtJGbV7lNMP0ifUj2vyjN6+hxYwOJQZnbDqnz4MoQZfAKSufQEOXT1Miji/sZTb7w4JVLdBZRfWCzlw2CHpU3hIH16s/NzmjFfnWc7l6sT6S4jHDNXsqju/z3NCKsFcQSorxMwSDZf0oH54Mrq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ugxhjz7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/ttg/ZC+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ugxhjz7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/ttg/ZC+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14D2821CFE;
	Wed, 14 Feb 2024 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707896369;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1jRQD3Y89aP88oTI6t9tfTKtHt2lB5XsjFBk4JaC5s=;
	b=ugxhjz7prMlOCZxNqDvFR0A/C5/VlrIXccC04Dyra6xcDOazyE5/Aik3+JtFsj3Mdy6oLs
	PDY3T4NWXwNsMJ5mjP5XKP2kM3gJzGiiV8YBifcbA18Qyy9UlCl8LP4kt1G829lBgxmX6M
	YMgP5qTUTLhlLP9Y33n+2nSSMKiKGE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707896369;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1jRQD3Y89aP88oTI6t9tfTKtHt2lB5XsjFBk4JaC5s=;
	b=/ttg/ZC+33IlqsDF5epEibjlIGC1HrUjzv1uU+17duVlJX+HwcmX/N7/tpK8+XfOsCshT9
	KZv/zB+gpAh5SJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707896369;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1jRQD3Y89aP88oTI6t9tfTKtHt2lB5XsjFBk4JaC5s=;
	b=ugxhjz7prMlOCZxNqDvFR0A/C5/VlrIXccC04Dyra6xcDOazyE5/Aik3+JtFsj3Mdy6oLs
	PDY3T4NWXwNsMJ5mjP5XKP2kM3gJzGiiV8YBifcbA18Qyy9UlCl8LP4kt1G829lBgxmX6M
	YMgP5qTUTLhlLP9Y33n+2nSSMKiKGE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707896369;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1jRQD3Y89aP88oTI6t9tfTKtHt2lB5XsjFBk4JaC5s=;
	b=/ttg/ZC+33IlqsDF5epEibjlIGC1HrUjzv1uU+17duVlJX+HwcmX/N7/tpK8+XfOsCshT9
	KZv/zB+gpAh5SJAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DE72913A1A;
	Wed, 14 Feb 2024 07:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3mDMNTBuzGXkLwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 14 Feb 2024 07:39:28 +0000
Date: Wed, 14 Feb 2024 08:38:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: raid56: extra debug for raid6 syndrome
 generation
Message-ID: <20240214073855.GO355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ceaa8a9d4a19dbe017012d5cdbd78aafeac31cc9.1706239278.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceaa8a9d4a19dbe017012d5cdbd78aafeac31cc9.1706239278.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Jan 26, 2024 at 01:51:32PM +1030, Qu Wenruo wrote:
> [BUG]
> I have got at least two crash report for RAID6 syndrome generation, no
> matter if it's AVX2 or SSE2, they all seems to have a similar
> calltrace with corrupted RAX:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP PTI
>  Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
>  RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_pq]
>  RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa0ff4cfa3248
>  RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 0000000000000000
>  Call Trace:
>   <TASK>
>   rmw_rbio+0x5c8/0xa80 [btrfs]
>   process_one_work+0x1c7/0x3d0
>   worker_thread+0x4d/0x380
>   kthread+0xf3/0x120
>   ret_from_fork+0x2c/0x50
>   </TASK>
> 
> [CAUSE]
> In fact I don't have any clue.
> 
> Recently I also hit this in AVX512 path, and that's even in v5.15
> backport, which doesn't have any of my RAID56 rework.
> 
> Furthermore according to the registers:
> 
>  RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa0ff4cfa3248
> 
> The RAX register is showing the number of stripes (including PQ),
> which is not correct (0).
> But the remaining two registers are all sane.
> 
> - RBX is the sectorsize
>   For x86_64 it should always be 4K and matches the output.
> 
> - RCX is the pointers array
>   Which is from rbio->finish_pointers, and it looks like a sane
>   kernel address.
> 
> [WORKAROUND]
> For now, I can only add extra debug ASSERT()s before we call raid6
> gen_syndrome() helper and hopes to catch the problem.
> 
> The debug requires both CONFIG_BTRFS_DEBUG and CONFIG_BTRFS_ASSERT
> enabled.
> 
> My current guess is some use-after-free, but every report is only having
> corrupted RAX but seemingly valid pointers doesn't make much sense.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

I haven't seen the crash for some time but with this patch I may add
some info once it happens again.

> ---
>  fs/btrfs/raid56.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 5c4bf3f907c1..6f4a9cfeea44 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -917,6 +917,13 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
>  	 */
>  	ASSERT(stripe_nsectors <= BITS_PER_LONG);
>  
> +	/*
> +	 * Real stripes must be between 2 (2 disks RAID5, aka RAID1) and 256
> +	 * (limited by u8).
> +	 */
> +	ASSERT(real_stripes >= 2);
> +	ASSERT(real_stripes <= U8_MAX);
> +
>  	rbio = kzalloc(sizeof(*rbio), GFP_NOFS);
>  	if (!rbio)
>  		return ERR_PTR(-ENOMEM);
> @@ -954,6 +961,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
>  
>  	ASSERT(btrfs_nr_parity_stripes(bioc->map_type));
>  	rbio->nr_data = real_stripes - btrfs_nr_parity_stripes(bioc->map_type);
> +	ASSERT(rbio->nr_data > 0);
>  
>  	return rbio;
>  }
> @@ -1180,6 +1188,26 @@ static inline void bio_list_put(struct bio_list *bio_list)
>  		bio_put(bio);
>  }
>  
> +static void assert_rbio(struct btrfs_raid_bio *rbio)

                           const strurct btrfs_raid_bio

> +{
> +	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG) ||
> +	    !IS_ENABLED(CONFIG_BTRFS_ASSERT))
> +		return;
> +
> +	/*
> +	 * At least two stripes (2 disks RAID5), and since real_stripes is U8,
> +	 * we won't go beyond 256 disks anyway.
> +	 */
> +	ASSERT(rbio->real_stripes >= 2);
> +	ASSERT(rbio->nr_data > 0);
> +
> +	/*
> +	 * This is another check to make sure nr data stripes is smaller
> +	 * than total stripes.
> +	 */
> +	ASSERT(rbio->nr_data < rbio->real_stripes);
> +}

