Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4442FFA8
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Oct 2021 03:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbhJPBnQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 21:43:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33308 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhJPBnQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 21:43:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 11C861FD4C;
        Sat, 16 Oct 2021 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634348468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=B7dMh03E9TPW/Qa4s2yiShLfdxbV+3z8lA7kdGy9r/s=;
        b=tVooBDNxKkoljBEaEBqw2bxyEqV2BXZgjFI9qcLUI46pr4HJaXUO0qxpJcCzdjyKje5xFX
        kmKFK1XaHbZEooja9Mokz/pDgt4BcihBTGQdZDdQRkzJdy+3VINiQre/PpqAokt8imkwp7
        p1y617AOEgCcYTE6sOkz1hrxH6+Km7g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 304931345A;
        Sat, 16 Oct 2021 01:41:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GeMLO7ItamGRNQAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 16 Oct 2021 01:41:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     grub-devel@gnu.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fs/btrfs: Make extent item iteration to handle gaps
Date:   Sat, 16 Oct 2021 09:40:49 +0800
Message-Id: <20211016014049.201556-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Grub btrfs implementation can't handle two very basic btrfs file
layouts:

1. Mixed inline/regualr extents
   # mkfs.btrfs -f test.img
   # mount test.img /mnt/btrfs
   # xfs_io -f -c "pwrite 0 1k" -c "sync" -c "falloc 0 4k" \
	       -c "pwrite 4k 4k" /mnt/btrfs/file
   # umount /mnt/btrfs
   # ./grub-fstest ./grub-fstest --debug=btrfs ~/test.img hex "/file"

   Such mixed inline/regular extents case is not recommended layout,
   but all existing tools and kernel can handle it without problem

2. NO_HOLES feature
   # mkfs.btrfs -f test.img -O no_holes
   # mount test.img /mnt/btrfs
   # xfs_io -f -c "pwrite 0 4k" -c "pwrite 8k 4k" /mnt/btrfs/file
   # umount /mnt/btrfs
   # ./grub-fstest ./grub-fstest --debug=btrfs ~/test.img hex "/file"

   NO_HOLES feature is going to be the default mkfs feature in the incoming
   v5.15 release, and kernel has support for it since v4.0.

[CAUSE]
The way GRUB btrfs code iterates through file extents relies on no gap
between extents.

If any gap is hit, then grub btrfs will error out, without any proper
reason to help debug the bug.

This is a bad assumption, since a long long time ago btrfs has a new
feature called NO_HOLES to allow btrfs to skip the padding hole extent
to reduce metadata usage.

The NO_HOLES feature is already stable since kernel v4.0 and is going to
be the default mkfs feature in the incoming v5.15 btrfs-progs release.

[FIX]
When there is a extent gap, instead of error out, just try next item.

This is still not ideal, as kernel/progs/U-boot all do the iteration
item by item, not relying on the file offset continuity.

But it will be way more time consuming to correct the whole behavior
than starting from scratch to build a proper designed btrfs module for GRUB.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 grub-core/fs/btrfs.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/grub-core/fs/btrfs.c b/grub-core/fs/btrfs.c
index 63203034dfc6..4fbcbec7524a 100644
--- a/grub-core/fs/btrfs.c
+++ b/grub-core/fs/btrfs.c
@@ -1443,6 +1443,7 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
       grub_size_t csize;
       grub_err_t err;
       grub_off_t extoff;
+      struct grub_btrfs_leaf_descriptor desc;
       if (!data->extent || data->extstart > pos || data->extino != ino
 	  || data->exttree != tree || data->extend <= pos)
 	{
@@ -1455,7 +1456,7 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
 	  key_in.type = GRUB_BTRFS_ITEM_TYPE_EXTENT_ITEM;
 	  key_in.offset = grub_cpu_to_le64 (pos);
 	  err = lower_bound (data, &key_in, &key_out, tree,
-			     &elemaddr, &elemsize, NULL, 0);
+			     &elemaddr, &elemsize, &desc, 0);
 	  if (err)
 	    return -1;
 	  if (key_out.object_id != ino
@@ -1494,10 +1495,36 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
 			PRIxGRUB_UINT64_T "\n",
 			grub_le_to_cpu64 (key_out.offset),
 			grub_le_to_cpu64 (data->extent->size));
+	  /*
+	   * The way of extent item iteration is pretty bad, it completely
+	   * requires all extents are contiguous, which is not ensured.
+	   *
+	   * Features like NO_HOLE and mixed inline/regular extents can cause
+	   * gaps between file extent items.
+	   *
+	   * The correct way is to follow kernel/U-boot to iterate item by
+	   * item, without any assumption on the file offset continuity.
+	   *
+	   * Here we just manually skip to next item and re-do the verification.
+	   *
+	   * TODO: Rework the whole extent item iteration code, if not the
+	   * whole btrfs implementation.
+	   */
 	  if (data->extend <= pos)
 	    {
-	      grub_error (GRUB_ERR_BAD_FS, "extent not found");
-	      return -1;
+	      err = next(data, &desc, &elemaddr, &elemsize, &key_out);
+	      if (err < 0)
+		return -1;
+	      /* No next item for the inode, we hit the end */
+	      if (err == 0 || key_out.object_id != ino ||
+		  key_out.type != GRUB_BTRFS_ITEM_TYPE_EXTENT_ITEM)
+		      return pos - pos0;
+
+	      csize = grub_le_to_cpu64(key_out.offset) - pos;
+	      buf += csize;
+	      pos += csize;
+	      len -= csize;
+	      continue;
 	    }
 	}
       csize = data->extend - pos;
-- 
2.33.0

