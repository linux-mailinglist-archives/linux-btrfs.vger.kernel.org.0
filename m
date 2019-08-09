Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF087B39
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436482AbfHINdl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 09:33:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46709 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436480AbfHINdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 09:33:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id r4so71489869qkm.13
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2019 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hNBKtY1vgKFGyfKRI2xftlOfOdQdO3fKO4xhdooptLo=;
        b=nftb3KlFmtdz4hcCffrJ9aKUlsv64Ta1Ze2OIeFWWAIhq/+uUFfNW9m/5rvtumXJct
         bHN0t2JOb/RbbDwLWUC3V7heo+PkxGkvELbGdEO/XhSy3gGfpvSDaiKrQ5aIaE5e3Nwo
         8o2yQo8DBEAawpaFel++vAuUWiMYINqTR1xHI1E1fYVcCgectCuNqedJ1BEsczNK/YnQ
         tktiv+wNFwRSXNR4wpnTED+qXhyOTHA/q7woELHJ26GiHWRJP9rhpxdgieiWYK/FR/Mb
         UPu2TptMIboRLH7Vw5tl5rNsvtbKvN+RjbDZX1rFJIjqL/1h8fg2UToeisCB1QPgw6+p
         KTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNBKtY1vgKFGyfKRI2xftlOfOdQdO3fKO4xhdooptLo=;
        b=fYKJPtUw0MZilXi5ncfnNV3Y8+YeS/isEn+UoJI9eWFwYXl6BiogE9T7JKB+/jxi/x
         0zCZDaUzmGUhQyRQHcbn1irjRHQQL3KKOOr4QHQ4zBOBu3kxK/AxfqZSOVGM7oQR0Iyt
         4eHuAO8d/ocm5abqJ5ZoLlXXQ0qjW4NZSeIetnsXe+V812ZfKbW09fDJp5CUdXRtXrgS
         /36q+9hlFxtn0OdC36l886T0VXmnlboSqrutsmd8ymO4j1NLblUDDrmzbJDxadhHHsHA
         icYUJ3p/mzK/Y+Re2F6ReOyK61PJd4e3cgi7Kv1LCPtnIM3lYTraPkGaxEkzu8JBIT4X
         y3fg==
X-Gm-Message-State: APjAAAXJVoGzrghl28uUZiwVf+HXvjTDOQ5wxb4XPJIoZMkSoJrTIwn8
        0FxnT5wgkrvtoNP/VueOMggf1exkjTWC4A==
X-Google-Smtp-Source: APXvYqxcsHJFXsrkwffCJrLjP9ZXoMZ7bKZ5OWeLybivugMQr1cLxGaOoZbdUb6gz29RcaBYogRAcg==
X-Received: by 2002:a37:bc84:: with SMTP id m126mr16919765qkf.303.1565357619791;
        Fri, 09 Aug 2019 06:33:39 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q2sm40523027qkc.118.2019.08.09.06.33.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:33:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/7] btrfs: rework wake_all_tickets
Date:   Fri,  9 Aug 2019 09:33:26 -0400
Message-Id: <20190809133327.26509-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809133327.26509-1-josef@toxicpanda.com>
References: <20190809133327.26509-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we no longer partially fill tickets we need to rework
wake_all_tickets to call btrfs_try_to_wakeup_tickets() in order to see
if any subsequent tickets are able to be satisfied.  If our tickets_id
changes we know something happened and we can keep flushing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8a1c7ada67cb..163400a39e81 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -676,19 +676,22 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
 }
 
-static bool wake_all_tickets(struct list_head *head)
+static bool wake_all_tickets(struct btrfs_fs_info *fs_info,
+			     struct btrfs_space_info *space_info)
 {
 	struct reserve_ticket *ticket;
+	u64 tickets_id = space_info->tickets_id;
 
-	while (!list_empty(head)) {
-		ticket = list_first_entry(head, struct reserve_ticket, list);
+	while (!list_empty(&space_info->tickets) &&
+	       tickets_id == space_info->tickets_id) {
+		ticket = list_first_entry(&space_info->tickets,
+					  struct reserve_ticket, list);
 		list_del_init(&ticket->list);
 		ticket->error = -ENOSPC;
 		wake_up(&ticket->wait);
-		if (ticket->bytes != ticket->orig_bytes)
-			return true;
+		btrfs_try_to_wakeup_tickets(fs_info, space_info);
 	}
-	return false;
+	return (tickets_id != space_info->tickets_id);
 }
 
 /*
@@ -756,7 +759,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 		if (flush_state > COMMIT_TRANS) {
 			commit_cycles++;
 			if (commit_cycles > 2) {
-				if (wake_all_tickets(&space_info->tickets)) {
+				if (wake_all_tickets(fs_info, space_info)) {
 					flush_state = FLUSH_DELAYED_ITEMS_NR;
 					commit_cycles--;
 				} else {
-- 
2.21.0

