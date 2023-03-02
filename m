Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4A6A8CF5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCBXYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCBXYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:24:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C91B541
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:24:41 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEm6F-1pnVbG2L87-00GH9A; Fri, 03
 Mar 2023 00:24:34 +0100
Message-ID: <afde017a-6767-1a75-ca5a-5e0ebc083d30@gmx.com>
Date:   Fri, 3 Mar 2023 07:24:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 02/10] btrfs: cleanup
 btrfs_encoded_read_regular_fill_pages
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TPsO8NkpxgJ91nvihPx1OqmDCIyDETj0Vf8rRJeXk69/UTR1ufK
 n41Bxx2zYb31krOgrJ1nKIgk64eq5XxJurWYjXiXydRMxw6s9UfXYVRXdktbobIhT9D4YGj
 MRogN0aq2qa9BgzN50Pk5XLAlk2WIbqAOFA336h2vRHcW7Y4Yhx+bj9l4V9ZcNXx3Ekq8xD
 z3aeUmVtrex71KIubiSRA==
UI-OutboundReport: notjunk:1;M01:P0:ZXsOjRSz7fQ=;DXSx3M8hx+lBXNJpGMgdlV3+AFN
 18VBzQZP01j/EGGt3gcmUCLrRXVRLl1qcmpO8pwcJI4Z8S8uLYzRVE8gYs3CLO0wM8EsCkOCt
 ZGUQZxanltzU3S4SawlWhPILR0RUm4MiJ/80gya+LBrhSDqEglqRhhRtwSg9WKcdIfPWqsYjQ
 0u2QLGrFI1SmM2gphCNhNAtu5PlJdXDTV++NKlAjy1tdDlPSE1vM3BTC+dXQ4DDbusRgZDkEr
 +ZELFlbc4Jua4CQRdq1sHwQLrp3I/nCevsYTRHlAUGbozMnTlafODNKgS+ywCsFxbCuO77Ygl
 e+IvFdZaV4BDO2Of1HUGd9SkWWM4nEG7qeCzpKjzVUhfqesNdfq8Ic0vp3Np09Qu+YVTLpBJr
 SJGrb3xN6QCgt0HsO8+WAWdo3ibSkdh4nDxBrHqiuCyLpHBYnUZDB9LEg0os7sCH6rA3BheBQ
 x16vUcArC0emUpgl1uRd0MoY6atsLp17rp/39nyQJ4Wx1JbSBkwhsfDUBxpTBR7r2DSvO37au
 qspL+wrR5zbhWOXkyoGNMDMDkeTs8sCBI4usyUQx0lWjOOS7wkxh98a6jyKQ0WKh4bNiTx3Wx
 gUtnZK+jGNhWjIG1y6eP7rBOGxGNPNXwgl4URsWWAYA/7M/f2iYjEzZT6q/AyhpxhARJ9BSjW
 bMyVg84nh5SCG2qSCOjVvTwTLsmSDGkIvVSf/pRG5cvj+9ReRlsI9lqGXZwmnLT1qBbc3+57C
 3xT4QxZAbevJzS+WVULA61bu4B9e8YQr94enTE8tr0XkyMNSgNTUY5LoxdjKN/0PvvEiNyhQs
 +X1qCAG0SgJsb2Kkiy1j5RO/67Lv3zccJLWf8afx3gUBTBXH9GnVQ2vPmRYWRjKDMkrMMyiYC
 nXVTFP/7VE1i+PoMxsX9BuLmpqOUgrrv1fUUy7caBc6mkV4qA45KU1N6YyrZ5HKIzHG9ZJP8N
 GMg7tjcu8yUthexlAjf8qRr2mKQ=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> btrfs_encoded_read_regular_fill_pages has a pretty odd control flow.
> Unwind it so that there is a single loop over the pages array.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/inode.c | 51 ++++++++++++++++++++++--------------------------
>   1 file changed, 23 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9ad0d181c7082a..431b6082ab3d83 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9959,39 +9959,34 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>   		.pending = ATOMIC_INIT(1),
>   	};
>   	unsigned long i = 0;
> -	u64 cur = 0;
> +	struct bio *bio;
>   
>   	init_waitqueue_head(&priv.wait);
> -	/* Submit bios for the extent, splitting due to bio limits as necessary. */
> -	while (cur < disk_io_size) {
> -		struct bio *bio = NULL;
> -		u64 remaining = disk_io_size - cur;
> -
> -		while (bio || remaining) {
> -			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
> -
> -			if (!bio) {
> -				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ,
> -						      inode,
> -						      btrfs_encoded_read_endio,
> -						      &priv);
> -				bio->bi_iter.bi_sector =
> -					(disk_bytenr + cur) >> SECTOR_SHIFT;
> -			}
>   
> -			if (!bytes ||
> -			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
> -				atomic_inc(&priv.pending);
> -				btrfs_submit_bio(bio, 0);
> -				bio = NULL;
> -				continue;
> -			}
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
> +			      btrfs_encoded_read_endio, &priv);
> +	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;

Can't we even merge the bio allocation into the main loop?

Maybe something like this instead?

struct bio *bio = NULL;

while (cur < len) {
	if (!bio) {
		bio = btrfs_io_alloc();
		bio->bi_iter.bi_sector = (cur + orig_disk_bytenr) >>
					 SECTOR_SHIFT;
	}
	if (bio_add_page() < bytes) {
		btrfs_submit_bio();
		bio = NULL;
	}
	cur += bytes;
}

Thanks,
Qu
>   
> -			i++;
> -			cur += bytes;
> -			remaining -= bytes;
> +	do {
> +		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
> +
> +		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
> +			atomic_inc(&priv.pending);
> +			btrfs_submit_bio(bio, 0);
> +
> +			bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
> +					      btrfs_encoded_read_endio, &priv);
> +			bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
> +			continue;
>   		}
> -	}
> +
> +		i++;
> +		disk_bytenr += bytes;
> +		disk_io_size -= bytes;
> +	} while (disk_io_size);
> +
> +	atomic_inc(&priv.pending);
> +	btrfs_submit_bio(bio, 0);
>   
>   	if (atomic_dec_return(&priv.pending))
>   		io_wait_event(priv.wait, !atomic_read(&priv.pending));
