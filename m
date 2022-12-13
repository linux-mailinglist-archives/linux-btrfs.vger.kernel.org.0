Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374A64B187
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiLMIve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiLMIvH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:51:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9531AD90
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:50:45 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof57-1oYN0O1yzB-00p3qF; Tue, 13
 Dec 2022 09:50:38 +0100
Message-ID: <c7473b7e-7f37-6af3-3d56-38ec430cb8d3@gmx.com>
Date:   Tue, 13 Dec 2022 16:50:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/8] btrfs: cleanup recover_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221213084123.309790-1-hch@lst.de>
 <20221213084123.309790-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221213084123.309790-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:M9O6D+B7ClCLrzI60RSEIuXKU+nFRgWX8UD8+iXRW1KKdkBRm7C
 uSTvz2QG4Q1mkZMxNz7PZeUevyv6mdkCKjNHy0V0603GswR6Ynkj8ksFhJgOEn70vOxKD7D
 WfqhbNuBjybv/t2t819AL5a99lstrspD54i1nYdVk4IHi5jlmTgxOc3JinweoQHMlmCfi/p
 uHg+TI1vc3HSJWV6nEbJA==
UI-OutboundReport: notjunk:1;M01:P0:s2MFANR6JCI=;B8MEswmaMhVkp/lX3ViAN/J2h3P
 50crX/KXxSG1DXaXx4+QiV7OL/Z2D728M3Rwpe4aARAwGkXRcpTy+IYYNa/udKAIZNAL9ODwJ
 ErkodVOadoQMCkGL37qWs/WncZUckOIYbIHs5iMoDbuuyTGRf53zxsKfrs/+dt7LvCk8R3GBo
 VFZOnPVytu2DU04gfrQTg2v0eSdWvX7QcYQ0qjfgfVdUgCW95cZgIuWIU05fdJ3UXl/fc3+co
 sAqRpZz+9RMUGZUc/tB6zV4x4mHnIWjTh16IdIznEGs7oI292/vv82xH5f2VSKDOt8cUojTV3
 Z6o1jWGf7EFSGfcvxNC+S7eannAJ/8fKdN0b24EwzKpJbM4oxwV++nXDQ5l7RDB5V/SzTyTUF
 GI4rE5fOjol8j6TLgt/pxKQGoY9N9G8e8lhLS2WvNiu0939uF5bA3Zg4nXFcYCjMS2CTAaozx
 Gdn6ghGkmqjONXXHxULk+HZy3uzVJe4xG6zrtpc3IAOpAA4KDdkd+xKOxyoFv2hhDF98bDjVM
 aTsVwbKnL5NTd0gJH7ew0QBOKFLm49tpc2m1YgX0QfL1EJHQjnj52TvIOhHMoodydZfc6xNzQ
 fSn9QS6+rioYDXKMK3oGcqbLiFivdk5RERF0kGlc3EkpZvVda/kTEpZwbN27YOBepIMZDVRNu
 cInyaDdFkWV/IC95xT3I6zZnG6NrbQRGG/HQiv6G/Nf3W5y3dkMXGz6cQlrb3oAKg30KvqbfY
 FTPL6NkeMxSiwPkDSs0N/vHBzPxx7YYI9/BNT8WjfSXhrK3P998OWxoABAajbnA9JVV78Q72v
 euCMT9BKmPTWODkj9kV4uqOvhy3PCCOSuMz4UxSQsca/FHtr/f2FZm0ML3u+QQ2RS9SIvJvJg
 jQW3UIH+RaK04r3N55T7HcK1EhIqXi9heSOppUAQ0dwfiuq0dcgirdAWTSINL7zrKjua5IHVg
 iK1ca8FETpuUzJw7NaNQ4uFYGcM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/13 16:41, Christoph Hellwig wrote:
> The bio_list is only filled by recover_assemble_read_bios when
> successful, so don't try to walk it and put the bios on any
> failure before the successful call to recover_assemble_read_bios.
> Also initialize bio_list at initialization time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index e0966126ab27a4..5dab0685e17dd5 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1987,7 +1987,7 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   
>   static int recover_rbio(struct btrfs_raid_bio *rbio)
>   {
> -	struct bio_list bio_list;
> +	struct bio_list bio_list = BIO_EMPTY_LIST;
>   	struct bio *bio;
>   	int ret;
>   
> @@ -1996,28 +1996,24 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
>   	 * caller should have set error bitmap correctly.
>   	 */
>   	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
> -	bio_list_init(&bio_list);
>   
>   	/* For recovery, we need to read all sectors including P/Q. */
>   	ret = alloc_rbio_pages(rbio);
>   	if (ret < 0)
> -		goto out;
> +		return ret;
>   
>   	index_rbio_pages(rbio);
>   
>   	ret = recover_assemble_read_bios(rbio, &bio_list);
>   	if (ret < 0)
> -		goto out;
> +		return ret;
>   
>   	submit_read_bios(rbio, &bio_list);
>   	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
>   
>   	ret = recover_sectors(rbio);
> -
> -out:
>   	while ((bio = bio_list_pop(&bio_list)))
>   		bio_put(bio);
> -
>   	return ret;
>   }
>   
