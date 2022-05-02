Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D25176B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiEBSpo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiEBSpj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 14:45:39 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3ED85FA6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 11:42:09 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 5AC8D319A7C; Mon,  2 May 2022 14:42:04 -0400 (EDT)
Date:   Mon, 2 May 2022 14:42:04 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: misc-next 6a43055c266e: assertion failed: ret != -EEXIST, in
 fs/btrfs/tree-log.c:3857
Message-ID: <YnAl/JlVTQcBurTI@hungrycats.org>
References: <YmyefE9mc2xl5ZMz@hungrycats.org>
 <Ym+jpt5VmKwicgEf@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym+jpt5VmKwicgEf@debian9.Home>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 02, 2022 at 10:25:58AM +0100, Filipe Manana wrote:
> On Fri, Apr 29, 2022 at 10:27:08PM -0400, Zygo Blaxell wrote:
> > Running my usual "run everything at once" test...
> > 
> > 	assertion failed: ret != -EEXIST, in fs/btrfs/tree-log.c:3857
> > 	[198255.980839][ T7460] ------------[ cut here ]------------
> > 	[198255.981666][ T7460] kernel BUG at fs/btrfs/ctree.h:3617!
> > 	[198255.983141][ T7460] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > 	[198255.984080][ T7460] CPU: 0 PID: 7460 Comm: repro-ghost-dir Not tainted 5.18.0-5314c78ac373-misc-next+ #159 9f66820f9a8b6f20d808b7fbd7aaeab2c04eefe1
> 
> This is a bit confusing, the subject mentions 6a43055c266e, but here
> we see 5314c78ac373 and 9f66820f9a8b6f20d808b7fbd7aaeab2c04eefe1.

6a43055c266e from the subject line is the misc-next commit for btrfs.

5314c78ac373 from the kernel log is the git commit of the test kernel.
It's the misc-next tree with a commit on top to record the build
configuration.

9f66820f9a8b6f20d808b7fbd7aaeab2c04eefe1 is the GCC build ID for
debuginfod lookup, which would have been really convenient if it had
existed years ago when I had to roll my own infrastructure for mapping
kernel version strings back to specific build metadata.

> >    3847                         if (key.offset > *last_old_dentry_offset + 1) {
> >    3848                                 ret = insert_dir_log_key(trans, log, dst_path,
> >    3849                                                  ino, *last_old_dentry_offset + 1,
> >    3850                                                  key.offset - 1);
> >    3851                                 /*
> >    3852                                  * -EEXIST should never happen because when we
> >    3853                                  * log a directory in full mode (LOG_INODE_ALL)
> >    3854                                  * we drop all BTRFS_DIR_LOG_INDEX_KEY keys from
> >    3855                                  * the log tree.
> >    3856                                  */
> >   >3857<                                ASSERT(ret != -EEXIST);
> 
> It can actually happen, there's a harmless race between logging a directory
> and inserting items from other inodes into a subvolume's tree that can result
> in an attempt to log the same BTRFS_DIR_LOG_INDEX_KEY twice.
> 
> I'll fix that and send a patch soon.
> Thanks.

Cool.  Thanks!

> >    3858                                 if (ret < 0)
> >    3859                                         return ret;
> >    3860                         }
> > 
