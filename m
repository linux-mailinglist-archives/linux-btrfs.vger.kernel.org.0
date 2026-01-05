Return-Path: <linux-btrfs+bounces-20097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 780D5CF25CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 09:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 769A830094A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E059312836;
	Mon,  5 Jan 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FGW9j39F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067A2882A7
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601249; cv=none; b=A10Ihq81umFH/s/WX92kAtKZnKalbfE38VETtex8uNKqAINKGSW7BNjEJwhhLTXzuWWr2hI3InbyoWIo0aFjQeUY1x9wHzxG64YiCL6H1medQKgomoschYurDtT6QMnpituwbzAIPTw8gOXt5MzUm6QAP/71uV6U402RjqZWDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601249; c=relaxed/simple;
	bh=3MMNvHZxmzPucmbS1F/2SwX1n9U7drCrNdmDwwxe+uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9l/65e18lmJclhA7OoMQ6pUQZZAeK3kGIqhvHf7055GpxVCvlWfGcyReVtf6QEFXDZyyTRDBac+MLcj/SELb4b6aAGV3mJMOJITnQL5BpJVJJXF2fLX4i0Nd6I8uEp8lGRfnpYFjEOFnamL6nPrTj0Uh5HGkD0zF5D1dgiZYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FGW9j39F; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1767601246; x=1799137246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3MMNvHZxmzPucmbS1F/2SwX1n9U7drCrNdmDwwxe+uI=;
  b=FGW9j39F/YBnCjGafdIOmTVDPXn1vu9TVA5f0La6OOR5kscMuWj+F0eQ
   XC/WGuXobjDWGz9m6xYfldlcXE6BKMeneolT36GGX5NwY+pYT3iv8M9ms
   M9aoxQ1CXzwT7MTyaZmxl1v2bxli86IC7VEk9mg+USYuzUyV9Rrhbp3bD
   4avp5zHm7tXWm6zIcfDZ7j9B1f+FkIk0klCI4RBuwHmKqFfGtw8/Hivqn
   W0nWCbgfLR8hcsKcy3BpLQMWtvmRt8rv5FFmMZTrTpZr3ADuuIBv5CAAu
   65DAbwBgrtJZIbrmLSw9vkQodTti1arK2uFYeCPDpO4v1jF3/ngZx6DYf
   g==;
X-CSE-ConnectionGUID: Nm+4cfjwQoqw9o8NvzL7+A==
X-CSE-MsgGUID: rJNtY8jdThKMte3I7WTjuA==
X-IronPort-AV: E=Sophos;i="6.21,203,1763395200"; 
   d="scan'208";a="138919624"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2026 16:19:37 +0800
IronPort-SDR: 695b741a_14Mw9s7yN7q2fwhWVvslAuU4EKzzVw011jrOkb4e+OhoQJ4
 wUU5AkEd+Jp7d0FmzV9hB+92OUocrpv3qMqWKig==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2026 00:19:38 -0800
WDCIronportException: Internal
Received: from wdap-5kkqlteefu.ad.shared (HELO naota-xeon) ([10.224.106.47])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Jan 2026 00:19:37 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: tests: fix return 0 on rmap test failure
Date: Mon,  5 Jan 2026 17:19:05 +0900
Message-ID: <20260105081905.993994-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In test_rmap_blocks(), we have ret = 0 before checking the results. We need
to set it to -EINVAL, so that a mismatching result will return -EINVAL not
0.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tests/extent-map-tests.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 0b9f25dd1a68..6bad0c995177 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -1057,6 +1057,8 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
+	ret = -EINVAL;
+
 	if (out_stripe_len != BTRFS_STRIPE_LEN) {
 		test_err("calculated stripe length doesn't match");
 		goto out;
-- 
2.52.0


