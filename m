Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8182530742
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 03:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbiEWBsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 21:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiEWBsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 21:48:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD0D13FA2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 18:48:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C9AE21990;
        Mon, 23 May 2022 01:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653270531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KnzglVidsnjeMeyDqUPX/aMb/ldVwmMRTPCA85+7SHo=;
        b=hVL2rRrpqjfSMmaPZ5fxN8Vyyop6FJjINLOBs4GlKDm5XsCX5lIUV8K09jdxs/HF0MhNp6
        kPdVOq1t+bE86rcWdmxaB9alRwj5dAotFu8WD38Iq0de2Xbs9g1FyGtbDOul8cM5ty3J2N
        e449zb4ZiuHkSF+opKIuRoDUuXjMU8M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5581913ADF;
        Mon, 23 May 2022 01:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ioHYBwLoimLzOQAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 23 May 2022 01:48:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/7] btrfs: synchronous (but super simple) read-repair rework
Date:   Mon, 23 May 2022 09:48:24 +0800
Message-Id: <cover.1653270322.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

This is the initial RFC version revivied, and based on Christoph's
cleanup series.

The branch can be feteched from my repo:
https://github.com/adam900710/linux/tree/read_repair

The core idea of the revived read-repair is the following assumptions:

- Read-repair is already a cold path
- Multiple corruption in a single read is even rarer in real-world

With the above two assumption combined, we are safe to sacrifice the
read-repair performance, by going completely synchronous read-repair.
(the original code is also done sector-by-sector, but in an asynchronous
way).

Now the read-repair is done in a sector-by-sector base:

1) Try to read the next mirror (if have any)
2) Verify the csum (if any)
3) If read failed or csum mismatched, go back to 1)

All the read (from next mirror) or write (to previous bad mirror) is
done synchronously.
Which means, we will wait for the read, then also wait for the write.

This is no doubt slow, but we should be fine with that, as for corrupted
data case, the priority is on the correctness, not the performance
anymore.
Not to mention this performance penalty is only for the cold path.


The advantage of this method is, the helper, btrfs_read_repair_sector()
is less than 100 lines, straight-forward to read/maintain.
And as all later read-repair code, we get rid of
btrfs_inode::failure_io_tree completely.

And since that helper only needs to manage the content of the page,
no need to bother page status update, thus can be easily applied to any endio
context (both buffered/direct IO paths).

Unfortunately since that helper is so simple, there is no need to
introduce btrfs_read_repair_ctl structure, thus the argument list of
that helper is a little longer.

Cc: Christoph Hellwig <hch@lst.de>

Christoph Hellwig (1):
  btrfs: add a btrfs_map_bio_wait helper

Qu Wenruo (6):
  btrfs: save the original bi_iter into btrfs_bio for buffered read
  btrfs: make repair_io_failure available outside of extent_io.c
  btrfs: add new read repair infrastructure
  btrfs: use the new read repair code for buffered reads
  btrfs: use the new read repair code for direct I/O
  btrfs: remove io_failure_record infrastructure completely

 fs/btrfs/Makefile            |   2 +-
 fs/btrfs/btrfs_inode.h       |   5 -
 fs/btrfs/extent-io-tree.h    |  15 --
 fs/btrfs/extent_io.c         | 424 +++--------------------------------
 fs/btrfs/extent_io.h         |  27 +--
 fs/btrfs/inode.c             |  54 ++---
 fs/btrfs/read-repair.c       |  74 ++++++
 fs/btrfs/read-repair.h       |  13 ++
 fs/btrfs/volumes.c           |  21 ++
 fs/btrfs/volumes.h           |   2 +
 include/trace/events/btrfs.h |   1 -
 11 files changed, 164 insertions(+), 474 deletions(-)
 create mode 100644 fs/btrfs/read-repair.c
 create mode 100644 fs/btrfs/read-repair.h

-- 
2.36.1

