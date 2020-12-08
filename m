Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AD42D2F98
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgLHQ0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLHQ0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:15 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A03C061794
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:52 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id l7so12283594qtp.8
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctG5OJgA4JZGZ1K7sXn7NXcWoMXX6vMm3B7fMlYwpLE=;
        b=f47qdFYbjoavoN3uo4U7rCjy6NtukDlKy3eyqivPvsZTW/MGX5O8VWe/6bPn7VtXCU
         s6Sqghhehuo+F4Tvi7XA2cBqRf/EGBLoNzB4rrU/d+VZElHrbwz8IzPw2IdmwoSnf299
         neCSYXf9vmrJTsQM3s8Yf4ejTFniv/HF9R03WpenqZNaTq+AVVcGqgW2+wXvRpG5UNF4
         Q5oVaGz9wbYYzWzbgHaOibCHsWWL0V5KMsJj1K8pEEoIi+pFPEpQCEEauG0ln1U8SUsI
         xpISEvro2OVXYPMpaTl87JupMA/Xf4QnW2jfZ+AfsV5knp3YkGoWsJ3zVxh4WP6jVBMu
         fbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctG5OJgA4JZGZ1K7sXn7NXcWoMXX6vMm3B7fMlYwpLE=;
        b=k7lGIbJV0aaIoPDW7VhnKQjBZ8MR/yGohSxN706jFsfAhlcswuXQNp3zhGWld07Shy
         yF12v9wh2gSocVSXTwU8LJ5OaPQRvSlZf0vEv34vBKsGqVle8gVHIzjRL7woRhOJXcjU
         VLNTeDSyiBXauvSXeLi4GR2vnoTR+lBKoxa7JX8Jm05AzxXA1xCVMmzedgSpC61apQTm
         Yh45fz1LaHW6hxRITXilyYkWWsva9Au/pUdd/C3PlKWFQke8sobAOJsOlFbmzvuJH4G2
         hoDYy/SV3PwemK5j6xCQhypsMUBD+P4tENIKJmbGlu63oyt7K4AsoIeyPlrx4KeOF9G0
         50YQ==
X-Gm-Message-State: AOAM530/CTgMMEURfAe3mhgqRaJXedPmScDJNqQT8kEsJX36UynOx8sr
        wHgkiDAwpNTXoc+ztuOzMHCLVQE5Y40RxbZ/
X-Google-Smtp-Source: ABdhPJzUa9da22i/IhgEPPLo+V54jSi2uDwoo0dEvxTnr/36BhuHStbj4v9WSmeQIzZlte6I4g31Ug==
X-Received: by 2002:ac8:71c7:: with SMTP id i7mr22312066qtp.47.1607444691044;
        Tue, 08 Dec 2020 08:24:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b197sm14627504qkg.65.2020.12.08.08.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 22/52] btrfs: btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
Date:   Tue,  8 Dec 2020 11:23:29 -0500
Message-Id: <8f0e919db0d6d294e2385453e5a81ef18ea2e6f9.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in relocate_tree_block.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bc676c11a2f4..a0453d67749a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2550,7 +2550,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 				ret = -EUCLEAN;
 				goto out;
 			}
-			btrfs_record_root_in_trans(trans, root);
+			ret = btrfs_record_root_in_trans(trans, root);
+			if (ret)
+				goto out;
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

