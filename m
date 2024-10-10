Return-Path: <linux-btrfs+bounces-8824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB14999312
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 21:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1764F1C24B06
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C441E284B;
	Thu, 10 Oct 2024 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daz+EY9q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2241CDFD8;
	Thu, 10 Oct 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589658; cv=none; b=s9H7eBUsk8Ta0eWaFdkVHmH+wHXGNh2IgvFm5rG0sPsoxIbQaMsn63lqJUXG4gp1O+58TlXtgVPDDAP+ZCoI2DVUpwzW34pNB1RHx/Z3S+hBa/rRgY5AExbCrguTPR0TmsXhw1zMzQ4Ye4qwO0sYZSJU4JdqbsdpWQHj2MTXATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589658; c=relaxed/simple;
	bh=KqB8wmAe7duo/DZOH0JJvhfzDNd5IcOJIMTB8psapyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hg75D3bVnYmLUsNAWnnwg1XbQiDvXFZ/NIarnnUIsce9g/vl6otRftEmV5XE74ZQaihaPx6yJU4Arfyn9mJzS1fgFhXuH397RtaAX52KP/6TjCUakxsApjo2effGfnhhiXW60lg1ZhErH8XSmSS5FNnrvzFP3n0zLfRxgjHM8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daz+EY9q; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so636796f8f.1;
        Thu, 10 Oct 2024 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728589655; x=1729194455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pcVsSlgkx44oFHxxeXyOibtQ59FLjGADOzZNhPSr9x4=;
        b=daz+EY9q9oh1uoVy+ZWKxMq5O3FMuSlcvJDy1v627XAmDb6y/ELTBnG4Lt5IqaujeR
         dJf+tK7RugmLYfOspBv6kRIxVl1/whFGl7T2LWOL0fjaeDHZDxX55ZZ8dGYqk1xAcFvs
         ofpdLMHJ2aH13K+IdaOgFHLxZ+LGVvUcx+r/O9ElwGKKoZMvSC8nqJH+lWP/LvaA30Yz
         6L+V5V9NTSRvvcAZjLcZ2K+bqvG8m7H7FMUU0PnCn3JQky+uJUW1npDQ/MWawEtVS1cl
         Lm1No4Ca8syp4P7GAy9JhteC+2bNOFVAPMzee2XrzXRBs0WRssUXdGepjS3YxOWyuMXD
         ceIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589655; x=1729194455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcVsSlgkx44oFHxxeXyOibtQ59FLjGADOzZNhPSr9x4=;
        b=Xf/T3/Zo0I8Tuks7TC0GtdHwZWKVtYjzJG7HZLd2MCNT0qqgzGSzm2jP7sj/bnw4qe
         jYjeeNKFFB8W9yX1dd9iVfXW3otozNG70ZLg7xlQu7yA8esXS2jAdbSnCECbuv4sGF0f
         zftPFEoDL8TagUEyte/yayjnaWuMXpTn5ceK3TL02muVW7Jyljn5z9ItFrIj9G6yJ3Cx
         9whUbexiLslN+BbcS9ABVUQmXNSBytmmONduTevQxXlddo3rZR93oU0jYNajI18bBUPU
         HumqGNIS4JRHk96Gu+oHTIh05Wo+u63SNgZVnGl0KQXIctX2CGgBYSWXZwze963jIG/v
         drJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpyRvz3v7DTZWY/aBnAsSl1toDdohFeCxykFnOB2XLWhgSwFddtiOOvvsk4GcLl382+lBV+2rlfkH19Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMFh3bmHQKRH62DKwBgvANQwqmiXAPSkAIc5Sw08AaBfwxJDh
	dR4xDyltUI+7luee5TfN0v6a818DrypDZad5fUiFguaOYfUHrwxF
X-Google-Smtp-Source: AGHT+IHpPALSlaU26S1/b/Y8vsgOfeAUtCwow+Dx+j9ExXzmnuNrX6Q2I1NT1cZBfMK9kV0pc+EHwg==
X-Received: by 2002:a5d:548e:0:b0:37d:5436:4a1 with SMTP id ffacd0b85a97d-37d551ab394mr150965f8f.3.1728589654795;
        Thu, 10 Oct 2024 12:47:34 -0700 (PDT)
Received: from localhost ([84.79.205.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf46e96sm57124605e9.18.2024.10.10.12.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:47:34 -0700 (PDT)
From: Roi Martin <jroi.martin@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH] btrfs: fix uninit pointer free on read_alloc_one_name error
Date: Thu, 10 Oct 2024 21:47:17 +0200
Message-ID: <20241010194717.1536428-1-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read_alloc_one_name function does not initialize the name field of
the passed fscrypt_str struct if kmalloc fails to allocate the
corresponding buffer.  Thus, it is not guaranteed that
fscrypt_str.name is initialized when freeing it.

This is a follow-up to the linked patch that fixes the remaining
instances of the bug introduced by commit e43eec81c516 ("btrfs: use
struct qstr instead of name and namelen pairs").

Link: https://lore.kernel.org/linux-btrfs/20241009080833.1355894-1-jroi.martin@gmail.com/
Fixes: e43eec81c516 ("btrfs: use struct qstr instead of name and namelen pairs")
Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
 fs/btrfs/tree-log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e2ed2a791f8f..d2e5781701f9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1845,7 +1845,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 				    struct btrfs_dir_item *di,
 				    struct btrfs_key *key)
 {
-	struct fscrypt_str name;
+	struct fscrypt_str name = { 0 };
 	struct btrfs_dir_item *dir_dst_di;
 	struct btrfs_dir_item *index_dst_di;
 	bool dir_dst_matches = false;
@@ -2125,7 +2125,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_dir_item *di;
-	struct fscrypt_str name;
+	struct fscrypt_str name = { 0 };
 	struct inode *inode = NULL;
 	struct btrfs_key location;
 

base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
-- 
2.46.0


