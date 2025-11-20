Return-Path: <linux-btrfs+bounces-19220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F498C74760
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 15:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4FD24F9714
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B8345CC2;
	Thu, 20 Nov 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2wXxN3o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00523D7DE
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647281; cv=none; b=Q7zgMUWmEqputx+3rdHK2IoemluQ7To5l0noUo0W13wrdKifaNk4/vxMS2sbGlMuhOCrkv9bs7Vo8O100p87ob2jFsD9Hd73Fcc+fMu5pQCBP8AJA49v6Ra1DZgdGFm4T87UqXcQOiIqs0/oo6QLKIh+MthwdId4JWxZyH3JCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647281; c=relaxed/simple;
	bh=g08lwakGHkNs8gOxzepPAMQaVf7NB+R38jWDyL43UPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOqifbvmUq/xprlT6mkgNDlrhTmBqXowv+kCLhtX+Dx09444T7A56uC2x7+mEMGkg25VYP2uxjEXU5Wp6Yi0yzJ1T8IOUjwnpdthxWU4L6NsfEQW5orw3HnrydtQt4o15xk4JxBfbi7oPdqkHyyTV5oRaP6kU+Y+sHJyvaWnopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2wXxN3o; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297f6ccc890so1208585ad.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647279; x=1764252079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbKZqenfJF6u+zC+BvgPgGvC//iVkqiGSHP2rpEd590=;
        b=Q2wXxN3ou3u/KZ5CQspYiqKLX0bvREptVE2PiN0WaYvf3RZs5g0fEMhXqDlzhs79lI
         b8Yi9CKQF4MoXaioAtDsRgem9cRli38vZhnWbm6sRv3M6paiuw3GtX3kKZk1ercpw/UC
         7sIv7uqXSqC+VINLHVIGNkHtAnG2LEID9jAS1x3k83+ULX450YTO5HgCRHK8LDLAcncj
         loNCmRgxC+kZdrXkKs1Sy+bstu7HrJurrKFbOQnYRj7GmxfqU10VBCCAqAsmVDu6ky3L
         jZ0Ta2XsBoymuv7DmLU92zrTeTJ0Lu4X6HalOc1PFj9QV1d3no9twPK2HqahRWZIKhrt
         iYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647279; x=1764252079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbKZqenfJF6u+zC+BvgPgGvC//iVkqiGSHP2rpEd590=;
        b=s3RUNX4QhsI6aflEuJ+MlEand0pgIoZEgZGET7x30t+4fY1+TxU0z3vuvXYl666Vh2
         svfpV0AquEiLXfLfrijF1q9jTcDI/3u86qpIQ1fgLytvDLS6kzUjLjhNavh5BjpE5ICK
         8/Bj7UhMnYt+VuN8KhZXKXzXh+Nt1uC9G9AB8YWnBUG4EftSF3sEN+Ex2Rmg/VkU4Oe5
         bRkOHo/aYpJ21ZkKn/wq+cr1blcQJpH1tZ5Yje4pSVhNuCUudrUXf6tJ13HpGEn6YZ1R
         0Xe+Cb9XgCXoTnVd5UxLpkjMYwKjfRA1E6FMofhOQytfgGst6iwswpIX0k+S5YUzLm02
         3pRw==
X-Gm-Message-State: AOJu0Yy2FbnU6TPVdkRd3sq/JMlUmxpyrebYc3MmoEKBx643VV8F3A98
	A1/Wnnh9KiZhgLEikKjmazjvbx02mF44iuOlRA/9A5XpFNTtT+hkmvs7qEwGF4DjH5s=
X-Gm-Gg: ASbGncts0uVvcAFEbbp5TaW54KOqj7z9j/a/XhifklE98FtEuwf4kf6CN2v9AUq0P14
	QEhRGFL3ItQEW06aU9F6PD8vkNObHcbiSGVyX5sXVm593X3eywkMV0q6zouYe1LC+46bgUeb7f9
	2LliBLgI83BdjrgZF4EVngbTckQFRxuAcKcYOXfq8qdQPJSzrCuWLjWaRcYuJ+rRkY62HtycJag
	eiopNoGN/0pVnZl7gU2oPZOtnPJSvuUr8YwnXGNfUD3UfZg6DTuNGIFloepYs73Hh2RufoGH8YJ
	5vjh7YHIyDbCF2kk73TeWLvv/VxZqEgn7iKFoLvQpWe/tPWTyLkoQG9vpESdJ431wph93I9VySw
	Ax3MOuzRdpMhhI7bCAEoHSCvAhboSCiznAj9/XrjyX1B5ecNgOLp55UdhT4Txy91o3RzC0VdTVs
	5HiR0hwmiWcS4qz5ISJHbdNpaZl3rwAzw=
X-Google-Smtp-Source: AGHT+IGTPOQ/RAeu7QcmKyPbA/a50+GY9+tKtfPCJOdY4lSFd4kw93lSWJ0CAm/i10UVDVO2gVieVg==
X-Received: by 2002:a17:903:19e8:b0:299:bc94:7ded with SMTP id d9443c01a7336-29b5b02633fmr24108505ad.2.1763647278782;
        Thu, 20 Nov 2025 06:01:18 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm28660985ad.35.2025.11.20.06.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:01:17 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/2] btrfs: add comment for btrfs_clear_buffer_dirty
Date: Thu, 20 Nov 2025 21:57:04 +0800
Message-ID: <20251120140030.2770-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120140030.2770-2-sunk67188@gmail.com>
References: <20251120140030.2770-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/extent_io.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 23273d0e6f22..e80066fc0f02 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3678,6 +3678,26 @@ static void btree_clear_folio_dirty_tag(struct folio *folio)
 	xa_unlock_irq(&folio->mapping->i_pages);
 }
 
+/*
+ * btrfs_clear_buffer_dirty - Clear the dirty state of an extent buffer
+ * @trans:	Transaction handle, may be NULL.
+ *		If provided, the buffer must belong to the transaction
+ *		(checked via btrfs_header_generation). If the check failed,
+ *		the function returns immediately.
+ * @eb:		The extent buffer to clean.
+ *
+ * This function clears the dirty flag from @eb and updates all accounting
+ * that depends on it (per-CPU counter of dirty metadata bytes, folio dirty
+ * state, address-space tags).
+ *
+ * Special behaviour in zoned mode:
+ *   When the filesystem is zoned (btrfs_is_zoned) the buffer is *not*
+ *   immediately cleaned. Instead the EXTENT_BUFFER_ZONED_ZEROOUT flag is
+ *   set and the buffer remains conceptually dirty.  The physical zero-out
+ *   required by zoned devices is deferred until btree_csum_one_bio(), which
+ *   preserves write-ordering constraints without forcing callers to re-dirty
+ *   the buffer later.
+ */
 void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *eb)
 {
-- 
2.51.2


