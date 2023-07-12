Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47318750EE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjGLQoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjGLQoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 12:44:22 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145791BF2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 09:44:20 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-400a39d4ffcso4762221cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689180259; x=1691772259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbxPqSfNkaTpXwVO118i2YUaZSkv3KJ+5v+5UNfNCTQ=;
        b=Vr3SRS9xeDuTFf5hJNz3w4lj2/CyU1e4emv1+gf6wMREqL0nyiKImk+pJRb1iEAWjp
         dhvEFgDmjLjUSFpxcSZ6BiXq4CAnVmIJd6oWX5dg5jBYWQ8dLT0dhku3mrbgZlpcsxHT
         t+S18+8mM2l9TEuChBIykL/2tbIqDH5EAXtce+ZdmIruQeCT9Rnwl7uTok3eJ52JYhyC
         dQ0cWbyrvbllNHpCCAle4SEiMDJX2j8omsyym7vR1uRDdbLFumnVzSSO8MuDZA/pj3pt
         dvaoztcyNl0qCl+w+T/kX2AYTO/Czi9oTFC0PnsGHOLyRAX1UM0zFiomdheDmDNghs6k
         Ajcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180259; x=1691772259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbxPqSfNkaTpXwVO118i2YUaZSkv3KJ+5v+5UNfNCTQ=;
        b=RyB67D2JJUfMe+6QLwwAN+96DSXTd8qezdQ3lw6ImHFnc7VOxVCPHOU2ukdXyHXqRF
         kURNh18dlzy3o6EHCC8FOmRKvcJAEED45vD9eTN0ac7tM2RPv6K0JxybxOaRvShLjTiR
         M/WjMaksdDK+Jke3RZpvtC4dR9CHAukxy1bZtS+7191KfLgcCCvLkxFJTVUE4It+/ubE
         xjhxhK9drpw8t1WcEGHjtZmWBBEV8a05UQ9S8KQ10176qlTjvEPWUxmPbmuOprFm8tI7
         +GxNDxIXsd+Jdku9a4A1KSrXOeZNZkLKBVD3lvOPdbJpO26xtXgdNsxn3vo9nXxHEYka
         +QXQ==
X-Gm-Message-State: ABy/qLbnXcRKkTRcAVb3aHm8N66YzLmP8ve3QwSQlyq1nl2XbRvfVvJV
        xtbyux26dkx5NErcX9aqSYRFMjLiPrBJSdAznNqdaQ==
X-Google-Smtp-Source: APBJJlHW5ELM0pVmhkVySNe/oWLgGFdXN1trzB6EgU6F2XR2fgYoHFW3NGVvPu+WJ6DlFE4N3oH7fg==
X-Received: by 2002:a05:622a:249:b0:3f3:669f:472c with SMTP id c9-20020a05622a024900b003f3669f472cmr2688656qtx.32.1689180258849;
        Wed, 12 Jul 2023 09:44:18 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z4-20020ac87f84000000b00403a2e88d01sm2388646qtj.40.2023.07.12.09.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:44:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: set_page_extent_mapped after read_folio in btrfs_cont_expand
Date:   Wed, 12 Jul 2023 12:44:12 -0400
Message-ID: <f6704eb17e95f3f23a49ec7e4807f4fa45192965.1689180044.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While trying to get the subpage blocksize tests running, I hit the
following panic on generic/476

assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpage.c:229
------------[ cut here ]------------
kernel BUG at fs/btrfs/subpage.c:229!
Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
CPU: 1 PID: 1453 Comm: fsstress Not tainted 6.4.0-rc7+ #12
Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20230301gitf80f052277c8-26.fc38 03/01/2023
pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : btrfs_subpage_assert+0xbc/0xf0
lr : btrfs_subpage_assert+0xbc/0xf0
Call trace:
 btrfs_subpage_assert+0xbc/0xf0
 btrfs_subpage_clear_checked+0x38/0xc0
 btrfs_page_clear_checked+0x48/0x98
 btrfs_truncate_block+0x5d0/0x6a8
 btrfs_cont_expand+0x5c/0x528
 btrfs_write_check.isra.0+0xf8/0x150
 btrfs_buffered_write+0xb4/0x760
 btrfs_do_write_iter+0x2f8/0x4b0
 btrfs_file_write_iter+0x1c/0x30
 do_iter_readv_writev+0xc8/0x158
 do_iter_write+0x9c/0x210
 vfs_iter_write+0x24/0x40
 iter_file_splice_write+0x224/0x390
 direct_splice_actor+0x38/0x68
 splice_direct_to_actor+0x12c/0x260
 do_splice_direct+0x90/0xe8
 generic_copy_file_range+0x50/0x90
 vfs_copy_file_range+0x29c/0x470
 __arm64_sys_copy_file_range+0xcc/0x498
 invoke_syscall.constprop.0+0x80/0xd8
 do_el0_svc+0x6c/0x168
 el0_svc+0x50/0x1b0
 el0t_64_sync_handler+0x114/0x120
 el0t_64_sync+0x194/0x198
---[ end trace 0000000000000000 ]---

This happens because during btrfs_cont_expand we'll get a page, set it
as mapped, and if it's not Uptodate we'll read it.  However between the
read and re-locking the page we could have called release_folio() on the
page, but left the page in the file mapping.  release_folio() can clear
the page private, and thus further down we blow up when we go to modify
the subpage bits.  Fix this by putting the set_page_extent_mapped()
after the read.  This is safe because read_folio() will call
set_page_extent_mapped() before it does the read, and then if we clear
page private but leave it on the mapping we're completely safe
re-setting set_page_extent_mapped().  With this patch I can now run
generic/476 without panicing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3bde49018530..0e4e4afef133 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4863,9 +4863,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = set_page_extent_mapped(page);
-	if (ret < 0)
-		goto out_unlock;
 
 	if (!PageUptodate(page)) {
 		ret = btrfs_read_folio(NULL, page_folio(page));
@@ -4880,6 +4877,17 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out_unlock;
 		}
 	}
+
+	/*
+	 * We unlock the page after the io is completed and then re-lock it
+	 * above.  release_folio() could have come in between that and cleared
+	 * PagePrivate(), but left the page in the mapping.  Set the page mapped
+	 * here to make sure it's properly set for the subpage stuff.
+	 */
+	ret = set_page_extent_mapped(page);
+	if (ret < 0)
+		goto out_unlock;
+
 	wait_on_page_writeback(page);
 
 	lock_extent(io_tree, block_start, block_end, &cached_state);
-- 
2.41.0

