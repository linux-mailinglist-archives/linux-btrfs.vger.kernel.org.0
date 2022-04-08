Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CEE4F8FA0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiDHH3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiDHH3h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 03:29:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314C32DBFEB
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649402847;
        bh=WqppUMhfp8/Xve2XClm3nc1rz07hC9J+EjsA/LDsJ74=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TrWdlLmULcA47F4Czjjwd5bE+IdeESq17V0BZHdYt1GMLHCAGEK966DF/Lu0eEUm2
         SuBHBNM79fj1Zpc2mG5qQuwQjVtQwuRsSfzi1ph9q5ba6v5hSiwedVpo5BIy48HIk8
         wVwzfQDGQXYkqBs4RC1aOs7bVAlk0iuaixn83EA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnaof-1oJB7r062H-00jWFJ; Fri, 08
 Apr 2022 09:27:26 +0200
Message-ID: <888b0f4b-0454-fc4e-eb0b-bb047bc12b3f@gmx.com>
Date:   Fri, 8 Apr 2022 15:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 07/12] btrfs: move the call to bio_set_dev out of
 submit_stripe_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220408050839.239113-1-hch@lst.de>
 <20220408050839.239113-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220408050839.239113-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y9UsLBnY55hdXTZsSTkSoyXLLm1jXjCyEJ2kTk1GsWR9wnIXRZy
 wK0F9Fd1GAOrp+IIV8grQhF9OUZMKmLfb3N4gqrVTSwaNNvEGRjbzdMwbFCowH1jZh+Z6c1
 rcf7qXYjYGxrYHdN9Rj+TUosQrULae4VJ9iTdNg5k7EjsFiRWzqCFi9rYkKtNkBZywqDR4C
 L0Auiv+ZO+vVPC5hd5Qlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T8pOWN+Q/pM=:Jy/Gy5npEeXMLCU14dwVsm
 hJijvuZ7DtP74fmqQrEDjn9CjeyHseim4Yw+/b9HKaordUcEwHuwWSA/hFfp5XphD0kFhrHkA
 djjQr8/bp2LDrNA7gGQ4SemelUN0CJyQE8T//oRptcFpzbj0lokLzeudOV6VERU6i9ZUdO6+s
 2dYLYaayvRNdjtQo9b9I6N9vbrSOAVlDZqOZn6OqapJWoKN7034QlmCdZZu96ZUrQS+iyHrgO
 KgUQbEaGpCagYjhbPaFNrSZQrU85MbW2GEQisQUILoaa0WnXiENM+AEzHhi8qdj5lHtrXupue
 5hu8NOeitu/avax0E9t+dJWV7EFEgTkWDJ16eHfUR2fD/aDUStWNRsOBS6eyAtdOMZswA31t3
 rVFW5L+KePRnotnvjSQTDmh1lGOc+vazY7yHbcpV27AD/Nu87gTmXFjiDGS2XFoTSraltnlRk
 7vMKpta4taKfGOxatpDOGeTK/tt9GuC9xcyFAMFuWOrVZ4Rp3GYky+Up4L5ICGmikag49LPMz
 EWIHTAGkfo1VMb6PdKbYZqSAF8a8tuaKDsnr4xwQEUkrrxM3x2Val4yjYdtTad2xW3YkK2qcv
 yW1krY42u5WQnXw0bMJpCkBfkdDgyIcMVQRgZZjuU9e99IOQKnRsFlJ7FmgXPA9xHW4EtZaQG
 rfpvW9OGI06A80CeRCnlPIzOydZGaVSUD7tdeX9xE5BoadLqQNH3V3BTFYi6LFLmILISuP1Ce
 bC13GwPrz4rBsp+HHkDNK72cEcwEdM01Saq9Z2YDHAXrCoODv35nxYEiNh8zwi+4kQBW3Nd+l
 0Cl1R5mtKSYKl6koyGfU2AzDlPYn7TVXiIdQ5r0+qwsbgeTyO1GOhLS+xNxcERVXrwIme33Ls
 vXqCr9tNmNQynLksrn+H3hqLcN20OMb8NIpJP/Iwt9nCS162hrQYLMxAZByqHJnyR6+Yck4wW
 S8qorVxH626WQMZNSUg0jlukh94WPt1cN7Nu/YsMVnQpq1v3G+ZzQZM77Ut9l+4GS0pJjtJ5E
 FsPB1Zxjbs7ONpOmgcCyx5GwykCmQyC0s5ZbjkQb/0cGjinaqOH9TPvwMwLxQVWTvUZAW+C0S
 vnzb3SMvuOHYVM=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/8 13:08, Christoph Hellwig wrote:
> Prepare for additional refactoring.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The change is small enough and doesn't make much sense by itself.

Mind to fold it into the patch which needs this change?

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6b49d78d15029..8e066b9ebfbde 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6738,7 +6738,6 @@ static void submit_stripe_bio(struct btrfs_io_cont=
ext *bioc, struct bio *bio,
>   		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
>   		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
>   		dev->devid, bio->bi_iter.bi_size);
> -	bio_set_dev(bio, dev->bdev);
>
>   	btrfs_bio_counter_inc_noblocked(fs_info);
>
> @@ -6830,6 +6829,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   		else
>   			bio =3D first_bio;
>
> +		bio_set_dev(bio, dev->bdev);
>   		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
>   	}
>   	btrfs_bio_counter_dec(fs_info);
