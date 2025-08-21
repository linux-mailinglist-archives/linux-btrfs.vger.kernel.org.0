Return-Path: <linux-btrfs+bounces-16216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DD7B30654
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2300AE5333
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAFA38C5F4;
	Thu, 21 Aug 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1jhjCkcN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73D3128DA
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807640; cv=none; b=Z2q5OdV596nUVsaZ/qhwwg6myKz4AonEUH7ze1plad0bNXIwnXGmnJYdHUnG3gudMJAiSOfPQXnD/KdWQgYm+wKOlbV+5W0lx4N1YFaBgU541aGAe1TKhYEknGrOZX6k87vnFegIHXRu+ugAklljoI9hcV07Jhb3VxUWj7jyvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807640; c=relaxed/simple;
	bh=9m81VleAoJYIsplclL8wgSUlUDqD+fV0ieyF3eIa3Io=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8Tfq7apdYeNZjleVrxRs40LkDTexM5v4JxLgxSiZirTruAPlx0F8FyhOY0cE/NyJ+CDagxqCtIRiV8n0zxZgK4WqKrXmDJHflAem7KxjWCa54VwyYPaVq1/khITZZAq6xmS3+NLRq0iG5Q9ilb0BW0BRZylmmI22upsb9jNyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1jhjCkcN; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603a269cso11772307b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807638; x=1756412438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBxRTWup/TVL/uRRt8pc1fJ6+8UUSSl4M2C9tH87x7c=;
        b=1jhjCkcNyZd+lXH3WLOJrBYw3vZP47SLSevdEHGLYQjIdFGV4Qi0qRI9Y/WYLD11oa
         JgZxX/mY3kv4EYpk60j0RVgQOe4zJqcf0rfRGtnszDuN2RZhWFqetPwDdarrBazTSd7U
         UeN8/gxDB1HrhqWdjvhEB6Ly3WtdYL6fyUAWnFHbtGsfrsrrrTQhEX6VIHGhXwPfHeKc
         +zFRjLDkosNJHMCS2RYxZRITFGh+ytIKvY1g/XNwormPv3cdRExzP1Nq1nth8afLeQlN
         VmbkbaC/JqitXA63ANO2wMvXKMjuoYMfI07iJ7b5JP5OUSpBm4lTkpN+O5QK28JFhlM7
         ZgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807638; x=1756412438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBxRTWup/TVL/uRRt8pc1fJ6+8UUSSl4M2C9tH87x7c=;
        b=JKyb0igQC4pL/msDKlQ8YRcth5YKQmAaBn7NFe4WABiUEDRTd2/ATtNJDjx9qsT5uC
         /FnJollRgdoTfd6A3+0ndkKGqHkwJYE8awORJr5Y3/dvBnCk39MRBP+Jcqs3fP8LcBcm
         DruDXSWdhBhmixPY8VLDK7sAIVd1G7eFXNsP8QxnA9a+hFBlDZrD9MoMRDt6EJW3hZLt
         1HQj/FzXnd6GnHJIRmWkD1+zqNlnpb0J8EucoKlO4OF4fmbMxWyy0dx05zz7Y/+zVW5L
         gsFHEYv9L+v3Z73gfrJfT9epUO9rCFiBZtnppN+7dxUzeFjzEmQ8ITe8DMgwNrzsMmUt
         Vjtg==
X-Forwarded-Encrypted: i=1; AJvYcCX72Ck6fiGeRKeSglS8QlWU8DvhGzWFnz5io+Cbm/DX1YldjvAwPyqAUTjRdMBLCGujywqilmKIb5FBUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3VU+wiCNtJAUi27hEJb0iqAT5gJjTPma3Jdeh1Q029pQxEig
	5PWj7PjEm/hjvmWUOG0uGRqzT0aJXTzTXGZa2qGa8odYFO4gVXTWVQIcAFkGS2CUPLM=
X-Gm-Gg: ASbGncvDHjv6etV6tqsr1HjV+2e/GOmVz3C0xo4Unj0Gh1CwF3rNrjn0iiK+y93ylwL
	5d/Nm2Wj4La0mLfLX/1pIxqF9PLjjul5afrN6rq5I3JN9bxrgaSzGEaZGrns8VnD8C+SUzgHc6d
	mcPbcBD7ytncjR3Ye/z4mPIGW+5jxXXTHbVgv8YuW/D7R61HAKIu8BgNj6G3sivCe83Mz8jFkCA
	6JY4QA/w+7SbQpMqsit/GpMxXcFReqhSQ9d44oHMoHz3wsdnxjoZ8JrPtVPznhUw8NCX5ezQZgH
	UT5YPNIxbAhj5wVHChKHMjwgmsHZmJLceV5N9pmT5w2M/brxiAb9fzI154XVO4IABqcQ7NrqD+p
	XDm3/+Bh4A6vS0fBqo6YzDDsncbwUhRhWZW103kVXmLamRnpI1ZVWzbLfspI=
X-Google-Smtp-Source: AGHT+IFkaz2mWgCXtAS+KU0cGwdZosmAbjYXZp1O5qAihGpaj2tJsyf3eBiuyNcl5KJcSQ+mnbVRNA==
X-Received: by 2002:a05:690c:6e93:b0:71c:1de5:5da8 with SMTP id 00721157ae682-71fdc40d339mr6942157b3.36.1755807637738;
        Thu, 21 Aug 2025 13:20:37 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fc39b7081sm10222007b3.48.2025.08.21.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 15/50] fs: delete the inode from the LRU list on lookup
Date: Thu, 21 Aug 2025 16:18:26 -0400
Message-ID: <d595f459d9574e980628eb43f617cbf4fd1a9137.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we move to holding a full reference on the inode when it is on an
LRU list we need to have a mechanism to re-run the LRU add logic. The
use case for this is btrfs's snapshot delete, we will lookup all the
inodes and try to drop them, but if they're on the LRU we will not call
->drop_inode() because their refcount will be elevated, so we won't know
that we need to drop the inode.

Fix this by simply removing the inode from it's respective LRU list when
we grab a reference to it in a way that we have active users.  This will
ensure that the logic to add the inode to the LRU or drop the inode will
be run on the final iput from the user.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index adcba0a4d776..72981b890ec6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1146,6 +1146,7 @@ static struct inode *find_inode(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1187,6 +1188,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1653,6 +1655,7 @@ struct inode *igrab(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 	} else {
 		spin_unlock(&inode->i_lock);
-- 
2.49.0


