Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A308435695
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 01:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJTXrX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 19:47:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48270 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhJTXrW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 19:47:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8739E219D0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 23:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634773505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oBIww42GiiCQgzlr+E0qzDBl4M7vvrL3sQdLcWMP6xw=;
        b=gXazMhOrRWBS6SYz07oS5934LWfi8YsBeRG1N9g1B5+H9mrDL2yRdzYS8nMYDOiNJE89uB
        k7OGN2067mcrvJAkjmeQjB9daHXO7PUXvE0B9HYs+p5RGJIXhn8VeEVVaipU6Co/fQvuuj
        4ZHfzlk9Do+vm4q+NDb+8zCIzH4N7MQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C87FC13EAE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 23:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FCjIIgCqcGHMaQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 23:45:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: make sizeof(struct btrfs_super_block) to match BTRFS_SUPER_INFO_SIZE
Date:   Thu, 21 Oct 2021 07:44:47 +0800
Message-Id: <20211020234447.5578-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's a common practice to avoid use sizeof(struct btrfs_super_block)
(3531), but to use BTRFS_SUPER_INFO_SIZE (4096).

The problem is that, sizeof(struct btrfs_super_block) doesn't match
BTRFS_SUPER_INFO_SIZE from the very beginning.

Furthermore, for all call sites except selftest, we always allocate
BTRFS_SUPER_INFO_SIZE space for btrfs super block, there isn't any real
reason to use the smaller value, and it doesn't really save any space.

So let's get rid of such confusing behavior, and unify those two values.

This modification also adds a new static_assert() to verify the size,
and moves the BTRFS_SUPER_INFO_* macros to the definition of
btrfs_super_block for the static_assert().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use static_assert() instead of BUILD_BUG_ON()
---
 fs/btrfs/ctree.h   | 8 ++++++++
 fs/btrfs/disk-io.h | 3 ---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 140126898577..73ffffd54bdc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -218,6 +218,9 @@ struct btrfs_root_backup {
 	u8 unused_8[10];
 } __attribute__ ((__packed__));
 
+#define BTRFS_SUPER_INFO_OFFSET SZ_64K
+#define BTRFS_SUPER_INFO_SIZE 4096
+
 /*
  * the super block basically lists the main trees of the FS
  * it currently lacks any block count etc etc
@@ -270,8 +273,13 @@ struct btrfs_super_block {
 	__le64 reserved[28];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
+
+	/* Padded to 4096 bytes */
+	u8 padding[565];
 } __attribute__ ((__packed__));
 
+static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
+
 /*
  * Compat flags that we support.  If any incompat flags are set other than the
  * ones specified below then we will fail to mount
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 1d3b749c405a..a2b5db4ba262 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -6,9 +6,6 @@
 #ifndef BTRFS_DISK_IO_H
 #define BTRFS_DISK_IO_H
 
-#define BTRFS_SUPER_INFO_OFFSET SZ_64K
-#define BTRFS_SUPER_INFO_SIZE 4096
-
 #define BTRFS_SUPER_MIRROR_MAX	 3
 #define BTRFS_SUPER_MIRROR_SHIFT 12
 
-- 
2.33.0

