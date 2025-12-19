Return-Path: <linux-btrfs+bounces-19901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B95EFCD15E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 19:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FA72306D8DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D2626C3AE;
	Fri, 19 Dec 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="WZ9o3zL/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BC33A9D2
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168541; cv=none; b=aiTOGrGVpw+d124FbhxNllMbUlC7RICS1Z2xS0oceUV1DRMIJNje438hUAXFnVtq93neifAGtJQkoGwkRYNWtOy9Gh0kl4htRxlM+WrKkdEknmPelCqsvBrOoVf7QiQbYaEvKJocxDQug/HgJnS+3beVk65Lf39BRKgilqxjURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168541; c=relaxed/simple;
	bh=5xuhbZ7abfY2k9+DP2fV2N0F06VsS0iGN+9b09zkXgU=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=RfNXcoTtiYXmTD6NWUJWBpZt7g86Zw1yhXD5GwIIUN4Rc3zor+N3C8Xj9l0yGnC8zdwMgtnVs4yvq+LM3M51ZvqXK19fWR8WvITxyvhitrB22xpTvDCkHtBaHNn5oZ7i2lfUEy2MoFChor6Z3IkDKZ20UvW28dfr9I2oGEySkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=WZ9o3zL/; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id B74B12E9396;
	Fri, 19 Dec 2025 18:15:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1766168154;
	bh=Fdhuvgj1hqdl4Ex/YhXYg+A/yLeYeIY9RC3YAB2ZVP8=;
	h=From:To:Cc:Subject:Date;
	b=WZ9o3zL/MBT8md+uxtT01Lefqtchs37vdA4X0XucqzlYYC+nlGhnYP3efuvTuxHzT
	 gOXcCv45ueyF1VtKhsx+44ozucJtlfuH3CxCI2R3mYnDU1keYvGIhRFNzDsjPaSjLO
	 ILCThez3ldBMnQvW6e34hUfVLziaQCNY1ELJFnfg=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: show correct warning if can't read data reloc tree
Date: Fri, 19 Dec 2025 18:15:28 +0000
Message-ID: <20251219181550.12901-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

If a filesystem is missing its data reloc tree, we get something like
this in dmesg:

  BTRFS warning (device loop11): failed to read root (objectid=4): -2
  BTRFS error (device loop11): open_ctree failed: -2

objectid is BTRFS_DEV_TREE_OBJECTID, but this should actually be the
value of BTRFS_DATA_RELOC_TREE_OBJECTID.

btrfs_read_roots() prints location.objectid on failure, but this isn't
set when reading the data reloc tree. Set location.objectid to the
correct value on failure, so that the error message makes sense.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/disk-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e5535bdc5b0c..f1e58c1d6c38 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2221,6 +2221,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
 	if (IS_ERR(root)) {
 		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+			location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
 			ret = PTR_ERR(root);
 			goto out;
 		}
-- 
2.51.2


