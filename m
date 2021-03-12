Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3BE33985A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhCLU0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhCLU0a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:30 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D075EC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:29 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id n79so25709142qke.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzmRF3jfxiR858OqDPfYWOrK5vGIDaao1pthditrTgI=;
        b=iMxdxqFOnitOhTP+XS98QtUMs3xBqq9RPLTnx7lrFbLF+yNGovmdXUbwUJKTrek6TN
         owNFuU01lZtycmUKP9FD9reNKrIC1vzonIQMI7rhRVBsrvS7dMdBxM8m0fo1/TOGjTQn
         RwHmfVwLx9rys7FJUD+EtGPfN9oocIl0Yuty9UgwDvoFlNWuHpR9hIxuzzimh8YGIrtl
         t8vXaFIxjkgH3506xtvNaB2y1xxT7dB6+x2oZPyeDjvk2bQcun5ntVzNb0oPcbPcYnTh
         Kl+iwsJ8cF69FMynFBaVg+O1faDQwGRhc/b8qlaVPl0IcTpyIfYjhbLqoxyJ6X4PwnOZ
         69ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzmRF3jfxiR858OqDPfYWOrK5vGIDaao1pthditrTgI=;
        b=fIqQ7YfGj725Z3Q2BFWmwGfhqpCP1Mx+bsFYCtWSHt/zY9BpIy8IeawYmibmoz2kSh
         XLxYNmiouGh1mIR4SMdQuhSbIAweJcGZK6t2zRlW4ANFTRHWSAudq1lI+wp7V0zwNoBf
         0OJtec/UpbqEEA9XQ6F645ATNOZEi3zCIxWffGJPn2zp9cyI8M72BRryeyYVznjV/frA
         2F6nA1RGNzoagryUKcYWy/Q2D/OrXKvxP2QPHlMNmC/GtRe5H1dG9OANTXdH9Y2gQhaJ
         BiikTaY2dvP93Z01qJ0Zbftp2F7qBftcSEHZQAASwn6sDlVj8kXm4VD4xxuw2C3/oVd7
         bnTw==
X-Gm-Message-State: AOAM53091KvJP8L2a8xrXQo1fBDbUjwAazG9iwgiZCa8XoTXeseq9PA2
        pCKAU+9G8VtX0aYJnUrKiC5Dx4nPQ574kAW4
X-Google-Smtp-Source: ABdhPJy09CLg8M29atjznzJNi0xOfKFa8ZIohbJraElushk1fURpB56Ckh2tygKKYW/JL5kcGRjBmg==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr13598090qks.50.1615580788794;
        Fri, 12 Mar 2021 12:26:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k8sm3209414qth.74.2021.03.12.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 34/39] btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
Date:   Fri, 12 Mar 2021 15:25:29 -0500
Message-Id: <49e19eed0473ca291520ea958d557634fde6efe7.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 43037cb302fd..2fc04f96294e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4054,7 +4054,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -4269,7 +4274,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
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

