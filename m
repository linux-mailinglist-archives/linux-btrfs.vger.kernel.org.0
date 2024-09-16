Return-Path: <linux-btrfs+bounces-8065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF0E97A2A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBD31F23F28
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E51581F9;
	Mon, 16 Sep 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU89tAMb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7B156654;
	Mon, 16 Sep 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491437; cv=none; b=hPesSbsKBHxJIeJkCYfzkGUDY3Oq8SlAA1jVyjaI7xm3fiZabZxftncZwttU5cYONp/YnDk5P/dBIHi6LQ1ZMMAYo3v7MPY9zCWlT+FOgg0F+C81raqU6s+tRX8K57GEzxgp/Rp3QanmbpsHEVbz8PH1aUB0o+CuI/YWzcqSy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491437; c=relaxed/simple;
	bh=8uBllyDJlc4U/ldVink22w8oM+go5/KtiBhOC/MQGYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7ddsd9v0VFhILSXtuVWTvTyqo8T9oXottQ7XOF1IG7D4jujkKAS8M9lUGzQWppH9/LinkwKXEvUm3eVL4erM4x+Y7Lw+80YGxjOiI/OeTE08HLjt1JkgOlq/tmFDXvRGj0N2LrMiIBYQlJ3n/bodQ9IbC3InYx/PREe+KK5Ar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU89tAMb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so43003145e9.0;
        Mon, 16 Sep 2024 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726491434; x=1727096234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7maCUuqvqku5DtJPieBq8TjJIvVE/clAoBVWSpIBOg=;
        b=UU89tAMbNGWQ9QYZII8HsxYVSK1/AZORX4sWZpxO/5Ff6lGemrzJhLo79N4RD4UYS5
         6T8w7NKmbrbMqF0QFnntYSpwOZdRzyrlVcyk2f1EctHZsTZsLiwQSC1hojH6EdB5QGUt
         wvItdWoI+bPuNZf5N1MIUzJjGxjVlAjyQw5VY6VMhvkC2QRgQ3TW/Xt2KaVZeZJWRWQE
         RlAFKuEjNg3l4aEdTfuBQAeJV9g0TnX03P9ASovpyDNMaGxECkgLsbTN3yaw3KEsNUeV
         /gmmb4YvkyonR7I8FaYcNRQUNKXd5uij03LXaXud4SfpsEKv7xubbu8DAZTCGtCbiH3R
         kANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726491434; x=1727096234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7maCUuqvqku5DtJPieBq8TjJIvVE/clAoBVWSpIBOg=;
        b=vBCN1+OgSQvvjK3D987Mm0+1jfs2P3I2CEMum9VprxpleHwzxVxj8OQgrc6UTOS6d+
         cmSaDQNXML+MFDb3BGUgUJ0lsBrU2VUtRZaXMbOhiDVCuo6vK0+0n/jSv5C1qoD/R5re
         cXHylzK3XiLELwQVnieXrO6Ry5yOzqa+6sj61ezZ1Wx8fsNWcNdhrlQwfMiYpwq6Y7k0
         I3bQvjeqJQ7fD3v6g+NxdK6wL2ANq646SeCDptPMzjrmqigUYWf+V0rGNQjAJBn3q11K
         Fy/JU7l5uYHzmFfohNSMqyMyjKzkrmh73GPB6EESnaWLcQrXxPmHpjNKbIu87rIMWPYB
         Ef9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4bC1bnfHloNhdeFPNyOG0/R6u2xHw+R1fopzfCKhNl2eLqG8dKsOxNa+uk9R0AdniVPM6nz25T1wXOJ4P@vger.kernel.org, AJvYcCWHfTh3/nFzo944zw8i5Mhm6AkRUMnAeBkRRSQK8BXQI3FNhIGMeabcAqDgs/KbzKeyZW7PDwW5pN6WHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJoKKAZiwiQ5Umi7DwVaZACQLzftAmCywjEAtKz3o4qSls1bk
	UzRkqLFxw5UbZ4m9TyjGgW7way7jsSo6I5UNyhWQzEa4fv/zjsSd
X-Google-Smtp-Source: AGHT+IFbnk33wn5kbVw/+K328MOha5PalQj9pkuNKI8yYeCb6JBq2B98slV4gnbu7SHyy8BsQuasUQ==
X-Received: by 2002:a05:600c:4f41:b0:42c:b950:6821 with SMTP id 5b1f17b1804b1-42d90829e60mr106135605e9.19.1726491433520;
        Mon, 16 Sep 2024 05:57:13 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42da242741csm77129615e9.47.2024.09.16.05.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:57:13 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] btrfs: Don't block system suspend during fstrim
Date: Mon, 16 Sep 2024 14:56:15 +0200
Message-ID: <20240916125707.127118-3-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916125707.127118-1-luca.stefani.ge1@gmail.com>
References: <20240916125707.127118-1-luca.stefani.ge1@gmail.com>
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
 fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 79b9243c9cd6..cef368a30731 100644
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
@@ -1316,6 +1322,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
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
@@ -6470,7 +6481,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -6519,6 +6530,11 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	cache = btrfs_lookup_first_block_group(fs_info, range->start);
 	for (; cache; cache = btrfs_next_block_group(cache)) {
+		if (btrfs_trim_interrupted()) {
+			bg_ret = -ERESTARTSYS;
+			break;
+		}
+
 		if (cache->start >= range_end) {
 			btrfs_put_block_group(cache);
 			break;
@@ -6558,6 +6574,11 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (btrfs_trim_interrupted()) {
+			dev_ret = -ERESTARTSYS;
+			break;
+		}
+
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 			continue;
 
-- 
2.46.0


