Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B732C2FD3CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 16:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389307AbhATPKC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 10:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733276AbhATPGj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 10:06:39 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB4C061575
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:05:59 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d85so1424241qkg.5
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=quHplr4aOFK4JNXPqGcqTvaUrfo6rjYbAMEcjDSvsZU=;
        b=g678J3tTUBUh2uNpfQYibkJ8mPvpgfly6WQ6LtX8WPb0JTmGfMKMM4U47HITpgPqjs
         YM+PkuZYP6HARqD4p6HI8fP/GXaM6+m/q4M6zPlSbOnxD2Pn/RoE2MAjtFuUgdjoeWzE
         Ez/7RIUGuw3IUOJD2EKFlJBy9A0sp3JT5QwkPa2V3pA269HIKsPO15wzh6/5Z86CXuas
         DJYxVFmuC1lOP6gDxXdUuJhJZpsecp4gRusTC07kIkSrsfiSFdFHkCF9eWV/W4vORH3d
         qPwQjPyH/5iNvyFTfmngOsd7XlOujhTMhNKVwKQiPEVwANxEVNH2QNZNwjSAqMXzAxGT
         KAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=quHplr4aOFK4JNXPqGcqTvaUrfo6rjYbAMEcjDSvsZU=;
        b=ggpcuxiGYwwDxZDKdsIgmDPlzk/4dw6VZSVi3j9q0lzSXHrknqmc0Si5+Kyj37PeEq
         dVN+dGSNYdayRLgJzC2MojpGyEQy8gSDBUCCnAPYWmEPjE5gEDTcyT9xxLGaWudJBxcW
         KLohTPEsZORBCSN6fi1j5wRJ4JDtTTmQmswvOmgNb9aojvPLdc9ywfpmuwoNzgXwsT/7
         IoiXjwUWYSdOVyyacRQSQBlvBc+5mirOKsxQMwWtHUr7udSNY2sniaJQQZ4HXQuZm12R
         QIPQ0YdVaBlj/fqed1CDIp6FmsAmRs7ikh/TiMyKeRk9kzy14xKeyTgIwxK8sL/7S8A2
         dnrA==
X-Gm-Message-State: AOAM5304LUqokeznNUEmTz24mytyVr6GKz7UT98vXpCuh+EByphPeI/6
        y/rYOwTO/szO6E6F9083MOqeG94koIi8zlimHak=
X-Google-Smtp-Source: ABdhPJwZRswTAIhpmUumlcXJgsjlgfNWh8Y8nScXr5xWVQuRLctwJmO/Wq4/m8dihRejBSpFUcE0TQ==
X-Received: by 2002:a37:9583:: with SMTP id x125mr9723460qkd.75.1611155157967;
        Wed, 20 Jan 2021 07:05:57 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c17sm1509020qkb.13.2021.01.20.07.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:05:57 -0800 (PST)
Subject: Re: [PATCH v4 12/18] btrfs: implement try_release_extent_buffer() for
 subpage metadata support
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-13-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4732f7cb-8d1c-6af2-0ec4-9b9cf5a47c3e@toxicpanda.com>
Date:   Wed, 20 Jan 2021 10:05:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-13-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> Unlike the original try_release_extent_buffer(),
> try_release_subpage_extent_buffer() will iterate through all the ebs in
> the page, and try to release each eb.
> 
> And only if the page and no private attached, which implies we have
> released all ebs of the page, then we can release the full page.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 106 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 104 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 74a37eec921f..9414219fa28b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6335,13 +6335,115 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
>   	}
>   }
>   
> +static struct extent_buffer *get_next_extent_buffer(
> +		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
> +{
> +	struct extent_buffer *gang[BTRFS_SUBPAGE_BITMAP_SIZE];
> +	struct extent_buffer *found = NULL;
> +	u64 page_start = page_offset(page);
> +	int ret;
> +	int i;
> +
> +	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
> +	ASSERT(PAGE_SIZE / fs_info->nodesize <= BTRFS_SUBPAGE_BITMAP_SIZE);
> +	lockdep_assert_held(&fs_info->buffer_lock);
> +
> +	ret = radix_tree_gang_lookup(&fs_info->buffer_radix, (void **)gang,
> +			bytenr >> fs_info->sectorsize_bits,
> +			PAGE_SIZE / fs_info->nodesize);
> +	for (i = 0; i < ret; i++) {
> +		/* Already beyond page end */
> +		if (gang[i]->start >= page_start + PAGE_SIZE)
> +			break;
> +		/* Found one */
> +		if (gang[i]->start >= bytenr) {
> +			found = gang[i];
> +			break;
> +		}
> +	}
> +	return found;
> +}
> +
> +static int try_release_subpage_extent_buffer(struct page *page)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> +	u64 cur = page_offset(page);
> +	const u64 end = page_offset(page) + PAGE_SIZE;
> +	int ret;
> +
> +	while (cur < end) {
> +		struct extent_buffer *eb = NULL;
> +
> +		/*
> +		 * Unlike try_release_extent_buffer() which uses page->private
> +		 * to grab buffer, for subpage case we rely on radix tree, thus
> +		 * we need to ensure radix tree consistency.
> +		 *
> +		 * We also want an atomic snapshot of the radix tree, thus go
> +		 * spinlock other than RCU.
> +		 */
> +		spin_lock(&fs_info->buffer_lock);
> +		eb = get_next_extent_buffer(fs_info, page, cur);
> +		if (!eb) {
> +			/* No more eb in the page range after or at @cur */
> +			spin_unlock(&fs_info->buffer_lock);
> +			break;
> +		}
> +		cur = eb->start + eb->len;
> +
> +		/*
> +		 * The same as try_release_extent_buffer(), to ensure the eb
> +		 * won't disappear out from under us.
> +		 */
> +		spin_lock(&eb->refs_lock);
> +		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> +			spin_unlock(&eb->refs_lock);
> +			spin_unlock(&fs_info->buffer_lock);

Why continue at this point?  We know we can't drop this thing, break here.

<snip>

> +}
> +
>   int try_release_extent_buffer(struct page *page)
>   {
>   	struct extent_buffer *eb;
>   
> +	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +		return try_release_subpage_extent_buffer(page);

You're using sectorsize again here.  I realize the problem is sectorsize != 
PAGE_SIZE, but sectorsize != nodesize all the time, so please change all of the 
patches to check the actual relevant size for the data/metadata type.  Thanks,

Josef
