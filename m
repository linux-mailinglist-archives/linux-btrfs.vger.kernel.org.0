Return-Path: <linux-btrfs+bounces-4360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE38A8606
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF1C1F20984
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE911422A5;
	Wed, 17 Apr 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ARWrT6/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB321420B3
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364572; cv=none; b=IH4tXZSDMtruo3E5Dq1KLvtTmxApBrMUtfQG7tYLdDVt/3UnXafew4Q9DGwXJK4pH7PmUw6XuFk01PQs0qHVVGzZUn55FnBpgduSamXzgrO1dlQlkbd5PH13cvu5YNQu/fk6UQN/PosX9vMFcbm2b5NG9DL4etGDx1yQE5WJGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364572; c=relaxed/simple;
	bh=kADrSuK3KOAe9vqySv7uetLB0WjLYDzfPLO8t5XnLaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZFminV3N5m24UCXQoUJGdBlGq+c6upyoYfoXOW/nhEpa2nooIRvzg5EX2aOVaan4x9L6naFGSa/LMnb7kxZGqxLwN9lC+8EWmxmbza2J0lHUje3iWT9jyxXJdg485M+xeH4EWw1j4BDF4mpa/iKrjByq3QNOaswgE8oSSqyqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ARWrT6/0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78f0440656eso27935085a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364570; x=1713969370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5aaVz3YWLTiKomu2ZivMqMrNbeCk1IfwFqtaiGmw4Y=;
        b=ARWrT6/0El2Kal0NEWXgPz/thSc9W9pJy2WX1ONNRdm8o1d2G+JJP0k+pJdZYNKmwn
         7XaEx1yeBhjFPSAnqoImpbquZEjdMwtKhFhW90dqd3uV5SEEseVC749TDhdqVCtINmf3
         YH2fP8Ocmr0KuVbYAQYJi91CJwAH+U4PSqrXnUociL2HzHjEczVemAR09kl0mxGl3tHa
         AnF90xU6vAhKOjKHdD5EL86TWi+49VfHV/FOx9tvC5V17MYLbeX4jIRujlughFQ5M8tg
         W1RLVJqN252Gc1kdPwZPPZED49q2Qk6+YzGJaKvoHTLH5vlVca4Mr8YLfKdzNWfHi4RC
         D9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364570; x=1713969370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5aaVz3YWLTiKomu2ZivMqMrNbeCk1IfwFqtaiGmw4Y=;
        b=Gqo557NwMXpEpGOL+sw1KIXgL9xYyn6FAPgM+RGjI5UCJI9XApBYoXBzkYNVWQVGuj
         Z+5gzBbNbpXahjU1A3QRGIKBGHyXyZuQlfZhuQRi5gO2Q8/RYy0DcRDWtM0dTGhdq4ax
         TsJAsL5gPSAas3np7SrPRpjdeUKl/OvINk4WGNKhlXBUYrl8LW2ze4fCinpEi+5Pm5r8
         K+nkUiTnXgkMiJch3ldlAVf/5vfz8kC5zWZyBtdhQfXOPfw1B3s+OFgi2uXwX2WHH6IT
         NoxOsiVBuaXhlalSm60dKNqOqNnYUwtE2HFkGeCg5dlfnWUJ7oMEi7rtr+eNGT4pghEU
         vszA==
X-Gm-Message-State: AOJu0YxpaT5qMbsvh291XShIwv35/VAD9loU+2QtGSoLgqtC0HOoltzq
	WJ1/3KL/AFPb2TQUDAWUiaFJ/+4mQnj9vka7BBYutnveN296NlJ3yhFg/CGxOGM/DVHS0QNTWUC
	b
X-Google-Smtp-Source: AGHT+IE8LAwvjNXgV8kbXutxSs3dJaa6CoG9MEvxo97/IxnbV4fB3ag4YgaeRdLThPFbUPqJXk60BQ==
X-Received: by 2002:ad4:5502:0:b0:6a0:40f0:7968 with SMTP id pz2-20020ad45502000000b006a040f07968mr3301010qvb.46.1713364570194;
        Wed, 17 Apr 2024 07:36:10 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fe1-20020a0562140b8100b0069b497fccaesm8291798qvb.124.2024.04.17.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 03/17] btrfs: unlock all the pages with successful inline extent creation
Date: Wed, 17 Apr 2024 10:35:47 -0400
Message-ID: <7e58618dfcb81c8035c30b814b881fd957f134ae.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 4750af3bbe5d ("btrfs: prevent extent_clear_unlock_delalloc() to
unlock page not locked by __process_pages_contig()") we have been
unlocking the locked page manually instead of via
extent_clear_unlock_delalloc() because of subpage blocksize support.
However we actually disable inline extent creation for subpage blocksize
support, so this behavior isn't necessary.  Remove this code and
comment, if at some point the subpage blocksize code grows support for
inline extents this can be re-evaluated.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 925a53d886b4..19579439f7f6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1358,24 +1358,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * range.
 			 */
 			extent_clear_unlock_delalloc(inode, start, end,
-				     locked_page,
+				     NULL,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
-			/*
-			 * locked_page is locked by the caller of
-			 * writepage_delalloc(), not locked by
-			 * __process_pages_contig().
-			 *
-			 * We can't let __process_pages_contig() to unlock it,
-			 * as it doesn't have any subpage::writers recorded.
-			 *
-			 * Here we manually unlock the page, since the caller
-			 * can't determine if it's an inline extent or a
-			 * compressed extent.
-			 */
-			unlock_page(locked_page);
 			ret = 1;
 			goto done;
 		} else if (ret < 0) {
-- 
2.43.0


