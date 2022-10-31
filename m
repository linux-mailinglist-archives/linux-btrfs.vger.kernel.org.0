Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A0613E4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 20:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJaTd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaTd4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 15:33:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83813D2C
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 12:33:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9CB0022279;
        Mon, 31 Oct 2022 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667244834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4rUPSxxVNOnNcy0i68fyla6GunlA7KWgv36Yzn99pd8=;
        b=dbT+nW65wTZ8PpCln7Xhmo/1/PLnZU4zWI/qOt6s9vQG2u42v2diX/0FzpDW+1uaiKA6pZ
        2hNw7kz+0rlxX6LbgnF7f1BXN2vu+78cR3NLVby/jMUSueDE+0dOKU7F5JFpy6cdimuY5Z
        ZB0AYuEptq+Nj7nlcv1JPOIBdq21c+E=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 900D02C141;
        Mon, 31 Oct 2022 19:33:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 518AEDA79D; Mon, 31 Oct 2022 20:33:38 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Minor cleanups
Date:   Mon, 31 Oct 2022 20:33:37 +0100
Message-Id: <cover.1667244567.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few random cleanups or fixups.

David Sterba (4):
  btrfs: zlib: use copy_page for full page copy
  btrfs: zoned: use helper to check a power of two zone size
  btrfs: convert btrfs_block_group::needs_free_space to runtime flag
  btrfs: convert btrfs_block_group::seq_zone to runtime flag

 fs/btrfs/block-group.c                 |  2 +-
 fs/btrfs/block-group.h                 | 13 ++++---------
 fs/btrfs/free-space-tree.c             | 10 +++++-----
 fs/btrfs/tests/free-space-tree-tests.c |  2 +-
 fs/btrfs/zlib.c                        |  4 ++--
 fs/btrfs/zoned.c                       | 10 +++++-----
 6 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.37.3

