Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94902DC42F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgLPQ2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgLPQ2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:34 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0935EC0619D5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:32 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id 7so17648976qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqCBwEZJcP9oKXydIwojoncE9VQDvOpfyVCaDqYEQyQ=;
        b=rBUYEswJoRc1WggdgD3LFLj61pGqarC9InIQdYCUI4P3fn09Rx06xnSpuUinw+8fLR
         V4DLOg4AxBObGyff8Ma333zMYO3MuV8r1euW+UemaNj+c+1Xb4tJptzXEedsOe0xlL1d
         z0Ji0wws1dvzqzvmDlNxRV9LWBKzBGzIKi1zirh4p1WKAykQnk5SuuT7Hy+XuYzqi7b0
         dFL6Bu1xsJ4R+Fe0PaqgxgQsdhZPNHsVSpk9PM9T0hitCnaeFaWq7cMYKULIn09sJao3
         PCe02Z86QGkJ9Vr/qrN2+kUkQ89D4wuaw2UoAvmHmj9+YNZLOJryOT1d/LAgva1IwqZ1
         PjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqCBwEZJcP9oKXydIwojoncE9VQDvOpfyVCaDqYEQyQ=;
        b=XOx/2+UN7GPt1UCb1InjEsV3l5XaakDX55F7Sc7XAqTqrZv1ifBJsgymg1JZ0RyDfg
         apvrsR4OX9bo7lrAmJ4Kj2sGy6YrqOQ0aKmB/NxqjIEpiSP9IUjb4yBud8fvyI+sYR7f
         lvPK4kmHeIqFPNF7ITY3gbY4sJ3YChHmfSh30s8kSxied34K0idHnhxS3q4MGxBd+jvu
         4NexInYg+BHBQsu4XnTTQf+8+0MY1OuaK27aZuOw6k+fMM1YkSyvJvpBqRLWeJLhX6M/
         R77xos2bEqsCSJAL3Q4Ba4N9IHnHDFZMRpzg27nEhNU1Z0uMwtBwHr30/uzrPDtY6p5d
         2qlg==
X-Gm-Message-State: AOAM533Wn9UrTSG8ExzZBxTI36kqVIeB3YXZFgAshhXWjx7MFkkkFBYi
        gg/5ZaS+ihB0JmM1/VCcwylSORtYC3F7fYit
X-Google-Smtp-Source: ABdhPJxCbLH0+7yP6oE7uR1kEok7h36zR4B6zBQsLhtuT2lf7e3ipuU5/lhAuPjJEnlj89FzxXO1EQ==
X-Received: by 2002:ac8:2bd2:: with SMTP id n18mr44486778qtn.260.1608136050962;
        Wed, 16 Dec 2020 08:27:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k7sm1278796qtg.65.2020.12.16.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v7 20/38] btrfs: validate ->reloc_root after recording root in trans
Date:   Wed, 16 Dec 2020 11:26:36 -0500
Message-Id: <68fee71b3bc3bd34cf433cc1ea6cf5d9f8dd4b82.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to setup a ->reloc_root in a different thread that path will
error out, however it still leaves root->reloc_root NULL but would still
appear set up in the transaction.  Subsequent calls to
btrfs_record_root_in_transaction would succeed without attempting to
create the reloc root, as the transid has already been update.  Handle
this case by making sure we have a root->reloc_root set after a
btrfs_record_root_in_transaction call so we don't end up deref'ing a
NULL pointer.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d5740acaaddf..918fee55bc30 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2083,6 +2083,13 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			return ERR_PTR(ret);
 		root = root->reloc_root;
 
+		/*
+		 * We could have raced with another thread which failed, so
+		 * ->reloc_root may not be set, return -ENOENT in this case.
+		 */
+		if (!root)
+			return ERR_PTR(-ENOENT);
+
 		if (next->new_bytenr != root->node->start) {
 			/*
 			 * We just created the reloc root, so we shouldn't have
@@ -2580,6 +2587,14 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			ret = btrfs_record_root_in_trans(trans, root);
 			if (ret)
 				goto out;
+			/*
+			 * Another thread could have failed, need to check if we
+			 * have ->reloc_root actually set.
+			 */
+			if (!root->reloc_root) {
+				ret = -ENOENT;
+				goto out;
+			}
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

