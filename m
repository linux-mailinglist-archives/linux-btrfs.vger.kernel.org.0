Return-Path: <linux-btrfs+bounces-4616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA428B5A18
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B75B27136
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102977F15;
	Mon, 29 Apr 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wpvsh263"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A57605D
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397414; cv=none; b=XEuP6BW7/HQ11BAw8z0LfFvuPLM/Atn67f92t+MF0a7D1T9k3zSysPI5cQnOxbFY/wwCr2K0fRZbiqGtbjOGhCHqgjPQWT3hVdwBnq2c/mK2+IDivBvniaFFPCFVlrvPjgvFpSMuuvyW5//ZCi1ogzclnOo0TdxE1LCOSznv+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397414; c=relaxed/simple;
	bh=4qSJgeEzuW/yv80TO0ZNrEeDZ3LMWaXhoCYkMW7q8ZY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/bcK4AHbIycmaICQdnTm3nmOGBjEYOYXBMwl0umAyGqz5gqf3vgrqSbZFBNLCNvwXdIcwDOG2B0VzyN+udCSGk//ZlczzZtE3dEauEY+26rrnYs2AgZPkGlXpAVibct33KaoMNe1H2o7xJppy7c2ArlWVjvyL/yJTA/a+iQfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wpvsh263; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c8317d1f25so2628834b6e.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397412; x=1715002212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SH/G2m48Wjdwx4WE5OIAtm4zjgDlpxd9y1O01maoRvM=;
        b=wpvsh263RKlJ3TZl/d+d97B3lK+TQwjMYIuLuAdsURB6E+tumW+qM+GwwW4w0nG7M2
         R/LFpzObZhyv8Xu6Z3SXiTt4eoyZcyiflUJk2Rhp1LeZvhlm79fombwhrIW7+oZkjCaO
         rp/pqQZ2gpsbBqSuJsf7jMg8MruIcBJnkPcualAgOP2y/XXdZ6gwHLfXjl1kPodplMJ7
         TIl2NF0aWbjdndzjGIV6ZN+aXwLZBHgg4cuOvCZs5BkQ/Qrz4Xws8hGTxPnBQ5nA3FCh
         d+965K9r3jYkqQ9bAKn0UEVfqf6OznN1F++uS0X4qDvvFZAMeGYHGU0i9bNpd4eLlph2
         XV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397412; x=1715002212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH/G2m48Wjdwx4WE5OIAtm4zjgDlpxd9y1O01maoRvM=;
        b=ZjOay467TzosJcwRGFMDDe37ZAeYlskVwp7n+HCg3NPveuDdUr7Sf1D34Iwi3LCgp/
         Th3Br8tj6RyKbHpIX5dHT/TYPhaPFHYxkzlqyggv6ec7eQRN0praSMng6LZRM1UIMBxt
         uRkJwXrBb5ZSEfpdHZlt8Vj/efwijoAruqA40ke76p9IhsaC/CGkKOxvVqzAV8h/BeAN
         SIS+G8xdk8bKepCrPL0kzSZCHDyTm/cd2NdsR2le58bnvqB965SfxFnf4NWJ38hHBCca
         he8FZ3usT8eTqQl54yHHVvlO+pS0rszMNK5Z5hd5kAFePlDdty8dLElt/L+F94KSiNhL
         k/mw==
X-Gm-Message-State: AOJu0YyJaNzl7LOTJY2/3ZS1UhsPWNmT63eMMKwlhfN3qe1cowAGRQ8j
	v52MhgzoiluJdVx7sC4kL0pfa9mzMY4OCv/LDV2uzd/ev1IDHN1V+gjikXnLvL4jx+W4BOOYS1k
	h
X-Google-Smtp-Source: AGHT+IH0B1XT7p99wB2xuAvveNth3BPt4q8QlM6FN/u/0uhaH1vI9hl6MgDUbKPFqE1dy3KzWWGfnA==
X-Received: by 2002:a54:4606:0:b0:3c8:2fc5:c816 with SMTP id p6-20020a544606000000b003c82fc5c816mr10678799oip.11.1714397412276;
        Mon, 29 Apr 2024 06:30:12 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id qd13-20020ad4480d000000b0069b75b8633dsm3787470qvb.67.2024.04.29.06.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 13/15] btrfs: convert correctness BUG_ON()'s to ASSERT()'s in walk_up_proc
Date: Mon, 29 Apr 2024 09:29:48 -0400
Message-ID: <0ebad91b9919154d680a0845c597f02f2ed9ee05.1714397223.git.josef@toxicpanda.com>
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

In walk_up_proc we have several sanity checks that should only trip if
the programmer made a mistake.  Convert these to ASSERT()'s instead of
BUG_ON()'s.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cbb99454a194..44d879b673f9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5757,7 +5757,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	u64 parent = 0;
 
 	if (wc->stage == UPDATE_BACKREF) {
-		BUG_ON(wc->shared_level < level);
+		ASSERT(wc->shared_level >= level);
 		if (level < wc->shared_level)
 			goto out;
 
@@ -5775,7 +5775,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		 * count is one.
 		 */
 		if (!path->locks[level]) {
-			BUG_ON(level == 0);
+			ASSERT(level > 0);
 			btrfs_tree_lock(eb);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 
@@ -5804,7 +5804,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	}
 
 	/* wc->stage == DROP_REFERENCE */
-	BUG_ON(wc->refs[level] > 1 && !path->locks[level]);
+	ASSERT(path->locks[level] || wc->refs[level] == 1);
 
 	if (wc->refs[level] == 1) {
 		if (level == 0) {
-- 
2.43.0


