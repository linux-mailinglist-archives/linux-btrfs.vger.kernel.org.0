Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB18320FC3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgF3SxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgF3SxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 14:53:06 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92976C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 11:53:06 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t7so9754078qvl.8
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAkqAgaec40wQDymKAsrhJ8l3r+HaQ4LZntBhnj6trU=;
        b=DmXNLN7VYJNa8ri+n/TGLTnXctGMCIrkfaZOtqmqwItAyV21tmCiGJo2kYBdC/b9SJ
         Fb5Wl51N8gTakfAxgqDgPppJEtTUb2MHf25ckxIZyfU0iqQ3bqktNKxDpxHQoA/b0Jd/
         MZ0JbvhPp0Vv/5RUiBPlve3gFJ3qRUdd3F1vKuIUyXSjdvKNn52Gzge8dBNhbzWDH+f0
         cICXesq3AZ1sHAc6Z1E0POdZ95mvb9/mnvPjF3yLUn77l5Z7eUP9noLyW34IvQIOEC/Y
         v0UMNA0z5YoKX30TpTNgHTAk4dEAUMrSWBHLSb3TGhMP6j6MgFKHpph5cURM4/Ix+bgN
         INOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAkqAgaec40wQDymKAsrhJ8l3r+HaQ4LZntBhnj6trU=;
        b=oDKIMjavLFFq6u7WQOtaRKwR5RHaIiSaLCUOBuKqa+F9/AIufthLSFKvTShBMnU6OV
         hn/7Wc17ZAYMNuVnu3Ryl9WOBJQoyvszYiVExfZL0kRw3JwsgU2UI741I16GT7fUpBxd
         W2x/2r7Fr0WbWNSHDnyzzkEM15c9rM7DPUc8I7Np2LiNBN6tFvxT4wlFGmM190OJlQKE
         o7UZh8n/Iolr0mLFnDE/cvkco+dFgWiP8EyPf46ngZLniQPVD78z5NDLUhrSlFOsmQET
         jZAPALzHDiC6r/AfdGWSs1m57H6XdwNBLa6k2hotIuby+hgxOYHwZJYSw1L74G/pmcP4
         fDYA==
X-Gm-Message-State: AOAM5324e7yi+51fDSOisENTZydP2+YuYnp/MD1efZqm/nl2aktDisn8
        Ge2A/UqafyEtXceeUtvJH2eWoQOxG7W1yg==
X-Google-Smtp-Source: ABdhPJwLQ1wk3BDAebmELUuXsScrbYWIfAK0xVnDxyGRPfB6e/gINAMLAcngfLoQTSkJP1nVyF1n0A==
X-Received: by 2002:a05:6214:88e:: with SMTP id cz14mr21432984qvb.72.1593543185316;
        Tue, 30 Jun 2020 11:53:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w4sm4076880qtc.5.2020.06.30.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:53:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] btrfs: set tree_root->node = NULL on error
Date:   Tue, 30 Jun 2020 14:53:02 -0400
Message-Id: <20200630185302.3362-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Eric reported an issue where mounting -o recovery with a fuzzed fs
resulted in a kernel panic.  This is because we tried to free the tree
node, except it was an error from the read.  Fix this by properly
resetting the tree_root->node == NULL in this case.  The panic was the
following

BTRFS warning (device loop0): failed to read tree root
BUG: kernel NULL pointer dereference, address: 000000000000001f
RIP: 0010:free_extent_buffer+0xe/0x90 [btrfs]
Call Trace:
 free_root_extent_buffers.part.0+0x11/0x30 [btrfs]
 free_root_pointers+0x1a/0xa2 [btrfs]
 open_ctree+0x1776/0x18a5 [btrfs]
 btrfs_mount_root.cold+0x13/0xfa [btrfs]
 ? selinux_fs_context_parse_param+0x37/0x80
 legacy_get_tree+0x27/0x40
 vfs_get_tree+0x25/0xb0
 fc_mount+0xe/0x30
 vfs_kern_mount.part.0+0x71/0x90
 btrfs_mount+0x147/0x3e0 [btrfs]
 ? cred_has_capability+0x7c/0x120
 ? legacy_get_tree+0x27/0x40
 legacy_get_tree+0x27/0x40
 vfs_get_tree+0x25/0xb0
 do_mount+0x735/0xa40
 __x64_sys_mount+0x8e/0xd0
 do_syscall_64+0x4d/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f5302f851be

Fixes: b8522a1e5f42 ("btrfs: Factor out tree roots initialization during mount")
Reported-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7c07578866f3..c27022f13150 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2592,10 +2592,12 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		    !extent_buffer_uptodate(tree_root->node)) {
 			handle_error = true;
 
-			if (IS_ERR(tree_root->node))
+			if (IS_ERR(tree_root->node)) {
 				ret = PTR_ERR(tree_root->node);
-			else if (!extent_buffer_uptodate(tree_root->node))
+				tree_root->node = NULL;
+			} else if (!extent_buffer_uptodate(tree_root->node)) {
 				ret = -EUCLEAN;
+			}
 
 			btrfs_warn(fs_info, "failed to read tree root");
 			continue;
-- 
2.24.1

