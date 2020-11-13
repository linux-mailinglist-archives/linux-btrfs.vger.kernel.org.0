Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5502B203E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgKMQYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgKMQYK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:10 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14DBC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:10 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 63so4851432qva.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HstIpFLgENU09vvGOpBmgnDvsUyM8yMo89nF2do3qPQ=;
        b=mlKt4eNlIrHJQqyYARvlaZzrg1BYHE1HEI2QiyITm7VgIVItyq0l2O3QvRx842Fjk5
         ZrJqGa1674Y/8xbGkPywMS4ZmNzsaJ0LGm8zuLO5oqLGMlP72spRTVzaimj6r3Q2eT36
         X02zrqJFO3QfAMK54ogTRsf27lohNu3PgCKZu/ytHJGxJIL9kJ2KaySZgw5slJMD2WjC
         O2JiZneKMJLnS8Xh0JUkBFr1lSAj+HL/hm4TBASgLHX41AeJstLRLVNdDNd5gqn7wLIY
         oZNd1t8Cp3vlXlnTkV9iI+NqNTGvni9h52mCQHzP9V/+Dl6YzF2zu/3ikq7QNksSrp0d
         u7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HstIpFLgENU09vvGOpBmgnDvsUyM8yMo89nF2do3qPQ=;
        b=UXJRzy1rGbYBbTY4aEP6/Jaew6ilXdvJzE74hSnUZt/Vh86zYFh5BugcnGubEpdL6C
         tIm9AzQZGXOERriShNv3B7Ig8XEmem3LRNnrrlS6Sb9HNIXAIT0riYCGil1NEjBjobDG
         dyJRBCNSO85zb77glldSOVMPfaDbWwPcnWQGzZ/qC1Uj5vFoLR7EIsOc1PuS8vebiRlF
         KZqJetNKQ3+ICATBa2PAuS3jWsQyKRcNP8oxB7U4uJ+euPPER9attgra+cX5pm89Bd13
         +Jp4VaTFl1Dh3RxdwvfblFxNAhqVf/IMa2IZf6aGQtk44VgtrfD2kpZdDdT0lx5qM6GC
         WkJg==
X-Gm-Message-State: AOAM533b3zOfnDsFbU8i9ZDjJkS6ZXMcbv49l3jnovCAF4EO+xtExsDg
        KrrM5o6lfimSZYNQBTNxUip2v2/0pcwgUg==
X-Google-Smtp-Source: ABdhPJxwS+N+e4TZ0LFUpAYAag1Nfp4f0tMTtaJg3CWlgKk5WZRkVt1O52pyR+Tp8mb9u7CZnPNFew==
X-Received: by 2002:ad4:4a87:: with SMTP id h7mr3011145qvx.14.1605284644790;
        Fri, 13 Nov 2020 08:24:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v204sm7295101qka.4.2020.11.13.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 16/42] btrfs: handle btrfs_record_root_in_trans failure in start_transaction
Date:   Fri, 13 Nov 2020 11:23:06 -0500
Message-Id: <b076da600376b6c9f9c8fdf7ee2ea149969f51a6.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in start_transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index fab26241fb2e..f7fd013ecc2a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -737,7 +737,11 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * Thus it need to be called after current->journal_info initialized,
 	 * or we can deadlock.
 	 */
-	btrfs_record_root_in_trans(h, root);
+	ret = btrfs_record_root_in_trans(h, root);
+	if (ret) {
+		btrfs_end_transaction(h);
+		return ERR_PTR(ret);
+	}
 
 	return h;
 
-- 
2.26.2

