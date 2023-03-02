Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBD6A8D00
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCBX2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCBX17 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:27:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9F2594B
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:27:42 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1pteRq1YzB-00MMhj; Fri, 03
 Mar 2023 00:27:35 +0100
Message-ID: <29c65050-4b82-6c6e-2d04-b71444b51ed9@gmx.com>
Date:   Fri, 3 Mar 2023 07:27:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/10] btrfs: pass a btrfs_bio to
 btrfs_submit_compressed_read
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6vcIpIG3fO2YV0iRpu6vMC/VhCXZ3UQHMkNX0e0K7SeuiIh6Qri
 6qjH9rSrUHab4IvUvHB2kxBGiu5hYzXf5AOocXO5gatFbDjhU5HIN+G4kJPTtvS3nGyTDcc
 5tQycQkQW921N424srrIfqznVLNC7JND68KbDX1PmqT4hMWQxiAVtawR0cZqtTfCTr2RwJb
 R+NmL4oH89NXtOIuQr4VA==
UI-OutboundReport: notjunk:1;M01:P0:ipjYYUVzqVA=;AHgYyP9wvgk2fZscEEsrKAkueM0
 OWCPeY4kVEZW+Z98302i5KZbF6N9w6o73WYKRdZevEJEgsaYqxtIByCffLj/VWcnXkAIPawI1
 IngO5ysIcEzRdh0NNYuih6l2+dEVt8EwUJD8/mckTcVQmmpiDICI3/B37Jw1IhHZ2TwEiPwy8
 UXZMtNJYydcirdG/fXeEClx4AX8vj74BPID7sRw8Z5s4cY8e97p4ENQTe7FuZ8+jFcq7k+AHe
 z6S57EIzER9cp6JSfj2JOxIVZhItTYswy1KBaYWfaOH/4q90LOYIwSSApdQTVSTMl/k+gblae
 B9BZ+TTZ6fUrUIf9LpwOu73Xo5m6+HWh3q8S9YWgHu6Iw98aMXZxQ+/E4S/362SV2+mg57+ya
 Ft9B6Sgsvs1yDo+cxrdy5ZYSgSMB+jfgkQ7D+lJKnm0FGnqsI0pDbU7A/kwuOK8/jhDR+Vr1R
 ox30H0HtnijH0/jhsUGsMbGW49XI2GmHOS0VfIiP19sbilkDydnM762k2Q0oick9lSrNuX7Oz
 JavpK6NIYnMC06n8F16NHYkLYhIw4k+q9G2PzRw5VW3cLXnE/WOD7ct17uguD2jxXXOlo2ENn
 DtklEg0lTmWjqv93JqJv8WLyG0k/Fknbo55xKO18GT3qYh1Fq0WYIsowIPiyPgUPfLSwVHTB6
 eoM8bAvHxHkk+EEvaPme5hoGUXMaTX6UIv4F8lwT8Rr37iaRNwySZsIXe3YHfJLQbqfJNTBj/
 ZJQCR60Tc830BGqJV1SecTnLakzYvUnkhShg+cuuOEKHR4n5qKm0ZlDs41mBgAXj09kgHw7/0
 lMQBslNPzuDRhp+FtGQzoa/Do1596BILXejBlIk4sy2ZPABxfzFldOkRa2TMgnXcl68xmpcST
 EtNmhkyME/6itJuxtDplpdeoXix4kmWBzlI6/1bcuxY41WD3oQsTD+00Fd6tiffuq5fWtlkmn
 tFqID6hG9aAqYZqx3YcEiAiO6QQ=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> btrfs_submit_compressed_read expects the bio passed to it to be embedded
> into a btrfs_bio structure.  Pass the btrfs_bio directly to inrease type
> safety and make the code self-documenting.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/compression.c | 16 ++++++++--------
>   fs/btrfs/compression.h |  2 +-
>   fs/btrfs/extent_io.c   |  2 +-
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 27bea05cab1a1b..c12e317e133624 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -498,15 +498,15 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>    * After the compressed pages are read, we copy the bytes into the
>    * bio we were passed and then call the bio end_io calls
>    */
> -void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
> +void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
>   {
> -	struct btrfs_inode *inode = btrfs_bio(bio)->inode;
> +	struct btrfs_inode *inode = bbio->inode;
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct extent_map_tree *em_tree = &inode->extent_tree;
>   	struct compressed_bio *cb;
>   	unsigned int compressed_len;
> -	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> -	u64 file_offset = btrfs_bio(bio)->file_offset;
> +	const u64 disk_bytenr = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> +	u64 file_offset = bbio->file_offset;
>   	u64 em_len;
>   	u64 em_start;
>   	struct extent_map *em;
> @@ -534,10 +534,10 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
>   	em_len = em->len;
>   	em_start = em->start;
>   
> -	cb->len = bio->bi_iter.bi_size;
> +	cb->len = bbio->bio.bi_iter.bi_size;
>   	cb->compressed_len = compressed_len;
>   	cb->compress_type = em->compress_type;
> -	cb->orig_bio = bio;
> +	cb->orig_bio = &bbio->bio;
>   
>   	free_extent_map(em);
>   
> @@ -558,7 +558,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
>   			 &pflags);
>   
>   	/* include any pages we added in add_ra-bio_pages */
> -	cb->len = bio->bi_iter.bi_size;
> +	cb->len = bbio->bio.bi_iter.bi_size;
>   
>   	btrfs_add_compressed_bio_pages(cb, disk_bytenr);
>   
> @@ -573,7 +573,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
>   out_free_bio:
>   	bio_put(&cb->bbio.bio);
>   out:
> -	btrfs_bio_end_io(btrfs_bio(bio), ret);
> +	btrfs_bio_end_io(bbio, ret);
>   }
>   
>   /*
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 95d2e85c6e4eea..692bafa1050e8e 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -94,7 +94,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   				  blk_opf_t write_flags,
>   				  struct cgroup_subsys_state *blkcg_css,
>   				  bool writeback);
> -void btrfs_submit_compressed_read(struct bio *bio, int mirror_num);
> +void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num);
>   
>   unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
>   
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 77de129db364c9..6ea6f2c057ac3e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -155,7 +155,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   
>   	if (btrfs_op(bio) == BTRFS_MAP_READ &&
>   	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
> -		btrfs_submit_compressed_read(bio, mirror_num);
> +		btrfs_submit_compressed_read(btrfs_bio(bio), mirror_num);
>   	else
>   		btrfs_submit_bio(btrfs_bio(bio), mirror_num);
>   
