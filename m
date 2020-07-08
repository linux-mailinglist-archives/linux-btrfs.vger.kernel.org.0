Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0B2189B7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgGHOBB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgGHOBB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:01:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3790C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:01:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c30so37682588qka.10
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frCUE3S3/bN7rWND0qsjSP1NCZLi+CeRQ3+FfDokoQY=;
        b=bHUnXXQk8F+WO5qpAdwlMmQ8wigThK6hz8E5KC81OThUnRwza33Ft1akSWK9iSKsgF
         vriLQdpUhXcdLeu5MQZlDOXt3RajWMaFqx4AeWqiusw9zUv5HpV9F69ZRoht059hxeOO
         f+ag5l0T+onLmaqPYl2rEXi+JI1VUT4CUeog7JR5B9AacApi2//FrW/1xfl1fLuhogCW
         0PofJsjnhP25nO2SeNJxPvd6UrFkq+k5O/jfiQBDKlx+MlnzOwrCmOUuzvIwqFgd40Gk
         R+kBH8KRhSvtHHsLDhCD2sKxxk7P8tCIP73Z9uMoOxB0CmBPf5/846dhIB+L8AtsG7bS
         E/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frCUE3S3/bN7rWND0qsjSP1NCZLi+CeRQ3+FfDokoQY=;
        b=cfe1OUvfS6WrQ7kWI/jHCr+iEI+Hzh8OSPDhNELajTnG+i/73/osArx7FMkCX/Mmte
         dA3MeyRBc+RbxLqBCjEkF30cPqonl7X9FEcv0BdLkv74vmG6KyJxfV7dy8VgfP6w4Q+Y
         1FilSuAYfyADTrfkYFox9X8Sj9drnwyemmAX/qM0lHMqjCDS+OFEO/s0J2UlGWHJjPP3
         RZCybz6esVoZM5bwZsW6HQu8LF/A0EMq51+/l56q4Nazo6s9HMJCyxMLuvUtrDU8opme
         4PZyKzWWLkKyZpnY8WTGIRa4FLc91xQ26d9jJNpl7wP/T4eu8ZG13DT77WbMyXaRpusQ
         HvTg==
X-Gm-Message-State: AOAM531M89gPUJCBG7s0lh0Qe4DzR0+ro/WOUT0zgwTGPbeDVoor95RF
        /2R/IPH6Ft08Uxtp1tVms7fqplFFQaTY/Q==
X-Google-Smtp-Source: ABdhPJwGedtf90J1nd2PFOwS1KEw8BvwEZwrWtgfusUbXT415prvl6PYkFkYfmfLw0fObPnjzbKNuA==
X-Received: by 2002:a05:620a:11b3:: with SMTP id c19mr56943887qkk.203.1594216859497;
        Wed, 08 Jul 2020 07:00:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n64sm27340458qke.77.2020.07.08.07.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 20/23] btrfs: run delayed iputs before committing the transaction for data
Date:   Wed,  8 Jul 2020 10:00:10 -0400
Message-Id: <20200708140013.56994-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before we were waiting on iputs after we committed the transaction, but
this doesn't really make much sense.  We want to reclaim any space we
may have in order to be more likely to commit the transaction, due to
pinned space being added by running the delayed iputs.  Fix this by
making delayed iputs run before committing the transaction.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5b46835766e3..092f3f62a5ef 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1022,8 +1022,8 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
-	COMMIT_TRANS,
 	RUN_DELAYED_IPUTS,
+	COMMIT_TRANS,
 };
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-- 
2.24.1

