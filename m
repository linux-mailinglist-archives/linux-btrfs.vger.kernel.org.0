Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1D2DC43D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgLPQ2t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgLPQ2s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:48 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64775C0619DF
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:58 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id y15so17587332qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ur6ox4iL1o9MVeHXdYEjmLMvBsofMGEAupRdEsR8x8M=;
        b=wmv9q1p4FwH6Qb24vIzzak4sPILbj1fd8rHojC4lpYM3LjueuK7QVtjBzoxawnvbIH
         Ialnzvam2EgCpWqcgomRGKeADy1iYjMSrdR8h/HZlAxM10Q9PQ3VfD+d6BSE4bFBV1NK
         rgOZ34zSckbwl/bTWyvtyRAdiTZzKWmqgBxtWtSDGU+VQXHVzAOEocfhzo6Me1c5uE2T
         ctGwa41J4ZdeNuFN+v8WwkapXD/peeiWpJ8y2G4q7WeHxrrEu7G4cx3ZUYRPRwPMlJjL
         QwEx3z7mJwNyjc5eL9ZnKk2RavxmGi+bUNnqrjbz8LStAL6N4ZRMlw6tjFVM5luXbcqW
         8ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ur6ox4iL1o9MVeHXdYEjmLMvBsofMGEAupRdEsR8x8M=;
        b=gwiLIgtIdOe/mp/QvdeokcdRVFpjgahYMU5Qee/g3aj4RqvI70+nhwpdlAR32QKTej
         Qh70GwP8zGpfs4NZo3128gyowxcuA1m+2uKOw6eZ3XR8CPo81XbDXJDTN+lSsObn+dbt
         cXJBxuc7OQv03MrWxTzG/6jgQUWjXXD1n5efPYT5HWfu5PxU8uLGbQ+3ngLyPGVfbYel
         +Gx0A2NW6sdEjx/rB7XB2yPc3OXwCZLVXk5+u+GX8L8K/Hs5EJzqwjLy4+J99S7uaed4
         +OK/Rj5w27xcHwTCWFdn70IMH4AhKO5Gib7twbRa/K4VDmVetKCfNhdcXYLSWQO7FPfB
         +sxw==
X-Gm-Message-State: AOAM531hcEI6H3fKl4kzRgM8CTSQWssVtPFWHntqQGN0hoFohLQKrhgY
        JGfBQBhFlGzCcN+I43w1ply6xn0UoMpze1rC
X-Google-Smtp-Source: ABdhPJw4SUbjLwrmU3Vgg6Rftmr4wgmv7AyV730pFoJV0VQaADYsWF65pbfcNPkC42Pfxe6oAHLaGg==
X-Received: by 2002:aed:29c2:: with SMTP id o60mr43227293qtd.253.1608136077339;
        Wed, 16 Dec 2020 08:27:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u26sm1332231qkm.69.2020.12.16.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 35/38] btrfs: cleanup error handling in prepare_to_merge
Date:   Wed, 16 Dec 2020 11:26:51 -0500
Message-Id: <1d9d1340374c0f463015ff251884aefc16dfb752.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
index 39d5cb9360a2..56f1fce7c746 100644
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

