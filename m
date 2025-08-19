Return-Path: <linux-btrfs+bounces-16158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD2B2C2A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 14:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2071F3BAE82
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4AE32C339;
	Tue, 19 Aug 2025 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQpYsHJQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA732C33D;
	Tue, 19 Aug 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604945; cv=none; b=dpKOGt7efmYsdaAIPUsz6yF+reDk5O8wssDjADz2y/HeXRMbHr0ELAet6lZQsA0CbokYOkpUe+vTVjJ9VRqAvaNMxa6lbfQcqZMuO6eyXotBznJVUWp/HHYs1hI9xVCZkzC0HexDCrGavaptrpMF1dVmjb0GBhOyEg0Q7gPyyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604945; c=relaxed/simple;
	bh=na6fPEIXs9/sGeqcja3uFEI352Rn9PcidjlBf6SoK6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3R02B/Hm2ZJnHqzzbuv+YwYJqXWNrZIed1AiRrYwptUc+YzcW2CopTCLnD6Kw0Jj0Jo+tJcAOjpK86pJji88N2LZqhKMrQ0bXSeOquH2zPHR0gErsiSjNJwuAbfwOLV9ZyFY3q2qM6sen52KJJynijljv/V3HZn2cNmG+wVqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQpYsHJQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e6cbb9956so1499230b3a.0;
        Tue, 19 Aug 2025 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755604943; x=1756209743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRYp+8g1HL98AE48/rhJ/UoPQGve8y3lM261Zv2kpyA=;
        b=HQpYsHJQrB7AiO4t9gC8b/nncCPiGzmbAIqMt4O2CDA3vDk2o5XcplNnHfVytgTKp2
         j5wwyXafxjzsxeN7V+8xXtCkdAev9UTDTGFCGA7x7CL0ZXbqxCElksuiYf/+OJiSEosV
         utJwU6ejl5qW5E5CiM+DfVhlZHDQd4nHfm0oHVTrS82S5eg3FRVU8/13WJwzdTcTc/Ir
         ghL8wAAisQidNMlH5ftmT32StSjYmVrHG8qebL6rE69OXmOFi8Wgbndv/7Q07DV3wD93
         lxBBNkZHCDvgnT3yZ4v5mVq2XIOzWCGK5Aj9BheyZxcXkdc0FciAZEBOcE0J+osvOTBJ
         4lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604943; x=1756209743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRYp+8g1HL98AE48/rhJ/UoPQGve8y3lM261Zv2kpyA=;
        b=uMUf6FkSjGNOAKif7U60aYgXwLNUWBZvRkNYPEZ6oup3hXQimOZspj2OI+jw80DM8T
         CPmkLL/tDXVxm4fAxyIWKC3RNukWPoYaR6m5TBS4jxloDYTX4AMgLvtLBYeihMOm15vR
         niPyn3bFpfbARXGSyX/bhwOaWmJadgrW/KVZ4sBIqrkexO5VHCYWERvITG8b1vCENWue
         mjhR5IGE29mSZyEuy4aNiHlqPOfrUJI8WJHiv50jbbut/9xBDUj9U7DEnKY9Ykf3N3E4
         OJrdC0UQmnJY2Ky9hhTNX6LoCOcD6cdb2+2UywxiciE5LJqdrSNp6ssR8ZHHzxYmfl1i
         S40w==
X-Gm-Message-State: AOJu0Yy7VX6myyRZ3/Y8XM8FuDYW/HwJq8jTSv9nLXGpYCkQt02lFmWD
	xthjW4Eq3Brk6HXCvXKmHZgjPMh/shEVL4XRcIYGNUz6m0X7DnOpqPWrk70fDeyU
X-Gm-Gg: ASbGncuU2OCiurt+HhvKVB6pLKEUa2Qed4d7I8kvH2DJlQDbQOyT6q80x1/tYwV9aGb
	1INh4Cmi7hhfuZfTjBAMacqEDexBzfqo8w/k1qcQslfSmoEz+88Xak6/falP4Exl1zRyHGt0IrA
	FCavAC87SoDiJAIHaUCEovhpQCCSuzoBoVhRQFh07H1AIFmnK2x5Y7lVbBgpFpK+l+HhBQUkHYb
	yCW4I/FjcBp4ohGL4ZqFKmh4cX6VBWSkmJKdVStviQfUp9LdBcFjZcSR6ZJPuJT7kY0JCShMmGG
	iEb1utz4UZqjbvxHsDw7fJyOjqMr4JrzckYw9+3qJG/fQOX+2NRa904X4dLTHy26wYTePtvPEm/
	xzdH1sDM/JsKBrkuoS+NApqCkPA==
X-Google-Smtp-Source: AGHT+IEJ8VQbsLVbwMob19b2CSag4LubLdShVAuGWARanYzIoMStNXxuZIwBPVwT+fe1elvBbdSfPA==
X-Received: by 2002:a05:6a00:2e1d:b0:76b:e1c6:35d6 with SMTP id d2e1a72fcca58-76e80dafe6fmr2828944b3a.0.1755604943045;
        Tue, 19 Aug 2025 05:02:23 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d122ad7sm2331999b3a.36.2025.08.19.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:02:22 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com,
	quwenruo.btrfs@gmx.com
Subject: [PATCH v2 4/4] generic/563: Increase the iosize to to cover for btrfs
Date: Tue, 19 Aug 2025 12:00:36 +0000
Message-Id: <ecdd04bce98bb0d1393289e84cf8913ae10cb222.1755604735.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tested with block size/node size 64K on btrfs, then the test fails
with the folllowing error:
     QA output created by 563
     read/write
     read is in range
    -write is in range
    +write has value of 8855552
    +write is NOT in range 7969177.6 .. 8808038.4
     write -> read/write
    ...
The slight increase in the amount of bytes that are written is because
of the increase in the the nodesize(metadata) and hence it exceeds
the tolerance limit slightly. Fix this by increasing the iosize.
Increasing the iosize increases the tolerance range and covers the
tolerance for btrfs higher node sizes.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/563 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/563 b/tests/generic/563
index 89a71aa4..6cb9ddb0 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -43,7 +43,7 @@ _require_block_device $SCRATCH_DEV
 _require_non_zoned_device ${SCRATCH_DEV}
 
 cgdir=$CGROUP2_PATH
-iosize=$((1024 * 1024 * 8))
+iosize=$((1024 * 1024 * 16))
 
 # Check cgroup read/write charges against expected values. Allow for some
 # tolerance as different filesystems seem to account slightly differently.
-- 
2.34.1


