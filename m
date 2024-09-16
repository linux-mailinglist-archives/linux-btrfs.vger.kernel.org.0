Return-Path: <linux-btrfs+bounces-8050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE928979F1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417801F221B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD071552E4;
	Mon, 16 Sep 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWsvn21f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A03152E0C;
	Mon, 16 Sep 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481791; cv=none; b=D2giG68cdvtEbtiPKW5oMGM/9j60IDHzRryizTE2WQEcqf/UF9ryX0Dy0+72LHXpbcsp6JzxAABG3eNU7dyOg5AJx/0FggTPeKbcG55Hlol1VOvkCmQJb+qxWrunbsimgoFHrt1jpT1jQRV36TF8L86OnNCzvma842r5PYLvIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481791; c=relaxed/simple;
	bh=Qli+h/uXJqZx6B+dTAdfsruBtooNooToeUGYDRfRd80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWsFlWvDdiNnxDYJA1fNi30Istr0WVjRPBFeh7A23XS2mH800h8u0+B/qDNEAbacsQNLRxtGFExzpeHFnuVRO9mcCejGRyUU6jbDdQSL6osHHJRwFsA2jTtElU6O0EmTWwJuXg0uR231FvZSxVP3AuwHPczobP6SnO+soqRjbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWsvn21f; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3787e067230so3049913f8f.1;
        Mon, 16 Sep 2024 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726481788; x=1727086588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+96dCE/RH3/NNKWNE9Y9s9N6w3czRGVtUhIxMgqQU3M=;
        b=mWsvn21fJP7M5O7r/i9o05M7omERfFqi6FW6bQF5PQB3NdRARuZLmcemySVq4Rh2IT
         xpz/jZ9501l8oY3L9OKjIrkLh3rDeeTEjTW62P5cUO4wAlSZWBmuChDMhQbqoTqfN4pP
         vShL8C968CMdf5mooST6JFu6w/FMEY/fwNzyD6dDh2n8aIJGum+TdwoXAc4xfmUlGS8O
         m+TgIN/iol5KbzbRNY6iGL61vgPy81kjx/K4XtjMIteT+C0wQYrsa/5AD9CkRA4JCb5l
         IDdxbbDG/uQ2bCMVoz1UCP0qR2T4LQeTJIi3z6DQquFeNfdFobym2sfValQKXffc6Ou3
         4fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726481788; x=1727086588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+96dCE/RH3/NNKWNE9Y9s9N6w3czRGVtUhIxMgqQU3M=;
        b=n9HmVjHx/YcNcg6UPXzfG/SMavWoepXknRYQfsmkqwDI7nyq7N+5Lrvw85HXq5CkWe
         gOt3+lmAEBAczgD2t6HKM2RsrhCDiooh5gBO7KYv6v/jP7OV/3Py/A8kA+7Vpf5IRs3+
         i276eLpOshFc1/sfgxWMastIsY9QduxtDeZ15r8Rgl6LIkVTrjB2yYmWtZQ5HZM9AbBL
         0soyAEP60hkIYBYfIHTH6J6TKvezHaspqUWv1w/lVZgxzn12dRq2GCCC7Mx6+qaKeYig
         m7Y04g3+ZLgQuW8gixUOB7ymme8Oq1/EHavj9G+8E8xC7uGTeRLXjyLn++z3paz7dejt
         qOqA==
X-Forwarded-Encrypted: i=1; AJvYcCU6R9+KnybpeY9+1Nu/+s8jFspZRJ+1O8HNO+q9OAav+pppGNHcBpgWTBtrW1Y4rqLTiv9anqrzQogr0MwT@vger.kernel.org, AJvYcCWHzJmqJZqTdRiMALpEL1AOsMV942FTQG9uzIYmsxawSaLXiiYqdA9BlXBR4RWi9dtirEaBiR6TgOAwAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1wkaka0mwikusiXvvBrEvy1QXOk86QbzjXWlh3A6//tv8BRO
	ECpN3DYeJZYoaEdLoNtp/K6uVmVgx9x4JozI1MhvmX1lJWz0CYmD/GiJiZb2
X-Google-Smtp-Source: AGHT+IFl0F8VDK8TI+2SWw31p5UlBQYeCPPUv9AJyKtmv/4CMqWc25Im1+rPat3RplPVB4itghh46w==
X-Received: by 2002:adf:f801:0:b0:374:c1de:5525 with SMTP id ffacd0b85a97d-378c2cfecefmr9223537f8f.6.1726481788461;
        Mon, 16 Sep 2024 03:16:28 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e780015dsm6814201f8f.69.2024.09.16.03.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 03:16:28 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] btrfs: Don't block system suspend during fstrim
Date: Mon, 16 Sep 2024 12:16:09 +0200
Message-ID: <20240916101615.116164-4-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
References: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the system isn't able to suspend because the task
responsible for trimming the device isn't able to finish in
time, especially since we have a free extent discarding phase,
which can trim a lot of unallocated space, and there is no
limits on the trim size (unlike the block group part).

Since discard isn't a critical call it can be interrupted
at any time, in such cases we stop the trim, report the amount
of discarded bytes and return failure.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cbe66d0acff8..ab2e5d366a3a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -16,6 +16,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/lockdep.h>
 #include <linux/crc32c.h>
+#include <linux/freezer.h>
 #include "ctree.h"
 #include "extent-tree.h"
 #include "transaction.h"
@@ -1235,6 +1236,11 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static bool btrfs_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 			       u64 *discarded_bytes)
 {
@@ -1319,6 +1325,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		start += bytes_to_discard;
 		bytes_left -= bytes_to_discard;
 		*discarded_bytes += bytes_to_discard;
+
+		if (btrfs_trim_interrupted()) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 	}
 
 	return ret;
@@ -6473,7 +6484,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -6522,6 +6533,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	cache = btrfs_lookup_first_block_group(fs_info, range->start);
 	for (; cache; cache = btrfs_next_block_group(cache)) {
+		if (btrfs_trim_interrupted())
+			break;
+
 		if (cache->start >= range_end) {
 			btrfs_put_block_group(cache);
 			break;
@@ -6561,6 +6575,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (btrfs_trim_interrupted())
+			break;
+
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 			continue;
 
-- 
2.46.0


