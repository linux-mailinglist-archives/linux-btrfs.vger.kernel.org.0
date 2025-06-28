Return-Path: <linux-btrfs+bounces-15058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92325AEC529
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 07:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92AB1C21F29
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 05:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC18F21D3F3;
	Sat, 28 Jun 2025 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="ROL4nXdX";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="fmf7PW0X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB6FBF6;
	Sat, 28 Jun 2025 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751088132; cv=none; b=qnCXkuvcoK60zH+n1urVizkgNic1/qQ6029kYSVuWNPPKST81LAH7L8c5mOcuffREbJRanYBxjJtwV3pW4q6beTusJ0dSf2tKsUv4bB3l1mZIySZXs/4pxws78qBcKyCsIcyheTxrwtQnYK/VBPlARjFvADvJEwrzm+phxjtQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751088132; c=relaxed/simple;
	bh=puHtFpaLSbU9FWpPlO24e4ikS7LfYMuclxFiM/AW2/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVEgcVgqDeRvMVofvf1wsL15YZ3JsHf3AlRkbBIN6LUz6icwhLqh510DIkxBtsGG4eOkJZv76c82UR+Wo9Vbl6+5cebG7f1OFrExdbgKcM1GWfPTVOkaHefFVghsF8FCTD67a1lSJGKx5mIkZ2OrC/HxPr9NS0cy7LJVnCx/sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=ROL4nXdX; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=fmf7PW0X; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
From: George Hu <integral@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1751088127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+n6YoYei2Xg/Nt4ZTRLBsF2RuAVYxz+Rvux6EU8bhE=;
	b=ROL4nXdX945cpxbn9YWXZVoidokRxNHFAhceX4T9rjJ8tmuj9LAFhC8j0WOHsqzwVFjALc
	vBX5580BXim9hu5vIUtri+v/6UPJdwQ/R0pU21MR8kK0JCXIODJmqXnV+g7ZvmjVl5mCMK
	F0U2uTngyJbrIZajKqrZRU4uNosXmoT/dIYaqY6/JEFpUruxwIW+VS9u8hadoHfO5iD7sN
	suSXHizjC2B/rghcriLEwstqIyVlo6qX7F0CJkb9jVN9X2kv/Zxd4g1PBOEZA+Es4jc0Bq
	AGcJeBM6TsWliekjpe/1wrhCABKof4XBchcfQb5UAl9bpopeVumAD23Z1GGSGGIdjQyDBE
	gtSGmGSLrOb7TCCwkfXHQC36AhBBPMATmQcnN7RCCywlzQrbKlhlE10t6Nli/i7YEJAzJQ
	3gXjegILJ37PpaDSMUP6OJMyG8BHgyUxvUYosut/UUM7cEPQ3HBdy7/FlPPXP1HqmxQWYD
	5Vr55OnKpHCqOdsf2Ocv8rw7wZeN3JLv3XkNqBGvz8mN9A4KYV+0n2m6y7lD6Q0XTZK1EV
	5x0Wm7fmxqIYoS8tR9LwElk8B83YfCAwraanqe649LA3JWtDOzLtLmfYUsbhMjaGcPYzA7
	IYfi58rnZuBc8FroWYDuyqKXujWMVIvQ8+5cX5Ecxac3cakesg2ZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1751088127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+n6YoYei2Xg/Nt4ZTRLBsF2RuAVYxz+Rvux6EU8bhE=;
	b=fmf7PW0Xxph/VE/mtUNLwNPsdi6LwiQJMy9EWqMWyo3WGvWqICrP55Up/of+jKJxgPcRjE
	N8ZHMKISBlZTTuDQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=integral smtp.mailfrom=integral@archlinux.org
To: wqu@suse.com
Cc: clm@fb.com,
	dsterba@suse.com,
	integral@archlinux.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: replace nested usage of min & max with clamp in btrfs_compress_set_level()
Date: Sat, 28 Jun 2025 13:21:30 +0800
Message-ID: <20250628052130.36111-1-integral@archlinux.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <669773b7-4428-43ca-ab80-d7ed1c71886c@suse.com>
References: <669773b7-4428-43ca-ab80-d7ed1c71886c@suse.com>
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
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 48d07939fee4..be8d51c53f39 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -975,7 +975,7 @@ static int btrfs_compress_set_level(unsigned int type, int level)
 	if (level == 0)
 		level = ops->default_level;
 	else
-		level = min(max(level, ops->min_level), ops->max_level);
+		level = clamp(level, ops->min_level, ops->max_level);
 
 	return level;
 }
-- 
2.50.0


