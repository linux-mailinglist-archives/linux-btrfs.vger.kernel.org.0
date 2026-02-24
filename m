Return-Path: <linux-btrfs+bounces-21895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLt5BcL6nWmeSwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21895-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 20:23:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FC418C016
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 20:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43EB830C597C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7813ACEEC;
	Tue, 24 Feb 2026 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS0z22Z2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A553ACEE5
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960980; cv=none; b=kXNH9KBwuHF07LJ0PAu3JZnIbyzhKk340chdJqS7qb9FQOenhm+m5mi5ICD27vBlcZNhKudHcmsos0wPd7l76deRLUmSne1R3VXSkHH9Lc6y4ogd4lbH16A8m+kIq4bslCADse4Zl9Llm5LYlWVbzKmK2NGhBa8fD7LxsqlIPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960980; c=relaxed/simple;
	bh=RKxptFjOQg2ePxtrPFOMEGunm7brl19UYdjtsUqptSU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHpCZgKCmfK3snM0npVTJj4ENW/Cvj0A5ljSSaaJWn5HXPrw36zI7D9eFfx1IO6BT8G36XMgHsCVbwDWmFPL394r147PJgn8ls8/iCUUq5lSrBM/XZwqbRkbRWNpaZ7uRT6XbR2YQX+o2X7hU96RxvZbuzccWNiWkwnrQf82ykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS0z22Z2; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7947cf097c1so55217627b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960974; x=1772565774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5blE1hym1Y/2JouN/dbaOiUOruy/Z7iUAuj7qCa+RA=;
        b=OS0z22Z2SgsT8pHI44vC1EdM4GfkKaombf7F5Jq8eXhsg9QGRM5R6EeMYEE8JHJPn8
         L+YQ+y6fi2F05QwBgTrFgyJKQ89WXPs6MgYd9evHj5RW09srb8nAkd6jI1MVytlsKkqS
         8CboCoAjBs3sjWQrg5gHt+J0jc2P4eDFnUgYX3DiXx/7AkgCLgV0yBtdxDD2CE4bWwtE
         RD0FoR+gP0PRq777s1Xo4MROyg5unmjWsv5an1eG7arDJz5dL9pGw3mqhO+mNV9Si8ij
         zY8ISZXrX5ZpS3qJAMugI1d70HtsRzvK7C1GfWvtljmXT9GaPLBNZ4USiDvPhjulziDh
         mM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960974; x=1772565774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j5blE1hym1Y/2JouN/dbaOiUOruy/Z7iUAuj7qCa+RA=;
        b=jm/Kts5ICk808WX3OTJIPw9Ykx+vEPzdsjsuPyq7Fh3zF/5dz9gF0hacjgsSHz33Yz
         oYjzeTfudmAO14Bix0TSzcb7PS0mEOTCCPzOv0vNbcQ13liO8WB2x4ZwaIfIWU7+/MFO
         LtEjRodKgMoU8UZuS5u6T7Zc+IDoxsdlMyVsI98iiUtXokl5Ks8holY5sI/FU4v0VlpK
         Cv1LlJZedMwUD/zwb+0Mr8safRNcfs38CjVrYvwrRGuxHQa3D9L9V83UMhCvpYbSM8+l
         Bco2XhbVzidDfa5hc2+FmBTCgwYGd2nVXqFr+a6fIyGmhDOlBrGp4tzwn/XI7VRS1pdz
         uW2w==
X-Gm-Message-State: AOJu0YyGsF2PghlZsNZEY92jAaSN304VF52OKOrWnhkC50uFuD/FRVqs
	5brttfSufQr9AKDN7tZ1M5sol+fU+sy5RAuJRiO9Z5mmzq0NzJ7v6aBd0gMbVWXLYoU=
X-Gm-Gg: ATEYQzzJ5x9Vholf+k5/oIvo+T3I2TCKc1mCvfBmXR8tg6/u8G3SrnSKcOUwoDD4Xgr
	30UhwlXZZRBX3qLzKHX9xYQ9hVREV60YwEKUJF6RYXNELvuHKz/ibjtIVNRxHe/aYJyGYW6pONQ
	aXVhltmYSN92NHgprzoLN6eF1Aya3K9JPf9S4EW9WW4F9NIBDlbKEBRlKNjKXFY2h0T6jUGeMVA
	apvyRsm0qnUGiaaQPnaAEsAE1jSIhlw91zf832kpOMAQNAeEPZcJWHVsK56AV1nVdlAAtCA1Vkr
	ZSMVO/MmOQ7qFl+Kx0zpqxw5UT4QZW2VryPz/e1ZcokfWC2ULedH67Upp6JJvT/FewOaSLxGPxB
	tTb9wrghGWQm/DezO7BXSzvvnVngbb1Nnp/PM4eOkPyx+Rwg81Wuw/o83/OAhJh96VDm9BH6/Eq
	UY1owRneM2I9l2QBJm
X-Received: by 2002:a05:690c:62c1:b0:797:d5f2:c64 with SMTP id 00721157ae682-79828cf722amr121678937b3.10.1771960973621;
        Tue, 24 Feb 2026 11:22:53 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd88efcsm46952667b3.24.2026.02.24.11.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:22:53 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 3/3] btrfs: add tracepoint for search slot restart tracking
Date: Tue, 24 Feb 2026 11:22:34 -0800
Message-ID: <18c04d9a68f64fa5e36dde196306170d0fb437d9.1771884128.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771884128.git.loemra.dev@gmail.com>
References: <cover.1771884128.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21895-lists,linux-btrfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7FC418C016
X-Rspamd-Action: no action

Add a btrfs_search_slot_restart tracepoint that fires at each restart
site in btrfs_search_slot(), recording the root, tree level, and
reason for the restart. This enables tracking search slot restarts
which contribute to COW amplification under memory pressure.

The four restart reasons are:
 - write_lock: insufficient write lock level, need to restart with
   higher lock
 - setup_nodes: node setup returned -EAGAIN
 - slot_zero: insertion at slot 0 requires higher write lock level
 - read_block: read_block_for_search returned -EAGAIN (block not
   cached or lock contention)

COW counts are already tracked by the existing trace_btrfs_cow_block()
tracepoint. The per-restart-site tracepoint avoids counter overhead
in the critical path when tracepoints are disabled, and provides
richer per-event information that bpftrace scripts can aggregate into
counts, histograms, and per-root breakdowns.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/ctree.c             | 10 ++++++++--
 include/trace/events/btrfs.h | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d4da65bb9096..5447ee640190 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2152,6 +2152,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			    p->nodes[level + 1])) {
 				write_lock_level = level + 1;
 				btrfs_release_path(p);
+				trace_btrfs_search_slot_restart(root, level, "write_lock");
 				goto again;
 			}
 
@@ -2214,8 +2215,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		p->slots[level] = slot;
 		ret2 = setup_nodes_for_search(trans, root, p, b, level, ins_len,
 					      &write_lock_level);
-		if (ret2 == -EAGAIN)
+		if (ret2 == -EAGAIN) {
+			trace_btrfs_search_slot_restart(root, level, "setup_nodes");
 			goto again;
+		}
 		if (ret2) {
 			ret = ret2;
 			goto done;
@@ -2231,6 +2234,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (slot == 0 && ins_len && write_lock_level < level + 1) {
 			write_lock_level = level + 1;
 			btrfs_release_path(p);
+			trace_btrfs_search_slot_restart(root, level, "slot_zero");
 			goto again;
 		}
 
@@ -2244,8 +2248,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		}
 
 		ret2 = read_block_for_search(root, p, &b, slot, key);
-		if (ret2 == -EAGAIN && !p->nowait)
+		if (ret2 == -EAGAIN && !p->nowait) {
+			trace_btrfs_search_slot_restart(root, level, "read_block");
 			goto again;
+		}
 		if (ret2) {
 			ret = ret2;
 			goto done;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 125bdc166bfe..abf1b73ee60f 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1110,6 +1110,30 @@ TRACE_EVENT(btrfs_cow_block,
 		  __entry->cow_level)
 );
 
+TRACE_EVENT(btrfs_search_slot_restart,
+
+	TP_PROTO(const struct btrfs_root *root, int level,
+		 const char *reason),
+
+	TP_ARGS(root, level, reason),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root_objectid		)
+		__field(	int,	level			)
+		__string(	reason,	reason			)
+	),
+
+	TP_fast_assign_btrfs(root->fs_info,
+		__entry->root_objectid	= btrfs_root_id(root);
+		__entry->level		= level;
+		__assign_str(reason);
+	),
+
+	TP_printk_btrfs("root=%llu(%s) level=%d reason=%s",
+		  show_root_type(__entry->root_objectid),
+		  __entry->level, __get_str(reason))
+);
+
 TRACE_EVENT(btrfs_space_reservation,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info, const char *type, u64 val,
-- 
2.47.3


