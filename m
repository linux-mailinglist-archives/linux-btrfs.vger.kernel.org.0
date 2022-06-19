Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8788550B15
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiFSOKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiFSOKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 10:10:18 -0400
Received: from out20-99.mail.aliyun.com (out20-99.mail.aliyun.com [115.124.20.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C57B7E4
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 07:10:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436826|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.412926-0.00331062-0.583763;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.O8E3Ak._1655647811;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O8E3Ak._1655647811)
          by smtp.aliyun-inc.com;
          Sun, 19 Jun 2022 22:10:12 +0800
Date:   Sun, 19 Jun 2022 22:10:13 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: output mirror number for bad metadata
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <ae3c7264a3aefe55c64e3c6a0426289800023742.1655646447.git.wqu@suse.com>
References: <ae3c7264a3aefe55c64e3c6a0426289800023742.1655646447.git.wqu@suse.com>
Message-Id: <20220619221013.BD1C.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> When handling a real world transid mismatch image, it's hard to know
> which copy is corrupted, as the error messages just look like this:
> 
> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0

Is this case like the flowing:
metadata minor 1: updated with new data
metadata minor 2: old data
data minor 1: old data
data minor 2: old data

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/19


> We don't even know if the retry is caused by btrfs or the VFS retry.
> 
> To make things a little easier to read, this patch will add mirror
> number for all related tree block read errors.
> 
> So the above messages would look like this:
> 
>  BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 1 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>  BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 2 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>  BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 1 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>  BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 2 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..506d48b5fd7e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -220,8 +220,8 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
>  		goto out;
>  	}
>  	btrfs_err_rl(eb->fs_info,
> -		"parent transid verify failed on %llu wanted %llu found %llu",
> -			eb->start,
> +	"parent transid verify failed on %llu mirror %u wanted %llu found %llu",
> +			eb->start, eb->read_mirror,
>  			parent_transid, btrfs_header_generation(eb));
>  	ret = 1;
>  	clear_extent_buffer_uptodate(eb);
> @@ -551,21 +551,22 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>  
>  	found_start = btrfs_header_bytenr(eb);
>  	if (found_start != eb->start) {
> -		btrfs_err_rl(fs_info, "bad tree block start, want %llu have %llu",
> -			     eb->start, found_start);
> +		btrfs_err_rl(fs_info,
> +			"bad tree block start, mirror %u want %llu have %llu",
> +			     eb->read_mirror, eb->start, found_start);
>  		ret = -EIO;
>  		goto out;
>  	}
>  	if (check_tree_block_fsid(eb)) {
> -		btrfs_err_rl(fs_info, "bad fsid on block %llu",
> -			     eb->start);
> +		btrfs_err_rl(fs_info, "bad fsid on block %llu mirror %u",
> +			     eb->start, eb->read_mirror);
>  		ret = -EIO;
>  		goto out;
>  	}
>  	found_level = btrfs_header_level(eb);
>  	if (found_level >= BTRFS_MAX_LEVEL) {
> -		btrfs_err(fs_info, "bad tree block level %d on %llu",
> -			  (int)btrfs_header_level(eb), eb->start);
> +		btrfs_err(fs_info, "bad tree block mirror %u level %d on %llu",
> +			  eb->read_mirror, btrfs_header_level(eb), eb->start);
>  		ret = -EIO;
>  		goto out;
>  	}
> @@ -576,8 +577,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>  
>  	if (memcmp(result, header_csum, csum_size) != 0) {
>  		btrfs_warn_rl(fs_info,
> -	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
> -			      eb->start,
> +	"checksum verify failed on %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d",
> +			      eb->start, eb->read_mirror,
>  			      CSUM_FMT_VALUE(csum_size, header_csum),
>  			      CSUM_FMT_VALUE(csum_size, result),
>  			      btrfs_header_level(eb));
> @@ -602,8 +603,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>  		set_extent_buffer_uptodate(eb);
>  	else
>  		btrfs_err(fs_info,
> -			  "block=%llu read time tree block corruption detected",
> -			  eb->start);
> +		"block=%llu mirror %u read time tree block corruption detected",
> +			  eb->start, eb->read_mirror);
>  out:
>  	return ret;
>  }
> -- 
> 2.36.1


