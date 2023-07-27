Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442477655DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjG0OZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjG0OZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 10:25:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1682D47
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 07:25:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0486321AE1;
        Thu, 27 Jul 2023 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690467903;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7zmgT/MOqiky/9EnQEAPmyaOMDZYQ9th5PxMSugT7Y=;
        b=FeewHyLwf44mL8MRScfqMaNTcBHn5hNl9KwdpXCX6TvtLrsd4Ho4UShnEZgfNUbWI8Ntux
        oMN6Sf+FWYOScdvhxbOVEDjwwu7xGlrCWEkSu3ZdjHGTlXDGlZBXUgm0moddBOL+cVVV87
        naDiQCXuWThHL+TjqgLeDSs9VN9D/c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690467903;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7zmgT/MOqiky/9EnQEAPmyaOMDZYQ9th5PxMSugT7Y=;
        b=7Nj0MFSgcvOekerseq7UfdglPigqaesXVL4QKn/4qnuwsIh4C+FocgXPln/f1i1NS2TkFx
        CsY9DlGdYisDiWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7F66138E5;
        Thu, 27 Jul 2023 14:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PtD2Lz5+wmQqDQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Jul 2023 14:25:02 +0000
Date:   Thu, 27 Jul 2023 16:18:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] btrfs: map uncontinuous extent buffer pages into
 virtual address space
Message-ID: <20230727141840.GC17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690249862.git.wqu@suse.com>
 <46e2952cfe5b76733f5c2b22f11832f062be6200.1690249862.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e2952cfe5b76733f5c2b22f11832f062be6200.1690249862.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 25, 2023 at 10:57:21AM +0800, Qu Wenruo wrote:
> Currently btrfs implements its extent buffer read-write using various
> helpers doing cross-page handling for the pages array.
> 
> However other filesystems like XFS is mapping the pages into kernel
> virtual address space, greatly simplify the access.
> 
> This patch would learn from XFS and map the pages into virtual address
> space, if and only if the pages are not physically continuous.
> (Note, a single page counts as physically continuous.)
> 
> For now we only do the map, but not yet really utilize the mapped
> address.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/extent_io.h |  7 +++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4144c649718e..f40d48f641c0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagevec.h>
>  #include <linux/prefetch.h>
>  #include <linux/fsverity.h>
> +#include <linux/vmalloc.h>
>  #include "misc.h"
>  #include "extent_io.h"
>  #include "extent-io-tree.h"
> @@ -3206,6 +3207,8 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
>  	ASSERT(!extent_buffer_under_io(eb));
>  
>  	num_pages = num_extent_pages(eb);
> +	if (eb->vaddr)
> +		vm_unmap_ram(eb->vaddr, num_pages);
>  	for (i = 0; i < num_pages; i++) {
>  		struct page *page = eb->pages[i];
>  
> @@ -3255,6 +3258,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>  {
>  	int i;
>  	struct extent_buffer *new;
> +	bool pages_contig = true;
>  	int num_pages = num_extent_pages(src);
>  	int ret;
>  
> @@ -3279,6 +3283,9 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>  		int ret;
>  		struct page *p = new->pages[i];
>  
> +		if (i && p != new->pages[i - 1] + 1)
> +			pages_contig = false;
> +
>  		ret = attach_extent_buffer_page(new, p, NULL);
>  		if (ret < 0) {
>  			btrfs_release_extent_buffer(new);
> @@ -3286,6 +3293,23 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>  		}
>  		WARN_ON(PageDirty(p));
>  	}
> +	if (!pages_contig) {
> +		unsigned int nofs_flag;
> +		int retried = 0;
> +
> +		nofs_flag = memalloc_nofs_save();
> +		do {
> +			new->vaddr = vm_map_ram(new->pages, num_pages, -1);
> +			if (new->vaddr)
> +				break;
> +			vm_unmap_aliases();
> +		} while ((retried++) <= 1);
> +		memalloc_nofs_restore(nofs_flag);
> +		if (!new->vaddr) {
> +			btrfs_release_extent_buffer(new);
> +			return NULL;
> +		}
> +	}
>  	copy_extent_buffer_full(new, src);
>  	set_extent_buffer_uptodate(new);
>  
> @@ -3296,6 +3320,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>  						  u64 start, unsigned long len)
>  {
>  	struct extent_buffer *eb;
> +	bool pages_contig = true;
>  	int num_pages;
>  	int i;
>  	int ret;
> @@ -3312,11 +3337,29 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>  	for (i = 0; i < num_pages; i++) {
>  		struct page *p = eb->pages[i];
>  
> +		if (i && p != eb->pages[i - 1] + 1)
> +			pages_contig = false;

Chances that allocated pages in eb->pages will be contiguous decrease
over time basically to zero, because even one page out of order will
ruin it. This means we can assume that virtual mapping will have to be
used almost every time.

The virtual mapping can also fail and we have no fallback and there are
two more places when allocating extent buffer can fail.

There's alloc_pages(gfp, order) that can try to allocate contiguous
pages of a given order, and we have nodesize always matching power of
two so we could use it. Although this also forces alignment to the same
order, which we don't need, and adds to the failure modes.
