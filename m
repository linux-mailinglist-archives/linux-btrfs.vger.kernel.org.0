Return-Path: <linux-btrfs+bounces-15090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496CDAED897
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD3D3A45AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A965244699;
	Mon, 30 Jun 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AXEJxg12"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65224467C
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275436; cv=none; b=RAUajlEGdAD02zHAfCF/ypZ5YMEJxWdi4O3A4E5wL5akRLmbpuW/Yq9L05W1xcc4Sm2BbqvslLtw0D8h2ArrvhxN66htG0BXE8Fn6kOzREykd0R3zzhe5ds6t8ZUoDv937C5kq4fxgoMrpoes3o85jWyp1PLGqxoK9xay9qh+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275436; c=relaxed/simple;
	bh=XL3iEZCBhL/zcYJRHh/xqMAkgEzR88LIghSfX7XbqlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA4Jx0sF7cdMXLsZLdUqw4Bhp6nlFBlT4u2cH/NMvNQvRvTqLShgZ6EwfyNIPwdrL1g1w0Ja47y63/xo/8nN1rYnW5aKGa2IlVLDv4YU1Pn++cJCXpj5z8xHVIdUunvlRDsYGCApPyD2pYJXaUomr5C+NnbJKMJZ5xGit2fmUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AXEJxg12; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751275435; x=1782811435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XL3iEZCBhL/zcYJRHh/xqMAkgEzR88LIghSfX7XbqlU=;
  b=AXEJxg12MhfZZmwxEZsv2cbBUs4AnyHrlDuRdqcxhEH32p0SuFLa5PZm
   EdYltVaWg+y+2ohQ7BpqqncWkkO1Bt4W+fL/urMlrdm26kEt7B+te7AAh
   VGWZlWm2t1R5PO0BFfBU1boUOYgrEpK7/PUrIgs5KRyTT2eEQgG0hEfoU
   T1kcTvQ5j+qKQ+SNqlq0B57KQxLvFetmptcj2SkAQ9QLALTdmSO80f0Za
   UQ2mM5/4zucwy6h/vfU30r71zS5hLP1jgmrBYCBWbtF1qLWvNPs5pswwk
   5+4vWnaSFVaI3kyknqmD0aja06QVpvO+pSmnE8dP4bUeKHzD7CZbaFaHR
   Q==;
X-CSE-ConnectionGUID: uFXAZ4u1QuCsCbYo34bEpQ==
X-CSE-MsgGUID: iNg7LRmsSFatCZS1FHWnFQ==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="84975635"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 17:23:55 +0800
IronPort-SDR: 68624923_nL8JQBSdaYG6/2nYw/2wPBIEmdaijMsZf0ahBg3J6YUWqXK
 iPsIFKqf3KK5aAKXRuf7fYwLmUOxb1ZkFVUEI7Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2025 01:21:55 -0700
WDCIronportException: Internal
Received: from 5cg2174243.ad.shared (HELO naota-xeon) ([10.224.163.146])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2025 02:23:53 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: requeue to unused block group list if zone finish failed
Date: Mon, 30 Jun 2025 18:23:31 +0900
Message-ID: <077e0b74b72da529e4817dbbcbd38a9c902e6799.1751273376.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751273376.git.naohiro.aota@wdc.com>
References: <cover.1751273376.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_zone_finish() can fail for several reason. If it is -EAGAIN, we need
to try it again later. So, put the block group to the retry list properly.

Failed to do so will keep the removable block group intact until remount
and can causes unnecessary ENOSPC.

Fixes: 74e91b12b115 ("btrfs: zoned: zone finish unused block group")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d9afaddeeab0..4eef86dac6e3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1631,8 +1631,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		ret = btrfs_zone_finish(block_group);
 		if (ret < 0) {
 			btrfs_dec_block_group_ro(block_group);
-			if (ret == -EAGAIN)
+			if (ret == -EAGAIN) {
+				btrfs_link_bg_list(block_group, &retry_list);
 				ret = 0;
+			}
 			goto next;
 		}
 
-- 
2.50.0


