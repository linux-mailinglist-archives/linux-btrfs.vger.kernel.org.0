Return-Path: <linux-btrfs+bounces-6770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4C93D91E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D170D1C23167
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574C614F108;
	Fri, 26 Jul 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3a6Ckckd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA614EC4E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022631; cv=none; b=igFzVtGfvHChbx3wyLkI/USBLHKauwjhS3oquSvfIY0WEKrz0XnpbxF9Sqdzd0gQVP9BnkkSBkeMLy3gDQi0tsHN62LYzJi9CsRLKmfthO6eU4SxQ1eyd2QCc0/FbvIcnpb0FN+dURjm8XJ6EWl7sYJJrgbrH2dDL5C4oFpHUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022631; c=relaxed/simple;
	bh=CAf2UpMV19L4WUW48ckmb8R3dcNGjV128CKSGQiVUgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+rC8hRcT0jgEwjPDkUcsZV5el8OmCJJJ8Mksi9m5j9giU/qrgwfUO10wrGK8R1BcbdPpKlxuceLoyPnr1HEKO74lT0zwrxhYPuCApZ58MXymmLrHbX0Jx1L/ixo7dJXPCCtnd/BFBmUExMkVhqfOJJhHx2TMLxrJREeNN+2OXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3a6Ckckd; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-67682149265so382017b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022629; x=1722627429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSKpljHV3Uo0sCNLwHxpIQpbtwjDivLUc2p915iNNkg=;
        b=3a6CkckdWasLXIGlgIg1sGsckIFN7MpTGZ1xVbHmd6a43cSdKNRM8UEJLi9z8chbKu
         EXZmxiUqWL4NMsyYuc/lPHiYksdoV65+iS7LM5DTHdunx6bgZYXRxG/VDpq9At81M5Lw
         mMayKuI2xlhRK9aS5+gl68ltaFSEtJikCC0IgbQ8444wGMVk/xIGfTb3oZqqXtdevncl
         i1Jx7as0cczlqRP9IeaeYKf0Bgu9OOtGYafKnREO452d01YGNUgRgl4YivMmHil82rVu
         MOFTLuTb9ePx3gjrjix3tT1+wpx6aCeWcC1PhsaA8JLgsvpcl9OCoYXoAa+qBpFLWeBM
         Yb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022629; x=1722627429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSKpljHV3Uo0sCNLwHxpIQpbtwjDivLUc2p915iNNkg=;
        b=omy3cnKV8HKOZWBL/KqpksM6cSP4fS94IhZX60rnrhGpNBkljyX9jIBdBvleF6zZIs
         y5fRbYtEHk689mT8Sdx2krkGtBhx4JPhMRrLAZvTxakoHcgX/tJgi/qhbTWrjL1IWZaW
         Sj2sw5NQ/McQC1cFZlwjs5ByJxZ0jnwCwt3Lvt94sVzbBpBQudIWIKSPBZRJOI/g4QrR
         A8L4y4EcmO5KYLB5Oqy3lQcDVmVf+uoZgbwRNY9IUtc7qBzQNds3MyRlKau/AT9m6WrB
         PWnlWhCo8hiHU7VMvDCQ/wz7vraFKiiCuevolgo4J0tqRTcGUSSam3Yan6QMTkW5XYUa
         ldrA==
X-Gm-Message-State: AOJu0YyjplMzb73PJlEujHK78dmfYzWV5iIphEgk6U1ulyx0obofY4qY
	Hj25cR/Cw3WKny8kUAnvD5nI0PxAIqaTmEnr40bx6VzO5OVHFFXMio+ON/Twy2rcken2HIkjfoT
	Z
X-Google-Smtp-Source: AGHT+IHkmVuZg+ByiY2hLs18u2aeTH2PJOeAGGx1yz+QuVkBpH9lDW85K3jeLkHoQLw1sqOnzOdmcg==
X-Received: by 2002:a0d:c983:0:b0:62f:945a:7bb1 with SMTP id 00721157ae682-67a0a323dc1mr8640837b3.42.1722022629202;
        Fri, 26 Jul 2024 12:37:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e61csm10033467b3.42.2024.07.26.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 30/46] btrfs: convert btrfs_cleanup_ordered_extents to take a folio
Date: Fri, 26 Jul 2024 15:36:17 -0400
Message-ID: <6987e88d64a5755e57742d39dbf2b5b690363e48.1722022377.git.josef@toxicpanda.com>
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

Now that btrfs_cleanup_ordered_extents is operating mostly with folios,
update it to use a folio instead of a page, and the update the function
and the callers as appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d1c81a368b52..76fa9b1e0f11 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -393,7 +393,7 @@ void btrfs_inode_unlock(struct btrfs_inode *inode, unsigned int ilock_flags)
  * extent (btrfs_finish_ordered_io()).
  */
 static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
-						 struct page *locked_page,
+						 struct folio *locked_folio,
 						 u64 offset, u64 bytes)
 {
 	unsigned long index = offset >> PAGE_SHIFT;
@@ -401,9 +401,9 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 	u64 page_start = 0, page_end = 0;
 	struct folio *folio;
 
-	if (locked_page) {
-		page_start = page_offset(locked_page);
-		page_end = page_start + PAGE_SIZE - 1;
+	if (locked_folio) {
+		page_start = folio_pos(locked_folio);
+		page_end = page_start + folio_size(locked_folio) - 1;
 	}
 
 	while (index <= end_index) {
@@ -417,7 +417,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		 * btrfs_mark_ordered_io_finished() would skip the accounting
 		 * for the page range, and the ordered extent will never finish.
 		 */
-		if (locked_page && index == (page_start >> PAGE_SHIFT)) {
+		if (locked_folio && index == (page_start >> PAGE_SHIFT)) {
 			index++;
 			continue;
 		}
@@ -436,9 +436,9 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		folio_put(folio);
 	}
 
-	if (locked_page) {
+	if (locked_folio) {
 		/* The locked page covers the full range, nothing needs to be done */
-		if (bytes + offset <= page_start + PAGE_SIZE)
+		if (bytes + offset <= page_start + folio_size(locked_folio))
 			return;
 		/*
 		 * In case this page belongs to the delalloc range being
@@ -447,8 +447,9 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		 * run_delalloc_range
 		 */
 		if (page_start >= offset && page_end <= (offset + bytes - 1)) {
-			bytes = offset + bytes - page_offset(locked_page) - PAGE_SIZE;
-			offset = page_offset(locked_page) + PAGE_SIZE;
+			bytes = offset + bytes - folio_pos(locked_folio) -
+				folio_size(locked_folio);
+			offset = folio_pos(locked_folio) + folio_size(locked_folio);
 		}
 	}
 
@@ -1138,7 +1139,8 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			       &wbc, false);
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, page_folio(locked_page),
+					      start, end - start + 1);
 		if (locked_page) {
 			const u64 page_start = page_offset(locked_page);
 
@@ -2317,8 +2319,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 
 out:
 	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, locked_page, start,
-					      end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, page_folio(locked_page),
+					      start, end - start + 1);
 	return ret;
 }
 
-- 
2.43.0


