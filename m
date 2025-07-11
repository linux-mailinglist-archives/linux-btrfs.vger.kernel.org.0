Return-Path: <linux-btrfs+bounces-15440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD6B01495
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90284B42944
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F661EE033;
	Fri, 11 Jul 2025 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J17kF1kv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB51E5B64
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218645; cv=none; b=PA1CXhy9FAxNDyRpNuIxg1DYHjgJfjY86FAXtTPc3vHrgitORi3Xbm3HIkhazKLwJZxVs7JLXOdjJxE4SaqfrdNOfqo+nTKtIBNkUKXKyD1novAmqs9koMBG/ZjPbLrlEkVpkuyalKoaFVJhJLvAYQqio9IKLVddYVkewbTOfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218645; c=relaxed/simple;
	bh=RQWOWJWimrwpqKsAQ8oPwZNDqFEOyDoJ1T7YUvSVcm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0voJHoy8NArU4ySD+PFVDhCUzSY6UVIj0rtutl2mOap8GwsWTc5EBH3opP5++fBiLj1DL9GAVZdCrf6cgUu1geLjoc9fj6nVxAQCN2wNvX0q+4TeD7N+ZuTTjRe1t3DDO4URrhx2BFY8eq0SMxxPN6JgPb+P8opjZQrIo8uiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J17kF1kv; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752218644; x=1783754644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RQWOWJWimrwpqKsAQ8oPwZNDqFEOyDoJ1T7YUvSVcm4=;
  b=J17kF1kvmmhaQDlHZeJuv7iIygz0TQJX73DcNrTuuoVGSnDX0K4Jx4sN
   DysxhQtEhMGpo8mbmN2ppo78JhX+vcuGqpY34BeXoLNjLVRGPGUjETEBo
   Q5Een7/b40T+x/tgz2NS/tbP0M9Db05Dmwt6AYUf8jO8jh9gEcAoEMFnh
   MyEWqr39J9Q9Uw+xyOVba7KiZTgTIV0cXePUmQ0NSvjuazQ+QEtpCZveo
   Dss/Mb2nmsCXhsNZkyMZzpWN/hc6XxP12wJ/Q1kmhGzj9q8V3FgrsjeGY
   AJkbnsmj8PmoSJtReWrzpc/TrYpv+baTrIxXc2U8MET7xT3O0MiEU/JNd
   g==;
X-CSE-ConnectionGUID: rjDhtKgDRmSDoUt7E1U8SA==
X-CSE-MsgGUID: mSwSt7lCRwyXkmTZtAV+CA==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="87607283"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 15:24:04 +0800
IronPort-SDR: 6870ad79_JyPPZnEOcvimw+63DFwqDcwhmpcreWEI24kfEJf1Y/3LZUY
 4oI19fR7q2u6098AITVXVcr1hbKa5tHLon6fBpQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 23:21:46 -0700
WDCIronportException: Internal
Received: from 5cg2012qjk.ad.shared (HELO naota-xeon) ([10.224.163.136])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2025 00:24:02 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/3] btrfs: zoned: do not select metadata BG as finish target
Date: Fri, 11 Jul 2025 16:23:38 +0900
Message-ID: <5489288e61c237c42fb11a024b5c1684f332279c.1752218199.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752218199.git.naohiro.aota@wdc.com>
References: <cover.1752218199.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We call btrfs_zone_finish_one_bg() to zone finish one block group and make
room to activate another block group. Currently, we can choose a metadata
block group as a target. But, as we reserve an active metadata block group,
we no longer want to select a metadata block group. So, skip it in the
loop.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 245e813ecd78..db11b5b5f0e6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2650,7 +2650,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
-		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM) ||
+		    !(block_group->flags & BTRFS_BLOCK_GROUP_DATA) ||
 		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			continue;
-- 
2.50.0


