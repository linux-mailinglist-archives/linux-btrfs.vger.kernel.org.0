Return-Path: <linux-btrfs+bounces-16225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80EEB30687
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140251D013F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B345373F96;
	Thu, 21 Aug 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ONDchD72"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79DC38D7FA
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807654; cv=none; b=OWfQlkMg8lQQRcB+UkyHHsNTWy4lh5gj92AaUA3qBSKUnU8b88a06bMY6rNqtBOC8cclO+xY/TDlsh7evvgyUNTChtQKxj70HsysTqaqh6Qyg7ywHF65YMc9nkgdXATj4b+RM47AE2PqQrV9uSAGYhZJVYeQcg+5yMOd3PL8+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807654; c=relaxed/simple;
	bh=/SD0GMQ7Z7lFaGRylxaKZKlYwNeii2yE86zZo8Sf7zY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyDxKCAX2Lqw2RMCzT5obwaq3qQJ447XexXRvKwMtEVL5+tyWrE6X9+zW14vE7eATwD7Si8Jvi4DbPK30kkI7Kk5RlX3clYe9ZZCdS1HuWTrrdQUUQubxyO4kVoIOIbVjLCOwG43SrYedokQUccRxFLZ++8ZSXPVQGY35zRbDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ONDchD72; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso63894276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807651; x=1756412451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOMZ4zNNq1s5cON6tAf/wq9yALNeNe8lvhj+xp/yDeY=;
        b=ONDchD72W2DwN1FJdIE+SLzJAyAdGWwOzGuSG/IW4cVZAiN6IqrX5RMpnL/NTAGSK8
         wGlw9hG4pGobJJTyA6r6oVoC1zeB91GQsbdcyMO833NytI+hjCx64gUtVhtSrHq2vwfq
         YqQOsklf84SU5aepheB22LjL+sg0x/a1FCx15YrhUd7LO72w3ixGFEtLRnPVJQWY8MvM
         VK9/xCCadbCJBEePzm3zyrqlolYWJpT8BXOvM9Ddn7jK7w3vpNzTMfaHSUlER2cFLSOV
         Kc0GmNtGT4AodvEoRbTM4GPcAv2JlGBIBSd912getd0eJdCbkwRDO/uKMOWjHuxNkmJP
         RB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807651; x=1756412451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOMZ4zNNq1s5cON6tAf/wq9yALNeNe8lvhj+xp/yDeY=;
        b=e+Ri7FSciCoNBHqz18TQ3YNpP3YGCPYPv8Pi0AQL5dDdCYjzXD/qwlMaLqhjSKe/Bn
         oOkZIw76SbzyB/K+8eEkPyMSpjJPTRLs/UvXoOaG817flX/T3q3gvwnLGHHWUu4Adreo
         kFflz6AHZB2mSa7V7y42XNF4EmPOweVGsjP2lj2mRZeueZHzbIJLPcUO6NUdpSH7N1av
         ZhBjAIhYJHVClOUtgETgWCLDNsir2IMPdWu7FWOpYBhJnNKQTDNspUYIxs8ZXEZ+yTOb
         O0I5Mr0m4PSEo/Ved43rKgR0XvHI33zI5IEQwoFNcCUXlX8LOt3yCJcet7mgGQ2inl+D
         CCUA==
X-Forwarded-Encrypted: i=1; AJvYcCXDotDzIxig7rzBZc7vgpqzV9d5Llv8UYXiRgUDs4euTvoMfRkqfssFJFFDWX2cp+5tEYE0/v8gS42Beg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm29ZMt7iS3WoJnQDu7z5zYz2dtIVowsBwUzi9T0/MJhg/KpjQ
	d2WnaPYLQGYwYMXZaKCpGdOql4tO1wrdRUOPMNn8NH43sgENTOyO2LnHF1cUwWOpF+M=
X-Gm-Gg: ASbGnct2DuSd5pPXvz06d7p5IiPSGS5nciBJTg/tIfI18sUL5picYziXUFE/W4NlzG8
	1fFqMsluUR+/kyi6qlClFc8BJqAXQukwSuGLzc5KdSiOroqljiJMCLf6nUJcltYntaK8rOq+BEn
	qqtczzWxQNIK6O8iX8GIeHhRQ7nqL8otELxak0jeg+PjBA3Bubed3WCqbE4eGyQ3+xN3e3i7Lnq
	Xgxb4N0/mWmKUHvF22qsj+8YUXydqJ1/VQrjVyoeE3IQWGMGBTp6twCKAvEYJZN2150uR9Mf8o9
	z25pNKUaaaYHp3Ub4QzacR1HNMBMZUEhMd4YGHGcj8+5j3+/zU0aa6SPHxHUx3C/sqnOZpSk97A
	DY5GxhoIfXxymgzgwHkdw14Be5kPS07YoIvhsMmUt5xmdyLCXqgUFly+AQgAT1eOONg1jqcNzyL
	sChK1i
X-Google-Smtp-Source: AGHT+IE6HvsxjPwCyB/oWd9nkC+GiXEkxClQFs1S1ZRPTLNR+IPSUbRvRPeUbjnnpHHrMVPQxbBM3g==
X-Received: by 2002:a05:6902:2b89:b0:e94:e1e3:efc8 with SMTP id 3f1490d57ef6-e951c2eac87mr904774276.53.1755807651484;
        Thu, 21 Aug 2025 13:20:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f14d53cbsm2423258276.26.2025.08.21.13.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 24/50] fs: use igrab in insert_inode_locked
Date: Thu, 21 Aug 2025 16:18:35 -0400
Message-ID: <b4aa91a69d006ade6afc9acee6fbd2192cd186d4.1755806649.git.josef@toxicpanda.com>
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

Follow the same pattern in find_inode*. Instead of checking for
I_WILL_FREE|I_FREEING simply call igrab() and if it succeeds we're done.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 63ccd32fa221..6b772b9883ec 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1899,11 +1899,8 @@ int insert_inode_locked(struct inode *inode)
 				continue;
 			if (old->i_sb != sb)
 				continue;
-			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
+			if (!igrab(old))
 				continue;
-			}
 			break;
 		}
 		if (likely(!old)) {
@@ -1915,12 +1912,13 @@ int insert_inode_locked(struct inode *inode)
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
+		spin_lock(&old->i_lock);
 		if (unlikely(old->i_state & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
+			iput(old);
 			return -EBUSY;
 		}
-		__iget(old);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
 		wait_on_inode(old);
-- 
2.49.0


