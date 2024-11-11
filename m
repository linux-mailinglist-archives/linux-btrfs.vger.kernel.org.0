Return-Path: <linux-btrfs+bounces-9475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA49C4A32
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 00:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EE61F21BFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 23:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441661E04AE;
	Mon, 11 Nov 2024 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MQOeFTKf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF031D07AA
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368953; cv=none; b=Ag1ufTRnkz+fKMdv8uzuB53MZ4qGj73pzMYhgDJiCJZ5094VVq4/h+xL8hBhGDT+mPLONZSjAMnvhyRkZcjSVJdJIehKmyCKx3WHS0YBxCrAhwj6+06uPDOESJJwEmWDSZwD/Bw4z49r3ebIDyLPxjLCHl9RjBWn7yQW2kA7ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368953; c=relaxed/simple;
	bh=JN6ziuaz3h3w93syhui0sSuROUWYBUO3x3xlg3f4CsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEJcL68cM1uWF5EY3nl24B4vRhhJ16go3Z/ca90q/7vLY7xx+TzfkqkSAQQveym5loAYpCqP8jBXctT1X9kOwaueLpDkAkkdeyaXqI6clnUW42aVwYGxAfVJ5ua2kw3xsQCcKX1pma5dOo373I3Dj9p7j05wKIsu+wpJJI5kH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MQOeFTKf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7240d93fffdso4129979b3a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 15:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368950; x=1731973750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=MQOeFTKfgntx/fL0KS1w5ehtnzLw2J47Mgw4aCD7qt3FE0GsZguoRF9UzEZDgQNRgw
         aFV52MGH6xiQKxHGYiA1kQ5dpioB9Eb2OR4Hcr1snqxBl+9BCvPqY53HaGpaY5Dv+Kxt
         5uSsPI702LUrz9n1i44B0UVSu0D/HdbH9sI6vGKOckND5vcI7xCVX4UyWAKHjqOvqbeV
         H6z2/+sDDjg6Ql5St4JCD+3NCRqUcBKc2ATPKwnEKp4Z874xUa6nZGAqIBzYYA1Ms9TM
         2EC1Jigln0/b4vOYbtqVWAsGezZdc3xX9GQP/UGaLCY75z7A1NSNfrTGydecQF7a/u2V
         zVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368950; x=1731973750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=kohAXKeoFkwjAxpgzr6gHNKZGL8sWLDpwkSznBDM6XssSLaKmEy17Mao33KwvEInX0
         pJGt9KO56xX0noSbAeqJpF5iq74cksj7ZuKljysg0TnW+9F6i/TLON+ex6cDjTadh4dD
         W5nO6c+CfZ6svHeaOjaOzLnZJUpTLqdDiPAEzEN2SLMdonFRb3bzyr52lJJiQ+9CdEcU
         OqwPB6UbRaOPF5ucVU4omKgXGrt9kzN8GCq35ciSBIILJscSaO9FB4pn/33Z2rXgOL5z
         Jf7WRxJwqvo85hfGLk1wyCD54n4auZc9/lguLR+/RLDnQfKdy5fUIfQmEITHpuF1Bq6q
         hYyw==
X-Forwarded-Encrypted: i=1; AJvYcCX3FyrgYB/5E9Do7tAmQ1l33Tp/rdptykfeVtKBCucN4gyxqXwXWEgvqSxJhweedvpopwkdt3jRUBLyeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOhkVl6Mtz6dmQax6qdYpeBVPKpm46g++NULM8nJRMEIt0sxp
	aQ0MeNzSrMWny9bTNF7lGUcvgk9xGxSG9R+tpc0bqS7tAtULbe2kYlBj6kOPoX3l/9p5GnW4tX8
	BGiI=
X-Google-Smtp-Source: AGHT+IGxdsMu1dfGOYWXi1R28aWFhjsN5Q3I34Dwpy3CjKRXcDtvBr7LZlUVTVK3RyQbj+sGtC8u7g==
X-Received: by 2002:a05:6a00:3a29:b0:71e:680d:5e94 with SMTP id d2e1a72fcca58-724133510d7mr19932677b3a.19.1731368949731;
        Mon, 11 Nov 2024 15:49:09 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:49:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/16] xfs: punt uncached write completions to the completion wq
Date: Mon, 11 Nov 2024 16:37:41 -0700
Message-ID: <20241111234842.2024180-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They need non-irq context guaranteed, to be able to prune ranges from
the page cache. Treat them like unwritten extents and punt them to the
completion workqueue.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a577097..c86fc2b8f344 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -416,9 +416,12 @@ xfs_prepare_ioend(
 
 	memalloc_nofs_restore(nofs_flag);
 
-	/* send ioends that might require a transaction to the completion wq */
+	/*
+	 * Send ioends that might require a transaction or need blocking
+	 * context to the completion wq
+	 */
 	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
-	    (ioend->io_flags & IOMAP_F_SHARED))
+	    (ioend->io_flags & (IOMAP_F_SHARED|IOMAP_F_UNCACHED)))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 	return status;
 }
-- 
2.45.2


