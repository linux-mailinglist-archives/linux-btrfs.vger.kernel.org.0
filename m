Return-Path: <linux-btrfs+bounces-6766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEA93D91A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583821F20F78
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA755143898;
	Fri, 26 Jul 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="28Vfce2U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431614A62A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022626; cv=none; b=ph/1rTM5LauJQR8PSMaXvbhSboVIPRTsgHQItirxemJCbW0JsPYJICU+mhzbYj0/mMTKvQNtkNHrVMBfc80EZ97p/l2B81X2BmQaov76nrKYlW0vqBzIemG0Xp7xntTT7ziN/eN2JUZCfpikvvI7QORy+PSKZPKcvpKYDykEjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022626; c=relaxed/simple;
	bh=DKNY+OoVb580grAKIdaIydw8WKgmgCxEXp4/VUPnv54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU32l1eAOrm3+UMUl+iKyV6w+YhhOfBlX7CxIGT9fsapBcIfBr5p72MKVT/F/yydzoi46Gu9XWk7ptArNTGRkz1pqZ1UuhdeL4tmw9T7KkJU9i8v1UhP0ghJeK6uATg3fmsGjv1IthjaWhuifdTWI9xvoh3HPaZeoUUct7pGVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=28Vfce2U; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66526e430e0so375347b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022624; x=1722627424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8mn4fgfp5hpDD5/ffNe5knH/SCnTcqUd//Oyk8i9TQ=;
        b=28Vfce2UJ/vSerZ3dITWE1H5a95QsjUsFjaWUYaMD1A38jHlY8qS3vnzyrY4SoCOWw
         DBHLQgO3+zQw0Am7+/cKfxfGti5BEdmixCMrA5AaYD5Ke4sgo8faWJD/nWokygzo4bIn
         ubh2+9UrPsFSHRh+ysce4JSdGy6WBlbPBN1xOSZH54leIU9VOSsobeEJ26KNgT04TEQ0
         X6PlFzBa2CnWPqIP8SAzf+f8ermaFtmZ8fYsuP0VGpGl4u//ocWYDLU7LebDOgz4n5x/
         hN3tXmfMHippIDk74P0UswDb/G8G5QvjLVUa6lT6NYeZ/uJT9MveXrGOcbphE0Duuj33
         Pueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022624; x=1722627424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8mn4fgfp5hpDD5/ffNe5knH/SCnTcqUd//Oyk8i9TQ=;
        b=hFeOwdLSJ9cJYyo1QCW05J1lE3v8PURCn8MrZIK6EA/TdzJdHxi5u2bhiAeFcMLsex
         RPMA9npPelyWxtpzveW8+t73ZoLs6PwzXwgo8mFuls3IFwdC3g4YrbTjV41E8hmV9728
         6LHF3XC0XzKsvJVUpHVAOJzN8Nr3woAL78RbRSfn7Eh2l9pEAiaVrXyeio30/lhRi0/v
         u7vnzCT1fz0zgsOQ3wNKm4cyQuJtVqn2MC7B4wLTs2N4rl/zEEu1Uz4nm9XFxFzvRRVz
         sprxEnDsUuVwFTBvVUcpvlz7p601O5iNu1BxNO23lskr2aKp+PZX+LwD8N5bJtdp0Ye5
         66mQ==
X-Gm-Message-State: AOJu0YzH/Z54eW0eLfKeBUVY1eDasP1GQuGqo8MNeDJj9kMm/QNVepik
	ZYOWVPrwOJvibFs3SIFTqoBD38jVfjjEEjWdzq3T40JawLkXmRtIjjY8kZfb/7cUrwOOoZ17lDY
	7
X-Google-Smtp-Source: AGHT+IE/P8eEePxjfRac2HxHbLoF3mbP+rG3J1p1ZpDrEAPuVgPqCQOGLbEjx0DWEJl9OHdUD5HUTg==
X-Received: by 2002:a81:6e46:0:b0:62f:b04c:2442 with SMTP id 00721157ae682-67a051e835emr10570427b3.7.1722022623769;
        Fri, 26 Jul 2024 12:37:03 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd91ecsm10015777b3.17.2024.07.26.12.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 25/46] btrfs: convert cow_file_range_inline to take a folio
Date: Fri, 26 Jul 2024 15:36:12 -0400
Message-ID: <95c76149c7094019e8879547df1c642cfce36511.1722022376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we want the folio in this function, convert it to take a folio
directly and use that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index db0aa7ece99c..7f2875c99883 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -715,7 +715,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode, u64 offse
 }
 
 static noinline int cow_file_range_inline(struct btrfs_inode *inode,
-					  struct page *locked_page,
+					  struct folio *locked_folio,
 					  u64 offset, u64 end,
 					  size_t compressed_size,
 					  int compress_type,
@@ -741,10 +741,9 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode,
 	}
 
 	if (ret == 0)
-		locked_page = NULL;
+		locked_folio = NULL;
 
-	extent_clear_unlock_delalloc(inode, offset, end,
-				     page_folio(locked_page), &cached,
+	extent_clear_unlock_delalloc(inode, offset, end, locked_folio, &cached,
 				     clear_flags, PAGE_UNLOCK |
 				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
 	return ret;
@@ -1365,8 +1364,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	if (!no_inline) {
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, locked_page, start, end, 0,
-					    BTRFS_COMPRESS_NONE, NULL, false);
+		ret = cow_file_range_inline(inode, page_folio(locked_page),
+					    start, end, 0, BTRFS_COMPRESS_NONE,
+					    NULL, false);
 		if (ret <= 0) {
 			/*
 			 * We succeeded, return 1 so the caller knows we're done
-- 
2.43.0


