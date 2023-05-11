Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF86FED63
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEKICI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 04:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEKICG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 04:02:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2772703
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 01:02:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CFE371FD81;
        Thu, 11 May 2023 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683792122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6soyiNGFQvzkXkKf+m/KkTW47rfErv5IaWOY+bMzEoI=;
        b=Z5MDzOky9CVP9uFi2nSsO73XJPKKJ7RCbMwo6iTK/U7whcZ3jjKSaQDS+XC9eR6WbvfNGD
        h3Je8fcbcw2cEe9eSoGf7DzwR/YOI5YFDaB1jcUZ0ALFFbSFH38eK+LCAvcEgT9Pslyz8w
        QMwKrYahN/HPuSzwJbtrGDrdZLrpVAc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0270E134B2;
        Thu, 11 May 2023 08:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CKjKL/mgXGRhawAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 11 May 2023 08:02:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] btrfs: handle tree backref walk error properly
Date:   Thu, 11 May 2023 16:01:44 +0800
Message-Id: <7d7e05a0148476dbf7cd8f076de1c076da68948e.1683792063.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

[BUG]
Smatch reports the following errors related to commit 3093caaa4d16
("btrfs: output affected files when relocation fails"):

	fs/btrfs/inode.c:283 print_data_reloc_error()
	error: uninitialized symbol 'ref_level'.

[CAUSE]
That part of code is mostly copied from scrub, but unfortunately scrub
code from the beginning is not doing the error handling properly.

The offending code looks like this:

	do {
		ret = tree_backref_for_extent();
		btrfs_warn_rl();
	} while (ret != 1);

There are several problems involved:

- No error handling
  If that tree_backref_for_extent() failed, we would output the same
  error again and again, never really exit as it requires ret == 1 to
  exit.

- Always do one extra output
  As tree_backref_for_extent() only return > 0 if there is no more
  backref item.
  This means after the last item we hit, we would output an invalid
  error message for ret > 0 case.

[FIX]
Fix the old code by:

- Move @ref_root and @ref_level into the if branch
  And do not initialize them, so we can catch such uninitialized values
  just like what we do in the inode.c

- Explicitly check the return value of tree_backref_for_extent()
  And handle ret < 0 and ret > 0 cases properly.

- No more do {} while () loop
  Instead go while (true) {} loop since we will handle @ret manually.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 16 ++++++++++++----
 fs/btrfs/scrub.c | 28 +++++++++++++++++-----------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4e65b2376cf3..ff449dfd9215 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -276,17 +276,25 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 		u64 ref_root;
 		u8 ref_level;
 
-		do {
+		while (true) {
 			ret = tree_backref_for_extent(&ptr, eb, &found_key, ei,
 						      item_size, &ref_root,
 						      &ref_level);
+			if (ret < 0) {
+				btrfs_warn_rl(fs_info,
+		"failed to resolve tree backref for logical %llu: %d",
+					      logical, ret);
+				break;
+			}
+			if (ret > 0)
+				break;
+
 			btrfs_warn_rl(fs_info,
 "csum error at logical %llu mirror %u: metadata %s (level %d) in tree %llu",
 				logical, mirror_num,
 				(ref_level ? "node" : "leaf"),
-				(ret < 0 ? -1 : ref_level),
-				(ret < 0 ? -1 : ref_root));
-		} while (ret != 1);
+				ref_level, ref_root);
+		}
 		btrfs_release_path(&path);
 	} else {
 		struct btrfs_backref_walk_ctx ctx = { 0 };
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 79a2a239e3f4..44005880519f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -473,11 +473,8 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	struct extent_buffer *eb;
 	struct btrfs_extent_item *ei;
 	struct scrub_warning swarn;
-	unsigned long ptr = 0;
 	u64 flags = 0;
-	u64 ref_root;
 	u32 item_size;
-	u8 ref_level = 0;
 	int ret;
 
 	/* Super block error, no need to search extent tree. */
@@ -507,19 +504,28 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	item_size = btrfs_item_size(eb, path->slots[0]);
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
-		do {
+		unsigned long ptr = 0;
+		u8 ref_level;
+		u64 ref_root;
+
+		while (true) {
 			ret = tree_backref_for_extent(&ptr, eb, &found_key, ei,
 						      item_size, &ref_root,
 						      &ref_level);
+			if (ret < 0) {
+				btrfs_warn(fs_info,
+			"failed to resolve tree backref for logical %llu: %d",
+						  swarn.logical, ret);
+				break;
+			}
+			if (ret > 0)
+				break;
 			btrfs_warn_in_rcu(fs_info,
 "%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
-				errstr, swarn.logical,
-				btrfs_dev_name(dev),
-				swarn.physical,
-				ref_level ? "node" : "leaf",
-				ret < 0 ? -1 : ref_level,
-				ret < 0 ? -1 : ref_root);
-		} while (ret != 1);
+				errstr, swarn.logical, btrfs_dev_name(dev),
+				swarn.physical, ref_level ? "node" : "leaf",
+				ref_level, ref_root);
+		}
 		btrfs_release_path(path);
 	} else {
 		struct btrfs_backref_walk_ctx ctx = { 0 };
-- 
2.40.1

