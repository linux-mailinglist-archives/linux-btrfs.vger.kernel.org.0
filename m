Return-Path: <linux-btrfs+bounces-17259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83057BA8FC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 13:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C35417D164
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793F3002D4;
	Mon, 29 Sep 2025 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PMjBlLxE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C22FF679
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144547; cv=none; b=RglXKMCBi3cLkY/qG6c3yN6Ws2WvfJ9XcuqQSIVQBuP+7pxjAKPBf4vBamgTPDGv3tqmGJC3QWW3N7H3ZKnPMAX7Qu41nS4HP7kNrv9RQSrEVSQlh4Er89vJSsr6J0SwKaaRPr+Iv3Ja1Pvx3NImH5blMu9MSZ6PrqqEKGdh79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144547; c=relaxed/simple;
	bh=PVseIWiKoQlzUK/LFgr4flb9pJ+0Fa4PD81+jzuHY0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=REHTEcbFwdLDS/Te0vgTK6MV6elPKE8fevWWf7os7t33944kxtOEM1169EbDPJGFC3mTKpT6XvlvOxe8llccKghgeMInApYCJfTiQeSj8IQbJoK+5MVD1yQZ7r7nrtXbczqbi6UPUG+u/ehZmQ/P77xvaEy0vGSAzvwbagc7k2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PMjBlLxE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5515eaefceso4358434a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759144545; x=1759749345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvXpI9Uj0P5knWZZSdS525EXKHAxizO3HKQssPn5KvE=;
        b=PMjBlLxEqy/SNeZ98k1RdWgeXRIb0qljwy0BMX3qiH3q/mMzifm8R0ahZkHkldXTMw
         u9VuFevtXxnTVKgu0xcyX/iNCyfiZNzfS/0OQzEYkR/vzInvT0dl+TI8QnMl9pSAAScY
         H+jPenRo7SZsq1b7U8ela2M7FG8EYWH0k/iTaPEmBueqLwcIm1cuBATSi1/pal6sZVJb
         35A6SGXcx/JHtvoBOlR5MxHBxt028Z2ziL0zKYVY5wyT27CNuklypXF6KsXdON1xl8mT
         g784OWuq9ayUr24CtyxzklIxBmpLwhH070UUmrhC52Bd9U5qdC7O+hvhinBrt09kN0kZ
         2Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144545; x=1759749345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvXpI9Uj0P5knWZZSdS525EXKHAxizO3HKQssPn5KvE=;
        b=tj+9bZlNG/1lcdD+clnOc3YLnZGHqQ213hTJNzgYd8diXz7dgkahBYQSazJtSi6iZs
         M9moSY0rtYZCKw6yho2i3ij8VQFntNXRz+MQIHeKC+0s/8987ril5mxDMaAoM+AV1oOu
         BNjkGSx+XELd9rY2TashsROH4Rc7SWrQTmUJ3EQ/Lp2J1ETdyRsbGvLwIu20BDrxJBOY
         uzYT9tr0j3tY7pu+X+H10+IKb30GPKSgxL3hJTtFiLF8tHP2iQciZi2BnOOf0EHvb8sZ
         f5EfOA9lG1IAqkxOfUlcUU3NThgNrnAWbR2HCz1YGmgtVpy5KGGO6i1xeU7lMinwIgU9
         CHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnRF+ycTSDQ+EN6seCE42ZqE24AH6wajPI3NIHPOOAb1kjjsS+QFXwSJ+ujHewg211hK6adVVhZTzyzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7Aj38rUIokQwvXtZyM0fRusUvFQ03XyOFITLOKKLouk1Cz8d
	YuED14FzQA8zj6IQ8ojEWVrPLOhWiOyV7LeEo5U4MZuZQmSCQTEWtlZyyZ1IwDn0ULE=
X-Gm-Gg: ASbGnctrON7GFY5Y5qJDB5RulHgqHAxgE4D/O6BWEleqorgQK5fz18mZiV5LRjcWXMo
	rvL6POfOxUbwkOCfnBDv/lTEe+kGsLNINs5TG5lFwcqAaVDvEKi3eo3tv7E86wM9HX5ea3nlD/T
	s6l+UPY/j+y46/+FM4Hgg8yq+ZhDHf/MmEUIb4AP9Ba6iifuYUtoBYulLwNsADG+rHtj2wbegfe
	bjtUr9SqiO9QJOLP7sKlgRjEpo2+FoxAU5C3Umn8AqXzvZk0qwgDcVs8LiXYnG7ZxScCDTlaT9+
	EwOPLxbX9z5RypOFgmByDSZJZ+vBlnv54uUTlrvu/PPK3CuBsKjFh1YOD/nPrLZp64YmvN6hu/n
	VvAppFJeeJLncZAoZsx71TTCbXFIas7AP0wMpad6FndQ=
X-Google-Smtp-Source: AGHT+IEvyHlney3PgQuqnRkmgr8JE86a8eWPctFK7OejS1Uga3alUyrnVrUb4vQVgEIV5QeAISy+vA==
X-Received: by 2002:a17:903:4b07:b0:286:d3c5:4d15 with SMTP id d9443c01a7336-286d3c5548amr53962345ad.36.1759144544699;
        Mon, 29 Sep 2025 04:15:44 -0700 (PDT)
Received: from localhost ([106.38.226.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed672aa0asm129207595ad.62.2025.09.29.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:15:44 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org,
	chao@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	brauner@kernel.org,
	agruenba@redhat.com
Subject: [PATCH v2] fs: Make wbc_to_tag() inline and use it in fs.
Date: Mon, 29 Sep 2025 19:13:49 +0800
Message-Id: <20250929111349.448324-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic in wbc_to_tag() is widely used in file systems, so modify this
function to be inline and use it in file systems.

This patch has only passed compilation tests, but it should be fine.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/btrfs/extent_io.c      | 5 +----
 fs/ceph/addr.c            | 6 +-----
 fs/ext4/inode.c           | 5 +----
 fs/f2fs/data.c            | 5 +----
 fs/gfs2/aops.c            | 5 +----
 include/linux/writeback.h | 7 +++++++
 mm/page-writeback.c       | 6 ------
 7 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b21cb72835cc..0fea58287175 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2390,10 +2390,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			       &BTRFS_I(inode)->runtime_flags))
 		wbc->tagged_writepages = 1;
 
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag = PAGECACHE_TAG_TOWRITE;
-	else
-		tag = PAGECACHE_TAG_DIRTY;
+	tag = wbc_to_tag(wbc);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag_pages_for_writeback(mapping, index, end);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 322ed268f14a..63b75d214210 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1045,11 +1045,7 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
 	ceph_wbc->index = ceph_wbc->start_index;
 	ceph_wbc->end = -1;
 
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
-		ceph_wbc->tag = PAGECACHE_TAG_TOWRITE;
-	} else {
-		ceph_wbc->tag = PAGECACHE_TAG_DIRTY;
-	}
+	ceph_wbc->tag = wbc_to_tag(wbc);
 
 	ceph_wbc->op_idx = -1;
 	ceph_wbc->num_ops = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..196eba7fa39c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2619,10 +2619,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	handle_t *handle = NULL;
 	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
 
-	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
-		tag = PAGECACHE_TAG_TOWRITE;
-	else
-		tag = PAGECACHE_TAG_DIRTY;
+	tag = wbc_to_tag(mpd->wbc);
 
 	mpd->map.m_len = 0;
 	mpd->next_pos = mpd->start_pos;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..101e962845db 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3003,10 +3003,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 			range_whole = 1;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag = PAGECACHE_TAG_TOWRITE;
-	else
-		tag = PAGECACHE_TAG_DIRTY;
+	tag = wbc_to_tag(wbc);
 retry:
 	retry = 0;
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac..12394fc5dd29 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -311,10 +311,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 			range_whole = 1;
 		cycled = 1; /* ignore range_cyclic tests */
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag = PAGECACHE_TAG_TOWRITE;
-	else
-		tag = PAGECACHE_TAG_DIRTY;
+	tag = wbc_to_tag(wbc);
 
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a2848d731a46..dde77d13a200 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -240,6 +240,13 @@ static inline void inode_detach_wb(struct inode *inode)
 	}
 }
 
+static inline xa_mark_t wbc_to_tag(struct writeback_control *wbc)
+{
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		return PAGECACHE_TAG_TOWRITE;
+	return PAGECACHE_TAG_DIRTY;
+}
+
 void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
 		struct inode *inode);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e248d1c3969..ae1181a46dea 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2434,12 +2434,6 @@ static bool folio_prepare_writeback(struct address_space *mapping,
 	return true;
 }
 
-static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
-{
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		return PAGECACHE_TAG_TOWRITE;
-	return PAGECACHE_TAG_DIRTY;
-}
 
 static pgoff_t wbc_end(struct writeback_control *wbc)
 {
-- 
2.39.5


