Return-Path: <linux-btrfs+bounces-21912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOC1HlPRnmnwXQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21912-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:39:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C333A195DE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B840D30DDE01
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D35392C40;
	Wed, 25 Feb 2026 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="tx0hXFeZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90E288C3F
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015761; cv=none; b=Z1xjzJ/1+I3h4bZ/wNIDtACOZ1ndSGsRRrb35hTmN+tD7ZITuliQTgimRz2Yf1lFKsoaWYEnCVncD8SRSg8C2zfibWMhupo7NWIrX+HCkqh4MZomxK7cluUpA401VJ6dVEm0IBnD7VNGKahlB7ySUe6QVppH5DCvx8ZjehbwUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015761; c=relaxed/simple;
	bh=plPTjm/UtOHxg93kqgEO7JdF/oAnYfxwdBVrmMT5iNY=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=KjHaomzmKIaD8dM23j0ZCyvCSibX6XX2KRc3HSKi6NS9v6y0KUGD9+tnT/gUoGE5kqL0YrIxNrrKa0sU2g6Xyi1T2nmjR7muxsdBzWQD3MNn6Grsddjh3NnvClHLYwyBVaJt8J7doNWJwVHZe6DW7SF19MfQbTD6aZnIgnFujVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=tx0hXFeZ; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 5C00A306F2C;
	Wed, 25 Feb 2026 10:35:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1772015758;
	bh=jCmEJ6uLDLh3gU9qwkbmqNJHU00cf/DCNuLzKToXM3Q=;
	h=From:To:Cc:Subject:Date;
	b=tx0hXFeZV/s3ai3+/sqZ1h6o8Q1H7qN1BT5B+snJEaYB3z7PZnI124Dqb7BNYYajg
	 noyAqoRmieyx2UC0G7ya24YGAI7q9K3ydiQefydHKjpqUbcP/hIHPrjyyHIrIEylk5
	 Kzvb7zyat/+aH/vP0ON+QarJNl1PgG/FrbWUamP4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	boris@bur.io
Cc: Mark Harmstone <mark@harmstone.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: fix use-after-free in move_existing_remap()
Date: Wed, 25 Feb 2026 10:35:51 +0000
Message-ID: <20260225103557.18457-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21912-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[harmstone.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,harmstone.com:mid,harmstone.com:dkim,harmstone.com:email]
X-Rspamd-Queue-Id: C333A195DE4
X-Rspamd-Action: no action

Fix a potential use-after-free in move_existing_remap(): we're calling
btrfs_put_block_group() on dest_bg, then passing it to
btrfs_add_block_group_free_space() a few lines later.

Link: https://lore.kernel.org/linux-btrfs/20260125123908.2096548-1-clm@meta.com/
Reported-by: Chris Mason <clm@fb.com>
Fixes: bbea42dfb91f ("btrfs: move existing remaps before relocating block group")
Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/relocation.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cc80760ba5e7..5a8644667620 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4295,14 +4295,17 @@ static int move_existing_remap(struct btrfs_fs_info *fs_info,
 	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
 				       &dest_bg->runtime_flags);
 	mutex_unlock(&dest_bg->free_space_lock);
-	btrfs_put_block_group(dest_bg);
 
 	if (bg_needs_free_space) {
 		ret = btrfs_add_block_group_free_space(trans, dest_bg);
-		if (unlikely(ret))
+		if (unlikely(ret)) {
+			btrfs_put_block_group(dest_bg);
 			goto end;
+		}
 	}
 
+	btrfs_put_block_group(dest_bg);
+
 	ret = btrfs_remove_from_free_space_tree(trans, dest_addr, dest_length);
 	if (unlikely(ret)) {
 		btrfs_remove_from_free_space_tree(trans, new_addr, dest_length);
-- 
2.52.0


