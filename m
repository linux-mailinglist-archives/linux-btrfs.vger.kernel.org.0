Return-Path: <linux-btrfs+bounces-13196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E513A953A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 17:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FB3171839
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A71DE8A5;
	Mon, 21 Apr 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBWS+izw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B77FBA2;
	Mon, 21 Apr 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250039; cv=none; b=FfN6WZuR+kXYjFgXO7Al9SZk0WQ16wIQqV9zCGiv7mgXfSAvqssbae8BrP+LGPdYKDFuQvxJly45X6TOeOzDQO0n/s0PqHjKDKV1dVf9azHm0TbD/pIUna5SkFUFuml8x3Xetg3HUIz7gdpxpg5yqLxz7Msrogqoe8Jy03EgkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250039; c=relaxed/simple;
	bh=xl30mBiPsVbrAVoWT2cUaqSN26fCRcEEjeOWSj0raN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IFqRVk/rbxZibxrgQkq4sVMQ7Ka1zvaayWCzFXm5mimyp3f4Q//zxztnA77o3Rng7/PMURmxeMQpiHlaqPN6rF6HRwbWz+LRhneJcyiVnJq8iYvNRlAVfhVqEooB7qf63UxnP/EEVLllC8aO3nWBrw0dq4N32N6v/grDK31e0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBWS+izw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3014678689aso3192377a91.0;
        Mon, 21 Apr 2025 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745250038; x=1745854838; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KF7cWwxdiMwaiMNX3W2BLkCIy6ps1A/eUtO5oTapbF0=;
        b=dBWS+izw32yJRFifrCBC8wFFL8oWkFFdzPmnBQHj3KvT2FqWCfR0DFU2BXE2FvbFNV
         66chZH5uuDVpYo6onmXNPAzWqejJ4wf4Rm4ArzteXX5Ud4Dtn5j9qcaRhQLhd4X8eem7
         eJrWheS4kmTUnsZzqp76GmBFOw9oKm8yXAXsd5h4Gxn8xLQgERsFoK9ARvvUUyQ6H5b+
         InyW3XAh5QLPpONRylPLHpqPodiFbzNj1qchVZf1lJbxY9GB5GxfbGe0Gy+gbVF5q7mT
         koe5dbk7A+iZNql0bV9WeSBH4Lrjkif3fn0430QIQxSIiZHRcfavp7YOkrFQzsFKnool
         3qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745250038; x=1745854838;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF7cWwxdiMwaiMNX3W2BLkCIy6ps1A/eUtO5oTapbF0=;
        b=uJKoSPAmlrYkRuPfRBNT2V4VjuHB66M/uUQBdZ9N+lteMQ/0hQz6F19kOVWeNQA0IG
         91oROGNbo94NwNJwz9+r4G6+1gCH18FxfFIlQ1EwLcrKKdEkWufAxY0WDEiflk/i6/0I
         znNIZKxjJIsNdTBYUQkG+0CragLmI2klBLqBefmr3OsVjtAiveZOJwEi3+uuXFytl+U6
         IYFrlpFg7Wr0SMWFrijvVJaLtzOJMdeojP+qs7slVYy6c0VQLJ+hVkS3y9lmNJbFLgM0
         7mRyFD3csKYFk7oZL45+mfrEufQwm54affCp6eP2FJeqdqfwFastvRy15fJB2ySTzlXa
         ltlw==
X-Forwarded-Encrypted: i=1; AJvYcCVUnFbS1ydQ1zJb939N/Fh+ps4oZ69zMiity37r5H9aMlvtmkFgROmNFiAeQcuspV9jOHIDCggcOmZZxg==@vger.kernel.org, AJvYcCXYCFHs1vt8q4Ds+EXhyHzz99VATyyUlwk+DAtqh6EolMGII/M17MtRbCC5+Ai69qzd0Py4Nqhp04eBMaA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IlYT8joXeKY0FxSDalKRlCqaW+5V1JNDLNW2fbv4OxegLAXd
	M4Uneaatj8VkqxinrIOd4HaQ+5Gxg9WwmJZFmb8V6IJD3BpCJ0Ma
X-Gm-Gg: ASbGncsKcmaBXxwK/r4ste4ZcnbMEWfp4JuH3X4DfpO/od99ac9nWpGg1LYFIoyUlhV
	UXxodzDgB9tIyicXjp8MSGzfUFrtmQHGk/fggjohTZZeIoLEWa6ao35tg/4H2eWfQNJbDQ62su8
	FHMcm9o6I6NxUP5ojHMOdYQ3Ke+u1cb+lVQGgp+JwRI//q+4QhKtJOPWRWGzPBn0f71QkqbUiT9
	y2hIeyqqgy7Yg9BtNICrJG7ng0YJhKEw07rLZ67dO72XL9zTepu2+irHlmqRDmif6oNu3J8y0e7
	s22/doJqzpbHWvOrwji7LqooPkgUC+VFGzK2uO/SKJfPe/BbQbzzgGjLjHOKwA==
X-Google-Smtp-Source: AGHT+IGeKY6ZJRzBHzx2vQBxXorxB7q4Yl+mVZgfPS0Ybp29GVxWSC6HCmp2cmAgJ5WBUIBTzxbOfQ==
X-Received: by 2002:a17:90b:5646:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-3087bcc8a9dmr20283700a91.33.1745250037683;
        Mon, 21 Apr 2025 08:40:37 -0700 (PDT)
Received: from ubuntu.localdomain ([39.86.156.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df25d3fsm6751320a91.27.2025.04.21.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:40:37 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: quwenruo.btrfs@gmx.com
Cc: clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	superman.xpt@gmail.com
Subject: [PATCH v2] btrfs: fix the resource leak issue in btrfs_iget()
Date: Mon, 21 Apr 2025 08:40:29 -0700
Message-Id: <20250421154029.2399-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9e7babf0-310f-40cd-9935-36ef2cebb63f@gmx.com>
References: <9e7babf0-310f-40cd-9935-36ef2cebb63f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

When btrfs_iget() returns an error, it does not use iget_failed() to mark
and release the inode. Now, we add the missing iget_failed() call.

Fixes: 7c855e16ab72 ("btrfs: remove conditional path allocation in btrfs_read_locked_inode()")
Reported-by: Penglei Jiang <superman.xpt@gmail.com>
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
V1 -> V2: Fixed the issue with multiple calls to btrfs_iget()

 fs/btrfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cc67d1a2d611..1cbf92ca748d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5681,8 +5681,10 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 		return inode;
 
 	path = btrfs_alloc_path();
-	if (!path)
+	if (!path) {
+		iget_failed(&inode->vfs_inode);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	ret = btrfs_read_locked_inode(inode, path);
 	btrfs_free_path(path);
-- 
2.17.1


