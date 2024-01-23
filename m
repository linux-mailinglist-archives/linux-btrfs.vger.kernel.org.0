Return-Path: <linux-btrfs+bounces-1631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9954837EB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 02:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C571F29CB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7DF7A735;
	Tue, 23 Jan 2024 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DhIrRYCc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C77612F3
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970758; cv=none; b=XgvTYZb9wA7480hNbzBUggdHBAqlvsmRxD3fZmvNr1ez4Nx0S3st3qGQKa1Dng/3MTYHKIlD1uNpUHiH0SW/hig6MGZa08CH79+wSvAFkmsCT07YtRMBx5pkbGuPHGXSzXDMpGpDj5Dq037WJyighYNuxVvJRd+bkkqtAXYIi88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970758; c=relaxed/simple;
	bh=TpR6teHZ/mpSlljZAe5k5kCh5DgjaXZFO8tyJAngV40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRLgpDcJCY8CMZOnf+IKjUoPJnR7tjXKE6uXAvamy0UOxJ0DoCL+ZqKKO7CNXtHV3dg9XEpfuDA2qFhIAFscHAWc5nTKFSZ1t7dy71OO2fZ7Zbxo81vfGBwLNnJrQMT42zJ59h7spn/t98ZWVEB1bcAKP3KAS0IeRW0Fyz5I3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DhIrRYCc; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-595d24ad466so2482173eaf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 16:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970755; x=1706575555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiT3/py78kD8Owr5bvLrUn8dFen8dEuc/D42dgSMckc=;
        b=DhIrRYCcvsDroyytmKzTBuWGR+vYa4okBNfNQKFOLkLerzs7SBzhm0R8SS+8YCvz9+
         W4tj+9TgBIv6tEvUrjxrUO39yvMxrMbzaYE/nLBSJqx5wPSeJkVIqgHIQiHnV9AvSfLx
         //dVx4d/s6CkRPdyQdd3hWj8pHXEW6ZEYb/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970755; x=1706575555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiT3/py78kD8Owr5bvLrUn8dFen8dEuc/D42dgSMckc=;
        b=bGaXzj7YyGI7OeOy/Y2UECqxU05AeBztw0PCaU0ibd0Cjugw3DOBVy6UrKBlpvXuux
         9bjdmRT/4CxT4VvV1wmoq14Qrb+jrBxhONB6B6zjo6pZ7iBwkeACi4PzvC3KR8B+KTmU
         hSSG+ikFGwU9mg3XKflzmTkfVZ0qkFdGijolLrhYNSo0hDwZNHbLVLWt8XwgCR6Ckw64
         5D3CiDVyq7N8+JCc944E7fmTAkFSS/Ny0QSzXuvBobmlDJMg87cKBUs41sGxlzrWWjtR
         mCCaksYWsWvB2Jxohm0w51zibHyNLyI9QiohEvxtiP8TNU9+r4E3LJ5OZoJv0hCeu/lz
         YrtQ==
X-Gm-Message-State: AOJu0YzGoTKMgjF3DuL/c6tPrgmww0VMy4ip+amGT0Ote7YCC2x1svOP
	gkBKnGrAZvQRZ87IT5kZWNuztgA0dvkxlQhGA9qrS+GUCew5uFNi44n0QPl9Hw==
X-Google-Smtp-Source: AGHT+IEbm9neBtrkf8zlMe/XQiNlvlxPGO4ufOom07ycfMTFLjsEggEqw0GSOC0u7hD3Q/8TGcH34A==
X-Received: by 2002:a05:6358:3a14:b0:176:411b:888b with SMTP id g20-20020a0563583a1400b00176411b888bmr4129504rwe.17.1705970755473;
        Mon, 22 Jan 2024 16:45:55 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 32-20020a631160000000b005d32c807296sm134222pgr.68.2024.01.22.16.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/82] btrfs: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:48 -0800
Message-Id: <20240123002814.1396804-13-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2625; i=keescook@chromium.org;
 h=from:subject; bh=TpR6teHZ/mpSlljZAe5k5kCh5DgjaXZFO8tyJAngV40=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgFfeVx2CwOxlQgJ6mdRUkjPKVsQ4wxQm8Eo
 0Fb22rxTrCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 JtzMD/9eNR4myrR+1tOyMuPMfapd+Ep06GScRoVLgXKneVxiu0hmGlhtdzsHV1+AssbXdzOoJoW
 QxIVv3tr8VyrsCER1WPzf8VB2OQDS1dx7+ZaUTsznUwIiIOgAKkXBPi6mkVhSSB+VX//N0JkgJP
 9RuBQW8XpW9OuwfYclTiOjBQkejhwC5BIUuOMVKKnoOl6yVeyjCG7EnQj6qvk5sHelweXKF5xni
 rsdhQajVbbYHfPt5J0yDlhyRq7CFRRz+2g4fpAJXm7O/HZ9vaQvUZuVnMwhqvR/pBRCKtJUdxAy
 ITO7VVMQb+9gqG0S2to8c+Co6OURs7vo7MVGtt+gqIuNxs36otBVuePIz/eIhgNT/2ZHMLjct4Q
 ZyXnSbdqUzASQ7HL22SFnuTktI+YVp7uYuwPBJUFo2M7fOdsI77QWeDtrk6/omOocXBoRJ6bMZL
 86BG+Dh0WW8OWMaqgaCqjXQNdkWx9mPXgNuDBmKae/XNAgxA1twHKiasClUXIor/5ZIavg2lUsc
 JfbVN8cw+vltYIADHJIA2E8VPpKOhlCsIc68x6+DM2Z+p2TBNr1qlDZGnHZqKlkiLt8UGhpsNLo
 aEgMRmK0YTJW6fJId38qQmkVt2IoPug3NTPqLBc6Pq6tD3UXznkmfxhYHxgBYPa2iCxUyzlwm6G 9MSor/xafFdN3yw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizer in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/btrfs/extent_map.c | 6 ++++--
 fs/btrfs/extent_map.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b61099bf97a8..29a649507857 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -73,9 +73,11 @@ void free_extent_map(struct extent_map *em)
 /* Do the math around the end of an extent, handling wrapping. */
 static u64 range_end(u64 start, u64 len)
 {
-	if (start + len < start)
+	u64 sum;
+
+	if (check_add_overflow(start, len, &sum))
 		return (u64)-1;
-	return start + len;
+	return sum;
 }
 
 static int tree_insert(struct rb_root_cached *root, struct extent_map *em)
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index e380fc08bbe4..3c4a6b977662 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -108,9 +108,11 @@ static inline int extent_map_in_tree(const struct extent_map *em)
 
 static inline u64 extent_map_end(const struct extent_map *em)
 {
-	if (em->start + em->len < em->start)
+	u64 sum;
+
+	if (check_add_overflow(em->start, em->len, &sum))
 		return (u64)-1;
-	return em->start + em->len;
+	return sum;
 }
 
 void extent_map_tree_init(struct extent_map_tree *tree);
-- 
2.34.1


