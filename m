Return-Path: <linux-btrfs+bounces-20483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55128D1C4C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 04:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 275203022AA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 03:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A32820A4;
	Wed, 14 Jan 2026 03:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwyBBPCZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB013FEE
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362707; cv=none; b=j/IMVI1WQPfY7r2QKtKXnJ7GIeiAynaF3SSF1Jwasyyr6PllfCOlwsJsqxK+34cD3LyoHzfefrUxu35s3O05nsOku9WCnqiXcKRGyNDvN/ozr+H1BptZq0n5GWVO+kvPpU8ZnQHBEIXYiwmmOdrBM6bJcDbGbm6qUyv6E3HVnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362707; c=relaxed/simple;
	bh=TN5pcy2tcUgSim1cC0jgTOIcbpyV3pnrFalvyLNEWlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEeFdyTYbT2NKUyIU2TgZtBggEF5pRekal7IP3jFF0oRkGqmNVjG6AmC4cs/blGqySCY0L10B6FZGtzHONcA5jkdUucpPw+Cbl1IX85aSMhBi9IROT2rBR4KvrJt0JD9rCKpbd/Nf/zwov3zn6Nr/xpo5MJWkM/ECeK6Nag1Hcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwyBBPCZ; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34e949d6416so910586a91.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 19:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768362705; x=1768967505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7PDag0xoAVudL2Nr0obcC5irAM8Wpilyr1+ZYGGRgw=;
        b=TwyBBPCZhTjH72+R8GoTkDtmA8BqseP4zzAdkFuv6ivNJ9JukrlLOeY3RCJf6KxJaO
         BPTBMvxkzdLsRVn+4RWsogyhMMHTbK7vJdIEOf0wnvDZ58tSIu2MfYlkHmAbtbEEnH4Q
         XPuWFe9mKCX0uGPOPbK+mQ/VRcCFTgz3bpebr34K4xnoQ60ff8Dqn8TY8/pMhAh9jU6A
         G+8F3BZztDBFN1lXqXc5EG8BPJF5u2DjFvEaaKeMd2VVb+9mZj4ZLz99MC176UjQ2I1B
         SwKlZM50ir9I54YxyZIk65SgaqkerHVstz6GRQV4hwCKDhMXtj7W7fJubv9kqRc9ra2r
         lvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768362705; x=1768967505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7PDag0xoAVudL2Nr0obcC5irAM8Wpilyr1+ZYGGRgw=;
        b=JdVUGLDLdgg2iKLrUMjECqGXTmedTUvNg/AAxcKYRKP5FQ7C12pZNYtqYq+mBBIHHQ
         VkA9cyTr9JhzVkZGNIbTxI80h79SlRfaMIHqPdcjnn1DVcbEnzeJg6BBOrVCCcyXwlmX
         v/zKn0txFfAajs1/myi3VmoaLBEipk/3JO7tXCrJM+8wd16mAAnpYSG6papFWJJoE8kL
         dPoUMP3MZEdG749/fRNzGV/jBq2N1Ud6fCxXJ291UHELdNnENPNY1BnB8R2kn4Idw1+G
         AJr4m2T2P4599CzRLnDJiSAtXiFN+prbYqvvzLoW5p2VUk0ZIuuA2eMweA48yMuCOKVJ
         WIkQ==
X-Gm-Message-State: AOJu0YzCl5CJCg5r6f7vjLZefFPaREUQHuVRq7EMDLwLDRxzxnDFg0a8
	jszoucP5Ol2D4ld/P6QZI+Xa+7wxu1lyxxa2hAbXu+hUqgVrfnR9aFk7O8hxBkhedXwB0w==
X-Gm-Gg: AY/fxX5wXhz/c8fD2tqIMxnoIaPVJ2lYGT6/lFA8Ws1l/vxAiwVPNa9PDV/+B+YL8oJ
	qufB8e6u1FKm9PG90xCiismlad+qY4vdHJzY3MzSYLhQZf2Hu2krpNQU+HQs4o+qqAbefUMzAVm
	JKbyAZwIab6pN8qCFbjuZd4UaHtZNSyLQs+tziBgTnHoYifJIWNO8nkhenNPtoOEtDNMMGKBNb5
	fWE8+pcUKXAHGW7dXzqSTls9C+ZN9OR9mt9ok6kETMwYDjDCWQ5p/J63cr/wgwZUN1SkB398quB
	baFMcTeY3Lxn5jmPu3vFScpo+NxH6bHGVm9oXmJsc0m8XsiF4Af5jdkBjqhdkgF7XSNZdQCCsZ0
	xNKwGsJ6PfkbYhAxN1FhIeTC9Wem+L7Ln5tybVqG7uNPytMulT1u5CDjWAhWY9bwn9ioJNdVhx8
	2JVacItTdfb5bcW3zz82r3
X-Received: by 2002:a17:90b:37cc:b0:341:8bda:f04b with SMTP id 98e67ed59e1d1-351092d8e9cmr891441a91.7.1768362705300;
        Tue, 13 Jan 2026 19:51:45 -0800 (PST)
Received: from SaltyKitkat ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109e7ee68sm525647a91.17.2026.01.13.19.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 19:51:45 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v4 2/2] btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()
Date: Wed, 14 Jan 2026 11:47:03 +0800
Message-ID: <20260114035126.20095-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114035126.20095-1-sunk67188@gmail.com>
References: <20260114035126.20095-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the filesystem state validation from btrfs_reclaim_bgs_work() into
btrfs_should_reclaim() to centralize the reclaim eligibility logic.
Since it is the only caller of btrfs_should_reclaim(), there's no
functional change.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 79d86b233dda..1594d58304b9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1804,6 +1804,12 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
 
 static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
+	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		return false;
+
+	if (btrfs_fs_closing(fs_info))
+		return false;
+
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_zoned_should_reclaim(fs_info);
 	return true;
@@ -1838,12 +1844,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_space_info *space_info;
 	LIST_HEAD(retry_list);
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
-		return;
-
-	if (btrfs_fs_closing(fs_info))
-		return;
-
 	if (!btrfs_should_reclaim(fs_info))
 		return;
 
-- 
2.52.0


