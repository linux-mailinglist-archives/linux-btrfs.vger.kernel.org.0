Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58A2769A85
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGaPNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 11:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGaPNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 11:13:06 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48B10E3
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 08:13:05 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a4875e65a3so3155197b6e.2
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690816385; x=1691421185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeXSqYxypSWikw9NQsTxS4mleceHwF8n66KSMALTfrw=;
        b=E/FjdZQODUApcx1XKeBAtHf2VzrBj7IoDk/uX27CDeHaeBygvDndJcnJy6GkS9PNTo
         J4NDwLE2cEch1c8rZFzXzuXHaJ1nuKPKXKMl3u6eZhxpZpFwi2+sgFBsWQ3rV2dGrOlu
         ipmq5N8uCe8j48s2lNYeCFoXauJxZX1xvFNpTTE7tfsbstn98ErHrbwYh8idrv3T8TgU
         4Z9wi1gddnGBSZc+SDsf53G7ZMw2dnMrKoG1mG5TaW5nzviaWdiLSTEOpUPJlBDVBRcy
         SsrTOxIChG+3WEEOOq2k5aWCwGPj8+V3W8shgCZ+7WaNzi/esSCmZdIM74TkUxV0az6b
         D/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690816385; x=1691421185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeXSqYxypSWikw9NQsTxS4mleceHwF8n66KSMALTfrw=;
        b=ijl4Q/qUw8pnT/bKibV14YDqf1em/EjKxOsH34GUglBbs+dX3gMeGS8tM0lB/oc648
         MqjeauFzgPLYyUt9V+23dToOz9PCiEQtQJgE1zxWT9ZQmgYZyJllNsIF1lk30CTeXrBz
         EbfjIl+Ejvy4ZPYg/mdvsejwdV5++/yjCUiOlG6fucoNJF1vU1/h2FQpes58294wRjuR
         5rmnoY7lGLpL1cQ2rru7j4jn+OmC62B75j26cP+GX3qRM75+nihn52orxGELnF8Ald42
         0ah9KoH8UBPxmrIXL/durDLByzsKQ/g5+CyB3kJmrg89gxucz7biYXKr9DaurL0waFhx
         culw==
X-Gm-Message-State: ABy/qLbK+1IUbH6cyVBBAaR310RmmFb5ACvr1pdlOkkDVrAQLknVpVSF
        HofXdNM4ziCMVqHpjYgataYUDclwm6s2J0eqBvMuWQ==
X-Google-Smtp-Source: APBJJlGoJYJ3sJK3hvrm0kR4ibXH3NLo1jbHFq8ggh4AE2UkJGmZhBoIPUNPJc//oiMurhkIZbkBZg==
X-Received: by 2002:a05:6358:e499:b0:139:d226:b361 with SMTP id by25-20020a056358e49900b00139d226b361mr244854rwb.31.1690816384907;
        Mon, 31 Jul 2023 08:13:04 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a135000b00403ff38d855sm3605967qtk.4.2023.07.31.08.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 08:13:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: set_page_extent_mapped after read_folio in relocate_one_page
Date:   Mon, 31 Jul 2023 11:13:00 -0400
Message-ID: <447c5374eeee4ad7abb5320602be92bf5748c04c.1690816368.git.josef@toxicpanda.com>
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

One of the CI runs triggered the following panic

assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpage.c:229
------------[ cut here ]------------
kernel BUG at fs/btrfs/subpage.c:229!
Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
CPU: 0 PID: 923660 Comm: btrfs Not tainted 6.5.0-rc3+ #1
pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : btrfs_subpage_assert+0xbc/0xf0
lr : btrfs_subpage_assert+0xbc/0xf0
sp : ffff800093213720
x29: ffff800093213720 x28: ffff8000932138b4 x27: 000000000c280000
x26: 00000001b5d00000 x25: 000000000c281000 x24: 000000000c281fff
x23: 0000000000001000 x22: 0000000000000000 x21: ffffff42b95bf880
x20: ffff42b9528e0000 x19: 0000000000001000 x18: ffffffffffffffff
x17: 667274622f736620 x16: 6e69202c65746176 x15: 0000000000000028
x14: 0000000000000003 x13: 00000000002672d7 x12: 0000000000000000
x11: ffffcd3f0ccd9204 x10: ffffcd3f0554ae50 x9 : ffffcd3f0379528c
x8 : ffff800093213428 x7 : 0000000000000000 x6 : ffffcd3f091771e8
x5 : ffff42b97f333948 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff42b9556cde80 x0 : 000000000000004f
Call trace:
 btrfs_subpage_assert+0xbc/0xf0
 btrfs_subpage_set_dirty+0x38/0xa0
 btrfs_page_set_dirty+0x58/0x88
 relocate_one_page+0x204/0x5f0
 relocate_file_extent_cluster+0x11c/0x180
 relocate_data_extent+0xd0/0xf8
 relocate_block_group+0x3d0/0x4e8
 btrfs_relocate_block_group+0x2d8/0x490
 btrfs_relocate_chunk+0x54/0x1a8
 btrfs_balance+0x7f4/0x1150
 btrfs_ioctl+0x10f0/0x20b8
 __arm64_sys_ioctl+0x120/0x11d8
 invoke_syscall.constprop.0+0x80/0xd8
 do_el0_svc+0x6c/0x158
 el0_svc+0x50/0x1b0
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x194/0x198
Code: 91098021 b0007fa0 91346000 97e9c6d2 (d4210000)

This is the same problem outlined in "btrfs: set_page_extent_mapped
after read_folio in btrfs_cont_expand", and the fix is the same.  I
originally looked for the same pattern elsewhere in our code, but
mistakenly skipped over this code because I saw the page cache readahead
before we set_page_extent_mapped, not realizing that this was only in
the !page case, that we can still end up with a !uptodate page and then
do the btrfs_read_folio further down.

The fix here is the same as the above mentioned patch, move the
set_page_extent_mapped call to after the btrfs_read_folio() block to
make sure that we have the subpage blocksize stuff setup properly before
using the page.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9db2e6fa2cb2..e01819f8de5b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2977,9 +2977,6 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 		if (!page)
 			return -ENOMEM;
 	}
-	ret = set_page_extent_mapped(page);
-	if (ret < 0)
-		goto release_page;
 
 	if (PageReadahead(page))
 		page_cache_async_readahead(inode->i_mapping, ra, NULL,
@@ -2995,6 +2992,15 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 		}
 	}
 
+	/*
+	 * We could have lost page private when we dropped the lock to read the
+	 * page above, make sure we set_page_extent_mapped here so we have any
+	 * of the subpage blocksize stuff we need in place.
+	 */
+	ret = set_page_extent_mapped(page);
+	if (ret < 0)
+		goto release_page;
+
 	page_start = page_offset(page);
 	page_end = page_start + PAGE_SIZE - 1;
 
-- 
2.41.0

