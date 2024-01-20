Return-Path: <linux-btrfs+bounces-1577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02EA833207
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 01:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6314B1F22EF3
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 00:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABAC10E1;
	Sat, 20 Jan 2024 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ErnYMYet";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXgXpzcI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E77EC0
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jan 2024 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712110; cv=none; b=GBmD2PPrKJ4sSwhJ1PZSEWEi/zQmJnt6igwU5N/wJ8RIwe6SqDHbloN4pn72tNKi7H/xH9ZvsbAwt6CoySXQYxelif0NB/Jjn/NT3rUQRojc1HE7ij5WLSiPoS4RKIlduqvqNRIc2lQST0eNdNjE332KZP0mV6zLf91heRc53Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712110; c=relaxed/simple;
	bh=3FtkTd+3FzRb5GLSYLs6nLDzZ/z20j9zxLi7nW8ZjkI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRAUeFbccVm/yFKvppGPKIBNwBNn1+I6IIq0t7/bdQmvuJYod/UQNtAbB9K7oPB8C9W2xHptbcaRqxYJK7jQxN+qjcItaskNRvSJpfHVXsc0rUCpvK4+CsRDHG1n98fequm495+jNglVoQbs8X7OkjbsB2jVaIB7R0yZmBt/xCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ErnYMYet; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXgXpzcI; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 386773200AC5;
	Fri, 19 Jan 2024 19:55:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Jan 2024 19:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705712107; x=
	1705798507; bh=vqoKA104sb2D+NIP1EyPfwAekJWdgbAK8USg+UWh/aQ=; b=E
	rnYMYetzh0edZx1O6sQq76+RqJ85CnvUZv0JR6tLx9tJFU8nZhjAHjDY/dglNmvu
	9G8/KW84dTYLyTpbdixA6ympHI2WtbFlSHfOIg3C+Ck2wuJF7c+7T4y8Ov3XnAcV
	GK0mtoz9H8iwlCeNg94fwce6zzY01D4RBRIGCZ9mnWpG/odFEMa1/turRsZM06tD
	m6Qv6U42p4RlMg2tkAVgIPRLnX7z4AzuI+qz62XtOrjnhyTaEbpAhoCDIhyNtpds
	5gxz3Fy59exr3rnLiXV71oSLXCZtBiTfIuvMrKbKYous7QigNDS1NiIjjSav73FW
	oDqz54hqbXOL/+Asv9fPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1705712107; x=1705798507; bh=vqoKA104sb2D+
	NIP1EyPfwAekJWdgbAK8USg+UWh/aQ=; b=QXgXpzcIfVCbm16f2kOHHyNBx7IIM
	Nys868lfrGQk7S9k5jLPPcVb8FwGoWzTvL6xw+nDlDXZ5IQlcjNYDyAmWzNB7fW4
	eGXPa3L2UdjqHwFq6qE28m9e2t+XlZPzO/4TMg9wbI+jl+hD6+VHB7Bu4ss6jEHW
	0nX/mkuM2nuz7pFt6+kwpo/M4YQJ7VcTs/6UR5sV0ANo7o8t2oHGHNV6PWpYRfO8
	SBkesFn/mGzkhAXYQ01UkQlqrbL3tztKP3qK/wHN8XCFv6/5alwAX5jHoLq/rw4C
	wK3sUrmOeL+FoTK7hU87NRgqNlRkr74imOIMmSV/YCD8kxWXfO3hB7F9w==
X-ME-Sender: <xms:6xmrZVsxNthF5nWkA3DPxM7mQc-FCroPh58hcp6XTtWBuYuW7PwHjQ>
    <xme:6xmrZefhRHF7ljfsjnPP5FmxZrIQ3xAFFALc8txbMAX08t58zyhDGSTdckx3BcVUt
    bdf-j4j5elag_dCa-U>
X-ME-Received: <xmr:6xmrZYwRnqcdFJcfd-9FH5Ga0S0LDpd-Bugjfon-Ny0YgmBw_A6zcLyxswmO8Yb-gMi4G0ZrV7Apz57vqDOpIr-GwgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:6xmrZcOsBDx0Ami3A-RV1OvH-l0w_sYIvwG7MLqBogOv7v3EP-4u7w>
    <xmx:6xmrZV-FPFv5QMqLlyHZIedkbI6knYAAARoepqCsU8Eairo5Im43Lg>
    <xmx:6xmrZcW_Eg8pME7cu9lHPncK0MwFXz6iaUgLDpJE2oT47R7GhmsngA>
    <xmx:6xmrZSFUz22FQBA3Gg0WOjN1sxZXBkFPzZ4X8AW9N8Pxds4aKtu9wQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 19:55:07 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: forbid deleting live subvol qgroup
Date: Fri, 19 Jan 2024 16:55:59 -0800
Message-ID: <8ef9980c0621c82737b646b2bcf9df7b5a6dc216.1705711967.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705711967.git.boris@bur.io>
References: <cover.1705711967.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a subvolume still exists, forbid deleting its qgroup.
This behavior generally leads to incorrect behavior in squotas and
doesn't have a legitimate purpose.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 63b426cc7798..672896b2b7a0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -29,6 +29,7 @@
 #include "extent-tree.h"
 #include "root-tree.h"
 #include "tree-checker.h"
+#include "super.h"
 
 enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
 {
@@ -1736,6 +1737,15 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
+static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
+{
+	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
+		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
+}
+
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1755,6 +1765,11 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		goto out;
 	}
 
+	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Check if there are no children of this qgroup */
 	if (!list_empty(&qgroup->members)) {
 		ret = -EBUSY;
-- 
2.43.0


