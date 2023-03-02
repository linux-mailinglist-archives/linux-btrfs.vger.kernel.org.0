Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34476A8D10
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCBXch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCBXcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:32:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C426584A4
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:32:34 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MqJqD-1qKdNB3GR1-00nMZs; Fri, 03
 Mar 2023 00:32:27 +0100
Message-ID: <e778d8d7-0379-3abd-7976-9340fca0713c@gmx.com>
Date:   Fri, 3 Mar 2023 07:32:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 10/10] btrfs: make btrfs_split_bio work on struct
 btrfs_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-11-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VPyFFoxafO3HF+IjGA5sQ1bA0xKSr1JXxxvkBHnqjzhRJ0z7zlx
 4T5ubgR/kq5z0n0CY3VqVHX9vwpNr/pIrkBw6VmNPFL8CFzPm7cV25HaDSaabyKWWWXliHq
 zetQj+fYJUc4mu1ayBtWSiJxAPZwHSfAOjj1PtnKi/KmWFsyGNBMcK/Vl1yKTWS98SU9/vg
 XReWPvhnFsK2GlkuOQlYg==
UI-OutboundReport: notjunk:1;M01:P0:OL2+rrKrUUI=;F8IsYTA4rL6ycfKS8ioZdONRROD
 otijcEuuu65p0DISAZLsaCd03G8fxtqmes5YHikf0CiUDldSLw3nHRrfKBSVNhEgObT5T0+Tt
 SH865vmZDqGTmR/8evAETqhyLYI7H/Dr1qoWER5y12ftTPrOcMXNN3tQPnxC74+lQqqlgqF0K
 du0hLsvBtWy/R0gG0Ght+0Uq3ejEDNweANzsPmfNzZEmjZL/Zt+OLbNkyhpqgTUMkrsImgcNI
 5F2LRcjIkWi24y0NrZnj7ecvLOrf6YzipBDZAvsg2QSMmbjn2pBJnst3OFLzdeADntrHTV1aA
 9Uwn9mv9Fa3vDRVCOEXnlgRXmmaa6LgeDCyqD3mx7Gi3Tdtc/sCI5FGlaBnnOQ9sHpA6urbqF
 v42VUAOh2kNfOwHLHAqb8Y2HHety5mVoAyh+EmirSLmuuSY/68vFO29A6AFdbsuXTKxVDBXz1
 jB3QyxJSsISAKnQHZ+OmHmOoFp2fx0pv7NZ42EobWGCzsD40Kj3S9BRUM1ozXZabX0AQSxR1R
 XCi40ZSVAbzE1e4tR7NUuO0YBhIvmwUyHU/b7l+dHHfQOf52nvpDshTJoUsV4dDgqoV3WTnXL
 ttNGM7jtzkytqcII7ctnKMkTxjk3vQDLe3HNfHCBMfXMk8LnSNvCl4ulsTDdR67HMTy34Ammk
 0YMinAzp+zmSwhc0GMi6mjwaQVkoqlzZwSljwizuMPhn98gMHEBJvuZipVdCBdqACULEDeVh2
 6ZNGiV9kjx3RJxsOPNraybepgrGmrl5oVWMNAcsdHW7WIGF1707mb+J2fCLoxDTdQhqdsGUCw
 6q9cVU7eu5m0kD9akY40tlvvdgtLPU+SWdKit9QguY6SrYxIQScWlbQUhKIA3l9alCXeFkyTN
 IVKlFr6fQRr3u8JajixWqabtPY0uM7+d4gtDPgQmFUPW9ccGmo5zHu+lXg+6m7qB0EP4Q+b8i
 sC2GX0kNlvzvSGwQtrgeOarREOw=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> btrfs_split_bio expects a btrfs_bio as argument and always allocates one.
> Type both the orig_bio argument and the return value as struct btrfs_bio
> to improve type safety.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/bio.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 527081abca026f..cf09c6271edbee 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -61,30 +61,31 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
>   	return bbio;
>   }
>   
> -static struct bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
> -				   struct bio *orig, u64 map_length,
> -				   bool use_append)
> +static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
> +					 struct btrfs_bio *orig_bbio,
> +					 u64 map_length, bool use_append)
>   {
> -	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
> +	struct btrfs_bio *bbio;
>   	struct bio *bio;
>   
>   	if (use_append) {
>   		unsigned int nr_segs;
>   
> -		bio = bio_split_rw(orig, &fs_info->limits, &nr_segs,
> +		bio = bio_split_rw(&orig_bbio->bio, &fs_info->limits, &nr_segs,
>   				   &btrfs_clone_bioset, map_length);
>   	} else {
> -		bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
> -				&btrfs_clone_bioset);
> +		bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT,
> +				GFP_NOFS, &btrfs_clone_bioset);
>   	}
> -	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
> +	bbio = btrfs_bio(bio);
> +	btrfs_bio_init(bbio, orig_bbio->inode, NULL, orig_bbio);
>   
> -	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
> -	if (!(orig->bi_opf & REQ_BTRFS_ONE_ORDERED))
> +	bbio->file_offset = orig_bbio->file_offset;
> +	if (!(orig_bbio->bio.bi_opf & REQ_BTRFS_ONE_ORDERED))
>   		orig_bbio->file_offset += map_length;
>   
>   	atomic_inc(&orig_bbio->pending_ios);
> -	return bio;
> +	return bbio;
>   }
>   
>   static void btrfs_orig_write_end_io(struct bio *bio);
> @@ -633,8 +634,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   		map_length = min(map_length, fs_info->max_zone_append_size);
>   
>   	if (map_length < length) {
> -		bio = btrfs_split_bio(fs_info, bio, map_length, use_append);
> -		bbio = btrfs_bio(bio);
> +		bbio = btrfs_split_bio(fs_info, bbio, map_length, use_append);
> +		bio = &bbio->bio;
>   	}
>   
>   	/*
