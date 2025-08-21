Return-Path: <linux-btrfs+bounces-16209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB63B30639
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D192AA1B21
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8160371EAA;
	Thu, 21 Aug 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zI6kRgSf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AF372181
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807630; cv=none; b=lzdvDiRabI9sNoKQzLgh1QNI6q1J6/E+LwCYUxopv4Sa6QLL7qoRl2ovdViwMiRy/KgJhPHu+oDmaru+81RFp/9yeVwyXWq2adE/Y2TzqXuFF8tyaz0snrjtkbQU4ynD9o3gxlIoffyyIpJFMxSxBnhUV0Nbc4+iir8q5y1vrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807630; c=relaxed/simple;
	bh=JqyAltqlHsDhxnWV26UFEbViQ/nho1N/pG6i6mXuWqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvEUtZY9exwG1rATAAPQ1QZow96lBs1ZJSUa+QVFPY7jg+w5u4IZnHtjxXdoZ5ghwi8nMHwf/oz+KKI39PyDUpomZDZim6KferaeKmXoyiAjYPltNYd7nLqh7Ozf4/GmsSFHGKIirk/lNr0bZHTExx8ewC1oFExva50CGQIwpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zI6kRgSf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e94fc015d77so1481166276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807627; x=1756412427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb2V9k5PVP583r5lr+1rASUj/P55tkAhqxStui+NIFo=;
        b=zI6kRgSfIggsXgynOSYpwQgheZHPxE9zDKl56XoWVJlL7+8yc7XqTV/DMoTsB5JYiG
         JOm1NHV86TInnLQK3VauPw9cIgv9QIEJ1/E9HN8TthgjSuEn0ycFwNERlixjrvgyF8KL
         ZfEBpE0LQ9i9tO7rBtULHfH6XIyjUtOtjpx05nIA65T7p+hICIr46vB4XqOwZQLnoONB
         zD5vyoinQodbs1Nyry584tRUz81OLdmFVSEd6UscaP7STMVTh6TA7wMazQGwJbgzOokx
         GJMKyYOQe2aMN/oOIr9t0R5++hIoloQvJgx/WW03drSojf3TBFGN/ZSe23oCE7hTiivc
         SpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807627; x=1756412427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb2V9k5PVP583r5lr+1rASUj/P55tkAhqxStui+NIFo=;
        b=m0vcaVLfFb0nP5URcTia09fQSAPw80sFM3r+9DZSf0ucW+gydWUbgeycrGUEAXULF/
         UtEtv6jUPycWNz91vdcTAGm6D+j8feQ/KTWsCqcACCfvSnCTlIqkxbpdW49FazbmbObT
         jPDgJxtiWknkObTpTQq73h+Ofh9bgDjVyhLVe/l1+WIT/dQV8blxFlDO7ZwN0AneOwbY
         wOQNmyuYQQjnyRkfHTVnkdLJu8oe1s/U/MbUbuL6vdOPb3r0kyWVCtVS8mBPXl2bjFtE
         fpOFv0sNJbjbBdKOcCsL5ETZX8JDka6Sb8TAIewVyO4xqTVfvmFKjIYNhjR4D02nYM0f
         zrCA==
X-Forwarded-Encrypted: i=1; AJvYcCVmlMaV1OTm27Mzg5H0W5f9xLLmkYBbWFSBA2unZUcgLwnzbjeBN0Q+a5hxHrdwfSq6AhhvcvtcPGfxZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCLzXvaw82j3LHfvLaC6m7TR6PVSqHUd4vbdZH7P0WOC4kTfJ
	0lE/anR58YAyyPZFSQ+rFB6TcGhBzjd8xtFmsbxCgrHcQdGW/4aeOYgaaQqcb3H8m0Y=
X-Gm-Gg: ASbGncvW2FHs+Nmv0+IyhFtK+P4UdgAkLHDkHVJF2rNH2maOhPP3oZbV+aQR+CAS2y2
	d7MY9HeVMQ7kd9QDDCKuMIycFYBdhLkLyNHSL+3gDvyLFyDqKpxw08dt4sAGq5/aLZJmTmpFctv
	s5BaeitccGJa0jXgnB7CqnVxC8HtuK/jTDPuU1dy0T2Zjx5+oFc2ZSldIu+G/70DUN+sSFy+uH7
	u/wvZG75P1uzwpHaSIdpr+xrasFtu4SMhjnhSH786z9r2vEDJnB37wfeRoJXq9K/MNxGArXs4xz
	GzpAv5HYPXVXq5o1HmYFjOFZBRMmf2w6fV1ExFI4KdKViUjX1BRUh1q25rL3ivGhXJz3H02DI2E
	MdP9cEEejNufXEcgmBeprAdRuUILnujGVqGflB4xPFFmVsD0IwMdl9DjUjt0=
X-Google-Smtp-Source: AGHT+IE87W5Ra788mXEaYg1x3BO4fJJ18wjL8kms/6rnsfpL0Qf/z0M6cHEdhh+NBNhq7o8SIEAtHA==
X-Received: by 2002:a05:6902:6c13:b0:e94:ffa6:177a with SMTP id 3f1490d57ef6-e951c2428f4mr1122255276.23.1755807627448;
        Thu, 21 Aug 2025 13:20:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9519ef31c6sm374368276.23.2025.08.21.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 08/50] fs: hold an i_obj_count reference while on the LRU list
Date: Thu, 21 Aug 2025 16:18:19 -0400
Message-ID: <1e6c8bb039a6f1e76347b3214be78326b403c57d.1755806649.git.josef@toxicpanda.com>
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

While on the LRU list we need to make sure the object itself does not
disappear, so hold an i_obj_count reference.

This is a little wonky currently as we're dropping the reference before
we call evict(), because currently we drop the last reference right
before we free the inode.  This will be fixed in a future patch when the
freeing of the inode is moved under the control of the i_obj_count
reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1ff46d9417de..7e506050a0bc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -542,10 +542,12 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (!mapping_shrinkable(&inode->i_data))
 		return;
 
-	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_get(inode);
 		this_cpu_inc(nr_unused);
-	else if (rotate)
+	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
+	}
 }
 
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
@@ -571,8 +573,10 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
-	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_put(inode);
 		this_cpu_dec(nr_unused);
+	}
 }
 
 static void inode_pin_lru_isolating(struct inode *inode)
@@ -861,6 +865,15 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
+		/*
+		 * This is going right here for now only because we are
+		 * currently not using the i_obj_count reference for anything,
+		 * and it needs to hit 0 when we call evict().
+		 *
+		 * This will be moved when we change the lifetime rules in a
+		 * future patch.
+		 */
+		iobj_put(inode);
 		evict(inode);
 		cond_resched();
 	}
@@ -897,6 +910,7 @@ void evict_inodes(struct super_block *sb)
 		}
 
 		inode->i_state |= I_FREEING;
+		iobj_get(inode);
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
-- 
2.49.0


