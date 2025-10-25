Return-Path: <linux-btrfs+bounces-18333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB1C08FFF
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 14:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94171B26BDC
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAB2ED165;
	Sat, 25 Oct 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L98mhKpa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D01E51EB
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761393911; cv=none; b=GdRgkTydO90w5D9qe96DPjm+9Mks0R6gBGVWGEvZjjtybXlhwLws5TbOnPrXoT1IjK9tUk8ArVz1O1OyzWr7tpd+JUMRHWzADra3CJ8dARn62DYFW5qtW4R41ra+8BDKxp9WoIKm4YhwKQBh3wF75O7lNGid4A9akXTEuuYgSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761393911; c=relaxed/simple;
	bh=RqyLr/KFP6kVHxuT8uv8+KaJmrBYAr/DIIDr7cYq7eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqTeuvNwdzaEyW6WheD0YKphADr+nQl12kRWMKG2v6vk2YnamsQyUmsWC8P4JTmnDvN2n+S1iUEFBaZWq1jlEQ0aLvdPwi9zTgxbZg+rzGgL3gHliAUNyyXz8XcyoVhjBKaTFvXxhnk52KRbQN/zW+8LZsMyXRl3uHc9d8blhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L98mhKpa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so44275245ad.2
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761393908; x=1761998708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPoytxf9KSpw9USlqlPwbyYT9B/FM2gOwtvnsmod8wc=;
        b=L98mhKpaxkV56QwTM46XpSk7lQIJ/pBhQfQoJ5V1s6FhOdRITNR8mcbWamOV4BQbF0
         SVn+NQhkrg/LdPTKmHeZ16L54g5x35qgPvRoTfHccJwzJx/v8kDRYp9hCTZzjNFsFkVq
         nvuwiOEVu/uT9lsArBx+eI7iJpc7TsXVG10YpGxjAbIR3B2en4AAZp70nTTOLciaXqhS
         ELPJgrDgkqgOb53XgQmrqv3APdSI0OGEebcfBqfAH+rpmGC1+P23eSqGn3d3Ih4DueS+
         FWBUnEvB7JekvuMgb7FIP96Du8Nr7YBXAbo5gdmfqyIpjnArxaCo9gia0/iWDIqU9cSa
         qNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761393908; x=1761998708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPoytxf9KSpw9USlqlPwbyYT9B/FM2gOwtvnsmod8wc=;
        b=TRLqahQTQJm0eflucyFAdRZ1vBHOM9ilWKRvBe8NFYtOK5qTPf5WQqxqeYiy7+hS1o
         mE34pBf5ndVDzgeaC2aKT060HFFUlR7eF4yaoO8zn+nNoHS2hX4lDv5LRc2J9lTyN+C6
         Zh5VYWPm0gv1Zv274r803bXR9/v/J6mKQ/jZdZuV/GHVT6X7dihBYtrlSTIGdlWHfwxG
         kjfGHlwecpRiDuX6k/7wWupjJ036SbCRGGuWPkA2yOwWsxAPBFjbE2V2i0aNRdtQOx9d
         f0FsGnFnmSl+0ne5aLyrietg1JY94zrmEHuIQ/lBG2FXpIS9gzVeubtoVkXGzrfGnoDb
         n5xQ==
X-Gm-Message-State: AOJu0Yx+BBA1qBoE2L+7gZxH6NbbB8Eq95uMQ2o09lXGx5QqxT9D2swy
	aFtx/f/crA2tbCwm7MCKJzJDFQp8zwAZjYQuRsVeRcKBdx0bOmRSNIe4IP4j9c2s
X-Gm-Gg: ASbGnctnStmZEs9HTWDPPjswcWvUGJ2hDvzVOGGq1t60e+/XfIC0liN+I3ULi+QkJ2F
	llbLW7LEUQsMR2P+Rja1kOZVnfGTNPQiITOB0i0fVrwCarcaDHVyVV+v+oTARb2zLjlctY7k9dz
	3E2rnhLN1IQTZgbI9Eku7gCdO3cDpVld99U6MyNtzK9aMoSrqizftuEPMfVYayYmKNWI8dZdNPr
	f1CkyfE2NFBG5Ll83iu9O9TJ2U8YbUyC14/YklpkvFGQAAHVy48yF+fp5RL4nzGiwHqitfJ94EW
	5FOBUoqSEi2KT568oI+PchI3tmmz/j/CKOTZ/rMo8Fu7MiszTUYMtwKvPKvWbopLyRe7IORtkTt
	KNyDSn6HXj40v+uyexwCTt+Pu+pYKxsE8GMeer3ytPJGl3CrzO2bVUOHkn5cZF4Dh0OZAXmhVzj
	GMktP25w0yUA==
X-Google-Smtp-Source: AGHT+IENHghZmAfoOLVQx3IvoJEGkCtm9ehcXpV3CexqECxrjj1hj7ylp/61RR7XbH9zkL6BI8FUWg==
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr374033525ad.46.1761393908432;
        Sat, 25 Oct 2025 05:05:08 -0700 (PDT)
Received: from Shardul.. ([223.185.39.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d099b6sm21480655ad.33.2025.10.25.05.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:05:07 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	shardulsb08@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 fs/btrfs v2] btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
Date: Sat, 25 Oct 2025 17:35:00 +0530
Message-Id: <20251025120500.3092125-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025092951.2866847-1-shardulsb08@gmail.com>
References: <20251025092951.2866847-1-shardulsb08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrfs_add_qgroup_relation() is called with invalid qgroup levels
(src >= dst), the function returns -EINVAL directly without freeing the
preallocated qgroup_list structure passed by the caller. This causes a
memory leak because the caller unconditionally sets the pointer to NULL
after the call, preventing any cleanup.

The issue occurs because the level validation check happens before the
mutex is acquired and before any error handling path that would free
the prealloc pointer. On this early return, the cleanup code at the
'out' label (which includes kfree(prealloc)) is never reached.

In btrfs_ioctl_qgroup_assign(), the code pattern is:

    prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
    ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
    prealloc = NULL;  // Always set to NULL regardless of return value
    ...
    kfree(prealloc);  // This becomes kfree(NULL), does nothing

When the level check fails, 'prealloc' is never freed by either the
callee or the caller, resulting in a 64-byte memory leak per failed
operation. This can be triggered repeatedly by an unprivileged user
with access to a writable btrfs mount, potentially exhausting kernel
memory.

Fix this by freeing prealloc before the early return, ensuring prealloc
is always freed on all error paths.

Fixes: 8465ecec9611 ("btrfs: Check qgroup level in kernel qgroup assign.")
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---

v2:
 - Free prealloc directly before returning -EINVAL (no mutex held),
   per review from Qu Wenruo.
 - Drop goto-based cleanup.

 fs/btrfs/qgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1175b8192cd7..31ad8580322a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
 	ASSERT(prealloc);
 
 	/* Check the level of src and dst first */
-	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
+	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
+		kfree(prealloc);
 		return -EINVAL;
+	}
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-- 
2.34.1


