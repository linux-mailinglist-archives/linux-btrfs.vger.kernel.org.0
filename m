Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006AA6654CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjAKGs7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjAKGs5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:48:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B950FD13
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:48:55 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmfi-1pLVBN0O8Q-00TGzq; Wed, 11
 Jan 2023 07:48:47 +0100
Message-ID: <46641c05-bfc6-018c-c153-4a8e62f59a2c@gmx.com>
Date:   Wed, 11 Jan 2023 14:48:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 07/10] btrfs: submit the read bios from
 scrub_assemble_read_bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111062335.1023353-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lBmKrcXjGcjnhavNn7rA1C6ApAQZ9nNj8IL/tkhp41vUJN/p2dE
 HObVAQzS5f6OHhIsWf2g/tz14b80k35XQBGuLbLGOlNFPU/4XFVSoF/ht7ecMSnDrU1sNA2
 IdlL3/qjx8rB8hJl2WvUhT9jN9bmjkNodsLhWKHjk0cGFOPxkf4PA++bHDSRKrOKcqL65XA
 OpAS6g9VcqY1wMXGJOtSg==
UI-OutboundReport: notjunk:1;M01:P0:0VaGkFdLWP4=;0xF3s1eVxZskkxxxkm8oxSHlIrx
 COxddDwO5qsmI/zpg2DP+C7RxbWL51ykcL00u3BmvZvA1pv3T5h1ictRs34a0yX33z+LjncX2
 yP3qL71LOiD5Lrt0pc11xEOc7AaVNGJVNQQWv3aj2Ib71vxge0TfKyeASdYJCh96Rjj32w9Tw
 dtLfTIHe088aIjDRQFUwPnkH2T/EETVjVX/ba6+h2k52nhdqx4LiRiulZ+tEuwg7yUvmnJZOB
 o30jEBhQmFTSQm44KnYrBBqP++KhWflqSmC6+CbjfIUflc3hx+TFStfCFYFoXUxX8hQy/aaJ2
 s/8/hPt2Nquiipq61LROgOPrHmAUeQ3+n4s9B1DIwmGFQpOBEFjWvL2HXl7LjjYjKWVbs2sfa
 coYATVrchgO5qiolnrL1mJsrhyMXhAvHhC74gSjtfIACglZ8qN3ly9lXc3Q3ZLzFpjYZLrtnO
 IJBTeKq2+4zyUns1hA80c1G9qgcUO615B9hmTqSPFPoFE9dsFDw6GdvnNWF8Iu417EXQ08m3B
 UK0AX0ImaDiaPhLafPlo4C24Y65khl55xrn28SnKXFVvF+kJbQ9+4LydGgD7pjghFuD1uPan+
 UOtCH1jMW4uSFx6vSfK2GUvWyNprNYR8XR7Rrl30HLexpDB1ghENme2z2+6xh0sXSl8JHHXeB
 8rpaq/usYndNTG3IbMtqmDuu8lqwF5hUGG5YL2tNb1VYb7C5lV+c5nnhtkyv5w7j23ng94kER
 IuGkWVm+XpA4RJCMDZYWHc1+cMjg+NDNdhpjNgoHFYifkuJ0DyPoOMbLADe6H7uZSQMRVIMT/
 sELwMOjm6qf592sGTM8l5SnTQmF+ZlxFAtkwbJOp05aya43sWUNIhJWi23TdDMOuCVrLYKkWm
 UVuv3+0PRN3mjbu2VDLRQNgoQ0muvxLuk+/MZgmta1letbTnmqGID9HpKnoinZyKp41imYwZ7
 3U0Ctp428uJ/I8yYrRZ0MX667Ik=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 14:23, Christoph Hellwig wrote:
> Instead of filling in a bio_list and submitting the bios in the only
> caller, do that in scrub_assemble_read_bios.  This removes the
> need to pass the bio_list, and also makes it clear that the extra
> bio_list cleanup in the caller is entirely pointless.  Rename the
> function to scrub_read_bios to make it clear that the bios are not
> only assembled.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Originally the idea of passing bio_list around is reuse the function to 
submit and wait.

But your cleanup has shown it can be smaller and simpler even without 
reusing the same submit and wait function.

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 36 +++++++++++++-----------------------
>   1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 88404a6b0b98e7..374c3873169b3f 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2668,14 +2668,12 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
>   	return ret;
>   }
>   
> -static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
> -				    struct bio_list *bio_list)
> +static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
>   {
> +	struct bio_list bio_list = BIO_EMPTY_LIST;
>   	int total_sector_nr;
>   	int ret = 0;
>   
> -	ASSERT(bio_list_size(bio_list) == 0);
> -
>   	/* Build a list of bios to read all the missing parts. */
>   	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
>   	     total_sector_nr++) {
> @@ -2704,42 +2702,38 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   		if (sector->uptodate)
>   			continue;
>   
> -		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
> +		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
>   					 sectornr, REQ_OP_READ);
> -		if (ret)
> -			goto error;
> +		if (ret) {
> +			bio_list_put(&bio_list);
> +			return ret;
> +		}
>   	}
> +
> +	submit_read_wait_bio_list(rbio, &bio_list);
>   	return 0;
> -error:
> -	bio_list_put(bio_list);
> -	return ret;
>   }
>   
>   static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	bool need_check = false;
> -	struct bio_list bio_list;
>   	int sector_nr;
>   	int ret;
>   
> -	bio_list_init(&bio_list);
> -
>   	ret = alloc_rbio_essential_pages(rbio);
>   	if (ret)
> -		goto cleanup;
> +		return ret;
>   
>   	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
>   
> -	ret = scrub_assemble_read_bios(rbio, &bio_list);
> +	ret = scrub_assemble_read_bios(rbio);
>   	if (ret < 0)
> -		goto cleanup;
> -
> -	submit_read_wait_bio_list(rbio, &bio_list);
> +		return ret;
>   
>   	/* We may have some failures, recover the failed sectors first. */
>   	ret = recover_scrub_rbio(rbio);
>   	if (ret < 0)
> -		goto cleanup;
> +		return ret;
>   
>   	/*
>   	 * We have every sector properly prepared. Can finish the scrub
> @@ -2757,10 +2751,6 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   		}
>   	}
>   	return ret;
> -
> -cleanup:
> -	bio_list_put(&bio_list);
> -	return ret;
>   }
>   
>   static void scrub_rbio_work_locked(struct work_struct *work)
