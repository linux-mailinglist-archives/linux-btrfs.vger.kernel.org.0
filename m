Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78F2D12EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgLGOAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLGOAH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:07 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B01C0613D3
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:42 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id u21so9344557qtw.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OjSJwdT0JFQIv9nKJ1FZxFDxGJCV49ejVoo5IbSve4Q=;
        b=tZh3taecEG3/z07awRHicNv6t/bvGLIy+g82q+Kqggg5JtzZhebv7o6AS9noNXNb2s
         NK6FYkPEsCs0BqPniPl+HyGLqR8EcA1nk2pZsTCqKtAs9jkaXW8z8zkkCMcFJeNmxeoN
         LVZZ4Up1SlDaNp9a6xFouNklEmqFPf+Fmr7vlKsbwFSgtj1ALAbZmknnqE2us7RXGSlM
         RuUIpZcmg0g1v2CoSuJG8Ye1zBppZQUcHvcyOQXVnkd72oRQvEvugyhTzml9yDAOzMsA
         feJ4Bq8ltIZc1vAeeB7Nz120X4e0Hoo8SSo9fFf9eVwX8HnT0cap1nbF+/tiVgG3kJ1+
         EGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjSJwdT0JFQIv9nKJ1FZxFDxGJCV49ejVoo5IbSve4Q=;
        b=BW2JkW8os1mgc5NXleu6PFtlI/ZA47RePv2OksoKY8KnO9aSc9bWZ/t++SuUa9UYI2
         J0hEpLbhX1nGj5dDicv24l8R6EYwBA4T9E2wjs65aFaijKcpUBrjLpx0GxAsCOM2+Fci
         xZo5XcXhnUNJJFe4qZSioy6tnzaaLODpUWNVVPLYUoWeZAlQUj/Z5Jewp/YJ0WuGT2rC
         8HaiPl8rpCM0tRLFm83r15QSLZIdkAAaw4PXDiFWpDAgi2VPDvMD2FOQ0uqFUmsS5hpH
         SHZYwW0RjyRMbgYYQo0ee4tUAaj2SbZjseau1LbnVxrcibmeaMYBzIAMvnzF4C2mSVxz
         7mew==
X-Gm-Message-State: AOAM5315oipanG6P69fEkjJALfgKTPE/HogHfjkb8W0Qbmo3HmgDAdi8
        j8wnYwgsothHPL/6q+bzESeJE6yP6HQDHIV0
X-Google-Smtp-Source: ABdhPJzDJufoG8ICOvSFrp8s/Dqg+m5wNuMVJ36gDyc4kMWvgZiw8YM8mndv9yRFnL/3BNmGvdxTTg==
X-Received: by 2002:ac8:4a8c:: with SMTP id l12mr23338215qtq.7.1607349521084;
        Mon, 07 Dec 2020 05:58:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h142sm11894087qke.104.2020.12.07.05.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 28/52] btrfs: have proper error handling in btrfs_init_reloc_root
Date:   Mon,  7 Dec 2020 08:57:20 -0500
Message-Id: <6d59c5c4a31244b2bdfdec7f27b5f0e16e5653c3.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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
index a68ae34596d2..265b34984701 100644
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

