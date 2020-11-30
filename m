Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33282C85D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgK3NrL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 08:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgK3NrL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 08:47:11 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8AC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 05:46:25 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so10729700qkk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 05:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OqVgQxpbS4XmTdKdQXo3H8Zj52FUP1PlYQEEFBEFpU=;
        b=nGfFLNp5W4VQ4g6evOQ3A2NAMwgt3tGmeJO1nHc2x2FOnSxMvJMtWYO5JnT19uvgM0
         nKQ1n2ZzmNQxH5QsvpPPRH8sNvQ/SdXddQasPbhFdUSt2+P5ZkfdvSVXiT/CjYLCMxla
         XwIgelLtAhISGDrQJTHbC6RxqgH8xOYxQjDBE8Bhhq4SbGsmEBJR43rzNqahXilodjGz
         eDFZgcuSj9fugeaC+K9ZC1ALj+fecjtrWuEwVaMLiwoxSj6SgdFn5S08hh3qKq+mvBDu
         ZgT3zVJ146OTBzd757rOu5POnEBHE40emEx0K3SOJB/jYewo9XXzy7V/jlgzWmaqO5GC
         /d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OqVgQxpbS4XmTdKdQXo3H8Zj52FUP1PlYQEEFBEFpU=;
        b=Zfv1bNwQG+GQP4Tfuz44lHB04uOb4QuSyupQwBupOUlUiYrb0wuGpuI/Znd9krZm8P
         1VA6UQklpWUqkIRvfKd6sx2kDEc6GTySC0/bRrkkIlnJVPIDtwO4z7dhozw8q41XASkr
         3B1FC0qOtA8xBkwVtz7U1zIOhSHelJJ/wN4s6erSY+PHxIRHxOIJALt9ofGKsRDO6hjp
         OCVkqeNJmDzVfDCbf4MrgrnhR1Wf8mmL4MSxsM90YZZDjYos4r7X99OrqNjKyw2AUsn/
         Nq9yqiT2MkH317+HTElwPHPioDNH8v1ptBCYNVEnmujj+wdmzT2ESd7abWO5qXuA/QyH
         2BAA==
X-Gm-Message-State: AOAM531+SB7SwIl3Of5P/tdq+7Ay64WZdS+uMvQ9eagVgM/evjYlaHYW
        pPIi2/EhqufLMSBkO2L1pkWkXgp/HyI4aA==
X-Google-Smtp-Source: ABdhPJw0byOEFhDmsituxJ7XZI9BVyRrjNwJwm6OWBgJPLpR28tpkTmbj8EVJxIjyvHwdN31vYLbyQ==
X-Received: by 2002:a05:620a:1123:: with SMTP id p3mr22066078qkk.48.1606743983865;
        Mon, 30 Nov 2020 05:46:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e9sm15136386qtr.95.2020.11.30.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:46:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not allow -o compress-force to override per-inode settings
Date:   Mon, 30 Nov 2020 08:46:21 -0500
Message-Id: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously, we would set BTRFS_INODE_NOCOMPRESS if compression resulted
in larger buffers, meaning that the data probably wasn't great to be
compressed.  This would sometimes make the wrong decision, and thus end
up disabling compression in cases where we still wanted it in general.
Thus the -o compress-force option.

However some time later we got chattr -c, which is a user way of
indicating that the file shouldn't be compressed.  This is at odds with
-o compress-force.  We should be honoring what the user wants, which is
to disable compression.  The rub here is our setting of NOCOMPRESS when
we can't compress the file.

But, the way the code works, if we have -o compress-force we'll never
set NOCOMPRESS ourselves, it'll only be set by the user.  I think this
is a reasonable set of behaviors, if NOCOMPRESS is set on the inode then
we assume it was done at the users behest, and honor it no matter what.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0ce42d52d53e..6609b5679d27 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -479,15 +479,15 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 			btrfs_ino(inode));
 		return 0;
 	}
+	/* bad compression ratios, or we were set with chattr -c. */
+	if (inode->flags & BTRFS_INODE_NOCOMPRESS)
+		return 0;
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
 		return 1;
 	/* defrag ioctl */
 	if (inode->defrag_compress)
 		return 1;
-	/* bad compression ratios */
-	if (inode->flags & BTRFS_INODE_NOCOMPRESS)
-		return 0;
 	if (btrfs_test_opt(fs_info, COMPRESS) ||
 	    inode->flags & BTRFS_INODE_COMPRESS ||
 	    inode->prop_compress)
@@ -1304,8 +1304,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 
 	unlock_extent(&inode->io_tree, start, end);
 
-	if (inode->flags & BTRFS_INODE_NOCOMPRESS &&
-	    !btrfs_test_opt(fs_info, FORCE_COMPRESS)) {
+	if (inode->flags & BTRFS_INODE_NOCOMPRESS) {
 		num_chunks = 1;
 		should_compress = false;
 	} else {
-- 
2.26.2

