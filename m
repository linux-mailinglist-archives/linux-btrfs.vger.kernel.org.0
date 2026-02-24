Return-Path: <linux-btrfs+bounces-21897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DBVLjQcnmntTQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21897-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 22:46:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F0318CEE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 22:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2419F30490D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF933D6EB;
	Tue, 24 Feb 2026 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="XwNhiBYj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FF335BBB;
	Tue, 24 Feb 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969570; cv=none; b=mSwii0TVDIcs191O+WOC/jXQlk9rpLv+fSkQn4b4ODdCvHPpngcYIIb/K2jaXOmvFUNZhskjKdKN6ezGBiO+aDb+uBol2JWsSMXS99jr6D+m2+VHqqdmtU9cIGO4CuJrCC/B1fEyFRquhIfeJTLa9TsbDBX43F19B0298Ak71YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969570; c=relaxed/simple;
	bh=oDIp4rrws0iR0RSPeNtUFX597nES8/SwmwYJxOCvRLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gqcpzPwm2+F0mOaWpfyMkrKiULCqSpWOUwpx8zUXe9VU0ycfHnwgZXTEAMGPhaBK0GCTxBOJzH2SDcICZGcHJBidioSp1lzX5lXhWBUC51OaWw3qRIxx3Hh4CGYIMUiyTkFBqgexUtvFZO7LIz1f3kfQUFXlxBJ+JDpOSxATYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=XwNhiBYj; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fLB9j1B90z9v67;
	Tue, 24 Feb 2026 22:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771969561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=33FKgAtf2f7M7LoPcOjrSsduyUQKGhkao6BfRtXNVDA=;
	b=XwNhiBYjvZxg4sy6CHECw2PQ1wq2q5wE5n6I8qnIWMX8MmjrVVs0e5nZ0vuPRrnixln5WM
	evGFGAIZmF/KrXFmt8F+llbCsuAwtYhY1A8PGVff3Rh1AlLMd916zT9wYeeQJ2hwMQj+ij
	U+4XPOTGgpwy5JH9oNi52MgpRZ6QVoqU0MhP8bSKCq6f1nAkvSqerzryGjAD3G8s+EimnQ
	gCZ3LeBxCE3KZlMdImKWRoDyTDccFc15Dmo4J41tUfnWnhR+kdEbyvVGyXoUghmO5BYhlZ
	jRBezCu8Qs4H8NK9YO689NWP7E8zI21JIbWrUOVXQ3c3dEN7E78yJn01TRzA3A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::102 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: dsterba@suse.com
Cc: clm@fb.com,
	naohiro.aota@wdc.com,
	kees@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2] btrfs: replace kcalloc() calls to kzalloc_objs()
Date: Tue, 24 Feb 2026 22:45:44 +0100
Message-ID: <20260224214544.562283-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.33 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.83)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21897-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mssola.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mssola.com:mid,mssola.com:dkim,mssola.com:email]
X-Rspamd-Queue-Id: 58F0318CEE1
X-Rspamd-Action: no action

Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
introduced, among many others, the kzalloc_objs() helper, which has some
benefits over kcalloc(). Namely, internal introspection of the allocated
type now becomes possible, allowing for future alignment-aware choices
to be made by the allocator and future hardening work that can be type
sensitive. Dropping 'sizeof' comes also as a nice side-effect.

Moreover, this also allows us to be in line with the recent tree-wide
migration to the kmalloc_obj() and family of helpers. See
commit 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for
non-scalar types").

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
Changes since v1:
  - Better commit message as suggested by Johannes Thumshirn and Qu Wenruo.
  - Link: https://lore.kernel.org/all/20260223234451.277369-1-mssola@mssola.com/

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

