Return-Path: <linux-btrfs+bounces-8680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF599961E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 10:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4404C28B22C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDBF188010;
	Wed,  9 Oct 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cftHmGrL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1A17C22B;
	Wed,  9 Oct 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461349; cv=none; b=OFA4wBNQo2ZWvEyJzTRKCszAQKxKygA0qvH2lYLfcIMxDhCIwMT3t3nvAo/W3XdF2itTzrusdbkWZ+bdWetz1qHuu4mucqPJXG7jQ70l8wUsSWig38DJ+A+6YL4SsHYrVqx1+6tsdUC7PYKRJ1czHn5F2rX5gwKVdpR/gWciey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461349; c=relaxed/simple;
	bh=JfIehgtjQ/3cHAs4Kql6eDBeVHKqU2Dj7SBpfPwTiUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+ocQ4bfzTXJa9fCcY0kAu8nQ60sHZuGCXrm+SyxU8m7wZBYYwmKbqvjw/rM/ydUkhUJmEjfRRfK6ecvLa57YChi1tlZaq4XhjbUigfWaKHrbr0kV57WuxG+3krEipkHwP5ngmogRYTqZr40pqXg9UwgLz31NpflrMO/80+4nSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cftHmGrL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso66199815e9.2;
        Wed, 09 Oct 2024 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728461346; x=1729066146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4StYDE/mLk4guuVT3VcCXOSWw8o4duh+319HH+EHD8=;
        b=cftHmGrLpzk3Gg6FVqPHluQSqNNMQSJcI2WEui2Zd2sV782OwCa9ARysC8WTs91cJd
         05ItIb8cQuUMHJDOQ4yhBg+kvTkXoXy2T6eD7t0lgNZbu8wwJcU6tHKr6dhbhzFksn/V
         bflXlnyR8Itv1GSZsTZfkUVFSz76N3PZ63VwbqmVoI5qZ6XSz/iJD3hEhW7ai0Yl11o2
         p0fxS0hqLgmUxk6JfznWzAO0JrrHGn03vPIVgJdE4Rd968rT/oc399IMFuC21s/4Lp6w
         1hB9LZSh2cFwBWrBVrLkOxzNFcJflbzQzfDrbyn8rbEmQJ7fFdvthkLSJEjtnAq/fNlM
         Ykyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728461346; x=1729066146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4StYDE/mLk4guuVT3VcCXOSWw8o4duh+319HH+EHD8=;
        b=B6hIqcMzeOEGv0GHBmrXk4e2nQw+rn8pI34/twQc6cB3icBgKhxeolYc7kH/rD8IAJ
         n6XpRBPCsiB+ndnQgg97/5XJo7p8Zji2Gw42EByKG3GnIcGCu4F0xYgdlcwGRnOmsyUR
         IQTjAPfH1R4lRAUWE2ZVgs7aRUdkMQsjF0tgobg/FU+rKhhwcF8u9baqVFWsqfFdtRZ3
         bmo4fBNGhf9lQprrS2mHcIPmJuf1NBekR6t+a9bve9PXVG549DasvVvRb0p3a1veGpDk
         gHkxNrfOYC64Se1R+etlN12AjW35quwDcsFKdPBbrVJWxE4WydumpZS4J8E7MsYErRIL
         2TSw==
X-Forwarded-Encrypted: i=1; AJvYcCUUknkrPs/6fQHQ1bNyNqVxuJvHXIbmXtb8yWyMFo+TsUmhti3dZGKpBVOZDYjH0O2uCXQ4CBzBZSJ63Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1OcqN82nJdS+0ATEEWw61IhbzpQwLjiwglmzPzeRixuowasY
	RUFk7BDpRjnUkVz8h4VekpHVxHzhgYRy78MWSfazxH5iWlgi0z7j
X-Google-Smtp-Source: AGHT+IEu9ciwUYqQdluCHvHz4e4VtxoCNipe/cWBWWJHYKV0bGeX9IUegN2O+tlAJNTC4Lfi+fhBMA==
X-Received: by 2002:a05:600c:3593:b0:42f:5ca3:d784 with SMTP id 5b1f17b1804b1-430ccf20504mr12905305e9.14.1728461346092;
        Wed, 09 Oct 2024 01:09:06 -0700 (PDT)
Received: from localhost ([84.79.205.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf4b1a0sm12054835e9.14.2024.10.09.01.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:09:05 -0700 (PDT)
From: Roi Martin <jroi.martin@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH] btrfs: fix uninitialized pointer free on add_inode_ref
Date: Wed,  9 Oct 2024 10:08:33 +0200
Message-ID: <20241009080833.1355894-1-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "add_inode_ref" function does not initializes the "name" struct
when it is declared.  If any of the following calls to
"read_one_inode" returns NULL,

	dir = read_one_inode(root, parent_objectid);
	if (!dir) {
		ret = -ENOENT;
		goto out;
	}

	inode = read_one_inode(root, inode_objectid);
	if (!inode) {
		ret = -EIO;
		goto out;
	}

then "name.name" would be freed on "out" before being initialized.

out:
	...
	kfree(name.name);

This issue was reported by Coverity with CID 1526744.

Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e2ed2a791f8f..35c452bab1ca 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1374,7 +1374,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	struct inode *inode = NULL;
 	unsigned long ref_ptr;
 	unsigned long ref_end;
-	struct fscrypt_str name;
+	struct fscrypt_str name = { 0 };
 	int ret;
 	int log_ref_ver = 0;
 	u64 parent_objectid;

base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
-- 
2.46.0


