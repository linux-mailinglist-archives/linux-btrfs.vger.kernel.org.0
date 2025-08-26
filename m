Return-Path: <linux-btrfs+bounces-16409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B39BB36EAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323C61BC3A6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A53705B0;
	Tue, 26 Aug 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="G5TsgGo6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5B36CC8E
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222912; cv=none; b=sAs2r1i0mU42IuUOqpKpqcpagAwCLEtCQ8SbM5GzDFzE1gYW6nFYb6I+iypejO5OmBip44N3GUwmlYvVV+ggqV3wQ9SOfZqn7G44KVmx6z2Io1a2vbgOOA/WG4luzWEJ2t7dxZoFUReXmZGfBa328bbqItg43o3SooKGt/7r0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222912; c=relaxed/simple;
	bh=pnLjXbUfoHcXn2jpRxuylRj/MRBDvUFW2eVaWnK6gz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbOA0m4K6beENpNsRZFViKF6CoCtqsHrlgl/xUU+00xisJTYyrwWQAFTfZ+1Ycpn/NFsVplKo7EisMKZZJ9F3NjzyHqyW3SBgBIEcpOBt6okNXCU7hC55xgufrSoJEZTjtfQWaEc3k0XadIA94hhjhZgHjGgFicm+6iZpkkgrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=G5TsgGo6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e953397c16eso2354361276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222910; x=1756827710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDdJEhTVcL0Kwh3vTWaXkqiJl0I0MAIx+6FUQgVhMXE=;
        b=G5TsgGo6pUZBOHWfrbWWdQgArtIBymxnTtqbMZBetT8TRDQ1+17pQm35doXSPuEFHm
         UmTjUwYiGwia83VQC4a8hq86C8GHfgTRWqYSR9f+6FQvyyAU5QSidqqo8EnCB9wqOMpH
         gXb+FePWa2+G8x5qvPR2/HaMil+FeA9afKJFS0C6rsl3J22fAZJ8AWNacGI0uBEyx+dQ
         Qve4Dd8JnEQisVdbzkV9oPV1Kw0/s1setJd6kLwTZc8kEgLy0sQRkn2INGolW7K6rRlB
         Y+IeYBiNEN/+7YI/YEdS9ZvGrRsH/L1HlYIXWjSOfuNCY4/euiY8UrsHB5xtv1T/Z+cI
         fT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222910; x=1756827710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDdJEhTVcL0Kwh3vTWaXkqiJl0I0MAIx+6FUQgVhMXE=;
        b=Rvh6M8/NLf7ZPr0nZ5UfdNS0TBPy1lgAszTS2g253+Xnr+r4OmnOPgvj7pUH5ntb99
         3JhdKeJ56yqkw+QTU56aM7LYG6vtNyms1mUtKIH2AXdVQ/SW0IXjOwMTIELsVF1cymZ+
         3cackyl7yBn/Gidy6yrPLvJvaN7gMsqT2TeRHYnwSERFTpSUPfYtB95bMDVFkvW93t6M
         bGSfbe7n0GMv039khPZpOYpU5K2saNId62qEHkNi3729/1QXjPamEdUmNTSYguNM9qRe
         OVW0YHeI8ctqy/Gi3whEf5F8+7LM92OziAIeUevfrLW6baeXbNmbapcX7uUV1+f9NX+f
         TiVA==
X-Forwarded-Encrypted: i=1; AJvYcCWwR8ZWPgAboJPYDub7QnkT+ERNRXqaGwmM2JApbdjkLkYQ0VQTBd72OR3X9tU0aaNzA+JykpX0UJY2nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylQjKubuKcfvLv/hG2BVTMbKAA2l6A1gNeIEJE/BSIGXC/I2BA
	ho0JWhVUHOmL59Mt7BYquj4MBxJyPpHvSTpuZAXnG93tE/meYcGbIQpdf2J29vzCJ2M=
X-Gm-Gg: ASbGncvZ26a71JbaNLDZ6rpzngTCBJvLBd4vzUXIe9alNbDtXFKkmhqLL9JYg/d3zdq
	xtecMMs3j08q9gk5CQvWaRXP72mawhVIJUHmJ9YPt7qjttLUp9UYeTAvF9okOqkfmr0oy3DQx/F
	5VCrsIksrZi6Q65FVzVQlAzyLFzHejj94cWaMdmxPU876TlKDsmJtUpgGZ5mMH9QWFSfH09bd/m
	vW/+VLXWBd5ajp0ag4nvLHOkW+5+16pONOd9KDPQzTAFyf7Krblf+rkKaCW52+PaAbHQhbX2N1D
	M+lHAwMAAaRCfDRF8StD5e9Bd9p53XKzDbzllDUTt4ie5nMCrehFqEurpT3OeHefdIXc2YQTVr+
	xRcRBlxYVkN8XwU1eTSOFLZV+ut+OC2rpwyuyLauMV1qu3oPqO155eHW5bmQLDJtI4VcmQg==
X-Google-Smtp-Source: AGHT+IEbtyzB0KkEDrw8Xs/L8Hc6W7XjqAvgA/hveL8BAb3PYuONcNj0ZepACSrEkBrgiNlNwynZ1A==
X-Received: by 2002:a05:6902:20c1:b0:e96:c754:b4e0 with SMTP id 3f1490d57ef6-e96c754b758mr7398145276.27.1756222910291;
        Tue, 26 Aug 2025 08:41:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c3674f3sm3320374276.29.2025.08.26.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 42/54] landlock: remove I_FREEING|I_WILL_FREE check
Date: Tue, 26 Aug 2025 11:39:42 -0400
Message-ID: <1bb97474d9b4b081371019c29708b9e4e3b3f601.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have the reference count that we can use to see if the inode is
alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/landlock/fs.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0bade2c5aa1d..fc7e577b56e1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1280,23 +1280,8 @@ static void hook_sb_delete(struct super_block *const sb)
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		struct landlock_object *object;
 
-		/* Only handles referenced inodes. */
-		if (!icount_read(inode))
-			continue;
-
-		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
-		 */
 		spin_lock(&inode->i_lock);
-		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
-		 */
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1308,10 +1293,11 @@ static void hook_sb_delete(struct super_block *const sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
 
+		if (!igrab(inode))
+			continue;
+
 		/*
 		 * If there is no concurrent release_inode() ongoing, then we
 		 * are in charge of calling iput() on this inode, otherwise we
-- 
2.49.0


