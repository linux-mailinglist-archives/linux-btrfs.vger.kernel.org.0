Return-Path: <linux-btrfs+bounces-15056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9BAEC4E6
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 06:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9E14A1B2A
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 04:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF421A443;
	Sat, 28 Jun 2025 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="bkVmTkIY";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="iAkTCR1Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740413BAE3;
	Sat, 28 Jun 2025 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751085184; cv=none; b=n4Dr0tbEJByqV0A4vvv1JHAAuehpze3VaMXanBpN3jJ1ym6CtE9Hx3dgdylNPL4NfHOW59JH9K0SbnKEIjpLntNRbHpLVjbUpi5JBnCvE4MwErxEniQjMTiwcq7nayDGffEw0r0RFpjeBi8grhviWVVJLvv1D5G4Hwq4KCTcYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751085184; c=relaxed/simple;
	bh=yN0N/CtnSKq1m5AArga+NyTOUfe5Qx9leFeRWbgo6gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgPjkS9SwvsPYfOoqEF+hG0Hlvqe8s3lUKfE0ysNw8JjLvQI5zgaQm1wL0mhgxKM4MhaoDfDe8UtpymDHmAqm2NfVny7j4szKHek4I7hjD3IcyMoyfbxXNUdyxoSedgwT+cOJBvXvts0m3lsMMeNO8+V1aCd1gdR9PgNiTYov3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=bkVmTkIY; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=iAkTCR1Z; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
From: George Hu <integral@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1751085173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X50KErm4fzlm4Gmo0jriFC6RIcSChDrr8QGwjw4nFqM=;
	b=bkVmTkIYgOl9JvHuED4goB7XXchMJIF6IP5ktgJGCbk5VUyb6EoqrDYv4/JGVhVnjnWJxg
	bg0nePqkTn8nWlZHDXibVoSGva5a6+KalltbqHzmL5bfiuG/U1Ei3Xp7cuXsKoihUmMprv
	yNg9VnIPO//G5YgMqCxT/isDJfnGqQmZNm3C0eNnVoqV2vUZheOJnk0lm3PWLT5sMOirbP
	hQmBLSjstXyJqb1t5qN87AaKoteP9Zlg2BgPBqGsm1XpQ5266v2MNyhBGwLSoVGsytDSYK
	Wbne5AeHxjve0FYLdGYCiYCo3io2Warfaw6r2a+lZ8BOo3cZHnVNyzrhSThyTK2cDU6VG6
	Hwj73yw20VQbeoaYDkjvMgMdZH5BmYehhi1rl8Oi2H9ZIrag5MisjR2SejFKjCWVMYWuC6
	tWbypUIAryEuobU2VBhdvgR8mg09weJeYKIH+RkIEvRzKmMIQ3CsP6DV91gFhddF2SYeSm
	+mkxZtasFsR+RxKpLzkJl8JQfbj2oHwaSvQI7UB5R/k0B+k+C5zYrPP0Gz7bGs203h/VeQ
	l0sTznDgVRH1LclQrqeBC+pD+QEBKrbUE2TaTAr4mIGKywr49BKiXzvJ517hhEt/F1Kvcd
	tsB0vsuJjhdVnltAXaStk6XtMhmPITuaEAm97SfCs4xssiyUFdpEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1751085173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X50KErm4fzlm4Gmo0jriFC6RIcSChDrr8QGwjw4nFqM=;
	b=iAkTCR1ZLKKbSr8cBt2tX9e+k0PPfyWqxuqaDKV+q6hMwq8fyEE2HQgtdm3rJat439bRMu
	1jIs8OXgfH/hpgBw==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=integral smtp.mailfrom=integral@archlinux.org
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Hu <integral@archlinux.org>
Subject: [PATCH] btrfs: replace nested usage of min & max with clamp in btrfs_compress_set_level()
Date: Sat, 28 Jun 2025 12:32:35 +0800
Message-ID: <20250628043235.29900-1-integral@archlinux.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the btrfs_compress_set_level() function by replacing the
nested usage of min() and max() macro with clamp() to simplify the
code and improve readability.

Signed-off-by: George Hu <integral@archlinux.org>
---
 fs/btrfs/compression.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 48d07939fee4..662736d94814 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -972,12 +972,7 @@ static int btrfs_compress_set_level(unsigned int type, int level)
 {
 	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
 
-	if (level == 0)
-		level = ops->default_level;
-	else
-		level = min(max(level, ops->min_level), ops->max_level);
-
-	return level;
+	return level == 0 ? ops->default_level : clamp(level, ops->min_level, ops->max_level);
 }
 
 /*
-- 
2.50.0


