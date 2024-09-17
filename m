Return-Path: <linux-btrfs+bounces-8096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F069497B4B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 22:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FF41F23C3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC6192583;
	Tue, 17 Sep 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gez2jX/A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4018DF78;
	Tue, 17 Sep 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605235; cv=none; b=ioXPAhbZyesyntSf3GUD1yoYSWB/EFRQsqdNfOu/icnlQv55oNhgMp1BgRwIdALXYVA5uvjmW/8I23KilmURfeOMBZvuincqyjwGxT/va0pTe/yq1NdXjPCdOqXPZex0+OSduGfjNq2GftdNiN1UZXf21Yn9jQ+nKCVvcKNo49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605235; c=relaxed/simple;
	bh=HPnVI1MJuxT5fwRCFOgAZvf4w4V5FkcMCcMT+RHlL30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlM46ccprwj5Bm+lES35lLocRVCq3OPPxQVXO98Sqet4LQRHVhvewd+Kt55mL1lZcVZmIM+bEozY2aveeOH7wOqytZR5oVrAAda0Kj8boGFw2bBes7ZIoIenjB6ajhNdCumhUcxwwyxBOUckm6EM6baBU9KN4GKCqRXCYMgXpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gez2jX/A; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so40381565e9.3;
        Tue, 17 Sep 2024 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726605232; x=1727210032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XPJtJw1nARsM0r7oxFgXPDKW264HSs0QmHpBBF/tcM=;
        b=gez2jX/AUQhJy9cMXYTJ7mdkzgMvuwIN5gpYP/WG2iR6gZUtx6F9LuxcxVTYhFHhnQ
         eViU2wJS3P6DYk5A9Z1B9oOm8+2SMqNs2c9N073QubgMOzm11sg/GS7EPFB5J+Epg3CZ
         TbTSomvX24TS9570k7XINoagC8iL+z4hUKTP9+NzPnqY7zygao6OovWXyZX1wjXYbCnc
         w9zERf4ngLgWMhMZu7CISpbicS0KdTXVRUrr1XjlWgP+dUP5CXkx0Zb7QSGNfrvDUSPC
         3HUu+FdZuSb1wihnvw0QCwgUMDlnZex6Dhy2k5ruYhZZ84axEUiaX8iGHQF1YmQEDXG4
         6GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726605232; x=1727210032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XPJtJw1nARsM0r7oxFgXPDKW264HSs0QmHpBBF/tcM=;
        b=VLOp5Bup/Jz6+HA1ZjuDDLbyZr3RbS385VnLptJeWhsLVkDwSsuJFrks/F2rHxBEgC
         v8C2rVAw4A9+hIb6JCGm1usRB2vHZBx6mnVzPR22ymVXwKUI0RSmr90/vo0sXpGHmL8f
         epJDnlV1cx4wXKxmP9zjW/ltkvv+ktk1/+m5Qb3VBPLRwwFw2vFBdjMYF3EEL82Qo/FX
         AukMG/OZstr17f2TOXOm4DuqoDzCIvyDbHBo1VTST0Rur8XARj4vFkURuralURifOq9U
         CmqIOFhsOruwd2wQBH8p+lLW+COu/AKlyE782vLKFs8VHFfNtlc3kbu2huRF5eeuM0lm
         SZaw==
X-Forwarded-Encrypted: i=1; AJvYcCUobLgl4cdyiGgMgFRkvMl781jKcwT4fE6RY94lsDkQfEDGbOaIdwCA6YfY69RpXj/SZAmchEcvUdo167iU@vger.kernel.org, AJvYcCVpC9hXyxe7uH2yvYRKYNaH+qJB4Y+l3y4JluTGlaSXyujqXTmPKrE8lVVUvMkR+6NfrWlxzfxYRZATug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+c1a+t7GUjV9mTv4DxMxUhJ0ngzpBdT7lfqBX8gZ9wrhH4G9E
	pT7CPeC7/UcAHpUXcmvZuRmXEeNj9nc9OF+B8lSQAiI15Dp2khCf
X-Google-Smtp-Source: AGHT+IEvSEbzEuKn134/9HENsZPfn9s/7CqN/kH99JV+TKU1zyK5eN8Tr+JPc6v9L31a/Mwx8C4dnA==
X-Received: by 2002:a05:600c:3ba8:b0:42c:87dc:85e7 with SMTP id 5b1f17b1804b1-42e60b36687mr48905495e9.18.1726605231946;
        Tue, 17 Sep 2024 13:33:51 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42d9b15c435sm148304545e9.23.2024.09.17.13.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:33:51 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] btrfs: Don't block system suspend during fstrim
Date: Tue, 17 Sep 2024 22:33:05 +0200
Message-ID: <20240917203346.9670-3-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
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
 fs/btrfs/extent-tree.c      | 7 ++++++-
 fs/btrfs/free-space-cache.c | 4 ++--
 fs/btrfs/free-space-cache.h | 6 ++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ad70548d1f72..d9f511babd89 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1316,6 +1316,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
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
@@ -6470,7 +6475,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index eaa1dbd31352..f4bcb2530660 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3809,7 +3809,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		if (async && *total_trimmed)
 			break;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -4000,7 +4000,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		}
 		block_group->discard_cursor = start;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			if (start != offset)
 				reset_trimming_bitmap(ctl, offset);
 			ret = -ERESTARTSYS;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 83774bfd7b3b..9f1dbfdee8ca 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/freezer.h>
 #include "fs.h"
 
 struct inode;
@@ -56,6 +57,11 @@ static inline bool btrfs_free_space_trimming_bitmap(
 	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
 }
 
+static inline bool btrfs_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 /*
  * Deltas are an effective way to populate global statistics.  Give macro names
  * to make it clear what we're doing.  An example is discard_extents in
-- 
2.46.0


