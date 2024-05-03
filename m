Return-Path: <linux-btrfs+bounces-4719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D28BAA04
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A836FB211CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05D14F9F0;
	Fri,  3 May 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQDlFno/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697714BFBF;
	Fri,  3 May 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729251; cv=none; b=X4zPpeLTQ+cfd6n9IIy3E1bQuHXJYHPQJl7Yv03g/NjAisQgdZ/KKxWxB1p82/zLcmWMmFL+8wahRLVwYpDkZ+tzpCsX/fxI6hTi5Eab5PVE+Fqpul+ox3TzUhH1xgO+gi+zBHahg32lf5Fdy4N2gKOJiOaNXxN3IvsMkk6QDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729251; c=relaxed/simple;
	bh=39A8OWlUv3UHFjQvm5veN9ZOLUCUQiJrOOD153SpmyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GE/d//afzv26eSvUMF7eJSxWJtuCZ6/CltunBH3mb4ZsoG0vLXlF1+smD0GwJFLHoNtHGOBv0JPysQYQckHdA3QP8OyrRRU/ds1OS00meIHPwkKPTBCRMuKkPPKBiXAebgvtXyMmvfDe43xFV+ZlTGwU4bvol23twHvMaagMSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQDlFno/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f174e316eso1944918e87.0;
        Fri, 03 May 2024 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714729248; x=1715334048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9gO1v4sXfXdAITvo0BN7gOXupM7E3E+qa7nXDHVYeI=;
        b=cQDlFno/TX6BZuiftdQM7AQb2g87c1a+46b0ArciDE9O7xkuTXmkbzf/yW3Qcy059c
         OWLYdItV4MZKe5nIh3iU0AviS6zz259iA+QVgxGHJl5r/Sr8s3DCpiXBiVoDDTJS34Ci
         lJTqqu0f8o3IVby6VR4vDr/jOMCo1KuuJ+79BYGf9y85jJ0wGCU22MCrb/8GgAFELSI7
         svgb1yfCmxBURheHByeZp9ZDm9m+UOvy/4TKaYg1ITmQfqgsNL5rzR4c6df6fHcBwb9k
         ZvrlOaMSqzT1OlnJZdnQqmKm2QihWxL24X1NnAyUMpEcnWfVBQn7rAmYBlXTiBVMKmWA
         AxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729248; x=1715334048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9gO1v4sXfXdAITvo0BN7gOXupM7E3E+qa7nXDHVYeI=;
        b=S2M4EigGlI6XzzF3TiGl8xo85gynYr577ZEP6y9tpgKqIxvgEmRxAmy8JAnUTVJMJF
         c95fCnB9i91XVlgrhh9uOkUtTMFn1tZ0Y7outUfJW6+T3+eaYfpugbydB0/K60GLjIBr
         uwWb2nq1gtxz528s5vIhVNpMI7CeemG/EOCEG3SkMTKgp1Owzh/PItR/E+SmhZ45MHHp
         kRNHbN3ie4/oOz/4cCeD1B6oLIFDGl3xttdtikSo2RtmKr8BxE+mL7j2ngFWpsEunhEH
         szP0jNbM5tbc8Mz4DiKQd7N3mX04Y624QqeTtgWdrEBGMHcxyAiXFg8Diw9rIVeDHAhJ
         iJZA==
X-Forwarded-Encrypted: i=1; AJvYcCXKRrUTeAKoLxel5KWPCFFAi3qcFE0s0ILOROMyW0iT518x9L/tx9KGJJNyvkY1nvSfKIOZD/ZFrEEz6ZKIscT8XiwN1nYAVHIsEj4hIh4Hm58UNf2BUbBQzjkQbpwBsRcMcJF9OJMNzsI=
X-Gm-Message-State: AOJu0Yy8ybGOt5zJdednbYxD+gDuOOhBjesMwk5LkFqdP7w8Za6GOE81
	BsguiMiTEWRcnyo2Nf6sXkXxPq0KGY/i/MTUtmsZpIL3BDp1kX4O
X-Google-Smtp-Source: AGHT+IGEMJv3fOcAWHTovUp3S5CuQ55ZULKUeY4/+3V4Dqn+tcro3oKC6xYCBsyM8UR7dEUmI4dU5w==
X-Received: by 2002:ac2:4e83:0:b0:51f:4dba:d331 with SMTP id o3-20020ac24e83000000b0051f4dbad331mr1258629lfr.67.1714729247323;
        Fri, 03 May 2024 02:40:47 -0700 (PDT)
Received: from localhost (host81-157-180-37.range81-157.btcentralplus.com. [81.157.180.37])
        by smtp.gmail.com with ESMTPSA id bf9-20020a0560001cc900b00341b451a31asm3327791wrb.36.2024.05.03.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:40:46 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: Fix spelling mistake "decompresssed" -> "decompressed"
Date: Fri,  3 May 2024 10:40:40 +0100
Message-Id: <20240503094040.2712326-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a btrfs_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 518d05b00a20..d7e5f681bc32 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -435,7 +435,7 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
 
 		btrfs_err(inode->root->fs_info,
-"zlib decompression failed, error %d root %llu inode %llu offset %llu decompresssed %lu expected %zu",
+"zlib decompression failed, error %d root %llu inode %llu offset %llu decompressed %lu expected %zu",
 			  ret, inode->root->root_key.objectid, btrfs_ino(inode),
 			  page_offset(dest_page), to_copy, destlen);
 		ret = -EIO;
-- 
2.39.2


