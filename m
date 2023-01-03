Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86B65BA8E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 06:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjACFvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 00:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACFvI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 00:51:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B8CAE73;
        Mon,  2 Jan 2023 21:51:03 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1pIcrG395u-00Xg4M; Tue, 03
 Jan 2023 06:47:49 +0100
Message-ID: <87d14908-dc9d-7ce4-c594-b28a9991efbb@gmx.com>
Date:   Tue, 3 Jan 2023 13:47:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     zys.zljxml@gmail.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
References: <20230103051137.4085572-1-zys.zljxml@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3] btrfs: use PAGE_{ALIGN, ALIGNED, ALIGN_DOWN} macro
In-Reply-To: <20230103051137.4085572-1-zys.zljxml@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pekQdG8Lv++qlQ443YYcSeM2YOcvnWrMIraexNtIzqzscu8wbPr
 J3t2JfmzD28KJ4nTvCanPsH90IlhRAJoEDzxIdcmBbZG+NVM6GmfnQyfupv+csTofZinomz
 VAn8FFiRq+i8hNiFzlirr/D0rE3vT1eVD1jtmZb0rrZGgpyrorui4K5B0cQ69YhLp0D3xiH
 WvEivFlThagrHQFwLY51g==
UI-OutboundReport: notjunk:1;M01:P0:RptfQLUvik4=;AsmpQKXmvBTk9kMZJovUzZin+ej
 X58xFtQ8ng3M3c7KhAgAnTk0IlWkzgo74Q1OTF9FG4wq9OMNc5HJlaOM0hDLRs7G96xnEGFlA
 SPhUwdDpTuCL4L659uTr04FCbGMigtpeVtDiFg7YDoUJLksXgZNB3pJ5+E1fLkxrssJmfnpS5
 TznCp6HOFV6tx5UuaVpoY0tWZBDPF5cnfV46V9548GylHhJoCtxW1mk20zxTp3IzPVDry8HNY
 Gbq+CgtOhSxU17XlNtpwyy7vZg8ResNCO7Mzni+CHiXmEJwNxnASGIFMerIYiQMOi3HvxtsCu
 NBm32ZZWt4R42OLqZ5rHHoxXmrcwtEStyTFFeQx5qy6XtlEVo8w2cS2jFLQdKzg0iWBIiVkU0
 HQzP2SN6ehleFJdgVAN8tsrzd3UZMl0LcG950EeAlaUE4LUO0jOdPHAy5AcIElGj93Ku8yR86
 DEcya82i5lCFHm+9O0Utr3RWDMzIV2BC+SlJGw5Juv9k59zR7pFtFgYyG/E4BVc6WrwQlj5HV
 CzRFwhOF/X1oqVmDPH3M3XAQvXpfDqQCHjHU15hrCfnZ4YxF1z+G7qJZU1ySmmdhdNIcV5I95
 s+xCc2ZEqoNW/+5bHFwWCVNRrrH3eFDmlkyaT1eLfXt3ch79ZA4lmDZRQN9xY/pr4UmLn6yDp
 2LTPgjWHIVGJ6d5Rlf0PD50VI9yDOqo5aQaclrs7Uo1FC0rDUJQFA/7VYGNniT50SVe40Dkcc
 F8jJeyKLj9vdfRvGh6uvuoO4YiKROCaaYhBapwV1cOBcEBj9sKjsajQRmO5njPlT7NrDFm37p
 hzX474XjexL4bmMhnptvqipTnQnPHSRw2Q6VCQNxD9IwBIle/j1hvAvyPHg7uYwjKoT9DcShk
 ylLnJwk+NlG9uEbT4NTzByhMYo9/86g1CZ1ZEPzFGYiYKjTptJAJBj+9z6s2FacTMlQZy6/G9
 eSTDEcl7K8xoCfXyXy4VL/sTIEU=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/3 13:11, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> The header file linux/mm.h provides PAGE_ALIGN, PAGE_ALIGNED,
> PAGE_ALIGN_DOWN macros. Use these macros to make code more
> concise.

Is there anything benefit from the change?

In fact, PAGE_ALIGN()/PAGE_ALIGNED() is just using the same 
ALIGN()/IS_ALIGNED() macro.

Thus I don't think your change is of any usefulness, not to mention it's 
going to introduce confusion and extra effort.

I'm completely fine with regular ALIGN()/IS_ALIGNED() usage with PAGE_SIZE.

Thanks,
Qu

> 
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> ---
>   fs/btrfs/compression.c | 2 +-
>   fs/btrfs/defrag.c      | 2 +-
>   fs/btrfs/inode.c       | 5 ++---
>   fs/btrfs/lzo.c         | 2 +-
>   fs/btrfs/relocation.c  | 2 +-
>   fs/btrfs/send.c        | 4 ++--
>   6 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 5122ca79f7ea..4a5aeb8dd479 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1609,7 +1609,7 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
>   	index_end = end >> PAGE_SHIFT;
>   
>   	/* Don't miss unaligned end */
> -	if (!IS_ALIGNED(end, PAGE_SIZE))
> +	if (!PAGE_ALIGNED(end))
>   		index_end++;
>   
>   	curr_sample_pos = 0;
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 0a3c261b69c9..130de66839c1 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -997,7 +997,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>   }
>   
>   #define CLUSTER_SIZE	(SZ_256K)
> -static_assert(IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
> +static_assert(PAGE_ALIGNED(CLUSTER_SIZE));
>   
>   /*
>    * Defrag one contiguous target range.
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8bcad9940154..ff3b1ab6a696 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10993,9 +10993,8 @@ static int btrfs_add_swap_extent(struct swap_info_struct *sis,
>   		return 0;
>   
>   	max_pages = sis->max - bsi->nr_pages;
> -	first_ppage = ALIGN(bsi->block_start, PAGE_SIZE) >> PAGE_SHIFT;
> -	next_ppage = ALIGN_DOWN(bsi->block_start + bsi->block_len,
> -				PAGE_SIZE) >> PAGE_SHIFT;
> +	first_ppage = PAGE_ALIGN(bsi->block_start) >> PAGE_SHIFT;
> +	next_ppage = PAGE_ALIGN_DOWN(bsi->block_start + bsi->block_len) >> PAGE_SHIFT;
>   
>   	if (first_ppage >= next_ppage)
>   		return 0;
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index d5e78cbc8fbc..71f6d8302d50 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -280,7 +280,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
>   		}
>   
>   		/* Check if we have reached page boundary */
> -		if (IS_ALIGNED(cur_in, PAGE_SIZE)) {
> +		if (PAGE_ALIGNED(cur_in)) {
>   			put_page(page_in);
>   			page_in = NULL;
>   		}
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 31ec4a7658ce..ef13a9d4e370 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2825,7 +2825,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
>   	 *
>   	 * Here we have to manually invalidate the range (i_size, PAGE_END + 1).
>   	 */
> -	if (!IS_ALIGNED(i_size, PAGE_SIZE)) {
> +	if (!PAGE_ALIGNED(i_size)) {
>   		struct address_space *mapping = inode->vfs_inode.i_mapping;
>   		struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   		const u32 sectorsize = fs_info->sectorsize;
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index e65e6b6600a7..b4cbd74fefce 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5635,7 +5635,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
>   	 * boundary in the send buffer. This means that there may be a gap
>   	 * between the beginning of the command and the file data.
>   	 */
> -	data_offset = ALIGN(sctx->send_size, PAGE_SIZE);
> +	data_offset = PAGE_ALIGN(sctx->send_size);
>   	if (data_offset > sctx->send_max_size ||
>   	    sctx->send_max_size - data_offset < disk_num_bytes) {
>   		ret = -EOVERFLOW;
> @@ -5759,7 +5759,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
>   		sent += size;
>   	}
>   
> -	if (sctx->clean_page_cache && IS_ALIGNED(end, PAGE_SIZE)) {
> +	if (sctx->clean_page_cache && PAGE_ALIGNED(end)) {
>   		/*
>   		 * Always operate only on ranges that are a multiple of the page
>   		 * size. This is not only to prevent zeroing parts of a page in
