Return-Path: <linux-btrfs+bounces-8553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC89901A9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DC5B25210
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA3156872;
	Fri,  4 Oct 2024 10:53:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93F179BB;
	Fri,  4 Oct 2024 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039231; cv=none; b=VCkWqLm1a0hBkAdcUWMwhGDZzVzoxo7yy/H2vjQcxfZS1yaCg7PQKNoMnR6uFjNUd50y8vp9ZtYhkL2DjjIT90N0yW+Mr9U6uh5/989LmQNAyzqJ6zqPu/1RoPj3tRvVJYpveqTrXArTHnFd7g//Vz5WcOy+hKjHFklF+hX6ohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039231; c=relaxed/simple;
	bh=DWljU3qY0qrV3vkJD6O/Pj957vWPw6Dblsqa2v44Za0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGDhNubu2DO2QSt6wqYqrCTja9uvJ7wiu1KD/YHgt3Si02gPjhRyEJKd47boNHG3Anagi6u0GXpWKXSAqFwYAPIgNyWztbWuKiG1tp09gztwX+MQP2+/FIr5Z7kK5FvVZ8WTNA9baIpDptID0FR4VsSMXPUFRyVTLIJEF8TZ1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so17228085e9.2;
        Fri, 04 Oct 2024 03:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728039227; x=1728644027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXeNJHAmVvczEIHZ6e0IC5Zzi8tqawU4KHZ04kqvtdo=;
        b=QnJ1p0gQOsA2H4GAVbTKEivQIDI+VFmQrn8KAs6zb+YnS28I6/ne9xECsec/6m7tn0
         v5ZKShUDbSYAJszlEQUPUQ6PD9+IzlHCDu+wm5XWJ+DilCH3Vwbe5Ysf3E0jCdP096i6
         8gfyV2NXF7tbQEb3Z4lBCRt11U3qh4X1ldUOdlHZCwDcJc3bbQ1IqNfMBhu90epiYH6y
         7FTG1BMk4l8g9jIOZSmRPnMBtVWQxmvv87XHEU2uBnz6TBbJM3iDrvErm0cbnKYBpr7z
         QHiSQNlKga1KnktCog0A7IIlpHoUHzLKPLINERGYq6d09+T4844SzsIwz8PYlR8a/7Vt
         Y3ww==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5YH0od+MxSiznZc0Fwi01VbpoQr3nz2iGg/WIFCku+5r90FFXiw57qZTcVw9m0K8IspYX36EhgjHyQps@vger.kernel.org, AJvYcCW6HZeWFQ0I2k123v0dcARetkwO8qkBCu0NL5gV49QAw5LiUrWBKw80j+dB7Y2Muc5kRd3mUmjoUQGJQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91s2ZFPbabdcD5evw7buzWiBqHzgx/7s8H5YhidWeLHtNfLdW
	riSuPyXm1JEHmyoo1HKr0kpDk38Q2K6Im6sPAfjhjPnohAi9gQzA
X-Google-Smtp-Source: AGHT+IF2EQKxiuA9l2LyCz/uiARYjibI9Ko1W2SK2tVAFXFXqlvo8qU1RXfY39ODJvXWoJs7lFZopA==
X-Received: by 2002:a05:600c:1d2a:b0:42f:7ed4:4c25 with SMTP id 5b1f17b1804b1-42f85ab5db4mr15549825e9.14.1728039227324;
        Fri, 04 Oct 2024 03:53:47 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a1f6a7sm12745745e9.8.2024.10.04.03.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:53:46 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: don't BUG_ON() NOCOW ordered-extents with checksum list
Date: Fri,  4 Oct 2024 12:53:31 +0200
Message-ID: <20241004105333.15266-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Currently we BUG_ON() in btrfs_finish_one_ordered() if we finishing an
ordered-extent that is flagged as NOCOW, but it's checsum list is non-empty.

This is clearly a logic error which we can recover from by aborting the
transaction.

For developer builds which enable CONFIG_BTRFS_ASSERT, also ASSERT() that the
list is empty.

Suggested-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v1:
* Fixup if () and ASSERT() (Qu)
* Fix spelling of 'Currently'
---
 fs/btrfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 103ec917ca9d..e57b73943ab8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3088,7 +3088,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		/* Logic error */
-		BUG_ON(!list_empty(&ordered_extent->list));
+		if (!list_empty(&ordered_extent->list)) {
+			ASSERT(list_empty(&ordered_extent->list));
+			btrfs_abort_transaction(trans, -EINVAL);
+		}
 
 		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		ret = btrfs_update_inode_fallback(trans, inode);
-- 
2.43.0


