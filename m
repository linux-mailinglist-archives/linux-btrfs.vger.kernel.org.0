Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB91F477F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 21:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbgFITth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 15:49:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:37882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730817AbgFITth (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 15:49:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43CE1AE0F;
        Tue,  9 Jun 2020 19:49:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB1DDDA790; Tue,  9 Jun 2020 21:49:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: add little-endian optimized key helpers
Date:   Tue,  9 Jun 2020 21:49:26 +0200
Message-Id: <20200609194926.9343-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The CPU and on-disk keys are mapped to two different structures because
of the endianity. There's an intermediate buffer used to do the
conversion, but this is not necessary when CPU and on-disk endianity
matches.

Add optimized versions of helpers that take disk_key and use the buffer
directly for CPU keys or drop the intermediate buffer and conversion.

This saves a lot of stack space accross many functions and removes about
6K of generated binary code:

   text    data     bss     dec     hex filename
1090439   17468   14912 1122819  112203 pre/btrfs.ko
1084613   17456   14912 1116981  110b35 post/btrfs.ko

Delta: -5826

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 17 +++++++++++++++++
 fs/btrfs/ctree.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3a7648bff42c..de7ad39bcafd 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1501,6 +1501,22 @@ static int close_blocks(u64 blocknr, u64 other, u32 blocksize)
 	return 0;
 }
 
+#ifdef __LITTLE_ENDIAN
+
+/*
+ * Compare two keys, on little-endian the disk order is same as CPU order and
+ * we can avoid the conversion.
+ */
+static int comp_keys(const struct btrfs_disk_key *disk_key,
+		     const struct btrfs_key *k2)
+{
+	const struct btrfs_key *k1 = (const struct btrfs_key *)disk_key;
+
+	return btrfs_comp_cpu_keys(k1, k2);
+}
+
+#else
+
 /*
  * compare two keys in a memcmp fashion
  */
@@ -1513,6 +1529,7 @@ static int comp_keys(const struct btrfs_disk_key *disk,
 
 	return btrfs_comp_cpu_keys(&k1, k2);
 }
+#endif
 
 /*
  * same as comp_keys only with two btrfs_key's
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 161533040978..5aa68119122f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1894,6 +1894,52 @@ BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key,
 BTRFS_SETGET_STACK_FUNCS(disk_key_offset, struct btrfs_disk_key, offset, 64);
 BTRFS_SETGET_STACK_FUNCS(disk_key_type, struct btrfs_disk_key, type, 8);
 
+#ifdef __LITTLE_ENDIAN
+
+/*
+ * Optimized helpers for little-endian architectures where CPU and on-disk
+ * structures have the same endianity and we can skip conversions.
+ */
+
+static inline void btrfs_disk_key_to_cpu(struct btrfs_key *cpu_key,
+					 const struct btrfs_disk_key *disk_key)
+{
+	memcpy(cpu_key, disk_key, sizeof(struct btrfs_key));
+}
+
+static inline void btrfs_cpu_key_to_disk(struct btrfs_disk_key *disk_key,
+					 const struct btrfs_key *cpu_key)
+{
+	memcpy(disk_key, cpu_key, sizeof(struct btrfs_key));
+}
+
+static inline void btrfs_node_key_to_cpu(const struct extent_buffer *eb,
+					 struct btrfs_key *cpu_key, int nr)
+{
+	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
+
+	btrfs_node_key(eb, disk_key, nr);
+}
+
+static inline void btrfs_item_key_to_cpu(const struct extent_buffer *eb,
+					 struct btrfs_key *cpu_key, int nr)
+{
+	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
+
+	btrfs_item_key(eb, disk_key, nr);
+}
+
+static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
+					     const struct btrfs_dir_item *item,
+					     struct btrfs_key *cpu_key)
+{
+	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
+
+	btrfs_dir_item_key(eb, item, disk_key);
+}
+
+#else
+
 static inline void btrfs_disk_key_to_cpu(struct btrfs_key *cpu,
 					 const struct btrfs_disk_key *disk)
 {
@@ -1935,6 +1981,8 @@ static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
 	btrfs_disk_key_to_cpu(key, &disk_key);
 }
 
+#endif
+
 /* struct btrfs_header */
 BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
 BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
-- 
2.25.0

