Return-Path: <linux-btrfs+bounces-15020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969AEAEB1A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8044A68F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5427627F002;
	Fri, 27 Jun 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="L1aJJgue"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF1227EC73
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014320; cv=none; b=mqS77pwKnHiCvf34ChHpb76IQnu/m1NgPvW/z6Aes70POZ51U+McKHxYeqIKhhBukRhytQQMrHx7c/r0W+ZF9mDV0+ZaSc4b2YBCh41xMpDgTNdc8Ght8aqupBpi8wPgKD7DpNidFPKrhxWGhGEgT6NVT1NjGl8STH8yCx/iurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014320; c=relaxed/simple;
	bh=dzhRywaCuM/Rph5+FDrPCgg7aZO9bMRl4mJfrVkpmhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8+sNnsFllxsgHXdagWLGD1KWWNUVGZg2t0bCDVMR9QRgr2EtoNq+0IMX+ZpsmiWhe6s1za7DWIt3SrdHBpHtQsUFPCFIrot4+j/ILOomalT4ncEUvN+hLuqwI0bRwHzbtVPoGhO8o1is5rsxolMseH5qnnyrAZYCHCueCathHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=L1aJJgue; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3b23:0:640:a115:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id B392B60B0D;
	Fri, 27 Jun 2025 11:51:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ppRVSl6LqGk0-HiousrrS;
	Fri, 27 Jun 2025 11:51:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1751014312; bh=NWTSmmG6U/SWrXGbwYElVlYFlXW3RGmZbxS9YvdYZZI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=L1aJJguelA54Brdnpza4M3ON/+2FsFuzk7E6a9DPRwU0WPPRvJd5I8X9kfaN+y1Dj
	 J8i7vCWslPAj1zds7DZUMMdCbkVcz1IRT4KWYVEdxYoohQ7uzHWZq7n8+hAPupGTxz
	 mB69vYN+zh8YpaNbKmd+wLBZjrRg9JNSOiya5GcQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] btrfs: avoid extra calls to strlen() in gen_unique_name()
Date: Fri, 27 Jun 2025 11:51:17 +0300
Message-ID: <20250627085117.738091-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'snprintf()' returns the number of characters which would
be emitted and output truncation is handled by 'ASSERT()', it
should be safe to use that return value instead of the subsequent
calls to 'strlen()' in 'gen_unique_name()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/btrfs/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2891ec4056c6..a045c1be49ba 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1804,7 +1804,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 				ino, gen, idx);
 		ASSERT(len < sizeof(tmp));
 		tmp_name.name = tmp;
-		tmp_name.len = strlen(tmp);
+		tmp_name.len = len;
 
 		di = btrfs_lookup_dir_item(NULL, sctx->send_root,
 				path, BTRFS_FIRST_FREE_OBJECTID,
@@ -1843,7 +1843,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 		break;
 	}
 
-	ret = fs_path_add(dest, tmp, strlen(tmp));
+	ret = fs_path_add(dest, tmp, len);
 
 out:
 	btrfs_free_path(path);
-- 
2.50.0


