Return-Path: <linux-btrfs+bounces-18327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A171FC08E77
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B15D3AEED1
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B92E2DFA;
	Sat, 25 Oct 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr/+UCYZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA629B204
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761384607; cv=none; b=OuMhEuR+CKDe67jI83JzCqKLuNaXxkSMjj9JOd9WWGm06BCyoXNaqE0GEFL9zVliWG1vvjTBSLj+fW4m2sVu3g5fOv6ElkwTJssDVuKxEdgbVKjLvP5QLSPB332J6XIrNi/RhhKF2X51+LtbrJted8di6H0f+QjqAq1rV27EVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761384607; c=relaxed/simple;
	bh=xTi9iK0cexilxltVMDnA5hECNlMR2KScYHdB9Pq9vS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dmaCnIILqnFSUvpudCaNLcwKwkEGyj+kWwDxPRd6AwD0TU4bi9grGoZqdqbTlUqbcSid0R0XMOEGcKlcTuSH+VIw+0l3KP80Y4yLdVes13M3pRbPZeKdFSWWN/gcf1/ubOisT2IXBR3W7xkASOXygeJd/nAYP5/hnBKkYxx4di8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr/+UCYZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2698d47e776so24217655ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761384604; x=1761989404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzOdTahmgATvyBKKNNGk+6ocxaYqIIvV/CA7uucejZ8=;
        b=cr/+UCYZyy3VYyfPXq7/nt2s13kD1hIrmn0/yF/0yltigPxqoRkZijzO27hA/nDJVR
         /JPYc3RO4Sap44yuddp13RX/GAz8qZEZgto4Jn4Z4qS4MqwtoJX2E78rqs9rFnbcbUWx
         UBrPugwtL9aGaNf1ofoKsYpuXmUQB6i3EqlTZzP0llMxieNPIx/NdP7BgzjlAh6kcdAy
         Es9qb2xyy8PFmSw3gkD1nEBw5JN+Afao6NcsUq5h8c2yQBmoBEOAn65JZ7XRNqqS6Vfa
         lybOeQeMM4RymKQQ4PIyJ823dpiiuQlWQmIXIA0F68LlvXZ6D+sRw/0mlAZPWHWdjjfW
         DiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761384604; x=1761989404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzOdTahmgATvyBKKNNGk+6ocxaYqIIvV/CA7uucejZ8=;
        b=nwPuVlvtpPGF9F/6KwBmkfz41DX2aRqfjbBpLV2Oinduv8USNC2M/FBYjQJ5lG3idB
         3mYGEwjefGgTkZpH2WJfV8eCic8LJKC0GN/8huPRHqY/Maj4K7F6zTTqDwLG/CDX+0kX
         Z07pkYcsIO01+2xZAIs9PTLpEhxjNi48TH+qBmbUu7JZ3+jfMraQ8PXXUuYN9nabjGka
         c4zxFRjVy7AL2UkPHeZtVjp50psFcA0JzlAzLPLUJgiBIU5Np+AjYLgr7aJYtEkLxbkz
         G5AfCjLw2eBFXt8WdtRJz59WOzicAVzasIs70qanouMBzX5gJVi6wTCt4U8pBNUknzRt
         ZyNQ==
X-Gm-Message-State: AOJu0YzrAcKRQtfF8c2uJav0/hshJX/k8nlhYYbuGrRZIcUKkKyc4VC3
	z5Z2MKPs2TrO1G6fhdgqOolvM3qDYdM4zTX/MszITzc7jHV/YnCkeGraLj/wl+F6
X-Gm-Gg: ASbGnctJuB4d7veSyUf+YLyUk1lB2yhoSsGjDNrI0EBmoq3gSUjjutzbpQ+GXuBQzDn
	+NJNYYZsTdg18ZihpqGGQh7BTJ6NdRgm8DGIEsS28WgnD18Fm8TMYKQ5y626QjVSsYzS0APyME9
	Dk2h7NTRH+Ulm6Uqy01iK0V+VKqSbS785e3bR5KwdUa9i6hMpqxwDfPHtRUKzeZqnbxqGV285kF
	B60EJfyko83Pi5Exm0DyON7OJfEguTb3O7JTTT9HfQW1V7CT04iHhu9MZbk6zozZ73QwuXcjN4A
	w27E8EH1TyvIyYc3PBCkGWgYEKLbtUywDpl/Gt6XlFRptttg3LEO206uT3hC8C83BSzrq1jmDOl
	jAWIeDZVQpHeuVFb8oTPo3/cN/68rckKghg7xtBeSBJ8VeSo1JpJ2AKY+o8QM2mHgfNG3TBPAKs
	Acs0Hx5IrRiQ==
X-Google-Smtp-Source: AGHT+IFzZAqzgx9hI9VWDaOpx4WVbJGiiiiPSP8erCa77EiYj7XPJXg1vLil+vrRBk3WAZVO6rop7g==
X-Received: by 2002:a17:903:249:b0:25c:8005:3efb with SMTP id d9443c01a7336-290cba423a6mr371056925ad.54.1761384604459;
        Sat, 25 Oct 2025 02:30:04 -0700 (PDT)
Received: from Shardul.. ([223.185.39.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40dbfsm17878515ad.72.2025.10.25.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 02:30:03 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	shardulsb08@gmail.com
Subject: [PATCH fs/btrfs] btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
Date: Sat, 25 Oct 2025 14:59:51 +0530
Message-Id: <20251025092951.2866847-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix this by changing the early return to a goto that reaches the
cleanup code, ensuring prealloc is always freed on all error paths.

Reported-by: BRF (btrfs runtime fuzzer)
Fixes: 8465ecec9611 ("btrfs: Check qgroup level in kernel qgroup assign.")
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---
 fs/btrfs/qgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1175b8192cd7..0a25bfdd442f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
 	ASSERT(prealloc);
 
 	/* Check the level of src and dst first */
-	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
-		return -EINVAL;
+	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-- 
2.34.1


