Return-Path: <linux-btrfs+bounces-16394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC86B36E6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EDD1B69888
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010BA35CEB8;
	Tue, 26 Aug 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zEftBxnH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8683629A6
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222891; cv=none; b=SL4+CfawTNoQZ0AzgV0ka/XNeV28q8R2NvmRm6fsgt9w0ET6y1NzssqA4ljPrtTC0e1ny+eq3Glj2soRiKEan4MaDxdIpZR/C685CZ1i5Wn7SbUJAYxijvdX9zDxWGlu4XBMdEjmbVVjbyGGXnxgJYMAjyX9fRY1TM03/HgB7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222891; c=relaxed/simple;
	bh=7Rb0WDz6RNiTOxNcfVfw/tSky4eT2lKquvzMe9BAl6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGMS1z/+seha8cD9rXKV4jVdHSWbF/AtHwHqja1elcWtz7qlvM2d4OBxaOmv95lgVmCYLOHqUdk1HoLbVYX6rwhsAsoy/FG9VC/Tv3fFeMLe/wZ/vwvhczM05/00Lgg59TkbTiSzNxd97eSDpcfhcPZSndBS1/jORoMe8ztUZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zEftBxnH; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e931c71a1baso8241196276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222888; x=1756827688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pKHzHpITaAc/mjXTKQS2R/PEauqoOSV7l2KfBiByOc=;
        b=zEftBxnHOYqdJPVmTEXMYULPzm+1QQ1YN0kFgb3VDGK+z9TCCHC2njCjZoYJmPf0zI
         xZos5vZFx0pUPPuPWAFDp8hzx7eQDWWtj8TzNrfWp2vOukmRps/7etBdjP/fXKxYMG7y
         ZW9tl4+OOns9pZy6c3vgi8vCR7raxs+g5vXa3Xa7+8EyaOk7P8OASzrl7AkNWnzEs3ys
         /zdBiA0XBuwDWjDrKj/pP3n483Nnw9AzFAGis9z/mEVVv+XwXjfuVHlO7y6ZlN1aqCpk
         Iv9iz8/b36g46zQVGbEGYmombxLPIJZ0EDlY6DVBcyVnbJrNOH7Ghe63wJ6bPF3Dzqzk
         hOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222888; x=1756827688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pKHzHpITaAc/mjXTKQS2R/PEauqoOSV7l2KfBiByOc=;
        b=CYCf4pypMz9UxgkvFx+QJxrYOVCni9zl6oKfuibQ+QBnTj6bhD7wI8Xcy+BVQ3euWZ
         7qcxQLbLYABssEAooPWpOC4cT4VA5whJ1xDHzhin8t4YyoP4ICBQoFx00sOMnaV6Jtso
         wcpFsuzlbTs50NEKirFTuhlv3y67hsospyvuc3rYPMnrj0+isfGwAgtroSPb/0YmIwDh
         MaXaJ6DI83dbzmK4Wk6YmNF00qs6GqhaKUvRlUSM2YwwhfX8L8NtNZN2IgOMJXf9BDpW
         yCLvsbMeBCNBaxQVx1C4sgbwK+clW72bZLJzo/uDq/VsgxrfN+xpB7kEli0bUN4Atf7x
         mR5g==
X-Forwarded-Encrypted: i=1; AJvYcCVUBhTAHxO2tfZijxysvqS4RcmTWRkeZZfNZb3ZVBgFEd+eMLUoXiprwe98URwVB0wtarLynZ2uuSSByg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnf+M/ZxrnPXnHZsnYnuJ/s6/sYmsQvclkB3ffGCmkogMf3LoT
	+bjQ4FW2tuMoW0KLpesSwHmQ4d5gkz/rP7/Zk3Zs/D6KF8EAKY6XEhr8dDJRKoCtQRs=
X-Gm-Gg: ASbGnctc4Fca/nvzbtw3DEVmbARBC1KCTT+Awt4NrLO3bFu+zvQsr5jUM5X+Hbbo/Wn
	jPQD9AYpTQ5pwKJd1prE6SPQkiqcCIXz6JNnTmdgGWEW3FQIolB3utYzjUxEipM7W/AqGB15sOt
	ifEomgIhJ6oq4df6RZJhCoNXAFQRZGKVwcTjMcydxlnCtiz/XtWYsDDMts1mfkqRQnoX+DeQnw/
	g1SoRRLrZM5QOfSqSIaiFZazxfYpOsTsL8eLp6aqWagyH8TGd6YRRBXwOWj/tsxNc4ZTzVN6csq
	DavZlgHDvWgoyLemuF7YAmt/tuBxZoyTFVMUaWuQQJ5bUpDQmOSgG7+VQNLI4Vo8O3pxGAaZc30
	KQNDHK6I9WxWLJWSwdIW4toaq/YB65tL1TRt9eaIVEUyEj2rsoL24k3QZ3MZqI/8mT6ftIw==
X-Google-Smtp-Source: AGHT+IHpeaJ39DrKl0SHq4TeALy48X7MoeQZe8JyD4wQTO8EFKaesDAqzHePbJNfnv8wB7k8ckcMHg==
X-Received: by 2002:a05:6902:3483:b0:e95:3b7b:6e4e with SMTP id 3f1490d57ef6-e953b7b72d3mr8336972276.53.1756222887983;
        Tue, 26 Aug 2025 08:41:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96ea63fab0sm169958276.8.2025.08.26.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 27/54] fs: remove I_WILL_FREE|I_FREEING check from __inode_add_lru
Date: Tue, 26 Aug 2025 11:39:27 -0400
Message-ID: <5b72bc52855034d68887e466dbf790d6c2a1a9eb.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only want to add to the LRU if the current caller is potentially the
last one dropping a reference, so if our refcount is 0 we're being
deleted, and if the refcount is > 1 then there is another ref holder and
they can add the inode to the LRU list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d34da95a3295..082addba546c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -597,8 +597,6 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	lockdep_assert_held(&inode->i_lock);
 
-	if (inode->i_state & (I_FREEING | I_WILL_FREE))
-		return;
 	if (icount_read(inode) != 1)
 		return;
 	if (inode->__i_nlink == 0)
-- 
2.49.0


