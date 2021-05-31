Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5A395647
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhEaHjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 03:39:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47962 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHip (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 03:38:45 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 448341FD2F;
        Mon, 31 May 2021 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622446625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0MjgCtcPif0quHprMIA2kIN3SAFdCJyLYb4j/l3HfRY=;
        b=tMirFoJKwXEqDVGLTjGFtH4Hlc7R+erecoVNjgEG6UQElFL3kFnfvP5ifukvJ5TN6MvQA6
        tQ/xGvf6eJ0VbVxbbxAeFZrbAA4XgodkTfZM1C14yu/pbyvf2JJElspLudP7LZfJoWb0vg
        BZiadiurwhvHFsvXjRpiMoWxFhgozOM=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8F5A7118DD;
        Mon, 31 May 2021 07:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622446624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0MjgCtcPif0quHprMIA2kIN3SAFdCJyLYb4j/l3HfRY=;
        b=r1U/KwBf2XJWB7M7y5xMsePR3wEuUvzklI9acIak2fc/0KvghahJWJRmf4f72Wpd7ItdKJ
        oVvcaxuAu38akplCr8pwZqfQ3iMRFeAQCGnjfh8OMLSXecJg0zL5mb1vFT3gyASIMVWjDt
        Xh0Cs1+RzLFsQaN8wcFFjcZhiHDrQlk=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id H8F0ICCStGC1HAAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 31 May 2021 07:37:04 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Use list_last_entry in add_falloc_range
Date:   Mon, 31 May 2021 10:37:03 +0300
Message-Id: <20210531073703.41498-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: *****
X-Spam-Score: 5.00
X-Spamd-Result: default: False [5.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_TWO(0.00)[2];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of calling list_entry with head->prev simply call
list_last_entry which makes it obvious which member of the list is
being referred. This allows to remove the extra 'prev' pointer.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e910cc2cd45c..2b28a3daa5a9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3034,7 +3034,6 @@ struct falloc_range {
  */
 static int add_falloc_range(struct list_head *head, u64 start, u64 len)
 {
-	struct falloc_range *prev = NULL;
 	struct falloc_range *range = NULL;
 
 	if (list_empty(head))
@@ -3044,9 +3043,9 @@ static int add_falloc_range(struct list_head *head, u64 start, u64 len)
 	 * As fallocate iterate by bytenr order, we only need to check
 	 * the last range.
 	 */
-	prev = list_entry(head->prev, struct falloc_range, list);
-	if (prev->start + prev->len == start) {
-		prev->len += len;
+	range = list_last_entry(head, struct falloc_range, list);
+	if (range->start + range->len == start) {
+		range->len += len;
 		return 0;
 	}
 insert:
-- 
2.25.1

