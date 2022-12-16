Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79E64E6ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 06:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLPFcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 00:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPFcq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 00:32:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3679B14D1F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 21:32:43 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma24y-1pR4kL3Kc8-00W230; Fri, 16
 Dec 2022 06:32:38 +0100
Message-ID: <0507a942-2a82-f086-2be5-a9ac64e4c1d3@gmx.com>
Date:   Fri, 16 Dec 2022 13:32:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1670451918.git.josef@toxicpanda.com>
 <ef73c4c67028f9e7d770dca236367f1ea0b56b55.1670451918.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 2/8] btrfs: do not check header generation in
 btrfs_clean_tree_block
In-Reply-To: <ef73c4c67028f9e7d770dca236367f1ea0b56b55.1670451918.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1JgDqFKsgHREyYuPoTUBb6UMjaLB1b+vtByPYGlVhWA8NpZp/90
 DkYUZTG2ghAjrxtwioSTchqryqPcqaztwCObq20r8vYT+VDvDNbzQYpAEF7hW0CWDjSuQ2I
 pE0qwWXiU3tSVlX7G3evhxP1+5lsPoJaGlMwMh6IDoXK+gFbsS4waLYlfOP3a6Cj/3Z4rgg
 JnMbN43bQ7d5Rj6AvUmZA==
UI-OutboundReport: notjunk:1;M01:P0:5cKq/B/rqZ0=;rOoKFIsUREgpkFbjXYerzf+X6Y+
 zwIv6niDXAVYsiET/MVerKZJRhH2EOtNhckIJioCI5U78JZJenmKGVDwhquqItlQlOS3kNUfc
 vZ313cPI+vMYrDmDYoJ69zGr8xnZix0HsRZ0eh1/xaZUKIKi3hWKIPKEZIk3lGWGMoTgT408B
 DsNw83HSkWjZSu8hzJwWtg+ohvZnSlsPiY4XHHyj3hWv2djrW6QhtsiAle3eUexpENsbADlgp
 1B1avGnqPbwuYgdZiBcWgMK7K/RKGNtxZSk7Jvpzhm4ci/t+9XBGuw1WX16qB9foYbgptekVv
 tnIoNHCuCCEU7VKNUMyA89+irM12i1cq+3+FvH8IMEKZTZr7HA8tzh9YNUxkqqCUHURgJr5gN
 bQ6pmWulmMcIZH41unTRXRfZpxfKStmIx4shvH2QO6ghA8+jr3tBYF82XxHRTObzi3MIiXUNd
 Ah/8kRaOVLHa0j8l/6RuYwSHjaZuy3iGBbJIG4AZBDyzNBa27k08rbjg3xI0TmcMYbDumMZEd
 fTNnDmgv+OWmEu/vmBIWfEh5QcllmTWq3XFTwpM8jVpG24QK58Ntz+fLbmfTLzZWMKF8UsGHv
 YzFGznJDRNiSMnfnin3OAgIyOJv8MSt9wJWVxdWI2BXLspAZ+jVHAPAGc+xzn2yOXBn4irJXn
 q+T9ykSQiXh5WdCT5NeWJIfnKsj9NkzYFdAigoImPQSvREdPH38pAZh7BEl5haX74ZIvLuibx
 HlpszAxsgNg5jI/V/4BPC5ADTQmRAXEonKj83fRImxsuSliyZeD1UX2wXHMtXVXIGGBKPAqV3
 +ztqRvo8UA+pWMqtuBe96wNcEfIkolEYp0DZs+ZYzh9I5HlJtTWZn3oMUmO0g4gerI/mqD8m/
 bvxADGHqmJl7B551KGY8Q2An0WDcLj0rhPl7t0Iec6DEUPQ+ESTTSEk0/VVndNP81PVNhMQwY
 7L5YOG39+f4zLWh/u0jTNC6fFQE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/8 06:28, Josef Bacik wrote:
> This check is from an era where we didn't have a per-extent buffer dirty
> flag, we just messed with the page bits.  All the places we call this
> function are when we have a transaction open, so just skip this check
> and rely on the dirty flag.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This patch is failing a lot of test cases, mostly scrub related 
(btrfs/072, btrfs/074).

Now we will report all kinds of errors during scrub.
Which seems weird, as scrub doesn't use the regular extent buffer 
helpers at all...

Maybe it's related to the generation we got during the extent tree search?
As all the failures points to generation mismatch during scrub.

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d0ed52cab304..267163e546a5 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -968,16 +968,13 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
>   void btrfs_clean_tree_block(struct extent_buffer *buf)
>   {
>   	struct btrfs_fs_info *fs_info = buf->fs_info;
> -	if (btrfs_header_generation(buf) ==
> -	    fs_info->running_transaction->transid) {
> -		btrfs_assert_tree_write_locked(buf);
> +	btrfs_assert_tree_write_locked(buf);
>   
> -		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
> -			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> -						 -buf->len,
> -						 fs_info->dirty_metadata_batch);
> -			clear_extent_buffer_dirty(buf);
> -		}
> +	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
> +		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> +					 -buf->len,
> +					 fs_info->dirty_metadata_batch);
> +		clear_extent_buffer_dirty(buf);
>   	}
>   }
>   
