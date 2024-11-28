Return-Path: <linux-btrfs+bounces-9945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339209DB4D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF54CB21BEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31924156F53;
	Thu, 28 Nov 2024 09:34:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B9C2FD
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786486; cv=none; b=XBaM3yDAJI7718Ai73+g+ALQc+lL4xt8ILZa9TMdEXNDkaD0mg/Sttfcc2stkAUpqocQvgF3m8Aqrw6AOMoUQwY7JtTMPUCB7wNaMvc2EsfU4n/Plkg2kRsp04zPnTO962ZlcAogzqh1hrTT+I4qgOR1L7DZaH7DOJZVQU1J6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786486; c=relaxed/simple;
	bh=v8670NlMK9s3f3mejJQRI7cY34okMqc4IBxBz2FjD7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3gnzJ9hUhGwSnEzNehc+bKzzhdIEYawY+8dNeidftT2IBO8VrZ0A5eh8ZGmBhPV8q8ROKsPT+E9Q1S1aeipWLyqAf3lEf2I8HsJD3CyTatQECAkHeqP+1o8CxMn7dcir67QaDzah55brTWnT+6pHdqcm84m2jJ4q/6uERs6c6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so5412765e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 01:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786483; x=1733391283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkutHHFigEdZM0LTGGitG5yzoTIXthL2+5C05xz7ULk=;
        b=LR8nx2QItOFsMmg3XhMt5TY/dkhp2f8gu1/SLnHtZ6YRxsJ/AykulBnnWOtMndE2iY
         HAflI6R+eZEMNNropQC45dlCyQLVhpaykyKtIqxAjD0pLetRA2QuFJjFfq70dxB888bp
         +eTQCqvhB4XxteMg/BNwHEqE905vAhy1V6/fbbOFWww19chKKBPxRE+ucrrkcMPbr4+Z
         vuvqe6ASmnLF/mEJMuvqhZA2gkFGYXWGea0o25r11EvvOzZJEN+Iz4HHuFEhtEjV8Pz2
         3/FdZKr7Kmlmq8080fP5Ut0yEJ7PSnj4SMe3cQse4//i6XVpdq96NYLrmqHZvntcqbDc
         J6sg==
X-Gm-Message-State: AOJu0Yy46q6lqbn5R2J2aS65pa3w4v+dcAHKq2eEObaoCKjVcFj2jZTc
	eHjUMZ03mJPh8uD0jbq1+2o1HPOKUh2LJAHomu3lh8cJL5a05aqmsFFd4A==
X-Gm-Gg: ASbGnct2VLkQ6QhJvX78kQojM6sIVDKyPhLTHZbgUD4i6/0jw5eGl1QHSgLK68Z965+
	Zb5hJ2VAvFKubd/nMGhf7Z6yCkqIseNWgDj++bCiszO0FLY9VdYXE+x7VqwoDJYhdWIGUihlZc6
	r4zvrCtmkUwqRnlBncqhAlBdHxu6IVJ7Ueujy/4y0faTHwzwwXTOW4qcMvP9O4+lMb5F42grg9d
	pTTQp710fDbLPpwQByvdujnEuqTKl1Gt6hYPPeisRg6OhjrTT0C+EXiCAFUgi5agOP3G7DirsLI
	lExBCGON+ZKV9uASwwvbVld00onjyjLC
X-Google-Smtp-Source: AGHT+IGGVe8JbBRZGh2gcUw8a2KdogBTGxRz2NbtSKmCtp/1AetdjRNwPcgLSyJAcDFfdGPno1mUkg==
X-Received: by 2002:a5d:64a7:0:b0:37d:354e:946a with SMTP id ffacd0b85a97d-385c6ee11e7mr5389022f8f.50.1732786483196;
        Thu, 28 Nov 2024 01:34:43 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd92eabsm1145894f8f.111.2024.11.28.01.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:34:42 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: don't BUG_ON() in btrfs_drop_extents()
Date: Thu, 28 Nov 2024 10:34:28 +0100
Message-ID: <20241128093428.21485-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

btrfs_drop_extents() calls BUG_ON() in case the counter of to be deleted
extents is greater than 0 in two code paths. But both of these code paths
can handle errors, so there's no need to crash the kernel, but gracefully
bail out.

For developer builds with CONFIG_BTRFS_ASSERT turned on, ASSERT() that
this conditon is never met.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/file.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fbb753300071..33f0de10df5b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -245,7 +245,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 next_slot:
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			BUG_ON(del_nr > 0);
+			ASSERT(del_nr == 0);
+			if (del_nr > 0) {
+				ret = -EINVAL;
+				break;
+			}
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
 				break;
@@ -321,7 +325,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *  | -------- extent -------- |
 		 */
 		if (args->start > key.offset && args->end < extent_end) {
-			BUG_ON(del_nr > 0);
+			ASSERT(del_nr == 0);
+			if (del_nr > 0) {
+				ret = -EINVAL;
+				break;
+			}
 			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				ret = -EOPNOTSUPP;
 				break;
-- 
2.47.0


