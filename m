Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662212CC735
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbgLBTxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389828AbgLBTxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:34 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3BEC09424F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:39 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id k3so1312811qvz.4
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3XOlrMbZqOyrnJ+x40p8pbEpFfea+152PUTnEKjMIdw=;
        b=RPeQQHIGsyO0ggtosVIluOaJD7yI0Ma6i6DGfYohxP8qINFLoNmkSz0vylyTyzsiqj
         QIFsGEpnjbcNa1SUnN/KjnES/jwGKM3N7MfGdxfdAk8RTG0Bzy4jzi0oQaLCtIlCr2w4
         Rthrf7SJrLIk/z72SXceq+RlPMMnDCq5bkPh9KHcdC/IFfue+8o49Wg35uvmAe4iM8Z1
         GG4P+nXKaDPcRKZsb9XOSkXvU6GWqSRcUQPR5yVKZX99d1CgR9BQzZj9Hn8sP/mJN3dz
         FX0qpT2v/sJe5muupQGjUZ9NEVVBmxgj2QC0IqpLMGXXHCOjskj1yRWLekycB/f2KAK4
         S3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XOlrMbZqOyrnJ+x40p8pbEpFfea+152PUTnEKjMIdw=;
        b=oad42+eIOcEuq3QF7w+xn3SCMw4I4nGsTN3M7YEgOn6SrH6qQmHvjJCyBJItaUPbkJ
         DM1WXTS1FDAbijcWSDlO2rOJWqJsKKdiUELeORvBQriycUji+ilYBXRRWP0XRdQuGkCO
         J2HW8ajMdydK5XzgNmtye7lRrvfem2jvis/MV4f66B9O7yATmY051Lo5MwRZqJSe/Msh
         fvS1MqETXtZ6sUSwtsyrF8nHP36alxcO2xuF/q6TOAR1PzIpONxf8dPCpw9DcSC67A85
         JkSQ1wlzL9eyyVySGoQuz+CemKE7kQcIlZAAXDzyTAmqV2J2KZIWL0/A1QVibpYPqQtg
         6WyA==
X-Gm-Message-State: AOAM531XrT9Ej2IlA+W9zTRnwwFfVaeAMmvJ7Co4PmdGNMNykdTpjE0v
        JX/GsKIThX4sJzdjBkSHQVDyK5SNrOnNog==
X-Google-Smtp-Source: ABdhPJxQWT8M2qJIDfT1FpJ0w5edxWeaE9xISsvcaKdECtmMEEvkt/5wG8Zn5HCQoGotR/p9kAeh7g==
X-Received: by 2002:a0c:a992:: with SMTP id a18mr4198138qvb.21.1606938758213;
        Wed, 02 Dec 2020 11:52:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a123sm2855067qkc.52.2020.12.02.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 46/54] btrfs: handle __add_reloc_root failure in btrfs_reloc_post_snapshot
Date:   Wed,  2 Dec 2020 14:51:04 -0500
Message-Id: <b6828b73e6b324c40908877fcf4b9930986a3766.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index 6315e74c1da0..695a52cd07b0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4204,7 +4204,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
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

