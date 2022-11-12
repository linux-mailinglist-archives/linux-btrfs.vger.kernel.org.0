Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E7626638
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Nov 2022 02:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiKLBov (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 20:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKLBou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 20:44:50 -0500
Received: from out20-75.mail.aliyun.com (out20-75.mail.aliyun.com [115.124.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772FA5B58D
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 17:44:49 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1719749|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0507037-0.000873666-0.948423;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Q5NVl5X_1668217486;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Q5NVl5X_1668217486)
          by smtp.aliyun-inc.com;
          Sat, 12 Nov 2022 09:44:47 +0800
Date:   Sat, 12 Nov 2022 09:44:50 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <cover.1668166764.git.fdmanana@suse.com>
References: <cover.1668166764.git.fdmanana@suse.com>
Message-Id: <20221112094449.D462.409509F4@e16-tech.com>
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

> From: Filipe Manana <fdmanana@suse.com>
> 
> Here follows a few more optimizations for lseek and fiemap. Starting with
> coreutils 9.0, cp no longer uses fiemap to determine where holes are in a
> file, instead it uses lseek's SEEK_HOLE and SEEK_DATA modes of operation.
> For very sparse files, or files with lot of delalloc, this can be very
> slow (when compared to ext4 or xfs). This aims to improve that.
> 
> The cp pattern is not specific to cp, it's common to iterate over all
> allocated regions of a file sequentially with SEEK_HOLE and SEEK_DATA,
> for either the whole file or just a section. Another popular program that
> does the same is tar, when using its --sparse / -S command line option
> (I use it like that for doing vm backups for example).

The case reported in *1 is huge improved. Thanks a lot.
*1 
https://lore.kernel.org/linux-btrfs/20221106073028.71F9.409509F4@e16-tech.com/

and btrfs misc-next with these patches passed fstests too.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/11/12

> The details are in the changelogs of each patch, and results are on the
> changelog of the last patch in the series. There's still much more room
> for further improvement, but that won't happen too soon as it will require
> broader changes outside the lseek and fiemap code.
> 
> Filipe Manana (9):
>   btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
>   btrfs: add an early exit when searching for delalloc range for lseek/fiemap
>   btrfs: skip unnecessary delalloc searches during lseek/fiemap
>   btrfs: search for delalloc more efficiently during lseek/fiemap
>   btrfs: remove no longer used btrfs_next_extent_map()
>   btrfs: allow passing a cached state record to count_range_bits()
>   btrfs: update stale comment for count_range_bits()
>   btrfs: use cached state when looking for delalloc ranges with fiemap
>   btrfs: use cached state when looking for delalloc ranges with lseek
> 
>  fs/btrfs/ctree.h          |   1 +
>  fs/btrfs/extent-io-tree.c |  73 +++++++++++--
>  fs/btrfs/extent-io-tree.h |  10 +-
>  fs/btrfs/extent_io.c      |  30 +++---
>  fs/btrfs/extent_map.c     |  29 -----
>  fs/btrfs/extent_map.h     |   2 -
>  fs/btrfs/file.c           | 221 ++++++++++++++++++--------------------
>  fs/btrfs/file.h           |   1 +
>  fs/btrfs/inode.c          |   2 +-
>  9 files changed, 190 insertions(+), 179 deletions(-)
> 
> -- 
> 2.35.1


