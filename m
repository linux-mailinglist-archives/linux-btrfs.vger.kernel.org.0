Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C567A3057DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314421AbhAZXHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbhAZVZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:26 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB454C061786
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:45 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id u16so64000qvo.9
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDjYg5z1XHKdcgkC2wUPKOdcCx2H37hkO0k+Ey7BmWA=;
        b=GFaR6A2R5FXxWlJ9EhCd0aDN0Kfd1e7JrluydOtrgkdC3fv3NPvDdl9u5tdbmHPIYY
         KxUW3XbY8VJjpZMc2rSOrrOwQZzvWeIn7ula0tHR+8S+uqeGzpouHRyW+egikMQH4LeM
         H0uTQ8+2ynQp6RnwtO029LW5H0YjknTPVk5DVl3eFS24O4Os5X9abLPaMbwXBKg6GPyV
         XyAQLERnkpJNktY1R55sDfu9eZKwTwCA8dRuYh+FJvRyyIgFcFsvAZbehJTcrXED76sM
         Yhtmwa5k0Gdm4XniBz8DOXy/xCu+uxaXOR8op7N5z3pdYE3+b/9nwS3VsIed9/FEUPYT
         fhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDjYg5z1XHKdcgkC2wUPKOdcCx2H37hkO0k+Ey7BmWA=;
        b=KniGFLYndNwSmHrRvyfGVP1einldZYJz1scCtaQ4CpshJhr+HAafi7a+jbMgIvU5/z
         tRV0AwFK3aPtmzLHr21L+IS6ypvav51kKpEkPcT+QW16+mNsKI5CIQyhnBznPL5UfSKJ
         RgvDY2MnGrtKFIYAXZvB3Nxoc28RECDEa18SSNWo+IXZsqVSM9vG9UaXg7FrmI+fljvb
         kie4zorjNzSIO8MRIL8d/G4u/Ozc7QrQ0Qm+P4oKarWV44+cxBcy1vwspIIfSx1Mc/gk
         j9gTHwG8Xyt90UhcOYpv6A6ctqqqoPxzvCMPc8/pHadvs36vB0lq3TxEJNc5mz+CjU41
         ovag==
X-Gm-Message-State: AOAM531zdO0OgoCknTx+EImmfcxNIhiaGnSTDqG7h5rHTNYcvJskZtlN
        oDQ9MVZnAB4dzk2YJ4sjgnRizI2OV9LPe6cT
X-Google-Smtp-Source: ABdhPJyUmB4bq0I3aF6l/BVgq567SyVktihLHKyMhP507agbSa1AjFJjtRPI+xAXFc75daxcm1F+DA==
X-Received: by 2002:a0c:eb49:: with SMTP id c9mr739902qvq.37.1611696284803;
        Tue, 26 Jan 2021 13:24:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c1sm6787978qke.2.2021.01.26.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 04/12] btrfs: introduce a FORCE_COMMIT_TRANS flush operation
Date:   Tue, 26 Jan 2021 16:24:28 -0500
Message-Id: <9c471c554b07853524b5496c2ea1ed7a343349b1.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sole-y for preemptive flushing, we want to be able to force the
transaction commit without any of the ambiguity of
may_commit_transaction().  This is because may_commit_transaction()
checks tickets and such, and in preemptive flushing we already know
it'll be helpful, so use this to keep the code nice and clean and
straightforward.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h             |  1 +
 fs/btrfs/space-info.c        | 14 ++++++++++++++
 include/trace/events/btrfs.h |  3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7d8660227520..90726954b883 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2740,6 +2740,7 @@ enum btrfs_flush_state {
 	ALLOC_CHUNK_FORCE	=	8,
 	RUN_DELAYED_IPUTS	=	9,
 	COMMIT_TRANS		=	10,
+	FORCE_COMMIT_TRANS	=	11,
 };
 
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ff138cef7d0b..94c9534505c5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -735,6 +735,14 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 	case COMMIT_TRANS:
 		ret = may_commit_transaction(fs_info, space_info);
 		break;
+	case FORCE_COMMIT_TRANS:
+		trans = btrfs_join_transaction(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			break;
+		}
+		ret = btrfs_commit_transaction(trans);
+		break;
 	default:
 		ret = -ENOSPC;
 		break;
@@ -1037,6 +1045,12 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
  *   For data we start with alloc chunk force, however we could have been full
  *   before, and then the transaction commit could have freed new block groups,
  *   so if we now have space to allocate do the force chunk allocation.
+ *
+ * FORCE_COMMIT_TRANS
+ *   For use by the preemptive flusher.  We use this to bypass the ticketing
+ *   checks in may_commit_transaction, as we have more information about the
+ *   overall state of the system and may want to commit the transaction ahead of
+ *   actual ENOSPC conditions.
  */
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index b0ea2a108be3..0cf02dfd4c01 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -99,7 +99,8 @@ struct btrfs_space_info;
 	EM( ALLOC_CHUNK,		"ALLOC_CHUNK")			\
 	EM( ALLOC_CHUNK_FORCE,		"ALLOC_CHUNK_FORCE")		\
 	EM( RUN_DELAYED_IPUTS,		"RUN_DELAYED_IPUTS")		\
-	EMe(COMMIT_TRANS,		"COMMIT_TRANS")
+	EM(COMMIT_TRANS,		"COMMIT_TRANS")			\
+	EMe(FORCE_COMMIT_TRANS,		"FORCE_COMMIT_TRANS")
 
 /*
  * First define the enums in the above macros to be exported to userspace via
-- 
2.26.2

