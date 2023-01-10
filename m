Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ABC6643CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjAJO5R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbjAJO4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:56:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F2725C3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67805B816C6
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397AFC433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362604;
        bh=6XqJgVXRGhc5h/V7+oO1GmFghc5iz6x10/Zilqk85qM=;
        h=From:To:Subject:Date:From;
        b=JJPAWD3oJvty9C6MeFz34mB/ixd0s/OP71p0VWVTX3heROEWnyKmvigFJPEHcnY3j
         cceNYDI/uvVuNDt6ZZwa2fpXY423Uc08HGm426FJq+ECXkGGtK+qA78LgBzhwgdK14
         I99vzcl1HnIQv8ZujmJHdBwoUsMQGl5Y4/cuheaEHsNPRQewcuanBGtQ+RIdIE9Oxl
         1kmTs6fMsw/4i6eSCJZ17UqneA5RGfukQdMi3bBqfuj9ODD3FnOQBk7gULzNM5fDdd
         tFCzeYnQV897rReQgCOkCikJbCbSGfc8qD0Vl4au0RWvSde1FcxKPM27rO0hdy4vcZ
         v82CDktcXIU1Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: some log tree fixes and cleanups
Date:   Tue, 10 Jan 2023 14:56:33 +0000
Message-Id: <cover.1673361215.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some fixes mostly around directory logging and some cleanups (the last
three patches).

Filipe Manana (8):
  btrfs: fix missing error handling when logging directory items
  btrfs: fix directory logging due to race with concurrent index key deletion
  btrfs: add missing setup of log for full commit at add_conflicting_inode()
  btrfs: do not abort transaction on failure to write log tree when syncing log
  btrfs: do not abort transaction on failure to update log root
  btrfs: simplify update of last_dir_index_offset when logging a directory
  btrfs: use a negative value for BTRFS_LOG_FORCE_COMMIT
  btrfs: use a single variable to track return value for log_dir_items()

 fs/btrfs/disk-io.c  |  9 ++++-
 fs/btrfs/tree-log.c | 91 ++++++++++++++++++++++++++++-----------------
 fs/btrfs/tree-log.h | 11 ++++--
 3 files changed, 71 insertions(+), 40 deletions(-)

-- 
2.35.1

