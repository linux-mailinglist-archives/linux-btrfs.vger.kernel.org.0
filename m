Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6800E2B1012
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgKLVUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgKLVUX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:23 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF258C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:23 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b16so4983055qtb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SONWYUOoPatb0yHJwO2+I0rURE9vuxjZ5UeRGcxpvAM=;
        b=sOc0/ntwC+8+AmZ0hWqW2CO5cofFk3HgcVqDtbmxrz1Jh1z8L0zlpBYX9o90VOm7RL
         ZDIhemuYUpF7VgYZ8vFo5Eoh7eW5M9fJF2m3yQscsFWVGAbPIBGZFsGkKPWRDZe01pR0
         11Hkkt+fdMiy5JCAerwQjxjg3wphUzG7ZeaxAH0qb6eRSmXcUx5BIMVl1amtDno3Gwly
         e+XzSZf51pU1EBwK1x8VlronNokp8C3ItR+e97Xbcy0gasA0kPGg72DR/o2EG9ffD/cV
         zuZC4T2OSmgThhaobOBXO72jEUCtPYSvdpr+iQamfXxtrD1yfjQwmRT9K8L4LjbevYO/
         EXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SONWYUOoPatb0yHJwO2+I0rURE9vuxjZ5UeRGcxpvAM=;
        b=W2Ex+dXG8IRIm1ESHt1tY+A/DCXjzNrClwcKERujjxo/pLyfr7tIekHbj5Dka7ICNz
         uzYEGM9PdU/UqwbfP4hpLXF0mcvykFQIpGDEfWtShmav9dioT9PBto3ZOu1K+ZMEqcFf
         mvafsnpmyHDxlUrnRwSQei7ptePRjjjaJ1gf1MDAPpNneuQWnNLIYgMx0sNU4JOq3ObJ
         YUPcMLhKQzn9SWG2bF8a00Ea0M9bPQmiBTx4ordE7o0SAAvxK7gnH8RYQR5+ed6pXTgo
         EnSvwhydT/qnPBSpL6up6RzP7Di61rLg444UV5WKxSMLcTyXe/Vxzm3DJuhCbhvVavMF
         Q2fQ==
X-Gm-Message-State: AOAM532leIzf+QHxZZSEEx4U9jxuhX/9Y3z7vDxzAnZWcanAKsJR9awo
        EggusBq8fP/7RuDj+suyUcXxOxFs2jXGTw==
X-Google-Smtp-Source: ABdhPJwNRZeX2MfO+soMQtvzONsbKk7z1Vf8WaBOgdB8NVL975JSmbIDft/Dg1ctRBtkVBUNBMxrTQ==
X-Received: by 2002:ac8:734a:: with SMTP id q10mr1149801qtp.389.1605216022465;
        Thu, 12 Nov 2020 13:20:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f128sm5825349qkj.48.2020.11.12.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 33/42] btrfs: handle extent reference errors in do_relocation
Date:   Thu, 12 Nov 2020 16:19:00 -0500
Message-Id: <95676eb7b3c7f842a90e81344ba177c891515d0f.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already deal with errors appropriately from do_relocation, simply
handle any errors that come from changing the refs at this point
cleanly.  We have to abort the transaction if we fail here as we've
modified metadata at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index df45b4df989b..100cd8eba91c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2476,10 +2476,12 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
-			BUG_ON(ret);
-
-			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
-			BUG_ON(ret);
+			if (!ret)
+				btrfs_drop_subtree(trans, root, eb, upper->eb);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				err = ret;
+			}
 		}
 next:
 		if (!upper->pending)
-- 
2.26.2

