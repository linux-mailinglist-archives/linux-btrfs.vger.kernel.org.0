Return-Path: <linux-btrfs+bounces-22269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGO/LzLkqmkwYAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22269-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Mar 2026 15:26:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D06D222A49
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Mar 2026 15:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BF4A3035F52
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2026 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B431A046;
	Fri,  6 Mar 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="iGQWzYsR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF910363C40
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Mar 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807190; cv=none; b=Y5KrpnghE9hOoLupgNm2Cdlifsb0q35g2LMg3bnR4dZ5vqrDtcecjkK/ZPx3hTyhlyd06fBYNJWJNF6i8jAb3Yl/DsRWapDR7CrrpmdVeurTqgR4s0BVcL+M76ODKE5VXyeFHLeUfEY/qTjv/C9hrBZDPILlPCvbg5E8DRs/beA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807190; c=relaxed/simple;
	bh=rpyetv7bQBx7o6auSSyoOSJ+TA375QjMHqe7lepqGdw=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=HkWWwb9tqgxbB6b+KnSSfaTyxNEUZMw+j7yOIyg3w0DGGZF22FtqMZtWech35mVFBLmfo644Pxjgp5KwD10WFUT0cXepuKlaFIugyBdj3+hw0rvG9nh1B3Ry4pleT+vG3OmEQOlct77uSqNZqaNyS3iEhe7s6khL3fFiyqdjE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=iGQWzYsR; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 436AF30B837;
	Fri,  6 Mar 2026 14:18:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1772806731;
	bh=D7PtTxPH0UVzUN9lgM0TetcAloMxa5zUl/MbhPNPI0s=;
	h=From:To:Cc:Subject:Date;
	b=iGQWzYsRPp0+4yCxgqWo8AMXrbHDdB+6MjI3gKEhEB1Xml+vA/vxYGZET8MA53EFJ
	 vQtKGycERMxS9gt9igjD8NYfANTjGMgLlPbJlfwSPBZr5KmEkR3E9/x4P6XiJPXfUh
	 C3kXqJ+AqeKOzzEStNIYYTHXCfOBbT2r5uvCtWbw=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	Johannes.Thumshirn@wdc.com
Cc: Mark Harmstone <mark@harmstone.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH v2] btrfs: fix use-after-free in move_existing_remap()
Date: Fri,  6 Mar 2026 14:18:31 +0000
Message-ID: <20260306141843.27186-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D06D222A49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22269-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[harmstone.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

There is a potential use-after-free in move_existing_remap(): we're calling
btrfs_put_block_group() on dest_bg, then passing it to
btrfs_add_block_group_free_space() a few lines later.

Fix this by getting the BG at the start of the function and putting it
near the end. This also means we're not doing a lookup twice for the
same thing.

Link: https://lore.kernel.org/linux-btrfs/20260125123908.2096548-1-clm@meta.com/
Reported-by: Chris Mason <clm@fb.com>
Fixes: bbea42dfb91f ("btrfs: move existing remaps before relocating block group")
Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/relocation.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 88b1ec416fe272..1c42c5180bddd5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4177,6 +4177,8 @@ static int move_existing_remap(struct btrfs_fs_info *fs_info,
 	dest_addr = ins.objectid;
 	dest_length = ins.offset;
 
+	dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
+
 	if (!is_data && !IS_ALIGNED(dest_length, fs_info->nodesize)) {
 		u64 new_length = ALIGN_DOWN(dest_length, fs_info->nodesize);
 
@@ -4287,15 +4289,12 @@ static int move_existing_remap(struct btrfs_fs_info *fs_info,
 	if (unlikely(ret))
 		goto end;
 
-	dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
-
 	adjust_block_group_remap_bytes(trans, dest_bg, dest_length);
 
 	mutex_lock(&dest_bg->free_space_lock);
 	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
 				       &dest_bg->runtime_flags);
 	mutex_unlock(&dest_bg->free_space_lock);
-	btrfs_put_block_group(dest_bg);
 
 	if (bg_needs_free_space) {
 		ret = btrfs_add_block_group_free_space(trans, dest_bg);
@@ -4325,13 +4324,13 @@ static int move_existing_remap(struct btrfs_fs_info *fs_info,
 			btrfs_end_transaction(trans);
 		}
 	} else {
-		dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
 		btrfs_free_reserved_bytes(dest_bg, dest_length, 0);
-		btrfs_put_block_group(dest_bg);
 
 		ret = btrfs_commit_transaction(trans);
 	}
 
+	btrfs_put_block_group(dest_bg);
+
 	return ret;
 }
 
-- 
2.52.0


