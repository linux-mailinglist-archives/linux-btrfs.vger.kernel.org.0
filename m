Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA91794DD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 17:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgCDQSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 11:18:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33813 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388278AbgCDQSj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 11:18:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id f3so2173831qkh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2olMn6iFNaS6/+7+ZxxEYJVX7riI9WVDb0uI0sXvt1c=;
        b=PL0IN6fphSV6vDpKX82QGPT+25xMAWiR0yIAtANjIGYCGp3zu628WPqpnTOisoxcDX
         vcuiqHEbIEdZ6svkhFpaV/iAbqeNDKpXVsDWlNeIuesf42FM6PacwZRPUfjBOlfdlQoH
         vVV7mjAU7DM/y6CRj80zr7MrZt6hdKmKTpKlNuerXn7QNX/IU7LPVPP7Vt7OrB+XSh3S
         SwY3aeQ2HsKmPX99E+f6NgcBw7d2LPzZ7gVzwAZCwhEmMH/2K0F+qKKctYrcfQHojTfC
         qbBIEMKmJ42FEqpKapG2Yo9ZNtdcPVyCtA3abSw2zEk6NIVMaBrTimckhg/p853Uu70d
         Dh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2olMn6iFNaS6/+7+ZxxEYJVX7riI9WVDb0uI0sXvt1c=;
        b=Z2QkUP4SI6LcZZu2s5YmvvbM5qCFSblzhWO0fFRNcxuXViwnPAoYFoVsXz9oqD6e5s
         mRFoxQjXER2eNjCPZn/xmRVBYlp7uNeJJazs7gB9cxPOuwk2SHIpUYEEje09UfFf8O+U
         WYZqm1/yaXB/ppIPB3k1P79Pr6b0Ed04QzT9H4TkXeZDXXMSoW9tgA7TvycpP+UM8Vcy
         lQYfGi3S3iDEMnlptdkMKzzyDUfUTL2ayMC9hiBns5Ya7uqYhWoPeA1yjmkaUemYMyF+
         CqWzC48KUr5fEj5GdwdG72C3misMAIrHON4cibhy/kUhz9BLUk3ynNHNx8Oc97cpv4zh
         qK5Q==
X-Gm-Message-State: ANhLgQ0H5Nmoo9tsKyc40nzOIWymtHaJVGDA6xo9ZYals3+KvRMfZDJP
        /Anv1bicPOSFudXSGybdp0+vji4unMo=
X-Google-Smtp-Source: ADFU+vs8UkOJ52dHCJfS1p/JtXP015B/QSBCgM/2kRoMZfokHLXtTQ4ki3TIPAzXn/wLdkgXB0yOxA==
X-Received: by 2002:a37:b646:: with SMTP id g67mr3206518qkf.52.1583338718059;
        Wed, 04 Mar 2020 08:18:38 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f189sm8482689qke.90.2020.03.04.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:18:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs: unset reloc control if we fail to recover
Date:   Wed,  4 Mar 2020 11:18:25 -0500
Message-Id: <20200304161830.2360-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304161830.2360-1-josef@toxicpanda.com>
References: <20200304161830.2360-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to load an fs root, or fail to start a transaction we can
bail without unsetting the reloc control, which leads to problems later
when we free the reloc control but still have it attached to the file
system.

In the normal path we'll end up calling unset_reloc_control() twice, but
all it does is set fs_info->reloc_control = NULL, and we can only have
one balance at a time so it's not racey.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2141519a9dd0..c496f8ed8c7e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4657,9 +4657,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		unset_reloc_control(rc);
 		err = PTR_ERR(trans);
-		goto out_free;
+		goto out_unset;
 	}
 
 	rc->merge_reloc_tree = 1;
@@ -4679,7 +4678,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
-			goto out_free;
+			goto out_unset;
 		}
 
 		err = __add_reloc_root(reloc_root);
@@ -4690,7 +4689,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	err = btrfs_commit_transaction(trans);
 	if (err)
-		goto out_free;
+		goto out_unset;
 
 	merge_reloc_roots(rc);
 
@@ -4706,6 +4705,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;
+out_unset:
+	unset_reloc_control(rc);
 out_free:
 	kfree(rc);
 out:
-- 
2.24.1

