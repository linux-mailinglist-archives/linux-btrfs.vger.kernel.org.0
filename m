Return-Path: <linux-btrfs+bounces-4949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0C8C4AA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 02:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B702286316
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D163AE;
	Tue, 14 May 2024 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QApmqN4q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED417CD
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647931; cv=none; b=ZIu/mlAnqU69ThLfMCLvXBN4E07ULhPf7D2UdNPnNd1sntVpRu9TopnULGI66AB8bLnKODIArricDUWbR3us0Zz6rdSoaMcvhcGC1CyJIH/oy1gg0eYDtqUkubXmjyw+bk6C18aPju9fPNrt/q4Aij4ox4wk9Ta17UcceFw5l6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647931; c=relaxed/simple;
	bh=291spckHOc/OndRzbUKt1knBk+0K4i7rEvJSmzcNZQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT4hhgyn06EaMDDPOF5dQsNbruCsaOmRseLnUVkSbaN2OLUkjOs6nj7p50aIC2BBfz7xXH7CP13tNFuJ6Eff0O/R95wMwr0PsZ7DsVibNIH6Xd1R+OWHYPlI1QeDk6JF/JqJLWuIe5GYTQFwzJhUG6XlNNtNljNI6MQD3YSvknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QApmqN4q; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715647929; x=1747183929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=291spckHOc/OndRzbUKt1knBk+0K4i7rEvJSmzcNZQA=;
  b=QApmqN4qhHiOxT81n9/CppPwRiz+rmAYC1z+7CC4mNQ+LzcsUmcbauSH
   eYlw7Z7SSsRDme1/cwEVS9RKwdoznRq+BC815I9EcW/skiSwAP52HYqV6
   AetdjMn9WjAvePgzrAEO05kv1KzJIFs2G5RwbWOJVyK2m5SoRNmGTqee1
   d/wcvSJyB1G3+jPkmYHrEeVb2ysEBLk5piiQR5Ow2EPATTQdYjiOkIFhl
   98kJaUSXYdL7Bb8EKRe/m2e0ku6l9tmxuKn3uAh0V4ZnvhCL3QmWSWAgw
   dKpKfXD+EoI8+n9gQxeZ7rhsjfY++LPzmzmUTsCbwGz2HjCMNVXjS8eRv
   Q==;
X-CSE-ConnectionGUID: tSkwSaFORDCr1AS+b4NM1Q==
X-CSE-MsgGUID: FFR+3gVqTmemFVTFfe885A==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="16252237"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2024 08:52:07 +0800
IronPort-SDR: 6642a825_nJwafmNaZYl1BIJnCkTUfoaFg/7GrAteDUpMlYHSXy9DE3y
 t5bQIilhJYdUrFIHRciWZdKKVAz2Jnh274xppOA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 16:54:13 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2024 17:52:05 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 5/7] btrfs-progs: mkfs: check if byte_count is zone size aligned
Date: Mon, 13 May 2024 18:51:31 -0600
Message-ID: <20240514005133.44786-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514005133.44786-1-naohiro.aota@wdc.com>
References: <20240514005133.44786-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating a btrfs whose size is not aligned to the zone boundary is
meaningless and allowing it can confuse users. Disallow creating it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index a437ecc40c7f..faf397848cc4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1655,6 +1655,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		      opt_zoned ? "zoned mode " : "", min_dev_size);
 		goto error;
 	}
+	if (byte_count && opt_zoned && !IS_ALIGNED(byte_count, zone_size(file))) {
+		error("size %llu is not aligned to zone size %llu", byte_count,
+		      zone_size(file));
+		goto error;
+	}
 
 	for (i = saved_optind; i < saved_optind + device_count; i++) {
 		char *path;
-- 
2.45.0


