Return-Path: <linux-btrfs+bounces-20091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE97CEFF51
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 14:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848F2301F7FB
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13815A86D;
	Sat,  3 Jan 2026 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG8xo1Qh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAB22154F
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445610; cv=none; b=KT/Xz02TCKIbbHQdC3l17OpvfkWBhdRbCy3QzbE0iIQq+yb6CEknv5qyu4dntLmkcsqAaO+XQwOu5sbBURn5eaxVgYj3lF1/kcQzpGeDszpuKoNxIx9X+cyhGLqEhq1Wf5cAfrWSeQuUbDYnU9uGPRI/2+DOc6YA5eMVZop5aR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445610; c=relaxed/simple;
	bh=imZa0HeUWwHEHqBcw5JglFpQZFjkYnL9sIr/8QOXWS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j47bLAXG8xT/xnJIhR70OYMq2s/jUIDDzMsmDPiGshSNDGRlhtbF/qP+FU+GqAOM+4Xkbpy4nkxpxMV96JEtg4m+BJ67VIssZAvowxC+q+eS/UNB7WuD+16+hnbTWn+8jtMY1cvMyHSR1cWcbW1wz5k26XVNqW++3lvyGyayI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG8xo1Qh; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78d64196795so10915247b3.2
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 05:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445608; x=1768050408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWYdUp6yz/n4XcfrsPe/c37jj0G3r6+H8ur45DAUzqg=;
        b=SG8xo1Qh8BKzPN6hILYPGwPD6HSS/GPo46Fy93uFY2oy7giD2Xn/3+gqMJ+wrqyJpq
         XwyY/G45e9287wWVOgdlc8X0lOyvTKYworA57QIyoZbDG5GwN9pps6SMpuTf1qg/1qeT
         8kVVysDrxYyqne8hp6prcCSmPZBURKRbS11diUDHEk0WDVhKkDJo9MuMYn7sfxg5D/pS
         uoPe8MQw3lS/RfFRBN63O1SuD9a1MJIsneRPmRRtEOukQDxgWM/IV1zIoabij3cEKFSB
         igkSC+ruQ9CHfGQ81DYBehabRihNDVnR0vipV2QCOcIQ1IBfk/5U88ew2XKpDQ1ymgCj
         QRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445608; x=1768050408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RWYdUp6yz/n4XcfrsPe/c37jj0G3r6+H8ur45DAUzqg=;
        b=MsqyAX/fPPKGKp+60YbTzvCUX8c1UJ4d8ClsiZyWCGOPWSCzXDySKYtrPpHP5dz2H0
         f8CNX9/tenDT33itB9hVu4GqZOCsQM+ruqYr0H37/9sETxYY0lS0FHOS0RhqiZFeS46G
         g+Y9ycetY0a+2bdeca68delBP3PNcz748fwBT2ZdNtlJ3z8Fnyh3fCZKgCq55JzP4tbu
         gDsTSJu3avbCaTPXwQ6dViWYKQOGDJBvagUUaU916iTplqArwZ+OXv191wS5FtdGMCNf
         SUCsZt0hNhotnOZj1pwdc2xnsHuX9VKSSFlu59kUU0/1nqx8qKFmxn3ass+7BKA9JtzB
         CV6A==
X-Gm-Message-State: AOJu0YyrnRXTyaLxrFLw2KCZo7zKv277s27kSN05/IP0r+ESOsHJBt+D
	uirQLyBQb/UMrPiznHcUX+V5DhIJRV4lhXoBWsKEyDQnjd1XkwYrshO5ZCu49lj8bAvUQg==
X-Gm-Gg: AY/fxX57SK5L8AbJx6MxT+SBn9GftRNReYN9GFsuK9mn2DVl2Kq/pqI7TdgwkvZb9/h
	F7PSkmOaNlL79NjAWJvEKJGBIQMYEZ9QM4lxuLLF0ILxZBkVfK1K1eN/jwAa+IiFLCD8dQZIUwE
	qgbq/iASCTLhF+K2uI5hTQPH3bAgfaDYAePB+pPLTJLMuBt5PrbdtCl8vatueRKH9kwycOwPNoB
	TJznkHmZUCn6ezDgAXC0P9ipq0lEtXimSyeRWHEiGdHy0EngUIPD5eQK+f0HKObpg488PzJRWpV
	66QpD1M80/QqZfSZp32CUjR5nXWUP2MEwqXPUit5UO8gkQLRJVj2IDgSBx84Qhc3B7bM4jr199K
	kH+AWxtbI8p24rhHhD/Q7VeA/657wHGLnNAr4wIDNawmbg0VHJDbIXxZeUH70QGszSK+XLQl+nT
	+OCCeh56i4xarpyI0M0Cs=
X-Google-Smtp-Source: AGHT+IHW4puJR27B1o1s4eQ7hk8ogpQ6ayvriaCazOmihFAH2ee/ASNyXWjDYJqWadL4EpyGJaZIIA==
X-Received: by 2002:a05:690c:12:b0:790:63c1:da73 with SMTP id 00721157ae682-79063c1db05mr47789177b3.2.1767445608135;
        Sat, 03 Jan 2026 05:06:48 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm112554957b3.15.2026.01.03.05.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:06:47 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 6/7] btrfs: use proper types for btrfs_block_group fields
Date: Sat,  3 Jan 2026 20:19:53 +0800
Message-ID: <20260103122504.10924-8-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260103122504.10924-2-sunk67188@gmail.com>
References: <20260103122504.10924-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert disk_cache_state and cached fields in struct btrfs_block_group
from int to their respective enum types (enum btrfs_disk_cache_state
and enum btrfs_caching_type). Also change btrfs_block_group_done() to
return bool instead of int since it returns a boolean comparison.

No functional changes intended.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 88c2e3a0a5a0..bbd9371e33fd 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -162,10 +162,10 @@ struct btrfs_block_group {
 
 	unsigned int ro;
 
-	int disk_cache_state;
+	enum btrfs_disk_cache_state disk_cache_state;
 
 	/* Cache tracking stuff */
-	int cached;
+	enum btrfs_caching_type cached;
 	struct btrfs_caching_control *caching_ctl;
 
 	struct btrfs_space_info *space_info;
@@ -383,7 +383,7 @@ static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
-static inline int btrfs_block_group_done(const struct btrfs_block_group *cache)
+static inline bool btrfs_block_group_done(const struct btrfs_block_group *cache)
 {
 	smp_mb();
 	return cache->cached == BTRFS_CACHE_FINISHED ||
-- 
2.51.2


