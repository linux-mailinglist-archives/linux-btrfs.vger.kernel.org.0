Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6777AB9E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjIVTRF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 15:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIVTRE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 15:17:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1029A3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 12:16:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D48F721845;
        Fri, 22 Sep 2023 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695410216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=J4Sed3zbk5M+4SqRLxe6jRcJwJG/oVkBCm5oHosjTCs=;
        b=jKR857I55eDQ7aEx22FREWag0JhSn1PnVnuAkJvw82D1YJtUE1Bk0Lo3lkUS6n1TImAGoq
        PwzIgLq0cGdPgguZNzYHvGzktLITLyMthuX13lI9XwQqiui/fBvF3O2v4/fvTDsCEzz8fg
        5G1sAHrZzcqdIfKZ4D+7MIX5ON8i6gg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B9CE32C142;
        Fri, 22 Sep 2023 19:16:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95A21DA832; Fri, 22 Sep 2023 21:10:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Siwtch to on-stack variables for block reserves
Date:   Fri, 22 Sep 2023 21:10:22 +0200
Message-ID: <cover.1695408280.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The block reserve structure is small enough to fit on stack so do that
in a few functions and avoid allocation. This in turn allows to remove
the alloc/free wrappers.

David Sterba (5):
  btrfs: use on-stack variable for block reserve in btrfs_evict_inode
  btrfs: use on-stack variable for block reserve in btrfs_truncate
  btrfs: use on-stack variable for block reserve in btrfs_replace_file_extents
  btrfs: relocation: embed block reserve to struct reloc_control
  btrfs: remove unused alloc and free helpers for block group reserves

 fs/btrfs/block-rsv.c  | 22 --------------------
 fs/btrfs/block-rsv.h  |  4 ----
 fs/btrfs/file.c       | 29 +++++++++++---------------
 fs/btrfs/inode.c      | 47 ++++++++++++++++++++-----------------------
 fs/btrfs/relocation.c | 46 +++++++++++++++++++-----------------------
 5 files changed, 55 insertions(+), 93 deletions(-)

-- 
2.41.0

