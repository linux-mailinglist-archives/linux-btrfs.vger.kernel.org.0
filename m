Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA336C2B52
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 08:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCUH05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 03:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCUH04 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 03:26:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B662D29428
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 00:26:50 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1qQyF143SS-00vMNl; Tue, 21
 Mar 2023 08:26:44 +0100
Message-ID: <35929eb4-7467-6cae-3d5d-3f6b239c11a7@gmx.com>
Date:   Tue, 21 Mar 2023 15:26:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] btrfs: remove struct scrub_stx for superblock
 scrubbing
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <10d0f55b196d4dc949f0ac29f2f0af023eaa7523.1679376183.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <10d0f55b196d4dc949f0ac29f2f0af023eaa7523.1679376183.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wB3ieHIIldoaYwtHdtNGik5sY1aZgxyR63/uf/nwxFEowD37aTc
 D5fab6QBAu2HHVJon0EhKGCVSb7/dlPHPxrd76wA0pIszW2eNO4MpYj2UvPzVH1iPO4/WMH
 7EjUi5XMq/A921tlQ4uI9glXNd7LKux4bfUJj0BdkkJip+NZFlhqH2fVsXpCg63NO/W3dnu
 THO1Lp/QL0taXDCJJOvkw==
UI-OutboundReport: notjunk:1;M01:P0:Jr7lUtKr6DY=;QW0FPP37vlHI8AahbBSCzBkyDIL
 Vl2R0PdbHjpRZiyUNz6WQbHQn3p3GebJhtcO2DMOYnZx8SutO+/ivI/NZhGedcP19y9OTaXqE
 FHeGTfY3Puw18ukzpAQyeXZNOklAujA/Caev5T70+At7cusqPEFuuZh/yNIElT6UZdcAGiN/T
 0sacj6bC2FaGhY3fR2P20pUGlCykPPrSiewCYe6rYddbATv1XMhfo1Isle6ovtugJHrrQ6N12
 qCvE2o08luSXA5MbyGuD2/OvDH5MVO7kzyLdpvB1X/ldt3d4wSnuwRhULXz8uVXuCHOMDDseM
 SLoVptcsOnIQA6SgQLH6BNbVfOqMgkbqJehP/rrUw0UFpNZZSAMzxGIEOLC+qPqbK4d4Yc5UK
 LwocEu4Nv80yJGwEiaHL9SXVyGzsZxsVArLdHYDGPdUAxpAvaGenoibPiScX6oAicBPq0xZVv
 ZnH8cC3xKMMUVMHcKg+pou9YavRzjRYK3cYYzKAxPumOPwOFB3gVeACkyIReiW9pcM/TVAv/7
 4W5bqx0eGoTftyUZlp9i//OSgMC1xrgkPq07weopFadnerbBTXJndRMHJXZ2CII2pKi7ui3XS
 bsQDQJbHcieYfVk4PdPJmRACWDoPeRp8M6NAjCN2m0z+MC9IYcvER3t9cHgZy1e8zpJGDdsRw
 PR9RkyX0I2R7ozkZI5QnP0cvkIpjL8fxdggUPYJFXw/MNLbz0i+5rMw4fxrtK97kIytUajEdz
 yCU342l/iNWNfN7yceSchiGQJYfUyWESQfXwXz3n097cqo+7SFKnIzlqt/5odsCYRDrh5R704
 4NWlbv4B+QgFuoM+kh7h6+z8W5zuymjO4ifvQTK5pYpgRhFlU8fMoAFF0g80bk3exvnrJTHVt
 ipAin3viXrKrHGhBRT+cEnFmvl91SHajY/37O2TYwg3jaRJ+7HKN0LT8iuE6TfC1d3TVcLVIK
 g73DdUbPF5AXWSI0hv9ORN96suU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 13:23, Anand Jain wrote:
> Following the patchset that implements reader-friendly scrub code
> made the struct scrub_stx is no longer required for scrubbing superblocks.
> 
>    btrfs: scrub: use a more reader friendly code to implement scrub_simple_mirror()
> 
> Therefore, scrub_ctx does not need to be passed as a parameter,
> (unless there are other plans for it).
> 
> This patch cleans up the code and is built on top of the above patchset.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Looks good, if you're fine I can fold this into the offending patch in 
the next update.

Thanks,
Qu

> ---
>   fs/btrfs/scrub.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index beccf763ae64..bc87277559d3 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4909,12 +4909,12 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   	return ret;
>   }
>   
> -static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
> -			   struct page *page, u64 physical, u64 generation)
> +static int scrub_one_super(struct btrfs_device *dev, struct page *page,
> +			   u64 physical, u64 generation)
>   {
> -	struct btrfs_fs_info *fs_info = sctx->fs_info;
>   	struct bio_vec bvec;
>   	struct bio bio;
> +	struct btrfs_fs_info *fs_info = dev->fs_info;
>   	struct btrfs_super_block *sb = page_address(page);
>   	int ret;
>   
> @@ -4945,15 +4945,14 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
>   	return ret;
>   }
>   
> -static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
> -					   struct btrfs_device *scrub_dev)
> +static noinline_for_stack int scrub_supers(struct btrfs_device *scrub_dev)
>   {
>   	int	i;
>   	u64	bytenr;
>   	u64	gen;
>   	int	ret = 0;
>   	struct page *page;
> -	struct btrfs_fs_info *fs_info = sctx->fs_info;
> +	struct btrfs_fs_info *fs_info = scrub_dev->fs_info;
>   
>   	if (BTRFS_FS_ERROR(fs_info))
>   		return -EROFS;
> @@ -4976,7 +4975,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   		if (!btrfs_check_super_location(scrub_dev, bytenr))
>   			continue;
>   
> -		ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
> +		ret = scrub_one_super(scrub_dev, page, bytenr, gen);
>   		if (ret)
>   			break;
>   	}
> @@ -5172,7 +5171,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>   		 * kick off writing super in log tree sync.
>   		 */
>   		mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -		ret = scrub_supers(sctx, dev);
> +		ret = scrub_supers(dev);
>   		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>   
>   		spin_lock(&sctx->stat_lock);
