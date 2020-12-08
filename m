Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0892D2F9B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgLHQ0V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHQ0U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:20 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867CC0611CA
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:40 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so12326154qtp.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dl/Aw2BmPy+Fr31OlV+WjvuybjetsFQpW6bH+5Wn9dY=;
        b=QUY08Avelz2ymYlxm/fMtVYQsYuzqJQxQwUc17txIZwi1GSyDgrI4u2GMoxWxdpo2b
         RTuKEISBaROx3lkuFYat4nq05hlACrDKK5fErZ/snRxPj7yvQ87gUoM7Br3OfKtXsGny
         rvQIFSjujRDvo9OcEe8XdqjEW5AXBl+/0VtmDBkZ8WZMUHYWGQARBs7p5rgt/zMSabLS
         NU1ZmKk5nlvovQmHZhDBmPUQg8lz5uU8Xf2G6yuEJg+/CmOa8YzHpf7zHKg9Fpu3aduM
         Gl+21ZotCDOJGSzcsLvULEjx5LWqHbG55sx51HG0BX6g2CW2/PnGdEHxWYKO8xoKzJIS
         sZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dl/Aw2BmPy+Fr31OlV+WjvuybjetsFQpW6bH+5Wn9dY=;
        b=hG3fP/5u1M9w/aot30ZHTVDnSp8IZ0SdV1ECmqFANx3blrXw3ctnmm+hUosHUbGPkx
         QjhnJ0rdo1Zhi0JxWBDHYvVq2jaxb02yMOFB8egpOTH3GG0adozGVSSdgxu1gXp5msmh
         8BA+PIF3nkX4gpKogK5RcAiTxtwzK7dFTjmS8HPmUlqWAsS46mOLwOfgCm/UcxWXDzJ2
         kP7G956zJ0HmPdGQsTL5glymZudPzT5ZaCmnXZ0yl/l1RvfbwfionrqzzGpItT2f7Mer
         N/JEgLBeXQdLfKWsmfbHRfZZX9DPc0O+k/RW4GrobPErOL3lxFVGpP8ZOe2riOxbfrrc
         a0Yg==
X-Gm-Message-State: AOAM5334hc9fB5u8HT5pa/9zYYKJ9KsawLtqsPTAm1mJrZ0MJEril17p
        Ohb56sA+AK1N+cb8Y6QRvVsQfxkPsa0B5RcR
X-Google-Smtp-Source: ABdhPJzwt0n/8dO6sbrEjpaej1C7uOnF4cpPfwMTrNYZeLLP3hehvjZ59/UrcFYRfJ8xr1YCNb65bg==
X-Received: by 2002:ac8:4cde:: with SMTP id l30mr13252721qtv.144.1607444739594;
        Tue, 08 Dec 2020 08:25:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y6sm5085897qkj.60.2020.12.08.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 45/52] btrfs: cleanup error handling in prepare_to_merge
Date:   Tue,  8 Dec 2020 11:23:52 -0500
Message-Id: <4f6363129586caea2cdfb84c1594c76ff713a773.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index af9008a71ff4..b824ef069ac5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1870,8 +1870,14 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
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

