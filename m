Return-Path: <linux-btrfs+bounces-4452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA98AB4FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E21928698D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF613D250;
	Fri, 19 Apr 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dc7RDby1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D513CFBE
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550653; cv=none; b=gAwuGxD3x3EIAlkWrniKktyaynlnyTGomk/Yquml/LNGqreIgLfmsPRnPiGWVVqU6j9deYsnkJo9wkGMDjM6AAda7Bfm/VvTJ90BfLpdMpGGGYLpK+Zjo2fDJHU6vzMAVNJv0OocH+iwMFR8PxOCjJIRpNcKkCM3Mh6Gygo0DaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550653; c=relaxed/simple;
	bh=5ThSzafXlJ0SeYuBY8QIChqvYKSd7NAUQu2VAkoTE4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl67+xU2N6HfghDhO4lLl9K/hLAZDD7tcqThug6GStsp1npk56QZGvf8a9lsMqlBIofEzP2Y9cgBngXKeclZqVCqEKvmKCFsA/b8YwiVWtiW3twcG1cjHSYzIXeYIg3MkSwU10PhGYRtQigjIwTPH0b02+5FnZV19+X+6ECTt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dc7RDby1; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbbc6e51d0so1379695b6e.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550651; x=1714155451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znahDsmr3ypRHAWUU20B5AwgcnzUuYeAuBAUcPbrJXE=;
        b=dc7RDby1bBekqCXe0VNLQEP13Zg8t6ApP5fG5VFP3vRT9fCHzRZOhFHmwDNTWgnkOP
         ggLtTQtqVt7TppjY89EreDKInxl8+dx1/tfEf2+187oEi6c5nD+oLuLGj6zlbDyKd/fr
         tfpzbSh7Wc9CdEB3znrpH2PhvM3qHlFTzH6hJdiFVTxbtseN3At9IPUsQ/hu9eVt4cc1
         /URf2V2t+RXCZrY7DQYd2Tzijo2Z146uRyD6ke3bwK1y+0kXua+MObTw+8pt9isJpOxd
         EUwG2VErPK0lxy3NPSNscWluvDsCcjn5mgqWe3wI1jeWXdJ3VtFWAlQEUa12GHzxFVMK
         sndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550651; x=1714155451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znahDsmr3ypRHAWUU20B5AwgcnzUuYeAuBAUcPbrJXE=;
        b=jB9iFFdCTBlDD1llGEmcHN7d74gmG5IL9LLAku/TVSmIxhgjmyF/eUPfN7sqWYBSai
         Lqx76v01TkwOZ40S1QDNi70ZObNpxO2DZpvM9taZVRvZR8TVfYcO3fUVBsy+vr7O3+vv
         zY78QhjIQE/dwijbiHNcPZukVnvHypcL5qNRU2/9AMdMz2ZvsCPHeYr3QAW+rJ81wdbH
         xkdDnSsKggJtnRXb5eZ2PYY41Hge601RaF0pwPRF3Oq6q72HfXtclgyUISOehOjxi3bV
         S7R7gN5juYatnwUu1VUhLI9sVFxxOz0jjDaXc0zwALEHatpCQFImKEDPtubj3vBUy1sW
         opuA==
X-Gm-Message-State: AOJu0Ywhn6JcyGbbBuxgC+KWnMzb4ZNz2eHoOIoCkCMmm60sfcL4uQot
	twVv4bSyewfJzSKa3XSwivclXNZx0nPHwud+yQIi2Q8FWJkMUGekxpnAnqp2Rv3FjuOx3Ay25nd
	X
X-Google-Smtp-Source: AGHT+IG489r65Yb0Kh1BvXd9wRp0ttSbdY/vw02oMrWI5IRz35Dn0z96WWLN3lA/vweGuf2H3eZ2Dg==
X-Received: by 2002:aca:1e0c:0:b0:3c7:4b08:e6ae with SMTP id m12-20020aca1e0c000000b003c74b08e6aemr2062712oic.40.1713550651559;
        Fri, 19 Apr 2024 11:17:31 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b6-20020ac812c6000000b0043769a2d3d3sm1781691qtj.78.2024.04.19.11.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 14/15] btrfs: handle errors from btrfs_dec_ref properly
Date: Fri, 19 Apr 2024 14:17:09 -0400
Message-ID: <85733fb309238393fbfb60dd4c2d88ca3becbc37.1713550368.git.josef@toxicpanda.com>
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

In walk_up_proc() we BUG_ON(ret) from btrfs_dec_ref().  This is
incorrect, we have proper error handling here, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d3d2f61b7363..0f59339aac5d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5808,7 +5808,10 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				ret = btrfs_dec_ref(trans, root, eb, 1);
 			else
 				ret = btrfs_dec_ref(trans, root, eb, 0);
-			BUG_ON(ret); /* -ENOMEM */
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			if (is_fstree(btrfs_root_id(root))) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
 				if (ret) {
-- 
2.43.0


