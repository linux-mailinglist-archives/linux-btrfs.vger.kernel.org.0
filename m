Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDF64B192
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiLMIyt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiLMIyr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:54:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3D219C
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:54:46 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzjt-1pP65X3U4X-00XIJL; Tue, 13
 Dec 2022 09:54:39 +0100
Message-ID: <8aa07d31-7abf-9b8b-6882-08246757b620@gmx.com>
Date:   Tue, 13 Dec 2022 16:54:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 6/8] btrfs: call rbio_orig_end_io from rmw_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221213084123.309790-1-hch@lst.de>
 <20221213084123.309790-7-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221213084123.309790-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sip9aXtMi3YEHs+8sIIDMFbJUN3mAKsahPZTAyKAtoBxL+77D20
 WvvYmPhkUUNXm6rlT1qLWptMgvLD8eZA1w3JqUcOLQ0A0VULkqRISE39zA3N8+t0vDH4lFg
 tdwp341D5iEYyG/pmkOW3xi4fhxZMnSUnErUdpcoQe832by4xrILUGkXqqm0TpJdEuMZ3KW
 rRNETNx4OFN5FjHOt9xFw==
UI-OutboundReport: notjunk:1;M01:P0:R6EBoTaWGRY=;g+FHaIu4rQSpgnbULZn+tFNK68r
 WZJYlF4jfAgSYWUrKbZ1aeDCgVuzQAhyIrjmjNeCImfepL9EuXg07ZT7BcnFa9R3KI/qFCHkf
 Zk1srI0WiT8RcmNCIxnmgetsoY5OiKt+Y780Ta7gjeeDJWLJx0c2GYl6iWAbZ65fm28H8yC1z
 EvuAHkrghmPs0dPADq8FKaKMYciWAOXj8+ymarxnW9QqvZ+I5nmJKSxg76MDEpd9t3ZH2v0VU
 mT5znwsykPKgoATb8QfF+ucHfwHtRFScmbvblj/VvzJ3bIkd130f69GeWTYLFkYKW2Yl0uF+d
 QM/47M/mLYcy1VcYYW8K3SDTiO+3li/OrajfTNXuEWrhe6dePk3Kbfn5MyrvaD5RJLEwKiFgo
 /UaiGqgsrCTpAX/b9lG6BE8jjPz8xHCdH93+CiUG85FIx1p4EZay6DMsEl9ND9gSTYfqAXtNp
 O0bx1rghCZoAY72GwdvJz5fTCI2bevh29gEPucOiJG1TCVK4pG6h8ezrrqNTAz+f9l8Ju+KoV
 P5jkFkrkLOEATjNd8xZTNCnvhZBNCJy7fzq6kf0xo5+KMiH0kGxf4WTNzSSZwANbGUGQqiHPi
 hmRDC8F0epM1JCZB9FGUItE3sje5+wXcAcQ6U1+A+gVFPQtx3OXwAB/I0Wv1gTAc2DGVNYs+y
 fJnGv0gSIgoKykW/jwtJMma2yEvlQNw8dja9gQo2sLtiB77at2tqPw89lx72NbABNU7pc7iBy
 03GQUjB/dxJxSJqFCbmm2eSUdXcUhPU/pAhhjlxAXpbP7Ht/vzND7O+ACxTi+wPFPwsq6spza
 WS/o3he+kjPlqDkOQUE1cZmNqUBQkai46pAGD86K/T9sgQ3HCANE14ZmiR7YMvEu9M5G+ESIs
 ssyaVlMZkQ72kLXLiYPWeecuByAng95MkwQ/zf36SYYDOznGVukLVfrvuH1JwhGFzoDOKwPF2
 v1n/YpGjMaPP5O0EERTjn+UW/dw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/13 16:41, Christoph Hellwig wrote:
> Both callers of rmv_rbio call rbio_orig_end_io right after it, so
> move the call into the shared function.

s/rmv_rbio/rmw_rbio/.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/raid56.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 2a5857d42fff20..2432c2d7fcbed0 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2262,7 +2262,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
>   	return false;
>   }
>   
> -static int rmw_rbio(struct btrfs_raid_bio *rbio)
> +static void rmw_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio_list bio_list;
>   	int sectornr;
> @@ -2274,7 +2274,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   	 */
>   	ret = alloc_rbio_parity_pages(rbio);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	/*
>   	 * Either full stripe write, or we have every data sector already
> @@ -2287,13 +2287,13 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
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
> @@ -2326,7 +2326,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   	bio_list_init(&bio_list);
>   	ret = rmw_assemble_write_bios(rbio, &bio_list);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	/* We should have at least one bio assembled. */
>   	ASSERT(bio_list_size(&bio_list));
> @@ -2343,32 +2343,22 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
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
