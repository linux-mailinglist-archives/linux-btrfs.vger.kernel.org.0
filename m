Return-Path: <linux-btrfs+bounces-17119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72743B95816
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 12:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BE37A5912
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F2322A1E;
	Tue, 23 Sep 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhZGN+uX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103032255D
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624457; cv=none; b=R2PkZZhksVFKsPOUXlHYnlYJ8ywSbsgE11Jjf6XXTL2wZRmZweTm6iyDtQhyFEVXpFkFdqgotmi+DXqnHX/LvPH+Z9W8mZXqcww/ayL/xouDGAIPpkRRmEpPQkm1uAVMv1d+GRCmYlQXurHxRCaRJFe3phYnL2psjDMz5WzFLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624457; c=relaxed/simple;
	bh=ouMLdiYXJEV/tbThHG/kXZjFoWBywpLKJo/Paio0wwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZMI0ZGMtVABbJozoMwcljYQDVLJhzNaNiSKY0VViJXWU4lwgEylpwKJckVDsLz9/HlpUt4uO7wGq4KQzv4xiBsoATA9Z3WfZfJ1dC2CSNEy/mrJJ8otKBq1rsNGS6VnSKeDc8mw1whs3vS+aiESenEK6bf6CkVULho8gHg4oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhZGN+uX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so39850545e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624452; x=1759229252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjQhtecysAf2+Tm/SiAxvWYNu2I/ZUKX2kulTrssyjQ=;
        b=LhZGN+uXvnRcZp/BkNSZYpY3HLnrF3MIXUHwRe5694SHPoiXPSjIF5o1Cx+hffoY2D
         wLQnIdbqbp35ju7NMkMmutMG6NxIK8kC9I0PKqjPRo3MlN6mwCJzofAiR4aChInAl7Dv
         uaazvsOcIgmaXfy/dWRVf/OhqHPCYnw40d9hV0nqJHuGnrYlHFvc4aKobLXWjPH/DEGO
         5oFXfC+bDh/jOq/E0hzacTXcCu3dhKCjCeiUmPNy1FWresmWjR9SPuCx7AQWtSGJxaGZ
         jYjbsboNrycDe21fu6Ip2tQufSoGiGGCcxId78Js5h4L5suYrY2HneCBlUZX9HB6XZjW
         d+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624452; x=1759229252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjQhtecysAf2+Tm/SiAxvWYNu2I/ZUKX2kulTrssyjQ=;
        b=nWOFYtIkg3pjlX1ihIwL5zU/n/HhTAnKPJ2tQBjp58vqQQK2jD+YlBew3ZsjUrLCQz
         siyoyKCT95VWMO8QYXgGtxo7/GrjUE2GgWxckMyRjbaQqOCjzzVRGCkCDirbOEByJ4hV
         Fag0hTICmCVV3IQCgQMfubKkA/jjKQi7YITNNEzfz8XKddwWfeIfCR60oXydf1OA0NG9
         jQnNd3bvmf2TNqyLAXMR+G2nS2oymK9wOU+UUVrk3HDpkHC9xQ/GvXn8U0+Y8qyVfOyK
         f4Au73f+8OTsbweHtKZVSI0NZ96g52L5a51v+q0j6TtWDaU4qkApxftgu7l89p4cLcFa
         e+iw==
X-Forwarded-Encrypted: i=1; AJvYcCXS2X5fM9rq/iTcIRPoDf1q+u9mPQL5v9zDGGyJahRNoWmFWJJ86Vwyg7e575eFyvnr4gjN4P0cm4TEYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywek7qlFShY61HsimG+rHfIXOi+G6dxkIerEYhA56V4LkFy+x2i
	J4TjnaVa+P2ptsXzUtfu0JfqdnxtxlL1qjHoWAk9jc7CrQyHJp7tAdtD
X-Gm-Gg: ASbGncuVA3UPuxyIm5vQv3mBH4jGgjrzhatc07IqunyWTH8Lqb3vANFD5vlqnrK70jB
	t6My5h+A56GkQDYrQENy47owuvfL2XqHNrDnFnIQF51/sQ1ss3KFBf01r2VXrXghRQYGo8Jpwzb
	IS/JA0BykODiseUomMadnvLr5w6f6cqd0wvqH250LlqaGzyrqDy9tcSybGK8rtLh1FyZdUkUhSD
	eYZKAkBS+VAgoRc5BA9ZWMiGzakVZ8J67Jnh9vdVoKO88muXG/qMd5zizELnE9VqVBZBm2rf5k9
	dXn1Iw9yzkxVzL9P/8IU4zGVWal9/S7q6M5IrdDxC9JnSjW5HiKe3kuFVyJvt/Nu8TAoCff733y
	E5x7i1GIhc/g9lYRoKln6D0IwQdgxbCy6dJdqRsbhYpflkk9oLadgq3HKLF5A76va0YsT+oGbGJ
	yP6OuY
X-Google-Smtp-Source: AGHT+IEVb9i92+ZMOauFSkmxexkNVrc4dNm4CbgsPp4IcZSL124eR4borVyarFVwdram0vM+rxqviA==
X-Received: by 2002:a05:600c:4685:b0:45c:b6d3:a11d with SMTP id 5b1f17b1804b1-46e1e1121edmr21348615e9.1.1758624451919;
        Tue, 23 Sep 2025 03:47:31 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e23adce1bsm9710525e9.24.2025.09.23.03.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:47:31 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v6 4/4] fs: make plain ->i_state access fail to compile
Date: Tue, 23 Sep 2025 12:47:10 +0200
Message-ID: <20250923104710.2973493-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to make sure all accesses are properly validated.

Merely renaming the var to __i_state still lets the compiler make the
following suggestion:
error: 'struct inode' has no member named 'i_state'; did you mean '__i_state'?

Unfortunately some people will add the __'s and call it a day.

In order to make it harder to mess up in this way, hide it behind a
struct. The resulting error message should be convincing in terms of
checking what to do:
error: invalid operands to binary & (have 'struct inode_state_flags' and 'int')

Of course people determined to do a plain access can still do it, but
nothing can be done for that case.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 73f3ce5add6b..caf438d56f88 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -782,6 +782,13 @@ enum inode_state_flags_enum {
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
 
+/*
+ * Use inode_state_read() & friends to access.
+ */
+struct inode_state_flags {
+	enum inode_state_flags_enum __state;
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -840,7 +847,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -906,26 +913,26 @@ struct inode {
  */
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline void inode_state_set(struct inode *inode,
 				   enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | flags);
 }
 
 static inline void inode_state_clear(struct inode *inode,
 				     enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~flags);
 
 }
 
 static inline void inode_state_assign(struct inode *inode,
 				      enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, flags);
+	WRITE_ONCE(inode->i_state.__state, flags);
 }
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
-- 
2.43.0


