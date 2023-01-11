Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B976654DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjAKGuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjAKGtq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:49:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB42101D0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:49:45 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNp7-1oUdX50JxN-00lkkn; Wed, 11
 Jan 2023 07:49:38 +0100
Message-ID: <7a34bed7-acf7-3ce2-1adb-28e0526ea847@gmx.com>
Date:   Wed, 11 Jan 2023 14:49:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 08/10] btrfs: call rbio_orig_end_io from rmw_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-9-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111062335.1023353-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eG36A8tgzdpjPIqnZOclVGgcx407I8BW5RJVtl+5mZ0FBqMDHZD
 TGy+HlWQnEewwn6QIlh4VbVZODIsEc8tAlfO+VEDHGhfrzNn/0EFr4OaYvE9bFTJ6tWGhkp
 PJg3bEWQ1OVLzUTkEb6SeJVXVzNYuJVsMWL+AjtVhJm6ViOvufOx0UlYDHIvuhMrfEdlG6Y
 etCeux95gjykIa9kC+vYw==
UI-OutboundReport: notjunk:1;M01:P0:cE6BwbLPW30=;Yapw1+dPVI/wk57MRulsMI0t6SS
 3QKd5AzVBWyjKnsYZ3e1zy4+wB32qUh6BSTCljWEO8P0F5sxZ3Kt/MlZF9Cr9Wj350loqWMSi
 fIEMKaYrJXUKOc+8Kq4oF7Yu1dfeCakrGTT9x2c4ydFLKZByrae70+VPpr3C8tOpu7KuCGvJK
 sontoBWDqpj9s08mm4XgWYfwetGZAD3ZknMHrdS9QHcwom//9QLI9kuilRzqgWyaWB791G7ml
 L2j/LaPnLd6qpL3bH0VabeOxSGytOZJHDbIYlfYFVD5BwEV6co/onNbpfz1Vsq218oZgHRERF
 EqVRuJIFlgDr8RG6UK7Ct0knPN/sDCUJfQd6PXywWUEHcxBDIZeYhUTiJhigyBDALwG+++rUi
 wZe6kGaEoBUcw8kGfJYl5Cu9bmWNPBBIZNGxMX8Ra7AS8h8AQlZs6N09bs6EINUadoEx6asc5
 0U6KAtOtA8y3/L2cl4hKDuCyfcpOy3ybDoilROgtlIimKvUnO1Epbbgxhz/txpZgSHZQaFu9u
 vHnvVFWMoFLnATcGLsX749X2lB8EJVT7gnefk2BD/9Obh8WOd1/6nHON48G6kxbouyDLvU/4d
 eV8tk07w5XzLYsXs4zQ4XhZgS39bbbODDZlv7MrnqcaBzFrrEW3iPxaQTbe588jBPcn/wOPPc
 aD/yVCwvB/y/KeoQ8/qzQOFOODhA2GYF1V/9QUBn5ze+w8oqkeILa2T6/TwocmOlWfYICSoB6
 TBuoR2X+Vbzbj6jKjDzC0sna+Pry1LqloIe/MGw0Tf9QWXvRDHVLSyQI4Sy0Amph+YtZ5tN8V
 3yD+MICVnhF4ZOaIl2AJTs35Osojg/9vQ88D0gbm8eji4LxavFdzFEP2cEN4gcfOwsXrEwvBH
 Qn+v+wPt6Jxz8mOxco3i6pn3jZugvGFqbUcgOnBuCAtQr9dtKLIT2GfA0rFVn6sUrZWa3K3mf
 as7x74kAJYkQS/CzsEiOtORXido=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 14:23, Christoph Hellwig wrote:
> Both callers of rmv_rbio call rbio_orig_end_io right after it, so
> move the call into the shared function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 374c3873169b3f..a9947477daf26d 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2229,7 +2229,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
>   	return false;
>   }
>   
> -static int rmw_rbio(struct btrfs_raid_bio *rbio)
> +static void rmw_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio_list bio_list;
>   	int sectornr;
> @@ -2241,7 +2241,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   	 */
>   	ret = alloc_rbio_parity_pages(rbio);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	/*
>   	 * Either full stripe write, or we have every data sector already
> @@ -2254,13 +2254,13 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
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
> @@ -2293,7 +2293,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   	bio_list_init(&bio_list);
>   	ret = rmw_assemble_write_bios(rbio, &bio_list);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	/* We should have at least one bio assembled. */
>   	ASSERT(bio_list_size(&bio_list));
> @@ -2310,32 +2310,22 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
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
