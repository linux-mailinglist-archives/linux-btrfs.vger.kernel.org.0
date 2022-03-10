Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C74D3EC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiCJBcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiCJBcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:32:54 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B02EF7B7
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:31:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z15so3778328pfe.7
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzSeKgLiqxAIVdQm7fAcUs7Z6p4Di19AnOKByvp5NvU=;
        b=UH1TX/rtR5ZYzNnMS3KVHIPpoudbO0g+5DPZPYSqmPb+72AEUNXVeCZtwQWq+P9Qkb
         CkNEvDeTT0WPNp06C4lUSbirFem1l2Ryf4igDKVBG1AlbJRhfDB4KlmPINkCUnbYpLgr
         bq/T95M9+jd1Ez9rNovuK5E6MDwDn35SUXi/n0lBGUVdTmBY3ajTovctwP/AuLxWsWwR
         VE6m9oDrErD5+6wnKui0JEZ8oFX+r2JB2WYsIRLzQE5ykb4MPOqiyVORsS+6YFPb7INE
         L27c2hjUFvtcMW6KF+jAfFHpD17llnqZqWmKXRMfVdiJAIz3sRF9bQo273/TGOrjwgW3
         KtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzSeKgLiqxAIVdQm7fAcUs7Z6p4Di19AnOKByvp5NvU=;
        b=whRfXN0fkPTneYgXXvCpT5W8fw2cmPpXnTc7L8cqwcg5eCpL4YbdeLdG6bhOC1ocH2
         PemVYD9bin0C23ez+6zqO4/KaSOjSn4P6VUOQ9gdmUhN4k30rcuTDL7UhapRpiGQUrE8
         DjR+IwmsI3Y5hlmCa3HsI88ANa7Q047Im6Nbkd1HQLrfM9Vq060mLl6/oBzSpkGO4m8F
         x8JgpGBaA0//QzDcibKv+0mQ7kVXy8uAE7jwlyWLT9ckdW8lR98yjgwF4eVHAFRrwFYq
         IBX50fO2PqS2OdEx/6CECP65/QS1RFjh1oC6lEiGTq5regvVEpg9toRqwRicAni6R2fg
         NgXA==
X-Gm-Message-State: AOAM531HbguMu1r/LCOKrVBSj28JRoYPk+nz1qSSTKu0B05XXFwdUisF
        2AubCuhgwQMXFD+EnMhvrGFz2d9j2Xh96Q==
X-Google-Smtp-Source: ABdhPJzyACVCNAZg/BfijblJ+E1vcGmGTjRaQsPEQehQucLKnKRBddovqVvcx+9YMQYXtB0G6J5l6Q==
X-Received: by 2002:aa7:8199:0:b0:4f1:2b3f:ff05 with SMTP id g25-20020aa78199000000b004f12b3fff05mr2565398pfi.1.1646875913583;
        Wed, 09 Mar 2022 17:31:53 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:31:53 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 00/16] btrfs: inode creation cleanups and fixes
Date:   Wed,  9 Mar 2022 17:31:30 -0800
Message-Id: <cover.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series contains several cleanups and fixes for our inode creation
codepaths. The main motivation for this is preparation for fscrypt
support (in particular, setting up the fscrypt context and encrypted
names at inode creation time). But, it also reduces a lot of code
duplication and fixes some minor bugs, so it's worth getting in ahead of
time.

Patches 1-3 are small fixes. Patches 5-12 are small cleanups. Patches
13-16 are the bulk of the change.

Based on misc-next.

Changes since v1 [1]:

- Split the big final patch into patches 3 and 13-16.
- Added Sweet Tea's reviewed-by to the remaining patches.
- Rebased on latest misc-next.

Thanks!

1: https://lore.kernel.org/linux-btrfs/cover.1646348486.git.osandov@fb.com/

Omar Sandoval (16):
  btrfs: reserve correct number of items for unlink and rmdir
  btrfs: reserve correct number of items for rename
  btrfs: fix anon_dev leak in create_subvol()
  btrfs: get rid of btrfs_add_nondir()
  btrfs: remove unnecessary btrfs_i_size_write(0) calls
  btrfs: remove unnecessary inode_set_bytes(0) call
  btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
  btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
  btrfs: remove redundant name and name_len parameters to create_subvol
  btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
  btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
  btrfs: set inode flags earlier in btrfs_new_inode()
  btrfs: allocate inode outside of btrfs_new_inode()
  btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
  btrfs: reserve correct number of items for inode creation
  btrfs: move common inode creation code into btrfs_create_new_inode()

 fs/btrfs/acl.c   |  39 +-
 fs/btrfs/ctree.h |  37 +-
 fs/btrfs/inode.c | 942 +++++++++++++++++++++++------------------------
 fs/btrfs/ioctl.c | 176 ++++-----
 fs/btrfs/props.c |  40 +-
 fs/btrfs/props.h |   4 -
 6 files changed, 579 insertions(+), 659 deletions(-)

-- 
2.35.1

