Return-Path: <linux-btrfs+bounces-16228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6667B30692
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187B21D2010C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F838E74C;
	Thu, 21 Aug 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="anu4mt8g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7E3728AF
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807658; cv=none; b=BWXddgP7LXhRD7QYlPwBOYcUKG92cR5a197JH/PkZlqY845bOvo0+Zph3+RAMRd7uQNXuwszDlvjVOXTKj9zlb/Fa7VnuvEmKhO2Y8UJ8AhfPi6ZS3WeFs0tbShfBJEqkusi08N/BzwZhmnXoaGE4P2QWmKNWu1dc2Task/uB1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807658; c=relaxed/simple;
	bh=pZWAfjeKEyxWVI1i/b/M2R87xzgDWCxe1Yk13Yj6LPk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Luu9qzc7ekLhENOjuQWesfeer8bypg6mFJZVXhf1O5TidQzSicdL5BUyHUfY40A2WW07zmxU2V8GkVbVYVZAoVS5+GsMgsbeXR16s+RU1eAV8BIJr9xZ0MSLpf88Fp7mu1dcuTEMAdf2NVo7VUPfk8t0RNaK7zW2gjh9Sn/rwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=anu4mt8g; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e9343256981so1787128276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807656; x=1756412456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8OxZ8arGUc2qFIUcpcCgS+zVxBChijINy+DyEvJNls=;
        b=anu4mt8g4EDrDHPwRfIeh+t/OfTiE6iTKHYbAl1ufsbOmDrHXxNeZyZPlUopTl18Jc
         zoT+amOB+TiovX4lcBQSI4NcmDavG+hMR9zDDcB03Zh9XMn/lOMM/BIVNiWiSSVBvaEo
         nV0kfxrI1DIrDqxfKqYFFkIc20yoHJBu4CrrCzS0lTH6+DrRCgGeBD8PQQ5hSfTVwebE
         SSjAiQzrYlN677ZgEF/F5YLofuJPhgl0P825tvVuKqNs9ay+prdXy2TmXKOnwG+Jrtgr
         hbVdnYjBgU7Nc1Oo8i0cmFmLk49/rV22w2s1UDJGagx5G9m0x9x5I32/sfvBmRqFvhKp
         r+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807656; x=1756412456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8OxZ8arGUc2qFIUcpcCgS+zVxBChijINy+DyEvJNls=;
        b=xPlbhonsLK90rRNPOTKT14GxCh/CHLNz1cqE20Nkh3RY0rMEHyPHIbXVFqmyPfNRka
         AfUqBiUAhMNFaW1eix/5b9dGNaaHdChC7Ncda6hPDLYb3Dn3xuTxPW8/jTPn568c6Zum
         tTdEHfUb/9nhH5ar9EDTSyg7tUMiyMuSLDriZkyEBPtXUiaOTp0A3q14B1QNhZcCQ5UY
         MmgDLRL9tU9xwfEwYsD9CJZTtzq9gs36/pdvuC0y+4t/1mDoXq6YQ/YS3sUgIDcLRzt9
         xKiWjPj2cX/sz/YF5L27gk5CkBAP6ayD8Masl+R1cnPiH2dOypcXDoc9Ix7KxRVQF/pb
         0/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCViBXjOAw/eVrCP4dCk45aZOsyJ87tAo04PB8tzBzyXGhgWg+51BYPRM9v9QNYjtAZoBlo3W0xrM7RV/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6DPaKtQ1gF66XsVcU5wE2Wu2UVAza+y14sBF6VElPAdxPur97
	4nLQVpkm3k/Kcx2b8RaKHyeSV8XEVZJcpQiUMQO6DUwfu2YQLhhF9KX9tNjDlKf3Uew=
X-Gm-Gg: ASbGncvq1E6QyGTdD/sMVNM0a8iMpUPkMQ5d/G/qVOcToGBX0t5+pitQUccw/UhPlps
	CqY82dZ3X9RbJv6Cn6CcgsB9nCEW8U9KPagdicNuBqbMM/8kM6zYpX27jcAKM2OOWRN+9b4e4J8
	tNGWgoP17xQPNA0DP0Y3jUfLgPNcOrZOKxzm0TQuYKyFTthh1k8AlyxitgJ8RkxFmf7egODCdeb
	OBu8UXV2ujH64kYSPUA6H+h5JaDFdJ1fy7PbFe2YN/gdZPZbRUtAmqe5K0edEC8dqUcBnXu5piK
	bKyYNuK/iZkt8VUkhbTVy13YCm1SO1J1Uq+1Bm6nhuOxRb8GXvuq4SaRIkahy1kKWTmJvwb2yVb
	5Jwee5pAyaagoJXY3sSHoxTFC4dQ7Hu/oj9VZupEouAD+KY+CSQRtauVuW84FktURnSu5nKMUua
	YW+JbF
X-Google-Smtp-Source: AGHT+IHKdD7c0NoLaVeNfnIQ5Yw7Ue8ZdBZnrvI+mZUb/Urk+RN0cKprW6ynBsmjXYuBK0VVixEYQA==
X-Received: by 2002:a05:6902:102e:b0:e93:4952:e2bb with SMTP id 3f1490d57ef6-e951cdc81a7mr498133276.1.1755807656238;
        Thu, 21 Aug 2025 13:20:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f1150b34sm2414635276.4.2025.08.21.13.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 27/50] fs: use inode_tryget in evict_inodes
Date: Thu, 21 Aug 2025 16:18:38 -0400
Message-ID: <7564463eb7f0cb60a84b99f732118774d2ddacaa.1755806649.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE|I_FREEING we can simply use
inode_tryget() to determine if we have a live inode that can be evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a14b3a54c4b5..4e1eeb0c3889 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -983,12 +983,16 @@ void evict_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode->i_state & I_NEW) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		if (!inode_tryget(inode)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
 
-		__iget(inode);
 		inode_lru_list_del(inode);
 		list_add(&inode->i_lru, &dispose);
 		spin_unlock(&inode->i_lock);
-- 
2.49.0


