Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EFE1CBDCD
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 07:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgEIFfI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 01:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFfI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 May 2020 01:35:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E324C061A0C;
        Fri,  8 May 2020 22:35:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so1668452plt.5;
        Fri, 08 May 2020 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oVPqgvFYpDmjHxtwZexyhCeh0mu3Dntz+mgij6nVzYY=;
        b=U8HaRP/fXpygxd+qh4WQ0oKNQCpdght8A3mk6BcJtbFiqDIaMMSunNcdSqGyfRksSj
         9ippqZvDQkxJsJvHR2sDIKSKa9ZX7M78w+kFV+ouHXfTC/IummTNHD5uQrQORIwNJyz1
         DWf6eeXlBuMurn9zDL3DcY3sw8hMfcvX+hAGVZ3u8Dsuf4HgXug6wcYsR6VkCiylivfn
         +ax3ZJwvoTs817VAjPX5cLWMQiJ5aVvGK46V8Y/fbYLI6COm96wIRF24iIrgML7GeJRr
         JLtzDGlnFe3jdU6URCSeATAheRgEcUW9Su3s+b0aP9Nt/6IYBnt44hsgNDcs96jz8Y+a
         jAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oVPqgvFYpDmjHxtwZexyhCeh0mu3Dntz+mgij6nVzYY=;
        b=E5LKH4Eqeo2HSNu6/zMyJp55ZXnEjWFfbHRdVMS0tsKsosdZQ33WUshEjoWJMo9pjV
         Q0c5UNepFTwk0nfiZH7X3pUT5rPY1vOQYEwVOiDv668wnstMSU5k3A/G6RMG2C6OLJTH
         Z1YbTSCWdaC7M4HGSI3A2kTvIVyY53mG/aYdVwiIbUdNlB1Oc1J0Q1C/60ZEuHO0EMfU
         2oQNblLkKXqjJu9ZJApYIPf7zSN8ZhGFzCbvGkwWx1opclXE2iZN8j/lbXma7AUo5c5G
         oRVmsPWNEyw4ZptdU39oObQwm+gSaikclJj1HAZgTcuVdhrd4ZAEp13Na6hMjil3dZsw
         kgbQ==
X-Gm-Message-State: AGi0PuZ7QjhE3zaajO6Q0t+79tNWVZfmC3ifNYSdq2q08Ex2FMKU2eCu
        NgZky5cgRuMQDT8fvH5Yc/Y=
X-Google-Smtp-Source: APiQypKux7Upd6mNxAE6TgYDmQtn6jZce4bi7lkCCj2wMxp51AS6zMkwHH3IJ9LmX39rSMrXLx4+BQ==
X-Received: by 2002:a17:90a:8b:: with SMTP id a11mr9393946pja.163.1589002507599;
        Fri, 08 May 2020 22:35:07 -0700 (PDT)
Received: from localhost.localdomain ([223.72.62.216])
        by smtp.gmail.com with ESMTPSA id w23sm2707446pge.92.2020.05.08.22.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:35:06 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 4/4] fs: btrfs: fix a data race in btrfs_block_rsv_release()
Date:   Sat,  9 May 2020 13:34:31 +0800
Message-Id: <20200509053431.3860-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The functions btrfs_block_rsv_release() and
btrfs_update_delayed_refs_rsv() are concurrently executed at runtime in
the following call contexts:

Thread 1:
  btrfs_file_write_iter()
    btrfs_buffered_write()
      btrfs_delalloc_release_extents()
        btrfs_inode_rsv_release()
          __btrfs_block_rsv_release()

Thread 2:
  finish_ordered_fn()
    btrfs_finish_ordered_io()
      insert_reserved_file_extent()
        __btrfs_drop_extents()
          btrfs_free_extent()
            btrfs_add_delayed_data_ref()
              btrfs_update_delayed_refs_rsv()

In __btrfs_block_rsv_release():
  else if (... && !delayed_rsv->full)

In btrfs_update_delayed_refs_rsv():
  spin_lock(&delayed_rsv->lock);
  delayed_rsv->size += num_bytes;
  delayed_rsv->full = 0;
  spin_unlock(&delayed_rsv->lock);

Thus a data race for delayed_rsv->full can occur.
This race was found and actually reproduced by our conccurency fuzzer.

To fix this race, the spinlock delayed_rsv->lock is used to
protect the access to delayed_rsv->full in btrfs_block_rsv_release().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/btrfs/block-rsv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 27efec8f7c5b..89c53a7137b4 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -277,6 +277,11 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
 	struct btrfs_block_rsv *target = NULL;
+	unsigned short full = 0;
+
+	spin_lock(&delayed_rsv->lock);
+	full = delayed_rsv->full;
+	spin_unlock(&delayed_rsv->lock);
 
 	/*
 	 * If we are the delayed_rsv then push to the global rsv, otherwise dump
@@ -284,7 +289,7 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 	 */
 	if (block_rsv == delayed_rsv)
 		target = global_rsv;
-	else if (block_rsv != global_rsv && !delayed_rsv->full)
+	else if (block_rsv != global_rsv && !full)
 		target = delayed_rsv;
 
 	if (target && block_rsv->space_info != target->space_info)
-- 
2.17.1

