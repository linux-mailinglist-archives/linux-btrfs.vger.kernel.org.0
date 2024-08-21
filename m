Return-Path: <linux-btrfs+bounces-7367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762195A254
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E6A2877DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312501509A0;
	Wed, 21 Aug 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QKBo5gwC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4714EC64
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256132; cv=none; b=T6644J/wTdKQlw2MKDz+MEXRU5tM2usOZPlE5qc243qZ8cP3lJjdRd0+5A+SeShj/GiQbQegsZ1B5sc10JCJ225IQxcOu9Nr4Uiw81F8P/AbGL7iBceALzIsGVQ/rA0tepBcPNQML8YzgBvkSJuJEKm6OyugbcC0925LeWAhhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256132; c=relaxed/simple;
	bh=6sYAZUCmjpxoqIQU0tHk/Q9iiNTZFAHgAOzHJ4Fpm2U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSyDp9yVcKjU0bXFz47rElu1wVJcEc8XiFb6ehICAVnqcTR4Jb8ox1zR0VLdN/wNtE5+8p0Xi3EF7O7MtkVyjpTt8DEnHBqfz8CYdejNfalWANlHEALHEQga8wZUciTBD5yDdVlK/j1G+t+KSo6b10TYiP7zfKNW2VOS8adlJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QKBo5gwC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-709428a9469so4326623a34.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724256129; x=1724860929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm7qw22RjMkP1zkkz1J+rH69AVj2mfYOeGv3FTOwVz8=;
        b=QKBo5gwCS5T/o8onWJf4Z4thKlpBYg3k5wZnh3hP+GAwF3FAMlSwwJ8+cOXPxdV13v
         MfJBS238+owaCR/NoOv5zxsOOBd9aBFTJTKVvc6bTXaGhkJ4aqSq0k2IOh5rn9+JivGV
         aW/FEDsGsBpZyZMLWecfDszLIZ1pXfohNxYxQuhJwUbUMU90FMELCcaQ2yF8OZRXJGlZ
         AB4Z1UqsuXSXnyBX8DJaHPPEMz/qtRKtn3RGOVESZzK+PQriz2BsGoUeyPiYrbrTu1uK
         pRaEWm9nIczhOa1f1HqYenGsN0xdRs4XMTZYfbF/NsN70zm7v2RVvRmLrI2lTh81Sx6k
         Ck1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256129; x=1724860929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm7qw22RjMkP1zkkz1J+rH69AVj2mfYOeGv3FTOwVz8=;
        b=Ni+/9auYIVepP9rc0SQIqH5o9zooBCcdeh9wioop12pg88RSeie6S2QqQfSxCUxwr9
         LOm0hyIK4GYHl/mWTXww7Gc+SAPexSfOufs/lrr+Zl/+V2ZIkvreiwDElM0P2e83f8i/
         RKMefaKJQnDOkyCeXTYumXO4XMGOPn8e3efMzg6y/VK2mILsahl7hmnroTIaM4s2ITvN
         H2Hdw4xmLrycUoEtJnYaZma4Q/tFCfMJyZi2h2U2S0bxLDqMW9PQESv5XUv8LprDpiVy
         gTv/FicqaIYoiUpsR4kmbExVyei0sxa6cLwtdJe/8ZcsfkmXYBhi7Jrr2A0p6bAwYj1z
         Ynpw==
X-Gm-Message-State: AOJu0YyNxlvkrl8HVbMrl24dhzTbM1dDEsJxKe7LqDJGS/QB5OdCkbUF
	DsgTXHlyJsLXw++sbX/suAHp50X4LItlPyRuaj/ylMK32rt2XkL4uU29UfbcSGWJjN9j3rfniha
	1
X-Google-Smtp-Source: AGHT+IHydACgd70cMX4uDt4PS/BbZMEoKFkZ7XsAH54/fOy7sgSjbWypBVJxcel+iwLiA5eMZLyvXA==
X-Received: by 2002:a05:6830:698b:b0:703:79f5:fabb with SMTP id 46e09a7af769-70df8700014mr3230157a34.11.1724256128476;
        Wed, 21 Aug 2024 09:02:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9d823bbesm22423257b3.106.2024.08.21.09.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:02:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: take the dio extent lock during O_DIRECT operations
Date: Wed, 21 Aug 2024 12:02:00 -0400
Message-ID: <defb396ebd042495c1501b999af73451ec9d07d7.1724255475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724255475.git.josef@toxicpanda.com>
References: <cover.1724255475.git.josef@toxicpanda.com>
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


