Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3853C8B3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 20:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhGNSuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbhGNSua (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E30C061765
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 11:47:38 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d15so2577635qte.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNekpPuEULpCMOwivjqUjmNvC4JFfFA0/dEwN2gvg5g=;
        b=MoDWOvkbNfmQlUXE94ddpWnR8t5gaHGSJ4yjF9hcFzocJuEMNyOZq0aFvxFDtDKwQy
         JJlphut81Z+PPnQONtSnYMFucGSF+zX9g2ecRjox/b5J8iOfTxCPI3kLisFrDnxpu+Zv
         0aIORgxoKEB/NX5mVcFHFmXG8gS00we+YAcqhpKk0Dc0yxCGkb31gqbh+LxS86RCf/2A
         1tobbeTjwZ22Ca8Z30PXaFFieWGlJ7AAQnZkQSyKqZX9ARa7ywKNticn3l4Vk/O3BOYK
         Jqw8NKCggtXwtHrNteh4kgvy+HsvNZp1nFibKdoGEJK4P+ONr8lTg2YhDx3H4zyvMCTA
         MPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNekpPuEULpCMOwivjqUjmNvC4JFfFA0/dEwN2gvg5g=;
        b=g0NHdjGzUGAkZ6izj7Hk7AVOwyjI245CnJt0MdTLuNB8w+EA1eMjfdUrf6/C/sboYM
         PacEDmpC6f/QfLh9fYnJBuceABHBhf10EtsUkC8WXYB+vYP2Md1rGw7ilPONpsDV9hHA
         2n0+ipVvv1sgJZAIyjLRT1lE83iT+lT4pg09BkfkPVSvhkXCFWtI9rx6NbBVPzv/n+LK
         XagbISSf2ORjggQrGGsx7Twglcclvn4PfOrXgvsoQZAPLTl/lpIhNyUZ9p3akdXvS9oA
         AhFjkEXLrxKoL81bY8z1i8cHfIp+mEkiynvVLnZSB8TXznBv5slgmg0MZKP2ftKFWkUo
         X3xg==
X-Gm-Message-State: AOAM5311lg0SqKevsCX/2+MMzIRddKDXMb2kfTtGoOf+7WE0EWUXT9fb
        lVdS5OK251+BF6lPAJqs2QGjcF8mNGFdxSvN
X-Google-Smtp-Source: ABdhPJydN+M0zPH+sop8KzTKtnIAH7/w63hbq9eWYwMhRgunXSjejkotX09tiVc2xvwuPFSi8j4uRw==
X-Received: by 2002:ac8:5803:: with SMTP id g3mr10576731qtg.3.1626288457181;
        Wed, 14 Jul 2021 11:47:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q184sm1389219qkd.35.2021.07.14.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 7/9] btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
Date:   Wed, 14 Jul 2021 14:47:23 -0400
Message-Id: <8b03a72d1b50931637b25daad29fb470fb08dde8.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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

