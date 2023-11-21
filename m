Return-Path: <linux-btrfs+bounces-236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BEA7F2E47
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BAE1C21967
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8B51C46;
	Tue, 21 Nov 2023 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CqUvFGEp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C8D52
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 05:27:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2F701218FA;
	Tue, 21 Nov 2023 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700573250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71Hx0MPmSbSaARuC0TKDSuxY7tEId6Hc5TLOd3qR0BM=;
	b=CqUvFGEp33AsrQr2UDbhPT6qAci85PlEjS7nsKhm2CtSMlrJRlp7GDdRAYobL8OXN96hUd
	KAD9ljxdk8sQ4FqZ65hcW6Y/9Hwm89pP/+1/bJvsELBotY535xME3kwhfoZcJfUIalVktD
	ZzvOCKjbX0RtNkcwbDYbgbS6TGoM3NE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 21C622C146;
	Tue, 21 Nov 2023 13:27:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 107F0DA86C; Tue, 21 Nov 2023 14:20:21 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: enhance extent_io_tree error reports
Date: Tue, 21 Nov 2023 14:20:21 +0100
Message-ID: <ff9391227782d4f1bf6404337e7747fd7e21e2f0.1700572232.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700572232.git.dsterba@suse.com>
References: <cover.1700572232.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [30.10 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz]
X-Spam-Score: 30.10
X-Rspamd-Queue-Id: 2F701218FA

Pass the type of the extent io tree operation which failed in the report
helper. The message wording and contents is updated, though locking
might be the cause of the error it's probably not the only one and we're
interested in the state.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 887d9beb7b10..2d564ead9dbe 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -313,10 +313,14 @@ static inline struct extent_state *tree_search(struct extent_io_tree *tree, u64
 	return tree_search_for_insert(tree, offset, NULL, NULL);
 }
 
-static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
+static void extent_io_tree_panic(const struct extent_io_tree *tree,
+				 const struct extent_state *state,
+				 const char *opname,
+				 int err)
 {
 	btrfs_panic(tree->fs_info, err,
-	"locking error: extent tree was modified by another thread while locked");
+		    "extent io tree error on %s state start %llu end %llu",
+		    opname, state->start, state->end);
 }
 
 static void merge_prev_state(struct extent_io_tree *tree, struct extent_state *state)
@@ -676,7 +680,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			goto search_again;
 		err = split_state(tree, state, prealloc, start);
 		if (err)
-			extent_io_tree_panic(tree, err);
+			extent_io_tree_panic(tree, state, "split", err);
 
 		prealloc = NULL;
 		if (err)
@@ -698,7 +702,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			goto search_again;
 		err = split_state(tree, state, prealloc, end + 1);
 		if (err)
-			extent_io_tree_panic(tree, err);
+			extent_io_tree_panic(tree, state, "split", err);
 
 		if (wake)
 			wake_up(&state->wq);
@@ -1133,7 +1137,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			goto search_again;
 		err = split_state(tree, state, prealloc, start);
 		if (err)
-			extent_io_tree_panic(tree, err);
+			extent_io_tree_panic(tree, state, "split", err);
 
 		prealloc = NULL;
 		if (err)
@@ -1181,7 +1185,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		inserted_state = insert_state(tree, prealloc, bits, changeset);
 		if (IS_ERR(inserted_state)) {
 			err = PTR_ERR(inserted_state);
-			extent_io_tree_panic(tree, err);
+			extent_io_tree_panic(tree, prealloc, "insert", err);
 		}
 
 		cache_state(inserted_state, cached_state);
@@ -1209,7 +1213,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			goto search_again;
 		err = split_state(tree, state, prealloc, end + 1);
 		if (err)
-			extent_io_tree_panic(tree, err);
+			extent_io_tree_panic(tree, state, "split", err);
 
 		set_state_bits(tree, prealloc, bits, changeset);
 		cache_state(prealloc, cached_state);
@@ -1363,7 +1367,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 		err = split_state(tree, state, prealloc, start);
 		if (err)
-			extent_io_tree_panic(tree, err);
+			extent_io_tree_panic(tree, state, "split", err);
 		prealloc = NULL;
 		if (err)
 			goto out;
@@ -1411,7 +1415,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		inserted_state = insert_state(tree, prealloc, bits, NULL);
 		if (IS_ERR(inserted_state)) {
 			err = PTR_ERR(inserted_state);
-			extent_io_tree_panic(tree, err);
+			extent_io_tree_panic(tree, prealloc, "insert", err);
 		}
 		cache_state(inserted_state, cached_state);
 		if (inserted_state == prealloc)
@@ -1434,7 +1438,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 		err = split_state(tree, state, prealloc, end + 1);
 		if (err)
-			extent_io_tree_panic(tree, err);
+			extent_io_tree_panic(tree, state, "split", err);
 
 		set_state_bits(tree, prealloc, bits, NULL);
 		cache_state(prealloc, cached_state);
-- 
2.42.1


