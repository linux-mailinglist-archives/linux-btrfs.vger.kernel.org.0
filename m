Return-Path: <linux-btrfs+bounces-20087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DC5CEFF48
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FBA5301E22D
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A9D2FDC40;
	Sat,  3 Jan 2026 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3rTi63Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2415A86D
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445597; cv=none; b=aH4bz18ppEaZPsX2lD21uWNSxdByh1T/JH5nAlhA+yyXyY8o5+DPu/kljZ0K5dNBgjHjC7t/RNZB9TX9Z9m5EYkRPvyKDeLZ0xadXiiRB1lECEkSNxB2CFPpvVISVvCqvEj2pdCBHHxWIl6AOUWS3wJ5ROt6Vq0sRBjSyt+a7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445597; c=relaxed/simple;
	bh=94Bxp14wkSct3489l1vc/1eS94ngWiCguTBl3ggu8u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtOPL3VkQQauSzx5Jdidgj2k8b1CKxd7mu7cDlNgcjk/68HlLwflGtSfta4F4nG+JoLvEt55uuhu4yzNocq0Nq2uepVaHemTXmZOeZYzn/7svXL7qY617KGjd9kuDjehMqd65jJ5y5tH9guSVFmDpVtKXMxE3n/ITfO/L8iw+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3rTi63Y; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-644752b3105so1486621d50.3
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445595; x=1768050395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsYLYBkGe276Rck++izp+gPB6K3QwoLA2eLCLwYpbEI=;
        b=l3rTi63YMFQoXNlxBWJLvgMX11RxHztHsTta+11t1OU451zMSqMhAAonaHNYvuEuiC
         1jw2OVzTGM8AAMM9u7JYXz0mvjpBGlmgQtola5yCItzWLUURueMEF8T+i5wqS5lkwHvu
         wjMnFKDFC+v2xUTzSjB+6PFwguqi/yFsfa1tNa5RyM/CLGPq1beO74CSynEG3zrUUZHN
         9KDabmxWXcpOgGV70njOK+YGPa8PWqwAYLZDC1T/4HKflk5EnWz6wvN/iqJSA0Fkhv3L
         16XVWWjYNTXJSE50mr8D6HYTf6jfwRnJ/YRTtAdMdZ+Lcsih9vzpKbZyONORXq8cIZwf
         rCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445595; x=1768050395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZsYLYBkGe276Rck++izp+gPB6K3QwoLA2eLCLwYpbEI=;
        b=F+C4wnvYbdBKR7jzPfE4/F1MQbp6jfEM7J1m7D12xwIWaao1ojhIhr2XJohfRDqPzU
         uX0TXtkZuYLbfzUwJOvpPVKsSgKEop9NahUisVxOAu0Utqa6sPfYMQaGews7q8s+q8s7
         lEBYHvKIKC2eEb8PDMJ+wZ9JgPG+gWOPK69+QVN8klDLg7bq19TPsLi0wm4OQWoGqBgQ
         +9vfakl5sjP2yTcj6xxxw8uNfWEiHfEigXDbtFTfYOq3ItVL9N51isBPmBMnethKoAws
         Z+AGOdK58NF5YAOka8EKyXsH0OBZKSSAGWHJRej4A/yrNVOMwdEvWQ1IAn4EdkYbrCGu
         KkCg==
X-Gm-Message-State: AOJu0YyfEjcav6Crr+icV//xLx+OY90ZCPbs4xNF3fCN8d3Qioum3hnz
	FN1+jAgICo8sdqV15WU2ENyWNwD2mpq298G1DvM8rv+pR57wwjICOTy+uYP0DGrzV9HxkA==
X-Gm-Gg: AY/fxX7gcFwyaLwQBvabTU8pMWFrZDFY9/F3gCkteO8vZ3oJ0YTUMqeAUu6g8Ebn2db
	Di42w2Muo2+0A2KHfOEY66cMjXMNEDarcK1qA7n54h083RKDTSplVZY7Mzx8LWSE6QYnOpd3PAp
	AZHUKN6rzmuj4vpmrIufO08DVtvOvMXhoYDroCBv63rvhuxVEmt9P/Tw2N0kZnGOG3FNpC4+8o5
	jqv40NGLeOnumH34ZKn3QeGNdi6birOmV76mc/J6baz3YI7mre+WCkqepwQYXSZks5lSKyIT23w
	xqrTAQzygHPMssc55I8yzu+7smJwC5vAVkFYhU+c+vLetLUvApHspwsT9zXgfrme+wG94RMFXJU
	1OTpTiZBZWEXvMMwphwvK8mFuv5ZEFUHa5gOTsT3ucLdSegqzN76vs63Sdmv65FwjVI6xcCLMmo
	mKLo7YiAp2mxmlNMfFgms=
X-Google-Smtp-Source: AGHT+IE8iIvGPTrp1WtEf+SU/RGHRnR1v2s5pakYSeOEBaTFeEV5KjY6+LKZp7WKaJ2TuQ25RFtUKw==
X-Received: by 2002:a05:690c:f81:b0:78f:c09e:9ad5 with SMTP id 00721157ae682-78fc09ea113mr308563147b3.7.1767445594766;
        Sat, 03 Jan 2026 05:06:34 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm112554957b3.15.2026.01.03.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:06:34 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 2/7] btrfs: use u8 for reclaim threshold type
Date: Sat,  3 Jan 2026 20:19:49 +0800
Message-ID: <20260103122504.10924-4-sunk67188@gmail.com>
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

The bg_reclaim_threshold field stores a percentage value (0-100), making
u8 a more appropriate type than int. Update the field and related
function return types:

- struct btrfs_space_info::bg_reclaim_threshold
- calc_dynamic_reclaim_threshold()
- btrfs_calc_reclaim_threshold()

The sysfs store function already validates the range is 0-100, ensuring
the cast to u8 is safe.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/space-info.c |  6 +++---
 fs/btrfs/space-info.h | 14 +++++++-------
 fs/btrfs/sysfs.c      |  3 ++-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index de8bde1081be..29dffbd9aadd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2037,7 +2037,7 @@ static u64 calc_unalloc_target(struct btrfs_fs_info *fs_info)
  * Typically with 10 block groups as the target, the discrete values this comes
  * out to are 0, 10, 20, ... , 80, 90, and 99.
  */
-static int calc_dynamic_reclaim_threshold(const struct btrfs_space_info *space_info)
+static u8 calc_dynamic_reclaim_threshold(const struct btrfs_space_info *space_info)
 {
 	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 unalloc = atomic64_read(&fs_info->free_chunk_space);
@@ -2052,11 +2052,11 @@ static int calc_dynamic_reclaim_threshold(const struct btrfs_space_info *space_i
 	if (unused < data_chunk_size)
 		return 0;
 
-	/* Cast to int is OK because want <= target. */
+	/* Cast to u8 is OK because want <= target. */
 	return calc_pct_ratio(want, target);
 }
 
-int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info)
+u8 btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info)
 {
 	lockdep_assert_held(&space_info->lock);
 
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a49a4c7b0a68..3cf22d7fad20 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -132,15 +132,15 @@ struct btrfs_space_info {
 	/* Chunk size in bytes */
 	u64 chunk_size;
 
+	int clamp;		/* Used to scale our threshold for preemptive
+				   flushing. The value is >> clamp, so turns
+				   out to be a 2^clamp divisor. */
+
 	/*
 	 * Once a block group drops below this threshold (percents) we'll
 	 * schedule it for reclaim.
 	 */
-	int bg_reclaim_threshold;
-
-	int clamp;		/* Used to scale our threshold for preemptive
-				   flushing. The value is >> clamp, so turns
-				   out to be a 2^clamp divisor. */
+	u8 bg_reclaim_threshold;
 
 	bool full;		/* indicates that we cannot allocate any more
 				   chunks for this space */
@@ -217,7 +217,7 @@ struct btrfs_space_info {
 	 * freed any space since the last time we made no progress.
 	 */
 	bool periodic_reclaim_paused;
-	int last_reclaim_threshold;
+	u8 last_reclaim_threshold;
 	u64 last_reclaim_unused;
 };
 
@@ -298,7 +298,7 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
-int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
+u8 btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 static inline void btrfs_resume_periodic_reclaim(struct btrfs_space_info *space_info)
 {
 	lockdep_assert_held(&space_info->lock);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f0974f4c0ae4..468c6a9acd3b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -937,7 +937,8 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
 	if (thresh < 0 || thresh > 100)
 		return -EINVAL;
 
-	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);
+	/* Safe to case to u8 after checking thresh's range is between 0 and 100 */
+	WRITE_ONCE(space_info->bg_reclaim_threshold, (u8)thresh);
 
 	return len;
 }
-- 
2.51.2


