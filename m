Return-Path: <linux-btrfs+bounces-16212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B6CB3064C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEB5AE4F58
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B4F3128A9;
	Thu, 21 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zESJVNbk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14738B67D
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807635; cv=none; b=qTGh6nwo/ZV8J7SGqzCSt0P49dp+lIs8xIPXB/dOZzG+RRRzvrBcmmB8/iV6PvpxIoVmrRdcvVwax1Ln8RPPotAMLrNzr5UyD0JeBkTjmQFnTG4MV9hu8fty1aYsYPcC9G/CERB1GA74hpjY4qrEd8TZuvKQOkS/y9SOe+iG08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807635; c=relaxed/simple;
	bh=2lSccGeZgoSX9aVaaFdQWb29wL+DUPO/GAFShbd8K+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eunjiZ9n47bTgV+4YmunROJoz8yZPi9G4R3j99YVm+NcuE/U8K2Fi31z8UQivKgB2xFcX21HVFXgLC4Fs4apZ4QR0Fdd9Rg/siPEjmc/Sww0FcBUtp0FC2ZDXCXFpOabUjH5Q1OYwYdHiuVuX1C0/fDzN+YiP9+SwtdG/bQHcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zESJVNbk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6059fb47so11950727b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807633; x=1756412433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6l/bS5zsFklKVceeWUebv0jSoLqiCtfylVlw96dX9A=;
        b=zESJVNbk2y3O8iYx0gwy3rxb0boWcrpPCTc0SvkjoX3yy0ZAxhHS+NsTE0PKR1mKLv
         zDiDSPUnjyQs5E0n+3TfR+Fi7C+NXtBkaC0C7FBHu2PYmOEtCDlDnh6s4bc9c2uLiLa1
         rhFEr7QAe8a0NVjWAkpzMwHH3dEsDFuFHzggAwUrt7gHL/UpsWgJfG+9VugQ8F0FE8Cc
         tDCF0ZLPtG69sqH4bmxy21FyDKet/4cS4qvxKAqvW+35Rwv44JENm61kC2QUQZdf0X+w
         knms9jQilY/lsOosNJYrueNdZwvGgE/LFUH6X8Q/BuFehfEAwoBrG+VA9FCBjCzvntDV
         MEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807633; x=1756412433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6l/bS5zsFklKVceeWUebv0jSoLqiCtfylVlw96dX9A=;
        b=p/7enCaonugvsw6k4lJ3EWsbOkupOgf4+FfP3qqniJKMXVW3UlcMOE6P6+5/e0Wu8G
         VL1Ej3r/+BRVo6FP2YlNusk0P+mRQskiBlk0h1LbO8QqkCZ+IpVV0fDug9DVYBf6vIic
         67SovL8TRgL9miZOI8aCecUsdvnSi3YKnYKfnzhXN5HEpIKRhPyuERwHjIaNzlnTnyJX
         J1P/GPaAd9L+xxwQ8fRyuQC2meYYkrza9YQcXAsvmRZJJr774xgb+32mN938saNd0wVT
         m+j84oZaNRTjeFFLDg8HBcKK7nnPhApG8ITok6ztutZemSR/EOP7ZJmDzHHYOt+/QLYi
         Y+UA==
X-Forwarded-Encrypted: i=1; AJvYcCX2eY1tunizHrnoZWAW+pi02V/ZuJZMT49RI1tdUEMsmh84Xgh85c2J5xxmeMLcalk1hdTYniKeqWPWEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/a6KUkSjOi9Lw6tfGlvR4lJLDkpR8rZ04cN9fhf75H+0S2wx/
	8+T3/JjQ2Bidqvf6uSiR/6TBgt1I86vSKEqMj2I1DykiJJeQGFdsW4KzaScw3g+EFoQ=
X-Gm-Gg: ASbGncvY7J+ellqW/7d0Gv8DfhmgBVdzuLYp0cc3o5728pMLV3yoH1o8mZ9nSdt/CgG
	+fKlKSYzVNJvYsx+hvm0STOfs5flrroEQuK/+eQxonhcXKIfgwyjEWBCbOXZHksH15ym8rDddu0
	UbK1LruYudplKSipl05lXNi4w50EKaNj0sZHlEFkAETO7ZZw8asRQa9798mQ4AdnxLRronM0FwL
	9BxYaf2KWrdwGbySne29BRgbJoZOwQys392LAIgJMCiIJfEya6+3XPJwGm+MDIhwR9PorIWjVrQ
	GQRSp/aAyOvZWfY4qbwWbNoK3u1M6B6k+w0+SFXFmwI4YcDkY4e+hkGk/CHyXW1qjlV13T8CPod
	ypAbVsHiaCH0LKSUXTOa/wEE+2Qb1VUAZkNvrEBXx7/gzl4u/i3AiT3EFM5ECR2K5GNAYlg==
X-Google-Smtp-Source: AGHT+IENgnB2uo7YbHtB+DxWNcnBLhyOt4jJNvfUugyviv21T/VvDjUt9O60NwAaV2wQMgUkTBA/BA==
X-Received: by 2002:a05:690c:48c8:b0:71f:b944:ff9 with SMTP id 00721157ae682-71fdc43915bmr7196657b3.44.1755807633295;
        Thu, 21 Aug 2025 13:20:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52c8b347csm50443d50.6.2025.08.21.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 12/50] fs: rework iput logic
Date: Thu, 21 Aug 2025 16:18:23 -0400
Message-ID: <51eb4b2eef8ee1f7bb4f0974b048dc85452d182d.1755806649.git.josef@toxicpanda.com>
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

Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
set, we will grab a reference on the inode again and then mark it dirty
and then redo the put.  This is to make sure we delay the time update
for as long as possible.

We can rework this logic to simply dec i_count if it is not 1, and if it
is do the time update while still holding the i_count reference.

Then we can replace the atomic_dec_and_lock with locking the ->i_lock
and doing atomic_dec_and_test, since we did the atomic_add_unless above.

This is preparation for no longer allowing 0 i_count inodes to exist.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 16acad5583fc..814c03f5dbb1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1928,22 +1928,23 @@ void iput(struct inode *inode)
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
-retry:
-	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
-		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
-			/*
-			 * Increment i_count directly as we still have our
-			 * i_obj_count reference still. This is temporary and
-			 * will go away in a future patch.
-			 */
-			atomic_inc(&inode->i_count);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_lazytime_iput(inode);
-			mark_inode_dirty_sync(inode);
-			goto retry;
-		}
-		iput_final(inode);
+
+	if (atomic_add_unless(&inode->i_count, -1, 1)) {
+		iobj_put(inode);
+		return;
 	}
+
+	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
+		trace_writeback_lazytime_iput(inode);
+		mark_inode_dirty_sync(inode);
+	}
+
+	spin_lock(&inode->i_lock);
+	if (atomic_dec_and_test(&inode->i_count))
+		iput_final(inode);
+	else
+		spin_unlock(&inode->i_lock);
+
 	iobj_put(inode);
 }
 EXPORT_SYMBOL(iput);
-- 
2.49.0


