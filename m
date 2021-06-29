Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CFF3B73AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhF2OCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhF2OCF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 10:02:05 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A48C0617A8
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 06:59:37 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p7so7903341qvn.5
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PQ/W8mpYAbUtGA5QrU6gmz/RrpmvrTciMU8aA+nLdpU=;
        b=V7+aUAgY+oMMSbxoBzWixoV+m/l2YkgWljTEkP0AFXD2HRwtDfALfWKL2Lzxj0opl1
         M6/qdUXArRHv++u2EbKRbLhy1Ibn1F8vz+fHdGselXl0ZPqxFihatyYvPkfOtxa3pPX0
         JoK+w02i5ddPAiXZxMQY8v/eNhyFWl4bYSv9a/SkcMG0MvJvUjMdk+bl+pk8wDFyT5Rj
         BCZsCaQ8QJxvXE9WPlaZB0G+IeEb4wvF5lpIvji80zBuIZ3Eleij3WioKoZ6Pq1FVDWo
         LTba/mlg50r7sOo2UOVSI1EqZpSsrig3tNjrOM2cHjDh5Z2btAZq30cRUV60XxmhDEOc
         4InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQ/W8mpYAbUtGA5QrU6gmz/RrpmvrTciMU8aA+nLdpU=;
        b=KD9lbGK3PwIqeM5WK4Cj8cA8cXQwhJHiLy20TXYFrzHhF4lRnr9iQ7V022rfqZlV1e
         jb9yCVL9qeXiR1eqnejsHZehjSoke/7JzUprB3OCOUU0Ak8MWFUOsSnyjeBh9mDjO9E7
         SBRE9GnIFrXkQ7XtNst33Xa47QGtdOOzwgXTUzLp5593dHemJeywM5ZYFgPxB+myIkms
         7MuyNjaUcuh/q5yJ6+aiBLN3cIvwt8StZTFomIlgB+th0wsfHm0Uz9potKGqvdOuzEWG
         r+7Z0Z01dRRl7hT5/bkWFVH6zz5fHNIjXt8UtTSYpfJOTSFwVhmFq9rGgwYJQ4VhAR7L
         KDYQ==
X-Gm-Message-State: AOAM532aWFna3ey0EdJbY/PLAe/2ullWDIq8In+qzlI5sV2AZxFQwqu5
        l79kOXKRBe7q8tdMwc9AfifenkW3prWU+w==
X-Google-Smtp-Source: ABdhPJxDZTjM3UU2d7hw2VVyKXAcF6NfwZz2NeMmy35j4QnL4rs//Om4bbhitauYLEK9SQFUdur13w==
X-Received: by 2002:ad4:580a:: with SMTP id dd10mr5823010qvb.17.1624975175886;
        Tue, 29 Jun 2021 06:59:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o123sm12109369qkd.6.2021.06.29.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:59:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/8] btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
Date:   Tue, 29 Jun 2021 09:59:22 -0400
Message-Id: <2acb56dd851d31d7b5547099821f0cbf6dfb5d29.1624974951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624974951.git.josef@toxicpanda.com>
References: <cover.1624974951.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sync_inode() has some holes that can cause problems if we're under heavy
ENOSPC pressure.  If there's writeback running on a separate thread
sync_inode() will skip writing the inode altogether.  What we really
want is to make sure writeback has been started on all the pages to make
sure we can see the ordered extents and wait on them if appropriate.
Switch to this new helper which will allow us to accomplish this and
avoid ENOSPC'ing early.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e388153c4ae4..b25c84aba743 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9713,7 +9713,7 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 			btrfs_queue_work(root->fs_info->flush_workers,
 					 &work->work);
 		} else {
-			ret = sync_inode(inode, wbc);
+			ret = filemap_fdatawrite_wbc(inode->i_mapping, wbc);
 			btrfs_add_delayed_iput(inode);
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
-- 
2.26.3

