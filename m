Return-Path: <linux-btrfs+bounces-11550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD10A3B2E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D679916B463
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D51C4A20;
	Wed, 19 Feb 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RccEu3Vj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4561B85D7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951896; cv=none; b=RsHM2z/ONSvGprx2455YAEJPK57d8Ki3eMso1smUSwjCECm+HU9MdBVHc3IiH6/ACV3eJ+6mH4b2aYJe8n+vfmATunFAhaH+gtRCmGAl7hfFli441o/zjlvSJjD8it54wnrBqtTYE0GzsLmxXtCUWOvHmOyV1AgsXFARjzch2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951896; c=relaxed/simple;
	bh=+GmoyTrFRY8sm8RZBOJoyQcldsVlHuimZi/L5L+2JOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxqADqQ8f70pQ/qaBSkw7OMzEVO5IZgPqnV93UnUy5tw9wDGwd6AkrQDmsFKEHt808LS/JEEQCt8UQ3N1w0xlj1JLyS3jkkk4w0I9oMnjeuq3CCuNG9PtfXJDSQkK79DMMxhGq3h3PPPAp+ULvAKRhmM7mn5gtMB9Kwjs+bZJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RccEu3Vj; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951890; x=1771487890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+GmoyTrFRY8sm8RZBOJoyQcldsVlHuimZi/L5L+2JOs=;
  b=RccEu3VjTRg92dYGwgjd+89k5t5rxOgk7uBgDPHRW/zkOZ8q7GFzAbkH
   H8FAkoZVJXhDWlPAydXccFwcSA3pJ5/OBGsmidkI9Uee5CYGb8UiNF5fa
   tTMMhE6jdep//0LmIQMvaZ9SnrILpPcvSIjXLq/+LJz5tGqgUwjGbbp7J
   O8l7vHwgdmE5xItOZoAyNTWx0z2jv7UsW1OWlNUqQuLa9If/Yh6UI1mew
   w4oOhlNQ67LEgOUlbfkxboydirymmzJBudPG6iSnyt7e7t6bbE69Z3vOr
   gf3LB4UB3Qjg0tBk2oiKrv0I7LGYz/2DJtI+DGpAqlDxrqQP+kq4HVxIk
   A==;
X-CSE-ConnectionGUID: /24X8xeBSnuIP0gWbCwo4Q==
X-CSE-MsgGUID: wkLUdqCIS76go7JMiX7qcg==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310799"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:04 +0800
IronPort-SDR: 67b58151_X84fmAJsBtoe4E+Kjra6v7xjW06rw7/unME/8kQy1ijgts/
 s27GvdGUqWsN3Kg5R2KV+L0vHlNeKTf8eCbLaRw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:30 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:03 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 01/12] btrfs-progs: introduce min_not_zero()
Date: Wed, 19 Feb 2025 16:57:45 +0900
Message-ID: <63892ea2d5c1b429e828ac270b517fbd05d5bd77.1739951758.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739951758.git.naohiro.aota@wdc.com>
References: <cover.1739951758.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce min_not_zero() macro from the kernel.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 include/kerncompat.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/kerncompat.h b/include/kerncompat.h
index 42c84460c1e5..e95bb4a53342 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -127,6 +127,16 @@
 	}
 #endif
 
+/**
+ * min_not_zero - return the minimum that is _not_ zero, unless both are zero
+ * @x: value1
+ * @y: value2
+ */
+#define min_not_zero(x, y) ({			\
+	typeof(x) __x = (x);			\
+	typeof(y) __y = (y);			\
+	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
+
 static inline void print_trace(void)
 {
 #ifndef BTRFS_DISABLE_BACKTRACE
-- 
2.48.1


