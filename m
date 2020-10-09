Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6B82889C5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbgJIN2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbgJIN2k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB70C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z33so4021247qth.8
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jQQ/2SDMO4Lz13whsQdPCLz25nXGdR3DugpTlmNMHOU=;
        b=UVd3dkXYeezDPU2Kue/HYI18dCyJYqscp2SwtcDXd8byFa043zAkIz8qAAM+dOzkoH
         ogkQgMtpnXYAp7lIg1EJ93nxd9vNYj7bPmaQOVKEtrUnh8IK55AMuwAHlrcxATlgw/XG
         KFqqe2IVXONhzWk7OmgEy4ZuOJtHMZJrvk2lfwQHHZjBpUdfnsEBrClpZEz9mdhM08ks
         8tLZubu6tXGXIZQqJY5V0UGDolJv1ozKwd5u2kxcPCAu6/7wY6iMrUSSmhJyac6R53Nj
         CTnlkiuSvm3+RQLoY2vpmxQ1rs3Wu7/awe8ia2tZDZaHSc5KM5V6szGsHGxAcvYY/aUL
         s64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQQ/2SDMO4Lz13whsQdPCLz25nXGdR3DugpTlmNMHOU=;
        b=EMVy+OQGlbDy7sSp7kN+fGfOehWmJMByHD/sPbcS3IDHJAwJm1oznsqqvppI4JJi9v
         zx1ieqfUfFPh/MzAxtxtxZA1uIPdBd614Q0IJRhhiaZY1ZxTCsFHa8UCRxAep22ohLio
         ccsZPAYILg6zZnp9myCLJOKa1qKAxsQ+mB1YaJC0pWenmKZ0j+g1971JS5+ocIizq7VY
         gMBHZ0d/jLR0bzBLONkVLI3eoJ3YpwNbukGSFL0OztiZW9ybDTpD3iM+gJ/0gy7Qop4j
         fwTRC+fJLWldLD3H7QjXMgltS6sjM9cwREGqLvqJdOkIWD210q752cB8/2lH2YQHLHfK
         KgOg==
X-Gm-Message-State: AOAM532jniZ1zpImtsnWJ7dQmVLopo5FQWxbrtFlICPSJ53znqyjDIHL
        6RXDa0pxXtbcVDpLVDefC8hfLIwJfVCplcHx
X-Google-Smtp-Source: ABdhPJzvSm4m0+59QxJxd8esasRK7jYYsuu/a5zVFnZzhEjwt+pqR2ls5eoxL4dZmTEZQSnmqzBm4w==
X-Received: by 2002:ac8:5c55:: with SMTP id j21mr13077889qtj.210.1602250119269;
        Fri, 09 Oct 2020 06:28:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w4sm6463077qtb.0.2020.10.09.06.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 04/12] btrfs: introduce a FORCE_COMMIT_TRANS flush operation
Date:   Fri,  9 Oct 2020 09:28:21 -0400
Message-Id: <58ae7655908a28c446139452ea8f5210d590acb4.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h             | 1 +
 fs/btrfs/space-info.c        | 8 ++++++++
 include/trace/events/btrfs.h | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e817b3b3483d..84c5db91dc44 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2654,6 +2654,7 @@ enum btrfs_flush_state {
 	ALLOC_CHUNK_FORCE	=	8,
 	RUN_DELAYED_IPUTS	=	9,
 	COMMIT_TRANS		=	10,
+	FORCE_COMMIT_TRANS	=	11,
 };
 
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 540960365787..cfcc3a5247f6 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -732,6 +732,14 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index eb348656839f..0a3d35d952c4 100644
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

