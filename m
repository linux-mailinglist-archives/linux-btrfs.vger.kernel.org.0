Return-Path: <linux-btrfs+bounces-21048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMR1JcQAd2lQaQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21048-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 06:51:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B1843BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 06:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C5A3019F34
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 05:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82291E2858;
	Mon, 26 Jan 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RjOFM6F7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB421B191
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406641; cv=none; b=t2AZWP4oQnMFdcNte9XHaJ6mTVbRAW1NhAMKk7PoyoW7t4TBr/RXO61RFzgt42MUMA2xLPnMm7HkgBsxD5Jbe63K/MY57EC0BXM7gthPD1Jx01hns0zppOfpUdZs6nv6dwCHXiEsm7zGFm3WFi77ojLMJWs/7eB173gWTgzpp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406641; c=relaxed/simple;
	bh=IhMTgeplbJ0ekqypYyBCJSg7Ohr/Zz6cHtX4tnCFBiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8ss4vGs0v46v6+WHEQegMkbcXDEVEqodFXzCRlxPw2pHAQ1GTx/TMNKBFY90JOeK883Vm2FG7zfUXE0TuLcz4l8Bz+cdN4kuoZKgA2CcEaLFkmYC8j04y58ZcQSNxEbH1QUAO5RFbhcz0UN/EkyXRkhB9Fx6s1JDhGNAGU1ZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RjOFM6F7; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769406639; x=1800942639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IhMTgeplbJ0ekqypYyBCJSg7Ohr/Zz6cHtX4tnCFBiU=;
  b=RjOFM6F7Hxbxdlz76w0mEQWe/3EOCIGRoCtrJZairu2cuyahfBxfAn/H
   yftHq8nQArVm8Xon0P45Q8ZiPMI4k6JtarTpjSsNLiiPah1BEz/yKmsc7
   PTBxgU4E/YeETlujN2XbAeC59VfssLszJ4xFVkEJ7Lg38FoVKbDv0vopt
   3dMpe6z1RPN+NQt3ndcu64q2VGn5o2Nqkvyc2SYKuxLnSxHBpBxLO+28t
   MpTkPstjJqPW4IdzDpzlZIMMOXAnrrIYlNcPJCWoeMUplsZHGfb9IeyZR
   ULi94vmecK3W4hD6tHMnXuyHzlo6eypSzP3zhFJK/vxcKUM1c4koI/ohF
   w==;
X-CSE-ConnectionGUID: tmmT36gUQaOFiGxZlnzvPw==
X-CSE-MsgGUID: aYAOtT9qR3eRxdYkhAZ0bw==
X-IronPort-AV: E=Sophos;i="6.21,254,1763395200"; 
   d="scan'208";a="139468890"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2026 13:50:31 +0800
IronPort-SDR: 697700a7_v190iGmKvMWhMRnGZ4UtbvK176FAWoZy2yCExZv136h1Om4
 +FASUmPBKr+QYNkLmf1frRbTPc5zfgHNdEaNIsQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2026 21:50:32 -0800
WDCIronportException: Internal
Received: from 5cg2075g8f.ad.shared (HELO naota-xeon) ([10.224.105.93])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2026 21:50:32 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/4] btrfs: tests: add cleanup functions for test specific functions
Date: Mon, 26 Jan 2026 14:49:50 +0900
Message-ID: <20260126054953.2245883-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126054953.2245883-1-naohiro.aota@wdc.com>
References: <20260126054953.2245883-1-naohiro.aota@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21048-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 151B1843BA
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


