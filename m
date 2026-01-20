Return-Path: <linux-btrfs+bounces-20766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDv7Bi0kcGlRVwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20766-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 01:56:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0C4EC06
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 01:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 535DD6A4652
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0366D3D3D17;
	Tue, 20 Jan 2026 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="cD4YVRm3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4B3C00B0
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913420; cv=none; b=Dvkx0v3fkxTRcup6o5ShajGQc7wKWqtvdJ9iayWJu32N3etRtQCJ16WlVK0rg/CJ0mqyESDqjDi7P13j6ZBEYI5tBnVRhv1biSgqCDdqyfJvmPULkSSPZFquoqV5dqAwHWVntkNv11HHIQqALyn3pfo6x/S5aIUm1gqHffNgS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913420; c=relaxed/simple;
	bh=iHpapYmCPRQBesvU2Zjl+JI2P//7RwZ7khmi5XSNCKk=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=FG0bUFdGFahLFgpR4gRrQCTYkpxVdLV9SUluO1hL780LjpPnRMu+Ik+TyN6h9lMXLTd9BgjrtC0FsfTBGuZxss8B6BZTkUFveeSQE33XAW+PajYLFpbi32bvCOQQvZZpNAzygYIUyLYHFCmUruda5KE4Vf/zX3RIUlTV2jQnvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=cD4YVRm3; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id E775F2F6B8E;
	Tue, 20 Jan 2026 12:50:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1768913405;
	bh=XbRGQL0gzl07yD3eql6++7UIEx2PstZwriXxU5ZKfOI=;
	h=From:To:Cc:Subject:Date;
	b=cD4YVRm3uFXC+a6uVZb616sa1YRJ/krZwVDb5LxCONpAFG3Axr9oylI7Uv3lUIECK
	 HbQJyR6HEiOSsR+8urS8iU/y0PwKMxRAY1r8yPP03OcfBV8jIUf6Kvnx1yLfNWxtEu
	 1EihnwZV6k1CYPp3ltrj2YwSHcc+d/YEYFGskk5c=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: avoid spurious -Wmaybe-uninitialized warnings in do_remap_reloc_trans()
Date: Tue, 20 Jan 2026 12:49:58 +0000
Message-ID: <20260120125000.26588-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20766-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_POLICY_ALLOW(0.00)[harmstone.com,none];
	DKIM_TRACE(0.00)[harmstone.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,harmstone.com:email,harmstone.com:dkim,harmstone.com:mid]
X-Rspamd-Queue-Id: 7FE0C4EC06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

find_next_identity_remap() sets the values of the start and length
pointers if it returns 0. Some versions of GCC are unable to analyse
this properly and give spurious -Wmaybe-uninitialized warnings, so
initialize the values in do_remap_reloc_trans() to avoid this.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 065db3f7840e..da4749d6bfa0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4940,7 +4940,8 @@ static int do_remap_reloc_trans(struct btrfs_fs_info *fs_info,
 	struct btrfs_root *extent_root;
 	struct btrfs_key ins;
 	struct btrfs_block_group *dest_bg = NULL;
-	u64 start, remap_length, length, new_addr, min_size;
+	u64 start = 0, remap_length = 0;
+	u64 length, new_addr, min_size;
 	int ret;
 	bool no_more = false;
 	bool is_data = (src_bg->flags & BTRFS_BLOCK_GROUP_DATA);
-- 
2.51.2


