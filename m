Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8FC58A586
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 06:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiHEEwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 00:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiHEEwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 00:52:44 -0400
Received: from out20-121.mail.aliyun.com (out20-121.mail.aliyun.com [115.124.20.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3DD70E63;
        Thu,  4 Aug 2022 21:52:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04580928|-1;BR=01201311R151S70rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.122182-0.012713-0.865105;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.OmW8XrT_1659675149;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OmW8XrT_1659675149)
          by smtp.aliyun-inc.com;
          Fri, 05 Aug 2022 12:52:30 +0800
Date:   Fri, 05 Aug 2022 12:52:32 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: fiemap is slow on btrfs on files with multiple extents
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Chen Liang-Chun <featherclc@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        kernel@openvz.org,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        Yu Kuai <yukuai3@huawei.com>, Theodore Ts'o <tytso@mit.edu>
In-Reply-To: <YuwUw2JLKtIa9X+S@localhost.localdomain>
References: <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com> <YuwUw2JLKtIa9X+S@localhost.localdomain>
Message-Id: <20220805125231.9327.409509F4@e16-tech.com>
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

> On Thu, Aug 04, 2022 at 07:30:52PM +0300, Pavel Tikhomirov wrote:
> > I ran the below test on Fedora 36 (the test basically creates "very" sparse
> > file, with 4k data followed by 4k hole again and again for the specified
> > length and uses fiemap to count extents in this file) and face the problem
> > that fiemap hangs for too long (for instance comparing to ext4 version).
> > Fiemap with 32768 extents takes ~37264 us and with 65536 extents it takes
> > ~34123954 us, which is x1000 times more when file only increased twice the
> > size:
> >
> 
> Ah that was helpful, thank you.  I think I've spotted the problem, please give
> this a whirl to make sure we're seeing the same thing.  Thanks,
> 
> Josef

This patch improve the performance very well, but  it seems to break
xfstest generic/285.

xfstest generic/285:
06.11 SEEK_HOLE expected 8192 or 16384, got 8191.                 FAIL
06.12 SEEK_DATA expected 8191 or 8191, got 12288.                 FAIL
06.23 SEEK_HOLE expected 16384 or 16384, got 16383.               FAIL
06.24 SEEK_DATA expected 16383 or 16383, got -1.                  FAIL

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/05


>  
> From 1133d5ebf952ebf334bc7be21a575b1f52eb71d4 Mon Sep 17 00:00:00 2001
> Message-Id: <1133d5ebf952ebf334bc7be21a575b1f52eb71d4.1659638886.git.josef@toxicpanda.com>
> From: Josef Bacik <josef@toxicpanda.com>
> Date: Thu, 4 Aug 2022 14:45:53 -0400
> Subject: [PATCH] btrfs: don't search entire range for delalloc with fiemap
> 
> For the case where we have
> 
> [EXTENT1][HOLE][EXTENT2]
> 
> If we fiemap from [HOLE] we will search to len (which could be -1) to
> see if there's any delalloc extents in the range, however in the above
> case btrfs_get_extent() returns a hole em for just the range of the
> hole, as it will find EXTENT2, so all we need to do is search for
> delalloc in the hole range, not the entire rest of the requested fiemap
> range.
> 
> This fixes the extremely bad fiemap performance with very large sparse
> files.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8fc1e3b6e00c..b7ad8f7a7b53 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7095,7 +7095,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
>  		hole_em = em;
>  
>  	/* check to see if we've wrapped (len == -1 or similar) */
> -	end = start + len;
> +	end = em->start + em->len;
>  	if (end < start)
>  		end = (u64)-1;
>  	else
> -- 
> 2.36.1


