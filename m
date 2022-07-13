Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A535572FD2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiGMH6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiGMH6D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 03:58:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C61DE9CE
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 00:58:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 11B511F9D1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657699081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OASxt4UCsPxo9kq7mq2O3/rE3gJzXtxCo1yahmmzJS0=;
        b=gO9HyTNzsmksMs37pF2Ps/y6b82qE1pMdj4ZldENhSbUcLVfiy+9oXnB2MmGpnG03c28vX
        YXWnOVofFjP8ZRTqUscobOUs78P+udX8TJwN6++Zmm2U1b278eyU556aPGKqHBBKem2sok
        Fk5Fay1pF+JweVslVUhfglef/P7wgXo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70FD913AAD
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:58:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VjY7Dwh7zmK/KQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:58:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: separate BLOCK_GROUP_TREE feature from extent-tree-v2
Date:   Wed, 13 Jul 2022 15:57:40 +0800
Message-Id: <cover.1657698964.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The block group tree idea is introduced to greatly reduce mount time for
large fs, over SEVERN years ago.

And 4 years ago, it's determined to let extent-tree-v2 to implement the
feature.

However extent tree v2 still doesn't have a consistent on-disk format,
nor any implementation on the real extent items, nor any tests on some
independent sub-features.

I strongly doubt if that's a correct decision, especially considering
there is really no dependency from extent tree v2 on this block group
tree feature.

Not to mention this is against the common idea on progressive
improvement.

So now is the time to revive the independent block group compat RO flag.

[CHANGE FROM EXTENT-TREE-V2]
- Don't store block group root into super block
  There is no special reason for block group root to be stored in super
  block.

- Separate block-group-tree as a compat RO flag from extent-tree-v2
  The change to extent tree is not affecting read-only opeartions.
  No reason to make it incompat.

- Fix a bug in extent-tree-v2 which doesn't initialize block group item
  correctly.
  Since we're re-using the existing block group item structure, we
  should properly initialize chunk_objectid to 256, or tree block
  will reject it.

- Dynamically arrange the mkfs_block array
  Instead a completely new array dedicated for extent-tree-v2, now we
  have proper helpers to add/delete block from the array on-the-fly.

[TODO]
- Add btrfstune support to convert to block-group-tree feature
  and back.
  This is supported in previous push, but now due to the new
  changes introduced by extent-tree-v2, I need to revisit the
  convert tool.

  And due to recent inspirations from csum conversion, I will
  go the double tree co-exist method to do the conversion,
  instead of the old one transaction conversion.

Qu Wenruo (3):
  btrfs-progs: mkfs: dynamically modify mkfs blocks array
  btrfs-progs: don't save block group root into super block
  btrfs-progs: separate block group tree from extent tree v2

 check/main.c               |   8 +--
 cmds/inspect-dump-tree.c   |  11 ----
 common/fsfeatures.c        |   8 +++
 common/fsfeatures.h        |   2 +
 kernel-shared/ctree.h      |  35 +++---------
 kernel-shared/disk-io.c    |  77 ++++++-------------------
 kernel-shared/disk-io.h    |   2 +-
 kernel-shared/print-tree.c |  11 +---
 mkfs/common.c              | 113 ++++++++++++++++++++++++++++++-------
 mkfs/common.h              |  20 +------
 mkfs/main.c                |   3 +-
 11 files changed, 138 insertions(+), 152 deletions(-)

-- 
2.37.0

