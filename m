Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53EF354E47
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhDFIHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:07:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49896 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbhDFIHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696471; x=1649232471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b/R/3lw/3WLs2RZ6MZEY4QHC4cvU8H9F8QEU1ByeZ1M=;
  b=eLLQkaXP/+35dxpzh1JVOxfK4LC4Vx77lO8nPxum1ZO512WOMfjTUdWZ
   GhYM4Bp+L0ayxNnqaMuOY9DUPnXrsCiTnKJLkq+lai2TXo57f6ohXy29l
   MCRDgEsNHUV+XNu5nuFN8J+Tauo5w7X67TM/au0XekOrpFn6/jJBGS2hZ
   f075Tjs8ARtoukNzQLa72hJffguHb9fMlXgcB13S4ljP9Epa2uRiIwEZY
   GyPDmfAIusZwKJolbeeWqRMcTkepabHsJfp501tj9Jz6lFb5rXFPme99E
   HK696++9OyreB4o0H0rEmZbh15VOJwWK6ztG7JpgiKBZ/93eLNE8WN4Ak
   A==;
IronPort-SDR: ZEIOeAydYNdozKCuRYfrqiEAAT5Eg7TOaXLtT2oauPv1YO+s03HUni9eYorK9NY7CR3TeOtawK
 8PyF527KYF7y0cziTfkSzhWsiH134jMu/3/80HVNMkirAM35gMF2k/oQ883sFJ4GJ1UNWz3eGZ
 WBa/ABdOw+6yT962m/s11WSBqCgyPsv/Lma76DpOsJY6CMcM+SE9jek3eyX+LuvsEs9QsM46vE
 7xQmp5FINitDhCY6kI8xDAU7ciEtogfET5vQpi+hC1GcBd4n1Y6m28BVaO9Wc/d6Ci+Azndpyd
 Q90=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290680"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:07:35 +0800
IronPort-SDR: HXIPcl0+K3+vzxZo0w/nR6lRx/BK6epJchcbacNyXrpuZGjdVxaBVkdoBj5tJAzGhKh2T5c1A7
 IPyRWP6EePgkrs/gKe3/PidxHC8NMD/BmIFEjrBTiqRa0jSj6DzTuAfvadj4ofSfdUKWQ5OJXi
 eA9QyD5TuesQsMwWF4I0mewreVWfK6cJZawcFUG46V3cXz5aJ3AzTNznZbvwq+lT4TMrw2Gf0R
 Qyf4znrCOlmNHmz5IRpLwJq2qWRjiNeoorLbg0u+CAkFvD+a4E70Se1mPRjcbZGoNg6Cv7dM1z
 xxcLtHa/FwpyBIyN+AO8XkfE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:24 -0700
IronPort-SDR: wipaC+/hoWAceLsb6Vbw3c/JrBUDqp7O1JD4VfEjjA3FZ1eosG7c/vUzl8Al8yionJSLX2A24m
 SdCQaRH8dA6pNGZ0NHZG6xhMwaN+v0dEOe49OEO6kNiTeZb0oj4/7OvUyRoyIQ5E37004P6dri
 9ueHwzHsbPPfRceOW4WM11XrxhfKJrWodtPyXLfSuZMWVlbnLIo+vKFfyfnrwC1eAZmB5f+/R5
 dkWyo2SStfRagKRnCSK0eocy/1TE3n/gt7YiIiiw9jytenSfs0JccnmJEzHmnpCLfHItdROHMa
 Joo=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:06:59 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 05/12] btrfs-progs: factor out decide_stripe_size()
Date:   Tue,  6 Apr 2021 17:05:47 +0900
Message-Id: <80a124fe2a3c9074d91e992ff833b98e9f8f8997.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out decide_stripe_size() from btrfs_alloc_chunk(). This new function
calculates the actual stripe size to allocate and decides the size of a
stripe (ctl->calc_size).

This commit has no functional changes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 44 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 1ca71a9bc430..95b42eab846d 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1087,6 +1087,37 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 	}
 }
 
+static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl)
+{
+	u64 chunk_size = chunk_bytes_by_type(ctl->type, ctl->calc_size, ctl);
+
+	if (chunk_size > ctl->max_chunk_size) {
+		ctl->calc_size = ctl->max_chunk_size;
+		ctl->calc_size /= ctl->num_stripes;
+		ctl->calc_size /= ctl->stripe_len;
+		ctl->calc_size *= ctl->stripe_len;
+	}
+	/* we don't want tiny stripes */
+	ctl->calc_size = max_t(u64, ctl->calc_size, ctl->min_stripe_size);
+
+	/* Align to the stripe length */
+	ctl->calc_size /= ctl->stripe_len;
+	ctl->calc_size *= ctl->stripe_len;
+
+	return 0;
+}
+
+static int decide_stripe_size(struct btrfs_fs_info *info,
+			      struct alloc_chunk_ctl *ctl)
+{
+	switch (info->fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		return decide_stripe_size_regular(ctl);
+	default:
+		BUG();
+	}
+}
+
 int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *info, u64 *start,
 		      u64 *num_bytes, u64 type)
@@ -1121,17 +1152,10 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 
 again:
-	if (chunk_bytes_by_type(type, ctl.calc_size, &ctl) > ctl.max_chunk_size) {
-		ctl.calc_size = ctl.max_chunk_size;
-		ctl.calc_size /= ctl.num_stripes;
-		ctl.calc_size /= ctl.stripe_len;
-		ctl.calc_size *= ctl.stripe_len;
-	}
-	/* we don't want tiny stripes */
-	ctl.calc_size = max_t(u64, ctl.calc_size, ctl.min_stripe_size);
+	ret = decide_stripe_size(info, &ctl);
+	if (ret < 0)
+		return ret;
 
-	ctl.calc_size /= ctl.stripe_len;
-	ctl.calc_size *= ctl.stripe_len;
 	INIT_LIST_HEAD(&private_devs);
 	cur = dev_list->next;
 	index = 0;
-- 
2.31.1

