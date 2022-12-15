Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205FC64D5ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 05:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLOEib (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 23:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLOEi1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 23:38:27 -0500
Received: from out20-26.mail.aliyun.com (out20-26.mail.aliyun.com [115.124.20.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313446655
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 20:38:24 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05934439|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0130029-0.000482287-0.986515;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.QW98zuh_1671079101;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QW98zuh_1671079101)
          by smtp.aliyun-inc.com;
          Thu, 15 Dec 2022 12:38:22 +0800
Date:   Thu, 15 Dec 2022 12:38:23 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 0/8] extent buffer dirty cleanups
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
References: <cover.1670451918.git.josef@toxicpanda.com>
Message-Id: <20221215123822.CF28.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> Hello,
> 
> While sync'ing ctree.c to btrfs-progs I noticed we have some oddities when it
> comes to how we deal with the extent buffer being dirty.  We have
> btrfs_clean_tree_block, which is sort of meant to be run against extent buffers
> we've modified in this transaction.  However we have some other places where
> we've open coded the same work without the generation check.  This makes it kind
> of confusing, and is inconsistent with how we deal with the
> fs_info->dirty_metadata_bytes.
> 
> So clean this stuff up so we have one helper we use for setting the extent
> buffer dirty (btrfs_mark_buffer_dirty) and one for clearing dirty
> (btrfs_clear_buffer_dirty).  This makes everything more consistent and clean
> across the board.  I've additionally cleaned up a random writeback thing we had
> in tree-log that I noticed while doing these cleanups.  Thanks,
> 
> Josef
> 
> Josef Bacik (8):
>   btrfs: always lock the block before calling btrfs_clean_tree_block
>   btrfs: do not check header generation in btrfs_clean_tree_block
>   btrfs: do not set the header generation before btrfs_clean_tree_block
>   btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
>   btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
>   btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
>   btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
>   btrfs: remove btrfs_wait_tree_block_writeback

xfstests result with/without these patches.
with the patches [1-8]	btrfs/066 btrfs/072 btrfs/074 failed
with the patches [1-5]	btrfs/066 btrfs/072 btrfs/074 failed
without the patches 	OK. no failure.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/12/15

>  fs/btrfs/ctree.c           | 16 +++++++--------
>  fs/btrfs/disk-io.c         | 25 +++++-------------------
>  fs/btrfs/disk-io.h         |  2 +-
>  fs/btrfs/extent-tree.c     | 12 ++++--------
>  fs/btrfs/extent_io.c       | 18 +++++++++--------
>  fs/btrfs/extent_io.h       |  2 +-
>  fs/btrfs/free-space-tree.c |  2 +-
>  fs/btrfs/ioctl.c           |  2 +-
>  fs/btrfs/qgroup.c          |  2 +-
>  fs/btrfs/tree-log.c        | 40 ++++++++++++++------------------------
>  10 files changed, 47 insertions(+), 74 deletions(-)
> 
> -- 
> 2.26.3


