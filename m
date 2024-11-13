Return-Path: <linux-btrfs+bounces-9593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C69C702F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E490528525F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013382022C5;
	Wed, 13 Nov 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6vYp27M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789982010F6;
	Wed, 13 Nov 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502817; cv=none; b=RRuahUbWgEqn8BCxEaQFm+EuthtHxqFqklGUUy1XAGmYtEHlKSMpGh0y1+AkkEPUt1aTgWUUozzVu6hXoK7ugE0dP42mBZ+qvS0gnu+RxbpWXVMJHw67uKMRX9dfUui/Kdh6wvf5nSIc2kM10+cgrJLMd0yhCYtPJv+YNFZ4c/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502817; c=relaxed/simple;
	bh=F0UgPckedjaCXEFQMnzz4rpfr+ORwyh2j7PG09KHHx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WjRtKxTJC6b8DuAFmmZdExUMR6XvzoR+ip897H76zkR4pmuxjhjyC4hxxJbXyz2Eag5d72gUUJVVj6Olz5p0D1OptroyF91bWtBoxGvoHJi7WaZ1luwuAAgJ1jsyAeIbPUzACM37xupJJU9h18Rj6/u/jaE75iWWvp1Q8JZr8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6vYp27M; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso55429295e9.1;
        Wed, 13 Nov 2024 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502814; x=1732107614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbD5ay8JHZIEWXda/mkakib3q8FVjwPNcGWng2RlCnw=;
        b=C6vYp27Mvt0kU5WYsRuvpkpUiriQOHl9OFWm2lx0XqqDTULZGRftqsI1GXaSEP/XGy
         grtMoORgv27doKGVU5bPMe0ZKrsEEUMmdc47C9WJTxw0QEUNJXg2lTRvxb0X9G+NtCUo
         3Jw2z51CaSTKoK6ToZexPLggOsm3TIRNvU3orIf/EYrDwmdn3I/Uv3c2mTq6wVWy0viE
         nwTi8GyBtxzDePctONccRFqEtrz2xUEJoNEDvrvQqjq2R8Qy3LNQcdXL+a5felHyW9Zj
         ur2W34qLI0Q2SZ7k5vPaJabadu2PW5Y6RWfT6yZWoenHXOOT3QbhRfoCol+F581JfPo1
         G01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502814; x=1732107614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbD5ay8JHZIEWXda/mkakib3q8FVjwPNcGWng2RlCnw=;
        b=btbef/MtkNeXJk1YwW/C5XvN71emzcdK3PqxZ4baxszHc9TQ3axMWA4Z417VP+BZGO
         rvFk2mzHHlsasHsJaTgrEMD4LsFFCmb3nnanEGss1gWSrBHuxOxxR4zyDfLGvveRSIm1
         qqbF/vlxDt86kt/xlA1ujiQFeep2d1nuUAbMNFhSH/nOCAdePClJLq7IrvyDY/oj/WO8
         7NrE2ljTUND3FPG9wOIhtw9kD1ZmJmDJAXxvYFt4cZWfc8mAsYr1dk1/I7Gozk6lPzoc
         gfGptbeUL0IUG3dUaJ6ilenRpUxvm23QSDA1ZdpgnVD3++/b88i+yk3XMWNXwfl7Do70
         /XZw==
X-Forwarded-Encrypted: i=1; AJvYcCUZHzHcdU6GoisESs8oytQeX7lLacL5QIdpybHEY1fsqpg1Lv8LmxM4F4Vogv0sawHV/16KvCKo9vpoSwTX@vger.kernel.org, AJvYcCVAzYVY6X9R53TLYu+nbq09VzMuX3o1QG/+w71yc2+W07vNGmtyqJ70CMXkCfSMKK/pq5SJP39QyldKsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77EaOpWP9cc4EYGthgIovdmQjO7KTHdeTfEgmhSumotLNxc5T
	zTbKxNvW38WAxPBdahFPiusEClMJgJIO7eHvPK9f7ROttdWdalm4
X-Google-Smtp-Source: AGHT+IGsUIbm9I49X+OeID+VSI09/Kwz3fS9lzCIgcam8zUvR7gm7mbJ1eNP0wVfbEaS9yK5lVCLMg==
X-Received: by 2002:a05:600c:a44:b0:431:561b:b32a with SMTP id 5b1f17b1804b1-432b750a815mr178041995e9.19.1731502813601;
        Wed, 13 Nov 2024 05:00:13 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e0e33sm23892745e9.7.2024.11.13.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:00:13 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: send: remove redundant assignments to variable ret
Date: Wed, 13 Nov 2024 13:00:12 +0000
Message-Id: <20241113130012.1370782-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being initialized to zero and also later
re-assigned to zero. In both cases the assignment is redundant
since the value is never read after the assignment and hence
they can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7254279c3cc9..c5a318feb8ae 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7253,7 +7253,7 @@ static int changed_cb(struct btrfs_path *left_path,
 		      enum btrfs_compare_tree_result result,
 		      struct send_ctx *sctx)
 {
-	int ret = 0;
+	int ret;
 
 	/*
 	 * We can not hold the commit root semaphore here. This is because in
@@ -7313,7 +7313,6 @@ static int changed_cb(struct btrfs_path *left_path,
 			return 0;
 		}
 		result = BTRFS_COMPARE_TREE_CHANGED;
-		ret = 0;
 	}
 
 	sctx->left_path = left_path;
-- 
2.39.5


