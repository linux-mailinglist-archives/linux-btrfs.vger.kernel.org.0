Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CCE2D2F94
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgLHQ0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgLHQ0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:10 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C7C0611E4
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:56 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id a13so3377246qvv.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNOx2Jjr74+wLTtBDiv3gKClZYDo3iFpbDcFDbIYh4s=;
        b=tUgOkhPBiafqIbSdFBgsCZrw3Id4LIO30SBXoO8cKKTB2060mpKK//ndumc1yPrnrX
         Bmto8p0QZYHZ6l4zkBNp0ftFAdwKFt4/9OhfWleAROhJJrENCq5lIGx1L0nNQ1keXvJ+
         4lSdhK+5EnKKux1dkuJ9xHYXm53px5IxufYjMbfU5dEJk3co4lBL87OjLLTRv5bl/c7k
         SP6PNh8jery1xtH2nyaipWItRAOrjb5UmcYDGRdF/pcw+637lFDSkAQW03uGrZQdqoQM
         4p1Y30G4S+PA94iJ2BElpHzzY23PL5fBvUtMyqjfXGFq3uZ4YqzrTky4qs4MoTZbhVHJ
         X+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNOx2Jjr74+wLTtBDiv3gKClZYDo3iFpbDcFDbIYh4s=;
        b=jaK22tyfMQbwiVL9Q38jnM2FhRZaJUTjTU/hskjNOVNmgM8sYQWdYlPZlcZXWt5ApD
         /ckKh4BD/KyR5gRCS1kKfzlaqjByUrpnVxga2YdENIgLlJLAfsPHfme+5MezK3CPCjkm
         bBLBXu8RX8y8W2iMcv17/8LOWEItBYz1JUvFsTBjBFSF4h1nK9UOx45pLmMVssL6Bek+
         4F+bF4fkfxKCm/3GtQo431oOr6XvTVggYwwbcB0VULYkeaqOl6uqyJ4UmoRjJtGZKFLt
         Qk6dGrl9+MG4vERvylgF8MwW005bvrAvpmQmZn9IC+tTGZv16rKD4KtoTr2qck3k/dVE
         3bZA==
X-Gm-Message-State: AOAM530e+Ya/77ewRcHTMxSbDxqz3vt8slpxfYC9W1jHlChwNvQMmmA4
        ikKb6RlhQ2saJEQjBxBi4FqtnGODYjfHKvf1
X-Google-Smtp-Source: ABdhPJwmMvTDnUN8k+J+B6e8S5Da5J6ZxhHr5Mm/uJA1E+8ByhinlowWeqHCUtyEpKip4usfkcLPUA==
X-Received: by 2002:ad4:4426:: with SMTP id e6mr16967455qvt.51.1607444695028;
        Tue, 08 Dec 2020 08:24:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p24sm6421860qkh.73.2020.12.08.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 24/52] btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
Date:   Tue,  8 Dec 2020 11:23:31 -0500
Message-Id: <a92ed76ff2768eb93145e13bc2f4362e0ba5d03c.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index df9b9c1a8831..77feead2a324 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1435,7 +1435,9 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * recorded root will never be updated again, causing an outdated root
 	 * item.
 	 */
-	record_root_in_trans(trans, src, 1);
+	ret = record_root_in_trans(trans, src, 1);
+	if (ret)
+		return ret;
 
 	/*
 	 * We are going to commit transaction, see btrfs_commit_transaction()
@@ -1487,7 +1489,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * insert_dir_item()
 	 */
 	if (!ret)
-		record_root_in_trans(trans, parent, 1);
+		ret = record_root_in_trans(trans, parent, 1);
 	return ret;
 }
 
-- 
2.26.2

