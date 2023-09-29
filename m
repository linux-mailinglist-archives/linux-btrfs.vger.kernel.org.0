Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7957B3A4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjI2S7M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 14:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjI2S7L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 14:59:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD91AA
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 11:59:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6349C1F45E;
        Fri, 29 Sep 2023 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696013948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qTZUeTz3W1foPDycmT0QAtZ9ugthoVFMZwPnUR0FK7E=;
        b=AHx/MO1omYHBuuswVlS1VRktwjui7rhX7wdMsPh43ATfRc6zBcsPzO3xu/HXBBuQk0Iicd
        zKwvLLqz0aTfsti52RxjBHoH0A5Ytjj8nJcqS4Q+/CIfUI3vD/2YSUmigB0SXtLlrq9Tt4
        sbI22ZdptLQezL+csL0UVnE/SsUjAOo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4157B2C142;
        Fri, 29 Sep 2023 18:59:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CAAF2DA832; Fri, 29 Sep 2023 20:52:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Open code btrfs_ordered_inode_tree in btrfs_inode
Date:   Fri, 29 Sep 2023 20:52:29 +0200
Message-ID: <cover.1696012550.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The structure btrfs_ordered_inode_tree can be open coded, namely to get
rid of the hole that in turn appears in btrfs_inode.

David Sterba (2):
  btrfs: open code btrfs_ordered_inode_tree in btrfs_inode
  btrfs: reorder btrfs_inode to fill gaps

 fs/btrfs/btrfs_inode.h  |  20 ++++---
 fs/btrfs/inode.c        |   8 ++-
 fs/btrfs/ordered-data.c | 122 ++++++++++++++++++----------------------
 fs/btrfs/ordered-data.h |  15 -----
 fs/btrfs/tree-log.c     |   4 +-
 5 files changed, 72 insertions(+), 97 deletions(-)

-- 
2.41.0

