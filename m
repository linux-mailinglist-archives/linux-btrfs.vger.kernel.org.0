Return-Path: <linux-btrfs+bounces-4815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA858BEB4C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170BC1C22323
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C816DED3;
	Tue,  7 May 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Ltz1syrg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CC16DEB3
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105563; cv=none; b=hkn9+/g1ESYfXKkaoqgHhztxyl73lNxanyijJoarXwAxKgQN8GTvoKs0JPcLUyAjiddUR1jwXGzPJUOAlOWFuNdvgXGLDXXDn8yT7XYbiljl/qP1M587GIvejqyicZIdW0k0SDe4Q/bCHtpJkYo1jStzoiUEzFqHBg6PObzObDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105563; c=relaxed/simple;
	bh=1Tn3+SagoUfzZXAAexFvohSblTFaT4QtJz9w8IcCINI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+hMRQjg+dIhBkr6If+RZNBrJxRWUay2A9Pe3HlJrIZJ9OKGu6tpvyrIcwbR79CXWltAtOt0tzqtu9s3BpKEBKsPl5Ek0S9VkOhVGI//3VESQ3w4kY3t651S4jUqTsZlXTD/6BsT2DJXjktWf/f1RXL3k/DTZvhTnyeQ5+F33jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Ltz1syrg; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de5ea7edb90so3561246276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105560; x=1715710360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Mnhk/eNwsblskxgTsDO1tvm4+/gLwjWmEhn0tCBkF8=;
        b=Ltz1syrgrPVZe5FBGwGx8cL4vt+Z4SDbJ7IsdYCBOBUVD8tcqjcYdf8fVxKThVD5//
         K/1BryQHJ24dCFsbuCLTA/F3Xhf5aqNZnXIvTpMAoAkBfu49lETxR+VFaLg5rROsSp70
         YUwQnyKuq5W1Nfe3/siZwJMZjUXhysLsAtvuiUPs3oj0bq0tMODUtk1hR/F38ue6sG0Y
         TlEP7FspT7jP+On79QkFqqTodo++6Pk6PwLywfhncqldsRRv6YuFcm3mvWEtZj9RJfXd
         WcRsj1vMbJYEuX6Ey4TDWWtfIPZ3lOCb+z8dcayyadyedfcU5t0ph8S1XJtCW5bGuDn9
         V8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105560; x=1715710360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Mnhk/eNwsblskxgTsDO1tvm4+/gLwjWmEhn0tCBkF8=;
        b=baRgRoxru+mWc3BCqrfg1jJl+YSPC3bhYZBfmllQQj/qWIgvwv052cParY1XXuzurd
         jAAHLpqcLa08lROHIPIJ+8hsGTuLt1WP9UPn496NPpsGatPHpyUoqGxLqvRYQiAS0+wI
         G4mik5Bf4tOFGFD0UZphbY2Nfah7ujqJkeMr5dh+MphaZmlkDaYW81z1WFhlCQiYBN+i
         a6RbknjNOvPSwHx2B+FM7ZAmrAaNKLhhTp+349Yct1NabPh60hrueFe9GP6XGNPNa0ri
         If3PuB3xzXXHxYc7g9Fa34j6vwbow0gt9XD3mjHBWLgQ6PqoRSfzS6iaWO1sZbst4qBp
         KK8A==
X-Gm-Message-State: AOJu0YxWfcikuzFxAJ6dCT+M0kI05P54V6TTxBEYBHaso86am/usvNdf
	gnXYnly5imCn2JuUJ+rUxiW50UAbhycQtbho4jtZx/J3RsCX8hd6E+XswG7cp+8uAPXFlazjXiC
	n
X-Google-Smtp-Source: AGHT+IH5kwGLXZfYr3hF13gbawd+hU+fTEcZUhLdK43HIXyug/E24ScMaACjZTCCRSFTEXlDIPcDhg==
X-Received: by 2002:a25:68cb:0:b0:de6:3d8:3deb with SMTP id 3f1490d57ef6-debb9d8ceb2mr491587276.21.1715105560519;
        Tue, 07 May 2024 11:12:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w8-20020a05690204e800b00de60bbad61csm2607720ybs.63.2024.05.07.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 13/15] btrfs: convert correctness BUG_ON()'s to ASSERT()'s in walk_up_proc
Date: Tue,  7 May 2024 14:12:14 -0400
Message-ID: <6f51da324645bbd9e202fbec73614ed2e2c5954b.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In walk_up_proc we have several sanity checks that should only trip if
the programmer made a mistake.  Convert these to ASSERT()'s instead of
BUG_ON()'s.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2e3a2aba8001..c6f8c31087a1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5757,7 +5757,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	u64 parent = 0;
 
 	if (wc->stage == UPDATE_BACKREF) {
-		BUG_ON(wc->shared_level < level);
+		ASSERT(wc->shared_level >= level);
 		if (level < wc->shared_level)
 			goto out;
 
@@ -5775,7 +5775,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		 * count is one.
 		 */
 		if (!path->locks[level]) {
-			BUG_ON(level == 0);
+			ASSERT(level > 0);
 			btrfs_tree_lock(eb);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 
@@ -5805,7 +5805,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	}
 
 	/* wc->stage == DROP_REFERENCE */
-	BUG_ON(wc->refs[level] > 1 && !path->locks[level]);
+	ASSERT(path->locks[level] || wc->refs[level] == 1);
 
 	if (wc->refs[level] == 1) {
 		if (level == 0) {
-- 
2.43.0


