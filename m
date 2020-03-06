Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E317B710
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 07:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgCFGx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 01:53:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33210 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgCFGx3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Mar 2020 01:53:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id m5so648937pgg.0;
        Thu, 05 Mar 2020 22:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k8lKr+jkEueNL9fiDMUF+wF+sa4NlM0pOjvW8vJZPto=;
        b=cI9wU8hPNsjkX13N5xuTNuhILzY8O37rL4z49B2r3Sl2m+mTrOpiijZrJ+s1hZy9JF
         Ffh37HbRNWMdQSWID4UP9DwYCCUZvqlesBGTlCZUNcaLW+nAAXYat0ZZRPLh1vjWXOK2
         EmOuLRn0bARfNXVKwuH5TT1eSKzAvkiDVhoOXYZMnXqsKrNnw08CGnaycDboR2/D2xNa
         V1KsrJmo+2XUu6C66+gD0PLVG4IR5WviMRkJc3cv5BaERJLRT5BW+bi1Bk07knJ5dZa5
         94Co+hy/mTXKtWefGbrGYv1tk19yg/lYfDkKaY+7obsLDdCb22T/aG5LSxqOdB0nidwr
         5OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k8lKr+jkEueNL9fiDMUF+wF+sa4NlM0pOjvW8vJZPto=;
        b=uj9DtviZooPPOqOPhOzO4oFG+wDHa3FnVeyzAuZ/db5yR8yfCrcwD3dkJfZBx4WdZ3
         xIJ5JHy7pCsd15ngYdQinSFKutyXDZNHkp4gaGk+B6WLe/8hFEGqRXY89Yac0Cy3rldz
         cVDsPZzGgR9EUEcxVhnxnVkpoETzYDEivtg61nxCI3t7MhPlvVvQj+dHxI7r7Ipqr8wW
         xmZR27wG7gVmfPmw5+Wb9qgWguziDxgfQRLxGj5l6vDV/l0/jEykjsjH/JEIOsjhmHEq
         6+dwUGB+NU1mHWHLAJ4OG4RzSSERa+10cUcv8LscRNk4wZx8YMaiLTDk2n0jXKOn2bI6
         YXlg==
X-Gm-Message-State: ANhLgQ2qLNEMn91nAdV36rfaIGmCimiNeod8twk1QlB+T7MwgXLvwo6c
        FXSEHc0Dybe3wfdyvIEQXA==
X-Google-Smtp-Source: ADFU+vvgZDVNdDty/pVQK/EdyGZRM6m0eDOduutl9e91mTg0oLWSDt9J1tBnaAKE5BZ2ypVbyfltiQ==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr1943435pga.167.1583477607968;
        Thu, 05 Mar 2020 22:53:27 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee2:ecde:d483:e483:cccb:2577])
        by smtp.gmail.com with ESMTPSA id x2sm32683411pge.2.2020.03.05.22.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 22:53:27 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        frextrite@gmail.com, linux@roeck-us.net,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] fs: btrfs: block-group.c: Fix suspicious RCU usage warning
Date:   Fri,  6 Mar 2020 12:22:43 +0530
Message-Id: <20200306065243.11699-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

The space_info list is rcu protected.
Hence, it should be traversed with rcu_read_lock held.

Warning:
[   29.104591] =============================
[   29.104756] WARNING: suspicious RCU usage
[   29.105046] 5.6.0-rc4-next-20200305 #1 Not tainted
[   29.105231] -----------------------------
[   29.105401] fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 fs/btrfs/block-group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 404e050ce8ee..9cabeef66f5b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1987,6 +1987,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		btrfs_release_path(path);
 	}
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
 		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
@@ -2007,7 +2008,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 				list)
 			inc_block_group_ro(cache, 1);
 	}
-
+	rcu_read_unlock();
+		
 	btrfs_init_global_block_rsv(info);
 	ret = check_chunk_block_group_mappings(info);
 error:
-- 
2.17.1

