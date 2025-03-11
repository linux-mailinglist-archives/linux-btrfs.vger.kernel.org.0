Return-Path: <linux-btrfs+bounces-12180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4231A5BA95
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 09:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABD2165C33
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4701F12F2;
	Tue, 11 Mar 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvJVA+Ej"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785CF1E32DB
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680829; cv=none; b=SyQtqnT7Gm6BrYHN8KElhFGkeDewkOlnhmOa/Id4IarHuaD6qJjzNii/n/YwEYNJwLos94DwUfTVXEEwb5q92MiSCmP/3+KQZHJ9Khaj1Nm20xMJHnMeehyHcOL7XpWUB4QCZZTmR5WL2Hf+vyKB50RePxizDOhbdFcZLFfuEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680829; c=relaxed/simple;
	bh=cHC+BguhzMGWYnga3bnKS8YCrhT9Z7to7R4FqFIK+ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRyhdTXQyG35sszAEJmbvrtrCgBtIO5N4nMpuVOV8PifPvcmlv5B8szL2DGN+Qiy0GkupZjfKMLEUzgkJekFgH5OjUvQcUGvtMvA6U1JC0q4SWWNl4RvP5tToQnuXd+J4EDMokNJcQMb0ZW2lMJdJfyw1CvKV+Wxb/mgt8p5QQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvJVA+Ej; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-21f8f3bd828so8939195ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741680827; x=1742285627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DYXgPFTGeFHRK2gpJRR2tyVYVqDrLbyU27Ojr815Bk=;
        b=kvJVA+Ej3F98fK5xPkJqf7l/LIsZXRRTf8J8t6e8yLtpJeRehPIrW1jcLqI8RatqiO
         2JMLTxV5CC3BDtz5gqSHIjQTA4wudbcoBQx5ilGetLJ4U23WnFh08m5QRdl8INEJuTsE
         pXhibPkSZzID3Z5eSt9UPs66tlsvN3FHBMRxZsV9GG2vLuL5fk938q5SPF3VvKqQf9bk
         UCTQDfxbdaxv38JKojdLmlnO4sq5y3aOOmM/+a1ekU35mEkh5IJqid4fpbrLPlt47LoW
         UhrkSGxTyqCdninpX+YWwn8W29ezCa7gZu8O9Iq6Kr0HI794k/eDbShCpTqXYI0LRJLr
         32HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680827; x=1742285627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DYXgPFTGeFHRK2gpJRR2tyVYVqDrLbyU27Ojr815Bk=;
        b=DA3XNa0sTWdaR/+iZMWOfOuSYnf2dCcacd4k3ToYsVRM46Ydnsy+u397/XIX3oHnZN
         WRdLll+6lBm7hi6Q8YTGWygWm/70h9QhHll2ax7Ateoqjzxdx1n24Pt8bbB6PagvzLtz
         tIwQVU7we3RK6WkTyswPgEGKs9ZcHEdhgoge1GpKtyX01QOZRArvmtsG1a9/qnE1uhnf
         C6U2sSc3ByJyhvxzMoFaCZjp3bjsr9tCdmBGNDR50VCzvB5y6BE1DYzS9xhALxxn2Lq4
         cCVEI+iv9dWbsLsvjUwJzw/CldR+D5fDJl6A3ACgSe15gr8OGUEKHWEj2oHAhwuTpEfw
         nJOQ==
X-Gm-Message-State: AOJu0Ywhpb2HY3qd7xSs0in+HMIqFbGTut7tvUMrStSz9vAN0Atpn6Ze
	+9fI5zsweHECO3WFvrWt/m3URROdR8tJkcq6S8FmG3oHCwh9SK8eyGCMP+KLQxYl1Q==
X-Gm-Gg: ASbGncukRjs7RnuvPHgCPqtIRIX7GjNhK2DpwzdcnZyT+J5kkTmWHGtkHQM9H3/I8/u
	2SlcgZTt/Fnaz9Al9NM6xQ+j+53tH6UtrcKxdRj4aprM/OxLHhFAwDcM+i3WNhQMU07tuxhpXVV
	fBhARKd6kzGq9rUro9IEPRXl0diqszskeiz5Hb+HCFyyuAJj/gqq40ZtnkLSM9TQaGiNm3WmMjG
	tsWwuH8Cf2I+yye7l0ch7KtvRapPH4EoI5fKn7v5TT/ayKHgLFSQVKiiX2XHXCeL5c3esjjrVMS
	qszLZN1+vL/kXzGQUY+6J0gTePQLYKYuMnlZNQboDpbKj98=
X-Google-Smtp-Source: AGHT+IHGf2WZv2sT6HR3hS3lBxcyTjpT7kYkgvUCXPH2S5JRHarayfR4KcIEdJPxrWNDyI1pwEpUPA==
X-Received: by 2002:a17:902:d48d:b0:220:e98e:4f17 with SMTP id d9443c01a7336-22541ea9638mr69207655ad.2.1741680827418;
        Tue, 11 Mar 2025 01:13:47 -0700 (PDT)
Received: from SaltyKitkat.. ([198.176.54.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5cdbsm91203635ad.230.2025.03.11.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:13:47 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 1/3] btrfs: simplify the return value handling in search_ioctl()
Date: Tue, 11 Mar 2025 16:13:12 +0800
Message-ID: <20250311081317.13860-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311081317.13860-1-sunk67188@gmail.com>
References: <20250311081317.13860-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Move the assignment of ret = -EFAULT to within the error condition
   check in fault_in_subpage_writeable(). The previous placement outside
   the condition could lead to the error value being overwritten by
   subsequent assignments, cause unnecessary assignments.

2. Simplify loop exit logic by removing redundant `goto`.
   The original code used `goto err` to bypass post-loop processing after
   handling errors from `btrfs_search_forward()`. However, the loop's
   termination naturally falls through to the post-loop section, which
   already handles `ret` values. Replacing `goto err` with `break`
   eliminates redundant control flow, consolidates error handling, and
   makes the loop's exit conditions explicit.

The changes ensure proper error propagation and make the loop's exit
conditions clearer while maintaining functional equivalence.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..bef158a1260b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1642,21 +1642,20 @@ static noinline int search_ioctl(struct inode *inode,
 	key.offset = sk->min_offset;
 
 	while (1) {
-		ret = -EFAULT;
 		/*
 		 * Ensure that the whole user buffer is faulted in at sub-page
 		 * granularity, otherwise the loop may live-lock.
 		 */
 		if (fault_in_subpage_writeable(ubuf + sk_offset,
-					       *buf_size - sk_offset))
+					       *buf_size - sk_offset)) {
+			ret = -EFAULT;
 			break;
+		}
 
 		ret = btrfs_search_forward(root, &key, path, sk->min_transid);
-		if (ret != 0) {
-			if (ret > 0)
-				ret = 0;
-			goto err;
-		}
+		if (ret)
+			break;
+
 		ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
 				 &sk_offset, &num_found);
 		btrfs_release_path(path);
@@ -1666,7 +1665,7 @@ static noinline int search_ioctl(struct inode *inode,
 	}
 	if (ret > 0)
 		ret = 0;
-err:
+
 	sk->nr_items = num_found;
 	btrfs_put_root(root);
 	btrfs_free_path(path);
-- 
2.48.1


