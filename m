Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF22DC446
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgLPQ3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgLPQ3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:29:01 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCECC06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:41 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id i67so15510073qkf.11
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9iPzHWw4NV9MR+ZDl9yTYR1+aMXrodjsoMwwshDHzE=;
        b=qEmrSdbuVmrJQTkcyX/g/5cMIOSjTtMrtvx6ogTUBZgFOac/qxEuSJd1l9PrH5hN27
         5h7RN3oTImVtyP7jUVxnE6umVdRx2vzWiYSD4qJ2Jq8ZTlH/1S4uB7Zpe+xyFmZdgsfh
         11IOJd0WYmfgNrs7l3MFZfHZKSstxn0tdMvh98Eu/QbG6HuBR/VAmpVOhA5r2bvtZtDs
         ZhhN1H79mEf0U7237mLjFLLx1/Y9MdWxnYNcBo8y3UNfTTDd5U2jwnwg6HH9jFmx4JRV
         /kLB8znUSNMsW4mnQAWqj3Xnt+Hb8Bs4hIrE7lnHIV06QLuoWFlZnz3Nlq+9Zi8uXtvb
         1kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9iPzHWw4NV9MR+ZDl9yTYR1+aMXrodjsoMwwshDHzE=;
        b=WEbtPrvupiq08GAqlr3ljB572IJmEmkoj11z1eW9c87pquYLiFtv4aUU19kHLJwWSy
         BN6anPRtYdRxZ8YOcF+mbNoYfSELGsNUaNFJO4vzE5juqIrtjJKCXZg3O1rKRh+WqwX8
         hVwo58lUEB1vj8yhg27C0TqPrnj5Eoe1xGnBD8QPSCD941YkCFND0N5lkxCuZeLQxwlu
         s29VAebEbHTgIIYaFR9OwOwpCcc1np+7dTqog3H6bzh5wTNL5P+1khec/dtNqyONCsS4
         5qHqacxos9ESHaRj0nJl7vFY56GO36Hpw5ekeEAwEAzmdD6KpXN1IaEqVeWDHPhzwc1e
         NTqw==
X-Gm-Message-State: AOAM5307+G8JhIClIqalsH/0dCAKra82tCSn2oY48gITnlR8G/lBN+48
        XF1XmtIJc0PQG3WaUOhsip6L1QeppR+t8z1Z
X-Google-Smtp-Source: ABdhPJzbU/4bYwa+KhK0mo46dHf+zkqeKH6otgbked3RfI3soPUp5kfIvaoEkkPH4Ytgyx3YimiSxw==
X-Received: by 2002:a37:5084:: with SMTP id e126mr44037517qkb.148.1608136060001;
        Wed, 16 Dec 2020 08:27:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x20sm1404909qkj.18.2020.12.16.08.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 25/38] btrfs: do proper error handling in btrfs_update_reloc_root
Date:   Wed, 16 Dec 2020 11:26:41 -0500
Message-Id: <8c7b7107775ffafac71bc90e28f9b88518cf8968.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We call btrfs_update_root in btrfs_update_reloc_root, which can fail for
all sorts of reasons, including IO errors.  Instead of panicing the box
lets return the error, now that all callers properly handle those
errors.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3a207548edde..73c8cc502b07 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -904,7 +904,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (!have_reloc_root(root))
-		goto out;
+		return 0;
 
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
@@ -937,10 +937,8 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&reloc_root->root_key, root_item);
-	BUG_ON(ret);
 	btrfs_put_root(reloc_root);
-out:
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.26.2

