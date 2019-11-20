Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CD2104628
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKTVvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37526 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKTVvy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:54 -0500
Received: by mail-qt1-f194.google.com with SMTP id g50so1277863qtb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=m5pbwLthKWcDJdtyYwlxxCmYFxItR2eyzgRVwhY3Sks=;
        b=di8RUp9NmbXXRFc+DD3Dg0kNXeLJprrCg1QKWQ+sb3gYLYhIn84H3tQu94o8D24FHT
         fxqdTT3/Z9psv62ufBpLsfi+msef6qLzV6vY92yJO+8sBJ2ge7vVal1tqY2f3MLOJpCz
         3B0dbDbEhwSHX4Gm0RHihFe5JE9l4Bt7YgpBndx/ossYtPbT2qDUDYz2iLdXvazawcwT
         YFamMG/g6JgsZzbI6Pr9pOMGCIaov9B3fQyNGgAKSiySfUdfLlhpGnbBNwXYnmHom72b
         BL6NDbqJfvz1S8stjnrJhs+59QbCnqEA/dkO8GSdKC4BajZC/4nvO5hS+T1Ji1Omic6o
         45ZQ==
X-Gm-Message-State: APjAAAXNMF3NYtGLRpr/reyMYQ8+YlLPupRAVG2VcOYzORZdVP3reIhe
        za77t08aG080faGG/YpWqzs=
X-Google-Smtp-Source: APXvYqyTiCO8fA0LJjkuZXcqgq9fG/oXU4ucyOdTVcLzCxX61pjyc90FGz7+V6HOy5mG8pVTMVsFKg==
X-Received: by 2002:ac8:6f7c:: with SMTP id u28mr4947844qtv.273.1574286713315;
        Wed, 20 Nov 2019 13:51:53 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:52 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 22/22] btrfs: make smaller extents more likely to go into bitmaps
Date:   Wed, 20 Nov 2019 16:51:21 -0500
Message-Id: <87afc57de2ddd8f08e4e374b179c697ed16d0ca0.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's less than ideal for small extents to eat into our extent budget, so
force extents <= 32KB into the bitmaps save for the first handful.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c4d4a7fbbd77..0bfdb636f0c8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2108,8 +2108,8 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 		 * of cache left then go ahead an dadd them, no sense in adding
 		 * the overhead of a bitmap if we don't have to.
 		 */
-		if (info->bytes <= fs_info->sectorsize * 4) {
-			if (ctl->free_extents * 2 <= ctl->extents_thresh)
+		if (info->bytes <= fs_info->sectorsize * 8) {
+			if (ctl->free_extents * 3 <= ctl->extents_thresh)
 				return false;
 		} else {
 			return false;
-- 
2.17.1

