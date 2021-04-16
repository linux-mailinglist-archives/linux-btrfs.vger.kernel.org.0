Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFCD36230A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245216AbhDPOnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbhDPOml (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 10:42:41 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB49C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:42:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id bs7so13026746qvb.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eZjFl18qB08gf7W04OZ5B948L/XebPphKDKZJXR07C8=;
        b=wK5zRUX4inFi1noLL9SHpNN9dNdQZ+ADsIKUurHVSuWPyvs7xDgNGh8dIXjRQVVW2z
         y2Z4Ew3m9GdfpjpPP+jWmXZzHBozRgsD59Li1QYYZjEcfNjXY3CLCBSEqGKYBmzXMWT8
         KxO8WiGt8+5kiQLZyCc8IgEiaSluDC2+iFiWe8BYFn2iyqokMVsnQRT8YEFG4qW9bH33
         ssu0ngc/+SnqTqoP1VLTdAtTD/CMIIbv0VxAkjDPXmMUTRADutCfkjRYlWipcZkSsWyT
         ay20U+f1sTu4nbzCezoK2S1ydEjJ1MsqA7qws3QjmCqnhc/dkc38smjzZSG3wZNIpiKo
         XtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZjFl18qB08gf7W04OZ5B948L/XebPphKDKZJXR07C8=;
        b=cy3pEVZ3JZtPudAJntSL1o+YaIRoZ/Ot90GNNXwCfqHtEsO1ROA//gRZjnewhBlJqm
         d5rDYR/vx4QHnRsKROShlSlx+0/YG9Nb6ullVRM5Z0StDup5wmYL+Wk5ZyqAJDm5UMSO
         FEIzfyHPykB3rQ1rFO2smnug0PLA7RtdBECqAuqJfmVJwKQxPICOZ78QB48uiSCic2li
         qgUrjiWYIGC+y7cu6Pms1mDsf0iTGfKfTklIZ33hegw/EvTKyCyuNzIi5Orwo9XuWBpF
         BKQabLCxz5QZ06u4f0E8GlwsbpPZHaKF4VfCnD7t8MxzGcdxggA/QIFTOYIxh1PSPIri
         wPxg==
X-Gm-Message-State: AOAM532l7wCOPlOd2QfhSrvfKY3JEfiYyWqzPVUfp5kgXiX2HYE7G2eO
        0Bo/wbruDm+YCVwAqpZQpEzVgjZ6htWiGg==
X-Google-Smtp-Source: ABdhPJw3+THMBXDX4stS6ST9XpIr1Wx5Fsu2vt+YVcyaTYF3xPhaKbLZU66eT2HOhsVHVWjuIXkggg==
X-Received: by 2002:ad4:490f:: with SMTP id bh15mr8836815qvb.55.1618584132556;
        Fri, 16 Apr 2021 07:42:12 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g128sm4319008qke.1.2021.04.16.07.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:42:12 -0700 (PDT)
Subject: Re: [PATCH 11/42] btrfs: refactor btrfs_invalidatepage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-12-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0babca4e-325a-88a7-bbfc-c810a5bedbeb@toxicpanda.com>
Date:   Fri, 16 Apr 2021 10:42:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-12-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> This patch will refactor btrfs_invalidatepage() for the incoming subpage
> support.
> 
> The invovled modifcations are:
> - Use while() loop instead of "goto again;"
> - Use single variable to determine whether to delete extent states
>    Each branch will also have comments why we can or cannot delete the
>    extent states
> - Do qgroup free and extent states deletion per-loop
>    Current code can only work for PAGE_SIZE == sectorsize case.
> 
> This refactor also makes it clear what we do for different sectors:
> - Sectors without ordered extent
>    We're completely safe to remove all extent states for the sector(s)
> 
> - Sectors with ordered extent, but no Private2 bit
>    This means the endio has already been executed, we can't remove all
>    extent states for the sector(s).
> 
> - Sectors with ordere extent, still has Private2 bit
>    This means we need to decrease the ordered extent accounting.
>    And then it comes to two different variants:
>    * We have finished and removed the ordered extent
>      Then it's the same as "sectors without ordered extent"
>    * We didn't finished the ordered extent
>      We can remove some extent states, but not all.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/inode.c | 173 +++++++++++++++++++++++++----------------------
>   1 file changed, 94 insertions(+), 79 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4c894de2e813..93bb7c0482ba 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8320,15 +8320,12 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>   {
>   	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>   	struct extent_io_tree *tree = &inode->io_tree;
> -	struct btrfs_ordered_extent *ordered;
>   	struct extent_state *cached_state = NULL;
>   	u64 page_start = page_offset(page);
>   	u64 page_end = page_start + PAGE_SIZE - 1;
> -	u64 start;
> -	u64 end;
> +	u64 cur;
> +	u32 sectorsize = inode->root->fs_info->sectorsize;
>   	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
> -	bool found_ordered = false;
> -	bool completed_ordered = false;
>   
>   	/*
>   	 * We have page locked so no new ordered extent can be created on
> @@ -8352,96 +8349,114 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>   	if (!inode_evicting)
>   		lock_extent_bits(tree, page_start, page_end, &cached_state);
>   
> -	start = page_start;
> -again:
> -	ordered = btrfs_lookup_ordered_range(inode, start, page_end - start + 1);
> -	if (ordered) {
> -		found_ordered = true;
> -		end = min(page_end,
> -			  ordered->file_offset + ordered->num_bytes - 1);
> +	cur = page_start;
> +	while (cur < page_end) {
> +		struct btrfs_ordered_extent *ordered;
> +		bool delete_states = false;
> +		u64 range_end;
> +
> +		/*
> +		 * Here we can't pass "file_offset = cur" and
> +		 * "len = page_end + 1 - cur", as btrfs_lookup_ordered_range()
> +		 * may not return the first ordered extent after @file_offset.
> +		 *
> +		 * Here we want to iterate through the range in byte order.
> +		 * This is slower but definitely correct.
> +		 *
> +		 * TODO: Make btrfs_lookup_ordered_range() to return the
> +		 * first ordered extent in the range to reduce the number
> +		 * of loops.
> +		 */
> +		ordered = btrfs_lookup_ordered_range(inode, cur, sectorsize);

How does it not find the first ordered extent after file_offset?  Looking at the 
code it just loops through and returns the first thing it finds that overlaps 
our range.  Is there a bug in btrfs_lookup_ordered_range()?

We should add some self tests to make sure these helpers are doing the right 
thing if there is in fact a bug.

> +		if (!ordered) {
> +			range_end = cur + sectorsize - 1;
> +			/*
> +			 * No ordered extent covering this sector, we are safe
> +			 * to delete all extent states in the range.
> +			 */
> +			delete_states = true;
> +			goto next;
> +		}
> +
> +		range_end = min(ordered->file_offset + ordered->num_bytes - 1,
> +				page_end);
> +		if (!PagePrivate2(page)) {
> +			/*
> +			 * If Private2 is cleared, it means endio has already
> +			 * been executed for the range.
> +			 * We can't delete the extent states as
> +			 * btrfs_finish_ordered_io() may still use some of them.
> +			 */
> +			delete_states = false;

delete_states is already false.

> +			goto next;
> +		}
> +		ClearPagePrivate2(page);
> +
>   		/*
>   		 * IO on this page will never be started, so we need to account
>   		 * for any ordered extents now. Don't clear EXTENT_DELALLOC_NEW
>   		 * here, must leave that up for the ordered extent completion.
> +		 *
> +		 * This will also unlock the range for incoming
> +		 * btrfs_finish_ordered_io().
>   		 */
>   		if (!inode_evicting)
> -			clear_extent_bit(tree, start, end,
> +			clear_extent_bit(tree, cur, range_end,
>   					 EXTENT_DELALLOC |
>   					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
>   					 EXTENT_DEFRAG, 1, 0, &cached_state);
> +
> +		spin_lock_irq(&inode->ordered_tree.lock);
> +		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> +		ASSERT(cur - ordered->file_offset < U32_MAX);
> +		ordered->truncated_len = min_t(u32, ordered->truncated_len,
> +					       cur - ordered->file_offset);

I've realized my previous comment about this needing to be u64 was wrong, I'm 
starting to wake up now.  However I still don't see the value in saving the 
space, as we can just leave everything u64 and the math all works out cleanly.

> +		spin_unlock_irq(&inode->ordered_tree.lock);
> +
> +		ASSERT(range_end + 1 - cur < U32_MAX);

And we don't have to pollute the code with all of these checks.

> +		if (btrfs_dec_test_ordered_pending(inode, &ordered,
> +					cur, range_end + 1 - cur, 1)) {
> +			btrfs_finish_ordered_io(ordered);
> +			/*
> +			 * The ordered extent has finished, now we're again
> +			 * safe to delete all extent states of the range.
> +			 */
> +			delete_states = true;
> +		} else {
> +			/*
> +			 * btrfs_finish_ordered_io() will get executed by endio of
> +			 * other pages, thus we can't delete extent states any more
> +			 */
> +			delete_states = false;

This is already false.  Thanks,

Josef
