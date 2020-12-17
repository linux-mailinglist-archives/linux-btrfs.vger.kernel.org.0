Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0C2DD480
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 16:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgLQPog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 10:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLQPof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 10:44:35 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7AC061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 07:43:55 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 143so26717096qke.10
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/Ol4mgPGtj2x37qXx/FkRKkLWjXloTBdFB/PyG2XJHw=;
        b=z491L3JcHHvj/cWT1+3vxW2Wd/m3VqXGfQte9EUDWK2XMxIU+KR2CKwhSnI3Hm581J
         Q7om9NNQYVzokbFowgaTpzrcGY847xnyndc/JJxOqY7dNedgvyxK6cSR1uc4VmHx3Wor
         1sL2tFn9RPu2vUB5XKLMug44XhYj6yWp70Mc1H7x0AuottPlZU5snX83ehUhLYup9jZS
         ba5UsDtVEQ/Z54R6oII2calhYQyJpBlB5ST+YVFFrINHKaDyqCpc5Aho/UYwSCsVQqmn
         Ql71+GgsEQFgZkUHubhvFlKWPclgpsx0QbI/PdpnD7isSNrXiPP9TWDRYXXQYltALmjZ
         q7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ol4mgPGtj2x37qXx/FkRKkLWjXloTBdFB/PyG2XJHw=;
        b=AZXUaBWjDTfCgNDVhF5guam24Hb7kvEZy83jhWIiI+VaXX+IuoL0y9JH8x1o/wsStf
         18SgWFvMOp2XDraK3RejC0fhNT2jM4jWSv64NCi4ow4s3+YfX/FLRqPUs7sBfNN+V2cW
         C4PwHfoSCfrJ172bMQuEfqaioexLRpxfajjk2ccHLyRqBkYQPuav2SSboiGMTLJj0qLu
         4AaCRZCg2u31eDGww9faBmjAaJt6/ciRlFimADqDtkWTTHwTa0fr3lGhW+D3LbdMOuub
         +am15v/g36kT8Zb7yLUF2ftgyhXjiUEWd02SBaTZnqt+WNVfVmTFgoAcBAiCFbOT0FyX
         /fHw==
X-Gm-Message-State: AOAM530riUWs2h/PjjMc68JAS6J1PGJ38lBoakRDUSpkw1/bzJdLgOkO
        9aNJZdBO0Vaqk862lacrtItcYAyF8hUlYcYd
X-Google-Smtp-Source: ABdhPJx7of1pJCTyaA1gwcUgqgtJfBamT0HwbqRWGNJ1gRNs/RPhL9UfNpyABWiTYsvQ5EMNuAHFSw==
X-Received: by 2002:a05:620a:1526:: with SMTP id n6mr50505241qkk.334.1608219834210;
        Thu, 17 Dec 2020 07:43:54 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm3239598qty.30.2020.12.17.07.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:43:53 -0800 (PST)
Subject: Re: [PATCH v2 02/18] btrfs: extent_io: refactor
 __extent_writepage_io() to improve readability
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fda4ba81-ca43-15f8-c403-533c28320232@toxicpanda.com>
Date:   Thu, 17 Dec 2020 10:43:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/20 1:38 AM, Qu Wenruo wrote:
> The refactor involves the following modifications:
> - iosize alignment
>    In fact we don't really need to manually do alignment at all.
>    All extent maps should already be aligned, thus basic ASSERT() check
>    would be enough.
> 
> - redundant variables
>    We have extra variable like blocksize/pg_offset/end.
>    They are all unnecessary.
> 
>    @blocksize can be replaced by sectorsize size directly, and it's only
>    used to verify the em start/size is aligned.
> 
>    @pg_offset can be easily calculated using @cur and page_offset(page).
> 
>    @end is just assigned to @page_end and never modified, use @page_end
>    to replace it.
> 
> - remove some BUG_ON()s
>    The BUG_ON()s are for extent map, which we have tree-checker to check
>    on-disk extent data item and runtime check.
>    ASSERT() should be enough.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 37 +++++++++++++++++--------------------
>   1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 2650e8720394..612fe60b367e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3515,17 +3515,14 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   				 unsigned long nr_written,
>   				 int *nr_ret)
>   {
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct extent_io_tree *tree = &inode->io_tree;
>   	u64 start = page_offset(page);
>   	u64 page_end = start + PAGE_SIZE - 1;
> -	u64 end;
>   	u64 cur = start;
>   	u64 extent_offset;
>   	u64 block_start;
> -	u64 iosize;
>   	struct extent_map *em;
> -	size_t pg_offset = 0;
> -	size_t blocksize;
>   	int ret = 0;
>   	int nr = 0;
>   	const unsigned int write_flags = wbc_to_write_flags(wbc);
> @@ -3546,19 +3543,17 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   	 */
>   	update_nr_written(wbc, nr_written + 1);
>   
> -	end = page_end;
> -	blocksize = inode->vfs_inode.i_sb->s_blocksize;
> -
> -	while (cur <= end) {
> +	while (cur <= page_end) {
>   		u64 disk_bytenr;
>   		u64 em_end;
> +		u32 iosize;
>   
>   		if (cur >= i_size) {
>   			btrfs_writepage_endio_finish_ordered(page, cur,
>   							     page_end, 1);
>   			break;
>   		}
> -		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
> +		em = btrfs_get_extent(inode, NULL, 0, cur, page_end - cur + 1);
>   		if (IS_ERR_OR_NULL(em)) {
>   			SetPageError(page);
>   			ret = PTR_ERR_OR_ZERO(em);
> @@ -3567,16 +3562,20 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   
>   		extent_offset = cur - em->start;
>   		em_end = extent_map_end(em);
> -		BUG_ON(em_end <= cur);
> -		BUG_ON(end < cur);
> -		iosize = min(em_end - cur, end - cur + 1);
> -		iosize = ALIGN(iosize, blocksize);
> -		disk_bytenr = em->block_start + extent_offset;
> +		ASSERT(cur <= em_end);
> +		ASSERT(cur < page_end);
> +		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
> +		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
>   		block_start = em->block_start;
>   		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
> +		disk_bytenr = em->block_start + extent_offset;
> +
> +		/* Note that em_end from extent_map_end() is exclusive */
> +		iosize = min(em_end, page_end + 1) - cur;
>   		free_extent_map(em);
>   		em = NULL;
>   
> +

Random extra whitespace.  Once you fix you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
