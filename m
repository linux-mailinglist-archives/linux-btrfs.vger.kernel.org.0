Return-Path: <linux-btrfs+bounces-19495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C86ECA1A28
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58EF5300CCD0
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157982D190C;
	Wed,  3 Dec 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DKSB17jM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vmRVXEIT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C222D3724
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796261; cv=none; b=FYMA6YUj4+FOV4vI29QQEB28De3KD712WJn1TWyUe51As/Rh6kBJ3UfxKzsK3yRPBRZ7WC5QGJKIkRXbBQ2XEnQAGXnRa/KgA+QWJj1EH8mkF2TMTNoTgtFq3NxlbpW2cApRVmqPHPxWv+mMhPNF0b5gNJBXKQVE8yHiIHhO2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796261; c=relaxed/simple;
	bh=ndko24n15t+mnHRezbF9CHg+SXqbTCSHq/FiAHT2TMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2tk+E8uSGc92MxfF4hm9imt9eDsg1O30DrBk0ZYrhz5mCNjYd24lHOLGOeLV3xDvoafGURwr5Kh+4gjXHv+dUQFyf12nkBc/pArX/QeBNMObXLjCi051I3jldg4cmNJQM30Q2MaWbquyL5n9bavjDydHq/LMlj9IP/82Y11/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DKSB17jM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vmRVXEIT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAD8A7A00A3;
	Wed,  3 Dec 2025 16:10:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Dec 2025 16:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764796258; x=
	1764882658; bh=aqsZViPOKuna4IBUB2F9ngZwYeOFH1l2vRrwShyN6+g=; b=D
	KSB17jMnmzonF9hI4NY6tlNICw+0qBxHywjSSBq0byn8HoIDAXYXkopbkJuAIxcv
	0RgfDLDxq0ZABoyh301y+V0xF2cG/awKq0nF89VHcPALzzqCZRKAtmKk1uCrVfjm
	2bp1lcLWIHHpJd+yzcS7ZQtoHIXbnTPeeKRb9pg+BDD5hO9PE6k2FNYc5LFfhik+
	G+fF0rQv2vvnANRipjk95XmfGjs+EYhqjVDtvSgnTZCwtP3Sh06i1yTACJYJHmDG
	/6/6GNVaEffM/HASjEM6inhIdR9033o+7fHzN0G6F8pQ0D9K11YJNMGvgEiQX+Lw
	e4J4/XBpvcdCXU2A48c4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1764796258; x=1764882658; bh=aqsZViPOKuna4IBUB2F9ngZwYeOF
	H1l2vRrwShyN6+g=; b=vmRVXEITXTHDi1RWIMDcx2Q9IKJFsfvSjzGSn+5Rz5PE
	Lw0UgXbIq60uMjNsBmpBrVoWieKYK4vG9KeRkE9Wz/068zonEH7hLcDtPOzmvs8W
	jxSGn3Cy75eZ0xLJELoLmbX/aP7T0a+sm77LzKmIaUsgR2cKei+CWt35yLSDE1GI
	Gr0ORLKTTAJsFhxcHTEgBBvZh9cYTgLOlIra2OkXfIOUCr/df/97E6D/s6louiG8
	Txvif4gzLAhQBJunQjg8Jh5NyFjyTC2lonSR/8dfjF0ZKxmBFlL602pwMlRRLYrN
	IzJuNLgd0Euoc27FH9b/38hnxtEntR7yQHPV/dhfvw==
X-ME-Sender: <xms:YqcwaeQmLrNRb6zB-ECVj_vefyiZ3a-yxwr-dFwS53GPizuyG3Y7qg>
    <xme:YqcwaZwGWywTEb3_N-jSzysVPLn2-IcHE_2Ano86mw8UQZwqDgJMoJF7JRBQFmBCz
    B1LHwIYupvOLFDpkXBJD7hnADjwLPjpomCSbo6G58T0cndmyleNHsg>
X-ME-Received: <xmr:YqcwaZfuyj4PqO9xMPdcUjHlsyqfph5TFruTgsFeEkJl1IGaoWV5_6O2LFH1NwihopH5frz0ed2yUO7kfzjw728A7z0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffvedvhedtud
    efiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:YqcwaVKJ0Ru1jl8pgug7yzqwj33jG4QW4p0zqQg4pbY2AUepRPVa5w>
    <xmx:YqcwaaGh9bb6SB74ZRzDOIEnR4QXbaTlFrA9nmitxpUgxXy0WxHKmw>
    <xmx:Yqcwafpi0NGSe3buIVpFOgB_vaybfypvGGBe5a-eKeQ2gCRFI9qo_g>
    <xmx:YqcwaTRzs3SlBH5dMW8Jxw_tUAaVLikfgXjZsblFzAk4GY44wiBTvA>
    <xmx:YqcwaW1Oii_aCX2upILcaI2Xn0NHERh2w4ATTlstzTgK32FDoPkl31AP>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:10:58 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: relax squota parent qgroup deletion rule
Date: Wed,  3 Dec 2025 13:11:11 -0800
Message-ID: <4b63df0e26492b520b8b145e1d95e356ad89d51a.1764796022.git.boris@bur.io>
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

Currently, with squotas, we do not allow removing a parent qgroup with
no members if it still has usage accounted to it. This makes it really
difficult to recover from accounting bugs, as we have no good way of
getting back to 0 usage.

Instead, allow deletion (it's safe at 0 members..) while still warning
about the inconsistency by adding a squota parent check.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 51 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9e7e0c2e98ac..731ab71ff8ef 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1458,6 +1458,7 @@ static void qgroup_iterator_clean(struct list_head *head)
 	}
 }
 
+
 /*
  * The easy accounting, we're updating qgroup relationship whose child qgroup
  * only has exclusive extents.
@@ -1730,6 +1731,36 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
+static bool can_delete_parent_qgroup(struct btrfs_qgroup *qgroup)
+
+{
+	ASSERT(btrfs_qgroup_level(qgroup->qgroupid));
+	return list_empty(&qgroup->members);
+}
+
+/*
+ * Return true if we can delete the squota qgroup and false otherwise.
+ *
+ * Rules for whether we can delete:
+ *
+ * A subvolume qgroup can be removed iff the subvolume is fully deleted, which
+ * is iff there is 0 usage in the qgroup.
+ *
+ * A higher level qgroup can be removed iff it has no members.
+ * Note: We audit its usage to warn on inconsitencies without blocking deletion.
+ */
+static bool can_delete_squota_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *qgroup)
+{
+	ASSERT(btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE);
+
+	if (btrfs_qgroup_level(qgroup->qgroupid) > 0) {
+		squota_check_parent_usage(fs_info, qgroup);
+		return can_delete_parent_qgroup(qgroup);
+	}
+
+	return !(qgroup->rfer || qgroup->excl || qgroup->rfer_cmpr || qgroup->excl_cmpr);
+}
+
 /*
  * Return 0 if we can not delete the qgroup (not empty or has children etc).
  * Return >0 if we can delete the qgroup.
@@ -1740,23 +1771,13 @@ static int can_delete_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup
 	struct btrfs_key key;
 	BTRFS_PATH_AUTO_FREE(path);
 
-	/*
-	 * Squota would never be inconsistent, but there can still be case
-	 * where a dropped subvolume still has qgroup numbers, and squota
-	 * relies on such qgroup for future accounting.
-	 *
-	 * So for squota, do not allow dropping any non-zero qgroup.
-	 */
-	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE &&
-	    (qgroup->rfer || qgroup->excl || qgroup->excl_cmpr || qgroup->rfer_cmpr))
-		return 0;
+	/* Since squotas cannot be inconsistent, they have special rules for deletion. */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return can_delete_squota_qgroup(fs_info, qgroup);
 
 	/* For higher level qgroup, we can only delete it if it has no child. */
-	if (btrfs_qgroup_level(qgroup->qgroupid)) {
-		if (!list_empty(&qgroup->members))
-			return 0;
-		return 1;
-	}
+	if (btrfs_qgroup_level(qgroup->qgroupid))
+		return can_delete_parent_qgroup(qgroup);
 
 	/*
 	 * For level-0 qgroups, we can only delete it if it has no subvolume
-- 
2.52.0


