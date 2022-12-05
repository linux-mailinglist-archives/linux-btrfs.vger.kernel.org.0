Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C766422E5
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 07:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiLEGHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 01:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEGHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 01:07:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B166637A
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Dec 2022 22:07:51 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 246E21FE2A
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 06:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670220470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CzKJbrfTn4hkRxALs/wxac4x8jTMSNtVqXVVuSMeVgQ=;
        b=GEijP0vGZ5zddESONFcqCGIn+ZyIWE5P/EzgxIKkM6PEkwNIv9PQ10B1D3buXdy+lRVXBS
        SNUWsoVyvrC+Qi/MUUgAuZJF1Q9OLMQ7rmcEmZJdvJFtG1cUFKtYr22JlVVDn7WU6M0xKG
        qQcJztTcxmlytj5rCxh2ljMO6lIURmA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 571D41348F
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 06:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2F+VBrWKjWOcfgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Dec 2022 06:07:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check: enhance the error output for backref mimsatch
Date:   Mon,  5 Dec 2022 14:07:30 +0800
Message-Id: <1ecdbc90c7cc26f7f5b7a0af7683cf81717b6200.1670220414.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Btrfs check original mode output is not that reader friendly already, it
even includes pointer output:

  backref 15353727729664 parent 1140559929556992 not referenced back 0xc9133d70
  tree backref 15353727729664 parent 14660022714368 not found in extent tree
  incorrect global backref count on 15353727729664 found 3 wanted 2
  backpointer mismatch on [15353727729664 16384]

In above case, the "0xc9133d70" is completely useless, as it's a pointer
for the tree_backref structure.

And the term "backref" is quite abused in above case.

[ENHANCEMENT]
To enhance the situation, let's use some output format from lowmem mode
instead.

Now above example will be changed to:

  tree extent[15353727729664, 16384] parent 1140559929556992 has no tree block found
  tree extent[15353727729664, 16384] parent 14660022714368 has no backref item in extent tree
  incorrect global backref count on 15353727729664 found 3 wanted 2
  backpointer mismatch on [15353727729664 16384]

And some example for data backrefs:

  data extent[12845056, 1048576] bytenr mimsmatch, extent item bytenr 12845056 file item bytenr 0
  data extent[12845056, 1048576] referencer count mismatch (root 5 owner 257 offset 0) wanted 1 have 0

  data extent[14233600, 12288] referencer count mismatch (parent 42139648) wanted 0 have 1
  data extent[14233600, 12288] referencer count mismatch (root 5 owner 307 offset 0) wanted 0 have 1
  data extent[14233600, 12288] referencer count mismatch (parent 30507008) wanted 0 have 1

Furthermore, the original function print_tree_backref_error() is a mess
already, here we clean it up by exacting all the error output into a
dedicated helper, print_backref_error(), so the function itself only
need to find out errors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 163 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 109 insertions(+), 54 deletions(-)

diff --git a/check/main.c b/check/main.c
index 0483a119b8bc..f1c056bc966c 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3991,10 +3991,115 @@ static int do_check_fs_roots(struct cache_tree *root_cache)
 	return ret;
 }
 
+/*
+ * Define the minimal size for a buffer to describe the data backref.
+ * It needs to support something like:
+ *   root <U64_MAX> owner <U64_MAX> offset <U64_MAX>
+ * Or
+ *   parent <U64_MAX>
+ *
+ * Obviously the first pattern needs longer buffer size.
+ * The minimal size (including the tailing NUL) would be:
+ *  5 + 20 + 7 + 20 + 8 + 20 = 80.
+ *
+ * Just round it to 128 to provide extra wiggle room.
+ */
+#define DATA_EXTENT_DESC_BUF_LEN (128)
+static void describe_data_extent_backref(char *buf,
+					 struct data_backref *dback)
+{
+	if (dback->node.full_backref)
+		sprintf(buf, "parent %llu", dback->parent);
+	else
+		sprintf(buf, "root %llu owner %llu offset %llu",
+			dback->root, dback->owner, dback->offset);
+}
+
+static void print_data_backref_error(struct extent_record *rec,
+				     struct data_backref *dback)
+{
+	struct extent_backref *back = &dback->node;
+	char desc[DATA_EXTENT_DESC_BUF_LEN] = { 0 };
+	u32 found_refs;
+	u32 expected_refs;
+
+	if (!back->found_extent_tree) {
+		/*
+		 * No backref item in extent tree.
+		 * Thus expected refs should be 0.
+		 */
+		expected_refs = 0;
+		found_refs = dback->found_ref;
+	} else {
+		expected_refs = dback->num_refs;
+		found_refs = dback->found_ref;
+	}
+
+	/* Extent item bytenr mismatch with found file extent item. */
+	if (dback->disk_bytenr != rec->start)
+		fprintf(stderr,
+"data extent[%llu, %llu] bytenr mimsmatch, extent item bytenr %llu file item bytenr %llu\n",
+			rec->start, rec->max_size, rec->start,
+			dback->disk_bytenr);
+
+	/* Extent item size mismatch with found file item. */
+	if (dback->bytes != rec->nr)
+		fprintf(stderr,
+"data extent[%llu, %llu] size mimsmatch, extent item size %llu file item size %llu\n",
+			rec->start, rec->max_size, rec->nr, dback->bytes);
+
+	if (expected_refs != found_refs) {
+		describe_data_extent_backref(desc, dback);
+		fprintf(stderr,
+"data extent[%llu, %llu] referencer count mismatch (%s) wanted %u have %u\n",
+			rec->start, rec->max_size, desc, expected_refs,
+			found_refs);
+	}
+}
+
+static void print_tree_backref_error(struct extent_record *rec,
+				     struct tree_backref *tback)
+{
+	struct extent_backref *back = &tback->node;
+
+	/*
+	 * For tree blocks, we only handle two cases here:
+	 * - No backref item in extent tree
+	 * - No tree block found (but with backref item)
+	 *
+	 * The refs count check is done by the global backref check at
+	 * all_backpointers_checked().
+	 */
+	if (!back->found_extent_tree) {
+		fprintf(stderr,
+"tree extent[%llu, %llu] %s %llu has no backref item in extent tree\n",
+			rec->start, rec->max_size,
+			back->full_backref ? "parent" : "root",
+			back->full_backref ? tback->parent : tback->root);
+		return;
+	}
+	if (!back->found_ref) {
+		fprintf(stderr,
+"tree extent[%llu, %llu] %s %llu has no tree block found\n",
+			rec->start, rec->max_size,
+			back->full_backref ? "parent" : "root",
+			back->full_backref ? tback->parent : tback->root);
+		return;
+	}
+}
+
+static void print_backref_error(struct extent_record *rec,
+				struct extent_backref *back)
+{
+	if (back->is_data)
+		print_data_backref_error(rec, to_data_backref(back));
+	else
+		print_tree_backref_error(rec, to_tree_backref(back));
+}
+
 static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 {
 	struct extent_backref *back, *tmp;
-	struct tree_backref *tback;
 	struct data_backref *dback;
 	u64 found = 0;
 	int err = 0;
@@ -4005,42 +4110,11 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 			err = 1;
 			if (!print_errs)
 				goto out;
-			if (back->is_data) {
-				dback = to_data_backref(back);
-				fprintf(stderr,
-"data backref %llu %s %llu owner %llu offset %llu num_refs %lu not found in extent tree\n",
-					(unsigned long long)rec->start,
-					back->full_backref ?
-					"parent" : "root",
-					back->full_backref ?
-					(unsigned long long)dback->parent :
-					(unsigned long long)dback->root,
-					(unsigned long long)dback->owner,
-					(unsigned long long)dback->offset,
-					(unsigned long)dback->num_refs);
-			} else {
-				tback = to_tree_backref(back);
-				fprintf(stderr,
-"tree backref %llu %s %llu not found in extent tree\n",
-					(unsigned long long)rec->start,
-					back->full_backref ? "parent" : "root",
-					back->full_backref ?
-					(unsigned long long)tback->parent :
-					(unsigned long long)tback->root);
-			}
 		}
-		if (!back->is_data && !back->found_ref) {
+		if (!back->found_ref) {
 			err = 1;
 			if (!print_errs)
 				goto out;
-			tback = to_tree_backref(back);
-			fprintf(stderr,
-				"backref %llu %s %llu not referenced back %p\n",
-				(unsigned long long)rec->start,
-				back->full_backref ? "parent" : "root",
-				back->full_backref ?
-				(unsigned long long)tback->parent :
-				(unsigned long long)tback->root, back);
 		}
 		if (back->is_data) {
 			dback = to_data_backref(back);
@@ -4048,38 +4122,17 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 				err = 1;
 				if (!print_errs)
 					goto out;
-				fprintf(stderr,
-"incorrect local backref count on %llu %s %llu owner %llu offset %llu found %u wanted %u back %p\n",
-					(unsigned long long)rec->start,
-					back->full_backref ?
-					"parent" : "root",
-					back->full_backref ?
-					(unsigned long long)dback->parent :
-					(unsigned long long)dback->root,
-					(unsigned long long)dback->owner,
-					(unsigned long long)dback->offset,
-					dback->found_ref, dback->num_refs,
-					back);
 			}
 			if (dback->disk_bytenr != rec->start) {
 				err = 1;
 				if (!print_errs)
 					goto out;
-				fprintf(stderr,
-"backref disk bytenr does not match extent record, bytenr=%llu, ref bytenr=%llu\n",
-					(unsigned long long)rec->start,
-					(unsigned long long)dback->disk_bytenr);
 			}
 
 			if (dback->bytes != rec->nr) {
 				err = 1;
 				if (!print_errs)
 					goto out;
-				fprintf(stderr,
-"backref bytes do not match extent backref, bytenr=%llu, ref bytes=%llu, backref bytes=%llu\n",
-					(unsigned long long)rec->start,
-					(unsigned long long)rec->nr,
-					(unsigned long long)dback->bytes);
 			}
 		}
 		if (!back->is_data) {
@@ -4088,6 +4141,8 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 			dback = to_data_backref(back);
 			found += dback->found_ref;
 		}
+		if (err)
+			print_backref_error(rec, back);
 	}
 	if (found != rec->refs) {
 		err = 1;
-- 
2.38.1

