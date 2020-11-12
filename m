Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35872B0FF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgKLVTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbgKLVTa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:30 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768ABC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:30 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id u4so6878433qkk.10
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jGJqbbWvRbNhwcXrxDQyGapgw2HfoqGzsOVAoWnP2s0=;
        b=tbIgz67bxrUK20SmbmQ/siQppc3Y9bET6eASaUbEL3ucV4SCUSH5+CNFUiXJ+bmhPU
         VG+fKS5c4MuBZ6wko//YLIsS5djCb3Ehg0/d/S5NTRU1UcTY1ZdKze7pRbz8WvUxOPCR
         30QckTRxXPPD10Tu7KSsZe3pJxwg+wsBKgAlN2ooB57qWmtjIcnhGet0W+qb8tsotnmD
         D7B2mCSqvQ5WcsJjAJUwEptN7hv9wydp1gzf0pID/TTr+YlkPiwezXR77idiuNu3qB3Z
         XVYdR83DaAN7gyDT8eukFbTzr5aeNwG2Tkl/omGVz46DdKQwwHjMEc+rswRYv10A1xMy
         0KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGJqbbWvRbNhwcXrxDQyGapgw2HfoqGzsOVAoWnP2s0=;
        b=DUH2J5WOkE3BVBrXmpJ1gcmMwzyMTVrk++1rLjQ8coowCNjVaiZaX46uZVZ/oVoe8O
         bazBrYKCNA4fjA+efZjNYJ/Tgm3mzeWyhGJcIhjct0ixbxi4oB1htapnrnuwgDadbh55
         YtyF7YX6VISuYiXfyZN381td/kZvAk+0gw00KyT0y6IulJ55ZO4q4ftdvUhN6n15Qa/O
         EeFoSC2mhMZgmEiTm+Da4O7AYeaEoz+ScN68+laL6QzZnlihVJZ/cnqXYkoV0L+/5xSo
         yp0Ch9QoFDkZNJe9L5Ad58lg4pj/mSR/J4q0rm0vY1trRZP0E/xso3kqnJ+3ciilWzGM
         3r4A==
X-Gm-Message-State: AOAM532671S2uShKv2NGDDMbByoG9qKhlcU6DWC2BMbKy8j8SIRNRlHK
        t3N/aUNERieQxlc5GpAD4lIp749TbXQGVw==
X-Google-Smtp-Source: ABdhPJzRhUpiNMFmAcp4xhNx6bi2gAambnh2CrrZq0/V6v6Se63v77YR16p9YozH65y/tW/+WA+6bg==
X-Received: by 2002:a37:4117:: with SMTP id o23mr1780348qka.479.1605215969176;
        Thu, 12 Nov 2020 13:19:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k4sm1579401qki.2.2020.11.12.13.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/42] btrfs: do proper error handling in record_reloc_root_in_trans
Date:   Thu, 12 Nov 2020 16:18:36 -0500
Message-Id: <3677c369793ed0521d003d3ccd1de39f4dc639ef.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Generally speaking this shouldn't ever fail, the corresponding fs root
for the reloc root will already be in memory, so we won't get -ENOMEM
here.

However if there is no corresponding root for the reloc root then we
could get -ENOMEM when we try to allocate it or we could get -ENOENT
when we look it up and see that it doesn't exist.

Convert these BUG_ON()'s into ASSERT()'s + proper error handling for the
case of corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5deaf56ceb8d..4d445cbc8d69 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2002,8 +2002,30 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, false);
-	BUG_ON(IS_ERR(root));
-	BUG_ON(root->reloc_root != reloc_root);
+
+	/*
+	 * This should succeed, since we can't have a reloc root without having
+	 * already looked up the actual root and created the reloc root for this
+	 * root.
+	 *
+	 * However if there's some sort of corruption where we have a ref to a
+	 * reloc root without a corresponding root this could return -ENOENT.
+	 *
+	 * The ASSERT()'s are to catch this case in testing, because it could
+	 * indicate a bug, but for non-developers it indicates corruption and we
+	 * should error out.
+	 */
+	ASSERT(!IS_ERR(root));
+	ASSERT(root->reloc_root == reloc_root);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+	if (root->reloc_root != reloc_root) {
+		btrfs_err(fs_info,
+			  "root %llu has two reloc roots associated with it",
+			  reloc_root->root_key.offset);
+		btrfs_put_root(root);
+		return -EUCLEAN;
+	}
 	ret = btrfs_record_root_in_trans(trans, root);
 	btrfs_put_root(root);
 
-- 
2.26.2

