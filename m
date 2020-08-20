Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5A24C204
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgHTPTW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbgHTPSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:18:49 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B21C061387
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:49 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so1077567qvb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OjGQFEYOFk+8Y4uqNECrK7AhZUIeC7Y3nVSoTOcR54A=;
        b=SSXHURYU+qPKlix1AGmkfbb2MbxmtdguARW9GCT4iJQV8p4j74PBtlm1thle/Ac94h
         EPkZ666LFNfGDiJjXPD3TqEn4kMnapRBHDcnppYjBjTRz/JPoi4PkDKfUOAlTre2EMub
         Tm3K/p27+ACognBMJV6F0nBflQVn2ITr3sSs201uXNLGXbyg3DUUmhta7+Is7ozI3N6n
         DwVBBj4V5hcFqX7NhF7+FwsJJE6Lg6m9RQmepUBoHFKoGHs2hZZRqFRpPcvEH8dtp7h0
         lf9okcYMK+2WUn9iOYw5mo5uuFjasXHDDx2moY+0FXbnyjtx7r4kxKKrBNHGMayaGhJR
         XAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjGQFEYOFk+8Y4uqNECrK7AhZUIeC7Y3nVSoTOcR54A=;
        b=XnLB3X10dpeV2KiOZ13DPCktYl+hTQuA8WSwiFLNjRvTLpVjclgmZJLXJS/KolfOA+
         uedntMuAjfesUfhWylrWimgs9z4ULNIV3o651TxfxVbyNJJ01oUoN4Xd531+m3Fb+HvY
         /p/Rf2DZ2aHvS5VTX32kByD+NzevZiqCOtvL8L49S/x/8TMlVYmLoTbKFTLzQXmrj5Zw
         iQ/JxIDln91DmjB3gPbWuJUFyA92Tp0MBR0ECJ2d+fe65oHQlq4Un2vFCxrxpgiEhgOS
         +xbmk7fMvWeb2XeVOMqhn0NO10YtwDRY+WZhxzDh3mcH2Exjk3NioIujLbs44sr5Mzgn
         4tJQ==
X-Gm-Message-State: AOAM533Uz7hQkRN294CiQpvOfWZUNkVr1lrcY3e7gZX9cyDaM3sqF/RN
        oKIPpUrtejZFE+/LPZWGkkT1oQYEcms+fSWn
X-Google-Smtp-Source: ABdhPJxKFOlVy+6gCI5jP15CCjlx/cNwhnyfWvmwdAHKbUcK/ZXAwpwMVUhpn7sysjKJ/VBAY4UkUg==
X-Received: by 2002:a0c:fb11:: with SMTP id c17mr3300958qvp.113.1597936728141;
        Thu, 20 Aug 2020 08:18:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r6sm2563006qkc.43.2020.08.20.08.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:18:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: set the correct lockdep class for new nodes
Date:   Thu, 20 Aug 2020 11:18:30 -0400
Message-Id: <928df7dd502b27fd2358bb3936b4bdbb30a0cd14.1597936173.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597936173.git.josef@toxicpanda.com>
References: <cover.1597936173.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When flipping over to the rw_semaphore I noticed I'd get a lockdep splat
in replace_path(), which is weird because we're swapping the reloc root
with the actual target root.  Turns out this is because we're using the
root->root_key.objectid as the root id for the newly allocated tree
block when setting the lockdep class, however we need to be using the
actual owner of this new block, which is saved in owner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 73973e6e8ba6..6c2373f65be2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4522,7 +4522,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		return ERR_PTR(-EUCLEAN);
 	}
 
-	btrfs_set_buffer_lockdep_class(root->root_key.objectid, buf, level);
+	btrfs_set_buffer_lockdep_class(owner, buf, level);
 	btrfs_tree_lock(buf);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
-- 
2.24.1

