Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663424709A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 20:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhLJTGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 14:06:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56448 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbhLJTGB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 14:06:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CFBFECE2C7B
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Dec 2021 19:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AAFC341C7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Dec 2021 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639162942;
        bh=jINkYOUlWs3k2LTRbxjr0w0YSTNw4BLGtr6oKU5yEUc=;
        h=From:To:Subject:Date:From;
        b=I4voeF8CZTG97PevVQjz3tWOJldysPzB7GBnF2yvZIJkY3M81mIjxPEGhq7JHNVi2
         5aBmKieUlvnJrMvbaOiJeLtEGzd5GE2wrdenQ2ZNRC4cdeKIxQb7li1mPS7EX61AH+
         LK3WutUtoOGIBRlwzrfdmgKZ4V0BYzRNfubDC01N3PUM3Mp2wLsO5dg/bu5aEO+xlC
         p+lFWABZ0+sWnPeCBQ4Kh1Ma22Pz3kQFHUi6XjyqaN7JR4hUp3HQuz86bgfLrPA5VH
         OTCU+CzjTq44gvqFrFA2rqDon23bN0jFkithqSGITREN2a1Pi/PXzf3e7DiijwCbVI
         o+IUDTakRu+/A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix double free of anon_dev after failure to create subvolume
Date:   Fri, 10 Dec 2021 19:02:18 +0000
Message-Id: <b6c30d9569d56552e38dc6bd305c6eb6578f3782.1639162814.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When creating a subvolume, at create_subvol(), we allocate an anonymous
device and later call btrfs_get_new_fs_root(), which in turn just calls
btrfs_get_root_ref(). There we call btrfs_init_fs_root() which assigns
the anonymous device to the root, but if after that call there's an error,
when we jump to 'fail' label, we call btrfs_put_root(), which frees the
anonymous device and then returns an error that is propagated back to
create_subvol(). Than create_subvol() frees the anonymous device again.

When this happens, if the anonymous device was not reallocated after
the first time it was freed with btrfs_put_root(), we get a kernel
message like the following:

  (...)
  [13950.282466] BTRFS: error (device dm-0) in create_subvol:663: errno=-5 IO failure
  [13950.283027] ida_free called for id=65 which is not allocated.
  [13950.285974] BTRFS info (device dm-0): forced readonly
  (...)

If the anonymous device gets reallocated by another btrfs filesystem
or any other kernel subsystem, then bad things can happen.

So fix this by setting the root's anonymous device to 0 at
btrfs_get_root_ref(), before we call btrfs_put_root(), if an error
happened.

Fixes: 2dfb1e43f57dd3 ("btrfs: preallocate anon block device at first phase of snapshot creation")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c598e124c25..fc7dd5109806 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1826,6 +1826,14 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 	}
 	return root;
 fail:
+	/*
+	 * If our caller provided us an anonymous device, then it's his
+	 * responsability to free it in case we fail. So we have to set our
+	 * root's anon_dev to 0 to avoid a double free, once by btrfs_put_root()
+	 * and once again by our caller.
+	 */
+	if (anon_dev)
+		root->anon_dev = 0;
 	btrfs_put_root(root);
 	return ERR_PTR(ret);
 }
-- 
2.33.0

