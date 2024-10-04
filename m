Return-Path: <linux-btrfs+bounces-8543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3C98FF8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14E11C22021
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D611148FF2;
	Fri,  4 Oct 2024 09:23:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E2148849;
	Fri,  4 Oct 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033829; cv=none; b=KcDQ9YDGM7N5DZBlxa10rBFcdnlfXEjdn8vRqlhVc8iX0qsJThb6qQJ1diKEk8rGsBxkqdv1IQLKY7iV6r9hLB0lCBwr2IpyNVTYReBqWwZBfo+CbYBWqTJejThd3SouEVjhxRdC6wc8e2Vjm5cabat/f7pU3IJYNJoQeHzrCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033829; c=relaxed/simple;
	bh=znWjQxpyp1Ip5afHMFhPSkFOByMxYLt4qwfyIi6G/+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWCRyLU765tMLaN0fed+towIFfLVZjzXeLhRRx4Ej8UdyJ7gwNewI7onrsLgYQbH6kjlrxr1OZv3DfxR/mAK6M8GmKC+Zl/5zYff36Z7VcNZXu7CR/Dr6XcWddKRZoNgs2by/lJyYa9xF7k2fb1p7VWqKkCwkEz7mLj3giG85xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398e4ae9efso2154618e87.1;
        Fri, 04 Oct 2024 02:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728033826; x=1728638626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOWKvZYR1BJnmwwX17jQh2UMxV8ydMCDEWHjPgd3Smc=;
        b=f98ZgX06JSTwdFA/hIgvZ1ZkSQV3jV4y/SRNB9F2BKV9rbBo5Ds1NUsThGj4nCfNHc
         z9raoaohuNAhSWwuZNfol8lJJ3sjXEq/7pOthsZKHqI1nDW9lrel2ovGHNKho7uA38RJ
         gQFpfv2s56ZSe0goRK15/0k2Rah9cjlQ7CKWLKYx+p5yTtaHi6bLB6eFFeJ59Gnrc/0a
         P9X7Nx18cg2JjeFpaFeSbSaFvoYgBbD+jLI3TJIbx9Eg71rx26+6reVRlXTUSvJnL4XY
         LRK0+kAieZSQvWQhABz/w6g5mm7yysc2ogApDJ43Y3pHWYZxqltpzoYUJZRi7iMMW8Fs
         XCyg==
X-Forwarded-Encrypted: i=1; AJvYcCUymxnN2GHTVOMtQysaJw8XqPSrSSragJAHtCFEAw6c+FWniH81fPm0/YgOoHLktkqmR/5DEy3uHoLs7A==@vger.kernel.org, AJvYcCXzp5UZC3SciZkQQT1/6slNbRNyYdYS7k8tIyt2Ry2VqCDc6oSky/BJC4yXx8oXlrwkNJEjW92crTITFkqW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ovmzX3W1sTXGrF/bg9uVjemlZ1m9pPMSs29uyXxQ1KEWmn0Q
	skupxPGg6xEb7Y7sKA0oiNjFITzzPyPZmGSlaYsCm4y6u0656qeW
X-Google-Smtp-Source: AGHT+IGrd23FEjDH7CH3ZWdCVdU6bJNUaOWyV4T+MA90ybuB0FtsA6aq9gGrvT+uwtZ8YOP/SyE/sg==
X-Received: by 2002:a05:6512:2803:b0:539:9457:e70 with SMTP id 2adb3069b0e04-539ab88b48amr1261244e87.32.1728033825852;
        Fri, 04 Oct 2024 02:23:45 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b26345sm10820505e9.30.2024.10.04.02.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:23:45 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: don't BUG_ON() NOCOW ordered-extents with checksum list
Date: Fri,  4 Oct 2024 11:23:37 +0200
Message-ID: <20241004092337.21486-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Curretnly we BUG_ON() in btrfs_finish_one_ordered() if we finishing an
ordered-extent that is flagged as NOCOW, but it's checsum list is non-empty.

This is clearly a logic error which we can recover from by aborting the
transaction.

For developer builds which enable CONFIG_BTRFS_ASSERT, also ASSERT() that the
list is empty.

Suggested-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 103ec917ca9d..19ba101dc09c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3088,7 +3088,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		/* Logic error */
-		BUG_ON(!list_empty(&ordered_extent->list));
+		if (list_empty(&ordered_extent->list)) {
+			ASSERT(list_empty(&ordered_extent->list));
+			btrfs_abort_transaction(trans, -EINVAL);
+		}
 
 		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		ret = btrfs_update_inode_fallback(trans, inode);
-- 
2.43.0


