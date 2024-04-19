Return-Path: <linux-btrfs+bounces-4441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A18AB4F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63A91F213B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC613C902;
	Fri, 19 Apr 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LkXiNJbf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BC13C3F9
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550641; cv=none; b=VgF/cALWiXuwdl34WNaXO/qqE4iMSNGfr/JwpB2qSipTA/5fqhUiini4OpQty7fCv+s1J4GSgK0/Jq/1+h3SO/6hKY6eBstHAe9liNg4IZQo752paV0aMkEsM9seXgOiIFSy3WME6fVfF5Mm1svQBGP0Cm5xev7Pd4r2b/0a4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550641; c=relaxed/simple;
	bh=2lbu7MlZ20OCPUMDY7PD15w3ICPg8Sl1AeFxPWiwIC8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb4wz+m6LGolbtNiGwQHCB31eZBUm28yt+KJVtfACAYe4ZwjnVlZjNFpRCNL2ys3g4GOyX+Q/w4a/CwPdlTbc+MGIj/1F4NX0tWGZv4GgsfJCucxQdwMf+L7RGgnA4q0xFcu1/R2612NEPs/qWg18auGcmQWV2og1YlBeV9WBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LkXiNJbf; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ad211d3370so341058eaf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550638; x=1714155438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gByU/8pUjCoMe84UQHkVi5p3TEOKUhAcnFsVY0GJioY=;
        b=LkXiNJbfHSB4+O7cCFYdpZ4ZxXMkl+YLGP5vJ0z8UQds+X5Ysg5ap6/dBuenKJenhI
         w+JQ3HVllOdkp45EZcxbTx1QGu7/eR+YRKGqcW5+vjtd+9c+DPZFk8vqY1ZWiyjMmm16
         qd+GVmKTtpbp0PsoX0gL94nnVe9JVrAjtDrGnpAf6oYuPUbcR2tgJ+rgcMTERjlp2nzw
         7Q85+5xO6ToFOX5+0iZbopGKBnne3x76dBHcI9g8rK4IOI3/UNKkZRT3dQnGQ+84XwAY
         0Xzbxp2q3gGmQqpnOEYB7VYQOmt6WnbOwD2Gcb6eRTbDMc6v0C5ALvmGzbQskULArcN0
         bMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550638; x=1714155438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gByU/8pUjCoMe84UQHkVi5p3TEOKUhAcnFsVY0GJioY=;
        b=cjf2nHvJdmoPqENIS0IlM/jf4smjg484RdKOx/iBiI1ZwqMhs+Ttfu/NfRceBaxlO3
         ht/0KjzkXIsFGeVZB++uFK5yizS+6GPRa9oouM9Kl3FaUYXqpDJnVDL48stGy9VbmuX0
         cKoPaEYIriwbNeAj1jwzqCH9MeBC/cPJ89Lpdap9aHlih9iiwN7+3MCEbyJPDMYuRJKA
         yAtJlFZwLDh1O5PhaNJMoUaf/h93n3jQUbVdjc7kE2m2n471N8XNRUwVTo7DtLf37InW
         yQuObeXtxQXPeO9wiMzDmebTxCYAIofRhostxqncBGEOnU/LZEhNhyuBmEEwrO+n6j1K
         0mYg==
X-Gm-Message-State: AOJu0Yzj7fAKi5tc0TYbe/8Y5mRxPmlx9uM0PeQxyruvDxJD7/QUMfzT
	/OPCmVk0ie7mt3vUVjIsmILUUmCO2qPnZ3BdM9lNR7f+vxljNViohPaOOV7e6P61p3Uxxe1ii2H
	O
X-Google-Smtp-Source: AGHT+IHCgkWUouO8+KWBPulD7k0Py+6n5Vlu8RAXV4cR/O/5srif5vvfTgXmBexouXac1f6ratCuVg==
X-Received: by 2002:a05:6358:4b09:b0:186:d3c9:fc0b with SMTP id kr9-20020a0563584b0900b00186d3c9fc0bmr3481486rwc.30.1713550638550;
        Fri, 19 Apr 2024 11:17:18 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l12-20020a0ce08c000000b0069b5acd4645sm1749116qvk.82.2024.04.19.11.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 03/15] btrfs: use btrfs_read_extent_buffer in do_walk_down
Date: Fri, 19 Apr 2024 14:16:58 -0400
Message-ID: <469a21efbd9050203d1e150004ecafa3c312aa05.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if our extent buffer isn't uptodate we will drop the lock,
free it, and then call read_tree_block() for the bytenr.  This is
inefficient, we already have the extent buffer, we can simply call
btrfs_read_extent_buffer().

Collapse these two cases down into one if statement, if we are not
uptodate we can drop the lock, trigger readahead, and do the read using
btrfs_read_extent_buffer(), and carry on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 64bb8c69e57a..b8ef918ee440 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5508,22 +5508,15 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	if (!btrfs_buffer_uptodate(next, generation, 0)) {
 		btrfs_tree_unlock(next);
-		free_extent_buffer(next);
-		next = NULL;
-		*lookup_info = 1;
-	}
-
-	if (!next) {
 		if (level == 1)
 			reada_walk_down(trans, root, wc, path);
-		next = read_tree_block(fs_info, bytenr, &check);
-		if (IS_ERR(next)) {
-			return PTR_ERR(next);
-		} else if (!extent_buffer_uptodate(next)) {
+		ret = btrfs_read_extent_buffer(next, &check);
+		if (ret) {
 			free_extent_buffer(next);
-			return -EIO;
+			return ret;
 		}
 		btrfs_tree_lock(next);
+		*lookup_info = 1;
 	}
 
 	level--;
-- 
2.43.0


