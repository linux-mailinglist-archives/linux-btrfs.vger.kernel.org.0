Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7A184B55
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgCMPpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:45:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39996 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgCMPpC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:45:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id j2so355035qkl.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhpST5SRMDU1486x5u4424Fg4Vud/zxOziaLMWOmdRw=;
        b=cXYNX0Vovb6KTqm2Q53W5ViujD0O//V9PlaH/86mDSvLCuWCEZLnvMTkbDwqc/nwI7
         vYL4HynpXZRiwS3NnApnW2/mCc/ZU5R8TkCyM17abRIkMl1TTsydup2osJDKq5xSywVS
         td3wOO9lYg+pfvlcKm1YywwzWXgopPcwa2I2TUDrXExphZhLv5PtR/LF7Ev+JpFpkUli
         42GImWAulhDeNhyV9jy4HsnZEMKB/Cc8sV5rLyjF/KzixsbMKMNG5bap5SAq4h0UCTiz
         pTp/7osko/VeILXK8ULPxA5XQCkEOimLvSvBFzPu/5BuqaCkhCXtvn8IjVrFzGANG6o0
         VbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhpST5SRMDU1486x5u4424Fg4Vud/zxOziaLMWOmdRw=;
        b=Wb1E5PBQ9LLp8+wEOjHL/gmncFBVpBPB87UECimeqPJphEGXMuQpQbUuaOp4vtp+CM
         UeoCWPgsmDu0PekVBg6I39KZkOBAfNXRRu8yDlkampJrUJCWW+nTpWKsLIeBcyfjvIuu
         HvMmLiMit+SOp6cSYbR6DKcsXWDKwuOIJPY2ISXBcV0g19VSMUtDzjIqSQCSd0PW5xtw
         iTnu8+XuE+CrkPP4pngrCrrvkUWoa3PHY/kXZ2PQI/lAI7BOyzNJ6Absnm77LmmFZ8rx
         ikpkJrX6Io/sTQgLxnVTqfLmonVjldRK/GF92BcMYxyNECJftsYJCGZbpvKDvkrChqec
         5mAw==
X-Gm-Message-State: ANhLgQ0YQq8Fac2dw8+a3mUyvmFKP+Fl2IjkSP8vjGjZ7a+oN4ul1Lfk
        3//f3XQTLETxuErFakwdH7vQU9zsSio=
X-Google-Smtp-Source: ADFU+vvFdsVXt8vVJ8y4MMwTWCnO5OHvqbqHK/dgzXXkAOGnCXCJjuvVFSWxpY77g4vYufLrjF9gWQ==
X-Received: by 2002:a37:27cf:: with SMTP id n198mr13016005qkn.97.1584114300539;
        Fri, 13 Mar 2020 08:45:00 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t53sm3991994qth.70.2020.03.13.08.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:44:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 5/8] btrfs: run clean_dirty_subvols if we fail to start a trans
Date:   Fri, 13 Mar 2020 11:44:45 -0400
Message-Id: <20200313154448.53461-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313154448.53461-1-josef@toxicpanda.com>
References: <20200313154448.53461-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we do merge_reloc_roots() we could insert a few roots onto the dirty
subvol roots list, where we hold a ref on them.  If we fail to start the
transaction we need to run clean_dirty_subvols() in order to cleanup the
refs.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 721d049ff2b5..9c8a4a4b2bde 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4279,10 +4279,10 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		goto out_free;
 	}
 	btrfs_commit_transaction(trans);
+out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;
-out_free:
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
 	btrfs_free_path(path);
 	return err;
@@ -4712,16 +4712,15 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
-		goto out_free;
+		goto out_clean;
 	}
 	err = btrfs_commit_transaction(trans);
-
+out_clean:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;
 out_unset:
 	unset_reloc_control(rc);
-out_free:
 	free_reloc_control(rc);
 out:
 	if (!list_empty(&reloc_roots))
-- 
2.24.1

