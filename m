Return-Path: <linux-btrfs+bounces-20964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHexMetwc2lNvwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20964-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 14:00:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2732E76158
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 14:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB5EA30333E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A62F99A8;
	Fri, 23 Jan 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f/gjf30P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994D2E764C
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173198; cv=none; b=G2W6ghrWQ4qLSsRSyp6FUuf9GJ6HsJyk0fdw+ktFkzbb5OqA7n9lQA9zF1gxddRvGmxK/406pMRRizo/oDbzEzATCdySxDSmrp0RGYz1PdDaAOipkRMXAeVFQjK3n6ARcBoBTZKJIOKRwVnS/ld4QxFarLXCelL/9i075B+JSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173198; c=relaxed/simple;
	bh=30B7JtCZG+sAiKahK/R1fm+w58MykB62NOgVPmsxC1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxsM//ghe+o6SYNg8x+nkFje7x6Wy6LRYMjDQ24xbEabUVlJRTLNm6Kk5QzRblvnxF5x2//FUwoLZwULFPXDt1qLV600PiCOI19wiB/cyTcSZn4fNdf8HJu2+Ct1DVSGpedzyclC284f3IqhLju8Uprh4/e93Ovk19D/+Y/Z8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f/gjf30P; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769173195; x=1800709195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=30B7JtCZG+sAiKahK/R1fm+w58MykB62NOgVPmsxC1g=;
  b=f/gjf30PkIVvptAEkGLg0GGwtNRTZamhCR47vYl1RYyn8vLl4SRTc+5k
   /fDzK+DcosDt2UIi4cotL42o7seFibf6VKqpiZ9yRCuPenRQm+BL1Llbc
   d4eSfvG3svWvI1WOyKj2SVLS8i5u7h/KZTIrkKRDdep6KJoJttT8FgcDc
   pOaAftjwzt+j2mnlqaPLrzsLyzvbs/8UYkYbcBJ+FD2sJ1uvcC8n0XuAE
   fJqN0QHHKMd4jDy42sN1Jor1lljl8juXnfcTaarKLqcJgyhkPCYM1fEVr
   KvhFKtm3ZCBPhWgYjeC5D1hSpau8Aej6MVsecF5xWj0etputdgmF4mptm
   w==;
X-CSE-ConnectionGUID: QFKXucJmQaSg4fiXUxVTDg==
X-CSE-MsgGUID: PmNVj8ASQSOcF6MXkqxn/w==
X-IronPort-AV: E=Sophos;i="6.21,248,1763395200"; 
   d="scan'208";a="138590779"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2026 20:59:48 +0800
IronPort-SDR: 697370c6_dNH0WJJjI2SP25a/2mGsu4YtZ3fOo6u0PzUr0XG2o3d3Ybn
 f6LjVnBZLVP78v7Nwes5qenaxmZEAiHYgNqyTZA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 04:59:50 -0800
WDCIronportException: Internal
Received: from 5cg2075g8f.ad.shared (HELO naota-xeon) ([10.224.105.93])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jan 2026 04:59:51 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/4] btrfs: add cleanup function for btrfs_free_chunk_map
Date: Fri, 23 Jan 2026 21:59:18 +0900
Message-ID: <20260123125920.4129581-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123125920.4129581-1-naohiro.aota@wdc.com>
References: <20260123125920.4129581-1-naohiro.aota@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20964-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 2732E76158
X-Rspamd-Action: no action

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e4644352314a..8b88a21b16aa 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -633,6 +633,7 @@ static inline void btrfs_free_chunk_map(struct btrfs_chunk_map *map)
 		kfree(map);
 	}
 }
+DEFINE_FREE(btrfs_free_chunk_map, struct btrfs_chunk_map *, btrfs_free_chunk_map(_T))
 
 struct btrfs_balance_control {
 	struct btrfs_balance_args data;
-- 
2.52.0


