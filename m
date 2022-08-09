Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5D58D384
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 08:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiHIGES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 02:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiHIGER (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 02:04:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4F55B8
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 23:04:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35E5E33C53
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 06:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660025054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hQWVgOIJX5noQn0Ae1YD501+Di1GnVuAvPFPVB/jjqs=;
        b=tqRHzvYqGB4xY9kXC8eXx/TgwsS9ZbkKaUWAlXayyDC8sRalPiYMoB5N/PxctYf7ZMdNTK
        9F5NBhWPR2yKu3csQMJIcYN0aHbSyAl7dZbfgwkREAP2gFCQbZu/BJUTkF67B5ylUIkprQ
        780a+ERCt9kZyNtlFyGkBvyRmp19iNM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8640313AA1
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 06:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 61HNE9348WJTVAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Aug 2022 06:04:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/5] btrfs-progs: separate BLOCK_GROUP_TREE feature from extent-tree-v2
Date:   Tue,  9 Aug 2022 14:03:50 +0800
Message-Id: <cover.1660024949.git.wqu@suse.com>
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

[CHANGELOG]
v3:
- Add the artificial dependency for block group tree
  Now free-space-tree and no-holes must be enabled to use block group
  tree feature.
  This is for both mkfs and btrfstune.

v2:
- Add the ability to convert to bg tree using btrfstune
  Unlike the original patches years ago, which goes one transaction to
  convert the full fs to bg tree, this new method goes
  multi-transaction.

  After converting every 64 block groups, we will commit a transaction
  to avoid doing too much work in one trans.

  And the new convert will have fs_info->last_convert_bg_byter to record
  which bgs have been converted.
  This allows any bgs beyond above value to go new bg tree, while bgs
  before that threshold to go regular extent tree.

  The only concern is, the new method is pretty large in one single
  patch (+427/-27), which is not easy to review.
  I hope to get some feedback before adding the convert from bg tree
  (aka, convert from bg tree to regular extent tree).


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
- Add btrfstune support to convert from block-group-tree feature
  The infrastructure is already done.


Qu Wenruo (5):
  btrfs-progs: mkfs: dynamically modify mkfs blocks array
  btrfs-progs: don't save block group root into super block
  btrfs-progs: separate block group tree from extent tree v2
  btrfs-progs: btrfstune: add the ability to convert to block group tree
    feature
  btrfs-progs: mkfs: add artificial dependency for block group tree

 Documentation/btrfstune.rst |   5 +
 btrfstune.c                 | 148 ++++++++++++++++++++-
 check/main.c                |   8 +-
 cmds/inspect-dump-tree.c    |  11 --
 common/fsfeatures.c         |   8 ++
 common/fsfeatures.h         |   2 +
 kernel-shared/ctree.c       |   8 ++
 kernel-shared/ctree.h       |  55 ++++----
 kernel-shared/disk-io.c     | 103 +++++----------
 kernel-shared/disk-io.h     |   5 +-
 kernel-shared/extent-tree.c | 247 ++++++++++++++++++++++++++++++++++--
 kernel-shared/print-tree.c  |  11 +-
 mkfs/common.c               | 113 ++++++++++++++---
 mkfs/common.h               |  20 +--
 mkfs/main.c                 |  10 +-
 15 files changed, 578 insertions(+), 176 deletions(-)

-- 
2.37.0

