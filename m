Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B559337273
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfFFLGq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:06:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:34890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfFFLGp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:06:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5AC3AE54
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 11:06:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] btrfs-progs: image: Introduce framework for more dump versions
Date:   Thu,  6 Jun 2019 19:06:07 +0800
Message-Id: <20190606110611.27176-6-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110611.27176-1-wqu@suse.com>
References: <20190606110611.27176-1-wqu@suse.com>
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
 image/main.c     | 80 ++++++++++++++++++++++++++++++++++++++++--------
 image/metadump.h | 13 ++++++--
 2 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/image/main.c b/image/main.c
index 0b7c8736..e8b45a1a 100644
--- a/image/main.c
+++ b/image/main.c
@@ -41,6 +41,19 @@
 
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
@@ -395,7 +408,7 @@ static void meta_cluster_init(struct metadump_struct *md, u64 start)
 	md->num_items = 0;
 	md->num_ready = 0;
 	header = &md->cluster.header;
-	header->magic = cpu_to_le64(HEADER_MAGIC);
+	header->magic = cpu_to_le64(current_version->magic_cpu);
 	header->bytenr = cpu_to_le64(start);
 	header->nritems = cpu_to_le32(0);
 	header->compress = md->compress_level > 0 ?
@@ -707,7 +720,7 @@ static int add_extent(u64 start, u64 size, struct metadump_struct *md,
 {
 	int ret;
 	if (md->data != data ||
-	    md->pending_size + size > MAX_PENDING_SIZE ||
+	    md->pending_size + size > current_version->max_pending_size ||
 	    md->pending_start + md->pending_size != start) {
 		ret = flush_pending(md, 0);
 		if (ret)
@@ -1093,7 +1106,8 @@ static void update_super_old(u8 *buffer)
 	u32 sectorsize = btrfs_super_sectorsize(super);
 	u64 flags = btrfs_super_flags(super);
 
-	flags |= BTRFS_SUPER_FLAG_METADUMP;
+	if (current_version->extra_sb_flags)
+		flags |= BTRFS_SUPER_FLAG_METADUMP;
 	btrfs_set_super_flags(super, flags);
 
 	key = (struct btrfs_disk_key *)(super->sys_chunk_array);
@@ -1186,7 +1200,8 @@ static int update_super(struct mdrestore_struct *mdres, u8 *buffer)
 	if (mdres->clear_space_cache)
 		btrfs_set_super_cache_generation(super, 0);
 
-	flags |= BTRFS_SUPER_FLAG_METADUMP_V2;
+	if (current_version->extra_sb_flags)
+		flags |= BTRFS_SUPER_FLAG_METADUMP_V2;
 	btrfs_set_super_flags(super, flags);
 	btrfs_set_super_sys_array_size(super, new_array_size);
 	btrfs_set_super_num_devices(super, 1);
@@ -1374,7 +1389,7 @@ static void *restore_worker(void *data)
 	u8 *outbuf;
 	int outfd;
 	int ret;
-	int compress_size = MAX_PENDING_SIZE * 4;
+	int compress_size = current_version->max_pending_size * 4;
 
 	outfd = fileno(mdres->out);
 	buffer = malloc(compress_size);
@@ -1523,6 +1538,42 @@ static void mdrestore_destroy(struct mdrestore_struct *mdres, int num_threads)
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
@@ -1530,6 +1581,9 @@ static int mdrestore_init(struct mdrestore_struct *mdres,
 {
 	int i, ret = 0;
 
+	ret = detect_version(in);
+	if (ret < 0)
+		return ret;
 	memset(mdres, 0, sizeof(*mdres));
 	pthread_cond_init(&mdres->cond, NULL);
 	pthread_mutex_init(&mdres->mutex, NULL);
@@ -1577,9 +1631,9 @@ static int fill_mdres_info(struct mdrestore_struct *mdres,
 		return 0;
 
 	if (mdres->compress_method == COMPRESS_ZLIB) {
-		size_t size = MAX_PENDING_SIZE * 2;
+		size_t size = current_version->max_pending_size * 2;
 
-		buffer = malloc(MAX_PENDING_SIZE * 2);
+		buffer = malloc(current_version->max_pending_size * 2);
 		if (!buffer)
 			return -ENOMEM;
 		ret = uncompress(buffer, (unsigned long *)&size,
@@ -1818,7 +1872,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 	u64 current_cluster = cluster_bytenr, bytenr;
 	u64 item_bytenr;
 	u32 bufsize, nritems, i;
-	u32 max_size = MAX_PENDING_SIZE * 2;
+	u32 max_size = current_version->max_pending_size * 2;
 	u8 *buffer, *tmp = NULL;
 	int ret = 0;
 
@@ -1874,7 +1928,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 		ret = 0;
 
 		header = &cluster->header;
-		if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+		if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 		    le64_to_cpu(header->bytenr) != current_cluster) {
 			error("bad header in metadump image");
 			ret = -EIO;
@@ -1977,7 +2031,7 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	ret = 0;
 
 	header = &cluster->header;
-	if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+	if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 	    le64_to_cpu(header->bytenr) != 0) {
 		error("bad header in metadump image");
 		return -EIO;
@@ -2018,10 +2072,10 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	}
 
 	if (mdres->compress_method == COMPRESS_ZLIB) {
-		size_t size = MAX_PENDING_SIZE * 2;
+		size_t size = current_version->max_pending_size * 2;
 		u8 *tmp;
 
-		tmp = malloc(MAX_PENDING_SIZE * 2);
+		tmp = malloc(current_version->max_pending_size * 2);
 		if (!tmp) {
 			free(buffer);
 			return -ENOMEM;
@@ -2478,7 +2532,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 			break;
 
 		header = &cluster->header;
-		if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+		if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 		    le64_to_cpu(header->bytenr) != bytenr) {
 			error("bad header in metadump image");
 			ret = -EIO;
diff --git a/image/metadump.h b/image/metadump.h
index f85c9bcf..941d4b82 100644
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
2.21.0

