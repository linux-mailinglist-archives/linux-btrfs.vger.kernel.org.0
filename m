Return-Path: <linux-btrfs+bounces-8497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC698F160
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFBCB2309D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FA1CFBC;
	Thu,  3 Oct 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UQL1ETZn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EC19F100;
	Thu,  3 Oct 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965684; cv=none; b=B3Wb6AESY54mb+oTih009yKelufJpy6tYOCuCLe2VpGgPbr9KiPJhgJZDUl64DlqICqzprGz5jS2A8VClLNLrhviB1/3IQWrGRItE7sSVyNxHL2mIo39Rf/l/QCWAKE7TNslcVnHctnUB2KrUWmjvJ53y9bplO98iA92vCXuRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965684; c=relaxed/simple;
	bh=e2vBzQgDG3J70InybM+okDYij3ht//n4E24P3h7DHpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4qFuDGPndf7yLwJfK0aSCpx0DtJ0rgAOGSTZ/r4reaq4ZZ6vC1IE1bAR15tOUpNFrptx6sqGO+FfS6pyz1nmXXuKphDZZKyL2fRohts2ZgBT1MQNGvk1XUY7YNUDkRCt3O5muIgi4Ry4arsI/0iZrkUvluesQa4xP77ld/Ok/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UQL1ETZn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ryR75RtHi8480dF5YG3zRz82tnDhripKj2gfaZvDK8w=; b=UQL1ETZnmvmqUjCi
	aB8nbg82yne+QVR17QkChUsB/oO9oPUDaINuLV77Lpgy7QXGm7pL7SvEpTtjHvIGwEPG1gqxBLb5D
	Lf7ar+/At7L11v5Iq2bI8rsxGvQQhXlkwepsv/HUrWms27obuqoiMW+0dXjnV1TIc4G9NzBLNHfea
	x8uKCn5Mp8vT2YXm/5+XgY7MT8rcIEMfDuGLqGa+IzZrF6GvnncOk2OpPXpaIH0+0SW2JtitnHPIP
	H6o9gTpdyCIGjUdrX0cnCnUvqJum83DnH5cOlruPmhTkwB5ZF4ZNshn2NbLIkFsPTsxCR81pBaJHC
	UbhGEjVeZ3BvXdPVxA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1swMng-008fdF-0l;
	Thu, 03 Oct 2024 14:27:28 +0000
From: linux@treblig.org
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	hch@lst.de
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] btrfs: Remove unused btrfs_is_parity_mirror
Date: Thu,  3 Oct 2024 15:27:26 +0100
Message-ID: <20241003142727.203981-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

btrfs_is_parity_mirror() has been unused since commit
4886ff7b50f6 ("btrfs: introduce a new helper to submit write bio for repair")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/btrfs/volumes.c | 18 ------------------
 fs/btrfs/volumes.h |  2 --
 2 files changed, 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8f340ad1d938..7453b4999263 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5841,24 +5841,6 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 	return len;
 }
 
-int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
-{
-	struct btrfs_chunk_map *map;
-	int ret = 0;
-
-	if (!btrfs_fs_incompat(fs_info, RAID56))
-		return 0;
-
-	map = btrfs_get_chunk_map(fs_info, logical, len);
-
-	if (!WARN_ON(IS_ERR(map))) {
-		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-			ret = 1;
-		btrfs_free_chunk_map(map);
-	}
-	return ret;
-}
-
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct btrfs_chunk_map *map, int first,
 			    int dev_replace_is_ongoing)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 03d2d60afe0c..715af107ea5d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -735,8 +735,6 @@ int btrfs_run_dev_stats(struct btrfs_trans_handle *trans);
 void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev);
 void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev);
 void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev);
-int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
-			   u64 logical, u64 len);
 unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 				    u64 logical);
 u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map);
-- 
2.46.2


