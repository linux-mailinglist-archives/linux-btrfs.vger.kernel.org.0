Return-Path: <linux-btrfs+bounces-7776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC691969510
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E25E1F26D18
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B420FA82;
	Tue,  3 Sep 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMxxslRM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B104200137;
	Tue,  3 Sep 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347804; cv=none; b=OzjdjQMvttl9En63tWqhXB/iP3qi9nCi0GQKn9MedX8auX+kjZit+1/08lq8zfzA9mCf86P8ug1pxGdvYRwtDtHOb5stJ4aoBhSpzrtGeN78sI4cwZlcY+8M2JxIIFTjMl7jzihPawN/X6CjAF11SntqthQ6O/nHT+mzekVQRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347804; c=relaxed/simple;
	bh=t0LBXBgOaO2ECpAMsZRr7vHDdgrqd95DMqPwzO4EzlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYQccp5ryEKmLCIoWJiXD9h1H9ukzvuERIcDkV/JfWwhrf6PtQR/jkTmKbqHSQY6iov+UK0PaX7tgnPKrmNwdDqHhMmQ1klIG/Cqyxi8jERQrifWLL+L29l5qBpTJ5q5UYtK6xv+a2IhG3/Rl605t3H++CRalSJCiMFYNSAqNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMxxslRM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c79deb7c4so21653015e9.3;
        Tue, 03 Sep 2024 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725347801; x=1725952601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA7sQJMESOQdgSHhoH+FFgeDcGkcGI0Haw9TeaBz/rY=;
        b=AMxxslRMXcCGc9+lK9T9zkZYDsks1YIa/dilPy2kwXUzpReJjeLH08BZz51wYXO75X
         EzRItZ04sPjLWZDtd9UnZvMNVqKd+fDAPcr6Vg2dktOVw+QYjPxGufZ6TmcHVEBTHz1K
         jK2qSEmSofU+6VxygGpVRtphPoAOu+AczazNBWD1i4fwAs439/+a0chQjmfOemraybsi
         zaYwP7PGYNFonRIOJgE6sirjYHi1nhINq4mfERR3b/+E3/YHrafurE0+Pqg4yfx6xdjs
         a0bww0JJS8gnEgpoz0HbE+UUcfKlCySI0+PovGp4nVyMj+OrYxod6284qNcA4qV3h22H
         0OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347801; x=1725952601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA7sQJMESOQdgSHhoH+FFgeDcGkcGI0Haw9TeaBz/rY=;
        b=FGaz5/gGJEyzt4PEmZISvP1XsuUbI7XcQK92Sm5ubjJ6o8ORFYdH1e8DUkxe/KJ8rw
         pOD0FBM/ZS46BySMcIBItEbN/FAAeK/ZOrG6asgLw0zgjItVfZe05eOBF85Jg2iU8/IB
         jJACn3/xl5rUaAzGH0OUDomtKMATc+0uRjjgg9m63mVwK7SU0s75ndNV4oBxaDH2oD3F
         dTfx8UexfCYNaaJVnJHOsQNtA4Sy+iGY0ZuBze9aCI6bPsQ9/JmNK/Ew9SIZhhs/tH7O
         awAJ1ncBpeVkwkSqKnyqOOg06gt+i9ykB2mZgrEGZBloRviDTrqYI6rqirEe+7CHxvUH
         V/8g==
X-Forwarded-Encrypted: i=1; AJvYcCUK6QxmGMBKc5FBt2VrcFC175soOVzkOF5RWffROa8uILagCgZD/6IIL1mLYGlij+OtjXBzNBzg8/eRmwII@vger.kernel.org, AJvYcCXirVFv0V41tscxOVAkVYMFB6ZgsZKwHP3ksc6ydqIPHbr5SlpW8OPOFkb3JcUFciedic0dAYnXRypZgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxadq38YyPjzhmd4+KM5g3uHSkLAzOmprjSSweYKX8d+l9cjZ/O
	v/u3Epxc6gYFbZvfYRZB+dG5t1R277riGx7Ov3Rx0LqFbLtdliVTxCyLvGTz
X-Google-Smtp-Source: AGHT+IGKQt9P5x6UXcDe6UeQqLXTdZl34817rOtn8lmmuEpEHcm1kidHxUNKPUvSywQqhF+0BaDqgg==
X-Received: by 2002:a05:600c:56cc:b0:42c:87dc:85e7 with SMTP id 5b1f17b1804b1-42c87dc8765mr20936545e9.18.1725347801451;
        Tue, 03 Sep 2024 00:16:41 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb85ffbadsm154349815e9.12.2024.09.03.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:16:41 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: Don't block system suspend during fstrim
Date: Tue,  3 Sep 2024 09:16:12 +0200
Message-ID: <20240903071625.957275-4-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
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
index 9c1ddf13659e..ee4daaa56b95 100644
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
@@ -1318,6 +1324,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 
 			start += bytes_to_discard;
 			bytes_left -= bytes_to_discard;
+
+			if (btrfs_trim_interrupted()) {
+				ret = -ERESTARTSYS;
+				break;
+			}
 		}
 	}
 
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


