Return-Path: <linux-btrfs+bounces-22110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAFPBimwomnk4wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22110-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 10:06:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A51C195D
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 10:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E49E5303DA15
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBEA3EFD12;
	Sat, 28 Feb 2026 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/ZcHzDq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633F3EF0DA
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269603; cv=none; b=ik96ey/tqypGSt2pJPCGMCYJLB1jLZ8mciAVvIrWkO+xhj225cmVu4MZrGDuOOxzBes6qpaEpd1U2cvEOPeI53AsrmnDLCm/66iPihoY49TCmemuQjJogni0+wTzcvFjjCzpZH8qkb2ST9WBDEANuVpHyr+Fnu5A5SDxoMss0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269603; c=relaxed/simple;
	bh=SDkZ6OnP0DCX/zk8TiUybEOthpnqyryChtxIxiwvmrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUGD8h4Smaw4eHsCr/OmG0BHVbaM0udUGelqBZGYp5gJlCmb4apWYwPWCBi1+g2VqgTsJuU1uUPPdP5nBH95uLl82z6FVhEBORr0sy0b0F21KbEZCz5lnjNjpVPCvI5o9R9bxNjEqKOaHnqEtJiwUI0tMOIZqnn8+TAbaVgBDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/ZcHzDq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3594d7b36bdso1008552a91.1
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 01:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772269602; x=1772874402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMz6t2oyzUaXSrfBCyX2Xr2xba4aqzpY77uNKPyU2yQ=;
        b=d/ZcHzDqP0IRBM8Brk0rsUc/PegvEc3xAizPbJVCtqLFn9/gdJCZRmsycffSGIxU0g
         Q5cETySm/tSB3KaNpLsgIP2EU39gwc346eICHf2ci4ctW5K16nYl6jhUwsDyIN4bpJtb
         VVvxMLl3Df7MUR6PZelg1VFt3QAnSqYlDINraRrbZVVo1Lca20cmTH/nb6EWSrl6SfNj
         vazIBNSGmf9iePa16wuZCy2f0KwECcj9Sn3svR/e8uSNtLmZIU+W6zn46dshswSrTE4i
         eMNhHsKpuncYm6XDyJ7AwtDWehiTdWdXMRQ222Z56eG54IYZuIXIuSF3K2bL5PbKPr5z
         qrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772269602; x=1772874402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MMz6t2oyzUaXSrfBCyX2Xr2xba4aqzpY77uNKPyU2yQ=;
        b=DXQEqx2zhAPoHo5FkF78CjOVc4OhS15Cye4FmliiiLKF3aLM1+FMwKyvHzJSDdMA4o
         ijKVRVDIG7Dtz6iLaarOjhgtA11UFMYUMxNpttdIAxN/NfZJawa7oCtpb6PKJrzqy0MU
         vJDhUwaHk7nLOk1J92c9FiHCTDt0BGImTNyrPoDfVTGgt3N/7SArKvv0haVHAaNiNMc3
         P101aUfa6+EdtMGveWBiTZ4utTfek40YcWg2h48PsEoQgiTBnIZzglSa/YdXmIUty+GT
         z3UzYRIvPifZJS595oOSriAZjDcvLqeEtlCC3pqTbNv8d5LSGlydKTrtUKcy361jfWI2
         NgPg==
X-Forwarded-Encrypted: i=1; AJvYcCXKeWfthS71cUhGhi/T1V/dtNWTH3V0m6aOV4p5kfuzAtePRa7AeekdJGoLRPkPF1D48oksi26Teq8n/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+jXOq53c1PV0B1cBFJiI4vzNjETD+X31HGh2X8L6EV0vz0/Qd
	6+b573KTrAWKgRkeDxq4fVWOMKnfC4DuonkJCWLwjAHz805Iv99tEJLEjBvdgznNRpQ=
X-Gm-Gg: ATEYQzwCAsQsMtweki4JIjoiClwKp77+rQWNNqvR7A+0qIQcgabiWKBRcgdB4Xu240H
	XE3WT+BoEddLbrxAVziK09TFjF5nV1Xzdb62CAEcSAXkpe3Z0Ncu2MFvLcCsgtmmr8XysRR87km
	qDL5LGCfOIW27fPDzhtf2g7SJxdZITY3jY9yZYbmLhUpQNvVZ8YdF8giMOhc5ZUOR4j5zrq+/1J
	oNtFvxx6EFo18ZaCQSJiwztKTuxU1VcQ5uJlTz1YlDTgsae0F4DEv63vu2KQfa82AATACeXVFBY
	VFvkSw2c2b0gfGCv9HOWz7erEkyrYSEak4vhgG2fNM4hzeNAZ7FoZArw1TJ8Il1+JGkblZ8aIdy
	wSw09pnBp/PGB4MPHLZVFyQ4kKN5Mie9P7Qf67WlhiXBDg1AKCVgQ2Sfpi0M0lF7hCsWFzIaoLw
	AHS8x6P+UOP6xI5xruAtyxNXDw
X-Received: by 2002:a17:90b:47:b0:354:bf10:e69e with SMTP id 98e67ed59e1d1-35965c4164fmr4955190a91.9.1772269601742;
        Sat, 28 Feb 2026 01:06:41 -0800 (PST)
Received: from archlinux ([103.208.68.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dda5ec8sm7589488a91.12.2026.02.28.01.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 01:06:41 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: terrelln@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH v2 2/2] btrfs: replace BUG() and BUG_ON() with error handling in extent-tree.c
Date: Sat, 28 Feb 2026 14:36:21 +0530
Message-ID: <20260228090621.100841-3-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228090621.100841-1-adarshdas950@gmail.com>
References: <20260228090621.100841-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22110-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B36A51C195D
X-Rspamd-Action: no action

v2:
- use ASSERT() instead of btrfs_err() + -EUCLEAN
- append ASSERTs in btrfs_add_delayed_data_ref() and btrfs_add_delayed_tree_ref() to validate action at insertion time instead of runtime
- fold coding style fixes into this patch

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/delayed-ref.c |  8 ++++--
 fs/btrfs/extent-tree.c | 62 ++++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 3766ff29fbbb..d308c70228af 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1113,7 +1113,9 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_ref *generic_ref,
 			       struct btrfs_delayed_extent_op *extent_op)
 {
-	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
+	ASSERT(generic_ref->type == BTRFS_REF_METADATA &&
+	       (generic_ref->action == BTRFS_ADD_DELAYED_REF ||
+					generic_ref->action == BTRFS_DROP_DELAYED_REF));
 	return add_delayed_ref(trans, generic_ref, extent_op, 0);
 }
 
@@ -1124,7 +1126,9 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_ref *generic_ref,
 			       u64 reserved)
 {
-	ASSERT(generic_ref->type == BTRFS_REF_DATA && generic_ref->action);
+	ASSERT(generic_ref->type == BTRFS_REF_DATA &&
+	       (generic_ref->action == BTRFS_ADD_DELAYED_REF ||
+	        generic_ref->action == BTRFS_DROP_DELAYED_REF));
 	return add_delayed_ref(trans, generic_ref, NULL, reserved);
 }
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 03cf9f242c70..98bdf51774c4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -604,7 +604,7 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 		return -EUCLEAN;
 	}
 
-	BUG_ON(num_refs < refs_to_drop);
+	ASSERT(num_refs >= refs_to_drop);
 	num_refs -= refs_to_drop;
 
 	if (num_refs == 0) {
@@ -863,7 +863,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK && !skinny_metadata) {
 		ptr += sizeof(struct btrfs_tree_block_info);
-		BUG_ON(ptr > end);
+		ASSERT(ptr <= end);
 	}
 
 	if (owner >= BTRFS_FIRST_FREE_OBJECTID)
@@ -1237,7 +1237,7 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 {
 	int ret = 0;
 
-	BUG_ON(!is_data && refs_to_drop != 1);
+	ASSERT(is_data || refs_to_drop == 1);
 	if (iref)
 		ret = update_inline_extent_backref(trans, path, iref,
 						   -refs_to_drop, NULL);
@@ -1451,10 +1451,9 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret;
 
-	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
-	       generic_ref->action);
-	BUG_ON(generic_ref->type == BTRFS_REF_METADATA &&
-	       generic_ref->ref_root == BTRFS_TREE_LOG_OBJECTID);
+	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET && generic_ref->action);
+	ASSERT(generic_ref->type != BTRFS_REF_METADATA ||
+	       generic_ref->ref_root != BTRFS_TREE_LOG_OBJECTID);
 
 	if (generic_ref->type == BTRFS_REF_METADATA)
 		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
@@ -1621,8 +1620,6 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		ret = __btrfs_inc_extent_ref(trans, node, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, href, node, extent_op);
-	} else {
-		BUG();
 	}
 	return ret;
 }
@@ -1639,7 +1636,7 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 
 	if (extent_op->update_key) {
 		struct btrfs_tree_block_info *bi;
-		BUG_ON(!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK));
+		ASSERT(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK);
 		bi = (struct btrfs_tree_block_info *)(ei + 1);
 		btrfs_set_tree_block_key(leaf, bi, &extent_op->key);
 	}
@@ -1774,8 +1771,6 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			ret = drop_remap_tree_ref(trans, node);
 		else
 			ret = __btrfs_free_extent(trans, href, node, extent_op);
-	} else {
-		BUG();
 	}
 	return ret;
 }
@@ -2088,7 +2083,7 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			 * head
 			 */
 			ret = cleanup_ref_head(trans, locked_ref, &bytes_processed);
-			if (ret > 0 ) {
+			if (ret > 0) {
 				/* We dropped our lock, we need to loop. */
 				ret = 0;
 				continue;
@@ -2645,7 +2640,7 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num_bytes
 	struct btrfs_block_group *cache;
 
 	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
-	BUG_ON(!cache); /* Logic error */
+	ASSERT(cache);
 
 	pin_down_extent(trans, cache, bytenr, num_bytes, true);
 
@@ -4119,20 +4114,25 @@ static int do_allocation(struct btrfs_block_group *block_group,
 			 struct find_free_extent_ctl *ffe_ctl,
 			 struct btrfs_block_group **bg_ret)
 {
+	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
+	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
-	default:
-		BUG();
 	}
+	return -EUCLEAN;
 }
 
 static void release_block_group(struct btrfs_block_group *block_group,
 				struct find_free_extent_ctl *ffe_ctl,
 				bool delalloc)
 {
+	ASSERT(btrfs_bg_flags_to_raid_index(block_group->flags) ==
+	       ffe_ctl->index);
+	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
+	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		ffe_ctl->retry_uncached = false;
@@ -4140,12 +4140,8 @@ static void release_block_group(struct btrfs_block_group *block_group,
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		/* Nothing to do */
 		break;
-	default:
-		BUG();
 	}
 
-	BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
-	       ffe_ctl->index);
 	btrfs_release_block_group(block_group, delalloc);
 }
 
@@ -4164,6 +4160,8 @@ static void found_extent_clustered(struct find_free_extent_ctl *ffe_ctl,
 static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 			 struct btrfs_key *ins)
 {
+	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
+	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		found_extent_clustered(ffe_ctl, ins);
@@ -4171,8 +4169,6 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		/* Nothing to do */
 		break;
-	default:
-		BUG();
 	}
 }
 
@@ -4232,14 +4228,15 @@ static int can_allocate_chunk_zoned(struct btrfs_fs_info *fs_info,
 static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 			      struct find_free_extent_ctl *ffe_ctl)
 {
+	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
+	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return 0;
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		return can_allocate_chunk_zoned(fs_info, ffe_ctl);
-	default:
-		BUG();
 	}
+	return -EUCLEAN;
 }
 
 /*
@@ -4310,8 +4307,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			if (ret == -ENOSPC) {
 				ret = 0;
 				ffe_ctl->loop++;
-			}
-			else if (ret < 0)
+			} else if (ret < 0)
 				btrfs_abort_transaction(trans, ret);
 			else
 				ret = 0;
@@ -4441,15 +4437,16 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 			      struct btrfs_space_info *space_info,
 			      struct btrfs_key *ins)
 {
+	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
+	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		return prepare_allocation_zoned(fs_info, ffe_ctl, space_info);
-	default:
-		BUG();
 	}
+	return -EUCLEAN;
 }
 
 /*
@@ -5260,6 +5257,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 	u64 owning_root;
 
+	ASSERT(parent <= 0);
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (btrfs_is_testing(fs_info)) {
 		buf = btrfs_init_new_buffer(trans, root, root->alloc_bytenr,
@@ -5292,8 +5291,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 			parent = ins.objectid;
 		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
 		owning_root = reloc_src_root;
-	} else
-		BUG_ON(parent > 0);
+	}
 
 	if (root_objectid != BTRFS_TREE_LOG_OBJECTID) {
 		struct btrfs_delayed_extent_op *extent_op;
@@ -5633,7 +5631,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 		 * If we get 0 then we found our reference, return 1, else
 		 * return the error if it's not -ENOENT;
 		 */
-		return (ret < 0 ) ? ret : 1;
+		return (ret < 0) ? ret : 1;
 	}
 
 	/*
@@ -6437,7 +6435,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	int parent_level;
 	int ret = 0;
 
-	BUG_ON(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID);
 
 	path = btrfs_alloc_path();
 	if (!path)
-- 
2.53.0


