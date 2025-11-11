Return-Path: <linux-btrfs+bounces-18862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02595C4D96D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 13:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE8F188282C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361CD357726;
	Tue, 11 Nov 2025 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UzjruNHd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5E248F78;
	Tue, 11 Nov 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862793; cv=none; b=VJN6UPV5mR1jUXUNXUnq0sR9HVrajlFFgBZtnBMTWkVrojcGSWvrh2brVnFjMvaONXdyo3Y00ig1tbbozTmcMzcQJHGpxrsaNKSWfN8RpzTjspYeJg9+eyUWA1lz///qTwiEZiBFZ6meziqOzigKUYrc02dZqE8wd4OzKhwMJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862793; c=relaxed/simple;
	bh=y5U6iiMnaPZJ8bF6Me0DwCTiPvraiv/VbILyI2x9Gtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mt4UGSN3pUnGFeF2A1NyasP2SlLKSPlopN2lXHCaDtqqD/oFuXesnikirqjRG8MOJdaBmUCs/ClxsRY8TXPX1+9xSuecoW0YuvNkmKuq409weBE3wQ/5QFm9nl/xjiS0VijDD+3ivkOWRvWUXUyhk/SEeJE1PRUcv5BPeNLgiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UzjruNHd; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fX
	nUx8qkbwT+iYJFbuTl+5Ao2eAk+Du1NF38Cn2Twak=; b=UzjruNHdUBvSe9A00b
	OiXmOU/XlPnVKVWvWpYy3LOt4vgLuSDvRWrwLsE2I2Rca6WWRACCavy4ofFINsdc
	XaGzoD3qDGbH/xYGDe+f1mMmlr9RiObAYw8fYsZeckXSX9Vn4GEpE01c50i16DVl
	OUTCdLdAeqXb/Xl6wmXDhSB5Y=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAX1tyrJhNpMhXBDg--.36042S2;
	Tue, 11 Nov 2025 20:06:04 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] btrfs: simplify list initialization in btrfs_compr_pool_scan()
Date: Tue, 11 Nov 2025 20:05:58 +0800
Message-Id: <20251111120558.28240-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAX1tyrJhNpMhXBDg--.36042S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4DZr4UWFyrKr48CF4kZwb_yoWDtFX_AF
	y8W3y8CrsxGw4rCF1xCrZ7WF4UW34agr40q3WkGF10yry5GF4rJF1DC3y2vry2gr1rK34r
	KwnYy347GF9rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbQ6ptUUUUU==
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwQzTnmkTJqy2FQAA3T

From: Baolin Liu <liubaolin@kylinos.cn>

In btrfs_compr_pool_scan(),use LIST_HEAD() to declare and initialize
the 'remove' list_head in one step instead of using INIT_LIST_HEAD()
separately.

No functional change.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/btrfs/compression.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index bacad18357b3..0da57a3ebe22 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -194,15 +194,13 @@ static unsigned long btrfs_compr_pool_count(struct shrinker *sh, struct shrink_c
 
 static unsigned long btrfs_compr_pool_scan(struct shrinker *sh, struct shrink_control *sc)
 {
-	struct list_head remove;
+	LIST_HEAD(remove);
 	struct list_head *tmp, *next;
 	int freed;
 
 	if (compr_pool.count == 0)
 		return SHRINK_STOP;
 
-	INIT_LIST_HEAD(&remove);
-
 	/* For now, just simply drain the whole list. */
 	spin_lock(&compr_pool.lock);
 	list_splice_init(&compr_pool.list, &remove);
-- 
2.39.2


