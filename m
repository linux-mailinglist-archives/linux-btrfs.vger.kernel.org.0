Return-Path: <linux-btrfs+bounces-21853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C74BU7nnGmNMAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21853-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 00:48:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF88E17FFA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 00:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CE0830A75C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D1352C4F;
	Mon, 23 Feb 2026 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="FhQNwLfN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E736922A;
	Mon, 23 Feb 2026 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890330; cv=none; b=BUT7I5EiwvJeg0I15wSytAvrarLuSBAhPciL8ObQUMskKnIwy2tRJglrRNES5u0dtNQ89cDdYlppZVILT3RT6bUQfXQvDMwDP/uPisVvklN28VMTYcrUX3C+ynE8v56Xj+0zQkpJApdY9x78Y1BcIN06pfK4oqePJDPRAl3dvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890330; c=relaxed/simple;
	bh=8I/dq7cdrizds3KhOIYX14dAEy9tMRU0nrq5gQZoRYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CubBJBxpJjoqci6WR5v5bM8m/TpW6scuuVPBhTpJ6mK3NxQPPis87up6LoKGXQ64kE9cp2X2uVb+gC7wxGH2wFuTKnL5+eVcsht14LAQPFt8SuYpHJIjnM4EYRE2fdKFZ001YtVnMZtV/NURDfGwgtiYmtniWL6+qF06etgjeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=FhQNwLfN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fKcsp3ZW6z9v2K;
	Tue, 24 Feb 2026 00:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771890318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XpY1Ib4zweeJ+PfvS2Uc7dNIlFCvNM88XH29jdLRAeM=;
	b=FhQNwLfNJAyAVXJnce/WloXxRijrO2gQ6NryOX/3RrwBUB6tD58OEjDEYAh4pbcWVf/uRr
	DrROWhGrbWz6Q5d7CKDztgaqcovs/tdtAYwv4G0PuuRH9benT6Ljx17BqeM/u4S2VOtavU
	rOiKyTHCchRUB0OcIzGzDzymOyXKSm6sHROYpKxKg5OcFOsw/BQ7qEWRc2WyvD8tSpK3J5
	pSjo5dc8N7yeQfuivI9ud9Eaof3AnkUhl0Eu6oWDnRm4GmB8goOc0WzDvZwGn+58ioP0oa
	0C9ITQO9L8Z6xGEu5SrZk4LsOgDUzoYjijq+Mh4KkjFYe4ysQ9aoWOX0NZNmbA==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: dsterba@suse.com
Cc: clm@fb.com,
	naohiro.aota@wdc.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
Date: Tue, 24 Feb 2026 00:44:51 +0100
Message-ID: <20260223234451.277369-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.25 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.91)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21853-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mssola.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mssola.com:mid,mssola.com:dkim,mssola.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF88E17FFA1
X-Rspamd-Action: no action

Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
introduced, among many others, the kzalloc_objs() helper, which has some
benefits over kcalloc().

Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/block-group.c       | 2 +-
 fs/btrfs/raid56.c            | 8 ++++----
 fs/btrfs/tests/zoned-tests.c | 2 +-
 fs/btrfs/volumes.c           | 6 ++----
 fs/btrfs/zoned.c             | 5 ++---
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 37bea850b3f0..8d85b4707690 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 		io_stripe_size = btrfs_stripe_nr_to_offset(nr_data_stripes(map));
 
-	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
+	buf = kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 02105d68accb..1ebfed8f0a0a 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 	 * @unmap_array stores copy of pointers that does not get reordered
 	 * during reconstruction so that kunmap_local works.
 	 */
-	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
-	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	pointers = kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
+	unmap_array = kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOFS);
 	if (!pointers || !unmap_array) {
 		ret = -ENOMEM;
 		goto out;
@@ -2844,8 +2844,8 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 	 * @unmap_array stores copy of pointers that does not get reordered
 	 * during reconstruction so that kunmap_local works.
 	 */
-	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
-	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	pointers = kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
+	unmap_array = kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOFS);
 	if (!pointers || !unmap_array) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/btrfs/tests/zoned-tests.c b/fs/btrfs/tests/zoned-tests.c
index da21c7aea31a..2bc3b14baa41 100644
--- a/fs/btrfs/tests/zoned-tests.c
+++ b/fs/btrfs/tests/zoned-tests.c
@@ -58,7 +58,7 @@ static int test_load_zone_info(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 	}
 
-	zone_info = kcalloc(test->num_stripes, sizeof(*zone_info), GFP_KERNEL);
+	zone_info = kzalloc_objs(*zone_info, test->num_stripes, GFP_KERNEL);
 	if (!zone_info) {
 		test_err("cannot allocate zone info");
 		return -ENOMEM;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e15e138c515b..c0cf8f7c5a8e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5499,8 +5499,7 @@ static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-			       GFP_NOFS);
+	devices_info = kzalloc_objs(*devices_info, fs_devices->rw_devices, GFP_NOFS);
 	if (!devices_info) {
 		ret = -ENOMEM;
 		goto out;
@@ -6067,8 +6066,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 	ctl.space_info = space_info;
 	init_alloc_chunk_ctl(fs_devices, &ctl);
 
-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-			       GFP_NOFS);
+	devices_info = kzalloc_objs(*devices_info, fs_devices->rw_devices, GFP_NOFS);
 	if (!devices_info)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ab330ec957bc..851b0de7bed7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1697,8 +1697,7 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
-	raid0_allocs = kcalloc(map->num_stripes / map->sub_stripes, sizeof(*raid0_allocs),
-			       GFP_NOFS);
+	raid0_allocs = kzalloc_objs(*raid0_allocs, map->num_stripes / map->sub_stripes, GFP_NOFS);
 	if (!raid0_allocs)
 		return -ENOMEM;
 
@@ -1916,7 +1915,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	cache->physical_map = map;
 
-	zone_info = kcalloc(map->num_stripes, sizeof(*zone_info), GFP_NOFS);
+	zone_info = kzalloc_objs(*zone_info, map->num_stripes, GFP_NOFS);
 	if (!zone_info) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.53.0


