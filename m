Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CD99F82
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391593AbfHVTLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:18 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40984 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfHVTLS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:18 -0400
Received: by mail-yw1-f67.google.com with SMTP id i138so2837183ywg.8
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=we0y7S/ey++sSClxrOeO9dikgeZ30O9XVlCVkiwhijY=;
        b=WCyZcyQ3NP/CXCsfzkJU/BPR2aidTHEDjblgN8Qv10/tdEja93OEArD5UUvOEjyjjc
         RvCqW6kC+pTDjMHLcMVTpJKoqT1X3VwdCG5wGJg3M+56uIYqr227C+xNu4FkiyZhm+th
         ALnvHJY2RQJUTB2M6DLJX8Ol9Bl6EMcwjw6ueV5slk6HE0ELyX8qaUCk0EIozAcvmv4C
         eDA7VMfmyrXhav8Z2E6Xru47YNp00ZJAQ2fy28XBWb+ZZuzPWKHg7EUKMQTTG32xjTYp
         jmjgzX8A1FA5htyQ3LJ3md5N9STwDTjtBMrxAdfARu1OsrowfnLEm5NTAcN2zBU1dEYd
         RZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=we0y7S/ey++sSClxrOeO9dikgeZ30O9XVlCVkiwhijY=;
        b=ZXTne9Cn1BJ3KpgrghJCLgtpdSWq6OupxZgiYC5OwPiL3LmPY56/yMzle/EU9czh6n
         mUUva361RihKHDlNKRjKOIAIti+Ocgg56b7u9ZVmRYqLipBPRdAOBDi472jrWX64BXNO
         mWZl7H5bnf0vHBV1HhTgFyJxV8hbRk5tPLvigLPEdKhzB3/RLkg4hsG5P1FMWB4MuXHu
         ZErWRyLi2l+u6Nk4n+ErkbAUbZ3/6rmMHhKK9/O71vW3ozqqg8DjPPxJIfMMvttC6cc1
         KT0ZN5Afj2HStcP30CXkoqWQChTDftdxE+wOeqPDTCl1ATrJzoWfaJlrXabUFJPpQmDk
         9aTQ==
X-Gm-Message-State: APjAAAUitZo7zDT2uX+uEk+bR/3EVRr/+0lFNZwqhNt0kN3TKM2UFp4i
        X1IT12+TZisS6XMpip8vyiIZXBGmm/mvUQ==
X-Google-Smtp-Source: APXvYqyzjY5SvO4iQVYwpM/rRzF5iFnRQ/ZgYixW1YJnavnnOpXLabZv+VSzXGp2u3+V9QrNmKF1Ng==
X-Received: by 2002:a81:3785:: with SMTP id e127mr683049ywa.242.1566501077640;
        Thu, 22 Aug 2019 12:11:17 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 205sm111237ywd.26.2019.08.22.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: fix may_commit_transaction to deal with no partial filling
Date:   Thu, 22 Aug 2019 15:11:00 -0400
Message-Id: <20190822191102.13732-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we aren't partially filling tickets we may have some slack
space left in the space_info.  We need to account for this in
may_commit_transaction, otherwise we may choose to not commit the
transaction despite it actually having enough space to satisfy our
ticket.

Calculate the free space we have in the space_info, if any, and subtract
this from the ticket we have and use that amount to determine if we will
need to commit to reclaim enough space.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index dd4adfa75a71..cec6db0c41cc 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -473,12 +473,19 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	struct btrfs_trans_handle *trans;
 	u64 bytes_needed;
 	u64 reclaim_bytes = 0;
+	u64 cur_free_bytes = 0;
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	if (trans)
 		return -EAGAIN;
 
 	spin_lock(&space_info->lock);
+	cur_free_bytes = btrfs_space_info_used(space_info, true);
+	if (cur_free_bytes < space_info->total_bytes)
+		cur_free_bytes = space_info->total_bytes - cur_free_bytes;
+	else
+		cur_free_bytes = 0;
+
 	if (!list_empty(&space_info->priority_tickets))
 		ticket = list_first_entry(&space_info->priority_tickets,
 					  struct reserve_ticket, list);
@@ -486,6 +493,11 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 	bytes_needed = (ticket) ? ticket->bytes : 0;
+
+	if (bytes_needed > cur_free_bytes)
+		bytes_needed -= cur_free_bytes;
+	else
+		bytes_needed = 0;
 	spin_unlock(&space_info->lock);
 
 	if (!bytes_needed)
-- 
2.21.0

