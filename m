Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78772462DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFNPdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 11:33:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33032 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNPdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 11:33:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so1182125plo.0;
        Fri, 14 Jun 2019 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=94FnoFCGinxKIVI488xScEWQQ1X2y9NyRvuM1e8VR9g=;
        b=JHykRz/yv1ZeAaVIebzGDc1gORj9rH2a8l7aAyECo3Nx+UvrJuoAth4rLNJPXxdXb0
         nOhWWYPz25XqLYUrf/1jAsZDix8XVdiC58vYN8xosL3dQPjyq7TD9IlMZV33gxAgR7zK
         oZcB+ZZMtQhLhotyD4rIkNl29/GszIKMwfLK/xD5w+CV/Q0SIGU4ZG1l5UcYv97MiQ0B
         tn2zH0YrjCMd0ltmU/JHKX2yKRupyUKSIjb0kNoNzg4Nb1aXrRSiLUk1wuEA7Azh5bxT
         MlgMULdIqZ5MXqNpaq6IK6owfyJD1lUeeBhR/kfljnQbwJdDFAjfx6zWnM39xfICnv4z
         TEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=94FnoFCGinxKIVI488xScEWQQ1X2y9NyRvuM1e8VR9g=;
        b=pzV5SnZrB/HQF7/bH3SZ0yILUX/rE3tpK1oIIsTVlvzZKmxI+UzqusBewrGOwGofe4
         3LKLQ5jpLqYrP326/q6iJmc5EkRmNsVGWvmdMKqjFQ6J/P9UWCZM47HzrwSrEZKUMlSN
         Tt5m8CnaXcUSLUGZZtgdnYahJUCIocqXSJV8h+K7QpnyqsL6aMX85EOrX4DKBp7qDRC1
         SzzGI5ruHHccOVM5zI7lkc2p56zbpaHuMnhDbkvu+wF5XZYDx2uN/ERiPb+Y/O4QX5Jv
         CU8sGFJ9RqIA9IT5YOSkNSvGk4p0y1TAjyoBGE2kzwYG+0z3EfjY/d9rbCYBRiu6ExGl
         qJZw==
X-Gm-Message-State: APjAAAVttYur9Lh6R7jKoLct1/eTZ4crvxeqlQI+9T94mx3FaegqqIj4
        p951PBj2x+iZw0O88PFON2o=
X-Google-Smtp-Source: APXvYqwfqCfExW0GEUt9P4RalfBCPWeXn5IPAkbmIRSBmOW9d6Y+luQHM0Nl7xy2v0c4pe7a2BdKhw==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3mr70465260plr.74.1560526382836;
        Fri, 14 Jun 2019 08:33:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:b330])
        by smtp.gmail.com with ESMTPSA id l1sm3206498pgj.67.2019.06.14.08.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 08:33:02 -0700 (PDT)
Date:   Fri, 14 Jun 2019 08:32:58 -0700
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 8/8] Btrfs: extent_write_locked_range() should attach
 inode->i_wb
Message-ID: <20190614153258.GC538958@devbig004.ftw2.facebook.com>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-9-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-9-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

extent_write_locked_range() is used when we're falling back to buffered
IO from inside of compression.  It allocates its own wbc and should
associate it with the inode's i_wb to make sure the IO goes down from
the correct cgroup.

Also, export the needed symbols from fs-writeback.c.

Signed-off-by: Chris Mason <clm@fb.com>
Build-Breakage-Reported-by: kbuild test robot <lkp@intel.com>
---
v2: Module build fix.

 fs/btrfs/extent_io.c |   10 ++++++----
 fs/fs-writeback.c    |    3 +++
 2 files changed, 9 insertions(+), 4 deletions(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4178,6 +4178,7 @@ int extent_write_locked_range(struct ino
 		.no_wbc_acct	= 1,
 	};
 
+	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (start <= end) {
 		page = find_get_page(mapping, start >> PAGE_SHIFT);
 		if (clear_page_dirty_for_io(page))
@@ -4192,11 +4193,12 @@ int extent_write_locked_range(struct ino
 	}
 
 	ASSERT(ret <= 0);
-	if (ret < 0) {
+	if (ret == 0)
+		ret = flush_write_bio(&epd);
+	else
 		end_write_bio(&epd, ret);
-		return ret;
-	}
-	ret = flush_write_bio(&epd);
+
+	wbc_detach_inode(&wbc_writepages);
 	return ret;
 }
 
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -270,6 +270,7 @@ void __inode_attach_wb(struct inode *ino
 	if (unlikely(cmpxchg(&inode->i_wb, NULL, wb)))
 		wb_put(wb);
 }
+EXPORT_SYMBOL_GPL(__inode_attach_wb);
 
 /**
  * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and lock it
@@ -582,6 +583,7 @@ void wbc_attach_and_unlock_inode(struct
 	if (unlikely(wb_dying(wbc->wb)))
 		inode_switch_wbs(inode, wbc->wb_id);
 }
+EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
 
 /**
  * wbc_detach_inode - disassociate wbc from inode and perform foreign detection
@@ -701,6 +703,7 @@ void wbc_detach_inode(struct writeback_c
 	wb_put(wbc->wb);
 	wbc->wb = NULL;
 }
+EXPORT_SYMBOL_GPL(wbc_detach_inode);
 
 /**
  * wbc_account_io - account IO issued during writeback
