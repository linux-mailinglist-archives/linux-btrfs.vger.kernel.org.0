Return-Path: <linux-btrfs+bounces-9989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0899DF51E
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 10:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AA9B21389
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CAC83CD3;
	Sun,  1 Dec 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/JAXunz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF282D98
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Dec 2024 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733045775; cv=none; b=bJ5Epe/XfhrKlO/0TOvB6VFw7MHUSzj8jSvL5A8dLFZ/z/TjmWz17BGrnDknQ+Tb+WgVn11pSMMOUoec6irC1bqMVv7d0yFe8tASqK2EA0AlROxgreaGGiIjCWe0ndHAB+9dcw5NPlO1Ul3xs6fU8hcc0GodHeKZQvx0J7xkVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733045775; c=relaxed/simple;
	bh=V/oXOD9GbNSan96odxreYJIhYatuukOGYYeIiyfKbhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKqd0tSMQoeT0yj+pt9o1NfIh3WotUvx0429u0veahKQHu/UuRutbvEkHVZaNfjJFPhCSopJmQa+LtPAoc7D3ovcQtYIXuCoPbokfE01oaWleWNiOctmXYjOUl3vaJwoFW8J/Ax/yF/MVI3M2U71FluXSWK54vhszhWKpe7QxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/JAXunz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85FDC4CECF;
	Sun,  1 Dec 2024 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733045775;
	bh=V/oXOD9GbNSan96odxreYJIhYatuukOGYYeIiyfKbhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/JAXunzkbNKtJdGNBL6BqAoAETre/av319LAREQ9a9f5oHEoUWHPr1kw0k5mCz4A
	 21g+7z5JAPu5UrN3HNWi2gZSK9n681O8PaBIP4zLQfF9QoFZqJYBGGdQyF2fVfsjBP
	 V5FGRukVQr7kcirrdg3oSUAg1rgD2v8g7C1yNwGpvY0xZE0/B1gDm+YjtdOHn+GTNX
	 1Moj7snxOEW9buiVoiE3nn6No/v1yVpgxGTozLJB1QESpu+4uoaBIlIMshniDvujzp
	 VzCGKuJpnYkT+Wif/JHuPUoWVsi7/vOaWGy4yYFPC/6pRp/tQ/VF91VByd2LKP7sAN
	 RGJtyrshrY0gg==
From: Zorro Lang <zlang@kernel.org>
To: ltp@lists.linux.it
Cc: linux-btrfs@vger.kernel.org,
	zlang@redhat.com
Subject: [PATCH 3/3] stat04+lstat03: skip test on btrfs
Date: Sun,  1 Dec 2024 17:36:06 +0800
Message-ID: <20241201093606.68993-4-zlang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201093606.68993-1-zlang@kernel.org>
References: <20241201093606.68993-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "-b" option for mkfs.btrfs isn't a blocksize option, it does
"specify the size of each device as seen by the filesystem" for
btrfs. There's not an blocksize mkfs option for btrfs, so skip this
test.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 testcases/kernel/syscalls/lstat/lstat03.c | 2 ++
 testcases/kernel/syscalls/stat/stat04.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
index 675fb56f4..f7346893d 100644
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -57,6 +57,8 @@ static void setup(void)
 
 	if (strcmp(tst_device->fs_type, "xfs") == 0)
 		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
+	else if (strcmp(tst_device->fs_type, "btrfs") == 0)
+		tst_brk(TCONF, "btrfs is not supported");
 	else
 		snprintf(opt_bsize, sizeof(opt_bsize), "%i", pagesize);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
index 2a17cc7d7..3c4f1a6b4 100644
--- a/testcases/kernel/syscalls/stat/stat04.c
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -59,6 +59,8 @@ static void setup(void)
 
 	if (strcmp(tst_device->fs_type, "xfs") == 0)
 		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
+	else if (strcmp(tst_device->fs_type, "btrfs") == 0)
+		tst_brk(TCONF, "btrfs is not supported");
 	else
 		snprintf(opt_bsize, sizeof(opt_bsize), "%i", pagesize);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-- 
2.45.2


