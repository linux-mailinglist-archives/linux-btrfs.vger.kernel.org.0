Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384524D0197
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 15:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbiCGOkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 09:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbiCGOkl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 09:40:41 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9E6A07E
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 06:39:46 -0800 (PST)
Received: from localhost.localdomain (unknown [10.17.45.240])
        by synology.com (Postfix) with ESMTPA id EFFD810918BBA;
        Mon,  7 Mar 2022 22:39:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1646663985; bh=z7meuA4PvAS7hxh2KMDQk+lcmIdxZ668Z8SBX0cuXdg=;
        h=From:To:Cc:Subject:Date;
        b=AyvjKZbuLs83Q4PegNc56FqZBFtYHKSK7X7JNztLMW7wH5viyOzgxQDXnrJkKb5jr
         C/P0L1tHQf6PNgRvyc1Kjolon6Lha1qyZtjmpOqG1j1FenkApBit/SLklFoSXJvhOu
         Kdpm2azQENyKI0t6CMBaeP1pgfZ5B924MidElZ3g=
From:   ethanlien <ethanlien@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Ethan Lien <ethanlien@synology.com>
Subject: [PATCH v2] btrfs: fix qgroup reserve overflow break the qgroup limit
Date:   Mon,  7 Mar 2022 22:39:18 +0800
Message-Id: <20220307143918.28055-1-ethanlien@synology.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Ethan Lien <ethanlien@synology.com>

We use extent_changeset->bytes_changed in qgroup_reserve_data() to record
how many bytes we set for EXTENT_QGROUP_RESERVED state. Currently the
bytes_changed is set as "unsigned int", and it will overflow if we try to
fallocate a range larger than 4GiB. The result is we reserve less bytes
and eventually break the qgroup limit.

The following example test script reproduces the problem:

  $ cat qgroup-overflow.sh
  #!/bin/bash

  DEV=/dev/sdj
  MNT=/mnt/sdj

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  # Set qgroup limit to 2GiB.
  btrfs quota enable $MNT
  btrfs qgroup limit 2G $MNT

  # Try to fallocate a 3GiB file. This should fail.
  echo
  echo "Try to fallocate a 3GiB file..."
  fallocate -l 3G $MNT/3G.file

  # Try to fallocate a 5GiB file.
  echo
  echo "Try to fallocate a 5GiB file..."
  fallocate -l 5G $MNT/5G.file

  # See we break the qgroup limit.
  echo
  sync
  btrfs qgroup show -r $MNT

  umount $MNT

When running the test:

  $ ./qgroup-overflow.sh
  (...)

  Try to fallocate a 3GiB file...
  fallocate: fallocate failed: Disk quota exceeded

  Try to fallocate a 5GiB file...

  qgroupid         rfer         excl     max_rfer
  --------         ----         ----     --------
  0/5           5.00GiB      5.00GiB      2.00GiB

Since we have no control of how bytes_changed is used, it's better to
set it to u64.

Signed-off-by: Ethan Lien <ethanlien@synology.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---

V2: Correct author's name and add reviewed-by.

 fs/btrfs/extent_io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 0399cf8e3c32..151e9da5da2d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -118,7 +118,7 @@ struct btrfs_bio_ctrl {
  */
 struct extent_changeset {
 	/* How many bytes are set/cleared in this operation */
-	unsigned int bytes_changed;
+	u64 bytes_changed;
 
 	/* Changed ranges */
 	struct ulist range_changed;
-- 
2.17.1

