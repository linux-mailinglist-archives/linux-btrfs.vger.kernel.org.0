Return-Path: <linux-btrfs+bounces-17219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79833BA395C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342A9386319
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92C2EB85A;
	Fri, 26 Sep 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="SM155fUx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9627586C
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888852; cv=none; b=rKmhTuYKb3FWCmHNWe/ysvfCyY1L0P6+zshA8F0J66azM03n5Ypv+X6T9o7+tf27PoIFtzUQIBl4YhdVmNTDIxuihkzKvM6X2/PtvIfvuobjERbzXDxZw/UcDWaE9Xj9VOMIT/LEfdR4vu5FZjKoDgyXdNCx9qCvWexQqSkLJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888852; c=relaxed/simple;
	bh=zuuiwy7f+PuMS1Z9RGvXmGOnbxDycWLndHM8VT5CVbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZI/LW8CXsZF/7Z6sNjqmww10qNFL5V0R/RGTTiJ99NhPuGzD16AgR34ejARnnpdJ9Yi2WxdSff1qJSdD79+kmjnRH833Drt1HOUqDu6Cgat1QOUuoqwPgWtcsn76rxSr02Bk5SuBTAfNfL6ePayI8ejTsrE7+ZHDY7u4Ll9MbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=SM155fUx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so1672778f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 05:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1758888849; x=1759493649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxT4Y2WIVPS6x9uIm0wu4RFG6HiZ0zeh0bR1+7IEn20=;
        b=SM155fUx6VprMV417Iskd4d/SxfXjJmelQYwpQRTo/nIYX2EFx0vuJnL036DTDgYey
         U8lLcFwm/Ksbz+U9pS0os0u0MmiR0EE9MJftmdxfZEpsQR3ytpIF0B85V7HUAoDBPjyI
         8fe8kWGlHPd/zIF8wvvRAwkf2u6hvUrEqteG5s5702mm7L9KfMD/K+TvG7uMTk+TUMOz
         ZjaltCL+BwNDKfGvvpDUG7csrIpTUpRoAbd3EmvCluHMJOvSv5/KvH8q0TeFx+WjQlr+
         dvaMqAgUMtzimpIyPI7yqFjD9rZ7JT7T1Bl4nYhWQYDOa/gmDrivFkW0ghJy6h+FeTKy
         f6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758888849; x=1759493649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxT4Y2WIVPS6x9uIm0wu4RFG6HiZ0zeh0bR1+7IEn20=;
        b=Z9GlneCsBSYTZkZm2P3ARbaokNd9JLufyVJCB+ESAvALIASxQxPqmS8v9ruH/RQSFF
         rHMCwUDy8s7vWpsOGtp1MnF7mrjPx2JojeCyy9yAEkZkFNmlN4qUsr+3k/bOYfQhKhkU
         MuLMcRKijxbTKajl8au6RV9W5HOqJVa5pE4bVznmGmQZUpEcimeSUxujyDXTTWNsL2lQ
         j7AEgTv0B6jndoNZlKvyFY8n7bEj1V+nhzPTj/bsKMICATsPTw2Nh6zotXH67cp6L961
         /f1qZ+vjIqbU4pDIlXzH+doSL01u0/BFkEWzuO4IXV7C2akVbEglaj/NjuqPJ5jdGm0y
         aYBA==
X-Forwarded-Encrypted: i=1; AJvYcCXKKSbGPL5Tcu5+a1p+0PQNew+ibrGbbXSF3CJ+hbsjVNTEOMePbt5OavAlFgxQu43VduxfWOVesWsSmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEQdDmy8DKx123KdMliBDigrJzY31WLbP3NyQhHzhZ+bWZC2L
	n8SMIYUQwikJ21qdlqduKJtC3kQy57kBnrg8hokMCa4utu5ZDlzLeOzLp+6StgbOM+P8GlYRjev
	+/Nwy
X-Gm-Gg: ASbGncsPHytgRabqOBp0PrkcZGk9jHm9tfneE1Vez1ANPgSGJApTlrK4z9ZBeOerXyS
	5K+o++MeIXTjGfuAM2aHyKibQhK2KJOuIB0Tgs37PGhr9zSMUcGvRSukEQAsLuo/xxaRrpbOgil
	slVEpnrdCn8U8JAv6YKp0VEmSkahF/jOegF+htCHJmmdpeVVaZeS+dBK+Qc4ZrEPULJ5Rx+1idB
	wkGipqjyvDTCEVlrlPYkG7RdoSAAJlt+503RchH3Ejbj2bzIBXzYNl/Pbb6jproF3+vece86sLK
	XrzcwjvbbILuSo7CjWM9n6zuwuMzTelbIkYhywr3sU3aL9HqjW2ZWBhnQMY9XojyGPKTdiya1vk
	/BYy8gYAOrAujFzjCJejVT454oP9FkT7G0fF5eM2cA94EL2Y23Q==
X-Google-Smtp-Source: AGHT+IGz326RWc+dOHorr933BbC0Un5CjPWxQtgt5IRFWPvpnr2uyvYZgoC/PSsxgK1QpBBzGqKCjw==
X-Received: by 2002:a05:6000:1acb:b0:3f9:e348:f70 with SMTP id ffacd0b85a97d-40e4dabeea8mr5625439f8f.55.1758888848937;
        Fri, 26 Sep 2025 05:14:08 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:9ee5:820b:e03b:ab3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2c6b3sm7342008f8f.54.2025.09.26.05.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 05:14:08 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: clm@fb.com
Cc: dsterba@suse.com,
	naohiro.aota@wdc.com,
	johannes.thumshirn@wdc.com,
	linux-btrfs@vger.kernel.org,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [RFC] btrfs: assume fs_info is non-NULL and drop ternary check
Date: Fri, 26 Sep 2025 14:13:44 +0200
Message-ID: <20250926121344.25706-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When assigning max_bytes, fs_info is checked for being non-NULL
and a value is assigned accordingly.
However, a few lines below we do dereference fs_info multiple
times without checking whether it is non-NULL anymore.

This pattern has triggered Coverity Scan which thinks that
we may hit a NULL-ptr-dereference.

If we know for sure that fs_info cannot be NULL (and this seems
to be the case since various instructions assume so), we should
drop the ternary check when assigning max_bytes in order to avoid
confusing the casual reader or static analyzers.

Fixes: f7b12a62f008a ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
Address-Coverity-ID: 1659628 ("Null pointer dereferences (FORWARD_NULL)")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 fs/btrfs/extent_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c123a3ef154ae..dfda8f6da1940 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -374,8 +374,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	const u64 orig_start = *start;
 	const u64 orig_end = *end;
-	/* The sanity tests may not set a valid fs_info. */
-	u64 max_bytes = fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT_SIZE;
+	u64 max_bytes = fs_info->max_extent_size;
 	u64 delalloc_start;
 	u64 delalloc_end;
 	bool found;
-- 
2.49.1


