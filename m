Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DF2CDD87
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502063AbgLCSZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502057AbgLCSZU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:20 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070DC061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:45 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id y11so1417514qvu.10
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ym7/WXb8gAZ2ujvy+FZpJ1LHWlDq8VwatqmJRPcAIv8=;
        b=iddeWcxeFddSXXR90WINyyeMACo38wHV+T/lXAlTKeJzdubgrJQ5yC1i4C5I3gILiq
         DJLE7X+q8K3mb2AAftqOiX3UgdMwdyLs5+O5xbfuZSedNSCh4eyJ9ZIExJrbjnfxwpDa
         W2o4YLUfw6uOeTSQCQJ3Hhp5o4RUzEbtTF20bHuQuI+jtd4CZ+kL45d+RWoKiH/ITI8m
         W7j4RL82bBu6lnsqTHwDlULKIK8fFB4qT+WWlTaiSolQFtq/rQSMgKDEfFAu4uZdAZgL
         yPvicaiSkWp3NudzJoH9iZmr4CUOCQ60MNixR7j9FRO6nJzacgtOTYr6FkmcBIQOblZ5
         zcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ym7/WXb8gAZ2ujvy+FZpJ1LHWlDq8VwatqmJRPcAIv8=;
        b=eJl9+YGndFx6juN4Mk9oGcLV7GvPMQ6GW3FOQw+j7YHM3yicUsb9d6ygnjcy+YpaRR
         EK5+Kr1dgMncOA7ULmCnHPwMbrq2z3rMmE+jEt50h/S2I1uPQ1AR68el5TLKvqZxwNyx
         0l09xNWbjnYqgRTP4w1Gk5tToSD2K9JIRyFt+OtSZj48XGM1hU/GSQ9X7XOP9Z7I2dkg
         SGGDHYd6ZPIiPnI3l7+KVPVSw0z4g7DFMxaQbEUG7Ol9GZOwDxDyCUa5v/n3KeN1avYX
         GUMj2NRkIf1rgJUQ5Wp9CQUFlb2S0KmzncVRXg9z5EFpgwIeAj1RlEcAd3vZi5gWETKt
         94Ig==
X-Gm-Message-State: AOAM531nB6pEtEXTfA+f2kVrMoYK913U4G31N32Eb6UiYX0eeJgthMWd
        EchIxEdTKGhWty/GVVbOekO5evllbH7pkzoM
X-Google-Smtp-Source: ABdhPJwwzHKUK3OahL/b0O6EjXMVRkfEznX8X7T6ktCQuPCYPWxkCFtCYFIPaMkz/ahC6X94dM6UJg==
X-Received: by 2002:a05:6214:13c3:: with SMTP id cg3mr194377qvb.42.1607019824946;
        Thu, 03 Dec 2020 10:23:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e19sm1985823qtp.83.2020.12.03.10.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 25/53] btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
Date:   Thu,  3 Dec 2020 13:22:31 -0500
Message-Id: <ae1d377a02b3029183fc456e571353c68eb04411.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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

