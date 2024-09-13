Return-Path: <linux-btrfs+bounces-8013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C843978BE0
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 01:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35BF289C3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 23:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21117838B;
	Fri, 13 Sep 2024 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va7jAcvT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885601474C5
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726270247; cv=none; b=Gbfl1x4WJ2/kBeFtM/vC9rH+bXQTaky2m8V2cq0x4y5Bsb2eiqXLgrYe+qnHtzNv6LHeG3Pq3MMvmpwp0On4LUhh9qy1bcmZrGK44GNAg8xUrnknz94e+5XI/E9YnSwMl+fLPIr/QGlB14OqUfBgfenmgfiHRXK3SWhuhc4MZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726270247; c=relaxed/simple;
	bh=OtwflSISu36AdtmYTnwUMT4QM+kfpwumJ+U8Ao3YS3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pu/o/qPnb7oX3xQgjyyYnvYSIpKJzJWNIr07yMkrVunvSsPzsxEW669DckCkRZL2swEuUak7usWIsQzY796ll1iokB1EGNk4ZjeA4YIx15jkXOHJfc/cTz8dpkJHDEkGcenHdfqggF4MhAKRqKPGc7LBwQKmww6zf5b7XfoHUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va7jAcvT; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3e034fac53bso625385b6e.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726270244; x=1726875044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIGNxVzR0VnNS5lNUbo1YO1lNTW2hK6w5JFS8wBkhNk=;
        b=Va7jAcvTy+xEGRUCR2hlgfJkMxuKvSMSg45+xt3QdTLVK057E0lR6hD7bnSvVBWsoy
         mfu32cTYO5foylP7x0qr/3Y0w2Us0KBSt5w6tc/R/gGPTVdjaMqnmTiZ0ghR7FYcjLqd
         gmlFHKOYoLY10DwXeY9rFKvUgPiZ+LdgFeuuzHeOj79iFF04ZukaE7dHal6WknL1V53l
         WAWe8gSUhL4jliOYcuoiUYJZUosd/PF7GD+yotN0kj1TwedlP921iHT0ZPeDs/DVnePl
         hTdG0OzWEZbvPiANrMKI5iIeAqLOTWCSMZUlFTxvWp4andQ8UzMs2Xc2gXcd3EKgw/ra
         mspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726270244; x=1726875044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIGNxVzR0VnNS5lNUbo1YO1lNTW2hK6w5JFS8wBkhNk=;
        b=kq0BjwWUMVriK5rsp10n/H+rMBEZYOutbKKnBOby6k0mIHPjOMOMmvJD8QV783fEQL
         JFzlbSqCCKlo5EPalzbKrRK4YAnQgrhMwAUTdmZRHDbrLmea95p/sqxHW+W3XO2/DKAy
         KDe5GblLpulndUErUQFRWYZm2f7TwDh89Z+jSehH9ihUMCNQI4YAskYyAzA7+7jUrslS
         LS+wOAnF/fJN6s6mQeC/Ju7I7m8wpHkMwycGVDGUHdinBLcNoppry45SmXwU7EBRvguZ
         GRUSMzunU57/9UNFfrFvTG0BvPbD6AFVN+wCMXFBolchMr2X56gxo6rzw0fQWVK9BnNn
         FdXw==
X-Gm-Message-State: AOJu0YyO1SZyJnOfh7zH/uRVZR7ys0GzDUFiQ2ILK91DsdC3DiknGxHf
	wukbi5yO9AHleHO29jOAMZ9aYjyMcFhpGivlAnijVK0H7WHoJpE3D5r/H15P
X-Google-Smtp-Source: AGHT+IEmqSrBskl58Kg5JiUGfxKYxMSLlFbgA6rW6SuylG+EkUYu+Z5c/lavsrwk2wlqlalGbevMug==
X-Received: by 2002:a05:6830:3103:b0:710:fe9b:d55c with SMTP id 46e09a7af769-71116bce5femr2451526a34.2.1726270243832;
        Fri, 13 Sep 2024 16:30:43 -0700 (PDT)
Received: from localhost (fwdproxy-eag-006.fbsv.net. [2a03:2880:3ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b0d971d0sm77281eaf.20.2024.09.13.16.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:30:42 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs-progs: remove free space when block group freed
Date: Fri, 13 Sep 2024 16:30:16 -0700
Message-ID: <083c235db86e27f6191fc938fd5f61c980cc5e18.1726269996.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the upstream equivalent of btrfs_remove_block_group(), the
function remove_block_group_free_space() is called to delete free
spaces associated with the block group being freed. However, this
function is defined in btrfs-progs but not called anywhere.

To address this issue, I added a call to
remove_block_group_free_space() in btrfs_remove_block_group(). This
ensures that the free spaces are properly deleted when a block group
is removed.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 kernel-shared/extent-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index af04b9ea..df843862 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3536,6 +3536,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
+	/* delete free space items associated with this block group */
+	remove_block_group_free_space(trans, block_group);
+
 	/* Now release the block_group_cache */
 	ret = free_block_group_cache(trans, fs_info, bytenr, len);
 	btrfs_unpin_extent(fs_info, bytenr, len);
-- 
2.43.5


