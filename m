Return-Path: <linux-btrfs+bounces-4367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C228A860D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD431F2107F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAC14036F;
	Wed, 17 Apr 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="W1QHGBAG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91085142625
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364580; cv=none; b=BRoRILJPK0AahAPRTH9RFkJvedLwyzo70HrX6L/J94ea2hy72NzxY7A02DxzBqMRloocIcSmXA8O8rSng6qW25+kwD4f04XwBDbctCYD8E19pqaSkW1Mcs/lms/DCCQdKazeVDiSOlfDl4XX0KUD4t9D1WhO85fGKRT4L9lPrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364580; c=relaxed/simple;
	bh=+nq0wtpfH4KER8mBsUbu6J4UUsuSCCFYK0gEt/a5TJg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2Ym2Qs1x+YmqBMbaY1wS0sQqdZccbjrgel9PAP2PjsZ6YbrR6l0H6E+t2aP6eD6E2XaEW19CL8oHAYbWtoAAOSNwI0FuB97luU/D90TMcxGjyBsFtDgQl548PgXIVjD1DhxoRH5aCwEjPmydU3ZN2sabVUMgjFa7e7dl8Ahp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=W1QHGBAG; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-699320fcbc1so30419066d6.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364578; x=1713969378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wO9Y9pmUaM331yijLL4Y5jBy/ESfY0EBWXkj0YYSLW0=;
        b=W1QHGBAG1TA66Ru8mQrWFe+OtoBHTU3bj9/ovRXdQMnXCgqAQ+CW3VJ1ONiwwYn+EE
         BfuNrUW/t3/iiNFClKzcAquOOCj6ryw/62kjN3pGvtu1rL7pRRj6tNdxviU1i5fOGREk
         ZKfGzovWfLoKx8yMH2mAdN/052iCA0agDj60mUFmtacYNEQAtkins/O4U4YwCU0IiJh/
         dx53JXcdlq/BQgswwpkczFeYXLrGY4lHNL5YshSDiLH/GuRBpg+5RU+pQHRYO3bhrT5B
         ddMdQOu3y31ldSET/6NhXoiMYh50ygKqw0eEbQ07RBUJuhizPBFZv5J8rvKOJU+Osx62
         KEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364578; x=1713969378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wO9Y9pmUaM331yijLL4Y5jBy/ESfY0EBWXkj0YYSLW0=;
        b=Oud4OeZ6OShv+Y0tuyt9vW1/kvKhQ4R/Cz7GZSFae2nbJuESFwW7ZS0JHnvDKFBjFV
         w0S0Y53Upzot7jLwRYNpur9T+5VsCqsoDYzhLGP34bm29ZyhWq9O7p7zQxihNWgjBQjB
         jMpkd0FGCX811hrvU3r4hS1TgyaRQ4vSlBcsD2O5YWug618NDSRoYWvc+PIlI96q3g2v
         LvdxHoY7RzfbgjEH7enaTR09qejNGhL1CwEsG2jbn7Djj8vcXwd9bUo6a6nDklnX8RPE
         18ptRWEtlX2ZmQXd0ev0aShvnUgSojtTrqtNoG3EyxKf8KWPhglMNWgoxyxInkkBGkXJ
         DIsw==
X-Gm-Message-State: AOJu0YwMgIaUz3+tE+dUPMh9Yiak6JS0akBoKU+Wt3OScaIibJ0H6oZ1
	xDH1KycXBO70IbuBGJ6leJv873l3pXLG1rvPTpc2s6gulLU6JmpZkcEkW7LY3amygIYXd++WUez
	m
X-Google-Smtp-Source: AGHT+IFyzvcSMfCv6YOMzgFWa7cy7NxzQCP0MNyU7cDfpBlRSjE5GDwKd+PG1jWYK8dmBHjxo7Qqaw==
X-Received: by 2002:a0c:f644:0:b0:69b:aca:4a1c with SMTP id s4-20020a0cf644000000b0069b0aca4a1cmr16778889qvm.10.1713364578491;
        Wed, 17 Apr 2024 07:36:18 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0562140a0b00b0069be29e160fsm2505673qvb.141.2024.04.17.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 10/17] btrfs: remove unlock_extent from run_delalloc_compressed
Date: Wed, 17 Apr 2024 10:35:54 -0400
Message-ID: <62c3ad839000ac851c813c84f94580fafae16389.1713363472.git.josef@toxicpanda.com>
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

Since we immediately unlock the extent range when we enter
run_delalloc_compressed() simply move the lock_extent() down to cover
cow_file_range() and then remove the unlock_extent() from
run_delalloc_compressed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab3d6ebbce6a..9066d248b9aa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1642,7 +1642,6 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 	if (!ctx)
 		return false;
 
-	unlock_extent(&inode->io_tree, start, end, NULL);
 	set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 
 	async_chunk = ctx->chunks;
@@ -2276,16 +2275,16 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		goto out;
 	}
 
-	/*
-	 * We're unlocked by the different fill functions below.
-	 */
-	lock_extent(&inode->io_tree, start, end, NULL);
-
 	if (btrfs_inode_can_compress(inode) &&
 	    inode_need_compress(inode, start, end) &&
 	    run_delalloc_compressed(inode, locked_page, start, end, wbc))
 		return 1;
 
+	/*
+	 * We're unlocked by the different fill functions below.
+	 */
+	lock_extent(&inode->io_tree, start, end, NULL);
+
 	if (zoned)
 		ret = run_delalloc_cow(inode, locked_page, start, end, wbc,
 				       true);
-- 
2.43.0


