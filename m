Return-Path: <linux-btrfs+bounces-20512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3ED1F865
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 15:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438F23028F7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E62E9749;
	Wed, 14 Jan 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqQffqvC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5F19CC28
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401895; cv=none; b=uavRmSckUMPoWNzGmaKClc3qxDvA53tNL82/36sbYr0QDv34bEMJD5bciZaH5tSonhztSfYSMNgzk7QLIlRjDqAPiFAF+ilEC72rZlQYOOMSPklYn6JkYZijbtuBaTd6xPSTg+R0D0OQvXT8Xo3lF+JA1b4dnXw8HxsflQfVoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401895; c=relaxed/simple;
	bh=ZdGn+g3+1OS0nkrvB4E8l23YybK09xBeJh00yNHe9bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nqf5IJa1c7+rtj8bNpeWbQ5K8QzpaI2GNGAMhGzrsJt50xnh3VPPlp37uxvxKgYV2IU+276ylkeCC9Ki0zvvFytSN/BbBVN26gSxfT8c7YAc6z7b+/NCB3qs/j5jK0jDsq4zOM0qHGk7Ff61O9pRH7te39zePpfIsBjezIZ1c3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqQffqvC; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7cdae63171aso6483854a34.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768401893; x=1769006693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tk41miGTpx94qcsuSJtMLlzWI+q+8a0dYgXV36tfo7U=;
        b=bqQffqvCbWUc7S9qF00nOcg/fNrrUnBauefE97r7GTbzLVqxBKCv20d3puFTioe1ih
         jtC2CEJHW6BwakAGYG4U0k04cWhlspk+aU0iAjyz4X8K598j6MV9wM7F7MX4/D2F+s1Q
         hmi/oViOV9S2Mgle5oAXqdhFntcABjbQAhzJhQ2NJdrnbLuvwtaJ97IUeFp3vPtG46X7
         cx6dNZOv2Bfq6Joa8YXkKkvvJRTcs9VohHKsv4n9CIJCC6NDjKNGTp9y5DEqA50Nayfw
         KvbvIACqBG1RHQlRLE46ubkrkm/6hKBtcqk/u2d/LkKj1DvHD3MvJBEbx+Qp5zr/JE9F
         FizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768401893; x=1769006693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tk41miGTpx94qcsuSJtMLlzWI+q+8a0dYgXV36tfo7U=;
        b=rxBxAP2mK7wdC96/8jQ2sPuYeRtIHCnEUj1UKCOyoP3iOGr9IkBWtTQd8Z7kSSpLHP
         mMqJq1ff7DJX6X4ddRooBg2GaPP+tWmwaScsLsyTlHRG3EKt8Go5qwOM7wHLyhsV8vBr
         mLJ0OdOOFELyfLAuzt6BpKLcAO5OOq7qrTijFxMN2hkWyJgVPq3fEzhfO59nBka5gl+f
         6rwRk1BQw3Jzsn8Lc/AFX7K4jIJPOopPsCkh1r2unZY2ob+Hu8td85pdmudd5flw1sl2
         sJ2EDimHRXTyEt4rOoMdL6mhlmHcrqGb3jxiVqPmNTJ3BBlnlsrGoTrrIWd56eGMLogd
         OMGA==
X-Forwarded-Encrypted: i=1; AJvYcCXDLw4qxGl1I4Lt6q5hoOxmUqsvwz4MjqWj0IdaHXqA42LPRDqr/h5oZ9Mw/2KPqGwUFh9D1nBvvQ7reA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aUTPk4Scq76RYOplN8ON4oqUhYX8w1cauDS0Uae2Zy0XtWrB
	HaHAmKLRmAZAB5jq17vP1/RZtKy10F7kDS4hQLDU39VhCoNmOIeaClgq
X-Gm-Gg: AY/fxX4APUmUd/AHj5Ob0TIr82UYpzU4hUW9C/XdjfONvkqNb8z2Z7x6OrKxcZ1yk1P
	O5tjkOz0YFkS6LnmOew3x2P/DdjR4bFf8JPM0fMSuBJEl4QxMkpiwJ012ZtmNCWmbTgQZ84jVw6
	D7Abu7ugNI8Dc4HpenxlTObssa4iS5+7xYdplWEtypcgPdWXwjZm8ck8CIG3NktHnuEGUlHpSRL
	8wA3u85Yl+gIGW+NzuPaWpHvk+pXTcF9o8Kb9+WJz2MVR7mmYHdYMMJtwJrffwCat4mZCSljBQp
	7v6HOuRiWOttao2yXK+z758aWXgaA8AQC59JRXuRKKMOuf6MHqaLFYmv/L40HJy8MO3wKinChbC
	UzAgFTXpy28P6aksovv/J9QPa7e1SDHaOHewnzuYptjBuno0Ba3egJKy4k5ZB9yxARSWv757jOA
	aHMt3xu/nTE27PofzVLpoDeNuFpVyEZ4IfB97ZepCURzc=
X-Received: by 2002:a05:6808:d4d:b0:453:77d6:1784 with SMTP id 5614622812f47-45c7153d1aamr1775376b6e.33.1768401893309;
        Wed, 14 Jan 2026 06:44:53 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e1b1285sm11015763b6e.8.2026.01.14.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:44:52 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: naohiro.aota@wdc.com
Cc: boris@bur.io,
	clm@fb.com,
	dsterba@suse.com,
	jiashengjiangcool@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] btrfs: zoned: remove redundant space_info lock and variable in do_allocation_zoned
Date: Wed, 14 Jan 2026 14:44:50 +0000
Message-Id: <20260114144450.48776-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DFOC3S5F0LN3.158CDRO798GJ8@wdc.com>
References: <DFOC3S5F0LN3.158CDRO798GJ8@wdc.com>
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

v2 -> v3:

1. Removed the description about the 'space_info->lock' in the comment block above do_allocation_zoned().

v1 -> v2:

1. Removed the description about avoiding deadlocks.
---
 fs/btrfs/extent-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4cae34620d1..36b06ee47c1a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3824,9 +3824,8 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
  * Lock nesting
  * ============
  *
- * space_info::lock
- *   block_group::lock
- *     fs_info::treelog_bg_lock
+ * block_group::lock
+ *   fs_info::treelog_bg_lock
  */
 
 /*
@@ -3839,7 +3838,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			       struct btrfs_block_group **bg_ret)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 start = block_group->start;
 	u64 num_bytes = ffe_ctl->num_bytes;
@@ -3900,7 +3898,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		 */
 	}
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
 	spin_lock(&fs_info->relocation_bg_lock);
@@ -4002,7 +3999,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.25.1


