Return-Path: <linux-btrfs+bounces-21714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJq8H4OzlGlbGgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21714-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:29:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC4514F237
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C753305ED2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4D372B36;
	Tue, 17 Feb 2026 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="lcwU9l01"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B21C69D
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352760; cv=none; b=V8DH+rVotZaYrakf+RcgyPtUcNi5OW1+GAwjG4IRs5nVo707IomNt9Zz8nry5B4Fu+0OcC/icTB0iRjFzF1LzLUBDG965DZ0fnuF8U1RBRjJCq0pvbn4lDfjS9tC+OMOa9WCxdeKdsjnKl5NZFp4z2GpfI3TxkBNvZXYdpsOdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352760; c=relaxed/simple;
	bh=lrYae7Rv46myMJQMaZ7rG47NY+Oe7RIpA++sKNor4vY=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=n6F83cjxrMOqIj4Mr4vWxS1cufqpFJi4a5O24gE56AOV10N+JCvvBMwYSXqI8W0MPFPCKXf3vuw9T5qAvyNPBtjVnFLE+O1BmeF/8imtdEEv3n85G1lS+yeOX8uw5rif43xW5Nlh7bwh5FrOTimzN8jf3I4ffVIZ7stUCMOn5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=lcwU9l01; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id E47153030FA;
	Tue, 17 Feb 2026 18:25:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771352756;
	bh=T4CWHC9OinpYhLPsWJseEUjXdRUGCxR4hcEwif26pe8=;
	h=From:To:Cc:Subject:Date;
	b=lcwU9l0197LLl66d3I4qzfXwsJ7UTeAImLgCTWm5GB9QZf2f+VS8s7XFTBxHbMh8n
	 3s6AXAcnaIVlcYlKBFb/lDbazViqD5xnSrfYJFMNP2Lq1soPE0+97AQ4jikIOd9KMD
	 I1chiRkN/6vNitTLVEnuu2vvbdCx8JAFfVYuNrxw=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	fdmanana@suse.com
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: fix error message in btrfs_delete_delayed_dir_index()
Date: Tue, 17 Feb 2026 18:25:42 +0000
Message-ID: <20260217182553.18091-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21714-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[harmstone.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:mid,harmstone.com:dkim,harmstone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAC4514F237
X-Rspamd-Action: no action

Fix the error message in btrfs_delete_delayed_dir_index() if
__btrfs_add_delayed_item() fails: the message says root, inode, index,
error, but we're actually passing index, root, inode, error.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Fixes: adc1ef55dc04 ("btrfs: add details to error messages at btrfs_delete_delayed_dir_index()")
---
 fs/btrfs/delayed-inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1739a0b29c49..2746841c167d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1657,7 +1657,7 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
 "failed to add delayed dir index item, root: %llu, inode: %llu, index: %llu, error: %d",
-			  index, btrfs_root_id(node->root), node->inode_id, ret);
+			  btrfs_root_id(node->root), node->inode_id, index, ret);
 		btrfs_delayed_item_release_metadata(dir->root, item);
 		btrfs_release_delayed_item(item);
 	}
-- 
2.52.0


