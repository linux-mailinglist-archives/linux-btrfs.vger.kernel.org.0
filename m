Return-Path: <linux-btrfs+bounces-16390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8CB36E63
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881594617F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9253362097;
	Tue, 26 Aug 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cgZ+WPfp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C435FC33
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222885; cv=none; b=WI08s5SLLVbx82G3pA/cPyjvOoEoJm3us3O+XA3t73MN9+FA+Y6PuOvRguHLmHhaeUBt6fhEHfpFQauVX2FagDn3+Fq++zcMP598GfPeRsGo43b492TVXi+Gin59CA0yF2c1QM+FO0Ah1Kz25g2pZRe87rCwug1ZOsSUVG/aeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222885; c=relaxed/simple;
	bh=lkB1nCuOVUKuJ1vMB3bhPC3mpcBW+3Jl5Qt33kBEJwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq3OCJVSx48UGDBPzWT7aiN78koROzVMC7L51AAF0NuZOM9Rsk31pNlD5pPXjoD18XIhzOzGpuTAQcpOA1LEVEVB/18NaFfyJqMhjwbD7kq94mDRdaPg1jXkRwliFlO3rwq5WCOD+Bet1wT5U+0xElsfyVR5Mjz7RVw0XPYdaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cgZ+WPfp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6059f490so51935977b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222882; x=1756827682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztPWSLd/fv2gLAbi1CrTB5Oy2AFVHvWDSss9wMQrvyM=;
        b=cgZ+WPfpI4M3Kkfa4aqfMFQ/KwAnCIXrv5nzuaBNHWUUpTTk72mIJFd8jrdnb2oCZ5
         GR3oqWLPOn+aUWLCBegzWOozmvwlNt1yWqxfPPGNojqDu+t+UUi9UN17n45kuLBvj8sa
         Bg6EnrRS6U3NlMvZ1qi8zdrJRapYERVSLm8nQQm6Q3YwBbgF/3h4G3hwoxp2JJMjBQDU
         2faKjUy0+v3kluSMZ6Tz4wneAjtob3GeIw+TkHsMvisHvROzyIivgBm3fd3Seu5XSV6H
         l/ZO3s5TddICrlfcAWMAPDlqdZMhKPP29/tHWux5Ag/jyRVVhYLBJsYNF0bVzMAUFBjr
         mNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222882; x=1756827682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztPWSLd/fv2gLAbi1CrTB5Oy2AFVHvWDSss9wMQrvyM=;
        b=wwX3G4zlbusgD2uJv385Z6l7T24zgwwALPfFPUVlmm4rSHLVEKTO1OwCdztO/YBft2
         C+srGWTaKEGGvwUff2AuOQdf87cljdfcQJ7cgyZrps6fbWhNa61QFg02AR1SMbtIrOQ8
         bqhDMDRACVZPr8gle1W0J86XWkhz6zXLQIzplp34OAq/J1BRGtIPwJD2j97zH4rTQjWo
         XQTf9W7ivYjplS0Wek/UIpcJttCFLB0LlE5EWfdoZYis+KrQJo6Tg7FNCQ9JD3s2rfoy
         lGhqCnY0FVbWBbWiCMWkhUeG3IHWJ7HO0KwaeDt+mmIbOnt7su2dtMFJOZ0tReWZU+cL
         QRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6982NB06euS+GaFMvsuJgqmpUf6AgiKxwNM4SyTaBDh3YxARD9WIY2zkLlDlrcSZ7SCRy3A4DVWMiDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNESY+Ss1xYHlPHU9TFW3v0YSs1U5dMFRcWZzExLRlW8MXaH4
	Usg+2R2aO5uh8i1lv0htFOSgZnIKVunXoiTGbfYG6KL3grZxg55bNpukgZ0WcMk4u1tJ+kRrcgS
	aGAnX
X-Gm-Gg: ASbGnct/7ljms43pnNJZAdDejjmTmhuW24/nH+he5yGmcc0H2kexpTNkLM8wKSTFzXf
	moj0C1jLpxJ+4X/h7+jt3s8jjUKkI2oM2OrdYGHiOOYXY0ETRvARfIFx1on5zNVZy4nXMuvyPtw
	oHrN8hF3ReEGwLsvHSpNoBswqKBI2INKhLyBQLycSOBNsN73QN25ZS1u0nejsxedme5M7zuWbNa
	h4wk76s7IXont76ql6NY02UUs2mjVLHQ+gOb5NegzLfjScq7Ttv5kwBCKUKVQpA+pVWHLW67bPm
	qsH/I0nZJNXtZJtEi/A2DkIm3sR0P52BKFyaOon35XXXU6wGQ1Nm1j6/eNEcdwPGnXJT6urS0YC
	7/dv8xAsh2lN1VR3jQoM/tCEWnmPlxD8tm1nfW2xe+Eo/XgJVp7J7LrfPFMs=
X-Google-Smtp-Source: AGHT+IE5HfBgaZtQg7EWsjuGFR90F74YgLUsiDuiUNC3+F5T77VsrLUt9s0jokIyCRGLct+kt7pEOg==
X-Received: by 2002:a05:690c:9a11:b0:71f:b944:1011 with SMTP id 00721157ae682-71fdc43b185mr173144997b3.44.1756222881814;
        Tue, 26 Aug 2025 08:41:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18ee79esm25042627b3.73.2025.08.26.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 23/54] fs: use refcount_inc_not_zero in igrab
Date: Tue, 26 Aug 2025 11:39:23 -0400
Message-ID: <d40a41e428c07f88ea011fbf191bd8efac94c523.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to use igrab everywhere we want to acquire a live inode.
Update it to do a refcount_inc_not_zero on the i_count, and if
successful grab an reference to i_obj_count. Add a comment explaining
why we do this and the safety.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c         | 26 +++++++++++++-------------
 include/linux/fs.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0be1c137bf1e..66402786cf8f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1632,20 +1632,20 @@ EXPORT_SYMBOL(iunique);
 
 struct inode *igrab(struct inode *inode)
 {
+	lockdep_assert_not_held(&inode->i_lock);
+
+	inode = inode_tryget(inode);
+	if (!inode)
+		return NULL;
+
+	/*
+	 * If this inode is on the LRU, take it off so that we can re-run the
+	 * LRU logic on the next iput().
+	 */
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
-		__iget(inode);
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
-	} else {
-		spin_unlock(&inode->i_lock);
-		/*
-		 * Handle the case where s_op->clear_inode is not been
-		 * called yet, and somebody is calling igrab
-		 * while the inode is getting freed.
-		 */
-		inode = NULL;
-	}
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+
 	return inode;
 }
 EXPORT_SYMBOL(igrab);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fc23e37ca250..b13d057ad0d7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3393,6 +3393,36 @@ static inline unsigned int iobj_count_read(const struct inode *inode)
 	return refcount_read(&inode->i_obj_count);
 }
 
+static inline struct inode *inode_tryget(struct inode *inode)
+{
+	/*
+	 * We are using inode_tryget() because we're interested in getting a
+	 * live reference to the inode, which is ->i_count. Normally we would
+	 * grab i_obj_count first, as it is the higher priority reference.
+	 * However we're only interested in making sure we have a live inode,
+	 * and we know that if we get a reference for i_count then we can safely
+	 * acquire i_obj_count because we always drop i_obj_count after dropping
+	 * an i_count reference.
+	 *
+	 * This is meant to be used either in a place where we have an existing
+	 * i_obj_count reference on the inode, or under rcu_read_lock() so we
+	 * know we're safe in accessing this inode still.
+	 */
+	VFS_WARN_ON_ONCE(!iobj_count_read(inode) && !rcu_read_lock_held());
+
+	if (refcount_inc_not_zero(&inode->i_count)) {
+		iobj_get(inode);
+		return inode;
+	}
+
+	/*
+	 * If we failed to increment the reference count, then the
+	 * inode is being freed or has been freed.  We return NULL
+	 * in this case.
+	 */
+	return NULL;
+}
+
 /*
  * inode->i_lock must be held
  */
-- 
2.49.0


