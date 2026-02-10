Return-Path: <linux-btrfs+bounces-21607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGTzIYcwi2kFRgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21607-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 14:20:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45B11B2AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEAEC3038503
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048A32939A;
	Tue, 10 Feb 2026 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bRGfrS7i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E2328B7B
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729592; cv=none; b=kOmrq/AiHASL5hgKe4nhU5rDM8IbFUxiAF3grzWVztUlZ6aBQL2m9teyMcljJSO3MJ0UfrzzdG5kS9zuQ+XJS9Ol5+LF8WqTR7j4qYfHSj+muWiP7eUdQJdfaDbh8beAdslLvqGG9LmsITLIm1b1CYoHYJiyBwIWUgi/c17wtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729592; c=relaxed/simple;
	bh=bN/JaH2qGWIuxtRBubXXm67DssucKxnfRNVkyec9+OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzpm7ZyCTCVrJuDwzn0it+Xmr+qW1Vp3vzQCUL9x49GX+4WWbg/pYOXbPMjiyfwV2WqDdrzOsxVe6INFbCy/o4tXgrQgbuGhkmMTQVcdGJqcF5954kBRb939VBn5SZM+YSSHTq3F5+ifsem2fBa3D1s3rUeiM1clA2pM2LgNjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bRGfrS7i; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770729589; x=1802265589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bN/JaH2qGWIuxtRBubXXm67DssucKxnfRNVkyec9+OQ=;
  b=bRGfrS7iIsfkK7EwzsAqmo6GOjLLjXvZ7uvIoMXSBRHVWTeP3FGL4xAM
   vlNjM0S0GRE+grMJZxVAYujfLIHCYqxsBMo29aT/Da9LSxYbHN+WGZdKr
   kyavHb/OEnnabjhjHBTjBix0kJzY2Cfiw6y7HA2SHLum4p79/Nuprv523
   nLIPOZ49uI+gf4eqSK33sYcYJmbwiQCMj+HBncKNYfVHvmSYUj5joiiRt
   zwmq/g7VZIyfJJdlo0CY9vZn2M9LF9IJQCido29xHnEBmJ1N6XSld82sG
   ZJgZQWIXEHAYRLMlKOF+jbff5s8r65720qvt1zcADPyC54ol/pszW/AXU
   Q==;
X-CSE-ConnectionGUID: 83NfjawkQKusP8UijXN/yA==
X-CSE-MsgGUID: hLSYa3AGQ7iPm/tpzkUOVw==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="136955027"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2026 21:19:49 +0800
IronPort-SDR: 698b3076_lbEotpuq+y4tY2sbDOU+/KG1lqVKRG7Cyc1W8OJDxAMfMaS
 TR4I3NyuHjJGNtgWSXwSNevlJVjZAiA48Eelsyw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 05:19:51 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.118])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2026 05:19:48 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: change return type of cache_save_setup to void
Date: Tue, 10 Feb 2026 14:19:46 +0100
Message-ID: <20260210131946.286557-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21607-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA45B11B2AF
X-Rspamd-Action: no action

None of the callers of `cache_save_setup` care about the return type as
the space cache is purely and optimization.
Also the free space cache is a deprecated feature that is being phased
out.

Change the return type of `cache_save_setup` to void to reflect this.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e3e7852dd3e0..0857b720667f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3288,9 +3288,9 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 
 }
 
-static int cache_save_setup(struct btrfs_block_group *block_group,
-			    struct btrfs_trans_handle *trans,
-			    struct btrfs_path *path)
+static void cache_save_setup(struct btrfs_block_group *block_group,
+			     struct btrfs_trans_handle *trans,
+			     struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct inode *inode = NULL;
@@ -3302,7 +3302,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	int ret = 0;
 
 	if (!btrfs_test_opt(fs_info, SPACE_CACHE))
-		return 0;
+		return;
 
 	/*
 	 * If this block group is smaller than 100 megs don't bother caching the
@@ -3312,11 +3312,11 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 		spin_lock(&block_group->lock);
 		block_group->disk_cache_state = BTRFS_DC_WRITTEN;
 		spin_unlock(&block_group->lock);
-		return 0;
+		return;
 	}
 
 	if (TRANS_ABORTED(trans))
-		return 0;
+		return;
 again:
 	inode = lookup_free_space_inode(block_group, path);
 	if (IS_ERR(inode) && PTR_ERR(inode) != -ENOENT) {
@@ -3398,10 +3398,8 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	 * We hit an ENOSPC when setting up the cache in this transaction, just
 	 * skip doing the setup, we've already cleared the cache so we're safe.
 	 */
-	if (test_bit(BTRFS_TRANS_CACHE_ENOSPC, &trans->transaction->flags)) {
-		ret = -ENOSPC;
+	if (test_bit(BTRFS_TRANS_CACHE_ENOSPC, &trans->transaction->flags))
 		goto out_put;
-	}
 
 	/*
 	 * Try to preallocate enough space based on how big the block group is.
@@ -3449,7 +3447,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	spin_unlock(&block_group->lock);
 
 	extent_changeset_free(data_reserved);
-	return ret;
+	return;
 }
 
 int btrfs_setup_space_cache(struct btrfs_trans_handle *trans)
-- 
2.53.0


