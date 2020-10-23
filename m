Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30E52970FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373816AbgJWN60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373787AbgJWN6Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:58:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E7C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id m65so950835qte.11
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ds09wwiqKVOYJerPFF4bwYXctkBgLSGX/gOlKtxP2n0=;
        b=dLQufQqaBi9UaC6WplvJBSjte1BeQxoqDgcQjIGZAOgdi0F2K984dfLiNfcPsNn7Ha
         zWXVchA2tVbKgzC3UKm3rC8o2PJ87BL6+HoAnrvtOEF+m/noEomiklSUP/+D/2Xk9p0o
         EFrTl0lV/kSUJWfh+yA0PI4VgHQFryppxnpSmKsE9WADwyHaXk1Z/LH2M3NxreSblWZc
         1cJ+IGlroGbe6DmwI5JH4Yo3laKw1904eYcRv9xEmRtbn1JLP4BiduU98ZTSa5Xh8enB
         puLeZPSaXoffX/x/W8j/udoFxct28v548h4FLl7q76RNQTa2GxxuTgzh654/o99yQfAG
         6SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds09wwiqKVOYJerPFF4bwYXctkBgLSGX/gOlKtxP2n0=;
        b=dV+XuhWgahFV15Y4VJKxeLcdbC5y7G3xF1lw5Uzbe67Vi9F2kXUOCdqfNe+hNuwdUB
         hxIT/Q+HsvrcrOjN5tTSH22YtQ9Ucp5hbTiqNRbtCoz3JZUzqEuYUveG6tC5TArtXdkZ
         dNMOc7BJGygZurb21dfz57DHcsGFVRS0VZshsuBIVWWwdb2UdV8aAoIfG+e0rLYokxFh
         deVZm+eEFiBvj4MYkVy6c5z1ts46RJG2bsLf5I8PRlhxHXRdVNW3tv33jZVMk//bG72R
         G/GqsH8lveKMovDVGVCWH5rrnNlCEfjEGSjCmQj0r3lgn5Cr/vU/xeOYvJJsxFJzD/So
         upmA==
X-Gm-Message-State: AOAM530m3KrH5vIDa5vEVW5XT3bCbPADeE5TP5JLtzsfMaMsAdSulx7U
        EyPffiBR1RHrhVrqgLUeAzl6+ZqeR3sS6K40
X-Google-Smtp-Source: ABdhPJyO88u4lnJbrpLlP5tWpb/MXDsfZg3EK5L8L1PS8Nc9WKzNVM5A7RFPyiaNHStpRL5VWPyPQw==
X-Received: by 2002:aed:3323:: with SMTP id u32mr2259755qtd.355.1603461503339;
        Fri, 23 Oct 2020 06:58:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h7sm851439qtd.82.2020.10.23.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:58:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: load the free space cache inode extents from commit root
Date:   Fri, 23 Oct 2020 09:58:09 -0400
Message-Id: <5e4e7c68ef710c23034d6a7a180e8912d6ebbc7d.1603460665.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603460665.git.josef@toxicpanda.com>
References: <cover.1603460665.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Historically we've allowed recursive locking specifically for the free
space inode.  This is because we are only doing reads and know that it's
safe.  However we don't actually need this feature, we can get away with
reading the commit root for the extents.  In fact if we want to allow
asynchronous loading of the free space cache we have to use the commit
root, otherwise we will deadlock.

Switch to using the commit root for the file extents.  These are only
read at load time, and are replaced as soon as we start writing the
cache out to disk.  The cache is never read again, so this is
legitimate.  This matches what we do for the inode itself, as we read
that from the commit root as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1dcccd212809..53d6a66670d3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6577,7 +6577,15 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	 */
 	path->leave_spinning = 1;
 
-	path->recurse = btrfs_is_free_space_inode(inode);
+	/*
+	 * The same explanation in load_free_space_cache applies here as well,
+	 * we only read when we're loading the free space cache, and at that
+	 * point the commit_root has everything we need.
+	 */
+	if (btrfs_is_free_space_inode(inode)) {
+		path->search_commit_root = 1;
+		path->skip_locking = 1;
+	}
 
 	ret = btrfs_lookup_file_extent(NULL, root, path, objectid, start, 0);
 	if (ret < 0) {
-- 
2.26.2

