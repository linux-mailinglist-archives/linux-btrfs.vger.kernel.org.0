Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC55F734F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 05:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJGDXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 23:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJGDXA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 23:23:00 -0400
Received: from out20-15.mail.aliyun.com (out20-15.mail.aliyun.com [115.124.20.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D645F82
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 20:22:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08613826|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0100076-0.00120093-0.988791;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.PVNuiHQ_1665112975;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PVNuiHQ_1665112975)
          by smtp.aliyun-inc.com;
          Fri, 07 Oct 2022 11:22:55 +0800
Date:   Fri, 07 Oct 2022 11:23:07 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>
In-Reply-To: <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
References: <cover.1664999303.git.boris@bur.io> <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
Message-Id: <20221007112306.F62D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> When doing a large fallocate, btrfs will break it up into 256MiB
> extents. Our data block groups are 1GiB, so a more natural maximum size
> is 1GiB, so that we tend to allocate and fully use block groups rather
> than fragmenting the file around.
> 
> This is especially useful if large fallocates tend to be for "round"
> amounts, which strikes me as a reasonable assumption.
> 
> While moving to size classes reduces the value of this change, it is
> also good to compare potential allocator algorithms against just 1G
> extents.


I wrote a 32G file, and the compare the result of 'xfs_io -c fiemap'.

dd conv=fsync bs=1024K count=32K if=/dev/zero of=/mnt/test/dd.txt

When write to a btrfs filesystem
+ xfs_io -c fiemap /mnt/test/dd.txt
/mnt/test/dd.txt:
        0: [0..262143]: 6883584..7145727
        1: [262144..524287]: 6367232..6629375
        2: [524288..8126463]: 7145728..14747903
        3: [8126464..8388607]: 15272064..15534207
        4: [8388608..8650751]: 14755840..15017983
        5: [8650752..16252927]: 15534208..23136383
        6: [16252928..67108863]: 23144448..74000383

When write to a xfs filesystem
+ xfs_io -c fiemap /mnt/test/dd.txt
/mnt/test/dd.txt:
        0: [0..16465919]: 256..16466175
        1: [16465920..31821623]: 16466176..31821879
        2: [31821624..41942903]: 31821880..41943159
        3: [41942904..58720111]: 47183872..63961079
        4: [58720112..67108863]: 63961080..72349831

the max of xfs is about 8G, but the max of btrfs is 
about 25G('6: [16252928..67108863]'?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/10/07



> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 45ebef8d3ea8..fd66586ae2fc 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
>  	if (trans)
>  		own_trans = false;
>  	while (num_bytes > 0) {
> -		cur_bytes = min_t(u64, num_bytes, SZ_256M);
> +		cur_bytes = min_t(u64, num_bytes, SZ_1G);
>  		cur_bytes = max(cur_bytes, min_size);
>  		/*
>  		 * If we are severely fragmented we could end up with really
> -- 
> 2.37.2


