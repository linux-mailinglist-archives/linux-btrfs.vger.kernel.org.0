Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634376134C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 12:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJaLoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 07:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJaLoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 07:44:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43863EE30
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 04:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01763B815DD
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 11:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A38C433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216639;
        bh=UyTiJPtNpvnkeuv3VsVVKtlp+J920tjtrbZvetBtpW0=;
        h=From:To:Subject:Date:From;
        b=hggLON7RwV+EK7Gz7uGnDByMsmkjcnPzU500+y1q0R4SiaZksgQ1YI2jxdYJt8iPZ
         NGhDb34sxbk4knLZ236nzKV627sivCYt/Q71HbI2ylGUSUtHV5qyi1JbDr8gelYbtR
         6emI3gt6uo0OaLjF54gmLkZkNbwLY1g131LB9C4lUTiSIgUkYHzd+2d1HEWhnTDW23
         hpKT1Xop+KWy8JQwQNXJ5Ko5a0CW0CQMCusr3bjATxnHa9z7xXZbenEYOGCQPCdoWe
         /GpRhIW56X8vz1kJMsm0XllsbGL+GNR2ogFrFMf6uhoCuYup99voSE6jmyYRmPGNOl
         w7CrgAXpZqVog==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix direct IO writes with nowait and dsync iocb not syncing
Date:   Mon, 31 Oct 2022 11:43:54 +0000
Message-Id: <cover.1667215075.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This fixes direct IO writes with nowait and dsync not getting synced after
the writes complete (except when we fallback to blocking context). The first
patch is the fix, while the second one only updates a comment that is now
stale after 6.1-rc1.

Patch only applies to current misc-next, because a function prototype
declaration was recently moved out of ctree.h into btrfs_inode.h. I left
a version that applies cleanly against 6.0.6 and 6.1-rc at:

  https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=async_dio_fsync_fix_6.1_6.0

Filipe Manana (2):
  btrfs: fix lost file sync on direct IO write with nowait and dsync iocb
  btrfs: update stale comment for nowait direct IO writes

 fs/btrfs/btrfs_inode.h |  5 ++++-
 fs/btrfs/file.c        | 26 ++++++++++++++++++--------
 fs/btrfs/inode.c       | 14 +++++++++++---
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.35.1

