Return-Path: <linux-btrfs+bounces-4606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FDE8B59EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C9D285D81
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B5073534;
	Mon, 29 Apr 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ze23JWfm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D567172F
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397401; cv=none; b=kRb6fZS37NN9eXtBgMaboNaOHdoBNs1UXm9y6Fp2NVe+IJ6Hbovc/0yW7u62k0om/9tnetS3P0mqOTGtk6e3UpaE1idUnO1ZrB6w/KUKST7QqThG2U/Uf7W3C5SSoKDfCPnXFKlod9x0u624s70m80xgYSdot/BHzTOeYQKWoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397401; c=relaxed/simple;
	bh=HRe/cY89W88DPjqUozx9WNddjUI5Jt2zRhFofBo1x24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a79iYYfuMt33jAElEvCJhV3FN01fLyTOE0oTR0saWkZUW5jxc2H+pEAIicKGsg/FufghAiReb9GbRi9MoHwd+udPhKLfPoqSZoDz6//pOmIcvfynjmZmMJ5x592CgQVgmcNSR5RbTgkNlPiFDT7GhhoiLFL+sWOMzocGpvnrZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ze23JWfm; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c709e5e4f9so2861453b6e.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397399; x=1715002199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccXBod5dCco1QGMkPtLIUd6x9rTE1uxOFGGOETtDk7k=;
        b=ze23JWfmmuKEBlg8mI7geFR3AxQn1aMBrzoMV9d6vheEPuOzUasw4gWg5uqmoA0rgS
         wBqK76AV3LP2rkNKbftNuc8jhwhmZOlc5XtZ7hdZcAN2a6XVRsxwQ7gOZPdjmJXdBUSZ
         sMO9eRjf2Ghuv76c4p0S/RsgsuWVZJEPnen1sNZsSsZFNhkTQmyq9tQQqiIjY2WCu1nD
         h8M7NgWhwYAuEMDDr+TeVu8yjFsOnBain8Em3LDws6h4oZxA+IawRbupn7OdD2I30hUX
         4UJbmyY/TIoVM/FK4J5mSitG4VpIkwRoecdNACnJ+7pYIMVj6/s/QKmBMwzrqGit4qRt
         xewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397399; x=1715002199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccXBod5dCco1QGMkPtLIUd6x9rTE1uxOFGGOETtDk7k=;
        b=D+4LRwvViiF0YgNkmsrPS7sQlEWZ37KZxTVDPBk0GubabrDWfdIXUGVG6PQK+yuL3y
         JE2u3TVcxGaeifz1TneiuERrPvpZMY3Vwva15ApgTwWtzQac1XrWC8RDoCj232hsjue1
         h1j42cmknmhJuUb5EjxCKrmzBGIBJb1V+25WohVy1KkECveJVVy+osvk2l3KSdiGjPKb
         g0ujl2q9OHYsp1pRIwMTOiLxXih8XIM+LWVtslxv2Wm79MrH7PeTjOLOZJ+9RQKZUG+U
         ywAz8NKt1sERjXNxn7FLH6D9vDyd/8pqKBSAlQn8xt+gIYfTMuBDDcku+b2WSoTLG4Pk
         AVjw==
X-Gm-Message-State: AOJu0YyIxjw6zBYOAhBX5LN1NPxZykvVkZIZVUJxJdO0oPRbIphPDBPV
	Gf+ViW9nnAap2JMNNZzLL2BqKhAfzF47rkC47qBUlLrKyN/34hcMndg6S3q7OK44MGRiUeBWWaD
	n
X-Google-Smtp-Source: AGHT+IElKeOETBgr3UgYGmiBh6MgFFEpk3V0EySd64a2oDGHh6/sEbcPaBLFlBMKpImM3iFGDNtZYw==
X-Received: by 2002:a05:6808:358:b0:3c6:e81:4272 with SMTP id j24-20020a056808035800b003c60e814272mr11166817oie.10.1714397399213;
        Mon, 29 Apr 2024 06:29:59 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d13-20020a0cc68d000000b006a0d46d13bfsm407872qvj.69.2024.04.29.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:29:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 03/15] btrfs: use btrfs_read_extent_buffer in do_walk_down
Date: Mon, 29 Apr 2024 09:29:38 -0400
Message-ID: <f929b9b31654e588b4cf3961d4f52cc326695b5e.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
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
index d020ee1a6473..fa59a0b5bc2d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5507,22 +5507,15 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
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


