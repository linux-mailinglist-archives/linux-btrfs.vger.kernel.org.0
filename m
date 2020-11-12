Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0627E2B1004
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgKLVT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgKLVT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:58 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5415C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:58 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so5241562qtx.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4S9ifxbToG9WtuOaxfiMRecEx4hRpkEXnQUH8Ja8g/s=;
        b=Xiv3iALGK5dGOOW3tRjtfRqlyfOPhJojE6axtjBGdRJ+bNXpMBZ64B53FBOe+AQvHI
         1uCh9X5d1SSQnd3P0f6BlQIZuaVdA0ti2veWKKKlX1DuwEHy1kANK7jCb43vpwpio7Tq
         UItf5mgouh6EAZ2q038gJFxNeTGOReVtyqvETWBGwDDYkt/3lfBj07d2qa1dtf37qTK3
         QLUwhEHvGX2jHkFTzSCQ8vyBi8KVozg+tH6e8/3cp4zDxTGa0U9QeS5H8YuxFx+z/rjh
         CXz5tuIHbMi2GDzVpogVLGNE7CoMjD7lHY09ECje+++Uun5SdtHO9HKYOKyzTmQ7mmoM
         ggJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4S9ifxbToG9WtuOaxfiMRecEx4hRpkEXnQUH8Ja8g/s=;
        b=qtkWEpU8E2pndP02HVtKp77h+vsajgKhFxEwp3X2jEvRy96sLlEXWT3szicZVdLzdm
         MBzeRIjaLU22e6gCCdd7nScKvHJVkmpt9c2SPSZH+MoLWRWbntZAPmkMbkQJa/cGGVCp
         Y5GS2ORDTZAtjvRoXpWP24GD/IceH53JEjxXi1QCYas5ixF6KaMMBrNLpaRyhPvl5ZYo
         z0oxVM51VzC7mGriWWX0Io/QMfI/FMCp6bC+BtTD1ctDbDcZiB9N+OkIiRkeDyKbK+oS
         mmxCTT/U/tBZlI2usIT0rI1YJF5eC5G5+5p+zXUbRzqZRzovobdW+coBoiUgm3FuuCye
         ckxQ==
X-Gm-Message-State: AOAM533z972UGPkQdwdENDvTszx6N/SVUW4CH0koDA2zAVmBSU3vXecr
        SQX1GtE03V937yGZt3dCGvm4kXYwRyi0Jw==
X-Google-Smtp-Source: ABdhPJwT/0Gw+/nAmqWyNlRl9Ox1yzhoBwWbhCVKrfqbn/lLZlcLH8BWW1bvfzs8LpLKPwhsC0Slbw==
X-Received: by 2002:aed:2662:: with SMTP id z89mr1237736qtc.70.1605215997435;
        Thu, 12 Nov 2020 13:19:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h5sm5482597qtp.66.2020.11.12.13.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/42] btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
Date:   Thu, 12 Nov 2020 16:18:50 -0500
Message-Id: <726b9d2074ba39a9310a8cadf71608b5a2b2479b.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in commit_fs_roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 29084716b4d2..93b62ead47f2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1346,7 +1346,9 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
-			btrfs_update_reloc_root(trans, root);
+			err = btrfs_update_reloc_root(trans, root);
+			if (err)
+				return err;
 
 			btrfs_save_ino_cache(root, trans);
 
-- 
2.26.2

