Return-Path: <linux-btrfs+bounces-11492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD32A379C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC73B3AF325
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A561494D8;
	Mon, 17 Feb 2025 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kvKy9jA5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0B7464
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759874; cv=none; b=R5LrRjH09idKiCoR3S8x5pUr2dfP5hSmrji3KTW7KfI92AuAgXcdEeoDU2mJt9CitP7ZuhcfAfYi5FHMwUGDJK9IcDylXe59+XGqg1m5IiU/NqRlhKRFMJuqtMjs4q17cejOv/Wh6iaZgWqVd1tJwxIL2MhsRy1X+zD0EN0tR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759874; c=relaxed/simple;
	bh=+GmoyTrFRY8sm8RZBOJoyQcldsVlHuimZi/L5L+2JOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFn1AuUwfel9aKDBwmSELNAnijx7DQUr1rgngwjvxvUpxUReApQqR75A1akO2gPFR1YuegCnp0b3TaKXoHRbKlM6m+D0Nn9qUdLHMWDEkPdxggRi3/CRJxkiStPNpIS+kgVxvl+R9Xi5CT011w9yLRSOb+swpZlvLkmoVfPycTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kvKy9jA5; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759872; x=1771295872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+GmoyTrFRY8sm8RZBOJoyQcldsVlHuimZi/L5L+2JOs=;
  b=kvKy9jA5Db7zLaRng0Zl62LZFtyy2ygUv9X1fKu5q2OK046rcrfWJvy/
   V6+BVp+9qC9ZAvaR738oMv+OjeMeCMqPkWKgxyr+Lky/LmdZIZ4k1jmrW
   +xIdXzRBNFByxtQ/8hRcp3OSAzou+FRjS6IkkIMq3BwyUlvzWjj+08tIZ
   iwkfH5zfyf5hqpqeWfyMXi74SIyWrBHhXyAXLFp4P8/kP7Gk8gSa1e9ma
   d2R+yTdVtw4m6N6msZLQQB2mNdD2kHfWFhb3r5fT4y6UxJBV6uSGs2P5n
   7TueXAK+3INqXsUgOUEjIRRK5uQCqUmDQAIJli5W1ltdCp4k7HqJX3i5d
   w==;
X-CSE-ConnectionGUID: xbD3LYUPTai10+8kRESeYA==
X-CSE-MsgGUID: bophf5QOSB2kaHajNCFHXQ==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877171"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:47 +0800
IronPort-SDR: 67b29343_Arr2UZAhh45uuX/xz+cKypTbYJem92bHv32y3gYpj/6r+Fm
 HzNdhKjhPzcIHBANTXtrjaPIRlEUhV2hWmNnDaw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:15 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:47 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 01/12] btrfs-progs: introduce min_not_zero()
Date: Mon, 17 Feb 2025 11:37:31 +0900
Message-ID: <63892ea2d5c1b429e828ac270b517fbd05d5bd77.1739756953.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739756953.git.naohiro.aota@wdc.com>
References: <cover.1739756953.git.naohiro.aota@wdc.com>
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


