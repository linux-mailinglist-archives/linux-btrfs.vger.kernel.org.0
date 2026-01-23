Return-Path: <linux-btrfs+bounces-20963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N9zHOBwc2lNvwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20963-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 14:00:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6781176150
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 14:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E116630093A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028442F4A1E;
	Fri, 23 Jan 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gQ1+kxEF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70281DE4DC
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173198; cv=none; b=MwerEzBMGSAW0P+U+gP0XByfZBEOxJUcnOAxxJENo94pWLi+2yQ18DxXbBcWHh2VsSe6S5pcfRbCMqfNDznO0BF9EuUlixJ2RfXkSeR3AMcF3k7yx1jHuoYHUdNmWQnlD/KTheGMLDVleXZocB/3KrY/QeVFAuVa4kRbCC4B4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173198; c=relaxed/simple;
	bh=IhMTgeplbJ0ekqypYyBCJSg7Ohr/Zz6cHtX4tnCFBiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzN2r7nhsElrHNuprmaPPDDRLNUg7NjNAX7e5aMwq2TEVvBES4QNgyDLqnsj32/C0c7DupksslFU27xbF5xdE8bQUfvd0oQMvr4M5Aszb8X5f1CjrnF4nIgJQqJi9YUklMIvU17OOhLe7dm/7m1f4vGRgib6QEytZrZPTnViY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gQ1+kxEF; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769173195; x=1800709195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IhMTgeplbJ0ekqypYyBCJSg7Ohr/Zz6cHtX4tnCFBiU=;
  b=gQ1+kxEFScQVgxGR6yd+M4fhm0YMyF6/hqESLz0MS/WNda+rrgeg1/YL
   MU/OgD05zOmf5Z7FXTf/83aCqQa26k7XeE49mrwnijR2iBM1Hp1MdNZXB
   8y4nHx+w0YsZGmVHVUuDVC40ftNXxuKSsKjsQcoPrjR0xoQiLFfHH6gC5
   ZcFeSCzRmPhiQOnDVOLbcDgEdmpzpv5X1IiSceN3gK3dazucgaF1aJX1h
   Fpnk/eEYuEHAoliNy7DS+mdSDaCiH6A3vkCJ2UcOplenLtlanxt9+tm6T
   HopSyWjb//RwokF1mS4iRMJmWYddIQ+EWhdataMKL5ELGUEqXe7Gj2kS7
   A==;
X-CSE-ConnectionGUID: MmPt9PrgTruWDmcbWuEo4A==
X-CSE-MsgGUID: geu4pqErRl+rtw0e6u+i+w==
X-IronPort-AV: E=Sophos;i="6.21,248,1763395200"; 
   d="scan'208";a="138590778"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2026 20:59:48 +0800
IronPort-SDR: 697370c5_0Dyxnr7PSs5i1CN97hcU7MNZ6ORR1r7DEQUY1LINn0SMez7
 R8cHUu/218zJB7v/kAwNNA8jO3Gc2V6KH7mdtbw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 04:59:50 -0800
WDCIronportException: Internal
Received: from 5cg2075g8f.ad.shared (HELO naota-xeon) ([10.224.105.93])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jan 2026 04:59:50 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/4] btrfs: tests: add cleanup functions for test specific functions
Date: Fri, 23 Jan 2026 21:59:17 +0900
Message-ID: <20260123125920.4129581-2-naohiro.aota@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20963-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 6781176150
X-Rspamd-Action: no action

Add auto-cleanup helper functions for btrfs_free_dummy_fs_info and
btrfs_free_dummy_block_group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tests/btrfs-tests.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index 4307bdaa6749..b61dbf93e9ed 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+#include <linux/cleanup.h>
+
 int btrfs_run_sanity_tests(void);
 
 #define test_msg(fmt, ...) pr_info("BTRFS: selftest: " fmt "\n", ##__VA_ARGS__)
@@ -48,10 +50,14 @@ int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize);
 struct inode *btrfs_new_test_inode(void);
 struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize);
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info);
+DEFINE_FREE(btrfs_free_dummy_fs_info, struct btrfs_fs_info *,
+	    btrfs_free_dummy_fs_info(_T))
 void btrfs_free_dummy_root(struct btrfs_root *root);
 struct btrfs_block_group *
 btrfs_alloc_dummy_block_group(struct btrfs_fs_info *fs_info, unsigned long length);
 void btrfs_free_dummy_block_group(struct btrfs_block_group *cache);
+DEFINE_FREE(btrfs_free_dummy_block_group, struct btrfs_block_group *,
+	    btrfs_free_dummy_block_group(_T));
 void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans,
 			    struct btrfs_fs_info *fs_info);
 void btrfs_init_dummy_transaction(struct btrfs_transaction *trans, struct btrfs_fs_info *fs_info);
-- 
2.52.0


