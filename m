Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6248C606CA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 02:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJUAtq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 20:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJUAtm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 20:49:42 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1722F3BA
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 17:49:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h185so1091809pgc.10
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 17:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fydeos.io; s=fydeos;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8l9nVM/3yLbm7pUKjb33ZED2HrGdHnmOyh3Wid4zIM4=;
        b=K8SmNhpJOqB1sMJyxwc5kXxmFbfB1m03I6kLe8K0eW0KeQjxIBsjT71F7I0SuHhZyj
         keLGAzyxEsDZKkdeZ89gOOAruNEiBWSUyau1BrB8ufLJQYLGto2ItKueWvl8J3Xu9oqI
         n9yRwASa2SECJp6uexc9cVzYGTfpP5NML4/6X0HyWfbfj5IsGF5e2sasCVnOwNy6sVwP
         b+aYgZMEuTZKWnzL9IWoRLsV5vTikSkNJrQwF9rMsS/5d8NV6wWOsSRNMvv6NabbxKS1
         x2Qk0Io9/ducxkvpqVhULIgdaErEwmSKV47BCnf+uIr0yBWY3PZjIFzQlpUc8aP9H1bZ
         0rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8l9nVM/3yLbm7pUKjb33ZED2HrGdHnmOyh3Wid4zIM4=;
        b=NC02YePbBwX6cF8mhBMFfTZYSw6L5rVGeWF5hxXFeAEKCxk3uandpsXb9i7r7j+jS7
         ORzezaP6TkNjNrJUaDo9HTkdgF9fnnbDAjuvmzuHwZqHapL7SNFFDlHGn0rAw3e4mbs+
         NzPfVq9NodNZEQp/bD7hFHyWHfnd9FtsLHOReN30t5eXMzjAp+PobaLz51KWF5th1TpJ
         nDzUu0/eKOC62mHReGmaNq/noWC0QmlHQ1Sgn/HQ6FWhDs0B0Ho5PQobsPd1zTWsjgY1
         hcuPmY2/RxCSIlWHVLGGOgn0MT/YSU7/xVEu4o4TVJy5IjJ+28ZozUv8q+FDRGM/cgbv
         nSPQ==
X-Gm-Message-State: ACrzQf375EPux4zoku9wB9ko3SN0jdsGR6yIZJJUZSrKTigaGQaQJDNn
        BN5T9btn4IlN5IU4FIkiuyURlg==
X-Google-Smtp-Source: AMsMyM6nZADKl8bRRnKQZHqRbfl6GAa9tyx0JdjSe+Du8bbgM/RwsCTFin/hy2eFg8NfYUaudEgHWQ==
X-Received: by 2002:a05:6a00:804:b0:563:264a:f5e5 with SMTP id m4-20020a056a00080400b00563264af5e5mr16714234pfk.62.1666313380371;
        Thu, 20 Oct 2022 17:49:40 -0700 (PDT)
Received: from [192.168.2.144] ([45.62.167.228])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b00176b63535adsm13248960plm.260.2022.10.20.17.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 17:49:39 -0700 (PDT)
Message-ID: <41deec52-57ea-81f5-7b8a-633047a1f214@fydeos.io>
Date:   Fri, 21 Oct 2022 08:47:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] btrfs: btrfs: don't trust sub_stripes from disk
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>,
        Viktor Kuzmin <kvaster@gmail.com>
References: <90e84962486d7ab5a8bca92e329fe3ee6864680f.1666312963.git.wqu@suse.com>
Content-Language: en-US
From:   Su Yue <glass@fydeos.io>
In-Reply-To: <90e84962486d7ab5a8bca92e329fe3ee6864680f.1666312963.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/21 08:44, Qu Wenruo wrote:
> [BUG]
> There are two reports (the earliest one from LKP, a more recent one from
> kernel bugzilla) that we can have some chunks with 0 as sub_stripes.
> 
> This will cause divide-by-zero errors at btrfs_rmap_block, which is
> introduced by a recent kernel patch ac0677348f3c ("btrfs: merge
> calculations for simple striped profiles in btrfs_rmap_block"):
> 
> 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
> 				 BTRFS_BLOCK_GROUP_RAID10)) {
> 			stripe_nr = stripe_nr * map->num_stripes + i;
> 			stripe_nr = div_u64(stripe_nr, map->sub_stripes); <<<
> 		}
> 
> [CAUSE]
>  From the more recent report, it has been proven that we have some chunks
> with 0 as sub_stripes, mostly caused by older mkfs.
> 
> It turns out that the mkfs.btrfs fix is only introduced in 6718ab4d33aa
> ("btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk")
> which is included in v5.4 btrfs-progs release.
> 
> So there would be quite some old fses with such 0 sub_stripes.
> 
> [FIX]
> Just don't trust the sub_stripes values from disk.
> 
> We have a trusted btrfs_raid_array[] to fetch the correct sub_stripes
> numbers for each profile.
> 
> By this, we can keep the compatibility with older fses while still avoid
> divide-by-zero bugs.
> 
> Fixes: ac0677348f3c ("btrfs: merge calculations for simple striped profiles in btrfs_rmap_block")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Viktor Kuzmin <kvaster@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216559
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

LGTM,
Reviewed-by: Su Yue <glass@fydeos.io>
>   fs/btrfs/volumes.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 94ba46d57920..39588cb9a7b6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7142,6 +7142,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	u64 devid;
>   	u64 type;
>   	u8 uuid[BTRFS_UUID_SIZE];
> +	int index;
>   	int num_stripes;
>   	int ret;
>   	int i;
> @@ -7149,6 +7150,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	logical = key->offset;
>   	length = btrfs_chunk_length(leaf, chunk);
>   	type = btrfs_chunk_type(leaf, chunk);
> +	index = btrfs_bg_flags_to_raid_index(type);
>   	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
>   
>   #if BITS_PER_LONG == 32
> @@ -7202,7 +7204,14 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	map->io_align = btrfs_chunk_io_align(leaf, chunk);
>   	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
>   	map->type = type;
> -	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
> +	/*
> +	 * Don't trust the sub_stripes value, as for profiles other
> +	 * than RAID10, they may have 0 as sub_stripes for older mkfs.
> +	 * In that case, it can cause divide-by-zero errors later.
> +	 * Since currently sub_stripes is fixed for each profile, let's
> +	 * use the trusted value instead.
> +	 */
> +	map->sub_stripes = btrfs_raid_array[index].sub_stripes;
>   	map->verified_stripes = 0;
>   	em->orig_block_len = btrfs_calc_stripe_length(em);
>   	for (i = 0; i < num_stripes; i++) {
