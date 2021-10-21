Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A16435859
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 03:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJUBm6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 21:42:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhJUBmz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 21:42:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0130B1FD57
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634780440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUSlxd5pUiSEv6Qkekrh9f7qm+vB6HuuwFRlusr9PQg=;
        b=lntBzI3gh+E9NDwTVz1fvT3aD5lc6jCbGK+cJA6vSQzxiFrfo5qOvskzIkx+fPxJE4elHW
        eMmkFRVogiEXH0c/FFZDyIhTO4p6zuT7V9RdsyeYx9lqCJC5ZtrZ+J8Hh1t4Z4QgGBbTH3
        2BJcuVKy06qdxvL8IinXk30OMllc9l0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C96B13F8A
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +M+CBRfFcGFYIQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: unify sizeof(struct btrfs_super_block) and BTRFS_SUPER_INFO_SIZE
Date:   Thu, 21 Oct 2021 09:40:18 +0800
Message-Id: <20211021014020.482242-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211021014020.482242-1-wqu@suse.com>
References: <20211021014020.482242-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just like kernel change, pad struct btrfs_super_block to 4096 bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.h   | 7 +++++++
 kernel-shared/disk-io.h | 3 ---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 563ea50b3587..6451690ce4fa 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -406,6 +406,9 @@ struct btrfs_root_backup {
 	u8 unused_8[10];
 } __attribute__ ((__packed__));
 
+#define BTRFS_SUPER_INFO_OFFSET SZ_64K
+#define BTRFS_SUPER_INFO_SIZE 4096
+
 /*
  * the super block basically lists the main trees of the FS
  * it currently lacks any block count etc etc
@@ -456,8 +459,12 @@ struct btrfs_super_block {
 	__le64 reserved[28];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
+	/* Padded to 4096 bytes */
+	u8 padding[565];
 } __attribute__ ((__packed__));
 
+static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
+
 /*
  * Compat flags that we support.  If any incompat flags are set other than the
  * ones specified below then we will fail to mount
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index e113d842c906..823e5af37e75 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -23,9 +23,6 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-lib/sizes.h"
 
-#define BTRFS_SUPER_INFO_OFFSET SZ_64K
-#define BTRFS_SUPER_INFO_SIZE 4096
-
 #define BTRFS_SUPER_MIRROR_MAX	 3
 #define BTRFS_SUPER_MIRROR_SHIFT 12
 
-- 
2.33.0

