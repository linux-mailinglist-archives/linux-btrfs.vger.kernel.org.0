Return-Path: <linux-btrfs+bounces-16239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B2B306D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339831D25664
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23312391925;
	Thu, 21 Aug 2025 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Noh6+6O1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680437440C
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807676; cv=none; b=U8uJad9RnojomhdIm5pel7JCX90CEdC+H6fVI8NMKQYpRsAmJplFysdMPeGZnkN5obd9Qn8ysTpka+0nAYfpTqNZRvcu8Rd802V46SO6RJ98Y4jE088DnSgwdT7rP6yHN+nA5kEL400lJcMl+bBFVWDQhNwqp8NXClsv/+utFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807676; c=relaxed/simple;
	bh=ncJFwZEJnrUj8IpeTHtrl/YVsygglgXTHVy3Yq69xu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXd5v7nxaotWySR26HRVxmTJVSxZXmHqn8yCK1P7jJ1HFlWbtzvRCDpUJvbHjIbMmY6OT2P9PhHFVr/6eucwJ7TPGjt5f/0SehzRbhj00quelRhL4VNZSOiGIw4f/HjVqUpJbeHiaJ0Thu7usBzJ0WBKqRqgNBbTKZoKna9vMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Noh6+6O1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6051aeafso12624037b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807674; x=1756412474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g58GglhqUUo58s59oHZ910JXpBoXdBxDvcz31WoZTlM=;
        b=Noh6+6O1VBrZag18/Jsw752jC+t2WdDij1ILyT2rRFYsHyJGGN69lGgbCytGxMavtr
         8PVJJOo1qBT5zfZ8d8V4mT/P9JlxUjEpBr/T8Kp2bgvLFm/cFrBhQLYmq77NGUon/G8i
         NV92sSUbhdJFoNO2kTnAApAn7uU1nhUhXKZ8UOcK6JT2suOfRFPdZ99SnS2KgOrgmrTd
         CGl9qjbIhnNwpA/ZnYZyE/SxBFipPIvMLgNB4AhpP1lCkMfQKpIl+G0WdCVMvoJvgfO+
         u25zDuXIF974jlrCUrkp5w865xNa5zoicWgjxUtq9mvNEsUZLEz/xqCNBhfF7Nw6xPgb
         tThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807674; x=1756412474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g58GglhqUUo58s59oHZ910JXpBoXdBxDvcz31WoZTlM=;
        b=gv1YAdC5orkJm2oXJB3kAcvL9dKBo/xWwlbhj5Mg+c6TMZ7V501irGzd7o2gb+PPkR
         uLqYnodYycBdQ2aPvwFIjaPcyAMjY1g2sPkFAcoqqxi/l8xKUa3/0iEHZuE0X8xCtVBG
         VmPm6qbqEComS5uOq3QKUBQLWGksItZoSIOmP2eqTahemo33B6iY9vhrwYcFSehWtLNh
         cMNgip2kdsGDgGMaDSDp6ljBP+XO4++A55r8EnAGjddSZBJO2fSnQZ6R8fY/dviVr+ZF
         DAoQHtbJzwUW0ES0MCjmy6Fjjy1/z3rx/FlqTZT4k877ZwLGQAMXZ/AE1RrTW5hqjnwr
         P6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW8K/7ZwuCYuR8QBOka/gLT/cuTJZ/GCje1vrKEWHSdpLdQYvDwMsktvLCSPTudau04qzeOpnCJ9wPLHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcwrluY8uLce4RrL4cQMRKDuTOl8rq8GsdiKLPRc7huteAsPkJ
	IVpMX4hKMyJzJ4pSqacTN6yUB56zibTjvlH1vVN/xRnioWmLq4gh9aWCEgio1/FONh4=
X-Gm-Gg: ASbGncvjwFt0rjqgMRfAh2SdgmOb7PmdUOv48KVY4yia7c3+7G8MoAdE2SzMMqFXrTw
	CfbaO+ph/X/5iyaQVJcF/9+nHmsqra8y7FwoPn44KWmpKO/a0Fg3021JoxESDMRTcgtTu77ruCW
	0dZXcL/xEM8YfUOF2J0tIr4TtL1rZjZHwmvaPjLbCKh+iqqId2gjZ4pYxnPELSN8AZr4/Bz55nC
	2ip6PMoscTwnmKgykgjtInIwsK5ypZmTyUiB5/MCdYrqQnmmnhcpz48awXq77Rl9bRGYW/ozPef
	pFpuejFYEsqWkA+VXbN4eRvn0ZjZ94JN9yAaL8gsPHtw8n9Eb3UYFObPahhTTfT3cUcoD1V4hhH
	4fxJRgIkPVwMypF0ALqQir2EMh6Z8Trc+b041DxjTI22JM6EzWKhzCF7hSkNkAMxydsup1w==
X-Google-Smtp-Source: AGHT+IEqiDcFpm5jVq2WLhuv9tbmk7e+a0LbMcXW6cqI1uIKhRjkqvGvdJzMtVHbr+LWKhC12dhjiA==
X-Received: by 2002:a05:690c:6702:b0:71f:b944:102a with SMTP id 00721157ae682-71fdc5389camr6706207b3.51.1755807673675;
        Thu, 21 Aug 2025 13:21:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e84367526sm34113897b3.61.2025.08.21.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 38/50] notify: remove I_WILL_FREE|I_FREEING checks in fsnotify_unmount_inodes
Date: Thu, 21 Aug 2025 16:18:49 -0400
Message-ID: <6fce2524c1614e400f399260b5a2bc5c10d9dacc.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can now just use igrab() to make sure we've got a live inode and
remove the I_WILL_FREE|I_FREEING checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0883696f873d..25996ad2a130 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -46,33 +46,15 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
-		 * the inode cannot have any associated watches.
-		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-
-		/*
-		 * If i_count is zero, the inode cannot have any watches and
-		 * doing an __iget/iput with SB_ACTIVE clear would actually
-		 * evict all inodes with zero i_count from icache which is
-		 * unnecessarily violent and may in fact be illegal to do.
-		 * However, we should have been called /after/ evict_inodes
-		 * removed all zero refcount inodes, in any case.  Test to
-		 * be sure.
-		 */
-		if (!refcount_read(&inode->i_count)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(iput_inode);
-- 
2.49.0


