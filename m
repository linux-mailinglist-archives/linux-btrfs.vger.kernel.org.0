Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B962C4C1B69
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244140AbiBWTHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 14:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiBWTHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 14:07:20 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D758B31372
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:51 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id fc19so10052370qvb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yhWbaIjm4R8j5f9SmxsYeqBAu+dHxU2EbmIDonB/X5c=;
        b=I892kQgzQQ/4HcZ8Bf3Y58UhbMrW1igRiNJaBBWQs2Bop6y88vok9TUApXxoWHMvtb
         ZrvmDod9azE2bub8yFY99cV9/fD0oGdpcbuQW/jStCyEDBDYvrD4vfgqKiZs0VnV7/LA
         +e0tNPqH5u+IJRbIU5B65j7tr8Z+p9ABbgYEEEyhrWu++0k/lE/gZ0IoDzUN2DTQFzRB
         PJ+hVtlBQtrZuKfUD53VVTZWcz0cz/u1RgWw7+4YnyAHTnruyoBuHROVhY9g7RgkawJK
         gfKQvGVJwSW2fkJ9KSSGGCwtcujxjd944cVZ8NKdSnLk96lrLPBbasQK1Ygyh33ifXvt
         QyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhWbaIjm4R8j5f9SmxsYeqBAu+dHxU2EbmIDonB/X5c=;
        b=tHB4nDi+7ejCa7cE2aSwY341kHmDHfjfPgi/Cxz+Sv5QDvyS8awvgdVbYj+ACnvQ6K
         R0mu6UUl5LxSlWJVq+lwoAdq6ZchoCvc9uQ8DASdcFCA106rvC6yCiE9bVEH3+EH5Z71
         WRitxeZs7TlKDbKpPvxAJCtFnE3Vni4GojRN7QuDUd67Yny8UgioNkXoPuTsxnfM1I1h
         EOAErEsUxy6jzjE3ZQnq2PhjKdKmBq2c7fFXsDKM5bml5B5uFsa+RpiUJV2QtaIQnJwq
         vXHQ+j1WNsRNzz3cm9/ZCUNJWanTbPmJlDZXYYNJEZLD2K8pjXZ+lOzOxVC8eKNEpqP2
         7puQ==
X-Gm-Message-State: AOAM533hrYdMfcTFC9ltJbD62Dir29iddzr3jW+x63k7lfpTo99IO8gh
        proIj42rCFIlEf/zVtpZcwgsL2TdZFXm0D7J
X-Google-Smtp-Source: ABdhPJyLRPRWthHIMX+01eaeCi4wM3h2bhBMXc8MwFwCmOZU4NOsEgFBvRyX099hJNId56E0fArzZA==
X-Received: by 2002:a05:6214:2504:b0:42d:7b1a:8dd1 with SMTP id gf4-20020a056214250400b0042d7b1a8dd1mr1046937qvb.8.1645643210313;
        Wed, 23 Feb 2022 11:06:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i22sm289873qtm.46.2022.02.23.11.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:06:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] btrfs: remove BUG_ON(ret) in alloc_reserved_tree_block
Date:   Wed, 23 Feb 2022 14:06:43 -0500
Message-Id: <74adf5fd8aa9d9a5e25d86f0e74614aa7295fb92.1645643109.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645643109.git.josef@toxicpanda.com>
References: <cover.1645643109.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Switch this to an ASSERT() and return the error in the normal case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 99e550b83794..7b8414fdae36 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4761,9 +4761,10 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	ret = btrfs_update_block_group(trans, extent_key.objectid,
 				       fs_info->nodesize, true);
 	if (ret) { /* -ENOENT, logic error */
+		ASSERT(!ret);
 		btrfs_err(fs_info, "update block group failed for %llu %llu",
 			extent_key.objectid, extent_key.offset);
-		BUG();
+		return ret;
 	}
 
 	trace_btrfs_reserved_extent_alloc(fs_info, extent_key.objectid,
-- 
2.26.3

