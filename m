Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322112D12EA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgLGOAH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgLGOAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:05 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1CAC094242
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:34 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id a6so6963994qtw.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ym7/WXb8gAZ2ujvy+FZpJ1LHWlDq8VwatqmJRPcAIv8=;
        b=0RHgPjHOYUDzFktZkdGt0+KzqeHCyxlFJ4HkagvIAVXFjaA2c6LelAeiaQLA5NnX5m
         o4IKwHIONiiyk1NrsHZ2XCQhvseK2JFpAnTzkyWqBmv4ycibrGGhqtxXfpW5HgaR/zOw
         zCSBevNwVES+DCms3eRzx6z8ZaYLgtQK/eAx7yUuMf/TNIFosPl5Y0yP5NkO6d6v6ro8
         E0blNF2+CdI6knB3DcU6qZxPWtUEUGMF9RCaQdH+My/QY0YGX2QQzjwE5JVe1hTE06Cu
         menF7RlOJvZ6RM0PFk449/dlIPCHvs7bYvvPUs117S2zg9ICFckU0nrLrBchzgn7rgHo
         3bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ym7/WXb8gAZ2ujvy+FZpJ1LHWlDq8VwatqmJRPcAIv8=;
        b=rIESEk4fRyO9oa1IRbFWoOgxHjoa/W18LPI6yd+y3XlA05SlB0gsxP6wBQfRmMXdrA
         plaxhKNzOeFme4XEvuvnrT+f9Hh0oj45d/jWb4hZYcNt4760gKkvOpcu0lqhhZa9vnnV
         hfNRu1swslcjbzKr6PazOGy/zIFDzUfuBqkSgxwPnEl6f6raYcw9He38N9ETtwufnzQg
         OAkc7lojXJMFQ8Z9KxVwBjlCF0Zt4KMfsYJ43URvZHNOLo9t4PKoNd5EC7QYm8gNjvLq
         AF6eWUwjhBcbNO7UBd2z8K2Y4bErK6x68XzMdPrRg68dMQT7EUOWtn0NPrb+e1Z61Ec/
         d2DA==
X-Gm-Message-State: AOAM532tuy2y84CnuvH9mzhhnlZJRxpzjOnc8gISOd/mjSgQ1L3DqRSV
        gzQBNMbPRws+O0ygVAG1bsRfrpgKQbj13CND
X-Google-Smtp-Source: ABdhPJwKFSQO+RdiLRgNRF5RVTQjhQnOuhlBAIq1TObtSrAvIYS/wA5uPPWjOIZDFScSvAd1DiWeHQ==
X-Received: by 2002:ac8:1c6a:: with SMTP id j39mr18411541qtk.341.1607349512922;
        Mon, 07 Dec 2020 05:58:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p62sm11757630qkf.50.2020.12.07.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 24/52] btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
Date:   Mon,  7 Dec 2020 08:57:16 -0500
Message-Id: <7fc43e87605f296aa3093255c78f16f498a8547d.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, so handle this failure
properly.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c17ab5194f5a..db676d99b098 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1436,7 +1436,9 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * recorded root will never be updated again, causing an outdated root
 	 * item.
 	 */
-	record_root_in_trans(trans, src, 1);
+	ret = record_root_in_trans(trans, src, 1);
+	if (ret)
+		return ret;
 
 	/*
 	 * We are going to commit transaction, see btrfs_commit_transaction()
@@ -1488,7 +1490,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * insert_dir_item()
 	 */
 	if (!ret)
-		record_root_in_trans(trans, parent, 1);
+		ret = record_root_in_trans(trans, parent, 1);
 	return ret;
 }
 
-- 
2.26.2

