Return-Path: <linux-btrfs+bounces-19494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBDCA1A25
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A13DA300BDB7
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 21:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6652C21CD;
	Wed,  3 Dec 2025 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="eaNa+NOD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hW8wfy38"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BE2D7DC4
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796259; cv=none; b=bOrcmjtjHcgTKRAKk9wQBKhdLjYXX6lznwewyYUZ66lB+5e9nRuMaeI5iELdpj+8CkeA8KEFf5gqVgsqMA1rYQXKeLkGSdEbG0QoSjyNj6h6RuU2l7hIOrFq+FuEQDQ2T6hjaog/2vqiKOtJziXVang1IhzMe5AMQKUsxrWv6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796259; c=relaxed/simple;
	bh=S13yAcp2wj/R9r8dgII6IID7zV3BXT2HLNvyWusx6i0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANswHIOV9iAehdmxyjMryjS6pWE1Rj1zRgLZjtk1DEHsggxJKpphWezzlO/a2+XVgFgJY0TomEDWP5JbCYCswlG/f6MDptIwnA7nHDEhoDyoOAR3+juWX06Na/B5XMcGAAMgQApDJQf8Lk8mXELj1Pvp8Q6ORaGCegApwpHzotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=eaNa+NOD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hW8wfy38; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBB697A0266;
	Wed,  3 Dec 2025 16:10:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Dec 2025 16:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764796256; x=
	1764882656; bh=z9/2RraHyHxwm5HCTh9Ka4cK0i49Pl4LUAPj8hls85k=; b=e
	aNa+NODIPIOeIPN++JMmzNKn0qV7hhVEEPW5Jj62y+tr6xP4cefwdrR4oQchgY3P
	lsi/oaz6JRcNMUdSli7FJKVvXyG1OElP7o1rnt0XN1Yedvk6GK7XyS3t3e1oE2gf
	cC17P7kJH8S0rIYUVuMpsJ/Y8VPWDieBgCXgX7mKqjHb85ky8+Eq+iMJaHResngK
	a68CzPqnKaUyV1U2W+lSXPCzHs/n6QJ9CjMBhKhEcJXkF7XfwyW5brMyhRn8V1yk
	0Xq64PUf0FDFbFG5fW1QXaqtxC/NjB8pN+NO+G//pA/uWu+hD1xw9nj/guZTbZVa
	Dn6oPtALkODj6BaYxE19w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1764796256; x=1764882656; bh=z9/2RraHyHxwm5HCTh9Ka4cK0i49
	Pl4LUAPj8hls85k=; b=hW8wfy38AgGxTc7UpjJEou00rPd2kJeODl4tvWS9FXcH
	aWaPeHkis5DgnM8yOmKCf/vs2fnEmcWYNw/qcIeS7aIbwwS5MHq0BFdBErM27TKD
	cgbfpXlk10Pgt217xG9Rq3osBMNVqRqA0uintHekZc/VpSnVXYNReiXGLWI6CUF9
	snG5i9rhBwlGoakVBiRRZ9qFvBccGT8H0we64TWJesXOkOFwf32WCAc2iCjJlQFo
	gJUVzAsVs+34fuJsR+oiXudoy3EcB0P2MaGLuE/ExR9cPYAb4HqeXSyU5/JD6uQE
	eb0iaeEfUtvcHTrWhLAmqIOkmJy4zHAo9alE/ImJfQ==
X-ME-Sender: <xms:YKcwafkwN4buYcSZa35qV2qdrwLxnZehWX7NOo68P0sB3ie2CVSWKA>
    <xme:YKcwaY0vn6cg0SijKkthzj-PD94T4jDPlkeJ1pJ2OvVf3XUg3VsHreOhyt_I2861b
    3exZAtM2QI7JEEuCyZb9HinziDHSo2KCSi4uWYelFrq_up5o6O4FuoS>
X-ME-Received: <xmr:YKcwaTTjxLORMIuczj4A4-LY2j0yCp2bC-uvgkMyUGJ9VRDw879RQkWwNNnfnC-rnMK9CtWhT8KG6EWEq2FRgElUZ4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffvedvhedtud
    efiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:YKcwaSu-vyK7phQt5Z2ppuA7GwD9dPHQoUgQHJ_h0qJnd9fKZPnPIQ>
    <xmx:YKcwaQYY6ZN_p58gxrrMfLDLjxQde9W-v1np8CWNRNo5rBq9TOn-ug>
    <xmx:YKcwafuJ9Fx1lclbZ7ppxh_eNIanGAkrvCLNCU1pTHExZFbSCwrqtw>
    <xmx:YKcwaaH0DgGBbJLLKPvyc1SN3-Wymv-XaA-YSEhSWaBVMf8EIG0XDA>
    <xmx:YKcwaVLb-djrimDvnxmG3u6b6YdhdOfypW-57BMxDH0i4EHD5kZGwn_f>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:10:56 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: check squota parent usage on membership change
Date: Wed,  3 Dec 2025 13:11:10 -0800
Message-ID: <5d170d19ba8d0494c77a638293cc66ecb8a66967.1764796022.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764796022.git.boris@bur.io>
References: <cover.1764796022.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We could have detected the quick inherit bug more directly if we had
an extra warning about squota hierarchy consistency while modifying the
hierarchy. In squotas, the parent usage always simply adds up to the sum of
its children, so we can just check for that when changing membership and
detect more accounting bugs.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d46f2653510d..9e7e0c2e98ac 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -346,6 +346,42 @@ int btrfs_verify_qgroup_counts(const struct btrfs_fs_info *fs_info, u64 qgroupid
 }
 #endif
 
+static bool squota_check_parent_usage(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *parent)
+{
+	u64 excl_sum = 0;
+	u64 rfer_sum = 0;
+	u64 excl_cmpr_sum = 0;
+	u64 rfer_cmpr_sum = 0;
+	struct btrfs_qgroup_list *glist;
+	int nr_members = 0;
+	bool mismatch;
+
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE)
+		return false;
+	if (btrfs_qgroup_level(parent->qgroupid) == 0)
+		return false;
+
+	/* Eligible parent qgroup. Squota; level > 0; empty members list. */
+	list_for_each_entry(glist, &parent->members, next_member) {
+		excl_sum += glist->member->excl;
+		rfer_sum += glist->member->rfer;
+		excl_cmpr_sum += glist->member->excl_cmpr;
+		rfer_cmpr_sum += glist->member->rfer_cmpr;
+		nr_members++;
+	}
+	mismatch = (parent->excl != excl_sum || parent->rfer != rfer_sum ||
+		    parent->excl_cmpr != excl_cmpr_sum || parent->rfer_cmpr != excl_cmpr_sum);
+
+	WARN(mismatch,
+	     "parent squota qgroup %hu/%llu has mismatched usage from its %d members. "
+	     "%llu %llu %llu %llu vs %llu %llu %llu %llu\n",
+	     btrfs_qgroup_level(parent->qgroupid),
+	     btrfs_qgroup_subvolid(parent->qgroupid), nr_members, parent->excl,
+	     parent->rfer, parent->excl_cmpr, parent->rfer_cmpr, excl_sum,
+	     rfer_sum, excl_cmpr_sum, rfer_cmpr_sum);
+	return mismatch;
+}
+
 __printf(2, 3)
 static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info, const char *fmt, ...)
 {
@@ -1569,6 +1605,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
 		goto out;
 	}
 	ret = quick_update_accounting(fs_info, src, dst, 1);
+	squota_check_parent_usage(fs_info, parent);
 	spin_unlock(&fs_info->qgroup_lock);
 out:
 	kfree(prealloc);
@@ -1625,6 +1662,8 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		spin_lock(&fs_info->qgroup_lock);
 		del_relation_rb(fs_info, src, dst);
 		ret = quick_update_accounting(fs_info, src, dst, -1);
+		ASSERT(parent);
+		squota_check_parent_usage(fs_info, parent);
 		spin_unlock(&fs_info->qgroup_lock);
 	}
 out:
-- 
2.52.0


