Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC76E1AE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 05:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDNDn7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 23:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjDNDns (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 23:43:48 -0400
Received: from out28-87.mail.aliyun.com (out28-87.mail.aliyun.com [115.124.28.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9E49C7
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 20:43:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06651145|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00453865-0.000305028-0.995156;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.SFn51mH_1681443820;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.SFn51mH_1681443820)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 11:43:41 +0800
Date:   Fri, 14 Apr 2023 11:43:41 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: fix btrfs_prev_leaf() to not return the same key twice
In-Reply-To: <20230414035734.6DF7.409509F4@e16-tech.com>
References: <e6eaa082d536fc5223eae4627bc7dc6369e257d9.1681295111.git.fdmanana@suse.com> <20230414035734.6DF7.409509F4@e16-tech.com>
Message-Id: <20230414114340.57ED.409509F4@e16-tech.com>
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

> Hi,
> 
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > A call to btrfs_prev_leaf() may end up returning a path that points to the
> > same item (key) again. This happens if while btrfs_prev_leaf(), after we
> > release the path, a concurrent insertion happens, which moves items off
> > from a sibbling into the front of the previous leaf, and an item with the
> > computed previous key does not exists.
> > 
> > For example, suppose we have the two following leaves:
> > 
> >   Leaf A
> > 
> >   -------------------------------------------------------------
> >   | ...   key (300 96 10)   key (300 96 15)   key (300 96 16) |
> >   -------------------------------------------------------------
> >               slot 20             slot 21             slot 22
> > 
> >   Leaf B
> > 
> >   -------------------------------------------------------------
> >   | key (300 96 20)   key (300 96 21)   key (300 96 22)   ... |
> >   -------------------------------------------------------------
> >       slot 0             slot 1             slot 2
> > 
> > If we call btrfs_prev_leaf(), from btrfs_previous_item() for example, with
> > a path pointing to leaf B and slot 0 and the following happens:
> > 
> > 1) At btrfs_prev_leaf() we compute the previous key to search as:
> >    (300 96 19), which is a key that does not exists in the tree;
> > 
> > 2) Then we call btrfs_release_path() at btrfs_prev_leaf();
> > 
> > 3) Some other task inserts a key at leaf A, that sorts before the key at
> >    slot 20, for example it has an objectid of 299. In order to make room
> >    for the new key, the key at slot 22 is moved to the front of leaf B.
> >    This happens at push_leaf_right(), called from split_leaf().
> > 
> >    After this leaf B now looks like:
> > 
> >   --------------------------------------------------------------------------------
> >   | key (300 96 16)    key (300 96 20)   key (300 96 21)   key (300 96 22)   ... |
> >   --------------------------------------------------------------------------------
> >        slot 0              slot 1             slot 2             slot 3
> > 
> > 4) At btrfs_prev_leaf() we call btrfs_search_slot() for the computed
> >    previous key: (300 96 19). Since the key does not exists,
> >    btrfs_search_slot() returns 1 and with a path pointing to leaf B
> >    and slot 1, the item with key (300 96 20);
> > 
> > 5) This makes btrfs_prev_leaf() return a path that points to slot 1 of
> >    leaf B, the same key as before it was called, since the key at slot 0
> >    of leaf B (300 96 16) is less than the computed previous key, which is
> >    (300 96 19);
> > 
> > 6) As a consequence btrfs_previous_item() returns a path that points again
> >    to the item with key (300 96 20).
> > 
> > For some users of btrfs_prev_leaf() or btrfs_previous_item() this may not
> > be functional a problem, despite not making sense to return a new path
> > pointing again to the same item/key. However for a caller such as
> > tree-log.c:log_dir_items(), this has a bad consequence, as it can result
> > in not logging some dir index deletions in case the directory is being
> > logged without holding the inode's VFS lock (logging triggered while
> > logging a child inode for example) - for the example scenario above, in
> > case the dir index keys 17, 18 and 19 were deleted in the current
> > transaction.
> 
> fstests(btrfs/080) had few frequency(<1/10) to fail after this pacth is applied.
> but it is yet not clear enough.
> 
> # cat results//btrfs/080.out.bad
> QA output created by 080
> Unexpected digest for file /mnt/scratch/20_40_30_986878191_snap/foobar_63
> (see /usr/hpc-bio/xfstests/results//btrfs/080.full for details)

fstests(btrfs/080) failure happened without this patch too.

the next info update may take some long time, because of the low reproduce
frequency.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/04/14


