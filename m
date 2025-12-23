Return-Path: <linux-btrfs+bounces-19986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C32BCD86B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 09:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62A1530206BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 08:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A72F9D83;
	Tue, 23 Dec 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aOxPLi3c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26C2744F
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766476971; cv=none; b=NhQjOoQjtV6XChUb6QLOsNAG8ydemfZDqcOit51z7MNHZE7mWS+5hg2AHyjz+Ed/e/hiHjGQdvf6xF5odHuEQVrStj4HqCo4V/UxC73Cb70OzS7T5Ng3CY9G164p0bkbaMcvPJiEHCe4WiND5YZTghR+DPblleeVzq9CBIk2Cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766476971; c=relaxed/simple;
	bh=9sxiLrElTI5Ztk43MEmWpEu6IKgM9WAgv2dhiRlK6Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXPC+Dfs6/LGv+r2xnSZDihtyacf8FjPkPETULSRCFHDi7PCaA8o3wlrXtOgIwBNlFbksJZNPu6/ojptwvHrJ0A2DeY1RwPv0YG6hvsNaMElZ2AAzVCZwcEMS6bwDvAXkN0GKybM01+T7CvdLLH9VhhzlqIa9V+/YcCfZVo0mHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aOxPLi3c; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a110548f10so15376665ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 00:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766476969; x=1767081769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTUH1SPKBV/BQ5rzdoe3NdUj8Uqe/XoIX8txSdtTxSM=;
        b=FUKgmu6QvOdokCTY0u0RytdjV9CbkYuf9bK/eUKOWg6hIk/Pa951JpDmnn4udlygJa
         78YVLcsGOwDfLuCxxhgz02/tn3PtJ7RDNoWxqzhRnmysaAl157oYzoDqZbDdNZ4lB5T8
         rw3UcoQDodwknHFy/QtcgkBcVOq6s+Uuh2meT+gb2OGWzWNdpb4xW45ezAvSUnvBsOl+
         6lOWUjdAsnULZHXYX6qh17JaRkaOzYmTe0eGXu6boE09sZOMMOSplfCL9XxM97jSB9q4
         Wd8g9OWHIUzr9pG15s5EBdlo65knOLkCL2YROHFLTl/VcuRLyTvedsQayi398/vay/Ls
         CJDA==
X-Forwarded-Encrypted: i=1; AJvYcCXQOlWUJc1q3Q2QD8dn3tcUtZ3KTl350zo+kuCD28NSBlHLGA4L8kqIcot3DDxl2ZrQqTeuAmI5YwISxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Lzd6RKTr7hNEQx99S6ftU43R3Do0fjVoOr/BxkdAbajONVRf
	cAkiS+Yc+MsL+TAVSK+OviNuB8DdFOR+mAG3zAs7t7gYft/OA15+5y91Wzs3pfQVA2NNkP9U2X8
	02QTmn3fSsWkrT8FQDR2L6vmtS2WKJtOpDY0DLThMu6uFzDkP69LTK5DyurZy3S99AOcJkYJ5Yf
	Va4K7jCRtTH2eMO0actYySzqBfZfDyZL4kWi5zw1w1GB15Cgd4zAeiTLXo/qnHeNiz7NIEhxYdj
	n7ZoTC5zDFNjqBCAqnbTVUuXyELCcDDoLJCpw==
X-Gm-Gg: AY/fxX5013VV8bYLopfFqeA0FQuTeMz5DtBYxB0EKkWYiThXyZ6EfRK3wVJfTDZNkYs
	9ami7bK+bNcCA3RpHUi9YZJwbUPbzC0bTNSJnM0onZNNd57+zZjH52Pqwn+zSCOOA+/W9YOML93
	xoEY55lFWAJeJ0xPLulxYVJ+xHQm/Uo366uEykeniZUoaHB/g+QvvyKLdfGx8+/bKbxpvmGc60h
	IL1QTvXoRluoHwf5sdsPc2FZ6Y78iW+6Cqphk3HyOnETXnuIO9VX8uJBQ4RatLogFSdIkDCYu9j
	Iq2eWtRhhQf/1+O7MisEu988mpw6DD1IlJMr6jJZrfBkYUFjsL6gj3XrDAAYUIhVgQWUue3ad2D
	BDSJDqdNug5PlEcjqul/If5pCLrPMS7Cd1gerradUzQT6VTlziI4YDmNFd9noN3GmI2xb2nq072
	xu7Mgm4jw7Jtu0JTXN+TITOzDGsZwf3c8fYAxRHkomyjy8DTDsd8JqcLz0/9ZkkQ==
X-Google-Smtp-Source: AGHT+IGDUHEg8RlrT/8CpMkXJOECeNqUWlvJ5ELJPTJRKAZYPEdRWBl5MGoZfWl35nyE2Ey04OiUCOGOZYJW
X-Received: by 2002:a17:90b:58e3:b0:332:3ffe:4be5 with SMTP id 98e67ed59e1d1-34e921e63dcmr7940632a91.7.1766476968937;
        Tue, 23 Dec 2025 00:02:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34e9222a786sm1587344a91.6.2025.12.23.00.02.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2025 00:02:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88882c9b4d0so16142696d6.0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766476968; x=1767081768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTUH1SPKBV/BQ5rzdoe3NdUj8Uqe/XoIX8txSdtTxSM=;
        b=aOxPLi3cmG7xNLQbzY81NKyu+rRR6l+tjiEJ0KXp+yP1dDq35nn/DX+SRydMnLGrTz
         p4osyAUEWGiIUbrUPkqeurmuYAN6OQ/vAiGdPb4VEYiFRjqe9fjU85rfKxaWLdcYRRQl
         b9i3K2fz6rZIA83SXRXi2Y/oCuY334/i057wc=
X-Forwarded-Encrypted: i=1; AJvYcCUou+fUvuyRvEHCLxIERRO0dwEcKQelWx3lRkCNQqm44rKtuY38QiRqV2+qHIkHh7X5TbkHepfq17jJOQ==@vger.kernel.org
X-Received: by 2002:a05:622a:11d4:b0:4f3:616c:dbed with SMTP id d75a77b69052e-4f4abbc85d9mr156899391cf.0.1766476967706;
        Tue, 23 Dec 2025 00:02:47 -0800 (PST)
X-Received: by 2002:a05:622a:11d4:b0:4f3:616c:dbed with SMTP id d75a77b69052e-4f4abbc85d9mr156899141cf.0.1766476967188;
        Tue, 23 Dec 2025 00:02:47 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4c46e4aabsm53636071cf.16.2025.12.23.00.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 00:02:46 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Boris Burkov <boris@bur.io>,
	Bin Lan <bin.lan.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y] btrfs: do not clean up repair bio if submit fails
Date: Tue, 23 Dec 2025 08:00:41 +0000
Message-ID: <20251223080041.1428811-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 8cbc3001a3264d998d6b6db3e23f935c158abd4d ]

The submit helper will always run bio_endio() on the bio if it fails to
submit, so cleaning up the bio just leads to a variety of use-after-free
and NULL pointer dereference bugs because we race with the endio
function that is cleaning up the bio.  Instead just return BLK_STS_OK as
the repair function has to continue to process the rest of the pages,
and the endio for the repair bio will do the appropriate cleanup for the
page that it was given.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 fs/btrfs/extent_io.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 489d370ddd60..3d0b854e0c19 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2655,7 +2655,6 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	bool need_validation;
 	struct bio *repair_bio;
 	struct btrfs_io_bio *repair_io_bio;
-	blk_status_t status;
 
 	btrfs_debug(fs_info,
 		   "repair read error: read error at %llu", start);
@@ -2699,13 +2698,13 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 "repair read error: submitting new read to mirror %d, in_validation=%d",
 		    failrec->this_mirror, failrec->in_validation);
 
-	status = submit_bio_hook(inode, repair_bio, failrec->this_mirror,
-				 failrec->bio_flags);
-	if (status) {
-		free_io_failure(failure_tree, tree, failrec);
-		bio_put(repair_bio);
-	}
-	return status;
+	/*
+	 * At this point we have a bio, so any errors from submit_bio_hook()
+	 * will be handled by the endio on the repair_bio, so we can't return an
+	 * error here.
+	 */
+	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->bio_flags);
+	return BLK_STS_OK;
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
-- 
2.43.7


