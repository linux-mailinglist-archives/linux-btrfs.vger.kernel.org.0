Return-Path: <linux-btrfs+bounces-20813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LdPMTW7cGmWZQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20813-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:40:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC055622F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014189452C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6546AED6;
	Wed, 21 Jan 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byg2aU0L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D994418F2
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994041; cv=none; b=SmLwhu78VCObMeqRU7hIVM+Khttk38Imzkata8hCjdfSzeqtK0fSTKvgtkwnFfHv4eJfLoWfmiyUh6DfOBIQrs8tBhqwwfe4ZRFIw/5LcNe2S/FD+OZT6db1zVE7iJIJ/iIPTmlMO9iHQtg1TKuKo+l4hNb8epFTBzgdxtz16sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994041; c=relaxed/simple;
	bh=t1R4imCWtWPWVUIA1c7hMOEoa2mJNnKuCNmacLSn6Eo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnhAPfMAmUpfDpb2ESV+cgV1q07z77w26NjaA3Ojs7qhY+GSBdsCcsVtxgeJbY68Kxvmf1pYSzZGDOjj2lrAxdXbfUNf/qEJGJR0I7vpjxUCrUt46P68bFOQgvVavljxoamMteYmFxqstGhXC8kYXhDUk9hEjrKsRGe3QmwGbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byg2aU0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F4DC19424
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994040;
	bh=t1R4imCWtWPWVUIA1c7hMOEoa2mJNnKuCNmacLSn6Eo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=byg2aU0LthVuSLPCAWGLqyQvxOaJaBtS3wIde1Q5GrVCIv25GOvy/gmGfreQJdtPE
	 aMpwAgL+OAOIolFkOUn2QphryjawoYskj+Jo3Sh8vNF3f6kgnHGVt+w6eFpor7sGsp
	 YGsgPWaxso8ywAO7gW/6Wb/Yv9mHT+IESPVMDUzFgduU/dN7Jf+ttqnx3T64BephqZ
	 FGasJLKe+xOeXwv1inhMLvj565wKbLhFPU23Lhf/cBeVsqinAbg/9B/JYgmbr75MK+
	 j37yIgIfQ2/gHEMwUveNgSFeX1maOcLSWIbCNbMDfsgqfBjkJJVHTx3dYTRGtxlsFX
	 f/IFxeGOloohw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/19] btrfs: remove pointless out labels from qgroup.c
Date: Wed, 21 Jan 2026 11:13:38 +0000
Message-ID: <4e01dbbbb41353ff3e623436a765842ef96a9d6f.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20813-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0BC055622F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Some functions (__del_qgroup_relation() and
qgroup_trace_new_subtree_blocks()) have an 'out' label that does nothing
but return, making it pointless. Simplify this by removing the label and
returning instead of gotos plus setting the 'ret' variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c03bb96d3a34..f53c313ab6e4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1613,10 +1613,8 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	int ret = 0;
 	int ret2;
 
-	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
-		goto out;
-	}
+	if (!fs_info->quota_root)
+		return -ENOTCONN;
 
 	member = find_qgroup_rb(fs_info, src);
 	parent = find_qgroup_rb(fs_info, dst);
@@ -1638,12 +1636,10 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 delete_item:
 	ret = del_qgroup_relation_item(trans, src, dst);
 	if (ret < 0 && ret != -ENOENT)
-		goto out;
+		return ret;
 	ret2 = del_qgroup_relation_item(trans, dst, src);
-	if (ret2 < 0 && ret2 != -ENOENT) {
-		ret = ret2;
-		goto out;
-	}
+	if (ret2 < 0 && ret2 != -ENOENT)
+		return ret2;
 
 	/* At least one deletion succeeded, return 0 */
 	if (!ret || !ret2)
@@ -1657,7 +1653,7 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		squota_check_parent_usage(fs_info, parent);
 		spin_unlock(&fs_info->qgroup_lock);
 	}
-out:
+
 	return ret;
 }
 
@@ -2490,13 +2486,11 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 
 		/* This node is old, no need to trace */
 		if (child_gen < last_snapshot)
-			goto out;
+			return ret;
 
 		eb = btrfs_read_node_slot(eb, parent_slot);
-		if (IS_ERR(eb)) {
-			ret = PTR_ERR(eb);
-			goto out;
-		}
+		if (IS_ERR(eb))
+			return PTR_ERR(eb);
 
 		dst_path->nodes[cur_level] = eb;
 		dst_path->slots[cur_level] = 0;
@@ -2541,7 +2535,7 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		dst_path->slots[cur_level] = 0;
 		dst_path->locks[cur_level] = 0;
 	}
-out:
+
 	return ret;
 }
 
-- 
2.47.2


