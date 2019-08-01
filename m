Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2847E54B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 00:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbfHAWTs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 18:19:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38282 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfHAWTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 18:19:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so53368936qkk.5
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2019 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M53yaLjXYTjzEZdOLoFVfbdkTrAvo365E0R8mSp90c0=;
        b=A047uNDGY7Y49BRRdwlAnK3sO0uXphWLYwZf8CT3fzCYdKXwf/xQwVVADsBakTg+8O
         WgJrh3iVO4Yu+CoIBKYUDU+8Fi8UkeCiwlcMz+IhDvCFctlpWTF/IDPsJdxLpieCKqmK
         lNr8sJ3z3GBPlECKamwR2Dc5R44zbQcy21jXPT+6hZhCQS5uCgQhj3scEIm8LTjLmpYc
         Kfs5i0dzmUmc9XBInMXWtxdMAJOBnSgYEl1whXQJeyb+S8s//JpiHjdORgqixGkEVG4L
         YZrdDtFF3RORvAdCoklcEjvFY27Oe0xyI7P9R7xepI2jgz7xUX2qUq4R+aoqvOgTMTIM
         6MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M53yaLjXYTjzEZdOLoFVfbdkTrAvo365E0R8mSp90c0=;
        b=GOXQL7GZWQVybTeN2FdtMLuEm74aikaKXMXT3iHMZQM7BQp0xL+p2vlU+dHHQ23EgB
         G50DUYcCzvkUixK8IHVVrr2rRMzOltGIzlJeYIrr1ZnvQktRrqx644StJQktby0le8ye
         8Y9X+UwgXDyYpazqn4TGClBO1zgpIKoq4jj4qgAxbKltNMm4saUzqzXja0dRZK0V7XxB
         N/SFX+lXde26zl9TOJ8Mfs6t3snX18uBp7wS86Y60ZJinA/d3gmTHGunOgeN6sSGuier
         6OGmlBNpdbtGt4JtgyAEo6Ysgc9Se8hj3Yrts3xETZe2Mbaudwta0oFWudhlOWLhEkV0
         w0+w==
X-Gm-Message-State: APjAAAWwxE6rvMjJ9q2DpN46Q5fbMvAlXE0y1lcrtRrOo3HOUy8IrNiK
        CK1S8PnnsOiZoBFbAbsAoq6Mql6sQNE=
X-Google-Smtp-Source: APXvYqzUHwthrzFcFhicPdtCoSoNfVJHK3e6jIycQcoZus7OmuK/tPXPH9GHEOaLY9xYl83ltsP0fg==
X-Received: by 2002:a37:a603:: with SMTP id p3mr90025831qke.297.1564697986075;
        Thu, 01 Aug 2019 15:19:46 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r40sm39014660qtr.57.2019.08.01.15.19.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:19:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: refactor priority_reclaim_metadata_space
Date:   Thu,  1 Aug 2019 18:19:36 -0400
Message-Id: <20190801221937.22742-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801221937.22742-1-josef@toxicpanda.com>
References: <20190801221937.22742-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the eviction flushing stuff we'll want to allow for different
states, but still work basically the same way that
priority_reclaim_metadata_space works currently.  Refactor this to take
the flushing states and size as an argument so we can use the same logic
for limit flushing and eviction flushing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 71749b355136..03556e411b11 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -868,9 +868,12 @@ static const enum btrfs_flush_state priority_flush_states[] = {
 	ALLOC_CHUNK,
 };
 
-static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-					    struct btrfs_space_info *space_info,
-					    struct reserve_ticket *ticket)
+static void
+priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
+				struct btrfs_space_info *space_info,
+				struct reserve_ticket *ticket,
+				const enum btrfs_flush_state *states,
+				int states_nr)
 {
 	u64 to_reclaim;
 	int flush_state;
@@ -887,7 +890,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	flush_state = 0;
 	do {
 		flush_space(fs_info, space_info, to_reclaim,
-			    priority_flush_states[flush_state]);
+			    states[flush_state]);
 		flush_state++;
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
@@ -895,7 +898,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 			return;
 		}
 		spin_unlock(&space_info->lock);
-	} while (flush_state < ARRAY_SIZE(priority_flush_states));
+	} while (flush_state < states_nr);
 }
 
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
@@ -944,7 +947,9 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	if (flush == BTRFS_RESERVE_FLUSH_ALL)
 		wait_reserve_ticket(fs_info, space_info, ticket);
 	else
-		priority_reclaim_metadata_space(fs_info, space_info, ticket);
+		priority_reclaim_metadata_space(fs_info, space_info, ticket,
+						priority_flush_states,
+						ARRAY_SIZE(priority_flush_states));
 
 	spin_lock(&space_info->lock);
 	ret = ticket->error;
-- 
2.21.0

