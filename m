Return-Path: <linux-btrfs+bounces-21954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMNlINIXoGmzfgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21954-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 10:52:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F61A3C7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12E4730288F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3165A394469;
	Thu, 26 Feb 2026 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyABDGjX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6E314B61
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099478; cv=none; b=E0DqdrsD0wWG2LtL0GOk6Oyapp87WaH8Hg0xHkubqXZEO+pnjqBPIwo7lLsWTJmK2U8zyhYH1ENpl/VPVucRoE5NCrFncfAPKz7nHrektAHEwr1MTtQAem11yUirV9KbMFGWuBUIOZN6WOBpZKS4+jDXighTDNwK3gu6LbnCRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099478; c=relaxed/simple;
	bh=8nLB0/mCMwzrnCK+gFk36QPwb/+fvVmRqUXFTRxukiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMVpM8INk8aZStPx7qqiCC6jc6GyoMNOhZa9rNTqi9dY3eC7M77KIWaz33U0d8xOfp2Fb/ibDZ44lTvobSkeTdgIA7dUB4TOe+975H8x+QGZ0neUnaMkJpZ5xYABPrfUtfo7wJzsATUv+1GkHM++bW87VeVkka+7thDr7GSzj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyABDGjX; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7927261a3acso4631697b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772099476; x=1772704276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXCXxMA/z+f1JchSyKDgOD1B3ht0W1oLunni6gQeQqQ=;
        b=JyABDGjXQqVmESOvkCY+NVF1/cxeH7gnFOO34ITwRBgORdRP4Stezth651kvIgBdNi
         X0Fi9oLDymH5DtU45v7Zs1fWhNpjzHnsYjtPG32bNP9b2IFvGkqV4ZGzpy4YHPMBE3yN
         vobmSqo2cYlHg1fvUdnNiL/6qypXm7xp8x6t18QE1OJv/oZma6KzJALtELIBB/+eMIsW
         elESf6ZOYnzIs6DHruYIqpLGKXo82TPWran1f+/DWhQwRDySV4buSLJ149yzMxZC2ZXQ
         qJ90LtuhJy/3MFcvDBnzBJqQJz8CtU3hhK1YBLyjrF8R2+22OGEADnGcPQ1VZeS3zHCL
         bVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772099476; x=1772704276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXCXxMA/z+f1JchSyKDgOD1B3ht0W1oLunni6gQeQqQ=;
        b=Q5OwXF5neMQVZviMjslAFbBw8tHPTp55H38IoeReR00tIBsL4axzR32cuXJXwHYZ1p
         qq3+nWB0UOI+wm9CnicWYV20SGqiDpDyHjBAEKH9yI5lwXcmNWvwmhK/tO4ZazxazjoF
         vYb4rbQHEH3zmPbkhITF1zOvaXL/1MFxRUIoYfIOUm16YzSUcC9AC2ZdJkMz/GNYSKyH
         2X7gEP5EOjsVTVTIARrG1un8p+3Q+UEr/Ue8CggIxxVjNjIQ+IJZkRpxk5K+JReEj7iw
         3m0RhtQepu/wseYk+J7XT3+pXfpgWaecQgA+11NoNhA/bh6RBgIOsUcwFShN9SEfpeN1
         oIpw==
X-Gm-Message-State: AOJu0YyfbgI2TO7qoYOoKOOeAvE8hcE602d8jBUQsx+wFXXXiONHWF8e
	EIAI/sGEwP5a7NrwlhrKJXiYcTwwph5lCDtDy0s+cYi5woNOKHs1cRZHIDM4VAZJ
X-Gm-Gg: ATEYQzxWVr4Qcz9gilZRJk6QmxVrMTZRS0XpnE3BibiA3XBMJrWHbH3ffm9cUYaB65f
	03Zt6/KEeUEj66BoPxyVWMTXt99T29OngOQqLgJpEqmwu5FM9RWvxAzvt3ruMckcg6xIW56/nYP
	AlW7O7NYX83z3iknMah31PstZx+C3yHONGtdjH5DCA/ho650ku9ZtrkjfCRg5hDQNLLTKCvJTG6
	fESrJ5TS/joq/ks6jWWTu0rJRINgsgRyJVc+xDH9bvCI5JIogIOLTGtBiNOPcH/Ds2dOuyXCGb2
	UbeH3RcTmIJWWsWogyHHZLugs5PlAfdg4Qv+aKg8lqkPnVSZY3bpjHE2eyEi+f423clfrMDyiQW
	mARBrX+fB0DZbmfJerTLErUpSo2AJ5K06J7A/s0WkqX9Vvlt4wP+yOguWCQCIWNoElCsVpe9W9i
	RJUwCqHDiGmFroU/5Xrg==
X-Received: by 2002:a05:690c:389:b0:796:357a:9ae7 with SMTP id 00721157ae682-7986ff8dd68mr30383667b3.51.1772099476083;
        Thu, 26 Feb 2026 01:51:16 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf8183sm7092327b3.30.2026.02.26.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:51:15 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 3/3] btrfs: add tracepoint for search slot restart tracking
Date: Thu, 26 Feb 2026 01:51:08 -0800
Message-ID: <29af2660c8c3946d422f57910ec50916463a345b.1772097864.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772097864.git.loemra.dev@gmail.com>
References: <cover.1772097864.git.loemra.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21954-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 9E2F61A3C7B
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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c             | 10 ++++++++--
 include/trace/events/btrfs.h | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 46a715c95bc8..19f1fafeebb6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2164,6 +2164,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			    p->nodes[level + 1])) {
 				write_lock_level = level + 1;
 				btrfs_release_path(p);
+				trace_btrfs_search_slot_restart(root, level, "write_lock");
 				goto again;
 			}
 
@@ -2226,8 +2227,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
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
@@ -2243,6 +2246,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (slot == 0 && ins_len && write_lock_level < level + 1) {
 			write_lock_level = level + 1;
 			btrfs_release_path(p);
+			trace_btrfs_search_slot_restart(root, level, "slot_zero");
 			goto again;
 		}
 
@@ -2256,8 +2260,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
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


