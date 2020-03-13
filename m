Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90783184FC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 20:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCMT6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 15:58:45 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:38768 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCMT6p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 15:58:45 -0400
Received: by mail-qk1-f176.google.com with SMTP id h14so14737524qke.5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/b7AQ56pydDiZk6zL8/kTwl9Ug47C/cUg/A7bahr5q4=;
        b=evvBmt8HN6GtK6a+WoHl2541szqah24xK/6wB4hiDDI2SD25TsfZD/rTeMeX6qt9Nw
         y28tqpEO0lalbu1g0yh2/vfJwsyIPtWyXZ8+fdkDATJcFxx11KfwdXWQkkVpq4Clzw67
         o5r9etIg7XAOGACdeIWkM+luEzb2TSyKY7nLiD+2ACQ0y0ntUIuxhyzftwFs/7kPEbzI
         lCH7g3aJnI+gkG0lesXqKKaSTaoApNI9XF23Fy0B1gybU7BxRlU6kBd7L43rvvh+bwUq
         QUAr7ECdy8lTmv8Xy0S4ffRt9wBAK6DPZuzdw6fGRpMU4wSMmyhT/MaC5dGV3IXY6oqL
         TUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/b7AQ56pydDiZk6zL8/kTwl9Ug47C/cUg/A7bahr5q4=;
        b=CO1SZqpwrVRCto0ldrZ6xhbLxMGahsS9XIMkWacf7DPiz+tvCJmVvKkE2DuU1aSE6t
         HtpsYI4kaHJdrD75/UguCFM3Y9niQz+7kgpnjdOaft9Xt32haI108PIQFWuxJF5O0mqy
         PwNQvsLls5UGr0vezc51FI6f2mXyaCO2ITa2KITiqkOWMpx+IozotW3tkygyS3G5I421
         X5CoO3ggujRhc1o8VNKCAh7ypy4d4HMl3z5gxYQKTqhaw48n+qvnsOFS2v/goIkzi6Y/
         mkKK5FHfp+Dyl19ke4RzfMQVMMEarW/Wg7CHO0Q0DkCTF2cqyri5pOxHks2w+blCe/kz
         hmkg==
X-Gm-Message-State: ANhLgQ1VLZ5DC24PwAyS1f3UIBTBUDPg5lfojOu8UeJ5guyZCBFAkCl8
        p2j1n8ixoxMyGc9+3UBRPScQY4J6nzJGsQ==
X-Google-Smtp-Source: ADFU+vsmDKDJdwvzCjAcXnOD8F/mtcZkvGYXvV4OGigBq0XpDOvPObQ1Rd0NSimNLuchznE/yEM04g==
X-Received: by 2002:a37:85c2:: with SMTP id h185mr14725068qkd.446.1584129500628;
        Fri, 13 Mar 2020 12:58:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d73sm12315029qkg.113.2020.03.13.12.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:58:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: run btrfs_try_granting_tickets if a priority ticket fails
Date:   Fri, 13 Mar 2020 15:58:09 -0400
Message-Id: <20200313195809.141753-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195809.141753-1-josef@toxicpanda.com>
References: <20200313195809.141753-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With normal tickets we could have a large reservation at the front of
the list that is unable to be satisfied, but a smaller ticket later on
that can be satisfied.  The way we handle this is to run
btrfs_try_granting_tickets() in maybe_fail_all_tickets().

However no such protection exists for priority tickets.  Fix this by
handling it in handle_reserve_ticket().  If we've returned after
attempting to flush space in a priority related way, we'll still be on
the priority list and need to be removed.

We rely on the flushing to free up space and wake the ticket, but if
there is not enough space to reclaim _but_ there's enough space in the
space_info to handle subsequent reservations then we would have gotten
an ENOSPC erroneously.

Address this by catching where we are still on the list, meaning we were
a priority ticket, and removing ourselves and then running
btrfs_try_granting_tickets().  This will handle this particular corner
case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 235dee4a23d3..e84459292cff 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1258,11 +1258,17 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	ret = ticket->error;
 	if (ticket->bytes || ticket->error) {
 		/*
-		 * Need to delete here for priority tickets. For regular tickets
-		 * either the async reclaim job deletes the ticket from the list
-		 * or we delete it ourselves at wait_reserve_ticket().
+		 * We were a priority ticket, so we need to delete ourselves
+		 * from the list.  Because we could have other priority tickets
+		 * behind us that require less space, run
+		 * btrfs_try_granting_tickets() to see if their reservations can
+		 * now be made.
 		 */
-		list_del_init(&ticket->list);
+		if (!list_empty(&ticket->list)) {
+			list_del_init(&ticket->list);
+			btrfs_try_granting_tickets(fs_info, space_info);
+		}
+
 		if (!ret)
 			ret = -ENOSPC;
 	}
-- 
2.24.1

