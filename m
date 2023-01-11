Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016506654C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjAKGmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjAKGmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:42:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E2BD1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:42:49 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2O1-1ocIO80A5p-00e4CY; Wed, 11
 Jan 2023 07:42:41 +0100
Message-ID: <c946672d-29b8-969c-3230-28887c1ccf63@gmx.com>
Date:   Wed, 11 Jan 2023 14:42:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 05/10] btrfs: fold recover_assemble_read_bios into
 recover_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111062335.1023353-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+ZZrY9eawVZIXJ/Y5i0jMLbII4Zn5QoCytPv46qV8WWYgWrOOX3
 kV8zof6vdUSZTGaH1i+FYsRVj9dokFpGmJk4Zw+618ugApb8dD+YZJ7/qQEC8Ae7kP5169e
 9AT1aNmJcyiP8MYPH8toiqghqg/r+pu52GmCGR5Tn2qctQZ4e4yI8L1HpIMpQZWPAVGLrzC
 FpzWAt2mBoP1MCXa0ybjw==
UI-OutboundReport: notjunk:1;M01:P0:s+Vl6l0jXqo=;lBC82ylxPp3qnhLSu4bEnvWLY53
 //YJ4HFqSzE1mVKOUurIjlo/BDEaDm5ZQcb2WS9zBReIziq9qojM5cQZC7cEs19Zb+P0HW3FD
 GOBqxVUBRUh72bcUp12krEK944rKxRXto3dVtAPhMJHZHDbR2LeWBFgj2rzapuwhMboj/4jm7
 HK0Muo6ws+/wLip6j9+RJfcssoKha5vzL6dWjP/PBQKHIMPRXLgzS8h0WZOLpdGzmf9ywkDSo
 V2aKFN2+lsDqvB4E3esi4aBylTdLPaCCUeCT6bx7qSjuYz5FoH7I3+KRK8ndje0rsDzg3UJNy
 H/8U9RTNs5Z7lZ8OJrrUSZ9loHATGvkSbX0pVT95hb+A51ihYaaV3DD3tN7WrFl6TWZ73SIsk
 I+WtUpPj5R3j6eixVMc4531CnvLpvn3EfVmPWTM4IxTUScqJrtaQWjHXpffT4lj6SkgcTqD/z
 OuwyjtN1jfjNAKACp8iL88clutQJtPokQTs3F1ejJKq+xzdKhRnX1H2dGpc7SsNzYwG+cJHtw
 FwijWAbWLzujCAHSPdWc400PD/40A240eL5t8AMKIluyfS2wUjKwOXvc6YsMmWyEL++IPRrIf
 mdjtzzMLrElGYX/91qxoUuNnP5A/JAGR1C+JVmn1npH115YAQF5JUaGPDVM7TiTFYUcHwXQgV
 n+8iKFDqmi7EXXg9mvoQkirmjUZgRYMgNFxaDGQIZaOKgmmhKQ21CsBthRrtg/HefTOKlQTng
 HGe5Wh9krnEe67zWTTwxY1jszHmENpxzDTDOz3YyyWIyrqLSdzihsqJFBTXWRfnS/iCVe1e5Q
 Ak8vRJTF3S2vE+PHLL0+sQVxKbceQtb6g5cstey35DcRPKLkFZDCs55tOvL2ctAdaKhloUZ/a
 Sypg6FdjiJr69zU0+agA8bpo6APyo0e0TmPVqCVTo6zqoJ2Yu0PQX3yT0Iy/dJRwO8y8HIRay
 vpv4C4/0+Vy2kUnlo0Ka7F48NQ8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 14:23, Christoph Hellwig wrote:
> There is very little extra code in recover_rbio, and a large part of it
> is the superflous extra cleanup of the bio list.  Merge the two
> functions, and only clean up the bio list after it has been added to
> but before it has been emptied again by submit_read_wait_bio_list.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 61 ++++++++++++++++-------------------------------
>   1 file changed, 21 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 666d634f0ba2c1..4e983ca8cd532c 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1940,13 +1940,25 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
>   	return ret;
>   }
>   
> -static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
> -				      struct bio_list *bio_list)
> +static int recover_rbio(struct btrfs_raid_bio *rbio)
>   {
> +	struct bio_list bio_list = BIO_EMPTY_LIST;
>   	int total_sector_nr;
>   	int ret = 0;
>   
> -	ASSERT(bio_list_size(bio_list) == 0);
> +	/*
> +	 * Either we're doing recover for a read failure or degraded write,
> +	 * caller should have set error bitmap correctly.
> +	 */
> +	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
> +
> +	/* For recovery, we need to read all sectors including P/Q. */
> +	ret = alloc_rbio_pages(rbio);
> +	if (ret < 0)
> +		return ret;
> +
> +	index_rbio_pages(rbio);
> +
>   	/*
>   	 * Read everything that hasn't failed. However this time we will
>   	 * not trust any cached sector.
> @@ -1977,47 +1989,16 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   		}
>   
>   		sector = rbio_stripe_sector(rbio, stripe, sectornr);
> -		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
> +		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
>   					 sectornr, REQ_OP_READ);
> -		if (ret < 0)
> -			goto error;
> +		if (ret < 0) {
> +			bio_list_put(&bio_list);
> +			return ret;
> +		}
>   	}
> -	return 0;
> -error:
> -	bio_list_put(bio_list);
> -	return -EIO;
> -}
> -
> -static int recover_rbio(struct btrfs_raid_bio *rbio)
> -{
> -	struct bio_list bio_list;
> -	int ret;
> -
> -	/*
> -	 * Either we're doing recover for a read failure or degraded write,
> -	 * caller should have set error bitmap correctly.
> -	 */
> -	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
> -	bio_list_init(&bio_list);
> -
> -	/* For recovery, we need to read all sectors including P/Q. */
> -	ret = alloc_rbio_pages(rbio);
> -	if (ret < 0)
> -		goto out;
> -
> -	index_rbio_pages(rbio);
> -
> -	ret = recover_assemble_read_bios(rbio, &bio_list);
> -	if (ret < 0)
> -		goto out;
>   
>   	submit_read_wait_bio_list(rbio, &bio_list);
> -
> -	ret = recover_sectors(rbio);
> -
> -out:
> -	bio_list_put(&bio_list);
> -	return ret;
> +	return recover_sectors(rbio);
>   }
>   
>   static void recover_rbio_work(struct work_struct *work)
