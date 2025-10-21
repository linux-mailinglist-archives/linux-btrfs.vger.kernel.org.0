Return-Path: <linux-btrfs+bounces-18117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA8BF715C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DF1542780
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56B33DED2;
	Tue, 21 Oct 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="0tYh6Nke"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBE33CEB1;
	Tue, 21 Oct 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056913; cv=none; b=KhRbdb6sJmWiDv+TVIrvbPsxBQ/0pAq10G+P0rlrrsL6G4D+EZJ3haSp4BfCHYk8EI5K/bZjLCMTh2ivIICcjIu0bZe/kRfeJ24yMhL6ypmzA7JnhepYKtk69vNJ3b7A3Egd1ykchSO0v/GWiqWWPShGMjwBZYRbdC9vnCVCAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056913; c=relaxed/simple;
	bh=kIjr2ON/PurIYOXE+LNsjEc2BbF67/ys+PB2KDggH2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG4HtzRGDRvA71lhbdCyJnLz/nxL70ibueySqhqBQyqrRgf2Ke+Q+7OhCs/Jt3uciuQiwqLGK3aLml+96EurVG5fhpDHk0b7jLCqod/R2DHY34D1MCjp5n1kYR2RwJe46c9I3RnYGSKdFea1oX43WUjGkZsXh2ze6LCVPFbkBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=0tYh6Nke; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4crZR00gqLz9ttm;
	Tue, 21 Oct 2025 16:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761056908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x3oERtMwu9v6VSR766wyFue1jS0wUt8HyF2GQPQzSU=;
	b=0tYh6Nke7uPFz4pSjzTyBWQIujeuYe1lOoJ1S34z3MEvEPb7Pq8wPBCw2+ohmACoU2NoJv
	AHceXXjHrP4aQ9pfQDgD6Jx+b/CZPUSo9LyHGYe4rMwrRhkM5gC9QdezN+0jV8/iIFUKNM
	TSfTPlh7pr7BCOEmgJouEAxFsAmUAdqS3YGIKmtLWP9cvSkWTwEDKAc+kd5KKe1d53cXLe
	UpB3t0OU0X597GqQ1/nZery7UGM4GYMLFSw3H1dtrByD3cRzT5WHJblfR/0jXYUkcBTS1E
	hmwYe4kZ+IjhOlN+gh+ik75GiVVX7yXXvUcmxG5TXdWBRruC4jfgXmOYkBY7Lg==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	fdmanana@suse.com,
	boris@bur.io,
	wqu@suse.com,
	neal@gompa.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 4/4] btrfs: add ASSERTs on prealloc in qgroup functions
Date: Tue, 21 Oct 2025 16:27:49 +0200
Message-ID: <20251021142749.642956-5-mssola@mssola.com>
In-Reply-To: <20251021142749.642956-1-mssola@mssola.com>
References: <20251021142749.642956-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index 6adb57d5c958..664135240803 100644
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


