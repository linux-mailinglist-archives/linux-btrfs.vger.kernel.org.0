Return-Path: <linux-btrfs+bounces-22293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKiCK7cXr2nHNgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-22293-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 19:55:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBFC23EED2
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 19:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C17130CE454
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2026 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED53ED136;
	Mon,  9 Mar 2026 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="D03BgmY+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327536165F
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Mar 2026 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082257; cv=none; b=LqGLLQWW3QZZEsscX3PUAkMqkYxNwZt14RvO+46I7kFjIY6YNBl5BcJLrmbHatYF5Szt5r82YamvWT0uC0Zt4TXjkURyZcjykaddPWrl3qY9pQhKNI2i67bFps1D4Edtr/VXoKlDNzOeKEV4CZT9629hgCe4qapM0hmrY47FCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082257; c=relaxed/simple;
	bh=zc1Y9VWp88CSmhFgndMa9Pzyyhw+s39LLrnXKzwkFss=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=IFSldmKaCDDaJ0iLgW7DS33IZkJLMzpzGCZTX0iJos/IjnvaZOsMtlPrMCOyxrH/clit6HzftesPgvKH/9foNN9zfCvhJeRHJ0cij1DipWeX92Vi2ISvXhFolWgIBeM0esjnaa3xQl74qrVSY1FrLXYRzDw83X2vvQ1CwhwJ6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=D03BgmY+; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id B750B30CF67;
	Mon,  9 Mar 2026 18:50:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1773082252;
	bh=Tw7nIz9NvNgMkGRSh00MVX+wmt9PRoKWRuI7UPReVUs=;
	h=From:To:Cc:Subject:Date;
	b=D03BgmY+NpHV1C7QCVxIBohnZeNMeIb3XF+Vcs8ubpXy8qzDuW6JIw+EHI5g9cfcb
	 PliT0LW4vR+kzkhrXZsvXacU0gNL+iU3/eUYjD/pXuBBBNx0Hm2T23rqM8JS/UyeiW
	 Y70vrpSWNCshwU4TfSlhoHnugQbWbLHI/AAGYle4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	Johannes.Thumshirn@wdc.com
Cc: Mark Harmstone <mark@harmstone.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH v2] btrfs: fix potential segfault in balance_remap_chunks()
Date: Mon,  9 Mar 2026 18:50:37 +0000
Message-ID: <20260309185050.5895-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5DBFC23EED2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22293-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[harmstone.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fb.com:email,harmstone.com:dkim,harmstone.com:email,harmstone.com:mid]
X-Rspamd-Action: no action

Fix a potential segfault in balance_remap_chunks(): if we quit early
because btrfs_inc_block_group_ro() fails, all the remaining items in the
chunks list will still have their bg value set to NULL. It's thus not
safe to dereference this pointer without checking first.

Link: https://lore.kernel.org/linux-btrfs/20260125120717.1578828-1-clm@meta.com/
Reported-by: Chris Mason <clm@fb.com>
Fixes: 81e5a4551c32 ("btrfs: allow balancing remap tree")
Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/volumes.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 95accc9361bd26..aff286d9df4aa0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4285,20 +4285,24 @@ static int balance_remap_chunks(struct btrfs_fs_info *fs_info, struct btrfs_path
 end:
 	while (!list_empty(chunks)) {
 		bool is_unused;
+		struct btrfs_block_group *bg;
 
 		rci = list_first_entry(chunks, struct remap_chunk_info, list);
 
-		spin_lock(&rci->bg->lock);
-		is_unused = !btrfs_is_block_group_used(rci->bg);
-		spin_unlock(&rci->bg->lock);
+		bg = rci->bg;
+		if (bg) {
+			spin_lock(&bg->lock);
+			is_unused = !btrfs_is_block_group_used(bg);
+			spin_unlock(&bg->lock);
 
-		if (is_unused)
-			btrfs_mark_bg_unused(rci->bg);
+			if (is_unused)
+				btrfs_mark_bg_unused(bg);
 
-		if (rci->made_ro)
-			btrfs_dec_block_group_ro(rci->bg);
+			if (rci->made_ro)
+				btrfs_dec_block_group_ro(bg);
 
-		btrfs_put_block_group(rci->bg);
+			btrfs_put_block_group(bg);
+		}
 
 		list_del(&rci->list);
 		kfree(rci);
-- 
2.52.0


