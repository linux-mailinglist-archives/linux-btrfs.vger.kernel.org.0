Return-Path: <linux-btrfs+bounces-18273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D3BC0590A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777273B1209
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC930F93A;
	Fri, 24 Oct 2025 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="EGNpaG/u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0030F808;
	Fri, 24 Oct 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301360; cv=none; b=Hj7vo2LcAlCODLBIWJErn/NfRHgtVnM7Gjwn33fuuwfd78S2te0jC93EA7n7V+TXL0pz+HRAgEaflUSr81tVFxxmH6YnrFPUC+rcMdM91vdJwsX2/BxC8tu+57zgzFEKABE05S9/yEToiK0/t36HqXRHMCSlZMj1clenqMpk1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301360; c=relaxed/simple;
	bh=dfYrRcCz625GU5Hv4qF7R5hDzF21+y53LzlCMNULDzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGZssqviwCVN2b3DhsjT1k7HpZCPJ0+qAZO8zp4wqy+eLLMLOXU3rSrv6cvbUJKHj16OcxOfgYRVFkrTy4LgLuQD/DEOkljYaL6usXm+anj/N3g25wEwDQI3p2IuOpN2y0g+GKs8AEpK8/voA/r/m2dyLWY3SXIBNSa0V4PJHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=EGNpaG/u; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ctJqt3YW7z9sSs;
	Fri, 24 Oct 2025 12:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761301354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Js1n6kPDTMBIfCKrUsee5DCSrbS0DlAuQlCfrk27LTQ=;
	b=EGNpaG/uoS52MNNPLbxnB53UgA98RvddtykD6ad/Vjuo/dryjnHsRoMQnsk1JNu2nVoS2y
	JR02OQr6WVGzfokQ4cONmF9QjiKRdGsE5YpBJfcz00JmuXFaXMWuLkMcpkG7gOprvlSLFB
	PWmUsp+ixF7nerJZgbM8GxSupDCZHoHM5n41HP1ppuv+iAavFG5EGKnPqUY/nKcQa5fGsm
	fP4+kPpFXWseYF6iQR3+ntNrPxzebZWasCoq2I1kXCbvW4RmB5LQt/OtyPs5pB7xHNafWx
	B6PDA0eTjC2KV7Tel5Uv7jnsQGSxEahOxqd7Fsqdn+NP2noxSeQuoBJ8fy2TMQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::102 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	fdmanana@suse.com,
	boris@bur.io,
	wqu@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2 4/4] btrfs: add ASSERTs on prealloc in qgroup functions
Date: Fri, 24 Oct 2025 12:21:43 +0200
Message-ID: <20251024102143.236665-5-mssola@mssola.com>
In-Reply-To: <20251024102143.236665-1-mssola@mssola.com>
References: <20251024102143.236665-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ctJqt3YW7z9sSs

The prealloc variable in these functions is always initialized to
NULL. Whenever we allocate memory for it, if it fails then NULL is
preserved, otherwise we delegate the ownership of the pointer to
add_qgroup_rb() and set it right after to NULL

Since in any case the pointer ends up being NULL at the end of its
usage, we can safely remove calls to kfree() for it, while adding an
ASSERT as an extra check.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/qgroup.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6919f429c6b3..1c00a5330c4d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1263,7 +1263,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
-	kfree(prealloc);
+
+	/*
+	 * At this point we either failed at allocating prealloc, or we
+	 * succeeded and passed the ownership to it to add_qgroup_rb(). In any
+	 * case, this needs to be NULL or there is something wrong.
+	 */
+	ASSERT(prealloc == NULL);
+
 	return ret;
 }
 
@@ -1693,7 +1700,12 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
-	kfree(prealloc);
+	/*
+	 * At this point we either failed at allocating prealloc, or we
+	 * succeeded and passed the ownership to it to add_qgroup_rb(). In any
+	 * case, this needs to be NULL or there is something wrong.
+	 */
+	ASSERT(prealloc == NULL);
 	return ret;
 }
 
@@ -3301,7 +3313,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
-	struct btrfs_qgroup *prealloc;
+	struct btrfs_qgroup *prealloc = NULL;
 	struct btrfs_qgroup_list **qlist_prealloc = NULL;
 	bool free_inherit = false;
 	bool need_rescan = false;
@@ -3542,7 +3554,14 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	}
 	if (free_inherit)
 		kfree(inherit);
-	kfree(prealloc);
+
+	/*
+	 * At this point we either failed at allocating prealloc, or we
+	 * succeeded and passed the ownership to it to add_qgroup_rb(). In any
+	 * case, this needs to be NULL or there is something wrong.
+	 */
+	ASSERT(prealloc == NULL);
+
 	return ret;
 }
 
-- 
2.51.1


