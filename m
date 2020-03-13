Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26451850AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgCMVM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:12:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45827 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCMVM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:12:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so15087028qke.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rZ5jw5H/c1mtCo8uoI4wqNL4BPb4u9s9qY7pdLNkidg=;
        b=Rsu7rFVmhagegFo2LGpEUJRQxgUzctRAvtoy74GmI7815o47DsPjcEHH6iIpMnVLk8
         Zt562fC+i8tx7K1K6rMUROeN7ifkCWkuudFD8FRHfLORxfH/Gt6Pq9QY+8QSNMemv9qV
         39+DDwaY9+ImPegu0DRG/ychbPPPg/f+YGyZNaPn3n3+jZHcVKT7eQ1+h45ECCxA+brC
         SNUl7hfGxlTe6iIKNobu46OQqg+WUSQf1O6Yi582L8p7zIH7zE7nHWAQkC3B3kS+UKkI
         HfNcPOgglNrjB1cEzmrYng3+auwhA+oq3C7eVvGuk10/MJtBjQPZk7dIOWyLAWSqjQ4U
         LSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZ5jw5H/c1mtCo8uoI4wqNL4BPb4u9s9qY7pdLNkidg=;
        b=r3cS3j/P/QZVt0IWRWpoP7l1VW2Tk3TLxhp4tpbo6O0oqQgGtO4gnx+JcV6mvmvaaB
         CsU4lglUhT69OqEKk1vawAqF1fBDPPMgOGE7oRU7rRkBbApbTKRbZ2hAPUH38bSEqlBW
         UPOX5Eqj5lO3NF4x6kjb/mNvp6HCC5t7qedot20kLuepDLcen96Cmrbve4IrKnoRgS+M
         cFR2QWzjU3NC7AvdUi6UX8+zLGQc8se1cDtr72/eWF1D6CHcfQNU2i9+yywmNO9m2/1n
         FW9PYyMyn3saI2+M1rBls0WOndRSaxWPXf9pXOW7hGcSDVCVouClK63nSWSpw1iadVbb
         GvxA==
X-Gm-Message-State: ANhLgQ3awZjm4alV+XturZPtdXe7gbMsiHSC55doPlXVpYWZQnQsYc1n
        1R0Z3M1575+hkhZPjb/mMdwJiPIdUILXww==
X-Google-Smtp-Source: ADFU+vtYDcJ113LSm5Yc02oTcwgcbcMxKMrAEfJJarPavFEGNzZEarW/YQWCG5WQ/0KX026d0rl5BQ==
X-Received: by 2002:a37:a6d4:: with SMTP id p203mr15712318qke.184.1584133945124;
        Fri, 13 Mar 2020 14:12:25 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d72sm9932363qkg.102.2020.03.13.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:12:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: set delayed_refs.flushing for the first delayed ref flushing
Date:   Fri, 13 Mar 2020 17:12:16 -0400
Message-Id: <20200313211220.148772-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313211220.148772-1-josef@toxicpanda.com>
References: <20200313211220.148772-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to stop any other delayed refs flushing operations from
happening if we're flushing delayed refs for transaction commit as we
don't want the lock contention to make everything go slower, especially
the transaction commit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 53af0f55f5f9..cff767722a75 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2037,6 +2037,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	btrfs_trans_release_metadata(trans);
 	trans->block_rsv = NULL;
 
+	/*
+	 * set the flushing flag so procs in this transaction have to
+	 * start sending their work down.
+	 */
+	cur_trans->delayed_refs.flushing = 1;
+	smp_wmb();
+
 	/* make a pass through all the delayed refs we have so far
 	 * any runnings procs may add more while we are here
 	 */
@@ -2048,13 +2055,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	cur_trans = trans->transaction;
 
-	/*
-	 * set the flushing flag so procs in this transaction have to
-	 * start sending their work down.
-	 */
-	cur_trans->delayed_refs.flushing = 1;
-	smp_wmb();
-
 	btrfs_create_pending_block_groups(trans);
 
 	ret = btrfs_run_delayed_refs(trans, 0);
-- 
2.24.1

