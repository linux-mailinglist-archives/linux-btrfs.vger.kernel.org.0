Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7672CDD8B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502074AbgLCSZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502053AbgLCSZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:19 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2FEC09425C
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:20 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so2052472qtp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhGtkRnXplYY+CEDULNniNTVseakGw1lct8t29E1QDA=;
        b=kdd6AxO4gT3coIcbiJ+bPwYlHRMSNi+QTPFbwmdj1anvLOEYmkxIjQFqEcXVfoGkb2
         tvtonGD/auqoKBD2lTdz9AbarBXD0hI5vYEb8j8CbE3GSgcmkFDRC2kwyxJljNQZ1MXr
         MX+kk8H6/6T7dM4PE9zVUCs+GrtVeYZG1cGkapZN1CVNU9Dl9gNgGRki8Bws+nU1qPSR
         wgKsDR86Epa+EwnkgzQTtWfKjZzdu6Y9WQ068kKo36c9PW/OFuO+eFPlf2sioCEeXHT1
         j4dBU6QCToIMkb2eIrTZsJeQbQwqRLPSVzFZl5+US/GHH/BL5Cu9vvoKNxRmD4qQXo0S
         gEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhGtkRnXplYY+CEDULNniNTVseakGw1lct8t29E1QDA=;
        b=Hi2+TOC42hWS06f6Nnt2QOopOHs8k8GETiwt2hUzrBESOW6RdViJ1b+TaV6bd718iK
         OBUGYzTYjF8KLB0OnI7gQRw3YTexSzmrOS7KtYPkEFufwc8Lc+DUlvHhl/dDNxiJSljT
         fzoBXqvsJMjNZJgSsuFYQ9OSXhfrBhnao3rVh/RD5zuQlR/SJ8LSkRSEMYOhPiBDO/pv
         cN+avcFHkPXOMy/QpTmcROTLGN8PqkYkZs5c0F7U0kMMJ4ZP7MzkcjGnBWKoSTKzaX0C
         lxUjlaWwdGf3toVZEK5/q7UUdu1wRin5CU6EBinGWr2iNhxu0dpumOl54YboNKw1zdfE
         mZFQ==
X-Gm-Message-State: AOAM530yDmZfUes4wDuTLy5rL/B49g/cz5+tHgBgMCZGz3TD1nU9ZvNL
        BuyVtmS8OqjqHVIGy7TSNmyn51bP5dX4ilY3
X-Google-Smtp-Source: ABdhPJxdiyeaY5XrY7Y6KHfpRqGaJkoDxBjRoWG2TvYwb2SJBmEEU58fBuXsCJ7BABzkePLHIW0fBg==
X-Received: by 2002:aed:3144:: with SMTP id 62mr4558974qtg.342.1607019859565;
        Thu, 03 Dec 2020 10:24:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d12sm1936845qtp.77.2020.12.03.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 45/53] btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
Date:   Thu,  3 Dec 2020 13:22:51 -0500
Message-Id: <46761d6e45f65747f4f927c33e34d3c55b46fdea.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already handle errors appropriately from this function, deal with
an error coming from __add_reloc_root appropriately.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 05b42a559da3..a2900dc71c72 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4007,7 +4007,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -4222,7 +4227,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
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

