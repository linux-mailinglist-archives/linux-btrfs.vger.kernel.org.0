Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212916D9253
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjDFJKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjDFJKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 05:10:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49C198;
        Thu,  6 Apr 2023 02:10:22 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72sJ-1plBF32ZZf-008ewc; Thu, 06
 Apr 2023 11:10:15 +0200
Message-ID: <594c26a8-4402-6cab-5b0d-2f97adf9bcf1@gmx.com>
Date:   Thu, 6 Apr 2023 17:10:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: scrub: use safer allocation function in
 init_scrub_stripe()
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <3174f3bc-f83f-4009-b062-45eadb5c73d6@kili.mountain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3174f3bc-f83f-4009-b062-45eadb5c73d6@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:x/dlBM+BQetpcvbRt+iseOEjMmgTeW4pdO41WioiSaZJzqu0/N2
 Dm7A45qqNj7utSdtDlaggbkgpDOIBkge2ogAYOK5DxVCRmXuWDSzNlHonX3WfBKit7OaKQM
 DQM/MRwaY3DDVy3dbpSht6FSG8rZdEHWJWuoLGpMWdyA3rbmKd+KrHXh1HugpnsDglzkr+v
 fCLukz5xiLXf9++yPgHsQ==
UI-OutboundReport: notjunk:1;M01:P0:zkrvWmXt3oE=;mGmdekHbUpdIHXZI65pmf5Q73RL
 lHQdZWlKk7HCduR7yyrPqyWc6M5eOFj+Hw0eImrTaUAY2zjC2VBD4F+m0M01VFXXE3zIhK/NZ
 S3Zt0ywJWRI5670MYL0ZcJ4KX8SG0aI6Pq6BhZZXML8fbhviGuDUZZeEJ9t46kopP8+aBWD6L
 T7wiiFq+2lS2wgvEC1V4d90ddueSl9Vh7LN8u0o3U3APjzQLaQ5MNsobJS/tSBShVIBL3X0AI
 nY0ygB/xmGdD2rZETc6xyhRzFe1w+ph4bFyBQUHTgbkeCFC2+BNegKhe0eSjc+4P4gfJwyiCb
 t/egZzogAjOiOpDAPhO4wHrvWwHnQgdvkXVpB/SxPp1dkjvYRaQNX0wNrOwsnADRkWo21Tr2z
 +QaGFonBRqJwdLdqmKCuA0Zn6ddVt2L5XX8X0JCV7RqXqgmVGRjDym9bboFHZy2Afr+Xvdk22
 QFIZKk4UQR/Ql8Pb1C6HM/HUZ7/793Z6OpCNBdECBkGwNWIkMD8i8641N6iyl8D52d++OO2jV
 PZv9Xx/idvYzYok516+HiDHDcBeU+q21Ls/crh3JgfRIpXOp2Ct4pwg30gL3+h/+uwglQ3NMD
 16FVE8B+5lLKdrY6oy8mJav+Rg1BKg9hISjh8oiMxi5hmdFqWVUlV7WVXcNmJJ2LLbAIeyyOx
 4KHSxr2PyRJ0+d75a7xWsqFQFC2cIHTocGCs/VrOdQtl6W78ItYnrYD+4LzZLXBSOQFwyg7AE
 bpB6FiLYMZ+XO7VcC0Sty5kBzF0TlYeuSsHUu6bWvC/nLGyLmp2rWVljnQ9Oopvs9w87hdeQa
 LuBnCUCFRpyQH9GOcn3QFwDwHuiM1Vuu8MktrCzns1UYZklxqmBU3Z17OqWa/mqk2q6GR6arZ
 8jtrDV8rYI/lnGE8Z9E3KxluISE3mtk+FmeXWspPnpW8uSbGdrtPRl62LL0V63bo5dI6yNK7L
 lvz7Fo5Af7w5VF/KB0APJchl2hI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/6 16:56, Dan Carpenter wrote:
> It's just always better to use kcalloc() instead of open coding the
> size calculation.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Another thing I always forgot...

Thanks,
Qu
> ---
>   fs/btrfs/scrub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index ccb4f58ae307..6afb0abc83ce 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -254,7 +254,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
>   	if (!stripe->sectors)
>   		goto error;
>   
> -	stripe->csums = kzalloc((BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits) *
> +	stripe->csums = kcalloc((BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits),
>   				fs_info->csum_size, GFP_KERNEL);
>   	if (!stripe->csums)
>   		goto error;
