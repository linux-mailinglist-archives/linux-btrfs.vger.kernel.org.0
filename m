Return-Path: <linux-btrfs+bounces-4451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF08AB4FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC88284337
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84613D24C;
	Fri, 19 Apr 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Cq103nMC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A413CFB9
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550653; cv=none; b=S29gxYfrRwwx/TpQpYyzm/DkhOYSG/bFQbqjarMLobcB1E2Boqon6GwiEOqoVNe8tdqa+62V7JjBSoQDFdFrcqu2vMrRJExbkk6PB64uqYuG/T9F6ExxCg7aD+/Po6kDKKCtx2AJGedL4QJvDn8+qaBm8XxLjqMNMlODiKh523w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550653; c=relaxed/simple;
	bh=zNwsJO4RReHMEO+kXEi5z6GIb8b3QDhI0tBj5Qsgqf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB7KhhJYixFejyP0hsUclzjLK02y9MO56STv6b3y24tM6L1Gf3fRTHpY+SAcpFPd+oVJsJNs9447rq37dQixsjJToFW9Y4eMG3oHMyFMfOzU08/l06dsAuFl+2bcV8GQWwOyjaB0dhqMwasnb6otRLGrkrloOJC4yZbVHmQO5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Cq103nMC; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c60adf3474so1453112b6e.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550650; x=1714155450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7Qup1YQZSsagIf8Cv6SwXyCxu5zOUCz8W3WQpzckZM=;
        b=Cq103nMC00wXlIinIvchGnlXqKZQsR8kYBGtizQ9MIn7TuBpJl+JMokjuFXiM+vg9M
         NZfL8ChZ77s99zutVsGvvfy8qBddAK+nt07annIWqr2nydcry8A/5JKJYQzpAe/mgXpB
         7kNBliP15KEvqBGZ8lVzxxNm4JbVAIKd5a+ptPHQSH+0MW5MAqpWg+9wqcyeMHtG44hL
         k7/tLzbnlqmaD+uwIr1mtGigvYZBn3lJoHkeq6Bt/r/7BtLnz3DEPt+IdTOoL9zRevgT
         fEORR8bqkvAdC7s9+ibI9QXWzv6TDHTI3uAxSf7zCICpwC26doal1JJHfjlj+SszmCND
         uFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550650; x=1714155450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7Qup1YQZSsagIf8Cv6SwXyCxu5zOUCz8W3WQpzckZM=;
        b=HLsM5vlnBEsgKw/W9NXpNUGLruTPQcXinfyZsY9SAKNcxjObEsj4Iw1hBUs2LUGe9M
         ApmKrkbcGrjWlgvZGY6tfm4AAEdNZrmMeLl2nkPK37bqycn+66taH7qFsq71bA3yVfHo
         DLEAwj0DYIKyAzze8kRvU/KqQnYU7sKGBswrGhbbN9m00+ApmJn49UIZxWOouAljoMWJ
         5wIBbGW8ceUklw3KCZUoT4xZMJif1UsiyzMEWvc0fgaOeXoKGjtcqJD3a3JvplWcpIdc
         SSJoBXhgfFmgtBIqgXOw9FDeD7i+34BeiS0coC5EFUYrxOXjnfmrnKIc5AxFMB8wLxNC
         ywPA==
X-Gm-Message-State: AOJu0YyDBSsC5+xiE7OzW6uByY7W8gFJA0Dg0ah/7vB1DBzUzVFlz+eG
	KZZ8nptqawYTT2m+l3XGhodZcbDKd+tSIGtOGGiJAzHMaDumi2jxV7JTDTb2LpzwXI6W9Fmb+OL
	c
X-Google-Smtp-Source: AGHT+IEr36kwHiwY8qRYI1lZg13belw7AD7HTkV2NgR99yap4Uc5j7JFapTfmCvJUTkN45sFf8+yyA==
X-Received: by 2002:a05:6808:3c4:b0:3c6:f7ce:babd with SMTP id o4-20020a05680803c400b003c6f7cebabdmr3419471oie.44.1713550650386;
        Fri, 19 Apr 2024 11:17:30 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k8-20020ac86048000000b00434efa0feaasm1786984qtm.1.2024.04.19.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 13/15] btrfs: convert correctness BUG_ON()'s to ASSERT()'s in walk_up_proc
Date: Fri, 19 Apr 2024 14:17:08 -0400
Message-ID: <118364bfc6ec45c519fe92949820eff8896d0837.1713550368.git.josef@toxicpanda.com>
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

In walk_up_proc we have several sanity checks that should only trip if
the programmer made a mistake.  Convert these to ASSERT()'s instead of
BUG_ON()'s.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5eb39f405fd5..d3d2f61b7363 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5755,7 +5755,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	u64 parent = 0;
 
 	if (wc->stage == UPDATE_BACKREF) {
-		BUG_ON(wc->shared_level < level);
+		ASSERT(wc->shared_level >= level);
 		if (level < wc->shared_level)
 			goto out;
 
@@ -5773,7 +5773,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		 * count is one.
 		 */
 		if (!path->locks[level]) {
-			BUG_ON(level == 0);
+			ASSERT(level > 0);
 			btrfs_tree_lock(eb);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 
@@ -5800,7 +5800,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	}
 
 	/* wc->stage == DROP_REFERENCE */
-	BUG_ON(wc->refs[level] > 1 && !path->locks[level]);
+	ASSERT(path->locks[level] || wc->refs[level] == 1);
 
 	if (wc->refs[level] == 1) {
 		if (level == 0) {
-- 
2.43.0


