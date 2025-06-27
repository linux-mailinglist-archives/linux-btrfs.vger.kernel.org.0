Return-Path: <linux-btrfs+bounces-15027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC32AEB2AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8ECC17A5FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF99299952;
	Fri, 27 Jun 2025 09:19:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28007298CD7
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015973; cv=none; b=gQ2jq4dHE/ZAD5+Uz9FV3rALpz9vsyGuZvl4AaGEuYuPLVgS1KN+zMeVlTT12cP7biqzOy2HYTCbLdlITBvOXK7wx3nKHIygxjq9Wyryt8MdqL1/Gnyz37DTcMBB355UxsYqPtFimufTljM8OiXSz2gFzu06GT67GfOaCfaD1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015973; c=relaxed/simple;
	bh=OdxWsp+XWprcDbFCxI0EaNqva0hv0MrtAw2vxn9Snhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxnzVe3kk4G0Nb7VgKxqFzHlU/jbyvIHTKJ4m7jtLLtOaE5iA+nGDxgLtZizntiDlOcKM/BiCDomxXr4gGtMuy/eb5/KTcGcTplDSSKhcGc6vlwOSkplxBSlG7WeCYwkBeJ5OKulr4WbrxBS6XAPySEjt+5qsXNtibWvlYTTNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ce671a08so10835765e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015970; x=1751620770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI3LQnnSaJj+WXkppHpYs2LhFIGF0b4eJGA9NKOnXhM=;
        b=DVGEgr7hV4u3Zda/YzBkszuk3Svk0dGwXGLC1pznxC76+2BnNgPiKf++PhMalNMckW
         VwdT4RJ/t5XFpRuZk9RHB/qtZWJ5ieD9PvS3+PFFpJIDFVjUjxbQqoA0bpAhj1gY2t+w
         CFt6DAbuYPTacQVgF2TzFnTnAVIaT8kNRehIXay/6kvmt2+3amnQsR+lFVQokYUCD2Vy
         C95sdMqi42qvfTzO1CC4uVLtXSSsj0yJCa4hKFSa1oZe43pnbT8myXWWEt3wgUejMLGX
         xi+Tpl0trlyIIPjxqne+iT8Hw6LgisvjYd4SekVAKJfFDqcOvb5IK1JzvUnsToEtJgsS
         taHw==
X-Gm-Message-State: AOJu0Yw5P5vvsySHSwVUTqMba52ClQlUml+dXwRGmmkjgAGf6Ta6Ioew
	eJ3jGWgb+0Kut9USI+KngJCgzsq1+4B6clqlnTeGfdsBAd3i57sYAI2Bj60gag==
X-Gm-Gg: ASbGncsNusgIAggDDAUzTy3/a7BobBTbg10O62jiBjvndWka7YBaw1SQiWer1PK5SL8
	p1maLglBn+/EPBO6nQdcwdr4N482mpex33Dg9HOtGNIndslbA2qLqU9mG189o6RXq41tsTIhCba
	whFu/CPnKsi2FpJpE8bRm+ppE6PAuGST7tZCqFILJKmp+nFAFnvjnP9Kdpwg9WOfhvw/Ghv1w1i
	XAGucVBypxbNjZIfgj5+yJ4JUaxSVvQIBmtMdhtB746RZQAiJdBWmEMFBPyQlVvwFXHgDwK+uTT
	cPzWl1U5nyufEdbYwmZZTRmYO+fDZnX2J1nFcsWaUvfabpYTROUdg20MJQugeYS+nfQwIvUvNQo
	QJjEeve/89NzjBENEahTUlycGy5iQ5Ao1AFQI92qfRsAiiuqz
X-Google-Smtp-Source: AGHT+IG45q4+reD4X1IB3em7s1PAoj+0NMr8Am3E5w0zCzuAZTYUMgKekOz7x25JrWef/Mu+K81Nbg==
X-Received: by 2002:a05:600c:1907:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-4538ee61fddmr27685905e9.17.1751015970168;
        Fri, 27 Jun 2025 02:19:30 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:29 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 6/9] btrfs: remove btrfs_root's delalloc_mutex
Date: Fri, 27 Jun 2025 11:19:11 +0200
Message-ID: <20250627091914.100715-7-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627091914.100715-1-jth@kernel.org>
References: <20250627091914.100715-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When running metadata space reclaim under high I/O concurrency, we observe
hung tasks caused by lock contention on `btrfs_root::delalloc_mutex`. For
example:

  INFO: task kworker/u132:1:2177 blocked for more than 122 seconds.
        Not tainted 6.16.0-rc3+ #1246
  Workqueue: events_unbound btrfs_preempt_reclaim_metadata_space
  Call Trace:
    __schedule+0x2f9/0x7b0
    schedule+0x27/0x80
    __mutex_lock.constprop.0+0x4af/0x890
    start_delalloc_inodes+0x6e/0x400
    btrfs_start_delalloc_roots+0x162/0x270
    shrink_delalloc+0x10c/0x2d0
    flush_space+0x202/0x280
    btrfs_preempt_reclaim_metadata_space+0xe7/0x340

The `delalloc_mutex` serializes delalloc flushing per root but is no
longer necessary. All critical paths (inode flushing, extent writing,
metadata updates) are already synchronized using finer-grained locking at
the inode, page, and tree levels. In particular, concurrent flushers
coordinate via inode locking, and no shared state requires global
serialization across the root.

Removing this mutex avoids unnecessary blocking in reclaim paths and
improves responsiveness under pressure, especially on systems with many
flushers or multi-queue SSDs/ZNS devices.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h   | 1 -
 fs/btrfs/disk-io.c | 1 -
 fs/btrfs/inode.c   | 2 --
 3 files changed, 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a54a0b6e502..06c7742a5de0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -238,7 +238,6 @@ struct btrfs_root {
 	spinlock_t root_item_lock;
 	refcount_t refs;
 
-	struct mutex delalloc_mutex;
 	spinlock_t delalloc_lock;
 	/*
 	 * all of the inodes that have delalloc bytes.  It is possible for
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 929f39886b0e..e39f5e893312 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -678,7 +678,6 @@ static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
 	mutex_init(&root->objectid_mutex);
 	mutex_init(&root->log_mutex);
 	mutex_init(&root->ordered_extent_mutex);
-	mutex_init(&root->delalloc_mutex);
 	init_waitqueue_head(&root->qgroup_flush_wait);
 	init_waitqueue_head(&root->log_writer_wait);
 	init_waitqueue_head(&root->log_commit_wait[0]);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d68f4ef61c43..b9c52b9ea912 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8673,7 +8673,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 	int ret = 0;
 	bool full_flush = wbc->nr_to_write == LONG_MAX;
 
-	mutex_lock(&root->delalloc_mutex);
 	spin_lock(&root->delalloc_lock);
 	list_splice_init(&root->delalloc_inodes, &splice);
 	while (!list_empty(&splice)) {
@@ -8730,7 +8729,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 		list_splice_tail(&splice, &root->delalloc_inodes);
 		spin_unlock(&root->delalloc_lock);
 	}
-	mutex_unlock(&root->delalloc_mutex);
 	return ret;
 }
 
-- 
2.49.0


