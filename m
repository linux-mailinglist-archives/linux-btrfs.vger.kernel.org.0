Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5422D2F92
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgLHQ0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbgLHQ0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:10 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DDC0617B0
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:34 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id l7so12285274qtp.8
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AiRItZbDfX3OPAKhq48UaEMQcc2QWJynBHjm1/PoRdg=;
        b=d14pXTXqFBS6yM6rW/x3ql+nLp0F9uzo9IK4bFtplUVSj9eTT5DyXQPchdq8GnMHF3
         JcwAwiVVDgjJizVxRe6zm03Z5BeK7d+bJRvhEAHwp9w2UShSPnbYUSnhT9q3z/8IBNEX
         U6hLFETITmkOXXeXzs7eHP380TCKlX8idqtTaN7vA4ROz19r87Wgxr9V2POvrFs/gXF4
         gF+WcdzUq35Am5aWp9jRJ00a6WIAKenUU5Gn0FkVu7JN9TdZAoZqU+GXOWULMhAyp+WV
         cDmCfPnnu0pghbt9IjTpaBwy/5JgcNI/67NznFGO2WdTatGU4I77Ay8Ijb79jPd82EI0
         mxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AiRItZbDfX3OPAKhq48UaEMQcc2QWJynBHjm1/PoRdg=;
        b=H7xWB8jzNJgA5SLDoPV4p+3ORCQRD+ZugrLFBGLpgjD6QcnPMPcmsvjxY8kP3cbnNu
         8vgYyId+kZY9xiuI7JgKiUoljhP9yW6wteHT89RJW37Q55hkptwNUGMGxVq3TOeXKpmZ
         bJHnBDjxi+TktjYhzp1xBVUw+n5I1Jj52GUiJXkEYurfb4dPiSW9Mbsn8SpI6txl7Zqi
         BcJdNseh9r1p1MfMaTpNM1iqEyiIfLOBX+TFJ/J/seJ0jhlpQmDrIWhpMyZjpuQRQlJH
         hNStS3PDD0gEnRcT4FJSFqNvjljBd/EBZxsePQHzTN0KFGe6y27izkXKiAjN93/kvt+h
         U+RA==
X-Gm-Message-State: AOAM5338RmR2fr0tFRl9lukXxT7E1z2yKm1oEVvuUTvjWQpU3/rdaaDt
        T8N4+b9OJEmE6q2x+SOa5J5psFqo9U9cYsII
X-Google-Smtp-Source: ABdhPJwS4PVvha9eBZUU/OOYqHcPf3ungOkHOE6UDBAKYG5EZlBqMs86sfx00RKJuax4K7fUt7blKA==
X-Received: by 2002:aed:3668:: with SMTP id e95mr30877352qtb.69.1607444733503;
        Tue, 08 Dec 2020 08:25:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 17sm14218310qtb.17.2020.12.08.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 42/52] btrfs: remove the extent item sanity checks in relocate_block_group
Date:   Tue,  8 Dec 2020 11:23:49 -0500
Message-Id: <8d747afa22269b0ca24b4c635c3ed900f422f23f.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These checks are all taken care of for us by the tree checker code.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1097d1b3c492..328a78399ddb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3361,20 +3361,6 @@ static void unset_reloc_control(struct reloc_control *rc)
 	mutex_unlock(&fs_info->reloc_mutex);
 }
 
-static int check_extent_flags(u64 flags)
-{
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if (!(flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    !(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-		return 1;
-	return 0;
-}
-
 static noinline_for_stack
 int prepare_to_relocate(struct reloc_control *rc)
 {
@@ -3426,7 +3412,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
-	u32 item_size;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -3475,19 +3460,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_extent_item);
-		item_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
-		if (item_size >= sizeof(*ei)) {
-			flags = btrfs_extent_flags(path->nodes[0], ei);
-			ret = check_extent_flags(flags);
-			BUG_ON(ret);
-		} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
-			err = -EINVAL;
-			btrfs_print_v0_err(trans->fs_info);
-			btrfs_abort_transaction(trans, err);
-			break;
-		} else {
-			BUG();
-		}
+		flags = btrfs_extent_flags(path->nodes[0], ei);
 
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			ret = add_tree_block(rc, &key, path, &blocks);
-- 
2.26.2

