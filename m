Return-Path: <linux-btrfs+bounces-15477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713E8B025C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 22:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E743A16BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F9277CA4;
	Fri, 11 Jul 2025 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgC+nvqI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6E1F4CA1
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265580; cv=none; b=UZ/EljQKOeixZAM6i/Dzp6LVCgPODv4KdPclr8TGE6lCaEnVEdqDtFyvpfBytV7r1SYV01ERGcBzTNaU+43t1Ql5EAMDCCZYwcruGlUZZj798qPC7rQsvxKp//gZyINTXh8+kY0zaseO3ZCQ6cvJmS9BTqFlULMct0fpvZFpCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265580; c=relaxed/simple;
	bh=gTadJrP0sSECGH/Nepgfdg60h3a1ljs9MjZJjl5/2uQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4vZFsasevTW59+WT+elTU76Ri9CJLNpnn5Oqa0gjYUKw8TJUscuzvdLpJ3CxfsMp8zH+uC2LB+BSeYmAApx2HXzp3dYwOYWHw3r5YzjkdgwpY7vdjpGM6qnzovwkEQ+3fSVSgMnrpKnIaCMRli2jJZDU3rilj1ihLjkVAZrkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgC+nvqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650A8C4CEF0
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752265579;
	bh=gTadJrP0sSECGH/Nepgfdg60h3a1ljs9MjZJjl5/2uQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DgC+nvqIdPRLi84uUUf/Zs7q/6qx2B257bwtSzsm9JOuORkfiU/IBZX3W7L9TfvHg
	 qCGZrlCaM9DZFmf/I5p3jZsB/QjunZ7/EA3zxPX4xvDaYlFtvU93kPTACzAdzN6s9Q
	 VPK/1sS4bU1lwWOf5g7Xqx/KNfcl02WASdvOrFzZaKcwlkyAm3fuJNs0g5vTHuVt21
	 B2XnVryzaEzeOxR/Z7fD4Fi4SCHGV7uVU4iRUPeuRM1uekKYF2mzPlfApi7D4gESwZ
	 +bAxotsbDAXtUAcAYOLvzem8KLpR3sysCXVc5RFbFkgK4npZwPliSH8qgHQKf3bkx9
	 MiG38oB+rR34w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use saner variable type and name to indicate extrefs at add_inode_ref()
Date: Fri, 11 Jul 2025 21:26:12 +0100
Message-ID: <6b69a670c446fadfda76eeeb13957bf3b434f19b.1752265165.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752265165.git.fdmanana@suse.com>
References: <cover.1752265165.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are using a variable named 'log_ref_ver' of type int to indicate if we
are processing an extref item or not, using a value of 1 if so, otherwise
0. This is an odd name and type, so rename it to 'is_extref_item' and
change its type to bool.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index bbd1fca19022..9366a3bd2836 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1385,7 +1385,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	unsigned long ref_end;
 	struct fscrypt_str name = { 0 };
 	int ret;
-	int log_ref_ver = 0;
+	const bool is_extref_item = (key->type == BTRFS_INODE_EXTREF_KEY);
 	u64 parent_objectid;
 	u64 inode_objectid;
 	u64 ref_index = 0;
@@ -1398,7 +1398,6 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		struct btrfs_inode_extref *r;
 
 		ref_struct_size = sizeof(struct btrfs_inode_extref);
-		log_ref_ver = 1;
 		r = (struct btrfs_inode_extref *)ref_ptr;
 		parent_objectid = btrfs_inode_extref_parent(eb, r);
 	} else {
@@ -1430,7 +1429,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	}
 
 	while (ref_ptr < ref_end) {
-		if (log_ref_ver) {
+		if (is_extref_item) {
 			ret = extref_get_fields(eb, ref_ptr, &name,
 						&ref_index, &parent_objectid);
 			if (ret)
@@ -1505,7 +1504,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + name.len;
 		kfree(name.name);
 		name.name = NULL;
-		if (log_ref_ver) {
+		if (is_extref_item) {
 			iput(&dir->vfs_inode);
 			dir = NULL;
 		}
-- 
2.47.2


