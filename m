Return-Path: <linux-btrfs+bounces-4881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762058C19BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 01:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAD71C22D1D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF3786245;
	Thu,  9 May 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="S+4jtbxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8mRvA1c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266410A0D
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295960; cv=none; b=Ev5G6bKtyL+S9D4eldMYO8sefmRsfuw858tVJbzKUCGyMJ89UGZDIcreoBUMta4fxIui/enQfdN9dZ7o6NgZYXrUIe6hkDSXPAt+7mhmjM8ToQpNNEW0c+lchR74WZGwoAw15FUhyvX1u28fOled9EgljIu3F3q6HQUwJfl0I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295960; c=relaxed/simple;
	bh=Z7ng3DXk4wn+54g7O2keiyY3qwuryqMKS3s9dVNHPMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DBhHbWZvhIL3J9+jSgGMo6O2Dsp5fSw07Hn07wzEIKpaY/80Yx13diP5YYkxMemiXMr/+sB4I71eN8f9HlkJ1MsB1rEet07TFchqzN0oCyS7I9NFvo0/QmfgbfLhuQJ8mn3S2LdY7bE35szGPETlYs+yUzcPlgdCr9S4UCWxtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=S+4jtbxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8mRvA1c; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1D6671800151;
	Thu,  9 May 2024 19:05:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 09 May 2024 19:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1715295956; x=1715382356; bh=GGxANge+xIvZAEuCwwOT8
	s0rygjLZ908+wa6BLahrDA=; b=S+4jtbxWYGKIPgELtdl+BVRLl+e1E+f+BV5oZ
	RLcfgVkrgQ5vtWlZv06Cl1e8hz+fNswcMf+jqKbcvSTDMpaZ5bBDfDBPION/O+dl
	vdzi0cX2Uu84jYtcNeqN6BtZTWaQKAz5pWYJo4UeY1cTnHMXyWJmBsd6gewZ6VIb
	U/K0APWMRVGY1gn6fLYyXhYUqaHPP4Jqyni8uBjP4zpoNQ9p4bCu2EF5bSOFYkLC
	5rN3Qb2/MId1KYovzFv2J4YTC+8FdjhJEuYxJacmaFSRF2+iJ0fiNDbm8WBg6tbQ
	LgaEDpmMyE0XmmL0p+BvERo8G5wNVbZqUMEvyXYEyZFPBNH9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715295956; x=1715382356; bh=GGxANge+xIvZAEuCwwOT8s0rygjL
	Z908+wa6BLahrDA=; b=H8mRvA1cJv9lUVyQTYmj7n9OIGeO/EtTNr4T/6qxY/P1
	OSRcTBMEJMVKy19vowe/a9TlfkAlfUnPHVzaSywz7YvO/eOuYnkMYdNHh4VrIGEu
	Zc4QeO+L0XYckzLoDnF2jW4A88KU9UqRCpgP+uEZY/hMKWmfKEuSxDUgFee0bSrT
	Dbux8KawVhdIVmnUX97M42PE2kD0SwED1HCPsb084JZDlhSzRSZzFStm4wxyJI8U
	2ekA9f2yrTiJ+JpIwmAhrde7P8fg9QTw0wIzatrQU/Q2puqktUNc0DjkDOs1mdOj
	B3RRbmmF8fMJLifegOwlqLPm39tezrVFDu4koFQYeg==
X-ME-Sender: <xms:1FY9ZoZP5VPmiNDcJMbH-DbllpUXe8cs8hK4i-SnHReKufztAEuwQw>
    <xme:1FY9ZjZck4laKWIlPUxHv--js8xWi515c5mkeZvMrkjV9rXS4cFGz9QcztjZ_U6aZ
    q_UOhNlsvJ5c7OVohw>
X-ME-Received: <xmr:1FY9Zi8fv8WfzPBttGIz5VPwdilMdiqn5c34W-vy_2euCq5joQlFpMwMF4spojH8ZsrSsvtnj-bVOx4I-T_830WGVfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeffedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:1FY9Zirtm65rnMcGFlj_MQou5xmmZ5HdiQ4jOfyh49fpbTkZc6y7iA>
    <xmx:1FY9Zjp7c7rCafvznaLCxORpSrcTiKCkdYyfLVkEuBl8QQ675xkK8Q>
    <xmx:1FY9ZgQwQIrubgDnDzcbkUH8ZxcU2PC1emJ7COEGUvz7lqBiP6jfZg>
    <xmx:1FY9ZjqbxbaxUMaE8Zxlb7HZxBo8_TX5xtGvNrmrgUQ9DDWCLsPPnw>
    <xmx:1FY9Zq31mFQLKX1GvYkyACYM6Rfh4o-QQGRY-_0M1yFRLyOw7SxgdvSV>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 May 2024 19:05:56 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix qgroup id collision across mounts
Date: Thu,  9 May 2024 16:07:45 -0700
Message-ID: <f7e7c99aded1f18703dd19ec6b92cf3c7d635060.1715296042.git.boris@bur.io>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we delete subvolumes whose ID is the largest in the filesystem, then
unmount and mount again, then btrfs_init_root_free_objectid on the
tree_root will select a subvolid smaller than that one and thus allow
reusing it.

If we are also using qgroups (and particularly squotas) it is possible
to delete the subvol without deleting the qgroup. In that case, we will
be able to create a new subvol whose id already has a level 0 qgroup.
This will result in re-using that qgroup which would then lead to
incorrect accounting.

Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2cba6451d164..243995b95e63 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -468,6 +468,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 		}
 		if (!qgroup) {
 			struct btrfs_qgroup *prealloc;
+			struct btrfs_root *tree_root = fs_info->tree_root;
 
 			prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
 			if (!prealloc) {
@@ -475,6 +476,25 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 				goto out;
 			}
 			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
+			/*
+			 * If a qgroup exists for a subvolume ID, it is possible
+			 * that subvolume has been deleted, in which case
+			 * re-using that ID would lead to incorrect accounting.
+			 *
+			 * Ensure that we skip any such subvol ids.
+			 *
+			 * We don't need to lock because this is only called
+			 * during mount before we start doing things like creating
+			 * subvolumes.
+			 */
+			if (is_fstree(qgroup->qgroupid) &&
+			    qgroup->qgroupid > tree_root->free_objectid)
+				/*
+				 * Don't need to check against BTRFS_LAST_FREE_OBJECTID,
+				 * as it will get checked on the next call to
+				 * btrfs_get_free_objectid.
+				 */
+				tree_root->free_objectid = qgroup->qgroupid + 1;
 		}
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 		if (ret < 0)
-- 
2.45.0


