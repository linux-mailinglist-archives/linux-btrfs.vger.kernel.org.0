Return-Path: <linux-btrfs+bounces-4814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D2C8BEB4B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A741C21E1E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28E16DEC2;
	Tue,  7 May 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2yCKoqoX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B616DEAF
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105561; cv=none; b=NKuOkJr7YNSkE5TJSxz9CKkuBQQT+UvU/MHiKdcfWdzvolHafPMVn19s3eZ/vQT9zmP8RoI9b69EN0ijpmjcIIq2xnQWB4f/1QfvBr4cAjuuIJ8k2ei/tbjbGSgf2f2npRmv/9BGmPOsyWYbr9LrH5FDES1KmYefuj0zFoaQQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105561; c=relaxed/simple;
	bh=KhqqIUGDegCY9XYuce287PAhNDNWiSK7iwHSwJIpRVY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdAr5ExlNTY1P0OraUPbshc8M1T9JFQslHAlbo6FGs73OPLU24wFwBJ1AbyMz8/eCm8zZYCLNoObPEDZmtHUt9efEqoGv22zojkhAbjL23j8l86HX7T+T5cf0RYa3zwkpfey1eXCukG9A+WLmryPl97rBK83v5IDczo7nHDytC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2yCKoqoX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61e0c1ec7e2so259207b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105559; x=1715710359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPnY+pD+b1QnliSmODM5TAvUO8IPiGhZ6cPOEHOmHFM=;
        b=2yCKoqoXP7hxGEPeZqk3zDrXEE14WqclCICSqzkrKD55JQmR53PnxA/DLnhsTEhN84
         4cUOnFL74uGMiB5iDyuoOzkurvHjI4T8k4Cr6BfQWIN8AoT0AgbjjO/H3MGov3pntcas
         0KWqWtTn08uvk0HbCPZZkmI+86voxFViczTscGW1+T1BYfS0J7/qziy3yGbhN6OeQstG
         FmC8EaObmUTEdDqc0MJ3raRr6IG/9LqpA5X3JNrdIHRiGH8DoFqOIehApwxKfA1T01K4
         1MzXyzAK3uTMMkmv2pKea/wta2Oe1fWWG6Xwl0/wkpnozVivOJQb53uxSZ0+/PwNvD3J
         kOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105559; x=1715710359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPnY+pD+b1QnliSmODM5TAvUO8IPiGhZ6cPOEHOmHFM=;
        b=PbZ51Hurtrd2d4In8qCHyx0Pn/5FIGw4eE3/82U0MAsRWc0zcjhlH0KN7asquF7NW2
         B65zyeGMWd7l3bowDuraYzNXU8DdhGp+xumWmlYmUqIbkPIuyZvQ2EZOw/bCuLT2O8cj
         w/XEnIhjM3Ok/wD1K2ZzI3q6ccJNgbwROEEVYzHLfP6v7D2GaU3R/1S3ZrTcTDQO0Krx
         SvmhzhE8CGkbuUL5t/yx4b18Rqk5BxPSMAWWGNsJSeuFXI9l5V8J/JrQb1QqFwQtUISL
         Dd6Wrp7pEnmgy9B0RN10KslSvgjMdrVlFvjlIKJYmEnfwFb4CUAcetJktSRuNvdQbhlx
         /j/Q==
X-Gm-Message-State: AOJu0Yx/UOEYOoHn6YoodOteFle4dJmB+kuyTOUj4dk1huXtlKMbX5PY
	UlUObs9YsnZfPGK/6PgZH5C/4mlAXTup/rK6qheEgmUVcP3t7vQsp8DxVbwnvCMAszAEimX+jn6
	w
X-Google-Smtp-Source: AGHT+IHknQoqed7NBPIiwEEQr2XuT3gRbRrFP/dNcY3SSxYu2ZA4wgWjF8gL9fKs8NpL1lO1CQM7HQ==
X-Received: by 2002:a81:91d4:0:b0:61e:eec:ec5d with SMTP id 00721157ae682-62085a6fe8cmr5798287b3.5.1715105559305;
        Tue, 07 May 2024 11:12:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id be18-20020a05690c009200b0061521b0bb33sm2760395ywb.63.2024.05.07.11.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 12/15] btrfs: clean up our handling of refs == 0 in snapshot delete
Date: Tue,  7 May 2024 14:12:13 -0400
Message-ID: <874b3cb1c1591a96572a32d27b80b205cee4b795.1715105406.git.josef@toxicpanda.com>
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

In reada we BUG_ON(refs == 0), which could be unkind since we aren't
holding a lock on the extent leaf and thus could get a transient
incorrect answer.  In walk_down_proc we also BUG_ON(refs == 0), which
could happen if we have extent tree corruption.  Change that to return
-EUCLEAN.  In do_walk_down() we catch this case and handle it correctly,
however we return -EIO, which -EUCLEAN is a more appropriate error code.
Finally in walk_up_proc we have the same BUG_ON(refs == 0), so convert
that to proper error handling.  Also adjust the error message so we can
actually do something with the information.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c75a5b3ddb8f..2e3a2aba8001 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5351,7 +5351,15 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 		/* We don't care about errors in readahead. */
 		if (ret < 0)
 			continue;
-		BUG_ON(refs == 0);
+
+		/*
+		 * This could be racey, it's conceivable that we raced and end
+		 * up with a bogus refs count, if that's the case just skip, if
+		 * we are actually corrupt we will notice when we look up
+		 * everything again with our locks.
+		 */
+		if (refs == 0)
+			continue;
 
 		/* If we don't need to visit this node don't reada. */
 		if (!visit_node_for_delete(root, wc, eb, refs, flags, slot))
@@ -5400,7 +5408,12 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 					       NULL);
 		if (ret)
 			return ret;
-		BUG_ON(wc->refs[level] == 0);
+		if (unlikely(wc->refs[level] == 0)) {
+			btrfs_err(fs_info,
+				  "bytenr %llu has 0 references, expect > 0",
+				  eb->start);
+			return -EUCLEAN;
+		}
 	}
 
 	if (wc->stage == DROP_REFERENCE) {
@@ -5663,8 +5676,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		goto out_unlock;
 
 	if (unlikely(wc->refs[level - 1] == 0)) {
-		btrfs_err(fs_info, "Missing references.");
-		ret = -EIO;
+		btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+			  bytenr);
+		ret = -EUCLEAN;
 		goto out_unlock;
 	}
 	wc->lookup_info = 0;
@@ -5775,7 +5789,13 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				path->locks[level] = 0;
 				return ret;
 			}
-			BUG_ON(wc->refs[level] == 0);
+			if (unlikely(wc->refs[level] == 0)) {
+				btrfs_tree_unlock_rw(eb, path->locks[level]);
+				btrfs_err(fs_info,
+					  "bytenr %llu has 0 references, expect > 0",
+					  eb->start);
+				return -EUCLEAN;
+			}
 			if (wc->refs[level] == 1) {
 				btrfs_tree_unlock_rw(eb, path->locks[level]);
 				path->locks[level] = 0;
-- 
2.43.0


