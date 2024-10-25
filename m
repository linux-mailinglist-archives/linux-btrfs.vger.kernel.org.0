Return-Path: <linux-btrfs+bounces-9162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A879AFA6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 08:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63031C21E62
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 06:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D411B85DB;
	Fri, 25 Oct 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjr+5ps0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780841B395C;
	Fri, 25 Oct 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839325; cv=none; b=M6f9QHCSdPJfZN58nV3Jiox11ezTQqzRt1LTvqcyPsNABnAvVY1z71aD7IUjo7W0Dre1cZf6ZyiLCJSBDSv7OwsBC5dmaBODSlQi7euy+iwVYYyoYmAWcY/qFyQW+wCHYOz69IH6RMR9jWG0L3kjeYPJfu0Telh3UVNm6Sj05Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839325; c=relaxed/simple;
	bh=2MJXttdWv+uPBVxpl7mViWjKnohFQONagE8SjhImBJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7oLIaaE888H4G4As5JGCmwegNJxmh+NQHPLN5BgWsX8fPiram6Mayq2KjbPIoAFecSSaiSAEn5YFOctlg0dduHWileqdNQDi57KCKyLC5jE6uGwbse6xkt+hXiixlZxsGKddOZ/fJZLA4vDjJtsfqDVx3JC4xsoRmY30txxq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjr+5ps0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e681bc315so1175074b3a.0;
        Thu, 24 Oct 2024 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729839322; x=1730444122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpnAfrCWxCV4uziFj97/o8Q3QMblwAnXsQ6CAZtH3u8=;
        b=hjr+5ps0zhiYA7qoguNDmC+oD3HdGAibpYuR0BPHhiRsMR3F5CwxvSp6aAiq8d1JER
         nD9Q2aKjezzSu2Tvn1XEitNcM52ZKthCCCOdwm1SlPySPD1qC8pMTR2W75FnmlKni090
         9ed2Hn1occFHWchCKBG7s2EpBRif79fg90HknOS/PICRfD1CJ+rOWGpW4VcY48hMFOAc
         lpeTm0Az6ebqEc/KiVUyasJ/NPvAMQlee8P2xhlsPN/iHoewVpRcwKjoFdp1IhNlfiEb
         5OHuGFXXNoKELcoDFaccmNXby5lCqHuGRMOuOSvf255SbExhfSLwzgnkoEXQctQFq0zw
         3IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839322; x=1730444122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpnAfrCWxCV4uziFj97/o8Q3QMblwAnXsQ6CAZtH3u8=;
        b=NNt47Jm63BrxgiydD+2s675qs31q0jbrWySs6+WGb4gckP5wph7L7Rzf44nJboxEa+
         spUmEYNBsghC1WOu+NRTn/jBtsSF0gEmbHhfheG3QjdbaIU6SC93HQ4EhUcPilIwIACP
         CZrvX7Za02YiSodGUzrtSY23H83HE18ZrMz4OowX9VbfsXXZ4Kwsv5Mv8eEUoayIt+lL
         FYlXNUPlGW43YIQzaQI1J/Hb55kQC6j3JfNVH/9MHrunLz+jupoHSGIq4WJjEET0hP16
         c5gikY0A+5A1dwnHlpFR0K/n/SUO+aqHrYlivZHVcyQNLWpvLVABZmSFGW7mGPxZ0oEF
         LJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUc57K+dXzEc1H62+ez3egQl6KNsv1O9agjqsir0N1dH2t+1YGnPg9qLKMbBUl64DsSwCl3+BAhyy18oIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmCOdD4TrXsj+Vj+IEFndBiKebQalaeT3fYwMKSbdwffpJI7Km
	qVBmyK25pbRlWcJTWLJfCt64aG7I+PHs0QIfbDVQo+pt5Tx19rWnHymW/TrHAsY=
X-Google-Smtp-Source: AGHT+IHm+ZPWnAqyOGCAsX5H2I+TKHQoYPVEkKIKIoAT1rlEXFaAx9EjfhgvMwkMuXLkg8YXQkuMQw==
X-Received: by 2002:a05:6a00:39a2:b0:71e:4dc5:259a with SMTP id d2e1a72fcca58-72045280660mr8128901b3a.7.1729839322140;
        Thu, 24 Oct 2024 23:55:22 -0700 (PDT)
Received: from VM-213-92-pri.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8685729sm464011a12.37.2024.10.24.23.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:55:21 -0700 (PDT)
From: iamhswang@gmail.com
X-Google-Original-From: haisuwang@tencent.com
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	boris@bur.io,
	linux-kernel@vger.kernel.org,
	iamhswang@gmail.com,
	Haisu Wang <haisuwang@tencent.com>
Subject: [PATCH 2/2] btrfs: simplify regions mark and keep start unchanged in err handling
Date: Fri, 25 Oct 2024 14:54:41 +0800
Message-ID: <20241025065448.3231672-3-haisuwang@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025065448.3231672-1-haisuwang@tencent.com>
References: <20241025065448.3231672-1-haisuwang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haisu Wang <haisuwang@tencent.com>

Simplify the regions mark by using cur_alloc_size only to present
the reserved but may failed to alloced extent. Remove the ram_size
as well since it is always consistent to the cur_alloc_size in the
context. Advanced the start mark in normal path until extent succeed
alloced and keep the start unchanged in error handling path.

PASSed the fstest generic/475 test for a hundred times with quota
enabled. And a modified generic/475 test by removing the sleep time
for a hundred times. About one tenth of the tests do enter the error
handling path due to fail to reserve extent.

Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Haisu Wang <haisuwang@tencent.com>
---
 fs/btrfs/inode.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3646734a7e59..7e67a6d50be2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1359,7 +1359,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	u64 alloc_hint = 0;
 	u64 orig_start = start;
 	u64 num_bytes;
-	unsigned long ram_size;
 	u64 cur_alloc_size = 0;
 	u64 min_alloc_size;
 	u64 blocksize = fs_info->sectorsize;
@@ -1367,7 +1366,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	struct extent_map *em;
 	unsigned clear_bits;
 	unsigned long page_ops;
-	bool extent_reserved = false;
 	int ret = 0;
 
 	if (btrfs_is_free_space_inode(inode)) {
@@ -1421,8 +1419,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		struct btrfs_ordered_extent *ordered;
 		struct btrfs_file_extent file_extent;
 
-		cur_alloc_size = num_bytes;
-		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
+		ret = btrfs_reserve_extent(root, num_bytes, num_bytes,
 					   min_alloc_size, 0, alloc_hint,
 					   &ins, 1, 1);
 		if (ret == -EAGAIN) {
@@ -1453,9 +1450,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret < 0)
 			goto out_unlock;
 		cur_alloc_size = ins.offset;
-		extent_reserved = true;
 
-		ram_size = ins.offset;
 		file_extent.disk_bytenr = ins.objectid;
 		file_extent.disk_num_bytes = ins.offset;
 		file_extent.num_bytes = ins.offset;
@@ -1463,14 +1458,14 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		file_extent.offset = 0;
 		file_extent.compression = BTRFS_COMPRESS_NONE;
 
-		lock_extent(&inode->io_tree, start, start + ram_size - 1,
+		lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
 			    &cached);
 
 		em = btrfs_create_io_em(inode, start, &file_extent,
 					BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(em)) {
 			unlock_extent(&inode->io_tree, start,
-				      start + ram_size - 1, &cached);
+				      start + cur_alloc_size - 1, &cached);
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
@@ -1480,7 +1475,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 						     1 << BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(ordered)) {
 			unlock_extent(&inode->io_tree, start,
-				      start + ram_size - 1, &cached);
+				      start + cur_alloc_size - 1, &cached);
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
 		}
@@ -1501,7 +1496,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 */
 			if (ret)
 				btrfs_drop_extent_map_range(inode, start,
-							    start + ram_size - 1,
+							    start + cur_alloc_size - 1,
 							    false);
 		}
 		btrfs_put_ordered_extent(ordered);
@@ -1519,7 +1514,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
 		page_ops |= PAGE_SET_ORDERED;
 
-		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
+		extent_clear_unlock_delalloc(inode, start, start + cur_alloc_size - 1,
 					     locked_folio, &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC,
 					     page_ops);
@@ -1529,7 +1524,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			num_bytes -= cur_alloc_size;
 		alloc_hint = ins.objectid + ins.offset;
 		start += cur_alloc_size;
-		extent_reserved = false;
+		cur_alloc_size = 0;
 
 		/*
 		 * btrfs_reloc_clone_csums() error, since start is increased
@@ -1545,7 +1540,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	return ret;
 
 out_drop_extent_cache:
-	btrfs_drop_extent_map_range(inode, start, start + ram_size - 1, false);
+	btrfs_drop_extent_map_range(inode, start, start + cur_alloc_size - 1, false);
 out_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
@@ -1599,13 +1594,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * to decrement again the data space_info's bytes_may_use counter,
 	 * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
 	 */
-	if (extent_reserved) {
+	if (cur_alloc_size) {
 		extent_clear_unlock_delalloc(inode, start,
 					     start + cur_alloc_size - 1,
 					     locked_folio, &cached, clear_bits,
 					     page_ops);
 		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
-		start += cur_alloc_size;
 	}
 
 	/*
@@ -1614,11 +1608,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * space_info's bytes_may_use counter, reserved in
 	 * btrfs_check_data_free_space().
 	 */
-	if (start < end) {
+	if (start + cur_alloc_size < end) {
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
-		extent_clear_unlock_delalloc(inode, start, end, locked_folio,
+		extent_clear_unlock_delalloc(inode, start + cur_alloc_size,
+					     end, locked_folio,
 					     &cached, clear_bits, page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
+		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
+				end - start - cur_alloc_size + 1, NULL);
 	}
 	return ret;
 }
-- 
2.43.5


