Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C710339845
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhCLU0V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhCLU0D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:03 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8893DC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:03 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 6so4829069qty.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/NhJOQ1FL+FHgqYsekSsbxVYcnIQpBp0sO03ubl1tI=;
        b=hMb5wuVY0SFfXCktHAazZGpnkdgSx454xSBbvDfpsSHA0EY1yjHXA3feTan9GSEhLU
         PreL8WQ/0Ay5JtgXK/cKDoDRw/qPKUDAOA/+WnYGymPpQTbcnT8D3W+ts9MVDoUjdAzF
         LEm3lhY7w9tjdXw5PZp6w5MMpitmdbueJf5PbGDGVwPE0JL/AjNKugWwFdbvM76s2NN5
         KN/A2pUrTPPG6cjnO4tQSKNW0kQGA+IMRJSTxNyj5OHewyf+sqhQiESWzm1Ebe9t69I9
         tNkMeM2/rJmS5/yh/vtDHwI795QkWarX21LBgU7pliCOpI0YDvCazZhj/TzsKKZyH3Gg
         66Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/NhJOQ1FL+FHgqYsekSsbxVYcnIQpBp0sO03ubl1tI=;
        b=fdvFEl5G7du38W5wMK50ico+tZ3dOLefS/Ci+3C2ryQoS5QG303B/St3dZ5NmEo8mv
         Jp+qdnX8n/ffM+jOP2a+agOVAo51k28ENhh89eeaF+vklndglb/pzBoUwP7xP6SEyw4Y
         GpoWEsQFo2hIQ+ESgfWLpPllkO5l3BYT7epCpI7pRKJPl4keqlXxkJMckZGh2Ps1ReEt
         nCbqjhuIpMEUKSfWHms94w04UbyoBbObl3pKKxp19+G4rbQocruirNc45QQuHGT20Rsx
         YvQ1hJu7YoQm65yibDB1t1Q6jFlIeu4ayFAmm3wIFncuIYk/9Ghg+q9+QCYvtAQyTLiQ
         GXHQ==
X-Gm-Message-State: AOAM532ALZ3IuCKROqdjC8O4T6fIh6i+GvHASMrVtuIoi54s+JT28dvK
        Vb8J7M2WSLfZG7jywmHigiS6Z/IgXcpNxwgM
X-Google-Smtp-Source: ABdhPJxF6ZQlv6xMYhkegl1l1ZF9dlAyKILQ0ge2UGqbbtwYjE8BFkMsxYLlzxMcQsa4UddBWl0jYg==
X-Received: by 2002:ac8:57c4:: with SMTP id w4mr13633705qta.215.1615580762478;
        Fri, 12 Mar 2021 12:26:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r125sm5045494qkf.132.2021.03.12.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 17/39] btrfs: return an error from btrfs_record_root_in_trans
Date:   Fri, 12 Mar 2021 15:25:12 -0500
Message-Id: <5803ac440ab70c1c9bdd1435ee1784115056e787.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can create a reloc root when we record the root in the trans, which
can fail for all sorts of different reasons.  Propagate this error up
the chain of callers.  Future patches will fix the callers of
btrfs_record_root_in_trans() to handle the error.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 93464b93ee9d..c24ffbf0fb74 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -408,6 +408,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 			       int force)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret = 0;
 
 	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
@@ -456,11 +457,11 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
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

