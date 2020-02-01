Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE214FA88
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 21:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgBAUiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 15:38:54 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35080 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgBAUiy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Feb 2020 15:38:54 -0500
Received: by mail-yw1-f67.google.com with SMTP id i190so8986755ywc.2;
        Sat, 01 Feb 2020 12:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mwTtxM/El7wYG4De6gji0Twu6r1cttjqKEr0PQZ0xW8=;
        b=r04WWOp4Q59kqnAYxZqwH3pgWYwbkAhQR3J5rGDsprSPcgWjrBUnBccZIL2GCaEEuT
         KLA/lF2L0DruvDzXuEg+w2G0aau4sP2/7RjmvbNAUD6YZkxRMqWSZ2zZZ2NIYbobP0eh
         Wk7K3t9NBYhriKTKYLi3AucTNjbWCitIPpR+qXIPbm2Vy2i69gbx1QAfrEundyKwfIaU
         O5SH3ulNtpRObo6r2t+WU6y1cnAEEGLHcvB/bf96O9Sau8mXawbQwTy0GtG+xxA+eTsk
         A6ZKoAfLRriydv+ZVLwaoJmeppII7Hp4hqJwlzbcT6tPJUYQ9tjCGBQ66F5xsYVm+XF1
         5z+Q==
X-Gm-Message-State: APjAAAUOdwnFIgGxCK9Llivf6WfolHDd1djl5T1KRIDQr3hT0bL63Bo4
        bJuhhVCrCbRnRJ0bvhKW1YA=
X-Google-Smtp-Source: APXvYqxmBbdXfk3hSJtvOtOvW9+UNuPKdHGt7J+vBGV1KpT+gP3YFfYjKbPKwbhacfIkRBhmcT6E1Q==
X-Received: by 2002:a81:8405:: with SMTP id u5mr12746575ywf.93.1580589533499;
        Sat, 01 Feb 2020 12:38:53 -0800 (PST)
Received: from localhost.localdomain (h198-137-20-41.xnet.uga.edu. [198.137.20.41])
        by smtp.gmail.com with ESMTPSA id j72sm6252708ywj.60.2020.02.01.12.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 12:38:52 -0800 (PST)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] btrfs: ref-verify: fix memory leaks
Date:   Sat,  1 Feb 2020 20:38:38 +0000
Message-Id: <20200201203838.19198-1-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_ref_tree_mod(), 'ref' and 'ra' are allocated through kzalloc() and
kmalloc(), respectively. In the following code, if an error occurs, the
execution will be redirected to 'out' or 'out_unlock' and the function will
be exited. However, on some of the paths, 'ref' and 'ra' are not
deallocated, leading to memory leaks. For example, if 'action' is
BTRFS_ADD_DELAYED_EXTENT, add_block_entry() will be invoked. If the return
value indicates an error, the execution will be redirected to 'out'. But,
'ref' is not deallocated on this path, causing a memory leak.

To fix the above issues, deallocate both 'ref' and 'ra' before exiting from
the function when an error is encountered.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/btrfs/ref-verify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index b57f3618e58e..454a1015d026 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -744,6 +744,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 		 */
 		be = add_block_entry(fs_info, bytenr, num_bytes, ref_root);
 		if (IS_ERR(be)) {
+			kfree(ref);
 			kfree(ra);
 			ret = PTR_ERR(be);
 			goto out;
@@ -757,6 +758,8 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			"re-allocated a block that still has references to it!");
 			dump_block_entry(fs_info, be);
 			dump_ref_action(fs_info, ra);
+			kfree(ref);
+			kfree(ra);
 			goto out_unlock;
 		}
 
@@ -819,6 +822,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 "dropping a ref for a existing root that doesn't have a ref on the block");
 				dump_block_entry(fs_info, be);
 				dump_ref_action(fs_info, ra);
+				kfree(ref);
 				kfree(ra);
 				goto out_unlock;
 			}
@@ -834,6 +838,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 "attempting to add another ref for an existing ref on a tree block");
 			dump_block_entry(fs_info, be);
 			dump_ref_action(fs_info, ra);
+			kfree(ref);
 			kfree(ra);
 			goto out_unlock;
 		}
-- 
2.17.1

