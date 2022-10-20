Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE86260667B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJTQ7g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJTQ7e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:59:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361303A6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:59:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F24F822B31;
        Thu, 20 Oct 2022 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666285166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=20qdQcmDdRiCtJTuVMtLZtq7taFndBIdA8O7QbPtpuA=;
        b=t51y6EhiYTQLTj/pym1Y3vjqtXpZm7XR0qsL3ZID5spqHad5yP7YrPH6hw/1s3UjXYMgN0
        X3gcShIbbKlzvoQuShRdl1lHwMssVUzbFaJsSOiSb6nNtVOvVjSsT5ik3HvjebcOF03JxM
        mI51QxSh1que/tY72WAL2u8ktzgOz/4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E99382C141;
        Thu, 20 Oct 2022 16:59:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28C94DA79B; Thu, 20 Oct 2022 18:59:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/4] Parameter cleanup
Date:   Thu, 20 Oct 2022 18:59:16 +0200
Message-Id: <cover.1666285085.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few more cases where value passed by parameter can be used directly.

v2:
- move related code from patch 2 to patch 1

David Sterba (4):
  btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
  btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
  btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
  btrfs: sink gfp_t parameter to alloc_scrub_sector

 fs/btrfs/backref.c    |  5 ++---
 fs/btrfs/backref.h    |  3 +--
 fs/btrfs/qgroup.c     | 17 +++++++----------
 fs/btrfs/qgroup.h     |  2 +-
 fs/btrfs/relocation.c |  2 +-
 fs/btrfs/scrub.c      | 14 +++++++-------
 fs/btrfs/tree-log.c   |  3 +--
 7 files changed, 20 insertions(+), 26 deletions(-)

-- 
2.37.3

