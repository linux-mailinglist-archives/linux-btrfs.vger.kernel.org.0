Return-Path: <linux-btrfs+bounces-20423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14762D15328
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 21:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A203301D5DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F99330D22;
	Mon, 12 Jan 2026 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsI49F7K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A84326D65
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249352; cv=none; b=L0weeEOaJvHE6NJfyRjvewFgKAh1LXh4aPwiK2jmPU7XKR/BEsb+LwrIveH9ignejBDcw1a7QkbhqMWmAkHIqbcv/wPpFwWVrgOSAXgu2kMbhHvIsQ17fauQQU3b7LRTtlAkWtm1hp2syzg/tI/1OYacGLAh2lWXyjnadcSXpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249352; c=relaxed/simple;
	bh=iTyXVmOKTtuuaBrXEffb8U93bQ3tGfex+q/fzHPqD8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cOAWFdMOi2Z9mlIrHJbepaECAwdSZVTmqGMH0VadUxWAi/k1DYhhSHt3pVlr5Gjw//q5JiSKrUP66xl6NJ9XErDJ3I0MBD6ZmQa2L9YwDKdpQ7+0nLRFIEw0pZcEj8rUtRVY2nwWwJB+Qup8S+jJcIkFsCYPlUjPdJ5nHDifr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsI49F7K; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7cdf7529bb2so5000203a34.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249350; x=1768854150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQhHys9dUc4M12K/6mikStA3Vn/WKvogmWYn0AQLqxc=;
        b=ZsI49F7KRQmr5ZgWYRBPXxD2dack01vCpTd4Lh3X4mLnMBB7pg1mDrvVLCZA1kA2fN
         uj0RO/RR4oLUbRamX4y7iixnCMfun/SHl0GjtQE1lj9iC46iIEH9P2Ti24nq1xG430Py
         cK10ppdP2ATBXboaxPS2FMjWtA9Yv51JwJv4VbGkLQgrabaC9whyD0OK0DwU57op34HV
         RHodG4J9wJ4Cy9c+1LeclC2u8+iNraDaWkBOeoYKJa9/SCFy42x924xegaZHdS4xi7jf
         f7K7AGgKNu+z2Kg1SRWJNU9ea007jS08KY+xeKWCNNsuPm99qU8eT+d8vchlRTTL+hsE
         0zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249350; x=1768854150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQhHys9dUc4M12K/6mikStA3Vn/WKvogmWYn0AQLqxc=;
        b=xID46rWJbQ6uKBAETWybQKrN4Nj/O8Do9AWk86q5RgysDzMU/Ct9s1fEqQdz+qZK/Y
         LGDtyjSf5N//KUfdr/5wYS69qwcfyOse679ecmyn9eYR6n6nrexEt27V7+9JfRy3DC1g
         Q4Y4LpgFWomcbwCj7oL3BCA63pTysQCo1/mIrwwUicD3VdknRAH/Ij//7GkEyl2+Cbvi
         WPBGwJNaKuYlBkZx1Diu2g/KngRMd9pTPGpTn3q6DrtedCfYVrlXgvY5q4ejRy50h/6N
         cgfvlh/WDWDl6KRRL0ygI469bZwJ345zSNrkQo7+AAHBfQqLwFSleIdN+uHzsJq4F6VX
         oWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnHBAiCQHbXdIBfOFKgy8GqI1z2gEHBxx/4HPYBVhT0af8mEXjewY3KDjmjj1uls2P0zrgq1fp8USHNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83rylvypYxuYXlNbSy7k07gvKZgFbw31LBNO2zOsF+QNw9GLp
	COo3A3aSrIDHcceOJXtrBesaKVN8NLYwVhZPxJQJ0lOiqxuspTlUCvKO
X-Gm-Gg: AY/fxX6FbYm/l62zZb14JKJmyR0vbusFCJDIUdbCg+AgeM2OMxxm7dig7gmM+0fVOkc
	2EF9f7hkqolV/nn2y7uqt8U1HvMBdW05eUrptkNBLrIwSkE7q4DMuzyZNU9JjwEQLpJwvW7EQf/
	6yFCMFib4Xhmc4IgVTIQUyYHZIpZIEgF+S+Ib5msTkHLzrFhMDegS6ygEGzg9zL3jWwhSgBYaPY
	Hjhijb4QT4C9ImcusjSLSTwo2kqRIU+Gto0Ps/tZ0TjdM5zuJpay87m6Np1KDVkYAmK2hhp5KCV
	avJ159WzbfDI+EQE+CvXZgQRnlh4LMYuf4oEcuL0D4ILjF0RVQSl7txFlAQEZi8G+Z85IIgWaJY
	oGKDKj7sQk1rsOpXKMcLJ6bk7+3YUNgCZFQ2pijUgAU2VUg6i3OAAUVJ9UUdSmYMlwAlmH2xUsL
	nSBPj3v/TKHcZOoUYA+PDTGqcLIE5jLMRn
X-Google-Smtp-Source: AGHT+IEm2dv7tfrD2jmFgs5OapJQ/RY2SS/945e1BkQco4M2LTyMhD/j6zxrTMMNwp8sgXmupU5y+Q==
X-Received: by 2002:a05:6830:6ab9:b0:7c7:6752:2d8 with SMTP id 46e09a7af769-7ce50bb5c2emr11052191a34.32.1768249349917;
        Mon, 12 Jan 2026 12:22:29 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4762eefbsm15289256a34.0.2026.01.12.12.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:22:29 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: boris@bur.io
Cc: clm@fb.com,
	dsterba@suse.com,
	jiashengjiangcool@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: zoned: remove redundant space_info lock and variable in do_allocation_zoned
Date: Mon, 12 Jan 2026 20:22:27 +0000
Message-Id: <20260112202227.37626-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260112185637.GB450687@zen.localdomain>
References: <20260112185637.GB450687@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_allocation_zoned(), the code acquires space_info->lock before
block_group->lock. However, the critical section does not access or
modify any members of the space_info structure. Thus, the lock is
redundant as it provides no necessary synchronization here.

This change simplifies the locking logic and aligns the function with
other zoned paths, such as __btrfs_add_free_space_zoned(), which only
rely on block_group->lock. Since the 'space_info' local variable is
no longer used after removing the lock calls, it is also removed.

Removing this unnecessary lock reduces contention on the global
space_info lock, improving concurrency in the zoned allocation path.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Removed the description about avoiding deadlocks.
---
 fs/btrfs/extent-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4cae34620d1..43d78056c274 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3839,7 +3839,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			       struct btrfs_block_group **bg_ret)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 start = block_group->start;
 	u64 num_bytes = ffe_ctl->num_bytes;
@@ -3900,7 +3899,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		 */
 	}
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
 	spin_lock(&fs_info->relocation_bg_lock);
@@ -4002,7 +4000,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.25.1


