Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD703612E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 21:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhDOT17 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbhDOT15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 15:27:57 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84D0C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 12:27:33 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c123so21596659qke.1
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VhCPPCgGGfDKwftwmmleb2233jZzwtpvL1rcE4rR6TM=;
        b=kgoZBrfSZEjIAwYE5hfvl8SMj+lcIvfx3dsAlJrr/np0F09KsXwx3quUQitXP0oAk7
         m8bF0lgGQ2pX/eo/ID2T+MD2QQUlBkQ7igI0dfJZQ24/+2rZLeHO9y8z6yD01pVC9k0U
         THnKmxfNfIsL0pdrYfWnDBhvbBTpcc7CYDz1QcsuUVsi5m2o/VS4rmNTLJJaUFkaQhUO
         4eCaITybwuweBSU4RMb/xEwj7B6tH++qYR5/ac6tOwxO5RXup+HD8Gbei6LTqt4ehHfB
         l7PtekDRANQAqkgxLAZYvtiUT1lXm0wFLRvRYxOB3CjYAURWnC6H+CXpEOcTTZ+Li7fd
         lFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VhCPPCgGGfDKwftwmmleb2233jZzwtpvL1rcE4rR6TM=;
        b=PRgbhwCgJpO/0ZojqpK1S538H6i56I9XPQ+C71xsZLSUmDwuOJTqj2BJHksp7NKIED
         +Z6u1SnSAIB6xlkPByE7m58h6hbYdmdnQVeFTCS4R/g94Ujctb9tJWc3kHUtdYfeo4s0
         ULsKv5WlVG9ONs1+xlDYR6Sai8rYALvNog/imVzyBLwY98fbS7/9r0RCaYdOVxUC5261
         TGKszHqx3OiPOcnPhyahMOQwBV6Jec7dRaDFHdR+KU16Peyx8+1DhWgv2zKd3comGJgh
         1zfU5LRtaNZhxBrFSl/xLA6/zTT7N1nbsNYwq4htVRcnEOJV5xSumcTSID1TxWQS9fjg
         tvfA==
X-Gm-Message-State: AOAM531UpIW8tX4eZnwep1rfQUyjKJmYd5fUc+L971CAzyjALsIohZfl
        CMk930pTK+G/pm7LabKdx/0e/7qN52cDew==
X-Google-Smtp-Source: ABdhPJyez70hXlFL54B2qXx0xXNXRiUF6WU5Qr3Qbsn7lcywaIarK3rP2fuXGL4WIf/zOPbiSqTiKw==
X-Received: by 2002:a37:64c3:: with SMTP id y186mr5069964qkb.244.1618514852681;
        Thu, 15 Apr 2021 12:27:32 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1288? ([2620:10d:c091:480::1:2677])
        by smtp.gmail.com with ESMTPSA id a26sm2605683qtg.60.2021.04.15.12.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 12:27:32 -0700 (PDT)
Subject: Re: [PATCH 04/42] btrfs: introduce submit_eb_subpage() to submit a
 subpage metadata page
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <475c3f1a-ffec-6a7a-1cb0-c7217c87367d@toxicpanda.com>
Date:   Thu, 15 Apr 2021 15:27:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> The new function, submit_eb_subpage(), will submit all the dirty extent
> buffers in the page.
> 
> The major difference between submit_eb_page() and submit_eb_subpage()
> is:
> - How to grab extent buffer
>    Now we use find_extent_buffer_nospinlock() other than using
>    page::private.
> 
> All other different handling is already done in functions like
> lock_extent_buffer_for_io() and write_one_eb().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 95 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c068c2fcba09..7d1fca9b87f0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4323,6 +4323,98 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   	return ret;
>   }
>   
> +/*
> + * Submit one subpage btree page.
> + *
> + * The main difference between submit_eb_page() is:
> + * - Page locking
> + *   For subpage, we don't rely on page locking at all.
> + *
> + * - Flush write bio
> + *   We only flush bio if we may be unable to fit current extent buffers into
> + *   current bio.
> + *
> + * Return >=0 for the number of submitted extent buffers.
> + * Return <0 for fatal error.
> + */
> +static int submit_eb_subpage(struct page *page,
> +			     struct writeback_control *wbc,
> +			     struct extent_page_data *epd)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> +	int submitted = 0;
> +	u64 page_start = page_offset(page);
> +	int bit_start = 0;
> +	int nbits = BTRFS_SUBPAGE_BITMAP_SIZE;
> +	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
> +	int ret;
> +
> +	/* Lock and write each dirty extent buffers in the range */
> +	while (bit_start < nbits) {
> +		struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +		struct extent_buffer *eb;
> +		unsigned long flags;
> +		u64 start;
> +
> +		/*
> +		 * Take private lock to ensure the subpage won't be detached
> +		 * halfway.
> +		 */
> +		spin_lock(&page->mapping->private_lock);
> +		if (!PagePrivate(page)) {
> +			spin_unlock(&page->mapping->private_lock);
> +			break;
> +		}
> +		spin_lock_irqsave(&subpage->lock, flags);

writepages doesn't get called with irq context, so you can just do 
spin_lock_irq()/spin_unlock_irq().

> +		if (!((1 << bit_start) & subpage->dirty_bitmap)) {

Can we make this a helper so it's more clear what's going on here?  Thanks,

Josef
