Return-Path: <linux-btrfs+bounces-21840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGEUIqZmnGmsFwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21840-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:39:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870E17826A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39451309A62F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB834D392;
	Mon, 23 Feb 2026 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YF0DcadQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BBF350A3A
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857513; cv=none; b=ZaTzEkkGmqzYUZJNeo6Gdmao/iri1XXkVg1aWzfC4l6jPKELhIEikQqB2Lq7jq3/182x9n+9KWEdsqktC21RlkN58tUmiJGfYj23TMKQQwAVg4j+b5LAW0H9p/l/jmGfajUVuMRpwug/TeFUL14yNzqHzavREHU1W5D5zQ1FNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857513; c=relaxed/simple;
	bh=45vbYV0UF6uP63bRnMJnRzELH/2ul/DDPqzwHrUjuUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3fKkNgkAzbVIBS3nE+CxPeopAaTbwnUKKihBlXbJG6JManJO3PviCj0DYe/1f6OnYsxq6Ku+PKjuxK7f6v4M4YHpbJWMXXajGbH/pYt0w0MZWpm09/2ULKVWmrVRtDdUkyyULXBBwXw2C8kroYIrAemS1YvZ18UUHwqrWDXDJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YF0DcadQ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771857509; x=1803393509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=45vbYV0UF6uP63bRnMJnRzELH/2ul/DDPqzwHrUjuUY=;
  b=YF0DcadQDHjXmk4ytntaQ1+KfRQ6ftIfZ1gcDTeBaI3niCFecJHysAk8
   8uhVYsWXXzbUTBQCqOb96HPbMnS3G0RvfWM9iJp4PhRSkOaf92vbUVAED
   hj+dftVmWtQq4CMbEsqXVnRnNZGjVtmLeBJnSzerDYiOP0igH/MAY66Cs
   J+/luzIrNjWLuzg9NtVJJVIM1Bn2K7kdUBcfmC9Q5me43+5G4VuJ8ljtL
   naBPXIOlXQRxFwz9CC1yXh2ku3xcK6N+9ECdS62Gz5BTYIMi5p4rCdAXq
   Wz9uImOeLSr3Nukl2x8wbSkG9bTJ82Csc+H6wY4wk2M0+6GX44bkFGZAI
   g==;
X-CSE-ConnectionGUID: jeU6elEcTq6oKd80H4QOYA==
X-CSE-MsgGUID: 1TP+pCx/Ts2iLfy68h8Zwg==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="142368127"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 22:38:23 +0800
IronPort-SDR: 699c6661_Qz+ppmILWOyXjE3CJkraN6vxyEX6rpOKnJFlEd8jNQ9Y6Pc
 YY5mDrpr/XwDn9O/fjLpCF/F/g6soyic/IjyJFQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2026 06:38:25 -0800
WDCIronportException: Internal
Received: from 5xf42j3.ad.shared (HELO neo.wdc.com) ([10.224.28.143])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2026 06:38:25 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: catch aborted trans in btrfs_zoned_reserve_data_reloc_bg
Date: Mon, 23 Feb 2026 15:38:20 +0100
Message-ID: <20260223143820.89931-1-johannes.thumshirn@wdc.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21840-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: 1870E17826A
X-Rspamd-Action: no action

btrfs_zoned_reserve_data_reloc_bg() is called on each mount of a file
system and allocates a new block-group, to assign it to be the dedicated
relocation target, if no pre-existing usable block-group for this task is
found.

If for some reason the transaction was aborted during the call to
btrfs_chunk_alloc() and btrfs_end_transaction() is executed, a
NULL-pointer dereference happens in btrfs_end_transaction().

Check if the transaction was aborted before calling into
btrfs_end_transaction() and if it was aborted return early.

Fixes: 694ce5e143d6 ("btrfs: zoned: reserve data_reloc block group on mount")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f64b872d53ce..265947fde727 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2842,6 +2842,9 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 	ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC,
 	       "space_info->subgroup_id=%d", space_info->subgroup_id);
 	ret = btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
+	if (TRANS_ABORTED(trans))
+		return;
+
 	btrfs_end_transaction(trans);
 	if (ret == 1) {
 		/*
-- 
2.53.0


