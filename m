Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF52B202D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKMQXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:49 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB6EC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so7066808qtx.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P+N6jhb9M8PLo37rRZRK/Li4XimJ4xvMBj14nEAk/ns=;
        b=KMXKwzeryX4pAk6gE7kYZ8aeZb5JFFKGoCMPv9PAcSJuOTFjeGls7WY9AzN0KwbIes
         SSOYrqOGPOwpZ7TYnLnYn1LnQHqEGLg8yNc4yHtQPxHcO4zt7oo1uQsik1nU3NigM2Gz
         a8JckC2j4py4XlMAeBSnPm1LGzHhwivEtNlmgfSacQCpIXsLGSkQDrwr/K3T2dFtH080
         nLS/w7mIAMNnhZGiOV3AeDOznhmcCWwC2HdD2Hc0PoJ0+0xg4DVVr5Y6SBXrmJ+HRpk+
         8tZmlhNLgGnvhZt4znWVVHuTNIppGn7gHoJKcCvK0RBbeBnZSSLjG35CaCmNuxyHfhsx
         1cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+N6jhb9M8PLo37rRZRK/Li4XimJ4xvMBj14nEAk/ns=;
        b=XMOtR5FJQmelgE/+RQG3IZa0TtazLoOwUM1ihi1xIj7ukkwXjt4H7e8pVGKos3Yj8G
         lLgElO0E0ZQM9HlCcWk6QPqye8gYqrSxIbeYr/92cCBl4WHWtNIwoh+FFkMFq9X1uIfA
         Dxj4ZTHX8KMYsruTAXaChCe68B4Ns7+9pNajrVS/l+7T71TgtY/ual5CmIcuym8droL1
         Pwm9I/Lq9qJKD5b5gxXosfEqsMtjCeBd94oZ0XKSxgZ190X5AShibULnfYvWU+5oKDx5
         U+GGOT6xlL7SrWxKSXpTdKrlOxTmJ9GxfQMEYuGTOxRW/omyUhUs3Tc13E+rItw/PB2b
         U6Kg==
X-Gm-Message-State: AOAM531PhynA6+LphM6I5f42FDyD24IBxhGuttSbYA3cpRoEG37inUUB
        wlD+8MFOPlH8WIt7Se3klkYOLWywxGDXwA==
X-Google-Smtp-Source: ABdhPJwctjgxEWW8htjj2ipblrlpYJh4vCf8xKOfvHEiY3TxSEPHGLyBOyy4V54JWx8ssxWCLjvEFg==
X-Received: by 2002:ac8:7a95:: with SMTP id x21mr2678996qtr.307.1605284623807;
        Fri, 13 Nov 2020 08:23:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o62sm7458203qkb.94.2020.11.13.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/42] btrfs: return an error from btrfs_record_root_in_trans
Date:   Fri, 13 Nov 2020 11:22:55 -0500
Message-Id: <5ef2aa527f3a9e0525ab5a97ef0d585b999bb47c.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can create a reloc root when we record the root in the trans, which
can fail for all sorts of different reasons.  Propagate this error up
the chain of callers.  Future patches will fix the callers of
btrfs_record_root_in_trans() to handle the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0e4063651047..fab26241fb2e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -403,6 +403,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 			       int force)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret = 0;
 
 	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
@@ -451,11 +452,11 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 		 * lock.  smp_wmb() makes sure that all the writes above are
 		 * done before we pop in the zero below
 		 */
-		btrfs_init_reloc_root(trans, root);
+		ret = btrfs_init_reloc_root(trans, root);
 		smp_mb__before_atomic();
 		clear_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
 	}
-	return 0;
+	return ret;
 }
 
 
-- 
2.26.2

