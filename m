Return-Path: <linux-btrfs+bounces-16398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E461B36E8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439112A5A54
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29718369345;
	Tue, 26 Aug 2025 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VX3rg/1n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80E346A00
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222897; cv=none; b=oPWQU8UvjZ7xQP1d+VAxvfDy4GCCfQVUv9D5Lbe8i/AxB9XDDnh/OmZHLLjZgn7ecpRCcTprXy01JZGGAlGOfjESUcqh3DaQT9YWbI9PkL/M8AkqGjQV+wQ4YEvU++FhM6tj6L8KpuNyVF2qDThNrRxuFGfNbZrgyTSh0NvjNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222897; c=relaxed/simple;
	bh=Ek+K7HnIxIEopRMdqMnNty91y2VWEE+x+hrrKpFJIDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAPDVqCnFjDmryHVWfXE+XEWar6Zh0bH2o4jnNfuxNEKOLoLuOcHm5m2985aADtCQkEEkpjNWNiuG433tEJyEum4moxMTkBH8JQBtHRqml24iAHrViHmwNtGPvHurTRTPUeKtP3XRywiQir6ueqyxvFK0HRxvtOLYaqb8AyUvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VX3rg/1n; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e931c71a1baso8241405276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222894; x=1756827694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=VX3rg/1nwaBPBki8rHZ8UMExRSuThguHtxx0flJqoSvOXhaKgDjDtKIA9EExV3qk5T
         Lqz10q8Di5PI1oODeVYRbgF9u76OCf+emIJobOksU8NQXOzWMc+5V4S5R+zwW24dLhrr
         o3mbJQQhDm/K2PBw/cD36W1RjN4n7mW+rT/mHqT/KCDwiXwhmLiHqBvUZ2+V7kv5Nnj/
         LU7Uft/YyWnrh5UMWE6VaGIZ1Y89oBRVuzQ8LFofIdzNVuSH1+CeQVbKI6gfxtBxnXY9
         9POUaUX+9zt9GdgGY1QctZaiKg/jBZ7hGSx/DUmlX9hLHYgsZeIPLwZouW/pYPC8fZCt
         RC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222894; x=1756827694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=QYoJg3Ch3iZfzRB7BNXJe0KFWqzqK/Snjto6DLmbvsjXXcVrZMsT4YiaO+RVOanPy8
         6bNMSEmalHVkp8nFJMdeumthagi+cxGHGuc1hUoqhlj9VZ/+aSAbTrXKs/yDWUOwJgFX
         sQIlUEle+hCEhq0J+U+ofbf6/Dhsnav7N5De/QoKKIVhOsyLqCBDSIH4oAMS2u1dKMYy
         /l9M+qwJ5enQ5CcAyTDboKX3ALXwyVKW09kL4BZBcrm0TbVH6S2RaML6p4b8itU38R/k
         LRXezYrWdTgxjMHBO6jsivrHXSsM2wjugmrnD8TuvK1kEKqBU7v65k3R5lXhF7QdBHs7
         qnVA==
X-Forwarded-Encrypted: i=1; AJvYcCW6a/HMvX1GnhZEeoeSQGXMC0PFiOdyTQ5LCI6pYTMTPJYM5QMaeN/UmUJJGLFAXYDJFi+rnvt8OpqHow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pWQg++Ya5nWzKY9V5o1yQvWTGCjf2Aha9WxlkJayn2zqzuRu
	v+ewhDVnZi0tCTO1fCtXEugjwBMutqWOCCRGlvTIfDhBOGgyLuU2U6BkL44bLiwqnBI=
X-Gm-Gg: ASbGncsujMJMs9shodVH5iAg8KrEzCGnwgKsjv0F/vTHYeS4Skwgb1TJRnetJg6ADqG
	hmQlCtqe41dxI9wiGNudQ1SANXSuh/V2hcQuJvMTmqzazYZcNGxw/gtmFaow0qod3DbnARS2dtn
	Fu1QaCssTUAsRJjmwePrnDLpdCK24pm3ldIkDFbd0uzdnQce6ZSL7fCW8OrvlVUntftioAyMFB3
	COvT0/5jBvBOulOR74hAdsswk68Z0066CT3y+tGKgWIPUWAguwG6pO+p2UCU0VFm+mtKpC2ZUao
	DjUTNZPieLZJLCzaZZKFAiaHLyxMEhx7kXUXEoYFq1FoGUAGWuibN8B2VH7VgTDJX3VBh+jTr+3
	C66RflDDQP4Ah4RLLd/LAS+mHFlJMw6wECuZbh2IdDPpKWKse2vyHh2LzCUg=
X-Google-Smtp-Source: AGHT+IGsMpG/UCDruSz3Wvi7CzZlKIL5xzEKlg+zB+8+jIE4udBR1skQ5tPNMiXAg2ctT0vtiUJNQg==
X-Received: by 2002:a05:6902:c11:b0:e95:25c2:e800 with SMTP id 3f1490d57ef6-e9525c2f090mr16314789276.44.1756222893943;
        Tue, 26 Aug 2025 08:41:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96dbdb8453sm850314276.20.2025.08.26.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 31/54] block: use igrab in sync_bdevs
Date: Tue, 26 Aug 2025 11:39:31 -0400
Message-ID: <83700637bec18af1ca85a2d232a11c0fa85dca34.1756222465.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE or I_FREEING simply grab a reference to
the inode, as it will only succeed if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/bdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..94ffc0b5a68c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1265,13 +1265,15 @@ void sync_bdevs(bool wait)
 		struct block_device *bdev;
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
-		    mapping->nrpages == 0) {
+		if (inode->i_state & I_NEW || mapping->nrpages == 0) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
+
 		spin_unlock(&blockdev_superblock->s_inode_list_lock);
 		/*
 		 * We hold a reference to 'inode' so it couldn't have been
-- 
2.49.0


