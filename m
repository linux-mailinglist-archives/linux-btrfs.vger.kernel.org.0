Return-Path: <linux-btrfs+bounces-15438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0FB0141D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB701CA0613
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D91E5B64;
	Fri, 11 Jul 2025 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NrKpW9vw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7681E5018
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217912; cv=none; b=tbI+fxULlxuiZKQrB7JKtdBijsTxXc41wc501gZIxuvIEEP5MtjocDTofMOeXvou7B7bAw6hd1iUc3JKypQeN4cQqawSWklVlSH+WS4wR69dHTH5UKzT2Ex0Ia0EaDZn7SG11PUeLi0CWlFe0CMh6eLFmRqxc5IX9UZ7CQAhXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217912; c=relaxed/simple;
	bh=ptF4Ow4fjf0GSKCt1GIjjC4LLBM6F/y7qMgP7lVNO34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMcogzSO+7DgIqiY83f0rxJQuCV1uOZubhSolfvSCnkop6WumiYVGGJ2CX4tBlOq5AuEKszVHEYtxVuFIMru+U5ONdIUGxHtob2uNG53OmjRQo28syN7PHW8ShbAl607UF8RjwrCms4uXrNl/cdmLj8u7rATsFnWuMVyU27smfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NrKpW9vw; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752217911; x=1783753911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ptF4Ow4fjf0GSKCt1GIjjC4LLBM6F/y7qMgP7lVNO34=;
  b=NrKpW9vwGxzrO+G01QELmm1RtRqWdrIecHlRjajkMsJLfZnG9wOYKM9r
   DfeW2siwkkqU+cCzT7FzgjrYtKcC/c2R/0CWrznHhkn2OWxEwxvsghYVn
   Q6SLjZVMMy+V1V85VfT9rKnrRBa4bJUQjvIUsq50C0BFRlgj0eWKoi3Zm
   cID/GeBnaeuLjgNMdwQGxSdvc7ekib0kMlyP4H3f9td3YECIq2UZhywyJ
   /IT3haREH2FlZVcmwmApHW7vCFqW8e+vY4TCWaLPYApr6BkFYWYHvgs0j
   7hjIMO1GcySB1e4iBzEKCD07nz6kf9R/qZBZxvqqgXJDx+4RApr73tlvf
   Q==;
X-CSE-ConnectionGUID: zaOTtTKwQTq/4p6YlgW8Ig==
X-CSE-MsgGUID: kt+RHnqqQRuLZpM3Z3oqvw==
X-IronPort-AV: E=Sophos;i="6.16,302,1744041600"; 
   d="scan'208";a="87606672"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 15:11:44 +0800
IronPort-SDR: 6870aa96_eiNzsPl1OQWMazPha4AKr2fMqpw8rGsqJEKnYGs/0wPZrvl
 GkVUqZ0XCbvUriCjB2ARViKjWZJUb7G6j1gBT1w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 23:09:26 -0700
WDCIronportException: Internal
Received: from 5cg2012qjk.ad.shared (HELO naota-xeon) ([10.224.163.136])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2025 00:11:43 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/2] btrfs: zoned: requeue to unused block group list if zone finish failed
Date: Fri, 11 Jul 2025 16:11:20 +0900
Message-ID: <87efe2de05c2e12253055a0693693e715b5ec8a8.1752217584.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752217584.git.naohiro.aota@wdc.com>
References: <cover.1752217584.git.naohiro.aota@wdc.com>
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
index d93982aac5b6..c085d3782fef 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1639,8 +1639,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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


