Return-Path: <linux-btrfs+bounces-7511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27B395F6C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 18:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027C41C21958
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFD7198E6D;
	Mon, 26 Aug 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nod0zaAo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BF197558
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690258; cv=none; b=HYR90B93/zZvqLoQ/iqmd/t9C4qdIxrEFujwwWnyKZkoTedD4lSpAumWraNxz1dwPDEdGdywQq/Fk+aJ2XklG7GtgZ34aXemLZJarBx3xH+V5aDft6HTvPVLhGqehkOFv/Li713Vt6VTSyZN+wmG8HliexNBcWDA6KdpDmKtEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690258; c=relaxed/simple;
	bh=6sYAZUCmjpxoqIQU0tHk/Q9iiNTZFAHgAOzHJ4Fpm2U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxzrymXSCqSNsDB6dYEh/J/hWCaSf/6NraZsM7rTYiYw1dltiilVbYE42OSubuq2Ysyf7MKzbEC/w3zSQwT+M4GxmWw57qT9jNEUbihT+l2LIKBAxamDCo78UFeVSSOG3fn/d2hayZwrz9jqk9WDnpF3E+1ivLtS9zyuR3RRzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nod0zaAo; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-690aabe2600so40211027b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724690255; x=1725295055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm7qw22RjMkP1zkkz1J+rH69AVj2mfYOeGv3FTOwVz8=;
        b=nod0zaAosyvvx0zDcQkXqnPmLTrI/dtz9qHdA9G//x12GATzBzQgMzqkGINEDPhIda
         +b2bZAkGGjXkRPEeelyBZOBL1/XH2mNje0vM1keiF6mRnZOglhdMs/IredqoiO0Q+gVq
         Qo8xzX4/kgjeWO2We6e4Ps161VAxV3Jh0wVwJK1pcCEDIOH9m1H6rXiAAxSb8nbYoKvs
         rOpNPKz0QFw/BcJ086UsQ+3aInTDJy24vb3s/rht7knD9Zaaa0lis7hyhzmEulfMwKou
         rDwJLLcjcQUxYPLBdn5pjPddiVerseiKnH4UxHJGZzj23duDJxrdcjpNF6SiDvG+OqcV
         XFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690255; x=1725295055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm7qw22RjMkP1zkkz1J+rH69AVj2mfYOeGv3FTOwVz8=;
        b=jn+GQlLPvHrfaRF49TXvuAF45AfVrSUeld8pKdvSVCm6+CHwcp107g997nP2dimpbQ
         W5hnVaxFo4wEu/cbljcZswJxl5PCu6m3/ZD2ulfqRvuvwZfgs3pIsKJbJGcFweF66+6J
         JpeUukWsJHS9XOYKK3Z+jVllBJA/StOfrHkPeFSp6JVt9RN7idXalxKwPjEsoNnHXppI
         CEcBu6dXEqqHx+rV9pr2C9hP3yaMID2HcBAzWeYU3t9SL7cAUSKywesjvwoDvSiL3USt
         oeWBNzuXS1AyLcTndVtxIU58TsbjaIv7Mgkw/tEtBtvaDgVsTHzEx5JmO7bULyOSFZfF
         zF4A==
X-Gm-Message-State: AOJu0YwTPLrjNgk7nCY0PzC67edGzBs0XW9pSvp7F1HNMhOYjwR1vDjC
	JXpuN/inRAIV7yV7IK365C1E2bS6Ku8S+x1/j6r/55n9g5tXfELByCYga/huiaqeIgcEBp8Xxbb
	i
X-Google-Smtp-Source: AGHT+IFnUX1h+rafUwXH+AYhWBDFHAqx1jMppLGL9dtj+yxuwwkHTzrXtL01szI1kpaR3cB98yJsVA==
X-Received: by 2002:a05:690c:6c10:b0:64a:3e36:7fd1 with SMTP id 00721157ae682-6c624fb6cfdmr121452577b3.10.1724690255374;
        Mon, 26 Aug 2024 09:37:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3da024sm470984385a.93.2024.08.26.09.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:37:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: take the dio extent lock during O_DIRECT operations
Date: Mon, 26 Aug 2024 12:37:25 -0400
Message-ID: <8586f1fd6eeb9d88758eae9235cd967b3669b2a7.1724690141.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724690141.git.josef@toxicpanda.com>
References: <cover.1724690141.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we hold the extent lock for the entire duration of a read.
This isn't really necessary in the buffered case, we're protected by the
page lock, however it's necessary for O_DIRECT.

For O_DIRECT reads, if we only locked the extent for the part where we
get the extent, we could potentially race with an O_DIRECT write in the
same region.  This isn't really a problem, unless the read is delayed so
much that the write does the CoW, unpins the old extent, and some other
application re-allocates the extent before the read is actually able to
be submitted.  At that point at best we'd have a csum mismatch, but at
worse we could read data that doesn't belong to us.

To address this potential race we need to make sure we don't have
overlapping, concurrent direct io reads and writes.

To accomplish this use the new EXTENT_DIO_LOCKED bit in the direct IO
case in the same spot as the current extent lock.  The writes will take
this while they're creating the ordered extent, which is also used to
make sure concurrent buffered reads or concurrent direct reads are not
allowed to occur, and drop it after the ordered extent is taken.  For
reads it will act as the current read behavior for the EXTENT_LOCKED
bit, we set it when we're starting the read, we clear it in the end_io
to allow other direct writes to continue.

This still has the drawback of disallowing concurrent overlapping direct
reads from occurring, but that exists with the current extent locking.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/direct-io.c | 47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 67adbe9d294a..576f469cacee 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -40,11 +40,22 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 	struct btrfs_ordered_extent *ordered;
 	int ret = 0;
 
+	/* Direct lock must be taken before the extent lock. */
+	if (nowait) {
+		if (!try_lock_dio_extent(io_tree, lockstart, lockend,
+					 cached_state))
+			return -EAGAIN;
+	} else {
+		lock_dio_extent(io_tree, lockstart, lockend, cached_state);
+	}
+
 	while (1) {
 		if (nowait) {
 			if (!try_lock_extent(io_tree, lockstart, lockend,
-					     cached_state))
-				return -EAGAIN;
+					     cached_state)) {
+				ret = -EAGAIN;
+				break;
+			}
 		} else {
 			lock_extent(io_tree, lockstart, lockend, cached_state);
 		}
@@ -120,6 +131,8 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 		cond_resched();
 	}
 
+	if (ret)
+		unlock_dio_extent(io_tree, lockstart, lockend, cached_state);
 	return ret;
 }
 
@@ -546,8 +559,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	}
 
 	if (unlock_extents)
-		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			      &cached_state);
+		clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+				 EXTENT_LOCKED | EXTENT_DIO_LOCKED,
+				 &cached_state);
 	else
 		free_extent_state(cached_state);
 
@@ -572,8 +586,13 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	return 0;
 
 unlock_err:
-	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-		      &cached_state);
+	/*
+	 * Don't use EXTENT_LOCK_BITS here in case we extend it later and forget
+	 * to update this, be explicit that we expect EXTENT_LOCKED and
+	 * EXTENT_DIO_LOCKED to be set here, and so that's what we're clearing.
+	 */
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			 EXTENT_LOCKED | EXTENT_DIO_LOCKED, &cached_state);
 err:
 	if (dio_data->data_space_reserved) {
 		btrfs_free_reserved_data_space(BTRFS_I(inode),
@@ -596,8 +615,9 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (!write && (iomap->type == IOMAP_HOLE)) {
 		/* If reading from a hole, unlock and return */
-		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1,
-			      NULL);
+		clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
+				  pos + length - 1,
+				  EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL);
 		return 0;
 	}
 
@@ -608,8 +628,10 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
 						    pos, length, false);
 		else
-			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
-				      pos + length - 1, NULL);
+			clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
+					 pos + length - 1,
+					 EXTENT_LOCKED | EXTENT_DIO_LOCKED,
+					 NULL);
 		ret = -ENOTBLK;
 	}
 	if (write) {
@@ -641,8 +663,9 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 					    dip->file_offset, dip->bytes,
 					    !bio->bi_status);
 	} else {
-		unlock_extent(&inode->io_tree, dip->file_offset,
-			      dip->file_offset + dip->bytes - 1, NULL);
+		clear_extent_bit(&inode->io_tree, dip->file_offset,
+				 dip->file_offset + dip->bytes - 1,
+				 EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL);
 	}
 
 	bbio->bio.bi_private = bbio->private;
-- 
2.43.0


