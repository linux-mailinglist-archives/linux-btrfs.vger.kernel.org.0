Return-Path: <linux-btrfs+bounces-15481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF1B025D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 22:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635C9A40359
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A822A4DA;
	Fri, 11 Jul 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfCBFwMS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5545209F2E
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266206; cv=none; b=oXcSLx3vh+1xvmfjqLzolpijdB1bELJ/9M3THBrLDulKYveQgWEqHSmRJYc4d8umv1ccAThibHbPi+WgLt7q1L0d2l/K2u5k2bEH6LAu+XZUDO66AmaHk6KmS0DdlsmxUwAz1shkOeAENOnkHfauvjAsvzZYtzUE6RaGo5OMYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266206; c=relaxed/simple;
	bh=VBYh3cN8JRUef/lwGQMfmGrgyZ7A9u5EFb+VPDSidso=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGuS76LWcI6weKu3pNYwOWCY6yi/x6tLitUs9Uw+BezaeH7WPDeoB5PN4Xz3cFugAFF5nA+/7z/18mpm2K/emA018HiIoXT8cf2D3RtY+CdlBWKoAFoui55jBDU6q6ju3X/mQRNaD5xcuO2nprKTPEhz3I931CyIbRFXwLQc6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfCBFwMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEE8C4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752266206;
	bh=VBYh3cN8JRUef/lwGQMfmGrgyZ7A9u5EFb+VPDSidso=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DfCBFwMS19zzpdgcvm6389X0ZAeYnm2pYPAMQGHjwtVe6359GRu3TC/ofmPoj1CaU
	 az1zuCq8MPtyNL6H9bq85mspd5+eUzN00TXCqOP36BPkMU9SgtZ5EDOJ2ysuFGnqX1
	 EUHHpCVwNWpaSGjcDbjbuHcojn+5hQQ79rGX6q+ZKNBDfg2D8ZZXf9nh1HkTjE0kNH
	 L5KaldrBHvNm/FB6aUL0V7W1OPB4rHmz9dSVeou0aOUOuHUBdKHkNxh+Si78HmeEpz
	 r5uMG8/FD64xReBFAF0lNWdsk5vlJ8gecCYwsu65eZV5RCQZAngvmglpkxOoh4vVf4
	 duIdNpkgKOR/Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: use saner variable type and name to indicate extrefs at add_inode_ref()
Date: Fri, 11 Jul 2025 21:36:40 +0100
Message-ID: <d71618c5bb919f58ab51b0623c5bc08115a447c2.1752266047.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752266047.git.fdmanana@suse.com>
References: <cover.1752266047.git.fdmanana@suse.com>
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
 fs/btrfs/tree-log.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 354761a8cbc1..8ad6005257b8 100644
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
@@ -1394,11 +1394,10 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	ref_ptr = btrfs_item_ptr_offset(eb, slot);
 	ref_end = ref_ptr + btrfs_item_size(eb, slot);
 
-	if (key->type == BTRFS_INODE_EXTREF_KEY) {
+	if (is_extref_item) {
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
-		if (log_ref_ver && dir) {
+		if (is_extref_item && dir) {
 			iput(&dir->vfs_inode);
 			dir = NULL;
 		}
-- 
2.47.2


