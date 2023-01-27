Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97E67E340
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 12:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjA0L3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 06:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjA0L3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:00 -0500
Received: from out20-26.mail.aliyun.com (out20-26.mail.aliyun.com [115.124.20.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABF338EA6
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 03:27:56 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05519245|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00899099-0.000359721-0.990649;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.R1vCw1v_1674818865;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.R1vCw1v_1674818865)
          by smtp.aliyun-inc.com;
          Fri, 27 Jan 2023 19:27:46 +0800
Date:   Fri, 27 Jan 2023 19:27:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 0/7] extent buffer dirty cleanups
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <cover.1674766637.git.josef@toxicpanda.com>
References: <cover.1674766637.git.josef@toxicpanda.com>
Message-Id: <20230127192747.9C88.409509F4@e16-tech.com>
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

> v2->v3:
> - Reworked the logic around clearing dirty on extent buffers not in our
>   transaction.  We do need this for update_ref_for_cow in some cases that I
>   didn't account for.  I've expanded the logic for this make it more idiot
>   proof, and adjusted all of the patches accordingly.

The issue reported for v2 have been fixed. Thanks a lot.

no regression have been found for these v3 patches here.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/27


> 
> v1->v2:
> - Added "btrfs: do not call btrfs_clean_tree_block in update_ref_for_cow", Qu
>   noticed some corruption with the original patchset, this turned out to be
>   because we were clearing the extent buffer dirty at cow time, which doesn't
>   make sense as we're not free'ing the current block in our current transaction.
> 
> --- Original email ---
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
> Josef Bacik (7):
>   btrfs: always lock the block before calling btrfs_clean_tree_block
>   btrfs: add trans argument to btrfs_clean_tree_block
>   btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
>   btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
>   btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
>   btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
>   btrfs: remove btrfs_wait_tree_block_writeback
> 
>  fs/btrfs/ctree.c           | 31 +++++++++++++++--------------
>  fs/btrfs/disk-io.c         | 25 +++++-------------------
>  fs/btrfs/disk-io.h         |  3 ++-
>  fs/btrfs/extent-tree.c     |  9 ++++-----
>  fs/btrfs/extent_io.c       | 23 ++++++++++++++--------
>  fs/btrfs/extent_io.h       |  5 ++++-
>  fs/btrfs/free-space-tree.c |  2 +-
>  fs/btrfs/ioctl.c           |  2 +-
>  fs/btrfs/qgroup.c          |  2 +-
>  fs/btrfs/tree-log.c        | 40 ++++++++++++++------------------------
>  10 files changed, 64 insertions(+), 78 deletions(-)
> 
> -- 
> 2.26.3


