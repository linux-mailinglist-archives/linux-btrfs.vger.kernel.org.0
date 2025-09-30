Return-Path: <linux-btrfs+bounces-17289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB0BAC678
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 12:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220AE1C19F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5772F60A6;
	Tue, 30 Sep 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihZ/ygVd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB914217659
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226711; cv=none; b=Vy2L1siq640ljsejwM72ZqIiXLGzoEH84DPNKQMzouVErVQ3Ecl3DpT3L+QXD0WsD+bE/M6gA4J5GJFApJWbHmVIcf/U7U0J0vbdcS/mRxvdcyuH9Dve6lo6eUVL/9GqdtZ1e5cWTcOQV6gKX1BmamNGCJ1MXuTXGvDL2iIvlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226711; c=relaxed/simple;
	bh=X9juzzfORJjmVkVgJzjLoShWeYViK7aCq/qnOB2dWjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6qEEZcTU2xKPFDpOST77QxNmeDQcsrI1EWvjQgQvw1q2lLlJA7d9Nzj+QvlyLQb2tE/KkAnMqwCDcDwiA5NgRki7fflTl7lnWqCBXvInr2bMw+7AeGclml2mEoalhEll2AN4IHWJe0dQ8dlKYTd2zx2PoYkibqW1b4SOYKcSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihZ/ygVd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0ce15fso3349025e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759226708; x=1759831508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoqmnjzpIbUw9OO6iTSJNLFiIVbBFRgd5p6mNVJqWNE=;
        b=ihZ/ygVdp8YuZD7ILB2uvEe1X7ZTFimxLrZximf2HL+O4V11FXw7LPENr1jcKdeVzJ
         kdY+++CK90tvoNHAmK/tkgCAsIlvYP+uiRcx+ET2bc7zWfPzphX70dxJS8/TRfXqCQnv
         qfZpu5n0ZkNBfGqUNT71ds45NiRmZm80YNO36qw1dxhaDYL03wjA3kOV5+3e/cPWc37v
         ai72UaO0k4G0lp5ObtvrXlJ0vVGwCS2/OQQF+LnrIYa+lOqg70mN+aywE7dHToTdsGOq
         t4a5dOn4kdn5AIEsAuOSNBHhl3O6lFjHMuRSFB6QXD15cBccDhEfXPoOiRRadgEUxEW+
         /Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226708; x=1759831508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoqmnjzpIbUw9OO6iTSJNLFiIVbBFRgd5p6mNVJqWNE=;
        b=ELwzDea12wQz34oUFixOMOEX17KV/1HDvGeVzsHocgljEBqTSXe4xkjSjLmWsjIsEU
         RwZyx0VfDoTJNZoaQD1YFWAPi7aCef5ijGE86/CvEypRN2uyCKvdYr1LB/KXc8KJ1BWk
         BuM8IWSYZVJ2gCa3ci6WGyfq4aLjfq5ikclnJTdMM5ybU5tq8I/8G1eG5au9mLh4vI7S
         UOsF6DasD6I9jleYW4ZYIsE7lEWpPFRKN3tJaboYizE6i/otKy22Gv6bC+qyLJvEbmSG
         3FYKmJKph+8NgpKl3ZZRdRIU212ib4URD9GAPXyvPlAGoCuajNQiA2gL3ZuZrinqtQ5w
         kFBw==
X-Gm-Message-State: AOJu0YzqeiXKqrbjFsqI88mT4T8JpBVhwOgt3B0s57/rWxLlu6MwFeOv
	Z3T6NLDUGyYSKJ2QZsEdy0SH2GGvEKhsXu3nfjtHrtvzpKpQzPS0NEwU
X-Gm-Gg: ASbGncuoAdzkFnErnAt8mdIH4xlSX1ZUOVXXrkWKdHSePDK1uZm49KfxefLbHmMs2Ay
	9KgpzmwpnhAfov1QK0qAfaGjUtxDU1THzx2hKITlgJsjTcc3WATZhdOuXlILOY+xTLs2VRhH4MW
	VcmHLCXXU1nT5hesL/r0ie3lGwgz+YcMwqyyQTdgZCr/pAjn3sBfbwhVk7bK//cOxB2gGZ9oVGv
	P7JoqJxUghfbkHdr6zp5xJ4EOfqTwJjetOlAhj0zNS4sgWgJ8OoW+rP/7oEAP0r+nGhKbU672o9
	3NcyRPaO8TxSToD9G52J4oRKRXfRiufxcIUtpFa8w9N5HbR3OmJa221zEIFF994wjFzBO8zPgcJ
	zImWpQONHkEW9Hec+vDDkep6pSC6ufwfuFUOLVaPgzKLOC92dWnL0HSPFdQKcH9QN
X-Google-Smtp-Source: AGHT+IHR/hbTJBXGa5MRxuyi8MdBLzgo/Zj0q4wKBPTP845/xVxCCZl9+I5DcBEVzfMW11gF3Ur3Kg==
X-Received: by 2002:a05:600c:1f0e:b0:46e:5cb5:8ca2 with SMTP id 5b1f17b1804b1-46e5cb59fe3mr7885995e9.2.1759226707885;
        Tue, 30 Sep 2025 03:05:07 -0700 (PDT)
Received: from bhk.router ([102.171.36.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-410f2007372sm21238137f8f.16.2025.09.30.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:05:07 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v2] btrfs: Refactor allocation size calculation in kzalloc()
Date: Tue, 30 Sep 2025 11:03:44 +0100
Message-ID: <20250930100508.120194-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap allocation size calculation in struct_size() to 
avoid potential overflows.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes since v1:

-Use of struct_size() instead of size_add() and size_mul()
Link:https://lore.kernel.org/linux-btrfs/342929a3-ac5f-4953-a763-b81c60e66554@gmail.com/T/#mbe2932fec1a56e7db21bc8a3d1f1271a2c1422d7

 fs/btrfs/volumes.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6e3efd6f602..d349d0b180ac 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6076,12 +6076,7 @@ struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_io_context *bioc;
 
-	bioc = kzalloc(
-		 /* The size of btrfs_io_context */
-		sizeof(struct btrfs_io_context) +
-		/* Plus the variable array for the stripes */
-		sizeof(struct btrfs_io_stripe) * (total_stripes),
-		GFP_NOFS);
+	bioc = kzalloc(struct_size(bioc, stripes, total_stripes), GFP_NOFS);
 
 	if (!bioc)
 		return NULL;
-- 
2.51.0


