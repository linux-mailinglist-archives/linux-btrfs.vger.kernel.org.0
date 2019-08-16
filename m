Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39A3903DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfHPOUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:20:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32996 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfHPOUE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:20:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id w18so4130751qki.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dc4VGYSL3vPuuhr6wvTNO6eGeiRn3vdOpe3URcAf/2Y=;
        b=t6VMZ4Gzi6GyheZWeCsT7zIB6H1HXSKHzhT/DoFxMwx5aoI5Gc5qf/3XrZAG9jcbdW
         uSsoelcVuH94qf/BvvLv10XbyPtrCNTl8uyJ2kBX6u5iFTQHESmACPoOG56SfdVDaE5s
         pgyEFJHnaA1R17VcNT5vRl8TRklv6WbnxJhpvdqVmCVPqy90UztOnsmd8JbX47EqauUl
         wOJ2wnC3ipsgU0qIkOkYs7D+FTorguhQPHiKooX2z7lzBspObs5bqUPR/DNogN4yADRq
         M4v6XBMypW3a7SzH+s8h1fn194ZZFKLzkF7qQA52SbotGnwwaUoU0tuhbiUsDbPeKuea
         Bsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dc4VGYSL3vPuuhr6wvTNO6eGeiRn3vdOpe3URcAf/2Y=;
        b=P7oURVTlu+zWQgiqF1+kEW0Oufc39gQxkJOBRbY10oq2Y8Rpxm5EpjNUO2MAsomlTD
         JMyH2FXdLrXAgWBRPIYYvB3cdS+ezB8VsF7UILNGjFqt46LtJaIqc1WyHJXYXu5EsWmJ
         iQ3zz8ImyQc/yReGKtzc2vPwuIhlhd+CZgdKL0wvIGeDQmcp4KfnySp4sbhGc3sez9Yh
         oFxL5+baHxONusmG0ZDEzNMKPqhS+fZj8rQnuOjEGu8zSnwtYuP6RP0+v8wSGrry6JdX
         3o2bTSQeYTVWnAoyUDhFHAolY3V15tcDnZJSY7WvJ+ctHXlZhCyqP4XY4K8lIQWGsQDw
         +pJA==
X-Gm-Message-State: APjAAAXusiG+BsUDXwVg9nqeE0z/iX8oR/ssEDPngEQfXP9WEHxUowl+
        6zP+d2EUgOMAnYXb0wCVbRvORANehnJdPw==
X-Google-Smtp-Source: APXvYqwGneov9RQh8YtuPEFxlGzQRaIPhoxWnekpzWS17lr0FhALBuDYN5JsNGLlUA8kXaAm8bL+VA==
X-Received: by 2002:a37:444b:: with SMTP id r72mr8808306qka.361.1565965203115;
        Fri, 16 Aug 2019 07:20:03 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 143sm3071424qkl.114.2019.08.16.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:20:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: rework btrfs_space_info_add_old_bytes
Date:   Fri, 16 Aug 2019 10:19:48 -0400
Message-Id: <20190816141952.19369-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816141952.19369-1-josef@toxicpanda.com>
References: <20190816141952.19369-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there are pending tickets and we are overcommitted we will simply
return free'd reservations to space_info->bytes_may_use if we cannot
overcommit any more.  This is problematic because we assume any free
space would have been added to the tickets, and so if we go from an
overcommitted state to not overcommitted we could have plenty of space
in our space_info but be unable to make progress on our tickets because
we only refill tickets from previous reservations.

Instead of doing this partial filling of tickets dance we need to simply
add our space to the space_info, and then do the normal check to see if
we can satisfy the whole reservation.  If we can then we wake up the
ticket and carry on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 780be5df31b4..5f123b36fdcd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -233,52 +233,41 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info,
 				    u64 num_bytes)
 {
-	struct reserve_ticket *ticket;
 	struct list_head *head;
-	u64 used;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
-	bool check_overcommit = false;
 
 	spin_lock(&space_info->lock);
 	head = &space_info->priority_tickets;
+	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
 
-	/*
-	 * If we are over our limit then we need to check and see if we can
-	 * overcommit, and if we can't then we just need to free up our space
-	 * and not satisfy any requests.
-	 */
-	used = btrfs_space_info_used(space_info, true);
-	if (used - num_bytes >= space_info->total_bytes)
-		check_overcommit = true;
 again:
-	while (!list_empty(head) && num_bytes) {
-		ticket = list_first_entry(head, struct reserve_ticket,
-					  list);
-		/*
-		 * We use 0 bytes because this space is already reserved, so
-		 * adding the ticket space would be a double count.
-		 */
-		if (check_overcommit &&
-		    !can_overcommit(fs_info, space_info, 0, flush, false))
-			break;
-		if (num_bytes >= ticket->bytes) {
+	while (!list_empty(head)) {
+		struct reserve_ticket *ticket;
+		u64 used = btrfs_space_info_used(space_info, true);
+
+		ticket = list_first_entry(head, struct reserve_ticket, list);
+
+		/* Check and see if our ticket can be satisified now. */
+		if ((used + ticket->bytes <= space_info->total_bytes) ||
+		    can_overcommit(fs_info, space_info, ticket->bytes, flush,
+				   false)) {
+			btrfs_space_info_update_bytes_may_use(fs_info,
+							      space_info,
+							      ticket->bytes);
 			list_del_init(&ticket->list);
-			num_bytes -= ticket->bytes;
 			ticket->bytes = 0;
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
 		} else {
-			ticket->bytes -= num_bytes;
-			num_bytes = 0;
+			break;
 		}
 	}
 
-	if (num_bytes && head == &space_info->priority_tickets) {
+	if (head == &space_info->priority_tickets) {
 		head = &space_info->tickets;
 		flush = BTRFS_RESERVE_FLUSH_ALL;
 		goto again;
 	}
-	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.21.0

