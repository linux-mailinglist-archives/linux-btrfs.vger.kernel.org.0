Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1136CFBE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjC3GsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjC3GsE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:48:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44414EFE
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:47:49 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGiJ-1pqt2W3cWZ-00RIwD; Thu, 30
 Mar 2023 08:47:40 +0200
Message-ID: <25e42693-0311-5fd0-7642-9da3e780937b@gmx.com>
Date:   Thu, 30 Mar 2023 14:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/21] btrfs: remove the mirror_num argument to
 btrfs_submit_compressed_read
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230330063059.1574380-1-hch@lst.de>
 <20230330063059.1574380-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230330063059.1574380-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:242PvlsxfAJISnRi9IPtJLo69xT9094KMJ3zKBCzSqDZhm0hlPQ
 cbSmEXeLMkPK9f+J1RY5FgqbRW8bU4fnw7P7tWYQ/HdFNP/vc7J43MIxhtQU7ggBzf5q1k7
 XN8a9dgFLXhdI1/tVfSaN61fgz6VUF7hpNyqaVV29IvkJFgFd+VJUnb8czkYQl9ihsd1y7y
 QSUZBWRS4GIbg1C8O6cOg==
UI-OutboundReport: notjunk:1;M01:P0:+f2wOJkj4zA=;i3jYBC6jJGPyHlo36byyf5GNJ+E
 vbUytrk3p91VkptEMnIHQCqTJSPIV7omepucDJsTGLksjdo8L6PXUwmPAYfYYfcGo/g3/ZU0j
 YINffwsKiDMU11epYj79X5g8QujKfxb2xeuovd/++Ix+C25VsT21ylZfhhVtq51Hyk9mWTj30
 JqIw0AVZ2XVr5CBd0aiyKBVJcT7K2r2Md74AXGVEj2hgFoG3SbNqD1GGASaeDDfw6FKQTJvq9
 bQGYPhhKfv6Y6RO4Hxh7+dcWl3wnu2Nawsrx18SqwoR4b9AHuXON46YM3nTwbq3NyCnYgYsl7
 JS3AymapLGd7Yv9EzEPBTMKBf57T6SvwJRXv+2f6qDY/qrmKTk2Wc4E9D3qdsk46iHjrzWTwi
 1YpbjxfKoX7BnOLwI6KipoO8fmLdL0QiaP/DJXql2ZyfALHwiyvvsFtSpzm+ZWMCp76GAgj6x
 gyrZ1E2TRhz4RIiKzJLbbQ/JpLmV32tFtouTF0BaLtwWf7lpwqC6Yp7Ryy28dLt7PA0FCgX79
 mKcPdon/kAACynvo87zLqI7Nm00v2V246G6a8JdJCccB7AGaJvcjHdd1Qs1lXX3GKqs6xBcbK
 64ETxqwmQnChWk95nNFTqBkzbvoJOoJ58Kmy5J9GTmU75qG37NhR3AsgXqFaXCTJNY347x/2T
 Lp5SMEPCAqlXwjmv2K+Z1KOMdSiXnKWT2oBp7Fmo3wgSXh5xsFuNblU9J3RA4qYTMruYo4Nze
 RIeFhHtHgg69Q9fdSX3+d5pa3BEaXhduedX2I9yFlbm3ll5PLR2CjIK21O7tkYx6C4wib6NJ1
 h7azLo44EPWJvzkPnK4KFwLIxgnglQLfs+ZQcUxfAI5rVkFVC0UIUSJ607iDbHO08ee8uAg5k
 /QR7J+qgzjV61REgBI56YjIzsjyxUDh6BXzWYox4a0DHeziVRDdBOeYOa5Gm3ZUTIu+dZ41OT
 jzxiB5OzHiFwmAAhhRK1qLx7IcQ=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/30 14:30, Christoph Hellwig wrote:
> Given that read recovery for data I/O is handled in the storage layer,
> the mirror_num argument to btrfs_submit_compressed_read is always 0,
> so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/compression.c | 4 ++--
>   fs/btrfs/compression.h | 2 +-
>   fs/btrfs/extent_io.c   | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 44c4276741ceda..8ca152164c11bf 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -479,7 +479,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>    * After the compressed pages are read, we copy the bytes into the
>    * bio we were passed and then call the bio end_io calls
>    */
> -void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
> +void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
>   {
>   	struct btrfs_inode *inode = bbio->inode;
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> @@ -545,7 +545,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
>   	if (memstall)
>   		psi_memstall_leave(&pflags);
>   
> -	btrfs_submit_bio(&cb->bbio, mirror_num);
> +	btrfs_submit_bio(&cb->bbio, 0);
>   	return;
>   
>   out_free_compressed_pages:
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 5d5146e72a860b..8ba8e62b096061 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -94,7 +94,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   				  blk_opf_t write_flags,
>   				  struct cgroup_subsys_state *blkcg_css,
>   				  bool writeback);
> -void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num);
> +void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
>   
>   unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
>   
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8e709b44fa57ec..4d412efe32c6b2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -126,7 +126,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   
>   	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
>   	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
> -		btrfs_submit_compressed_read(bbio, 0);
> +		btrfs_submit_compressed_read(bbio);
>   	else
>   		btrfs_submit_bio(bbio, 0);
>   
