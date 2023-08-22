Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFF783AB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 09:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjHVHRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjHVHRG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 03:17:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F81125
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 00:16:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 072A4206BF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692688524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2FtS8WbBOa6B3VnFG8EDJbJnZfpfrpRkTRO3ZjU3lQ=;
        b=emU7QhEw0nQIPuJpLAo+noGRxUOMx1yknDyzbC/AicoVv0AG/33t+TQXZ/KKFvms+0J/jV
        UXnLIGSYdNYX7le3ltvWIn3jSIpr+dK94fpbsFwKUK1Zl4oLmstYWZiWwGsydFlphUzH5b
        +N5UGA0VFYCldUt0PmzViqBcdGjlICM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C0A613919
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kC33CYtg5GSDTwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: tune: allow --csum to rebuild csum tree
Date:   Tue, 22 Aug 2023 15:15:17 +0800
Message-ID: <8e131b9f8d812938261aa18e1c7374927abcc3a7.1692688214.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692688214.git.wqu@suse.com>
References: <cover.1692688214.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Currently "btrfs check --init-csum-tree" goes a very tricky way to
rebuild csum tree, by wiping the csum tree root and let the extent tree
repair code to handle the remaining part of the old csum tree.

We already have a report that such method has caused data corruption on
a seemingly fine btrfs (the report ran "btrfs check --readonly" first,
which has no error reported).

[ENHANCEMENT]
On the other hand, we have a new experimental feature, "btrfstune
--csum", which would go a much safer way to convert data csum, by
inserting new data csum items using the new csum type, then replace the
old csum items with the new ones.

This is way safer, and we have even tested the interrupted cases of such
conversion, and if the fs is fine in the first place, we won't rely on
extent tree repair code at all.

This patch would:

- Fix the spelling of check_csum_change_requirement()

- Remove the csum type check in check_csum_change_requirement()

- Do not verify data csum if we're rebuilding using the same csum type
  As we may want to rebuilt the csum tree to fix the csum mismatch.

  This would require a new flag, VERIFY_SKIP_CSUM for
  read_verify_one_data_sector().

- Skip metadata csum rewrite completely if csum type matches

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 35 +++++++++++++++++++++++++----------
 tune/main.c        |  3 ++-
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index e7bc22526fd1..b5e70c9e4f80 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -76,12 +76,6 @@ static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info, u16 new_
 		error("running dev-replace detected, please finish or cancel it.");
 		return -EINVAL;
 	}
-
-	if (fs_info->csum_type == new_csum_type) {
-		error("the fs is already using csum type %s (%u)",
-		      btrfs_super_csum_name(new_csum_type), new_csum_type);
-		return -EINVAL;
-	}
 	return 0;
 }
 
@@ -120,13 +114,18 @@ static int get_last_csum_bytenr(struct btrfs_fs_info *fs_info, u64 *result)
 	return 0;
 }
 
+#define VERIFY_OUTPUT_ERROR	(1 << 0)
+#define VERIFY_SKIP_CSUM	(1 << 1)
+
 static int read_verify_one_data_sector(struct btrfs_fs_info *fs_info,
 				       u64 logical, void *data_buf,
 				       const void *old_csums, u16 old_csum_type,
-				       bool output_error)
+				       unsigned int flags)
 {
 	const u32 sectorsize = fs_info->sectorsize;
 	int num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
+	const bool output_error = flags & VERIFY_OUTPUT_ERROR;
+	const bool skip_csum = flags & VERIFY_SKIP_CSUM;
 	bool found_good = false;
 
 	for (int mirror = 1; mirror <= num_copies; mirror++) {
@@ -141,6 +140,11 @@ static int read_verify_one_data_sector(struct btrfs_fs_info *fs_info,
 			error("failed to read logical %llu: %m", logical);
 			continue;
 		}
+		if (skip_csum) {
+			found_good = true;
+			break;
+		}
+
 		btrfs_csum_data(fs_info, fs_info->csum_type, data_buf, csum_has,
 				sectorsize);
 		if (memcmp(csum_has, old_csums, fs_info->csum_size) == 0) {
@@ -169,16 +173,20 @@ static int generate_new_csum_range(struct btrfs_trans_handle *trans,
 	const u32 sectorsize = fs_info->sectorsize;
 	int ret = 0;
 	void *buf;
+	unsigned int flags = VERIFY_OUTPUT_ERROR;
 
 	buf = malloc(fs_info->sectorsize);
 	if (!buf)
 		return -ENOMEM;
 
+	/* We're rebuilding the csum tree, no need to verify the old data csum. */
+	if (fs_info->csum_type == new_csum_type)
+		flags |= VERIFY_SKIP_CSUM;
+
 	for (u64 cur = logical; cur < logical + length; cur += sectorsize) {
 		ret = read_verify_one_data_sector(fs_info, cur, buf, old_csums +
 				(cur - logical) / sectorsize * fs_info->csum_size,
-				fs_info->csum_type, true);
-
+				fs_info->csum_type, flags);
 		if (ret < 0) {
 			error("failed to recover a good copy for data at logical %llu",
 			      logical);
@@ -565,6 +573,13 @@ static int change_meta_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 		error("failed to update super flags: %m");
 	}
 
+	/*
+	 * The new csum type matches the old one, it's to rebuild data csum.
+	 * No need to change metadata csum.
+	 */
+	if (fs_info->csum_type == new_csum_type)
+		goto out;
+
 	/*
 	 * Disable metadata csum checks first, as we may hit tree blocks with
 	 * either old or new csums.
@@ -811,7 +826,7 @@ static int determine_csum_type(struct btrfs_fs_info *fs_info, u64 logical,
 	if (!buf)
 		return -ENOMEM;
 	ret = read_verify_one_data_sector(fs_info, logical, buf, csum_expected,
-					  csum_type, false);
+					  csum_type, 0);
 	if (ret < 0)
 		ret = 1;
 	free(buf);
diff --git a/tune/main.c b/tune/main.c
index 73d09c34a897..b611d3171918 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -121,7 +121,8 @@ static const char * const tune_usage[] = {
 #if EXPERIMENTAL
 	"",
 	"EXPERIMENTAL FEATURES:",
-	OPTLINE("--csum CSUM", "switch checksum for data and metadata to CSUM"),
+	OPTLINE("--csum CSUM", "switch checksum for data and metadata to CSUM, "
+			"would only rebuild csum tree if CSUM is the same as the existing one"),
 #endif
 	NULL
 };
-- 
2.41.0

