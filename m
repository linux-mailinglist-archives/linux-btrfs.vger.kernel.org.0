Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E564F36AC27
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhDZG27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:28:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhDZG27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418497; x=1650954497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LET1yipfnjktN53BvpBod2WBsEjIhj9flXDrJ70sQSA=;
  b=noF39aGWXnXj5q8azfvioTFRFjntF8cKl5o+N0P7R0cXsIjVprWAW0kr
   Igrsxd3HvDFhWU41vsfrAB0USZ0sNjmabFzNHXV3xipqstT/02JqZk5zT
   QNSuucCzJuGoPQTQXxf17dMvP8YMM8qqKs6qeSr7pZWE+H/aCxdRw48Gu
   VolyeX1gRlKzlgwLI7yDLKk9Jr01bVb4bidpLkED5KMS48YuLrnz4ovmg
   kqEXUaI4fiHso/pNifQg+8Z7J4ELxuFJ+0UVWVoxODJ+iCR906d2RV/oX
   m4MD2FEoS5PL6ejn8dQ5wcU8tjBYATeR+VxTGPjdBlAzetWKeZe2B3Xi3
   g==;
IronPort-SDR: rs+S6y7h/+l/qmAau1Sok2yQL1MhRXcNy1zzybb+DmpkIVXmZyd82s6Jhj1FaJEeY6d4pzLAtD
 ugtsF5SO8LxF6d88Jv4Cz50Nfb3OMjDbyl+j+SK84mwFeA7DYVMOvt3NjMD6doFDt+7U8Ak5rt
 wibJy2qMs6/PFMuBTpWR3rPJuMn9SSV7t5s96HT3LbeLB+X4QVRjd7JUOtX1//v+HTGlg7NjFA
 Vw1B9dEaHaGBc0DvAuBm3bb7bas+hAKTKaCJLdCcG9X9IPpiA5HUxuHZrDtRhgOOQT0us8EFf0
 Qmo=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788119"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:17 +0800
IronPort-SDR: bi5mC04ibWAQS7aymLKz9kJb3UaSnPyFJbOgIvpKeVDbXBrAdc4b7mc51YZsaMySsVE/jI+qVl
 b5LI5gjZr7F6/prHDo7SJHE7NO4kW6NPikxKcdEca6DVfqARDh3WzE8cq+Q4FMeuZR+NK2bboq
 F2hoaKX5m3T00PZZ0fCx5ixEcU0sdQ5txiWJCQY7Ld7ngLCThIIqIUb9xAEpvtnLO5M1FnnudG
 TpIjgFbF7emfQPa9h0XylCKlKW1G118wOT2vO+kLdnC32a/fnr7241vn9ZQbeRffchza9udoBS
 EkdWkzTzxGql1u1f+zzFKfrV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:42 -0700
IronPort-SDR: DoUX66YQZY/VWS22S0RDydYmzNLjMtv0S5aaN9ZkGfWQUfDjqcmmTNJX+M0i0JJDWGdKxOxIA3
 974//xdCJUnriTa/+kQ8QToufzOQGKTbveGOvMYdlaN4v7WekFHlX4kfHhcNt/U2YwwTBoAAkt
 xsmWskrw9xU++yhr6qE3kSMHIUTgHch016TQw20bbsR9pSmSn2aJMwKUiUKBc+DhOW8tVeGCCc
 hOn0d8hFJUoU9aXuJAx0nV2XRkdAq4VTF1Fomx9R1MInjtgwyFETf6Lick8uyBwlgkUmg9unHn
 Xrw=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 08/26] btrfs-progs: zoned: disallow mixed-bg in ZONED mode
Date:   Mon, 26 Apr 2021 15:27:24 +0900
Message-Id: <5fcf22f807b9de547010cee4b211348f9fe014bf.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Placing both data and metadata in a block group is impossible in ZONED
mode. For data, we can allocate a space for it and write it immediately
after the allocation. For metadata, however, we cannot do that, because the
logical addresses are recorded in other metadata buffers to build up the
trees. As a result, a data buffer can be placed after a metadata buffer,
which is not written yet. Writing out the data buffer will break the
sequential write rule.

Check and disallow MIXED_BG with ZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index ee879a57b716..7b05fe6cc70f 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -348,6 +348,12 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		error("zoned: mixed block groups not supported");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
 
-- 
2.31.1

