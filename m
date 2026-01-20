Return-Path: <linux-btrfs+bounces-20762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB6BE2lbcGm8XgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20762-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:51:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF351393
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16C528866B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA0425CFF;
	Tue, 20 Jan 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoZZ8peA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1B4279E6
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911959; cv=none; b=ZvpY44+hfWVdbw2HEuAi3rmrlpPzKwxcJG2hBQgXASA4sMn/VHZPVWCX5VKqk76r1ZNe4HJcA/tR6OD1AWZ96Cn2j573AnoaBlZ04QQIYWLkbYWQLdpJgjiJEZ2srXqfr98/JMTH19w/vrYoob7CcLwauRRuY/xcC+d+G/DtCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911959; c=relaxed/simple;
	bh=B28a4UKaSqD9vAZnpcOB3rkRoKj5ouDc9DGXF3FNzTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJxL/fnOC7KedkOGQQvdkUDsnI7e9SFRMUXxSC/ym3SgMOtVC7s6/OGHZo5jwnLzXkusLEnB9SXa+zbySHvXDmuD3BrZfoqG5BR9GoSyEKEpwCFVvsCDveSnmQdKm8kQD2jFUSR5v4FWTw6oVBNGm7Fnp6pYWJWPAuvzI3+2npI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoZZ8peA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEEFC16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911958;
	bh=B28a4UKaSqD9vAZnpcOB3rkRoKj5ouDc9DGXF3FNzTY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JoZZ8peAjH/cYptePb3PzQeAUyhBkGsxYdtwenrpSRzVa9lOzXxyaBHoEyXTWaZpn
	 JK/I2sCV612orovEZNPaDzp/3Lnb39d/AuDdNMZmY0CDPlKkuuSrewMipPkj9dNSyq
	 uisTWfZvcFKUN+4pZWXrQB7bDImmC8rRlRjc5DwdrdKTAaT2/iH67DjpebPL105oQF
	 mDtScV9H6LRG038WFE0uoxrK/UY66VGWPbsX+lfXcL67O1OTAb09D0j43nbCfemv8H
	 glFFbvbSwJbxN4L+54fXLtthGEomSkg1CZqW+dZVhLOPIPLO5OhYvt0597yMoBPb8y
	 OoMAR6i3T1hGw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: make load_block_group_size_class() return void
Date: Tue, 20 Jan 2026 12:25:51 +0000
Message-ID: <cf72f36e6b9b09727c2ccda8d8b2b1fb95d7eda9.1768911827.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768911827.git.fdmanana@suse.com>
References: <cover.1768911827.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20762-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BBCF351393
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There's no point in returning anything since determining and setting a
size class for a block group is an optimization, not something critical.
The only caller of load_block_group_size_class() (the caching thread)
does not do anything with the return value anyway, exactly because having
a size class is just an optimization and it can always be set later when
adding reserved bytes to a block group (btrfs_add_reserved_bytes()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4fc4d49910bf..343c29344484 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -673,27 +673,29 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
  * 3, we can either read every file extent, or admit that this is best effort
  * anyway and try to stay fast.
  *
- * Returns: 0 on success, negative error code on error.
+ * No errors are returned since failing to determine the size class is not a
+ * critical error, size classes are just an optimization.
  */
-static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
-				       struct btrfs_block_group *block_group)
+static void load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
+					struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_key key;
 	int i;
 	u64 min_size = block_group->length;
 	enum btrfs_block_group_size_class size_class = BTRFS_BG_SZ_NONE;
-	int ret;
 
 	if (!btrfs_block_group_should_use_size_class(block_group))
-		return 0;
+		return;
 
 	lockdep_assert_held(&caching_ctl->mutex);
 	lockdep_assert_held_read(&fs_info->commit_root_sem);
 	for (i = 0; i < 5; ++i) {
+		int ret;
+
 		ret = sample_block_group_extent_item(caching_ctl, block_group, i, 5, &key);
 		if (ret < 0)
-			goto out;
+			return;
 		if (ret > 0)
 			continue;
 		min_size = min_t(u64, min_size, key.offset);
@@ -704,8 +706,6 @@ static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl
 		block_group->size_class = size_class;
 		spin_unlock(&block_group->lock);
 	}
-out:
-	return ret;
 }
 
 static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
-- 
2.47.2


