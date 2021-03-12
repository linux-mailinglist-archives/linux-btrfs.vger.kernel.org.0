Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE0533985F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhCLU0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbhCLU0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:33 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0834C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:32 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 30so4898989qva.9
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8PwcbYLcI09qfDxINxVvRFFpl2xsi4kodsIzZZ1JII=;
        b=TqN8g9uNjkhLNemyweQ5Gz5RLNOHwSwANe2TolNZ/PD6ftjj648iXeyI8AzkOxQQZv
         ObvkpGTyZCziD/S5To4X6oFcPM+O583OY8dtUHSx+59hi8MzoajnhHZHV3cPChOGRIX/
         5Be9d1lcwZrezFlVq/WO1AVvFPe/eI1XfHpiRe5gU2knrAt64sipJE8OUGGFEunGLLao
         9Up07Pt0gsSLepyqbjQF7CycmeUEIRp0OWyDofaKn7/ZQbKaIWHyaCs3uJzR6xjgJ75g
         g+jCkLtDNdIFIuZE3ipMS3tx5R0cPfEDnsF58y6KIUI3H8tNn7EyqWSoWf1vtoLjb5b2
         0eVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8PwcbYLcI09qfDxINxVvRFFpl2xsi4kodsIzZZ1JII=;
        b=kWTytBZAB2MzZ4dGTMDGQ3lyG5S3pxTIxsbv+tQi7dg6Dz6Y386YgYNtRIMYUNHHUP
         qqYgULmA+o06InFoAmHEIqmmDxOtZDhTi9R+gTCTsMeTAy+hSZ9Kabg1MbunDuh6xPny
         u0RV2v3LRIoakG+2c+7CavG83wbNvwf1o5GGe85CrvHfbLXs3qio2a8vqETZeO3ADpUi
         oiZVH5OrHVpwxsAq5ep89YKyzqf9hzYCzLVs1Oyr/SqZRs8b9ab2Wb+rMTNXoGPwuw31
         BWeO/QV1JEapj5Ppt/m6iOn57Dr5evqkM51JDzotQGGjtGwN9VXgyu8RTyLwlPma1R6z
         BD0Q==
X-Gm-Message-State: AOAM532LqzhDCM3xg2KhERfKz9IvBAFVjmaVAsI3pY2IONI/2H7xqPQ0
        tV6GbnsHyBemi22qfcoRMHYhdv3796AH4pje
X-Google-Smtp-Source: ABdhPJwov7Y+INTtQQIDet83ulQtzAkb49KQzHfpmiQzMPGBwjNdKu1xZBFeG77Ip3GOg8H5nONWqg==
X-Received: by 2002:ad4:4dc6:: with SMTP id cw6mr14216786qvb.31.1615580791616;
        Fri, 12 Mar 2021 12:26:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g14sm5127137qkm.98.2021.03.12.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 36/39] btrfs: cleanup error handling in prepare_to_merge
Date:   Fri, 12 Mar 2021 15:25:31 -0500
Message-Id: <aac09cbaabad84cf0bf15f069023d5cafbb1ee9d.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This probably can't happen even with a corrupt file system, because we
would have failed much earlier on than here.  However there's no reason
we can't just check and bail out as appropriate, so do that and convert
the correctness BUG_ON() to an ASSERT().

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 857da684d415..8f7760f8fcc3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1880,8 +1880,14 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 				false);
-		BUG_ON(IS_ERR(root));
-		BUG_ON(root->reloc_root != reloc_root);
+		if (IS_ERR(root)) {
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_abort_transaction(trans, (int)PTR_ERR(root));
+			if (!err)
+				err = PTR_ERR(root);
+			break;
+		}
+		ASSERT(root->reloc_root == reloc_root);
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
-- 
2.26.2

