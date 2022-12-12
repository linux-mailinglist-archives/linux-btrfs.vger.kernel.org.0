Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C86499A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiLLHkM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLLHkL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:40:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C795A6
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:40:09 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvvJ-1oSFnL0vuf-00hR1O; Mon, 12
 Dec 2022 08:40:02 +0100
Message-ID: <0d509df3-4f20-7a10-ee3d-8c7474af87a8@gmx.com>
Date:   Mon, 12 Dec 2022 15:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] btrfs: call rbio_orig_end_io from rmw_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221212070611.5209-1-hch@lst.de>
 <20221212070611.5209-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221212070611.5209-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ty7RTsaTKuP48eE4lzvxkVp1t6s3toUaF8CRdm+NTbRjmuXELKK
 I732cQz0rahZ0BPYWPb+VfsGH2OyYSLcpCbaGTTwq6Yk1OooUj7TLURn4PpVZpKjZhUqg6Y
 rD8GnA8/YCAhvFgyXHcroKEgPuLvBo9/JLKDsp3Tb4bYAERNk/hx9VVWalM1CdM8qEnWD3m
 Pw/nO7Nq5kmGUQ3rdP7lA==
UI-OutboundReport: notjunk:1;M01:P0:TtHWP2bHABI=;5LDSydaEN+989Vd/afFHVjY2DDX
 3+P3CGGhqLlf5HDPvvnTucwTxJvd6GifJyFuCw4LS9JvaaZ/FRpnKWnNLLdc7RhaQY/uL90EO
 yp3cEMmdMDh+AvEAO+x4KHEhDJ+mBZbB1jIUM4trinWI+5yu1wZGdI+FMwl6XgP8kBZwL/M55
 OQWvcJdIWfLMxtgrkd4lxlgnnaN+h9v02wPE3e8y8qSD10EHumWipIlOUUPOXfetvw0B9+XAK
 MfAu6I+OgcUZd6iNGl89K+LxFF4FZV1AMsoZI4uYki0VlmtsTuKyyiFgQyqoF49odKu3ERcYU
 K7AsWWWFI0a0thdLV9k32JfHBLuWMFrVvBc6e0AmU8p9WDl2ZvSSS/CKJVgnzTBPqKTPpf1eN
 CfpYyFqqtWl4ZWY/re1TuTonNhSIT+JWc7VVqWdoIjXgHenvt46EhfeZ3yRFE5AvapA2KzFYb
 uHSOz3zKHkGpb2T9qAfqh7hY9SXQKuQxAq3MctmWHvqoy+xP43wv2/1WR4RtT0z6nO5Fwd1X7
 xiHeOjKv7v86gsdtSthF0zcnxSNejQfBieVo3ty5+DM3VKiPr9O/fXV6tAh/qMGgij+jEZoyt
 2ROzuvZg4e3uUX11g06sXZX2UHBq+KHUO5qqVjsDF5SRgFCBGEKPSiEtnSxfjnEAjgE9USABs
 Tgk32OecHg0Za5GlkSErevnQ6o6s8B1gmGDolkAyLoxzoZcp2JpjP/29clJCJV1ochyM5Uvcp
 sH92TZwkZxTOXrgOZdPuk927V43hpRdDTV6RnO/5IIEJIOZ8Vdat+KaNf4Sc/kEmB4n9NlGoS
 c2BpHhd1JIQraS/uLIam8uL+FFjwJPKSSoIWUVtFYtRg/FPTMyy++V7ccC/RCLsMPFBprlyIT
 fZxaCIem+4yB+GBF94jnCfBP4CbbBXOSpWZ68lDsn+cLatYrJ2XuhrjNcF9cCJYNiYsk740nz
 Z6UGwVq+LKDQxba5/fVDZrKOaSs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/12 15:06, Christoph Hellwig wrote:
> Both callers of rmv_rbio call rbio_orig_end_io right after it, so
> move the call into the shared function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This changed the schema, as all work functions, rmw_rbio(), 
recover_rbio(), scrub_rbio() all follows the same return error, and let 
the caller to call rbio_orig_end_io().

I'm not against the change, but it's better to change all *_rbio() 
functions to follow the same behavior instead.

Thanks,
Qu

> ---
>   fs/btrfs/raid56.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 5035e2b20a5e02..14d71076a222f9 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2275,7 +2275,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
>   	return false;
>   }
>   
> -static int rmw_rbio(struct btrfs_raid_bio *rbio)
> +static void rmw_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio_list bio_list;
>   	int sectornr;
> @@ -2287,7 +2287,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   	 */
>   	ret = alloc_rbio_parity_pages(rbio);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	/*
>   	 * Either full stripe write, or we have every data sector already
> @@ -2300,13 +2300,13 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   		 */
>   		ret = alloc_rbio_data_pages(rbio);
>   		if (ret < 0)
> -			return ret;
> +			goto out;
>   
>   		index_rbio_pages(rbio);
>   
>   		ret = rmw_read_wait_recover(rbio);
>   		if (ret < 0)
> -			return ret;
> +			goto out;
>   	}
>   
>   	/*
> @@ -2339,7 +2339,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   	bio_list_init(&bio_list);
>   	ret = rmw_assemble_write_bios(rbio, &bio_list);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	/* We should have at least one bio assembled. */
>   	ASSERT(bio_list_size(&bio_list));
> @@ -2356,32 +2356,22 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   			break;
>   		}
>   	}
> -	return ret;
> +out:
> +	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
>   }
>   
>   static void rmw_rbio_work(struct work_struct *work)
>   {
>   	struct btrfs_raid_bio *rbio;
> -	int ret;
>   
>   	rbio = container_of(work, struct btrfs_raid_bio, work);
> -
> -	ret = lock_stripe_add(rbio);
> -	if (ret == 0) {
> -		ret = rmw_rbio(rbio);
> -		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
> -	}
> +	if (lock_stripe_add(rbio) == 0)
> +		rmw_rbio(rbio);
>   }
>   
>   static void rmw_rbio_work_locked(struct work_struct *work)
>   {
> -	struct btrfs_raid_bio *rbio;
> -	int ret;
> -
> -	rbio = container_of(work, struct btrfs_raid_bio, work);
> -
> -	ret = rmw_rbio(rbio);
> -	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
> +	rmw_rbio(container_of(work, struct btrfs_raid_bio, work));
>   }
>   
>   /*
