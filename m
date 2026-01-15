Return-Path: <linux-btrfs+bounces-20539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF6D25043
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 15:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CDB30F84B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A883A89CB;
	Thu, 15 Jan 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwCAw4xW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AF223DEA
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487918; cv=none; b=TDTuq8Bbn4Uo4EE0SxlEEruLZIui5QIoCmTaYyGL9xLIF++wiWkNzVEQcpkejNpIYy59SIUxjseYHL+t188Imqw/GM12Cv/kjtESSX9BLKoXso3veP+Sw+C/ZJIhjj2avNQ8hXK4v1Gj3R9xhkeOJGkBKKixUyIAa5JuvWM3+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487918; c=relaxed/simple;
	bh=Wv/3Aa8tWfJjLLISVQDBUFQsifWFbeQ/XDhV5lhBn2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LU6Z5Ho3qkG0XWccwdjnDj+M6Rj8MHw8rWTDs7rE2CGbIHUDIvtkRcssJXPU4uTbUgu4U//ZgZLuyzxAED0WM35qNEDdHZbs3dGcdFm5iuwcJfvYJtfFptLgt4jWa0Jm3ByfLcrqFLZoZ4ET48Lf52U1QSpM2lZmq50YlGwtEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwCAw4xW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c70afbeebso576965b6e.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 06:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768487910; x=1769092710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6dwhaqBfxx37jZyPctpV6PBwRbKadr98aK/ySF7sB/Y=;
        b=XwCAw4xWPQPR2oALpqh5rtmivwnL6RomRAzYjDFfdz5jjXdPN5syvUoJ2kw06l49Xj
         mSDOhUxxEeOiaivQSzTapmVWcr2VqwYeaIRE/KYOOTO8HaO03e5ORgYwEY/k28RMUnkz
         jwTw6Ii72BiJH+UIxbTgaSVoHwPdKs1UrkVi+RVMKMEs17RBnM1Rp51S04Y3LLdrdJHW
         kT9a6MhESAn/9B4+Ge/dlxQ6KjT/IIQBcJYoCLIkw0G25xd198EHuqSnsh33wU5mw10F
         wzAGTX1f7NPdgQW3efzE5eekaBrGksQmVobbAbinH5JgHvH7pP/Xi7PiJwxcyH7mGMr9
         mVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487910; x=1769092710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dwhaqBfxx37jZyPctpV6PBwRbKadr98aK/ySF7sB/Y=;
        b=gycIIGjima1uwU6a8g7plC1WGgvldyuY+QBdmb8psNOM+GI0ao6qygeAwYfL5W1LUN
         wNF49yHp/MIqzH8g1AQ6rsdK8VZKtGJqMqc8+wmoFH6KGH/AR+hXnMigd0NKbyv37Dh/
         QRaRxp3n+MNdty3R0yWQ9vBJPRG5Py13QxbW57es2s2jd358HveP1t5T/9iY3t+g4iZp
         EXPkgDSyS7X7ZnjbNaljV47DEcgsM5ZCsKDbAvA3/3xD3Y7f8LpEsxb1nuwmPufbZ+mR
         Bz040QemvCJXS9QPv+k73/6Fb0N59SGmF5q6EQxRLr9rRrIGrJkxSxTwwLVYF3YunMnL
         Ce5A==
X-Forwarded-Encrypted: i=1; AJvYcCW5VKMVFNWUg3TcSg3Q29O7xwAvpGwK/CmvTPE+/8dMtY7xqRsPt7Ic8/lkGbOA8J7wdIxrYu87F2sirQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJ1xsy+LAQ3MwT3R03c6F9mYXa0KYrU6IwNYNt8L/y5nbPsV0
	zrhfmBHo9oKk15e0R9qsDDz3Zs/SRP72O9r2Vysi2XGzD0MNR7drqnyGO4pumA==
X-Gm-Gg: AY/fxX7AR4dbskCFzanrNUS1vEBfKNo3KhqSM1vsQ6eEZwSyaKNMcKrHdm2bvOVhTCY
	tAZ/frmsPCL3Vl/N9G913d4zfKCvBlo7jG7NXkM3kead0SBcMQ6s4EG29CqdfH/D19/QMbGtzRj
	5cWnC1BhBB3KGE09dT5HYHUPDQI9xSPoaRsc1hES4xLGerMkeruZconwkoqtYuET4Ef3ruf+s0r
	sP+JIVcgNyFwGDpPLoAimByUe+vssNAfKZsZr3vAJGKstbLj8cyOnOgGXsAWtcYv5lR7/NCaTJL
	lTOT4IbLva0mI+1OYLu8n7LAZKp7NAyucKo/KZiNCcWnXWCe9am5tUaiWISWV2bYy34eIGg11nL
	9vaGYCkqmZ0vW0VSS8tzah2Dv7PN3NZSxo710qQgEPNc2aolaFa5aeL4rg1npl3RFe1yWWGLuU0
	ijBQF9iEMw53OU4gcs1ln1h1mWfvqvfpbL
X-Received: by 2002:a05:6808:c2d2:b0:459:b564:dd64 with SMTP id 5614622812f47-45c715cab7bmr4382306b6e.61.1768487909769;
        Thu, 15 Jan 2026 06:38:29 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c91352ac3sm449897b6e.19.2026.01.15.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:29 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] btrfs: remove unnecessary RCU protection in clear_incompat_bg_bits
Date: Thu, 15 Jan 2026 14:38:26 +0000
Message-Id: <20260115143826.17725-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function clear_incompat_bg_bits() currently uses
list_for_each_entry_rcu() to iterate over the fs_info->space_info list.
However, inside the loop, it calls down_read(&sinfo->groups_sem).

Since down_read() is a blocking operation that can sleep, calling it
inside an implied RCU read-side critical section is illegal and can
trigger "scheduling while atomic" errors or lockdep warnings.

As established in commit 728049050012 ("btrfs: kill the RCU protection
for fs_info->space_info"), the space_info list is initialized upon mount
and destroyed during unmount. It does not change during the runtime of
the filesystem, making RCU protection unnecessary.

Fix this by switching to the standard list_for_each_entry() iterator,
which safely allows blocking operations like semaphore acquisition within
the loop.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabe..d2cb26f130eb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1011,7 +1011,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 		struct list_head *head = &fs_info->space_info;
 		struct btrfs_space_info *sinfo;
 
-		list_for_each_entry_rcu(sinfo, head, list) {
+		list_for_each_entry(sinfo, head, list) {
 			down_read(&sinfo->groups_sem);
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
 				found_raid56 = true;
-- 
2.25.1


