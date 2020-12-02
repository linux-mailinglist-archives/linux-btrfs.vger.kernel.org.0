Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187BE2CC727
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbgLBTxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389796AbgLBTxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:21 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79363C061A04
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:37 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q5so2451104qkc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UsD+lUV2GcZMQYswSezo3sELwKxZU13lI6ByUqYpBsE=;
        b=J0PozPmdzDCbOFU8ivymJJtSR8GfjIZhq51piCVpY2h8xBVLCu2JF7ftT4bl3/fnlN
         VogfXfSKlMSJvoX3xgl1F4HiMAqvyOifn0DlZELZ1SGTawj7nB8Ed3rq8qsU6k/DM5BA
         mTa0YJjp+nFLZH0vnXgnjQaCZoyH7mB/OOM+evhAxx6bHLJf0ywr7/nIqUP5I2O0lGew
         EK9C6/PITSzw8kcu3m80Ml40JSqqpYTYNhAhhMsogstEWxik03lns5uPFRuXZMp4oOxv
         hlL7opYRGZIyPvSPvQaC2IFTZa9/ZujFMrKm27xViNuRCbEGUrqpLmUMOoq4JC8W/Gs1
         5Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsD+lUV2GcZMQYswSezo3sELwKxZU13lI6ByUqYpBsE=;
        b=Z3Rv1IPXQiHXdLQ4bKKuZ66xk0I8j1Yd2b5Ah3seew5HvbZRBYZ8FhSPwEjkH0+5Kw
         LtdvSlzmLp+ZfT0DC5J1QH0oFxAdVHSdnYW7cg+dsNFVoQFTeVIFdASCw9g9hsC5fykl
         f+/nclUxdc3x/W2IiY/Pvy9e42dQ8bZmQzXSHTj/gsHNdVXGbBJpwNXvenzsRVFZvxkN
         Rx6zo94zKK5yBeJVm8W6wTq39KLkGPiVyLs4vC8V4pjTWZC3aQumqDYCARb8jHveLoXB
         MqIwKPKqZmLmYcbbyMX+pvSA6nNIMxXPQ5pE7WIbj8TM3KJpcAuwlrnbkRjm22tE1aXY
         PWYA==
X-Gm-Message-State: AOAM5334VP5OiHFW92dYWBGMg/xGSgwlDcoROUBXfwfpCn0nMDrYWAHE
        9UHZrQdCuxOSjnybU6KpcTEaZCS8ix3zOg==
X-Google-Smtp-Source: ABdhPJxUgAxFPJvC3CwjUu6yS9na1MTJbK9AjJkilDJcXMNF48SYD0NBrL10HcZqj+Wq8w74kAZSUA==
X-Received: by 2002:a37:dc02:: with SMTP id v2mr4310856qki.181.1606938756443;
        Wed, 02 Dec 2020 11:52:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o125sm3112040qke.56.2020.12.02.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 45/54] btrfs: handle __add_reloc_root failure in btrfs_recover_relocation
Date:   Wed,  2 Dec 2020 14:51:03 -0500
Message-Id: <c8b8686a06271891df483dec87e3e6164cbc0f9e.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index bcced4e436af..6315e74c1da0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3984,7 +3984,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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

