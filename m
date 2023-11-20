Return-Path: <linux-btrfs+bounces-198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7C7F1960
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473DA281459
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221E1F959;
	Mon, 20 Nov 2023 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJ94Ftup";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uj+iC2de"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8B011C
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 09:07:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A72EB2190C;
	Mon, 20 Nov 2023 17:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700500044;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lu6qpvpIjbFFS0dtCUNSuWUFNVh7uKaxNmTkI1Ge7w=;
	b=PJ94FtupWmcVUdwRUjHVf9NrJeKnuUKuoB2Oo74htsR7tUz3s5cLISAjHF/XrrFIZP368G
	XJ7IR1z4wddCBbM56Xjev0dcyFlvtF8arr3d1X6xQ+jCUfAkDnxksNU/YwtW6tPVYRVSNK
	7luo09UWEwk0oRKNdNMRL1sgDW6VB0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700500044;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lu6qpvpIjbFFS0dtCUNSuWUFNVh7uKaxNmTkI1Ge7w=;
	b=uj+iC2de+lX8cC9ka9llUCYiG4DkI+FHRqiEEE+0mZqtWnsHVD8elKlNPbLKFHnvwmcq+A
	G5IG7SfIlAZKXfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CC86134AD;
	Mon, 20 Nov 2023 17:07:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lSXEGUySW2VoBQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Mon, 20 Nov 2023 17:07:24 +0000
Date: Mon, 20 Nov 2023 18:00:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231120170015.GM11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.986];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Thu, Nov 16, 2023 at 03:49:06PM +1030, Qu Wenruo wrote:
> Currently btrfs extent buffer helpers are doing all the cross-page
> handling, as there is no guarantee that all those eb pages are
> contiguous.
> 
> However on systems with enough memory, there is a very high chance the
> page cache for btree_inode are allocated with physically contiguous
> pages.
> 
> In that case, we can skip all the complex cross-page handling, thus
> speeding up the code.
> 
> This patch adds a new member, extent_buffer::addr, which is only set to
> non-NULL if all the extent buffer pages are physically contiguous.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> 
> This change would increase the code size for all extent buffer helpers,
> and since there one more branch introduced, it may even slow down the
> system if most ebs do not have physically contiguous pages.
> 
> But I still believe this is worthy trying, as my previous attempt to
> use virtually contiguous pages are rejected due to possible slow down in
> vm_map() call.
> 
> I don't have convincing benchmark yet, but so far no obvious performance
> drop observed either.
> ---
>  fs/btrfs/disk-io.c   |  9 +++++++-
>  fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/extent_io.h |  7 ++++++
>  3 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5ac6789ca55f..7fc78171a262 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -80,8 +80,16 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>  	char *kaddr;
>  	int i;
>  
> +	memset(result, 0, BTRFS_CSUM_SIZE);
>  	shash->tfm = fs_info->csum_shash;
>  	crypto_shash_init(shash);
> +
> +	if (buf->addr) {
> +		crypto_shash_digest(shash, buf->addr + offset_in_page(buf->start) + BTRFS_CSUM_SIZE,
> +				    buf->len - BTRFS_CSUM_SIZE, result);
> +		return;
> +	}
> +
>  	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
>  	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>  			    first_page_part - BTRFS_CSUM_SIZE);
> @@ -90,7 +98,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>  		kaddr = page_address(buf->pages[i]);
>  		crypto_shash_update(shash, kaddr, PAGE_SIZE);
>  	}
> -	memset(result, 0, BTRFS_CSUM_SIZE);

This is not related to the contig pages but the result buffer for
checksum should be always cleared before storing the digest.

>  	crypto_shash_final(shash, result);
>  }
>  
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 03cef28d9e37..004b0ba6b1c7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3476,6 +3476,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  	struct address_space *mapping = fs_info->btree_inode->i_mapping;
>  	struct btrfs_subpage *prealloc = NULL;
>  	u64 lockdep_owner = owner_root;
> +	bool page_contig = true;
>  	int uptodate = 1;
>  	int ret;
>  
> @@ -3562,6 +3563,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  
>  		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
>  		eb->pages[i] = p;
> +
> +		/*
> +		 * Check if the current page is physically contiguous with previous eb
> +		 * page.
> +		 */
> +		if (i && eb->pages[i - 1] + 1 != p)
> +			page_contig = false;

This hasn't been fixed from last time, this has almost zero chance to
succeed once the system is up for some time. Page addresses returned
from allocator are random. What I was suggesting is to use alloc_page()
with the given order (16K pages are 2).

This works for all eb sizes we need, the prolematic one could be for 64K
because this is order 4 and PAGE_ALLOC_COSTLY_ORDER is 3, so this would
cost more on the MM side. But who uses 64K node size on x8_64.

> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -77,6 +77,13 @@ struct extent_buffer {
>  	unsigned long len;
>  	unsigned long bflags;
>  	struct btrfs_fs_info *fs_info;
> +
> +	/*
> +	 * The address where the eb can be accessed without any cross-page handling.
> +	 * This can be NULL if not possible.
> +	 */
> +	void *addr;

So this is a remnant of the vm_map, we would not need to store the
address in case all the pages are contiguous, it would be the address of
pages[0]. That it's contiguous could be tracked as a bit in the flags.

> +
>  	spinlock_t refs_lock;
>  	atomic_t refs;
>  	int read_mirror;
> -- 
> 2.42.1
> 

