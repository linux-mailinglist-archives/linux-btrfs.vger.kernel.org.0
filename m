Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF61D18965B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 08:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRHyr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 03:54:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgCRHyr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 03:54:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B31B5B26B
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 07:54:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/4] btrfs-progs: image: Introduce framework for more dump versions
Date:   Wed, 18 Mar 2020 15:54:31 +0800
Message-Id: <20200318075434.27258-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318075434.27258-1-wqu@suse.com>
References: <20200318075434.27258-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The original dump format only contains a @magic member to verify the
format, this means if we want to introduce new on-disk format or change
certain size limit, we can only introduce new magic as kind of version.

This patch will introduce the framework to allow multiple magic to
co-exist for further functions.

This patch will introduce the following members for each dump version.

- max_pending_size
  The threshold size for an cluster. It's not a hard limit but a soft
  one. One cluster can go larger than max_pending_size for one item, but
  next item would go to next cluster.

- magic_cpu
  The magic number in CPU endian.

- extra_sb_flags
  If the super block of this restore needs extra super block flags like
  BTRFS_SUPER_FLAG_METADUMP_V2.
  For incoming data dump feature, we don't need any extra super block
  flags.

This change also implies that all image dumps will use the same magic
for all clusters. No mixing is allowed, as we will use the first cluster
to determine the dump version.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c     | 72 ++++++++++++++++++++++++++++++++++++++++++------
 image/metadump.h | 13 +++++++--
 2 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/image/main.c b/image/main.c
index 95eb3cc3d4de..12faf5350566 100644
--- a/image/main.c
+++ b/image/main.c
@@ -44,6 +44,19 @@
 
 #define MAX_WORKER_THREADS	(32)
 
+const struct dump_version dump_versions[NR_DUMP_VERSIONS] = {
+	/*
+	 * The original format, which only supports tree blocks and
+	 * free space cache dump.
+	 */
+	{ .version = 0,
+	  .max_pending_size = SZ_256K,
+	  .magic_cpu = 0xbd5c25e27295668bULL,
+	  .extra_sb_flags = 1 }
+};
+
+const struct dump_version *current_version = &dump_versions[0];
+
 struct async_work {
 	struct list_head list;
 	struct list_head ordered;
@@ -404,7 +417,7 @@ static void meta_cluster_init(struct metadump_struct *md, u64 start)
 	md->num_items = 0;
 	md->num_ready = 0;
 	header = &md->cluster.header;
-	header->magic = cpu_to_le64(HEADER_MAGIC);
+	header->magic = cpu_to_le64(current_version->magic_cpu);
 	header->bytenr = cpu_to_le64(start);
 	header->nritems = cpu_to_le32(0);
 	header->compress = md->compress_level > 0 ?
@@ -716,7 +729,7 @@ static int add_extent(u64 start, u64 size, struct metadump_struct *md,
 {
 	int ret;
 	if (md->data != data ||
-	    md->pending_size + size > MAX_PENDING_SIZE ||
+	    md->pending_size + size > current_version->max_pending_size ||
 	    md->pending_start + md->pending_size != start) {
 		ret = flush_pending(md, 0);
 		if (ret)
@@ -1045,7 +1058,8 @@ static void update_super_old(u8 *buffer)
 	u32 sectorsize = btrfs_super_sectorsize(super);
 	u64 flags = btrfs_super_flags(super);
 
-	flags |= BTRFS_SUPER_FLAG_METADUMP;
+	if (current_version->extra_sb_flags)
+		flags |= BTRFS_SUPER_FLAG_METADUMP;
 	btrfs_set_super_flags(super, flags);
 
 	key = (struct btrfs_disk_key *)(super->sys_chunk_array);
@@ -1138,7 +1152,8 @@ static int update_super(struct mdrestore_struct *mdres, u8 *buffer)
 	if (mdres->clear_space_cache)
 		btrfs_set_super_cache_generation(super, 0);
 
-	flags |= BTRFS_SUPER_FLAG_METADUMP_V2;
+	if (current_version->extra_sb_flags)
+		flags |= BTRFS_SUPER_FLAG_METADUMP_V2;
 	btrfs_set_super_flags(super, flags);
 	btrfs_set_super_sys_array_size(super, new_array_size);
 	btrfs_set_super_num_devices(super, 1);
@@ -1326,7 +1341,7 @@ static void *restore_worker(void *data)
 	u8 *outbuf;
 	int outfd;
 	int ret;
-	int compress_size = MAX_PENDING_SIZE * 4;
+	int compress_size = current_version->max_pending_size * 4;
 
 	outfd = fileno(mdres->out);
 	buffer = malloc(compress_size);
@@ -1476,6 +1491,42 @@ static void mdrestore_destroy(struct mdrestore_struct *mdres, int num_threads)
 	pthread_mutex_destroy(&mdres->mutex);
 }
 
+static int detect_version(FILE *in)
+{
+	struct meta_cluster *cluster;
+	u8 buf[BLOCK_SIZE];
+	bool found = false;
+	int i;
+	int ret;
+
+	if (fseek(in, 0, SEEK_SET) < 0) {
+		error("seek failed: %m");
+		return -errno;
+	}
+	ret = fread(buf, BLOCK_SIZE, 1, in);
+	if (!ret) {
+		error("failed to read header");
+		return -EIO;
+	}
+
+	fseek(in, 0, SEEK_SET);
+	cluster = (struct meta_cluster *)buf;
+	for (i = 0; i < NR_DUMP_VERSIONS; i++) {
+		if (le64_to_cpu(cluster->header.magic) ==
+		    dump_versions[i].magic_cpu) {
+			found = true;
+			current_version = &dump_versions[i];
+			break;
+		}
+	}
+
+	if (!found) {
+		error("unrecognized header format");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int mdrestore_init(struct mdrestore_struct *mdres,
 			  FILE *in, FILE *out, int old_restore,
 			  int num_threads, int fixup_offset,
@@ -1483,6 +1534,9 @@ static int mdrestore_init(struct mdrestore_struct *mdres,
 {
 	int i, ret = 0;
 
+	ret = detect_version(in);
+	if (ret < 0)
+		return ret;
 	memset(mdres, 0, sizeof(*mdres));
 	pthread_cond_init(&mdres->cond, NULL);
 	pthread_mutex_init(&mdres->mutex, NULL);
@@ -1832,7 +1886,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 	u64 current_cluster = 0, bytenr;
 	u64 item_bytenr;
 	u32 bufsize, nritems, i;
-	u32 max_size = MAX_PENDING_SIZE * 2;
+	u32 max_size = current_version->max_pending_size * 2;
 	u8 *buffer, *tmp = NULL;
 	int ret = 0;
 
@@ -1885,7 +1939,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 		ret = 0;
 
 		header = &cluster->header;
-		if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+		if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 		    le64_to_cpu(header->bytenr) != current_cluster) {
 			error("bad header in metadump image");
 			ret = -EIO;
@@ -2084,7 +2138,7 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	ret = 0;
 
 	header = &cluster->header;
-	if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+	if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 	    le64_to_cpu(header->bytenr) != 0) {
 		error("bad header in metadump image");
 		return -EIO;
@@ -2592,7 +2646,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 			break;
 
 		header = &cluster->header;
-		if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+		if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 		    le64_to_cpu(header->bytenr) != bytenr) {
 			error("bad header in metadump image");
 			ret = -EIO;
diff --git a/image/metadump.h b/image/metadump.h
index f85c9bcfb813..941d4b827a24 100644
--- a/image/metadump.h
+++ b/image/metadump.h
@@ -22,8 +22,6 @@
 #include "kernel-lib/list.h"
 #include "ctree.h"
 
-#define HEADER_MAGIC		0xbd5c25e27295668bULL
-#define MAX_PENDING_SIZE	SZ_256K
 #define BLOCK_SIZE		SZ_1K
 #define BLOCK_MASK		(BLOCK_SIZE - 1)
 
@@ -33,6 +31,17 @@
 #define COMPRESS_NONE		0
 #define COMPRESS_ZLIB		1
 
+struct dump_version {
+	u64 magic_cpu;
+	int version;
+	int max_pending_size;
+	unsigned int extra_sb_flags:1;
+};
+
+#define NR_DUMP_VERSIONS	1
+extern const struct dump_version dump_versions[NR_DUMP_VERSIONS];
+const extern struct dump_version *current_version;
+
 struct meta_cluster_item {
 	__le64 bytenr;
 	__le32 size;
-- 
2.25.1

