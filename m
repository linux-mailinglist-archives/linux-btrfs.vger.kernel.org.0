Return-Path: <linux-btrfs+bounces-18337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73AEC09F77
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 22:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700D93BCE55
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 20:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE282DC32B;
	Sat, 25 Oct 2025 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kArtkmSe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385C23875D
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761422430; cv=none; b=OLRy1d0nZIVENSCvQXB3jqLCXMDR0+hJ6tGMi9pAmFCxPf6UgAsXDqEvpifyr6eoMEp5kMrdVt8CxMkEZ9YG0YI9TZQMP18XV956uVygHBCL6yZf97r3ehRkYmbMmtPXpjRXCfx7MSuTu7MdBwKpidaAWxVoQJBJDN011gb3UL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761422430; c=relaxed/simple;
	bh=gTK2JfluqP2TVQ+J2BjTjg97nxpnL8hWo8TWogHz7iM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjmZ5uzEVkwE0Cs5JlhfkXYf+PJKDIusSbUQtl5TnpNIfcEFCXDYz64gT+0gvfqKCRiPgLim3Bj6UnqwA/esxK31ld3wowbsxX+bEucOC2BwdZIvM1DeE4S1yoYA7J6nqTDya6vGJTyiVePPxTYhQpIGNHPihUgitZNzyq2Ybsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kArtkmSe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26e68904f0eso35213685ad.0
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761422428; x=1762027228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaYeMKwI1BF49vrEVOohJsMVytqLhSnbaX71rZear/E=;
        b=kArtkmSeAH8nFkbRaxl1aJ8fFoybLL3W26wGQKwSPzXHJhHxofOszcuyEfTnUvsUIO
         of/W33ngea63PmPoNtSjqS5CoqLCorhmlRI+G8ahALjVC1+ha7Muhu1/utZ2He4o/cuE
         akXuXJ0AY8r/V/qvYoU2MwqsSWPaPLTB/p9sUB5AzGJDckvukxzsKswqz8ZwwSVKSpQB
         RaLN+gtPTIJdbB1KyAlQ29+q7OfQHu0tbDu/afquzH4gOFNnXEE1/8TZRpVyk3YISdMU
         BiN0O5NsERM9LR1/LZ0dArAt/BU9i/F3lKYQjhIGPiKDb1jAeSrPdmzOTcLJ/RhVRwfw
         plJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761422428; x=1762027228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaYeMKwI1BF49vrEVOohJsMVytqLhSnbaX71rZear/E=;
        b=FYSnm1qE2UKhTEb9qQSB6OBG+MVFJ5jNUy6vhrJGa3D3SlXc3DMMpsTXVWW3CNOsoC
         UremjOwEKI3H6FIsIcpCeGOmiucciwt66s7wGCDuqGS0EiByNSLFaCmruQRIaBzuwPpM
         wAmI3zVghd6otQmkv09PCn78dkYrLGKiZzGXJuOsLJGh7D1Bi1Ije0j1RWKXXfPA1a+q
         0zXsQq3rbJvYwHIcgUasdrUcEFpbW2FmDAeCnP2Dd6BZpDvPxzMaub3E6U4k4Ps0fB3w
         afu/1r+EjkuVETQZWV8paBZBn3Tc9doY0fLboe570MrdtjM5KtnIczC/o5VEJyJAqoEi
         yTZw==
X-Gm-Message-State: AOJu0YwtAMJTCFvVlKoqA05QVx9xMagBWpwNMiadaoZD1Ti0CqhOHXAf
	zhxaQTklcgCVLVRtibfOOLdguKonkMF5IMY3sTBFhCXefZS4kjMEKKicLUNvjFNv
X-Gm-Gg: ASbGncsYvoI+4P5HcF9scDkfkZxZgXZprORZwth/svUB5oSFDVp9L81DRSkA+BeILDS
	+KuJqqboANvACJV5CdDHXwruvYCBW2vYiQXDSxdt8qq7V60PqzTnwjgxgxledCZmJFhKfTQf3c9
	tRbfMlnFeXdKmMJYOjM12gwqwhOTGFEYl19UTAVbrcz2wVyq0O+xgFicKqx4+lyVISugZgthnn+
	fl3+b9UhWwEJpxioQk/zSAWS0QykDFJQdWKcDtWtJILF4rcvUnKTXSaB3NYQNEyp2r+oyuRxYSb
	0XovvHqE8Kw5HrkCj35gBhdv8EwcYxg3777ODf/qe1bGJGCiGttWjdgrRXgZNgUM33b6lrFCH20
	fLXoLS40JvNRwH7BG6F/dnVEnF8t00kL23IehA+vcJYa8y265MSOsnLNBDWA0umnD5u5F09UiUU
	3uFesi9d58Wg==
X-Google-Smtp-Source: AGHT+IEvmm33i5yQ74Ry6lP4P6rB7QNWNDpbtf1i0gbKVWkTsxAaii5ceRUOfu1A2ad8axHlPDDddQ==
X-Received: by 2002:a17:902:da88:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-290c9cbc119mr409541635ad.22.1761422428005;
        Sat, 25 Oct 2025 13:00:28 -0700 (PDT)
Received: from Shardul.. ([223.185.39.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d273cdsm30677905ad.55.2025.10.25.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 13:00:27 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	shardulsb08@gmail.com,
	wqu@suse.com,
	fdmanana@kernel.org
Subject: [PATCH v3 fs/btrfs v3] btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
Date: Sun, 26 Oct 2025 01:30:21 +0530
Message-Id: <20251025200021.375700-1-shardulsb08@gmail.com>
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

Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding a relation")
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---

v3:
 - Update Fixes: tag to correct commit SHA as suggested by Filipe Manana.
 - No code changes.

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


