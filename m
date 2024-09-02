Return-Path: <linux-btrfs+bounces-7748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33363968F0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 23:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0EB1F232B2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 21:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2FE1C62DD;
	Mon,  2 Sep 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kblt3aUK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C52139C7;
	Mon,  2 Sep 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310806; cv=none; b=kHwVNyBqg4sDICbLS5LgBD6SvntcE579aTcudck1bcA4wZ3GM6+moefabRFuf710Vjy+ojHgACag1PZ4KmPIOi6LeXTZv+q1ZOa9o0yUXGjoIGifkfp9JQXvOfsG3ZIPkMoLQP/Y6ZEdcQHi+kg8LTljFRRVs+FA1CWFjD0kpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310806; c=relaxed/simple;
	bh=pkpET/uZFHN7xCawNWO7nY5MStK547dU2c9KvFYWEv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCBk1/OGRSJVXE1IvL8hRqOvM3g1RnYzvNeemSpvq8XD6yymGLlU2Zthrq0OJrpa92sy8XyRLsagMcxxj2iQ5IJ8b0+DmvaLnwN3NOxF0FZoQFcAjLLDM2oIJ2G597LBkDohOlqshfSeZUFaqs82XuvL0oyY9+x+97M7vBg8Hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kblt3aUK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bc19e94bdso23015685e9.3;
        Mon, 02 Sep 2024 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725310803; x=1725915603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlxzsdvXEzZryfS+C92F0IMet4pQ2CFegtQZuGlbV9A=;
        b=Kblt3aUKM+p919M32cTyx1PKmBJZEbpcfGU6UhDrWbMc39LEZ7NyonSv5hy9jK8Ogn
         NHZz5NwmESy2USVWrPr6eDki7570uDDMv6PO51qX9O+70htEbOpQZVIvj2JXCj1TmF7O
         YCbUWfxt3c6ieyc6rI+vEvxShDXzflB7H9VoFIUlV8U9JXqbkOiB5dHHsnyJw/fwpB9n
         IFe2TDFNQi58Wm0u+/sf9lIi5v5O+jDz/mQoUZZzLEPCV/SO8BCYVjBUMieF04H1JyfT
         tYvzmSXQaHWs57pZXIiNbVBj87hk0PaMkiQwgZovvYFrbuKr37RjQtRwLDPYLXlvV4Ld
         5A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310803; x=1725915603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlxzsdvXEzZryfS+C92F0IMet4pQ2CFegtQZuGlbV9A=;
        b=p5A1YbTfjibi6mCTUyj1aIu2ZTiQek6nRWpQaG6dOg97EkP19ZgFI/+vZLVW+RCHTd
         QV5hKli8Lloq4WrMtv1zXlzmzoUvBr93xvOUFCHuy+HtIIuVAuuNyDJ3jJkCrxoEtVod
         v9J/FCKVCYI0iV2cQ3+j6klj7RlUgsLXaXBff5NEaadHWkxEjwCJxhNixmCCmOcJ6iJz
         kZWorQy2rG86vkNiQAUrKSqz6++aK0q9j3sWQw6vFZ1c7IyACSe8NM4pz1J3VRsYFoBw
         z5hUSsK8oxRcO2QftQ9KGkmy1bBWLizqdB0kXPQkiVZV32PXZISw6/iy2WWpHU6D8NgF
         XC8w==
X-Forwarded-Encrypted: i=1; AJvYcCWH813CcuGQj0ydKEBbYHF8IOpKIUHA5uPs1J7CBk9ysj+xyWj68pKWdEAfZ+hQZHX3FxRJzfhf+fRiOA==@vger.kernel.org, AJvYcCXkRd5yjJt39ISDpaPV+fpLzauxayG3sfAHJzJzE7FLb+JsmENlnrhGteu7ZTvfVDgX4drE7mUh9vhAkQQ=@vger.kernel.org, AJvYcCXnnLLsancRzpAPY3EroCaSlufBij/GpEhsdbijZ9vftC0HjkvJumoSlj3avFZrRf8kZiQket47I8zUEcfD@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOlMGMNURBP7PmejX0PSU5m/0DOMVI0b2/ohE6lXr9oUazBkU
	XnhAwYkqbKuPTDOZZ+HP1skurzxl4knA5wWSDnEbzosNzxcBHzwm
X-Google-Smtp-Source: AGHT+IFtjjxmX/D2XNy5vajIk5D1o0OYAnOsZdshyL6WHLN4dfHZLBBUQb5XzmYRI6QBDtrgfHcG5A==
X-Received: by 2002:a05:600c:1e15:b0:426:5dde:627a with SMTP id 5b1f17b1804b1-42bb01e5b62mr112014445e9.23.1725310802534;
        Mon, 02 Sep 2024 14:00:02 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42c89dca8absm2913705e9.27.2024.09.02.14.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 14:00:02 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: Don't block system suspend during fstrim
Date: Mon,  2 Sep 2024 22:56:12 +0200
Message-ID: <20240902205828.943155-4-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
References: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
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
 fs/btrfs/extent-tree.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 894684f4f497..7c78ed4044db 100644
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
@@ -1302,6 +1308,9 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	}
 
 	while (bytes_left) {
+		if (btrfs_trim_interrupted())
+			break;
+
 		sector = start >> SECTOR_SHIFT;
 		nr_sects = bytes_left >> SECTOR_SHIFT;
 		bio_sects = min(nr_sects, bio_discard_limit(bdev, sector));
@@ -6470,7 +6479,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -6519,6 +6528,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	cache = btrfs_lookup_first_block_group(fs_info, range->start);
 	for (; cache; cache = btrfs_next_block_group(cache)) {
+		if (btrfs_trim_interrupted())
+			break;
+
 		if (cache->start >= range_end) {
 			btrfs_put_block_group(cache);
 			break;
@@ -6558,6 +6570,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (btrfs_trim_interrupted())
+			break;
+
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 			continue;
 
-- 
2.46.0


