Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC652B2054
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKMQYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgKMQYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:50 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BFC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:50 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id b11so4840675qvr.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ONZCs3a26umIDydlSoZb1Xt5ixWfxSt7u2jrPcmYIBA=;
        b=segC6SdRDrp96X4VCL5H2CKto3NaGlWtumgjoCZ5QbJMrMzhDdX7HDhFbhVMu4rYyh
         bcz1k4+QYkUgp9vw+V/QD+z4t3+AhgHuBE+BMf17ZipngaaPJEUWcjzG4HgxmdJWrfj/
         DLDx8fbtAMxuoAW/xC0K98jhuYV0wzQVzcTkd3/iTZYbtVBwHpp7UNja+uLaQdIHPFTe
         8oSu+EoCE/e3r1AdGZv9OdYsSELus++uOXU5Pt4HdN5patwyE6EA74ZuGaK3hXETYaz4
         CHr/qn6gsXmLB1ZsHz6GVX3kOMo2iH7Fm92aaVZcDLAkG6J3N7MAW08VTdoYyJLwwKr2
         ving==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONZCs3a26umIDydlSoZb1Xt5ixWfxSt7u2jrPcmYIBA=;
        b=loDR8eJehyhC5bMn4GtkL5LuLtqPyYpoQaXRmrYI9lTZSuMf45MgZHd0vTUyMG1nXQ
         4R+5QmhTSa3UELWPM8o8TJ4zx7OuC4Wludmy/WE2piLok8AlA8M7lTGA2F+DhmUvWhb9
         9tOQdt/dI5YMBZgUbGohyXEFEe9ChAFSD7pVobEZYN03OdbD5kWbt4Ec8qSHDvQxGQGF
         eM53mCyvLbHroYGZAFT51XCT8suUAo/jqC7gmZ5z4Efr0YaWMRPEhkN2byYABk1pZ+kM
         palRipF+yB/56pUAuhWcjdQIT6nwJbGXh1ztRixdB2Oyr2XcA7xPXJj8RXFWYaWgVs2h
         Rwyg==
X-Gm-Message-State: AOAM530svM5vkjOoWut9yYAatu2lSvkPc04QISjhvtdtBBYwkUC1JzmK
        IFmQreZA8YbEtMjkd4ODfWoMSHhqSrG3uQ==
X-Google-Smtp-Source: ABdhPJwP/PMuKMpNaf1L/xHSkoTmEDpIYR+dnOuha+Q2+0NssQNVOH+1J9LBywVVmHZgSpAKucj+Fg==
X-Received: by 2002:ad4:56b2:: with SMTP id bd18mr3166242qvb.22.1605284684868;
        Fri, 13 Nov 2020 08:24:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d16sm7117785qkc.58.2020.11.13.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 38/42] btrfs: handle __add_reloc_root failure in btrfs_reloc_post_snapshot
Date:   Fri, 13 Nov 2020 11:23:28 -0500
Message-Id: <4c8d6f371e82f4252f9fc48b1f0008e6e0829961.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to add the reloc root, drop it and return the error.  All
callers of this function already handle errors appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e2994fb15f2d..01dbcdc86cf6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4171,7 +4171,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	new_root->reloc_root = btrfs_grab_root(reloc_root);
 
 	if (rc->create_reloc_tree)
-- 
2.26.2

