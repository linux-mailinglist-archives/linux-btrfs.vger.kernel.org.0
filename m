Return-Path: <linux-btrfs+bounces-10072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4553C9E4EE6
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8411665C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30E1C3F0E;
	Thu,  5 Dec 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Reg1ER9k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F121B87F5
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384968; cv=none; b=aP/ElumvdzH5cD9JJT0xRlhzsMbaWa89B18J6Bl2qKL+Hb4GQCVvw2j/4YkOr9doVvoxCWNWFS3ZezQatENrUPAE526TwrhFoi0LNX92Fm4Gwy3Ak87ZuPbp0q8CBTKW+ii739yyky/QJjMKOvNN8375z0F8rB4nZWezPpZK7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384968; c=relaxed/simple;
	bh=3tBkqOd1pC4GxPWICfAVG4PrFEovkK9wiyAIFebpEh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJ+YRPsJVxW63yonBk8LNd0uFBg59nEu9U5O2YXR9Jpm7/TiW6mQbAdEQj3xslXv45gGf3JEDjSZif1LberEzHA6O0iFfGXx5bLXUZStlPLBGMsHaLTyjJluetU6F3SlCg9byxnBMBZ7pEvYJ8z92JU0QAECuWu+6ffp4sAHrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Reg1ER9k; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733384966; x=1764920966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3tBkqOd1pC4GxPWICfAVG4PrFEovkK9wiyAIFebpEh8=;
  b=Reg1ER9kA1tD3B54+dPaM5UMQeyjxcjZfXWkOlBWIh9Vk5cOXCmmmBBU
   8TnxPJdg7J/9fkqKSCCsq68h1nwRAqh6dS9iQFaxq/+HffIhv719io2bw
   FE0UiKixtkckhCnVqSCfBRRLPolkWyet68AJFsf9PKG2lqwU/GcV43ngB
   oHywG7eCb/SgUWFOGELt9hnwSUKv8Q96K2pkCGxzGPLZo93xt1OpFsMXR
   a3mNWIQbNcVKbr04209P93GmauuZ34PYR6rIxLpd1BaLAEHFpDndUlVQQ
   QHQJNLz3s8Ge3MsdFZWBivbtS/u2iu7ezsuLmv+qGUF+XaauzeL4n62YV
   g==;
X-CSE-ConnectionGUID: i0Gzz4ouSuC9WI09/PW7Qg==
X-CSE-MsgGUID: d+aBypK9RK6KFKvKN25CIg==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626122"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:25 +0800
IronPort-SDR: 67514c60_cTovsuVHf4oaMNDdXVY0UprsilgBsGgPo3oBsChCvAU5IgL
 510Qgvh3hQXJOLEyAQt+nE/Gb6DulAFwaZVzXIQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:56 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:25 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 11/11] btrfs: reclaim from data sub-space space_info
Date: Thu,  5 Dec 2024 16:48:27 +0900
Message-ID: <36e642488814dbff7719c77b1fbdca5a8066ffc6.1733384172.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733384171.git.naohiro.aota@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only have sub-space space_info for data. Modify
btrfs_async_data_reclaim() to run the reclaim process on the sub-spaces as
well.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index cfc59123b00c..ddb042845e86 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1422,6 +1422,9 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	fs_info = container_of(work, struct btrfs_fs_info, async_data_reclaim_work);
 	space_info = fs_info->data_sinfo;
 	do_async_reclaim_data_space(space_info);
+	for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++)
+		if (space_info->sub_group[i])
+			do_async_reclaim_data_space(space_info->sub_group[i]);
 }
 
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
-- 
2.47.1


