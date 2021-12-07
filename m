Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1910046BF7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhLGPju (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:39:50 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35689 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhLGPjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 10:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638891378; x=1670427378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyzKTouzv9P2XOsDIRci5FGaoImY0Z5Q6PCFEjhdbnI=;
  b=QfwuBOIYDjN7JkfppUzLL05l2R6NaGgs2v8TZQ5xX9+aA2w4TAUsw4WR
   Qrb5Tp4JESgbWxoIBWDGZdVvO0+4muF/g72N/IJV4w09TUS35BttvB8OV
   1d+tRtYkmQhA1UEAoZnd/sFd/+tWRyNL+/4DD5buYMClsoclTa4KKkzBI
   7QofFRk/M7QkNjtVRay99Z+JFQW8o5TOyldNq4oJo8vWKe4UdRv+qOkBk
   UE/4dtGlVWjy5FtruXIqmN4Fq04kPxMh0lp/kk2UUGZIUdWh0BKh2Oipi
   eTkXaYsyP2f3GYGATB45Lr+SIhChBWfo2L7X+fRzJZPHCsvGVhpnmRxVF
   g==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="192442651"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 23:36:18 +0800
IronPort-SDR: gvbG7bhBg8FY2N2aGnbHYrRhHOYcENPfAHHvn7Uy2SbpKk/yrZlVyzf62LkZQLkr8HvnL9I4KG
 /K+3ix9rSDnbgUouOoUJADGk4zuzCuKeXhEPUAwfEnCo7U1Cb2DA/YuGmCBFNpLKRMioe3s1Wi
 bjz9C+0dr4SyBHzAjOV4kSsXQQHie5tC9hpH6JELRN/jcePl10vCgdCj/G1nhp2ImwA/aSvdmK
 Pf64MIx7LOrzyn9+NRKt4LagyLiUdUiCHm7X+UUSsM8BcIZQh68t9nIXvouDC8Gnqqmg8uCF76
 ucKHWj2TVlr1/Fw6xZsDVfpv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:09:24 -0800
IronPort-SDR: qA7xqYWEtdQ5MFxIKYCTvT3oCdXlw9iYWZY/meC8xTcRaV9PWbdVKQDiNtMwdPF6yXZdq/xsf8
 NNvlpYUvjvaGvpC6XEMgI0i5S4V0w6m2UjfAkYJymqwd4u24cuEjUozDoNopb50UhdCjKbywJV
 d9PpAZlrz7tq9PUmxF0Pbe1pcf1GwTeDYrLZ989nOXzKe3ls0RzijwXdAqPdxEJWUDaFyddvSd
 ERDH8bd+Z4fjQ3Uq+djLXEDD5Gon2loSV8pb9WZNFdHl8FHj+++uiMV9OzqpPYa/NE3OYGgftJ
 a20=
WDCIronportException: Internal
Received: from hx4cl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.41])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 07:36:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/3] btrfs: add extent allocator hook to decide to allocate chunk or not
Date:   Wed,  8 Dec 2021 00:35:48 +0900
Message-Id: <20211207153549.2946602-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207153549.2946602-1-naohiro.aota@wdc.com>
References: <20211207153549.2946602-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new hook for an extent allocator policy. With the new
hook, a policy can decide to allocate a new block group or not. If
not, it will return -ENOSPC, so btrfs_reserve_extent() will cut the
allocation size in half and retry the allocation if min_alloc_size is
large enough.

The hook has a place holder and will be replaced with the real
implementation in the next patch.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 34200c1a7da0..5ec512673dc5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3959,6 +3959,19 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	}
 }
 
+static bool can_allocate_chunk(struct btrfs_fs_info *fs_info,
+			       struct find_free_extent_ctl *ffe_ctl)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		return true;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		return true;
+	default:
+		BUG();
+	}
+}
+
 static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
 {
 	switch (ffe_ctl->policy) {
@@ -4046,6 +4059,10 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			struct btrfs_trans_handle *trans;
 			int exist = 0;
 
+			/*Check if allocation policy allows to create a new chunk */
+			if (!can_allocate_chunk(fs_info, ffe_ctl))
+				return -ENOSPC;
+
 			trans = current->journal_info;
 			if (trans)
 				exist = 1;
-- 
2.34.1

