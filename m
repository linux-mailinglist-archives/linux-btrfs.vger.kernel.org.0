Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5E5A9856
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIANUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiIANTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9083B7
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 655F761F2C
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4253CC433C1
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038313;
        bh=CaTRoAGdxuyTV73femupXs/4+p+n+/o2FLfikKhjR74=;
        h=From:To:Subject:Date:From;
        b=KQAT2BTkJbSx6LbUg11Ysi749qK/tJfdBUte7TkgTRwqEg1xR7FoAePydXPpKDdy7
         yMB0sZkGBBcxqHcZ4oQ+d22pOtyaDTqp3ITTikK7DA4afL6sHAY7bLRbsCltF1DeS1
         P3Jpjdq6Dm/NIQxrvRqSkpVSITM4SY6vDJZ99NCLnFaRxPvJ3fqC06O/NGnREJXAvg
         wWvNdaNL92MusAcC4A5Fjl21VxiohVZvSgYsefL546tcxZz4dxXTD3SUM7wNrJZ/wk
         bJDQUNSymf7Kt/HMhe25wPZ358YrHwZ0mEV6v2q6D+NfAqdZL45OzHBb15lIYI6BdH
         /OciXl5YxEp0A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/10] btrfs: make lseek and fiemap much more efficient
Date:   Thu,  1 Sep 2022 14:18:20 +0100
Message-Id: <cover.1662022922.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We often get reports of fiemap and hole/data seeking (lseek) being too slow
on btrfs, or even unusable in some cases due to being extremely slow.

Some recent reports for fiemap:

    https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
    https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/

For lseek (LSF/MM from 2017):

   https://lwn.net/Articles/718805/

Basically both are slow due to very high algorithmic complexity which
scales badly with the number of extents in a file and the heigth of
subvolume and extent b+trees.

Using Pavel's test case (first Link tag for fiemap), which uses files with
many 4K extents and holes before and after each extent (kind of a worst
case scenario), the speedup is of several orders of magnitude (for the 1G
file, from ~225 seconds down to ~0.1 seconds).

Finally the new algorithm for fiemap also ends up solving a bug with the
current algorithm. This happens because we are currently relying on extent
maps to report extents, which can be merged, and this may cause us to
report 2 different extents as a single one that is not shared but one of
them is shared (or the other way around). More details on this on patches
9/10 and 10/10.

Patches 1/10 and 2/10 are for lseek, introducing some code that will later
be used by fiemap too (patch 10/10). More details in the changelogs.

There are a few more things that can be done to speedup fiemap and lseek,
but I'll leave those other optimizations I have in mind for some other time.

Filipe Manana (10):
  btrfs: allow hole and data seeking to be interruptible
  btrfs: make hole and data seeking a lot more efficient
  btrfs: remove check for impossible block start for an extent map at fiemap
  btrfs: remove zero length check when entering fiemap
  btrfs: properly flush delalloc when entering fiemap
  btrfs: allow fiemap to be interruptible
  btrfs: rename btrfs_check_shared() to a more descriptive name
  btrfs: speedup checking for extent sharedness during fiemap
  btrfs: skip unnecessary extent buffer sharedness checks during fiemap
  btrfs: make fiemap more efficient and accurate reporting extent sharedness

 fs/btrfs/backref.c     | 153 ++++++++-
 fs/btrfs/backref.h     |  20 +-
 fs/btrfs/ctree.h       |  22 +-
 fs/btrfs/extent-tree.c |  10 +-
 fs/btrfs/extent_io.c   | 703 ++++++++++++++++++++++++++++-------------
 fs/btrfs/file.c        | 439 +++++++++++++++++++++++--
 fs/btrfs/inode.c       | 146 ++-------
 7 files changed, 1111 insertions(+), 382 deletions(-)

-- 
2.35.1

