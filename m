Return-Path: <linux-btrfs+bounces-4805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840CD8BEB42
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BC4282ADC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E562E16D4E1;
	Tue,  7 May 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Tu/zWMRV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A74216D313
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105549; cv=none; b=gJN0L5RkdgpCS0jgpW7dHr97v13rRaZiQDWRNXgdIPbqxeS8sJ1AQlYhJ7F2Nbp32OFiYDeP1lb2hsrigXanE1L3//jAM/PzSXwCl3ewUwWyNhJyuiwmSUkftFaryTyNIIeS1P/4WSGZ3h58pyyq7CzunFAmwswz2eTWst6td9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105549; c=relaxed/simple;
	bh=HRe/cY89W88DPjqUozx9WNddjUI5Jt2zRhFofBo1x24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piPBNpmjAuzmHs3MbXBhjaxV8Z89l5x8c0JU0dhKuA6a2Ew9YOejghkGGv/9/frfkTLbgMNmd55uLajdAszKN+jZUrTPzohE1K6sA65lotJXYUGeCzwx2INPDsJ9LOLPsoOwfpSHa7habbxuEG6DSor2zQRgdMvI6+TlKj0Ze90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Tu/zWMRV; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-debaa161ae3so1016074276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105546; x=1715710346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccXBod5dCco1QGMkPtLIUd6x9rTE1uxOFGGOETtDk7k=;
        b=Tu/zWMRVEZC1kwHxv/95VW7mrwzQOEThUEM8Ta3+yI05fZnNSK4G1xyPQxlTf02YtG
         vPEMoJ+MZ/klSD+NDn3H5d657SCDsQrAtVtSd742f8lD9DB/G0LSfQYM4lHwbwnYiNZx
         j7Mx+6KZsf1yqma2Cczf2OYSNEZAgnjU7JhHLvM205BkvAHcLvQwu2gbeI3vbbywV4nq
         d296P15AhYlI5zTsrlmNtnWqolFtd+t2vUUNxDFR4jIzLiG7BZN/n7Eb4lzpKA9bDdk3
         dBUZlO77yGdB5GiHvluKlJ7w8t5SlBY5q7es5twR6eTTvNHT0H4JobQjvtUkvy41Zg3w
         GUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105546; x=1715710346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccXBod5dCco1QGMkPtLIUd6x9rTE1uxOFGGOETtDk7k=;
        b=nZh1z/7AxPpU6PGxsV6QcQJ20aJnTkLxrhNQPqkNDPMekfGlxUVnqzyxWcpwoNFqLG
         oyd2bNo0APOdPEpOySslYForwXeZZb2VuHf42TkyGcc2+BUaxpzoxqtp4syGirRTiFDH
         5w1mD3TboTd5eHf1ENlFrCym8REul0rbVRqU3Rv1TJRx3yoGftgZqR+3L7UMztEhRPmX
         GiG604stNfal55K8a5T8WWl68fahKF3LD9sqxBN+wOUOkLeUIiHRyi5oX0NOT3etAZDp
         rGdz4ce/zAHQaK/vJKaD+68dVGlVVlfnXgL2goxg5sQFFIJB0Gck8XiYLxskDoKn68nB
         ajxQ==
X-Gm-Message-State: AOJu0YwAdFr5oABFCoiiww4aocSqrO1MXn5jz95GMD/kmTFilmrAeOVq
	dag000YFvaJTvG4nDRtBLNfKKOLyEeqYHOIZo8VyVZ4j8XyIYGXjgFFyuNPqPA6DrODZUPwx6Q+
	a
X-Google-Smtp-Source: AGHT+IEfC13Q7ZK2VF2sQ3Hf10G5XrXL8q7u7tYJo5MG7p3MOeOguhxKPsgP18ZlJPEj8JCwp8Ynfw==
X-Received: by 2002:a25:780a:0:b0:de4:8061:48c5 with SMTP id 3f1490d57ef6-debb9cfc30amr504262276.15.1715105546459;
        Tue, 07 May 2024 11:12:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h3-20020a255f43000000b00de5ac6580f3sm2688676ybm.49.2024.05.07.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 03/15] btrfs: use btrfs_read_extent_buffer in do_walk_down
Date: Tue,  7 May 2024 14:12:04 -0400
Message-ID: <12da2f4b382a07d9254c7e2c53391be4d32325c1.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if our extent buffer isn't uptodate we will drop the lock,
free it, and then call read_tree_block() for the bytenr.  This is
inefficient, we already have the extent buffer, we can simply call
btrfs_read_extent_buffer().

Collapse these two cases down into one if statement, if we are not
uptodate we can drop the lock, trigger readahead, and do the read using
btrfs_read_extent_buffer(), and carry on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d020ee1a6473..fa59a0b5bc2d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5507,22 +5507,15 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	if (!btrfs_buffer_uptodate(next, generation, 0)) {
 		btrfs_tree_unlock(next);
-		free_extent_buffer(next);
-		next = NULL;
-		*lookup_info = 1;
-	}
-
-	if (!next) {
 		if (level == 1)
 			reada_walk_down(trans, root, wc, path);
-		next = read_tree_block(fs_info, bytenr, &check);
-		if (IS_ERR(next)) {
-			return PTR_ERR(next);
-		} else if (!extent_buffer_uptodate(next)) {
+		ret = btrfs_read_extent_buffer(next, &check);
+		if (ret) {
 			free_extent_buffer(next);
-			return -EIO;
+			return ret;
 		}
 		btrfs_tree_lock(next);
+		*lookup_info = 1;
 	}
 
 	level--;
-- 
2.43.0


