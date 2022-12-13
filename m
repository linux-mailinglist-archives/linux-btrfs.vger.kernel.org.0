Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494D464B190
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiLMIxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiLMIxs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:53:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C086C58
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:53:45 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfYm-1pBZYv36Xg-00B25d; Tue, 13
 Dec 2022 09:53:38 +0100
Message-ID: <083cd81a-644e-a054-80c1-1b3b902ff6e9@gmx.com>
Date:   Tue, 13 Dec 2022 16:53:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 5/8] btrfs: cleanup scrub_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221213084123.309790-1-hch@lst.de>
 <20221213084123.309790-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221213084123.309790-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cMQCiZM6fs6Bi3LK49u0KaeZZp0a3zxRj1wNnqKTjUglMOhpAth
 NBQUDzfBkhKPUpUJAnB+fWuR4afATEpdPqIMq//IWi0T8Hq7C9P8NqpG7uZb7iOC98ZxVRX
 PmRCkf+WeSyHDptDM5Sdhl3G4WG7rIMrwSwQzrb03BMPgyMwQloeRG/HuKSTD3R3p1DYvsH
 e5/0flx45nTzs1Xl1Xscg==
UI-OutboundReport: notjunk:1;M01:P0:JBqsE0HlO4Q=;FXCD6PkVdV0RBSYqtKrn/TEDpu+
 YU7JZyi4yvauF7G/o/WX1bLVQRMtxjKVK0l3WFK4lT4v6av+YkGn+3xUu9BmHO6jjjCesYqgs
 iht27ZBX2/QfKO0ofRyRQIlUwFuujNDBk4ulEQJFeG2uzzU/2czRfHq2JNZJkRwra5af/KqXq
 lQa361DpplmBI2GFpqOGHthm30ZtDskdc1XgwgQIxlHGUGxVDMnpwXm2FKdPXhnUyZAOYw8mA
 Ri8F9b3MSElfirQCfE3qZJPV8lLi+dbo7313GzYC57j6RyK8PL2jt5smc24oIDn9p6LTlB0sq
 rYASlyI/ZE5306YMKDjV8/hxe3bTPOLTssbWIU90g75kA6u444RQPTv8MFQ+IgJVAsfL3rKIQ
 K0OYSXZOzlUvCssqdxqd5OG/ymrAE8a2i6E47nXlnRoXwIjfEkBGK1bsOmyghHYjcDSgwZQzj
 DjNtJskT6qDmOc7duQn5mRs5mMqXVekUgWZjFGBNYU8zzFoX52Jby2bqeBpwQgsZup1u4/+II
 vTImt/PZv/x4QsZ1QWoru4V4OeFu3S/k2eKLk+rgXgcvpjVeK+WDtB5xL+V2dPQfI3zpXjJGl
 8T3v+qRUUDl0VYOgRAUxPD67g5tGSefg0C1FvRmoUB0jUSXfqBPeqkSkVv4veQNjyBdLyKN1g
 dhXN/OmmEMZOuz1gl2BU05ABx1p0DhWjsO8Wfwbu5IL5NC6N5UwRszjBQCq3pwQ3tyLIZMDY/
 j8ppaJM+zx7c9WvwFqSb5I5lm5Zcesk8qEG8HwjbMqJtQOdUd4IvneMGKiPRKuw4SVsD9sum1
 ufG3FUVrnXWcGbat1/TEP1qFu8iYPk8GmOVUfin7gcYSX0boEgTP5yGInpYFkjBtizsh/7Had
 sg2iZ5utboyCDcAZ8V/YxPHMJyRCarp4+EyTkHut3sDj3o1K8ZDB6ShySk1zGdvppN6N2iK1J
 zUzWVyOTwXoMIhgLgab+XfEnys4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/13 16:41, Christoph Hellwig wrote:
> The bio_list is only filled by scrub_assemble_read_bios when
> successful, so don't try to walk it and put the bios on any
> failure before the successful call to recover_assemble_read_bios.
> Also initialize bio_list at initialization time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/raid56.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 5dab0685e17dd5..2a5857d42fff20 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2754,31 +2754,32 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   
>   static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   {
> +	struct bio_list bio_list = BIO_EMPTY_LIST;
>   	bool need_check = false;
> -	struct bio_list bio_list;
>   	int sector_nr;
>   	int ret;
>   	struct bio *bio;
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
>   	ret = scrub_assemble_read_bios(rbio, &bio_list);
>   	if (ret < 0)
> -		goto cleanup;
> +		return ret;
>   
>   	submit_read_bios(rbio, &bio_list);
>   	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
>   
>   	/* We may have some failures, recover the failed sectors first. */
>   	ret = recover_scrub_rbio(rbio);
> -	if (ret < 0)
> -		goto cleanup;
> +	if (ret < 0) {
> +		while ((bio = bio_list_pop(&bio_list)))
> +			bio_put(bio);
> +		return ret;
> +	}

Do we still need the cleanup? IIRC after submit_read_bios() (or be more 
safe, after wait_event()), we should no longer touch @bio_list anymore.

Thus the cleanup itself is no longer needed AFAIK.

Thanks,
Qu

>   
>   	/*
>   	 * We have every sector properly prepared. Can finish the scrub
> @@ -2796,12 +2797,6 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   		}
>   	}
>   	return ret;
> -
> -cleanup:
> -	while ((bio = bio_list_pop(&bio_list)))
> -		bio_put(bio);
> -
> -	return ret;
>   }
>   
>   static void scrub_rbio_work_locked(struct work_struct *work)
