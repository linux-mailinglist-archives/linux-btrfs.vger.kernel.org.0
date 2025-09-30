Return-Path: <linux-btrfs+bounces-17286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F92BAC36F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F189D1926D9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B482F6182;
	Tue, 30 Sep 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gofnQE9q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364672F5A28
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223684; cv=none; b=S3ajmhaGdpcQGd56MLI7nfjpuk5rFiq1ouRwCo17vRUqojk/S4tlHflvhIw7RJ+Ni0JrocD30+FgjlHEgeOFE9Se4BI7fcYaR0eTwxDGG/0hwCv6nlUa6WaW/2rkRvPe0ujA/1H7AE3fLGViFxI8Q4QQ69FbE5qDPig6lSIogyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223684; c=relaxed/simple;
	bh=14yGhWhxJxKPIeIrNLfrEWF/S6UUQE2k4azZt9Ge4F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmVd0ipMpHK4FaeKa9ieBqwzUedyy9jYH3anW1iA+++o/h9LID4mhxSrp01/sY0/B8w2XOYv4k7BqadBkgYtx9vgL5FkbPVq2gW78Di5Fjn+2CGyfNOvqFUK/0n4OFOlJHc9jEkKM5T8xvHkzksMlA7LjJJ4pHoqIqTAUHUYbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gofnQE9q; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-40d0c517f90so144427f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759223680; x=1759828480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DH1NlSlaEudUba94N0gvDnLMb1d3cyB+74kEXFRWj1E=;
        b=gofnQE9qaKwg1IFLtVmV8vCCvj8j9uoW+WbCZAyfWJpvrgb3kqJ9+mpjmXuxRwHPTQ
         0+WeOrlx85++KzdOdsf7waKpAFKtKP/YJNr7LjFV/ht9iCMNdnUDWHI95lzFl/nCR2y9
         CNKUjkdJkcmzFdJXFGeBq1qfEgU9wu/TTFJ+7IUxKqbdCEmXvOSgwwc0npo0ztxCPJ+o
         pwOJISs+hIsxhTDiITPufHS61C3T6J772iPvFcVqkliNGHWZX6go/IBGTsX1qUDGkn4D
         OAGe2C9aI7FY3tsFE5R6daBDWzWF7tLg0c9Ew9FjjuVnrOypkWz1gatda1Zn8oLNpgNK
         Y4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223680; x=1759828480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH1NlSlaEudUba94N0gvDnLMb1d3cyB+74kEXFRWj1E=;
        b=euzhhYZbBhuL3WQLhREdi/hRX6lZ91HAwlud0Q/QjbS4KWo9y7J3yFMbCXpGGX46NO
         5s28/IHp8VhjFAvNcrbdK5KzFeDohzQCdeLeM81S4OrIQlxcHOfLNlHMFhcVIXUgSKgT
         6IOeWtdu9LdSf1bboS/HbXEIyGVzYJk1SsgIzZQB6LYBpuIE+aG4DOY1Lsv0bnT7jw4O
         zjAdC6HRCRh0u4xk3Voajhxhj6/GQZzzpNPaY8S2T5KRVz1bAP+Tw/04qPIRC6PVnqG6
         kgidULPle47vczZ5Ww6QDK9G162wRi8Zwg07ictbpdD8pM9a5LDr9qYrhhG/8dFrMyjN
         KpQg==
X-Gm-Message-State: AOJu0YzsuOpxTJXIjXq5bckvJqeWw7bkfaxDd9jvvpK1UFLK3LnF/mDt
	hBc5keSXwg26v9KXq2bsbnw4S0loCXjYFV3PIWD172TnC5RBMOxNg56xebrg98lC
X-Gm-Gg: ASbGncv6jagbzeKbu4um956nsRs+6XA4CnNWR8xhM0zBxxGYGzis0mtbkbjaBXWzvMk
	egXYPnbxx3ej9yVDs5Nsm/8fHXO8ivjrPhF72BrsVF/aZ6ign/IE1RTS0rrIGc9EaTl7irFYX6x
	Z5ep7pbaJE2iKIH+0mSk/HhrAilTy3BLsj+sk6dzdWOYWKaZusGU9fEKykpzgUXBfigKs3KxPcy
	wlfUVStyRMK5JmRikAIU7LuLD2HzP/NhVw9QOzMEzaS/5n1O3/jjRitXAcvb0az/MJPgq1Cp8SB
	wfeSjYAGYcQy7urxIJYmRF6DhXXwgW2i0eqZhoUFXOVsEAxRlOuiW6V74f4ZCvZd3zVuzpFIbPK
	D2d0GGagPH7iyY++WhcJWJBckfeIrXQtKUXp3aVPj/zW17V397jZBxClyfC9odtykwTAqlG24+I
	A=
X-Google-Smtp-Source: AGHT+IHLikjr1LvbOBlnMIgFiu5KZJiA4nat4K1Q3fyVS+a1hd0LvhBcizuVjM3yI2Nj4+3iyJlerg==
X-Received: by 2002:adf:b64c:0:b0:3f4:52d3:7a6a with SMTP id ffacd0b85a97d-40e503e0212mr7500503f8f.10.1759223680399;
        Tue, 30 Sep 2025 02:14:40 -0700 (PDT)
Received: from bhk.router ([102.171.36.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1b665sm21775209f8f.27.2025.09.30.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:14:40 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] btrfs: Refactor allocation size calculation in kzalloc()
Date: Tue, 30 Sep 2025 10:14:22 +0100
Message-ID: <20250930091440.25078-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap allocation size calculation in size_add() and size_mul() to avoid
any potential overflow.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 fs/btrfs/volumes.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6e3efd6f602..3f1f19b28aac 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6076,12 +6076,11 @@ struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_io_context *bioc;
 
-	bioc = kzalloc(
-		 /* The size of btrfs_io_context */
-		sizeof(struct btrfs_io_context) +
-		/* Plus the variable array for the stripes */
-		sizeof(struct btrfs_io_stripe) * (total_stripes),
-		GFP_NOFS);
+	/* The size of btrfs_io_context */
+	/* Plus the variable array for the stripes */
+	bioc = kzalloc(size_add(sizeof(struct btrfs_io_context),
+				size_mul(sizeof(struct btrfs_io_stripe),
+						total_stripes)), GFP_NOFS);
 
 	if (!bioc)
 		return NULL;
-- 
2.51.0


