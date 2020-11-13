Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA72B2053
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgKMQYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgKMQYs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:48 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86FEC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:48 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id n63so7040808qte.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZuamnsNghqOzU0Ijlc2xZ0b45UoEziTlwcHZlxtSbPI=;
        b=IzGNRLmoXBqallqIa/APKDPvEOBhzULrPkWn67PppPsoKUGPxkgCtUkTXyPmXmnbv7
         sZyqD3jqIpf329LRMfTQG6oZ6WIac+9XhJE/jmwG6deC4FXid8dtZCqppD3ast2I1RSl
         GSgSEVT+eurXZjVkIt1ip2ZpKb0BiX+cm12xiCfjkEknw4j7fdATdfPukkDKK45i/atv
         yzNMS/Ecq9gXS2Ibmh9EAN6thzQTYvNq4EvakKb1QuT54mpRc0ZIwL+gKFN+8DwDzUij
         NYdbQyIRKYab5YYe1YOrlWjiXltsAxPb1pgaxUaPxIqxQN+BVyuQOqMIHna6AvVpGU7D
         743g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZuamnsNghqOzU0Ijlc2xZ0b45UoEziTlwcHZlxtSbPI=;
        b=lqtsIeA8XOLx/krCJgHWt5LqKCWjSfTzA/R2Yo0mJlb8X8Ctz13Kh0d0fWbkSp3Efw
         wLTmhGU7ZC+3odv9MKiy23CGyGwRiRPxob2Y5uCZ/ONMkdd2XgNeaDav+rCuLhz1/Tad
         /RQ72TIsj9uXtzl3YSYerZMH8Yh4Ck8nPEa7BUwyGS/uZbYseSmlE+MziuptO/AhLD6O
         vXr2uDtOP6n54wGBIzr2tw/8DXbxQ4Ms9BOFSEMfIXoJ7I9QxCwMeu4nduSULKF5TJU4
         WituZx129s5fFDlVrz5u4vj7kYoMd7XuqzLIBTmqBxP038ZvI9r3mBRSFNO4bYNUgcLP
         zKpA==
X-Gm-Message-State: AOAM531eP62am4j6DvxFErYaNntwy30gjb+BQNrkQvMjIxpJaRcurheG
        A16/D2GLQQIbgCPV+eZtM4CC+Vedp4yXAg==
X-Google-Smtp-Source: ABdhPJxaXgi7S4Mc/YkKL2N5acu27d7s4nBeShy16yOzGS5Rbw7Ml9c7Q8McumpsxrMuYmVUotKKGQ==
X-Received: by 2002:ac8:4613:: with SMTP id p19mr2786670qtn.13.1605284682897;
        Fri, 13 Nov 2020 08:24:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j19sm6938599qkk.119.2020.11.13.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 37/42] btrfs: handle __add_reloc_root failure in btrfs_recover_relocation
Date:   Fri, 13 Nov 2020 11:23:27 -0500
Message-Id: <330382a46504f48eda1aace141dbf5c53d81c28a.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already handle errors appropriately from this function, deal with
an error coming from __add_reloc_root appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c4b6eef70072..e2994fb15f2d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3951,7 +3951,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		}
 
 		err = __add_reloc_root(reloc_root);
-		BUG_ON(err < 0); /* -ENOMEM or logic error */
+		if (err) {
+			list_add_tail(&reloc_root->root_list, &reloc_roots);
+			btrfs_put_root(fs_root);
+			btrfs_end_transaction(trans);
+			goto out_unset;
+		}
 		fs_root->reloc_root = btrfs_grab_root(reloc_root);
 		btrfs_put_root(fs_root);
 	}
-- 
2.26.2

