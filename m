Return-Path: <linux-btrfs+bounces-4365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51E8A860B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6A61C2117F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C53142627;
	Wed, 17 Apr 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rS+NQDjG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5881422C9
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364578; cv=none; b=hcRkxtC/7meacxK8dHlHrY0bxwhe/6OiSh2A8QtUpLUorbtdNbk1K7K26gK5T/dxlEJkFQC6jFPp2LzJRyhtnMi8A3qJ3956vtR1m3o1h4arJqtvBcyqRXSZk9yENhDlmQoNBEc1jRJIOHr3FWN0P2JPKSOMl/hIbJXSQN/GEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364578; c=relaxed/simple;
	bh=SI7UBRui4exBVzMmZDqjH6jmbp2M31ZFFyvhb1yWGfY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsYsg9zXlemDGK+tA0S7j6qbHQeSShoKpIcAS5knYRxYu2LFeA9/hJeN2GTKaWxrsqqt6mzz/NbwtHc8SV7ZfajWJoKkfPLBFeaVHqYg5BPtPh3bZWh2OOxckkVYFd4wZkuLcU57kJzq3mlWD2mnnYxABY5q/6c8lZ9+T1Sq1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rS+NQDjG; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-437846c4ceaso1766431cf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364576; x=1713969376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwdBOXbPQKMF58zCnd69akHypCDuvtwD37ItRJVi6jM=;
        b=rS+NQDjGjgZ+baimg39XfwNwtN7oGQiUqYHrwbqp0S4sOCRjYLtg0LEm+nUDk4xsM1
         eyhzvwCeEGMVTDbjtgVNlKMh96GCNlMIueAb5DvzZMUZWOwQVGyhpPriqZtKwjsBl7U7
         TdTHX3p9266Ey1SD4/gzOpNXa/dG+qTQqWiZ7wVzSoa/FBBAKQB9ROc0W0WUwWr9pS+H
         xBEqqPrxKB4ad0HlErCT6U2wBA03RoaDCcwfo/oLPf5nCYtiTbywb9JcOdJVjjBffHq/
         YQCrBw9vy9vZftR244TLqWhJp4G5crN/yDZOTocEQVB779DXvBvX1ahUUm++ATGJBYOV
         JLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364576; x=1713969376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwdBOXbPQKMF58zCnd69akHypCDuvtwD37ItRJVi6jM=;
        b=CmfKh3nx+Ovy94Td0ZkdpGsZXrPlUMuBua1UaSn3JCsUGvKW/75kfeDR5uVxie2FDT
         Z0Opx0QKqPordDx+qx/mLRuP/PmKCzPx2zxHumVgLpYFGypYlVJGNSFXSl3d+tkGgO3i
         2qBa/7V68KhWykxaExusi3r2Mo9mSNn08v4/2whhVsEee1VODG6yvmI5JnWVA4WkDs4s
         vInXF0Leko5EijGBTSblXkSFo1ojfdhEdREXpPng6vnSHGSyc4qJUtuwi/tOOfl0CSyR
         tBs2IBpBE3PDfXGALA4j/AVh+ruRyrIqj4AHPfqI7dbrgblpq9Nj0rzKo44P9DtPyYRb
         hDew==
X-Gm-Message-State: AOJu0Ywa2krC1Mxc50XG/g1kNxsJBP74h85hxW5zj6uqJgyAnGY7whX4
	aY9XhPEk7/1Tz/W56E/jIMjmR3rLrZ5KWNlMYmFhiW/emWlomqydPAU7hZTrUtl8GulU7+rnVdC
	b
X-Google-Smtp-Source: AGHT+IGlaKweZmdH/buzml36qfArRByI0LZeDQAE9CF8AXe+eiGqotthyC34JwP5fE1OSk8iBndA2w==
X-Received: by 2002:ac8:7c52:0:b0:437:8bb2:4439 with SMTP id o18-20020ac87c52000000b004378bb24439mr210261qtv.48.1713364576187;
        Wed, 17 Apr 2024 07:36:16 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h11-20020ac8514b000000b00432bd953506sm8142566qtn.84.2024.04.17.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 08/17] btrfs: adjust while loop condition in run_delalloc_nocow
Date: Wed, 17 Apr 2024 10:35:52 -0400
Message-ID: <e6b89a60facace44086fc9eaed3e78fbece6c45e.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have the following pattern

while (1) {
	if (cur_offset > end)
		break;
}

Which is just

while (cur_offset <= end) {
}

so adjust the code to be more clear.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f14b3cecce47..80e92d37af34 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1988,7 +1988,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	nocow_args.end = end;
 	nocow_args.writeback_path = true;
 
-	while (1) {
+	while (cur_offset <= end) {
 		struct btrfs_block_group *nocow_bg = NULL;
 		struct btrfs_ordered_extent *ordered;
 		struct btrfs_key found_key;
@@ -2192,8 +2192,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 */
 		if (ret)
 			goto error;
-		if (cur_offset > end)
-			break;
 	}
 	btrfs_release_path(path);
 
-- 
2.43.0


