Return-Path: <linux-btrfs+bounces-21913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDOlJ37RnmnwXQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21913-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:39:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03734195E01
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC9231026EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8EA392C3E;
	Wed, 25 Feb 2026 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="JkQsIVXU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F41392C44
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015774; cv=none; b=n0BZxBUXgNtftyugZHkJaSlyoKCobVxco3Xh9DXCf+G8tg/M/XJbVeUDKWmFqKxwReH9dJCImIV2ULVedL3br0GqUIUEUNJrhUyXH5IjfvdmrVvJbP7yUczt3zlzZbzzE/O17kldwvLyZqSM96CcdCsrQy9enfHkgi/Ciw7+sFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015774; c=relaxed/simple;
	bh=jPGvTfStZuEJHP/UpF5+oCDy5ew1q7b4yg/dDZnrEAo=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=WsDj46KsW6qDCcdP1b/nVnwiMrAUTISEk7YIpOxqo76uNhJUkXDtHsd7JQODlFophmuW7CRVIGU8GR8R1tQcR6fnWmBgqoOfawe7e7JTweOf/oyZCd8wriO4bfeLk8qHcgYBV7XJKgw5Gu1VfSD6DJEOXxIZpskxeszwGuRHcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=JkQsIVXU; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 05704306F2E;
	Wed, 25 Feb 2026 10:36:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1772015771;
	bh=c0OKfdCm4W8PJQ14Onqs3XxwEOOVI85BCJYJfueRT2I=;
	h=From:To:Cc:Subject:Date;
	b=JkQsIVXU0ZcQHu+jiifnBY05+v0MFTiMg6966G0akm9Gv2YHfpsEu+/RzZ4AeUOAe
	 /f0mG0Y6j8MRKnuSuRhRsL1JN7jZ936EY7U593oKxf1eiYp/60a27YTnU92QzJXUq8
	 PaXhEdijFx526UDYTwsh8gWZbfGjBEaIYdLBWOZE=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	boris@bur.io
Cc: Mark Harmstone <mark@harmstone.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: read key again after incrementing slot in move_existing_remaps()
Date: Wed, 25 Feb 2026 10:36:06 +0000
Message-ID: <20260225103610.18494-1-mark@harmstone.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21913-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 03734195E01
X-Rspamd-Action: no action

Fix move_existing_remaps() so that if we increment the slot because the
key we encounter isn't a REMAP_BACKREF, we don't reuse the objectid and
offset of the old item.

Link: https://lore.kernel.org/linux-btrfs/20260125123908.2096548-1-clm@meta.com/
Reported-by: Chris Mason <clm@fb.com>
Fixes: bbea42dfb91f ("btrfs: move existing remaps before relocating block group")
Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/relocation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5a8644667620..2dee4d708f95 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4394,6 +4394,8 @@ static int move_existing_remaps(struct btrfs_fs_info *fs_info,
 
 				leaf = path->nodes[0];
 			}
+
+			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		}
 
 		remap = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap_item);
-- 
2.52.0


