Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9125B8E01
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiINRSl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiINRS1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:27 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBBB80379
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:24 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f13so7152343qkk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=PbJ/hl+iOFpqsp/H2txaInWwVcg3LW8C6QcofSfQqlg=;
        b=gxyxuQ4in2cBR0uMd/JVBb1oKpaNQ/b79ViMMuL+UrGGn/+tg4ABTCbVGuSlkoRDkT
         j9yQbPqrOstAenltwQx3myQmZs0+wo8SPX0kDVgYDj9/rfjYVXSJrFyEemMln1k8KdoZ
         XFfu1i5QgYOoYiZ6eiZwSRz5+9P2J4P3PZTiEKyer0XISvxe2lC+QJX5yhm7cY4Bcamb
         Vu364DQLdm0ozV8kkL56Q6xyMKfCYtf1Ez4bQyb9Uoar8SUUxveq3W28NOCFVF82OiiQ
         smSPSv3Y0ZkkXOqwqWzA9OCk4pjp21XMmbIi+voD75a+z4QPp/s3dMiETntEr0IJV3yM
         MYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=PbJ/hl+iOFpqsp/H2txaInWwVcg3LW8C6QcofSfQqlg=;
        b=JAbYnCMw04kry9k5nkX7oRYgxn+5Vp2r9DPU0Qdm9Z65IjWvKWjDBdIsBjBTWUy3GP
         HJ1JXUMk2aEBpnfOr1VrOMgzuotzZEZz8jhhz43PJ/3Lb+ocP8kbKhKZYHxeS8dnlKqa
         gFCeKtSsWxQ5bZp87fJMAFXhFZwOoQr8WX8Ml2Tx7FZc9u18kuSa9DbMIrY7ez50/RwQ
         JM4sG6LSjwwXN+5N/w0DGIcrNVd5QgOANILYHKUNzGensdcpGIan+2vvzt271R/lIcH+
         IXuTYnDE0VxxFQt3bCxcNldDwHIAg6qZoM7vdCl8lCSzZPwXpOxdQ6ozj5gVshrdmUJ5
         mf1Q==
X-Gm-Message-State: ACgBeo0x3BEWq+DGg0JyWfjLtUTTx03n4j/CEoiT7KZIKKWPRWphIzd4
        QlOioPpNHSuY9G4K//wVYTRFNNSmTDfRzg==
X-Google-Smtp-Source: AA6agR55C/HQfPZ+TktEswzcSwSufpoR40ltFvSodqTJP8ucCaflneoy4HqmxZJLEmRPf+r1v/f6tw==
X-Received: by 2002:a05:620a:1489:b0:6cc:43ae:4353 with SMTP id w9-20020a05620a148900b006cc43ae4353mr19592253qkj.173.1663175903155;
        Wed, 14 Sep 2022 10:18:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b8-20020ac844c8000000b0035ba5db657esm1847299qto.76.2022.09.14.10.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/16] btrfs: split out larger chunks of ctree.h
Date:   Wed, 14 Sep 2022 13:18:05 -0400
Message-Id: <cover.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Hello,

This series is based on the series

  btrfs: initial ctree.h cleanups, simple stuff

which needs to be in place before applying these patches.

This is likely going to have the largest patch of the series, which bulk moves
all of the struct funcs defines out of ctree.h into their own file.  This isn't
really possible to do piecemeal like other changes because we're using macros
instead of functions.  However the code is well organized so it allows for a
bulk copy and paste, so is straightforward.

I've done my best with naming, but I'm open to suggestions.  My general plan is
to have all fs wide definitions in fs.h, and then separate out individual things
to their own headers.

The biggest things I've done in this series are

1. Move the printk helpers into their own files.
2. Move the main state flags and core fs helpers into their own files.
3. Moved the struct func definitions to their own files.

This is by no means complete, this is just the first big pass, but as you can
see is already 17 patches long.  Subsequent patches will move more code and do
more cleanups.  Thanks,

Josef

Josef Bacik (16):
  btrfs: move fs wide helpers out of ctree.h
  btrfs: move larger compat flag helpers to their own c file
  btrfs: move the printk helpers out of ctree.h
  btrfs: push extra checks into __btrfs_abort_transaction
  btrfs: move assert and error helpers out of btrfs-printk.h
  btrfs: push printk index code into their respective helpers
  btrfs: move BTRFS_FS_STATE* defs and helpers to fs.h
  btrfs: move incompat and compat flag helpers to fs.c
  btrfs: move mount option definitions to fs.h
  btrfs: move fs_info->flags enum to fs.h
  btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
  btrfs: remove fs_info::pending_changes and related code
  btrfs: move the compat/incompat flag masks to fs.h
  btrfs: rename struct-funcs.c -> item-accessors.c
  btrfs: move btrfs_map_token to item-accessors
  btrfs: move accessor helpers into item-accessors.h

 fs/btrfs/Makefile                             |    4 +-
 fs/btrfs/backref.c                            |    2 +
 fs/btrfs/backref.h                            |    1 +
 fs/btrfs/block-group.c                        |    2 +
 fs/btrfs/block-rsv.c                          |    2 +
 fs/btrfs/btrfs-printk.h                       |  206 ++
 fs/btrfs/check-integrity.c                    |    2 +
 fs/btrfs/compression.c                        |    1 +
 fs/btrfs/ctree.c                              |    3 +
 fs/btrfs/ctree.h                              | 1784 +----------------
 fs/btrfs/delalloc-space.c                     |    2 +
 fs/btrfs/delayed-inode.c                      |    3 +
 fs/btrfs/delayed-ref.c                        |    2 +
 fs/btrfs/dev-replace.c                        |    2 +
 fs/btrfs/dir-item.c                           |    2 +
 fs/btrfs/discard.c                            |    1 +
 fs/btrfs/disk-io.c                            |    8 +-
 fs/btrfs/export.c                             |    1 +
 fs/btrfs/extent-io-tree.c                     |    1 +
 fs/btrfs/extent-tree.c                        |    2 +
 fs/btrfs/extent_io.c                          |    2 +
 fs/btrfs/extent_map.c                         |    1 +
 fs/btrfs/file-item.c                          |    3 +
 fs/btrfs/file.c                               |    2 +
 fs/btrfs/free-space-cache.c                   |    3 +
 fs/btrfs/free-space-tree.c                    |    3 +
 fs/btrfs/fs.c                                 |  108 +
 fs/btrfs/fs.h                                 |  320 +++
 fs/btrfs/inode-item.c                         |    2 +
 fs/btrfs/inode.c                              |    2 +
 fs/btrfs/ioctl.c                              |    2 +
 fs/btrfs/{struct-funcs.c => item-accessors.c} |   10 +
 fs/btrfs/item-accessors.h                     | 1104 ++++++++++
 fs/btrfs/lzo.c                                |    1 +
 fs/btrfs/ordered-data.c                       |    1 +
 fs/btrfs/print-tree.c                         |    2 +
 fs/btrfs/props.c                              |    3 +
 fs/btrfs/qgroup.c                             |    2 +
 fs/btrfs/raid56.c                             |    1 +
 fs/btrfs/ref-verify.c                         |    3 +
 fs/btrfs/reflink.c                            |    2 +
 fs/btrfs/relocation.c                         |    2 +
 fs/btrfs/root-tree.c                          |    3 +
 fs/btrfs/scrub.c                              |    2 +
 fs/btrfs/send.c                               |    1 +
 fs/btrfs/space-info.c                         |    2 +
 fs/btrfs/subpage.c                            |    1 +
 fs/btrfs/super.c                              |   51 +-
 fs/btrfs/sysfs.c                              |    7 +-
 fs/btrfs/tests/btrfs-tests.c                  |    1 +
 fs/btrfs/tests/extent-buffer-tests.c          |    1 +
 fs/btrfs/tests/free-space-tree-tests.c        |    1 +
 fs/btrfs/tests/inode-tests.c                  |    1 +
 fs/btrfs/tests/qgroup-tests.c                 |    2 +
 fs/btrfs/transaction.c                        |   29 +-
 fs/btrfs/transaction.h                        |    1 -
 fs/btrfs/tree-checker.c                       |    3 +
 fs/btrfs/tree-defrag.c                        |    1 +
 fs/btrfs/tree-log.c                           |    2 +
 fs/btrfs/tree-log.h                           |    1 +
 fs/btrfs/tree-mod-log.c                       |    3 +
 fs/btrfs/ulist.c                              |    1 +
 fs/btrfs/uuid-tree.c                          |    4 +-
 fs/btrfs/verity.c                             |    3 +
 fs/btrfs/volumes.c                            |    2 +
 fs/btrfs/xattr.c                              |    2 +
 fs/btrfs/zoned.c                              |    2 +
 fs/btrfs/zoned.h                              |    1 +
 68 files changed, 1915 insertions(+), 1823 deletions(-)
 create mode 100644 fs/btrfs/btrfs-printk.h
 create mode 100644 fs/btrfs/fs.c
 create mode 100644 fs/btrfs/fs.h
 rename fs/btrfs/{struct-funcs.c => item-accessors.c} (96%)
 create mode 100644 fs/btrfs/item-accessors.h

-- 
2.26.3

