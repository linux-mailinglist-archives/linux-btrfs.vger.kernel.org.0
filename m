Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB955F77CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 14:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJGMD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 08:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGMD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 08:03:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011CD57E0
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 05:03:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D7FD1F8A3
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 12:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665144202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/D/XjRlSbw4vRhSXdP8Rwdz4JILE3qKWYpNd8HjIqLg=;
        b=gVBhrjnW7hP6ZyQa/QHBqj8KszigomzMB4MhO33rJ13qbBxy3W5KzkdHsUf758Ob8BNbpr
        q/u/WFeeSd8YW/yauY6MaLHg/unY5cVujZTwmIuezZEYNHtvIyot5qEkvkCwGwCy/BP5e3
        y0KP72U/hOEDQGF/4o8LxSrLNFE7X/M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE34013A3D
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 12:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id APcOHYkVQGPeUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Oct 2022 12:03:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: mkfs: fix a stack over-flow when features string are too long
Date:   Fri,  7 Oct 2022 20:03:01 +0800
Message-Id: <d6a5f3dd13a8f2b4d0b1e2e4e20c4ff28e055346.1665143843.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665143843.git.wqu@suse.com>
References: <cover.1665143843.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Even with chunk_objectid bug fixed, mkfs.btrfs can still caused stack
overflow when enabling extent-tree-v2 feature (need experimental
features enabled):

  # ./mkfs.btrfs  -f -O extent-tree-v2 ~/test.img
  btrfs-progs v5.19.1
  See http://btrfs.wiki.kernel.org for more information.

  ERROR: superblock magic doesn't match
  NOTE: several default settings have changed in version 5.15, please make sure
        this does not affect your deployments:
        - DUP for metadata (-m dup)
        - enabled no-holes (-O no-holes)
        - enabled free-space-tree (-R free-space-tree)

  Label:              (null)
  UUID:               205c61e7-f58e-4e8f-9dc2-38724f5c554b
  Node size:          16384
  Sector size:        4096
  Filesystem size:    512.00MiB
  Block group profiles:
    Data:             single            8.00MiB
    Metadata:         DUP              32.00MiB
    System:           DUP               8.00MiB
  SSD detected:       no
  Zoned device:       no
  =================================================================
  [... Skip full ASAN output ...]
  ==65655==ABORTING

[CAUSE]
For experimental build, we have unified feature output, but the old
buffer size is only 64 bytes, which is too small to cover the new full
feature string:

  extref, skinny-metadata, no-holes, free-space-tree, block-group-tree, extent-tree-v2

Above feature string is already 84 bytes, over the 64 on-stack memory
size.

This can also be proved by the ASAN output:

  ==65655==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffc4e03b1d0 at pc 0x7ff0fc05fafe bp 0x7ffc4e03ac60 sp 0x7ffc4e03a408
  WRITE of size 17 at 0x7ffc4e03b1d0 thread T0
      #0 0x7ff0fc05fafd in __interceptor_strcat /usr/src/debug/gcc/libsanitizer/asan/asan_interceptors.cpp:377
      #1 0x55cdb7b06ca5 in parse_features_to_string common/fsfeatures.c:316
      #2 0x55cdb7b06ce1 in btrfs_parse_fs_features_to_string common/fsfeatures.c:324
      #3 0x55cdb7a37226 in main mkfs/main.c:1783
      #4 0x7ff0fbe3c28f  (/usr/lib/libc.so.6+0x2328f)
      #5 0x7ff0fbe3c349 in __libc_start_main (/usr/lib/libc.so.6+0x23349)
      #6 0x55cdb7a2cb34 in _start ../sysdeps/x86_64/start.S:115

[FIX]
Introduce a new macro, BTRFS_FEATURE_STRING_BUF_SIZE, along with a new
sanity check helper, btrfs_assert_feature_buf_size().

The problem is I can not find a build time method to verify
BTRFS_FEATURE_STRING_BUF_SIZE is large enough to contain all feature
names, thus have to go the runtime function to do the BUG_ON() to verify
the macro size.

Now the minimal buffer size for experimental build is 138 bytes, just
bump it to 160 for future expansion.

And if further features go beyond that number, mkfs.btrfs/btrfs-convert
will immediately crash at that BUG_ON(), so we can definitely detect it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 26 ++++++++++++++++++++++++++
 common/fsfeatures.h |  7 +++++++
 convert/main.c      |  3 ++-
 mkfs/main.c         |  3 ++-
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index dc4b346c040a..e4334e3ea6c0 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -251,6 +251,32 @@ static const struct btrfs_feature runtime_features[] = {
 	}
 };
 
+/*
+ * This is a sanity check to make sure BTRFS_FEATURE_STRING_BUF_SIZE is large
+ * enough to contain all strings.
+ *
+ * All callers using btrfs_parse_*_features_to_string() should call this first.
+ */
+void btrfs_assert_feature_buf_size(void)
+{
+	int total_size = 0;
+	int i;
+
+	/*
+	 * This is a little over-calculated, as we include ", list-all".
+	 * But 10 extra bytes should not be a big deal.
+	 */
+	for (i = 0; i < ARRAY_SIZE(mkfs_features); i++)
+		/* The extra 2 bytes are for the ", " prefix. */
+		total_size += strlen(mkfs_features[i].name) + 2;
+	BUG_ON(BTRFS_FEATURE_STRING_BUF_SIZE < total_size);
+
+	total_size = 0;
+	for (i = 0; i < ARRAY_SIZE(runtime_features); i++)
+		total_size += strlen(runtime_features[i].name) + 2;
+	BUG_ON(BTRFS_FEATURE_STRING_BUF_SIZE < total_size);
+}
+
 static size_t get_feature_array_size(enum feature_source source)
 {
 	if (source == FS_FEATURES)
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 3b5a915c6012..c4ab704862cd 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -37,6 +37,12 @@ struct btrfs_mkfs_features {
 #define BTRFS_FEATURE_RUNTIME_QUOTA		(1ULL << 0)
 #define BTRFS_FEATURE_RUNTIME_LIST_ALL		(1ULL << 1)
 
+/*
+ * Such buffer size should be able to contain all feature string, with extra
+ * ", " for each feature.
+ */
+#define BTRFS_FEATURE_STRING_BUF_SIZE		(160)
+
 static const struct btrfs_mkfs_features btrfs_mkfs_default_features = {
 	.compat_ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
 			   BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
@@ -86,5 +92,6 @@ int btrfs_check_sectorsize(u32 sectorsize);
 int btrfs_check_features(const struct btrfs_mkfs_features *features,
 			 const struct btrfs_mkfs_features *allowed);
 int btrfs_tree_search2_ioctl_supported(int fd);
+void btrfs_assert_feature_buf_size(void);
 
 #endif
diff --git a/convert/main.c b/convert/main.c
index 6bcb0f4876d0..c7be19f4e9bd 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1147,7 +1147,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	struct btrfs_key key;
 	char subvol_name[SOURCE_FS_NAME_LEN + 8];
 	struct task_ctx ctx;
-	char features_buf[64];
+	char features_buf[BTRFS_FEATURE_STRING_BUF_SIZE];
 	char fsid_str[BTRFS_UUID_UNPARSED_SIZE];
 	struct btrfs_mkfs_config mkfs_cfg;
 	bool btrfs_sb_committed = false;
@@ -1835,6 +1835,7 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 	char fsid[BTRFS_UUID_UNPARSED_SIZE] = {0};
 
 	crc32c_optimization_init();
+	btrfs_assert_feature_buf_size();
 	printf("btrfs-convert from %s\n\n", PACKAGE_STRING);
 
 	while(1) {
diff --git a/mkfs/main.c b/mkfs/main.c
index e5c1aa669828..c4a4e1986f9b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1028,6 +1028,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	crc32c_optimization_init();
 	btrfs_config_init();
+	btrfs_assert_feature_buf_size();
 
 	while(1) {
 		int c;
@@ -1750,7 +1751,7 @@ raid_groups:
 		}
 	}
 	if (bconf.verbose) {
-		char features_buf[64];
+		char features_buf[BTRFS_FEATURE_STRING_BUF_SIZE];
 
 		update_chunk_allocation(fs_info, &allocation);
 		printf("Label:              %s\n", label);
-- 
2.37.3

