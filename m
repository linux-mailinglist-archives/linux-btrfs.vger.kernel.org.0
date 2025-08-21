Return-Path: <linux-btrfs+bounces-16194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54807B2FA21
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 15:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B8A680958
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3633473C;
	Thu, 21 Aug 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agu9pdZG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF8334710
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782194; cv=none; b=a8cBTglD9Bj2CQTeDHNN3AL1cgwt/6DXbnqveLvQjvLlfgIiVJuAbF1JEnMj86Mkvjuvb6sYnnVDiIRIGQxCmfDvnSLBbl+7bUlVzsC5ofVry/EHen4KUc1PBxAXCfIwHOuoI8PUy0LDzYWXDJhiEhEbaWcyN6KZvTPSb9ngAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782194; c=relaxed/simple;
	bh=Q4HurMI1czs8auFPq+sUThWpc8/g5y/4mXMaQF4DJ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hv83w5TGZJCQKkVt3YC/l+Cn19lPjztLBct51zs0eind4soz4HquBiPaFR2Qmu62SM6Dq9Y4grmVOU4v/EKwnYIerumbm2kyeVDMsT9WK1r8ajp6dpqoc3cwy4tI9CkYkf6XzUeq6Rvx9FPCZYcNBR/RypigfiwpoUkAMYOxYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Agu9pdZG; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-24602f6d8b6so1150055ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755782192; x=1756386992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU1YpawE4qaHhKI/eXASETqXxlEw6Ls65OGJNR/ZrMM=;
        b=Agu9pdZG/8bp12J08IHTLBQNyJIiikdqfybG+gvFVSFdxBQbFdv+HlJqTdUvev6SKF
         wtiiIQFKYqj2MYKtRznPBJTfG15ySwlYI43a3R8GBHq6WZayzSSkF1mSBB5S4baicx0Y
         GnLnrhbYGDu/JOjz0d64YC6UL/F/snBFhkNKee8s5juqV8RbL/JCs6xYIVfUPr67GBpN
         y40i97ebX9zO9nk00FWRm6jv5KLH5hdo6zrBdyFa2E+HQmpOR3Mw+3KFoyTN7cNsK3gN
         WyYX8iKZPwkb8MnMTc2ghXx8LaRRQZIhAUZcNSY8Np2Xa+4lX9/Uf4L1K5MpYeXw8Fj/
         +T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782192; x=1756386992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU1YpawE4qaHhKI/eXASETqXxlEw6Ls65OGJNR/ZrMM=;
        b=eKHuUCkhn3o2E1JURA6xL4TjxhgYRS4bgeY7JF2m7UjnOPDIeU5nxLxdQV48VpcCed
         +5QfJygGUGpV7UTtHgNRscQ4aR+0XMY+h9mdrB1bJHXMpB3fj/Yg6vvHhWrnPBKidCna
         qEhXSL9olWAbxq3TL1yfRnpExYNuPaw/OPYkNH+mK1dlAPeLZkktuQbSc03nAdzZguvK
         uTa5ZRCN8MHc9s5ab6Ye4Lqc5ytR7fZk57bDDZPQe5kkSDCrMV6kbZQSN+77O1U63OMH
         0kY6FaS6lOLMcgd2JbFe/bGdfcFro03xbARcvK5V10m+KWS2QfJrGIi5hz5k618q5ufs
         EIUA==
X-Gm-Message-State: AOJu0Ywz4WJNhzru/42VzyT1K7IsocZDaBkYzrQwvn+PccEhTzhRrKY2
	MQCp4VrOI+AZEY0nVVLciIWcJNnJmzsD+Ty8x7TA0PHXTPJ9XByr/AaGK2OJmkllz2sxeg==
X-Gm-Gg: ASbGncugKViGKMsc+V2TjJC7hronpAubhEms/hUBc0j9NSgyFAV0P8lWYwogj+Ig16m
	oXdibwsBXCC+QFe3sOvMLK2hjcf8+rkajaNXdTy9bvuDe/zvnTgC66/hzFrvp8donKW1r9xEPTZ
	2JdNOxS9P4TrbfiT+k45eKQ+n2Et0ptFE0OzQiKwjv+1zsvCUVowNJlQGoE0h3lLcj0ut+l5Z5m
	2ZIAlEXOEGba8wCmAcbHLd+FcWdlYHjbrBwnlH8QE+gfSQ28bUSV15KI/jXEVI6EXo5wO+E2ggS
	KsPdBpOV2Vua/wBNrZVAGGYBe5ShiqtQiid5VgrR5UacFWM0Zyv973Iq7Iug8UWd/BK8S2uyFx8
	VMzYlof18Lu+ysUoCUVVXKLakx8au9dTGSdACCAlJMkNp9A==
X-Google-Smtp-Source: AGHT+IHaVMdfI/eWUyXtAhKnmGoSutxP3U4N0pbD1jGj0FVIGD3T3e/nCHjP7mibrXKLnshJRNlrdA==
X-Received: by 2002:a17:902:e80c:b0:235:737:7a8 with SMTP id d9443c01a7336-245febef0a9mr20181085ad.3.1755782192003;
        Thu, 21 Aug 2025 06:16:32 -0700 (PDT)
Received: from SaltyKitkat ([2602:fa4f:a30:6b83:f365:7bd1:5b7a:f317])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33df68sm55884335ad.21.2025.08.21.06.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:16:31 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/2] btrfs: get_inode_info(): check NULL info parameter early
Date: Thu, 21 Aug 2025 21:12:23 +0800
Message-ID: <20250821131557.5185-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821131557.5185-1-sunk67188@gmail.com>
References: <20250821131557.5185-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the NULL pointer check for the @info parameter to the beginning
of get_inode_info() function to avoid unnecessary operations when no
output is required.

This change provides two benefits:
1. Avoids allocating path and performing tree lookups when @info is NULL
2. Simplifies the control flow by eliminating the redundant check
   before writing output

The functional behavior remains unchanged except for the performance
improvement when called with NULL info parameter.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7664025a5af4..5010d17878f9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -913,6 +913,9 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
 	struct btrfs_inode_item *ii;
 	struct btrfs_key key;
 
+	if (!info)
+		return 0;
+
 	path = alloc_path_for_send();
 	if (!path)
 		return -ENOMEM;
@@ -927,9 +930,6 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
 		goto out;
 	}
 
-	if (!info)
-		goto out;
-
 	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			struct btrfs_inode_item);
 	info->size = btrfs_inode_size(path->nodes[0], ii);
-- 
2.50.1


