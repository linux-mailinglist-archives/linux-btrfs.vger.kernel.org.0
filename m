Return-Path: <linux-btrfs+bounces-16219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92BEB3065E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14D3720272
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2538CF99;
	Thu, 21 Aug 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fLhSWod+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71E38C61D
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807645; cv=none; b=bIK12VBTX+80bz/kn6a2irZa3fuE5kJOqU7ibBM7XPpr7ryjg6pj3QMGhx2weITSJssSCWTlp8DcPWv93Wau/LvBnKb6ipVgxO/pPKnAWka3WG24m5BVY5lMBbJ+2yt7Ty8jaYdUYLlkHKjag/tH96DHoen+Fw2Z04OaWKyhuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807645; c=relaxed/simple;
	bh=Kg4HyI9QpVcllETBw5mmbw49cjWo/i+7w3jN/b+fpXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urx6TGNCNMJef+wmf19a73o8wWTdVmCwzMlY0cRoO1BJEGhsHm8BKCtMRj2/RRA0hgP4koK97JR62b7JFUtoDUQRK4OWcBKBG9rZd0hYcucewzFgXBobsKUN6sR2qg3U3/spTdx1n7ac2LnsiXw5/9TIrdZW50DdolC1AOf/zoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fLhSWod+; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603cebd9so15886237b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807642; x=1756412442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6vlOFADLX5mw52k/m7fuDkR4/0v4QldE+cL7IA9Qp0=;
        b=fLhSWod+pQMoyGzM3hk9LBm4L4ngCrAN9KmjeLb00BIqvIqbedRyP1Nt2qCIbl3RzQ
         DJd2/8Ij92Ppe46a6hMYU8d2OLkRRVDfN5Y0rsNfadrltY1MPVP/ruxdohH5IqjKDndA
         +eg2lx1VJK/LEToVAFUMEe/0p1WqUb1Z54TaNJkarRNcvE3bGPuQRaV12wI6rlecTBMh
         TEzBaqiQJBFxR7q2BCj41/uDz2z02RkS2V2zRAESnnnoUSO6gv4SAOrkvLt5r7R4qJQl
         bGDGhQhNJgLtYiNrsxgR4/k94JMZo+hGzQjRt+Dy20p0WSZocjHOq+B8DUjKSSEUblhn
         Mi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807642; x=1756412442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6vlOFADLX5mw52k/m7fuDkR4/0v4QldE+cL7IA9Qp0=;
        b=d2OYCytS3F/X1+sahINFTCfQJBnT6Tde0suad0I52BNUzMIMLIc/jMJEAqZTK7Mlui
         rfKBmua4rGUgIoU9qsaiAXDTLoIyBCkfn/Ob3vO5SBWgyicqC0V5q1Q0aqt3b1XYgrXv
         y8IMr/5TF/J/AH/71E7N+otZ7uBmm9MDx8msFgW6qFM8a5edTLe7xEq/idHVRMBiBw0E
         WaFALUg3tVdcOP3HDx0+dfKY0j7wWGH+4IKIZIY7NBSQ3TgIMYR/jRLIw21b036w8kBp
         wPwJuyaDY2/OvvEfLnbCM6JfM8Lz3qV2KjE4DmmuDdolnfs1e/yRo4LiKX5Ia4zMO37J
         eB0w==
X-Forwarded-Encrypted: i=1; AJvYcCVf5VwG8m53N4tThKSql5vkkdiFmyhZ9OwGA/8eQ49P4eApdf8lYmuLDACQvbFsCxdpOtl/7AY1gKaX0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHBGeACivtCnW7mcLpCAVq1Q98Z9QtpvtVDDYyEAtRa935mKP
	/pv7bUFQl6SWEh0W8eNFI686G1R/NGeFaPORAVjjqghIYtiZBFI2a042ZI1dB5i1/+k=
X-Gm-Gg: ASbGncsXUPT4iatMKa3WTUAVI7kykIp0Qdn98PxcctHXmAl7jSCELkQ118VJIjsPofd
	US3YE/qLtZOp/crrc46tG3JcMUFiR/KN9yAprZvqr9kM6loQgYPSRdfAv4uJm5tljDj1NfFS7YL
	zZJ+ERcd+In+6Sikv/ZvBndUs9cJbazHMt7MFBNOeAs5orzoroJ3jhiI0+pBmhO/TnK2qHoV7W9
	ZSyWruR2cAjS6TGOzC3xqppngHQdNShk2fqiDK6sY1ytyOuwydafWmWzmWHrR2tt21WxzrToURL
	A4DUMws29spObe32rgBAz2eN5/KcIJ9EOqnSGO6d1BKkODBdRo+0Zhr5h92f7Wu0K1Y8lHCACXh
	7cHiMg2lUtKvxkus1efB91UxhpjAQZE/vgUcZkm2t3I8QT2r3mZFZ2TL8RCY=
X-Google-Smtp-Source: AGHT+IEaCpm4qmdeQmTjz+kVkgMRNomqyiidl3fTCdzZLNucs5oGAQlKaflKfo8a3BN1zA6M3Ppw9A==
X-Received: by 2002:a05:690c:688c:b0:71a:323a:b297 with SMTP id 00721157ae682-71fdc2f10e1mr5550167b3.7.1755807642271;
        Thu, 21 Aug 2025 13:20:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52b9fdedbsm53508d50.5.2025.08.21.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 18/50] fs: disallow 0 reference count inodes
Date: Thu, 21 Aug 2025 16:18:29 -0400
Message-ID: <6f4fb1baddecbdab4231c6094bbb05a98bbb7365.1755806649.git.josef@toxicpanda.com>
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

Now that we take a full reference for inodes on the LRU, move the logic
to add the inode to the LRU to before we drop our last reference. This
allows us to ensure that if the inode has a reference count it can be
used, and we no longer hold onto inodes that have a 0 reference count.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index de0ec791f9a3..b4145ddbaf8e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -614,7 +614,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	if (inode->i_state & (I_FREEING | I_WILL_FREE))
 		return;
-	if (atomic_read(&inode->i_count))
+	if (atomic_read(&inode->i_count) != 1)
 		return;
 	if (inode->__i_nlink == 0)
 		return;
@@ -1966,28 +1966,11 @@ EXPORT_SYMBOL(generic_delete_inode);
  * in cache if fs is alive, sync and evict if fs is
  * shutting down.
  */
-static void iput_final(struct inode *inode, bool skip_lru)
+static void iput_final(struct inode *inode, bool drop)
 {
-	struct super_block *sb = inode->i_sb;
-	const struct super_operations *op = inode->i_sb->s_op;
 	unsigned long state;
-	int drop;
 
 	WARN_ON(inode->i_state & I_NEW);
-
-	if (op->drop_inode)
-		drop = op->drop_inode(inode);
-	else
-		drop = generic_drop_inode(inode);
-
-	if (!drop && !skip_lru &&
-	    !(inode->i_state & I_DONTCACHE) &&
-	    (sb->s_flags & SB_ACTIVE)) {
-		__inode_add_lru(inode, true);
-		spin_unlock(&inode->i_lock);
-		return;
-	}
-
 	WARN_ON(!list_empty(&inode->i_lru));
 
 	state = inode->i_state;
@@ -2009,8 +1992,29 @@ static void iput_final(struct inode *inode, bool skip_lru)
 	evict(inode);
 }
 
+static bool maybe_add_lru(struct inode *inode, bool skip_lru)
+{
+	const struct super_operations *op = inode->i_sb->s_op;
+	struct super_block *sb = inode->i_sb;
+	bool drop = false;
+
+	if (op->drop_inode)
+		drop = op->drop_inode(inode);
+	else
+		drop = generic_drop_inode(inode);
+
+	if (!drop && !skip_lru &&
+	    !(inode->i_state & I_DONTCACHE) &&
+	    (sb->s_flags & SB_ACTIVE))
+		__inode_add_lru(inode, true);
+
+	return drop;
+}
+
 static void __iput(struct inode *inode, bool skip_lru)
 {
+	bool drop;
+
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
@@ -2026,8 +2030,17 @@ static void __iput(struct inode *inode, bool skip_lru)
 	}
 
 	spin_lock(&inode->i_lock);
+
+	/*
+	 * If we want to keep the inode around on an LRU we will grab a ref to
+	 * the inode when we add it to the LRU list, so we can safely drop the
+	 * callers reference after this. If we didn't add the inode to the LRU
+	 * then the refcount will still be 1 and we can do the final iput.
+	 */
+	drop = maybe_add_lru(inode, skip_lru);
+
 	if (atomic_dec_and_test(&inode->i_count))
-		iput_final(inode, skip_lru);
+		iput_final(inode, drop);
 	else
 		spin_unlock(&inode->i_lock);
 
-- 
2.49.0


