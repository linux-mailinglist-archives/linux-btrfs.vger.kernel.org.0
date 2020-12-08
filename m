Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923522D2F99
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgLHQ0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbgLHQ0R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:17 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB656C0619D6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:04 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id w79so5386328qkb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/nQwiagWOgqRM+nMIeb0R2gQ6YgS/wzwB6kYT/kd+8w=;
        b=wf/hMBxTD5xN6Fa+U/808xpqR09TcSyoCcMmFyf7Q/d+K2UAK+9/BgKyUkW044odJE
         GVsAxlrUcjcsI3CN4zsonvS0L3aWkZGEUtnX2/EP+bZnrUb0NA47wm7XbLTZtW3Z4J7p
         AXYyhyfJNV2j/9pctUQdychZk45TBuT5BS/intLPwt/8S7H1/1pu7H2df3C8TmmcRFyq
         m4bHEOgjH4Y3uumJrhPjlVL0UemCfzU6rlE6nzwhY/01nrAT7ygt+pWVGj3m14w9Mxfk
         BxHxxXjJI4uuj33ZkaIVSyxfPoQ7xAQ3h36qJQl9+5I8Cb8RKIbvJDEb0g7l4Nc99nIZ
         3WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nQwiagWOgqRM+nMIeb0R2gQ6YgS/wzwB6kYT/kd+8w=;
        b=AWgGiugKR8En6ubmBvybF+flm7pzKGw2betTIZUedqsjdxHRDj1DBZiIASOAYmmx6P
         XCFRIACeA0k81SyEovxgfHOh+c7+Z3S6KMx5ZShmjHn4KYYftVBTRsZsWnxlRWk0gFmi
         E2LDHvVFlugmfnhwbGOyTINso/jfzY2TaDwSf3FSw3Ribp4QEYhee+fwscWKL3sNmZCD
         Wi9VEw4r3Y4gNkEbZ2qUQVqV5WaxoAbWU8lA7mW8qlBv9XDc6ScX/Ap5+E3AMRYfZJYO
         KV04+IeeFk2TclERxg9dTqriDnKZzkbU0Tbn3MyIn7gEFn0Y2HJjGw0LGrIf/P+e+EGz
         3ZzQ==
X-Gm-Message-State: AOAM532W7nNJjWvC3v5CULi0D9yoFaXXs/qL3uq9156kfha7D6kJdHbT
        0Pt5CSd72PQLNmKreQ1D7dMujP9p+GbWBdUE
X-Google-Smtp-Source: ABdhPJw+IP3JOqz83gJUT5wx0WW4yPWztd9kcMj1BTZqy8YLJmFU3np70Hn7eUqpxNMvLZctS90eKQ==
X-Received: by 2002:a05:620a:95d:: with SMTP id w29mr30541867qkw.147.1607444703637;
        Tue, 08 Dec 2020 08:25:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y15sm4718800qto.51.2020.12.08.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 28/52] btrfs: have proper error handling in btrfs_init_reloc_root
Date:   Tue,  8 Dec 2020 11:23:35 -0500
Message-Id: <179c8306435d684a075019ef359f4727679ef018.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

create_reloc_root will return errors in the future, and __add_reloc_root
can return -ENOMEM or -EEXIST, so handle these errors properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 36323cd08bc8..692a24ec7d83 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -860,9 +860,14 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
 	if (clear_rsv)
 		trans->block_rsv = rsv;
+	if (IS_ERR(reloc_root))
+		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	root->reloc_root = btrfs_grab_root(reloc_root);
 	return 0;
 }
-- 
2.26.2

