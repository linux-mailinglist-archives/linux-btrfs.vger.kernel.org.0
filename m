Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D72D2F89
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgLHQ0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbgLHQ0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:01 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3CC0619DD
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:19 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 186so2511443qkj.3
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yGA6i5eUcurMkTIS9etR8PmmZIrcDt3XNSYNKFX/Uw=;
        b=2FwKmIaGF0xwn1FAHq84uTQDh+5ZRMdVRpwGg2WcyCgybbYq+BCl5OGX5/ZcJ+yjpf
         0JC5KfujWHNXPieMbt5yrIEcazX9fRz7wS5zF1O9U9flg4qjDpL4snkSG+ImzgGceajb
         Mk5Hu1HHbdM/oSa7eG0/aadw22TNrWv++JKX8fm+rSUpqKIPWBSkoMVRi5qod0sjBbY6
         /cvjuKmyLbjTKn0dkwwZcbR2vA5vF3EShBGtkl8rWgGb4Fd8yFk7Iws07cUCu+KTbAwC
         lV1nVFuTI5L4h5B5urNHP5etqJYInkVIwrRFYhS78mjc/AOS9VozaZmS9dTCQbW3PpOP
         gygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yGA6i5eUcurMkTIS9etR8PmmZIrcDt3XNSYNKFX/Uw=;
        b=HP8UsDijyy9w7eLkhm7LZS414wzXZrK7cA3jl4pDrZ8z9T6crllNiwice+WkOQZkRZ
         tpu4KyL1vLOSYaKKHEli5aUgrJ8kT+ln7qbFT8GRz32M+0pUMF9x+PEzSEOJjyMftmoB
         jFJXji+FHY9X/j215h9hL8HIFxL8cKkun78gzaUjoAFlrkckEiwSgQBrlNXgQcF/ZxqD
         duyjW03iAkax5lkiJFNlpg3cOnOJyFdEQ6Q3p6tmWCxibppar5pqghDqt2v+IIrZNfLd
         8/+v7FM6epc8lpaol+5Gf3Awv0V50zGjg88HLPQxCkcinKVNe3K6zpV+Is729OjIAjm7
         Kv7Q==
X-Gm-Message-State: AOAM5314qp8MWogRlEHDXtI/tWcyhyvBs25QTrg9DkngEUNH/+y++KVV
        OMecK+xAUB+xG8dRNrWqfRlamxY978gNLY1l
X-Google-Smtp-Source: ABdhPJztYSNOTaa1H4vYvE+C/pQzy7klnEUetat4KYM5yWJeZwR3tSQ1PdZ2HV8oTQ0SADY2nf6J+Q==
X-Received: by 2002:a37:9b8a:: with SMTP id d132mr13801467qke.81.1607444718604;
        Tue, 08 Dec 2020 08:25:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x22sm13690089qts.53.2020.12.08.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 35/52] btrfs: do proper error handling in btrfs_update_reloc_root
Date:   Tue,  8 Dec 2020 11:23:42 -0500
Message-Id: <fa2c107e14e850ce7f0d7c8273bda555eece8495.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We call btrfs_update_root in btrfs_update_reloc_root, which can fail for
all sorts of reasons, including IO errors.  Instead of panicing the box
lets return the error, now that all callers properly handle those
errors.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c99f50969e24..49caecd897d4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -894,7 +894,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (!have_reloc_root(root))
-		goto out;
+		return 0;
 
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
@@ -927,10 +927,8 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&reloc_root->root_key, root_item);
-	BUG_ON(ret);
 	btrfs_put_root(reloc_root);
-out:
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.26.2

