Return-Path: <linux-btrfs+bounces-15544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2197EB09874
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 01:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30C84A22EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 23:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A089258CF8;
	Thu, 17 Jul 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/RbZYV/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AB235072
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795903; cv=none; b=lxiZE1SW4A0YE1pjuwrYRoSo5uiJbLTwt5ODTndrmFL0e9Rzs7r6kaHfjy5xsM2WtY27byhYT+qzeSrDnprGSBFudYEFiEubkFlvOJHJot70Il5EW74JsWed46zNGik4cha7is2h0US1QFbYxLQmpB8+ijoryYnAc3l3kJb/vRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795903; c=relaxed/simple;
	bh=Qk8wBX8DO4PmCKwQn9l0ZZoJ9qrUFdkEC/fVFHt0u/0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WizuFCKUkDitxkX5yuQd7G1zRU35ilcUoJWQYexWpucnF+S17rgDwaICwJecEjDqqW4SqKcOIqAA6Ty+YDqMuL/Nfhey1W8dvEscZq7HW64O+onRJYd+f17kpas1TdlNb1ZmKSlZokTCsTUiYXNFgncSyrdd4P1x0rTqBiXL6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/RbZYV/; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7184015180fso17701947b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752795901; x=1753400701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sn/XKtLZ1/gHuCLdzwxi5LoQz0WZX1tb5nz6C4/sBg=;
        b=M/RbZYV/rym6rtM/rrjhjNZQ5EVaa1S8xtRxIm5e7oPheqW/s4Ov14nEyIxOgq0NP4
         T32TeKXDKa88R1Zq6w+UXvRTNzWGCvTrF9ClPjXWTxNTMSaxbV9YMOAy0H48iSkNfskl
         T6TS2vufgvWQmFml1pCuom1gmCE2NImNah2DXYntBu4bNdA/Y0JQb6M+UcP/XblpyYjU
         u6lMI4mFI1WhQs5WQ/gu28hBXhWqPSvRpi3oSHwdJ+sFoeyrMsyHT5LPAFW2fHQ4d4oo
         yCiyzB2Vk250IbF11c6kEvnDfCk6iiiRr/vBShHZlHZuXfBbVEewJFW1/8zo0z5tzbzc
         DMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752795901; x=1753400701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sn/XKtLZ1/gHuCLdzwxi5LoQz0WZX1tb5nz6C4/sBg=;
        b=BTkc2pgW0l/IkZRuHlnt/Q+NTbeJNQDysgL4+rG6iKmQwQ1KrdxdAYq9DJnbdPAam6
         5b+T+Md06pkradUz0F+c9k40Tj2gHNrrFH4nP03m+3hMWhEIDDM4AwZM0am7JZL6ZJ41
         550ol8n+c0no6zYUQ098c+W9tb5tAQVr8sUwfq9GZ8WGy1RpS1mIEPjUvHLfntpf6HKb
         iYud4h2rrlkSsUT6bdJQkVQpM24BT0Vb3GI3E0RESg2QkZM0tcmSkMaGdGPkzN7FHGFt
         wZNjeh3UJ23OuX+kwCZ+b/DV5+r4A33R7/iUh5H9NXiLw6r/8yzzx+sJ3hcoeJmneTM7
         FS/w==
X-Gm-Message-State: AOJu0YzbhK7ehd+RGjny/bxZlV92pA02i3XtaCaV/rqj2rYQGhd2dyyX
	zqLS+gn/v7GvnRFjCp5PGRYnu8rN4aWLwzMd4+GaDLpuIs+z/nFSKjiLaTc2H34v
X-Gm-Gg: ASbGnctXNvQeqfW0XiSeEtKMDYB36E5qs6AIAkq45IPT+MSaRDy1Zbamrf755fW11Ho
	vz8P0bOgBcyPWwdtZt14z31QfgU8VfdJWLdN2KLwNeJvV0X4nDSvfNebJOSStJXFVe81ZMTa/3t
	sO95uqU4UGdJhq+EJXmbQRa2K0/51ngMVELamPSK7LFaKIv78Yxdw1o+2DSsbx5/WoG8nE440IV
	HD0H55+XbQmDIAqppy+g9gR5zaT8nDdINCjf7QT8FiisTh8+mudqdbp2Nh9g0MA5kjuuMwi5HGi
	rJ1fMCvBBmrP61g5Sb/Z8TbUX1YXaZG27Uo3vWUf0w8c4uVQ4rVjEjlIW6ad8/MKsmRNDscwtzF
	6k/ktX026npRaFo5XwQ==
X-Google-Smtp-Source: AGHT+IFlfcKgFAs87ugRxZDmo+hTWM0bmcl1+b3g0T98K3fbvcSxAWhDD7IkodvesA6y6dwYRkaKXw==
X-Received: by 2002:a05:690c:6f0b:b0:717:c1dc:455b with SMTP id 00721157ae682-71837518962mr119394967b3.31.1752795900870;
        Thu, 17 Jul 2025 16:45:00 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195330617bsm666597b3.78.2025.07.17.16.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:45:00 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix subpage deadlock
Date: Thu, 17 Jul 2025 16:44:57 -0700
Message-ID: <52e3db9d6f775370d963eb5179e3cbfa1ace5e04.1752795616.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a deadlock happening in `try_release_subpage_extent_buffer`
because the irq-safe xarray spin lock `fs_info->buffer_tree` is being
acquired before the irq-unsafe `eb->refs_lock`.

This leads to the potential race:

```
// T1					// T2
xa_lock_irq(&fs_info->buffer_tree)
					spin_lock(&eb->refs_lock)
					// interrupt
					xa_lock_irq(&fs_info->buffer_tree)
spin_lock(&eb->refs_lock)
```

https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:text=Multi%2Dlock%20dependency%20rules%3A

I believe that in this case a spin lock is not needed and we can get
away with `rcu_read_lock`. There is already some precedence for this
with `find_extent_buffer_nolock`, which loads an extent buffer from
the xarray with only `rcu_read_lock`.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/extent_io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6192e1f58860..060e509cfb18 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/rcupdate.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/bio.h>
@@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
 	int ret;
 
-	xa_lock_irq(&fs_info->buffer_tree);
+	rcu_read_lock();
 	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
 		/*
 		 * The same as try_release_extent_buffer(), to ensure the eb
 		 * won't disappear out from under us.
 		 */
 		spin_lock(&eb->refs_lock);
+		rcu_read_unlock();
+
 		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
+			rcu_read_lock();
 			continue;
 		}
 
@@ -4359,11 +4363,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		 * check the folio private at the end.  And
 		 * release_extent_buffer() will release the refs_lock.
 		 */
-		xa_unlock_irq(&fs_info->buffer_tree);
 		release_extent_buffer(eb);
-		xa_lock_irq(&fs_info->buffer_tree);
+		rcu_read_lock();
 	}
-	xa_unlock_irq(&fs_info->buffer_tree);
+	rcu_read_unlock();
 
 	/*
 	 * Finally to check if we have cleared folio private, as if we have
@@ -4376,7 +4379,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		ret = 0;
 	spin_unlock(&folio->mapping->i_private_lock);
 	return ret;
-
 }
 
 int try_release_extent_buffer(struct folio *folio)
-- 
2.47.1


