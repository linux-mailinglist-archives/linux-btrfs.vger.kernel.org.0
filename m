Return-Path: <linux-btrfs+bounces-18007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7BBEE0C5
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06979189B6A4
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147A29DB6A;
	Sun, 19 Oct 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaLYBw7c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7042050
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863147; cv=none; b=BBjkX8Ejh06aw9KiG56/1unPYXSvSA7Vzj997enldhmOYImKmeUGY25uOC5XzpE6gjgVQ+oN0Fh0wYnCxBBg4O9FoMGylxJ1lVgv0VgBsIH/GCuC5f+hV6HvrixD28+zJrNszma62fOpLf5JqEshfKjgaOVJT1i81eM3eQ93EEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863147; c=relaxed/simple;
	bh=mEnjwgJfQJ0O71tpE2SqslOlsardtAe/nQ4bMnmTnKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j+7ijyQrpCADNDdKImfqjP3erhGPyZiHCAYfv23T/Fw2ScD7W53wytXpf5iemKmt90pzRDHWRoJreDt5En+LtAcXd6qjUppQJPkcz35HLIW+VfecKv22RIKFeGzCAmn2eCasQOHhZzBKtEfZ4LLdD0qW1aOeKLUQ/i+o59fMqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaLYBw7c; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so685324b3a.0
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760863145; x=1761467945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1O1qFjTaYa3YKr1wUK2qwfX5whhrXvdDystRg7bIkb8=;
        b=HaLYBw7cU+RhWFf5SNkDBftCG9/fuvcdi14+vf7N1LUrVwhlqar8jpS2e8a94p/8AE
         UP2uy4OYnm3wWYtaVTbV0Q/nMxMXEQsljLxZ94Osl5fqkoUSu9CiEnlDUToTb7xUSVEl
         NYhiAtwV56ExkcInE4b88KmzkG/+GjW9ZjWMZ95WucAlFKmKsp+xZJCNf8SthMrYj+b/
         uAe9c5iCQWNqKqc7uetsu0skll3nfbvfCnipNH0K297ESd5a78tn7rHbsI9U1JeCgpNk
         xL1kMcoPoestGvHMGK5WQnleRcelfzArCeXNg1unLctdkbu4ZvlrdjKsjXIQQgEzxK6U
         I4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760863145; x=1761467945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O1qFjTaYa3YKr1wUK2qwfX5whhrXvdDystRg7bIkb8=;
        b=ssKqcgqLT8Y/kDsIMdqsxSmuvgvn81RspXcaEGdzOJ/BbhqMTaGH0cbVWuBdApEv0H
         SKGMzCt4wYKSIjZcD3lUMMXcwk005Z0czmkCYz/Dcg6VWbLYawhVSuhFNXjgIngQYJoN
         ka1tAPpzBj4xpdxXSOv15p8CszavL3vQxH9FIxAUNTCaHUQiSdravGuWUA328EUWzhIX
         dMvic2ItB5Uns5umhyEhA+iJWewnBtPAgnMAcXWoGkDWlt0wU9cawLkLYhc9uIID6Bpm
         9DVnH801HAY3Ccy4pD+wdbEI7fqqSzgeIBzIxzvLlk8F5XUbOvUuDmktvkV8bDEPwv44
         ObtA==
X-Gm-Message-State: AOJu0YzydB/S7znrOusg7qnoKLyM9X6KYThS5cTOB08alBSs2e4hG1YK
	JLXFTXF5UTxz9MsNhvkBTAiz9c/ylmSbvpQ3XjCNV4oJqBWKJ3MSw0Iz
X-Gm-Gg: ASbGncs9YPjIK7GI4sZ+ksFzOBWJQdEcmzeOiUoaEPMTL3FVzdpyK8HfUUHtM72PKxQ
	K8PKohFxlyi9gC3O7NWvhBLZPXwQGZZvN1e3JbnrJfyWJ6hi6snkVv9RBdhechmnRRSbx2QABby
	ty90Yg7E1EnBuzXQAySyE2fywne+dW/ioXdz5q7TvrhawNBq5MPm7b79a+r3sYMrIsRbBnr8WeS
	bc89GvCE9bRkpXyWegN3m9N+QqIsIiAC3IddaW5h3ggMEQ5uwvNcElXCt4ZyFOIXr5ecJsawAGJ
	cGMP7Eh/Po9bFvEkt4XLiFED6LGdj31ddmMjfJ1BZmuDtBpq6oUUGY+8ye8Wo/9hPNqTCmv7NzG
	4ext2Kw+RIZf99Fhw7FaN5NnuFVx7d/aIIv7+c28iQ4ZYtGsIB4UsdAk5Z5haMRM8aRYDVwhDTL
	bIN203BfMXRARSlvTX6w==
X-Google-Smtp-Source: AGHT+IG0nj3JfGbvrdQsQygdR1y3JLnopGBbMcwuKfE0iF7oNqWVFfy3kIP6nViup8Myx5gaNy6aHg==
X-Received: by 2002:aa7:8096:0:b0:7a2:218c:962d with SMTP id d2e1a72fcca58-7a2218c974fmr7021815b3a.3.1760863145378;
        Sun, 19 Oct 2025 01:39:05 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230122380sm4864516b3a.77.2025.10.19.01.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 01:39:04 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] btrfs: initialize folios to NULL in compress_file_range()
Date: Sun, 19 Oct 2025 08:36:47 +0000
Message-Id: <20251019083647.2096733-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'folios' may be used uninitialized when jumping to cleanup
labels, triggering the following clang warning:

  fs/btrfs/inode.c:874:6: warning: variable 'folios' is used uninitialized
  whenever 'if' condition is true

Initialize 'folios' to NULL to ensure the cleanup path is safe and to
silence the compiler warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510171743.VQ6yA0Uu-lkp@intel.com/
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d726bcdacf6b..54903e17338f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -862,7 +862,7 @@ static void compress_file_range(struct btrfs_work *work)
 	u64 actual_end;
 	u64 i_size;
 	int ret = 0;
-	struct folio **folios;
+	struct folio **folios = NULL;
 	unsigned long nr_folios;
 	unsigned long total_compressed = 0;
 	unsigned long total_in = 0;
-- 
2.34.1


