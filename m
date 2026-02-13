Return-Path: <linux-btrfs+bounces-21675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JzLM8uLj2nURQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21675-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:38:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BF11397B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1CE30919A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3573C244667;
	Fri, 13 Feb 2026 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjO4Ev1q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E890285CB9
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015028; cv=none; b=sI2Eek5xUYHDrSfdwyJnzFQOdHZKi+Vylk1ZjTDJPdIemwlLt7DWAO6IDD6qniOlrUzLjMYHmhLWMdBBkOivuTPg2ppSIwyVcALB7OfkElboB5ycszpykuESdz57DxdNSPuKsg1ZtJNhWyjZZdXjJY51JisBmESK89sM2J/i1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015028; c=relaxed/simple;
	bh=F8OAQWpVCWir0Tm1TVhEqP8NQhJk4y1CXzicf6ysPzM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0NzO2kt/f2fpW2mMn7Xl+uswlygCACD2Qlcmzei+1gkFHiLlLbLzSybwxFxSGyvDjTIsHdi+PiB/XWjsIXpPSFbEygq7PME+4myrt7YGJvM/nAUIMqJs6Kz9/E3+VwrJFFOLHYmaZcWQOKZfmfl1lk/Zb1lGG9uRZHvOZ2Ez2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjO4Ev1q; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64ae5f0777dso1399309d50.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771015026; x=1771619826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJuXmMFHdA+zoKBODWSjiPYIyoLvh8MtV+SOz8zU6U0=;
        b=gjO4Ev1q55wPbl+W3jw6+6jjzQC+SUF2R1ebOHVSLoMBm/olsvICkCM8C0hvoUkX6J
         j/Qufc+TcAoVggNWBndFmws+bQdl54X639nGk4MkJp6qlJWD5wITgywNID4+g+kUd7UM
         WDehW/ZRd54NK7p+TRNu1a7F63kNBUZC8gQLCDmbraRh+5VkpXBjaFlca3TIay+Gw433
         sqKaWjTaESb64FAFqdof2LWSmYvf8+sseAeGTRhZYW/CzLXDaptGRWJxTpUyZ7O9/FQw
         CymwlFQqSlzdNC65ByBr2VETrgDMMuEUokJOenTk6xZ8+pehYBt0pTlsjBpqHz35TGk+
         +JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771015026; x=1771619826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XJuXmMFHdA+zoKBODWSjiPYIyoLvh8MtV+SOz8zU6U0=;
        b=IKNHJG8bCuL2AaXHV5oNGzyoUA5zDtXsSF37QMcVmJGLD232853bKgRjPaIrjk+g7G
         nC+bEgCp4jLpvTs0WJqs7HdXN2xJYS+fQEHYqlLGnIOuH69P6TUkOPsvK/AHHOcK/pIf
         /cC8DA4q+kbBNJ+BWfji1y2k+0A3/Wp1AAj0GKUjJCACxhEfZLCefJggsegYNJYEBn15
         bKdaR+8k4ec6HaOrSJagmvF6MjRma2FRC7zyD4E71j5sMS86rvLLpkEmwSjC6R/kBVqI
         ojFDWcSXegtIyyiAHC9Hb9qhnceEqJHEyOK73UlrdXSe8QiuQkgmEv4AeXfNw7MNHyhX
         i7xQ==
X-Gm-Message-State: AOJu0YzHkXyipn7qDTDaAvrDQfF2Ll4ObZ4qDi6wgWUDaaMQAN0aAy5M
	zodGs3+MMsx7zGTpNKB59ia301frQfq4KB/bPOEaQ2Dw/z+TLSCRsiVWrAJqGgqW
X-Gm-Gg: AZuq6aL21XQZnnq2KIHAGEqpyFtE5/xK22TIHL6NW4Mk9u+g/48q2thcM6J+OMvPxOJ
	wabh+AKMhIwvfB9eNstKptlLaetTnR7DFSVk7r9g0RfvpI4vkFFwLZ+85lT9KSn4hOSmAwsnXQi
	rRkqCKKps7YlWR1mxRYZJMfOIIoQsZIBzmnYkiVp7M5vT4XwpFgtOZmu/GCt2Bt8De5bH1QCGa5
	pfxCP0kwIm2rnej697B9XeyxXCtgj7XJHG65eiBMaBkwekc0E5e8QilI1+rqhZQ1eQHEgAHiVn4
	JjY2ZVC8vi2AQP5DJA+RufahqsEruRBss7L6/IswyPGsGV8vM+Kn5w5+qaglaqu3rR9ZShyj5Tc
	P4aZTQssKEikEUlka1BZdXwWUtWcVBNiywmJtYOednfsM5i7oYha6SdqRA8Sf2IIdDEVBzOMfai
	L0uM+EAD3mjxnWCgGElg==
X-Received: by 2002:a05:690c:c4f7:b0:794:f14c:462c with SMTP id 00721157ae682-797a0c0a63cmr54191817b3.28.1771015025976;
        Fri, 13 Feb 2026 12:37:05 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23d87csm74054647b3.25.2026.02.13.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:37:05 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 3/3] btrfs: add tracepoint for COW amplification tracking
Date: Fri, 13 Feb 2026 12:30:26 -0800
Message-ID: <daa819f56fd49e190b7ed70122ab79ecef690291.1771012202.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771012202.git.loemra.dev@gmail.com>
References: <cover.1771012202.git.loemra.dev@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21675-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49BF11397B5
X-Rspamd-Action: no action

Add a btrfs_search_slot_stats tracepoint to btrfs_search_slot() for
measuring COW amplification.

The tracepoint fires when a search with at least one COW completes,
recording the root, total cow_count, restart_count, and return value.
cow_count and restart_count per search_slot call are useful metrics
for tracking COW amplification.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/ctree.c             | 15 +++++++++++++--
 include/trace/events/btrfs.h | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 55187ba59cc0..1971d7bb5f60 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2069,6 +2069,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	u8 lowest_level = 0;
 	int min_write_lock_level;
 	int prev_cmp;
+	int cow_count = 0;
+	int restart_count = 0;
 
 	if (!root)
 		return -EINVAL;
@@ -2157,6 +2159,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			    p->nodes[level + 1])) {
 				write_lock_level = level + 1;
 				btrfs_release_path(p);
+				restart_count++;
 				goto again;
 			}
 
@@ -2172,6 +2175,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				ret = ret2;
 				goto done;
 			}
+			cow_count++;
 		}
 cow_done:
 		p->nodes[level] = b;
@@ -2219,8 +2223,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		p->slots[level] = slot;
 		ret2 = setup_nodes_for_search(trans, root, p, b, level, ins_len,
 					      &write_lock_level);
-		if (ret2 == -EAGAIN)
+		if (ret2 == -EAGAIN) {
+			restart_count++;
 			goto again;
+		}
 		if (ret2) {
 			ret = ret2;
 			goto done;
@@ -2236,6 +2242,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (slot == 0 && ins_len && write_lock_level < level + 1) {
 			write_lock_level = level + 1;
 			btrfs_release_path(p);
+			restart_count++;
 			goto again;
 		}
 
@@ -2249,8 +2256,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		}
 
 		ret2 = read_block_for_search(root, p, &b, slot, key);
-		if (ret2 == -EAGAIN && !p->nowait)
+		if (ret2 == -EAGAIN && !p->nowait) {
+			restart_count++;
 			goto again;
+		}
 		if (ret2) {
 			ret = ret2;
 			goto done;
@@ -2281,6 +2290,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 	ret = 1;
 done:
+	if (cow_count > 0)
+		trace_btrfs_search_slot_stats(root, cow_count, restart_count, ret);
 	if (ret < 0 && !p->skip_release_on_error)
 		btrfs_release_path(p);
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 125bdc166bfe..b8934938a087 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1110,6 +1110,32 @@ TRACE_EVENT(btrfs_cow_block,
 		  __entry->cow_level)
 );
 
+TRACE_EVENT(btrfs_search_slot_stats,
+
+	TP_PROTO(const struct btrfs_root *root,
+		 int cow_count, int restart_count, int ret),
+
+	TP_ARGS(root, cow_count, restart_count, ret),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root_objectid		)
+		__field(	int,	cow_count		)
+		__field(	int,	restart_count		)
+		__field(	int,	ret			)
+	),
+
+	TP_fast_assign_btrfs(root->fs_info,
+		__entry->root_objectid	= btrfs_root_id(root);
+		__entry->cow_count	= cow_count;
+		__entry->restart_count	= restart_count;
+		__entry->ret		= ret;
+	),
+
+	TP_printk_btrfs("root=%llu(%s) cow_count=%d restarts=%d ret=%d",
+		  show_root_type(__entry->root_objectid),
+		  __entry->cow_count, __entry->restart_count, __entry->ret)
+);
+
 TRACE_EVENT(btrfs_space_reservation,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info, const char *type, u64 val,
-- 
2.47.3


