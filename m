Return-Path: <linux-btrfs+bounces-16240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA6B306D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC267B02508
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2DE39195B;
	Thu, 21 Aug 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0xrRm3+m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4E391933
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807679; cv=none; b=Io9rKqjnZdZMz65esWNpU3VNwzzftCvTbuxu7LutMB+iUoSscBKP+3k5La+JzeHLVAf2/QpHMvyMmO16VIgpwQTqof/sphB6cLzVPeP76ZsGLV4cJ0fKM9aqq4UU76PuQ9VBaYZb+YWXq3L0DVISJHga2sWpz8l2TmB0AFWTq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807679; c=relaxed/simple;
	bh=l9LGL5YoR+E74x5+N/Eq/UXBXN/oa7FDffUkNr02mvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWka60U5qu8DufSIuKJguVQtkYIOLvqgOjmaTaX0yvgNGGOlL0E9ejBvg+dlLnu8nRK5p6znygTnU1DX8wLq56lyohdmH+n3pGTsS/6C3ZEBz0fLOSzRuKSkfMDJw238bEscQhv8j7Jpu3ENG7ZV4F0eD7wcvW7oP13wxFojCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0xrRm3+m; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e931c71a1baso1972825276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807677; x=1756412477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6A8xX7Mkw85UitdhfeCIWR7erYk+tgthiF9HNGtDW90=;
        b=0xrRm3+mKVWYP/+dwHCORPrPDAjir0w4zx3zLOwCTKGB+pDuowu8CcuA5AxVOv7AqE
         ObUCrRWYbHPjdlD7w1VFDcTl//pv/aFW9Jno7uOXMn7wT+eE/IaC6jiT5zPtEfaJKfiK
         eEGADrUX3oa9tvHvMGYVQO1HkMGWO4JBOoLFeQN0iadnnQzovw2YRSnWeFPhsf5pzT5R
         SEyLTBVJIC2ruab/aGzXU1f6Tmiu4rh3sFMIfCUH71vtcz8PAHxkOe/0wFDUQY0Yva8w
         IKGvY9VZ2FnDHM+zLKW9puN/37D3jJbayuFX5g9yNhpI5VgQkyVRlFg9mh6/k92Y6TiF
         2ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807677; x=1756412477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A8xX7Mkw85UitdhfeCIWR7erYk+tgthiF9HNGtDW90=;
        b=X8HEs+uqjy/keMfz2R24rPVoD1y13iX2cvWyyjIKRHS0/cgcprpJN5Z0mn3uPB0XtA
         bifwmdUfy1406k1VXGe5ATfo14RexiQ8xIRwCnkucLEaNkvBeJbYGkRc88qkfZq6MdNr
         t6V8jo8q747UAOWTHA/jO3zrV2UcEKc8Xns2cKuGQbO49Mq3nOOcfusVzeZDXRkE0ByK
         GqSk/vQp3rdp2ff7aZ/TrTJLANy103bbWpojjjSmgmsamHfZzxiizQy0dMMQk09I1rxC
         88sZ7TS/7+/9ozqxPAGxOfDcEZ0uQSF3q29c0IqRR4ysQrAb5fC4WzaeBi2f/BM6IVz8
         P6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+C+BRYUxGL/JAAvB9uvRG9gY2x7W3hZcTfULhu2rcxYae0vajc3YecqiPf3aH2kUmeqAJJEFBXPzUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpWKmyvoiQyVOYLkQYHwld0QxAgXylJZTtoy3ZaYuDw68xjM8
	mBhqfUeL9Qt+aN7AM6y5WZJT6lJYa9R0fcQT3bTH0cQoZvK8Dl5DyVYHLc45fCa3MSA=
X-Gm-Gg: ASbGncs+zk3RfLfBnR96VN7Su/5K9qdfIz6itKm9PggeMLawNDPvtTi7v0jrbHkluN7
	Dqaf/Ygl52v0U3mu26FtSOP/EKmmurU6nQAiF4ciM8+U8TjeQ66oIgqwbJlCUfDm+H5XtWU0YeO
	n1gnH1/83Y81t1/dN7ZTdeSPNWN7+bmDFJxGAsJZ0t1bZUu2abKJqRdOULcYxj4AGt9pMX/g4s3
	tEFljoh7mMeDAgxyaXwJx7Nfc0lbJgIKN9r2hyiqE1dhv2NYCPnEYQbfmMMLDnaeBqgey0U1CQo
	5sub9OR9zolqle13ypJDtpYkufLT+ol+m6UNrHxJKoORMdV4Ru1ImEsPguW60ZnspvPlxH3YqVb
	H2/Odp/I1yGmt1Al43gfoskodtzu/RSr6LfLdDx4tdL1fG2rPjchauEk4ddk=
X-Google-Smtp-Source: AGHT+IEslmPaAmy8j7deq0G6NJW1ig6p7tgKnrmQqRmoW4yzMeUV0UVc/9ZPvIEXnYkUv+t0w0Cs7g==
X-Received: by 2002:a05:690c:e0e:b0:71f:9a36:d33b with SMTP id 00721157ae682-71fdc412c54mr7580807b3.45.1755807676808;
        Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0b039dsm46055887b3.59.2025.08.21.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 40/50] landlock: remove I_FREEING|I_WILL_FREE check
Date: Thu, 21 Aug 2025 16:18:51 -0400
Message-ID: <e54edfc39b9b19fe8ff8c4c7e8b5fe06caa78fc9.1755806649.git.josef@toxicpanda.com>
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

We have the reference count that we can use to see if the inode is
alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/landlock/fs.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 570f851dc469..fc7e577b56e1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1280,23 +1280,8 @@ static void hook_sb_delete(struct super_block *const sb)
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		struct landlock_object *object;
 
-		/* Only handles referenced inodes. */
-		if (!refcount_read(&inode->i_count))
-			continue;
-
-		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
-		 */
 		spin_lock(&inode->i_lock);
-		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
-		 */
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1308,10 +1293,11 @@ static void hook_sb_delete(struct super_block *const sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
 
+		if (!igrab(inode))
+			continue;
+
 		/*
 		 * If there is no concurrent release_inode() ongoing, then we
 		 * are in charge of calling iput() on this inode, otherwise we
-- 
2.49.0


