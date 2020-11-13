Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770F02B203F
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgKMQYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgKMQYM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:12 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16DDC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:12 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f93so7013894qtb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yVPf6RphRvS27LRFikuCmzT3N4bDJgVuMugHkpBj3zE=;
        b=EAWGlgqrcOlmpov6Zg7FjXhKXe0SIKEy6z6K00m+KCXcRJnZ+PtrJBoncwNxYQTTqD
         UK2qZp/m8wijot9GaQG5PaXwcuBXkjSLz2zKotB+4aIt0mWvJus2/U6A/yBg9OPajAhb
         DMcDHgYdsCTNLgyfX3eKWqk0XW9xeIK71fD6dnwMp3Jr9cnpl2fBiF+F6yyUBAy65lBC
         LRPJroFIMTR6CxeXmgAwUtwRw6afew4+lpPiqb4aEE6wud4udv8cQo3EGAAbffa+vu1O
         yk+/FWXYdw01V+8Z2FIPLCfKcDdtlmH6VFqbdpFkRe8gIzlPdPea9PezaC8QXItPQ8Zl
         teIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVPf6RphRvS27LRFikuCmzT3N4bDJgVuMugHkpBj3zE=;
        b=XzqTD9qVUUTuA/Il7Ml3OmMoXiGqVxyPtPPgObl2ZY+QO5nb4UDwEthWU/10qI18j7
         GrHIjJ1i1eUdo0nWX/Pv97X2vYlhuTLsPz3bqmYecNpliLHPqJ26rNp/76LGioejzQPs
         euIWleUadc8lEXfCbfXKAKRJuxC8yobJ009K0ZX5deJ1ytMJyEBP3koDREBPnLg6GBR7
         cKkk9Ci8PD8350sTMDvrVvT85HAO9Jk5rQfohhJriRxN9aSBm+Gb0lmZHgLK45BN2xTS
         cD7l22Bw+J3Wvuk60DYF1LFZdZgQ1RL6wUEry8PcIztY3oOgDN8YRyNBVVKZZUiS/eTn
         bvWg==
X-Gm-Message-State: AOAM530j/XGFzDktqbG0+OQEWPvLHYGL5jl7itKStSDmfqiKly6F6T3Z
        ShY2NaOEUpYOj+JVB2J70X0VEguBW6b3CA==
X-Google-Smtp-Source: ABdhPJxojBpTwewqDPeSR3lK+45jgcTsZueFlsvi0TeykW2t7I/cQESXsVHmgDiWKwm1lvlaf8Ij6w==
X-Received: by 2002:ac8:5c15:: with SMTP id i21mr2695461qti.190.1605284646650;
        Fri, 13 Nov 2020 08:24:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t20sm7297365qtt.70.2020.11.13.08.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 17/42] btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
Date:   Fri, 13 Nov 2020 11:23:07 -0500
Message-Id: <586dad50cf007458ac04c497b78a1db7c46f3f4d.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, so handle this failure
properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f7fd013ecc2a..ad12a13d0412 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1440,7 +1440,9 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * recorded root will never be updated again, causing an outdated root
 	 * item.
 	 */
-	record_root_in_trans(trans, src, 1);
+	ret = record_root_in_trans(trans, src, 1);
+	if (ret)
+		return ret;
 
 	/*
 	 * We are going to commit transaction, see btrfs_commit_transaction()
@@ -1492,7 +1494,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * insert_dir_item()
 	 */
 	if (!ret)
-		record_root_in_trans(trans, parent, 1);
+		ret = record_root_in_trans(trans, parent, 1);
 	return ret;
 }
 
-- 
2.26.2

