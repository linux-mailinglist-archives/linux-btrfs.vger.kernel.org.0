Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682106016F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJQTJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJQTJS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DF875FDA
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s3so8335287qtn.12
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/lORXHrsS2cSSEhciWjIh0YpG2wj6C+znsOQvtmpkKs=;
        b=G/CIdio0FsRm38wnQgdUqVDGn7QZzR8bxQeWz1Iywr2oASjEalZWSYB5p1y3eqOz5f
         RYxnKQ3OSuMTKWX45fuv/f+306we7MedBZIlWwIzNuot1UB4ldOJjkP8cPDk0Z9nFDci
         LL4kDU+ha2dTz1nTqn99yU5ZA+Dpn3Mx6Tr7KgUoYzrPU/ce9qerGpqhVJYm15A0NqlS
         z22Mk6g+qyPVpRGZDvltnlOPUzQXeoIUuvyktpQFQgTo1LRLndkYxLjMu91Ie7V07nFa
         gdKh+jWwOZzYd0fncQSKljiy72SHv39ij+2R5INrzPJ2WNt+ZB1393etKqkiT34S4jrN
         CCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lORXHrsS2cSSEhciWjIh0YpG2wj6C+znsOQvtmpkKs=;
        b=ATluWFGD/tDGrltmJfEZe/I3qxj2h80Umg0Hm23MCAo/kHY0H8SAwFxOmf3x9AWuO3
         XYfP26A8grAsXqjL4nP7XDWdZ5HmL+34Z0AReis40d/woNPvJXnzBV48+3nIYGTgzn4N
         hsrNgye2XCpUov0241IPRiglZPCtsktwkG9E/rX1fglB54ubT5ZGDdWWvKESNSsVBx7i
         NcolgvbAnb9VwsSHoA2kMrEA2kOopfv/49WTNdO7peONitjUr5fJg/ywb21EZV4GUVGY
         rFfHPjhhCAlYFCsLLzbSERyMbZL4kLonShC7aTmZh2WlVP+j+i66nhHC8ps1zPG6XcQw
         MMUQ==
X-Gm-Message-State: ACrzQf2XJYoKJ6BmJW2mffKK1rQFYEFbGt98T6k7ABzvtQ9M5EVDQZHg
        siFVJjlekpl6SVGZ2C5zzhxJjN8rG7kJEw==
X-Google-Smtp-Source: AMsMyM56sa00EXO4wHCAmhq4WOqJfEDfTXwvwmFhfPjgAV6muhP1KFj0WbsPd7etvTMjuCLcYcP7VQ==
X-Received: by 2002:ac8:7d49:0:b0:399:d201:840b with SMTP id h9-20020ac87d49000000b00399d201840bmr10232804qtb.309.1666033755229;
        Mon, 17 Oct 2022 12:09:15 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006ceb933a9fesm410755qkk.81.2022.10.17.12.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/16] btrfs: split out larger chunks of ctree.h
Date:   Mon, 17 Oct 2022 15:08:57 -0400
Message-Id: <cover.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- renamed btrfs-printk.h and item-accessors.* to messages.h and accessors.*.
- I dropped "btrfs: push extra checks into __btrfs_abort_transaction" so the
  WARN_ON would be where the abort happens.
- I reworked the incompat/compat get helpers to be defines instead of inlines to
  maintain the faster code instead of un-inlining the helper, and this way we
  have a little better header cleanliness.
- I gave up on my idea of having headers able to be included at any order at
  this point and made sure everything was included in the proper order.  Once
  things are completely split out we can go back through and try to make all the
  header files as clean as possible.

--- Original email ---
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

Josef Bacik (16):
  btrfs: move fs wide helpers out of ctree.h
  btrfs: move larger compat flag helpers to their own c file
  btrfs: move the printk helpers out of ctree.h
  btrfs: move assert and error helpers out of messages.h
  btrfs: push printk index code into their respective helpers
  btrfs: move BTRFS_FS_STATE* defs and helpers to fs.h
  btrfs: convert incompat and compat flag test helpers to defines
  btrfs: move mount option definitions to fs.h
  btrfs: move fs_info->flags enum to fs.h
  btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
  btrfs: remove fs_info::pending_changes and related code
  btrfs: move the compat/incompat flag masks to fs.h
  btrfs: rename struct-funcs.c -> accessors.c
  btrfs: move btrfs_map_token to accessors
  btrfs: move accessor helpers into accessors.h
  btrfs: remove temporary btrfs_map_token declaration in ctree.h

 fs/btrfs/Makefile                        |    4 +-
 fs/btrfs/{struct-funcs.c => accessors.c} |   10 +
 fs/btrfs/accessors.h                     | 1104 ++++++++++++++
 fs/btrfs/backref.c                       |    2 +
 fs/btrfs/backref.h                       |    1 +
 fs/btrfs/block-group.c                   |    2 +
 fs/btrfs/block-rsv.c                     |    2 +
 fs/btrfs/check-integrity.c               |    2 +
 fs/btrfs/compression.c                   |    1 +
 fs/btrfs/ctree.c                         |    3 +
 fs/btrfs/ctree.h                         | 1782 +---------------------
 fs/btrfs/delalloc-space.c                |    2 +
 fs/btrfs/delayed-inode.c                 |    6 +-
 fs/btrfs/delayed-ref.c                   |    2 +
 fs/btrfs/dev-replace.c                   |    2 +
 fs/btrfs/dir-item.c                      |    2 +
 fs/btrfs/discard.c                       |    1 +
 fs/btrfs/disk-io.c                       |    8 +-
 fs/btrfs/export.c                        |    1 +
 fs/btrfs/extent-io-tree.c                |    1 +
 fs/btrfs/extent-tree.c                   |    2 +
 fs/btrfs/extent_io.c                     |    2 +
 fs/btrfs/extent_map.c                    |    1 +
 fs/btrfs/file-item.c                     |    3 +
 fs/btrfs/file.c                          |    2 +
 fs/btrfs/free-space-cache.c              |    6 +-
 fs/btrfs/free-space-tree.c               |    3 +
 fs/btrfs/fs.c                            |   94 ++
 fs/btrfs/fs.h                            |  322 ++++
 fs/btrfs/inode-item.c                    |    3 +
 fs/btrfs/inode.c                         |    2 +
 fs/btrfs/ioctl.c                         |    2 +
 fs/btrfs/locking.c                       |    1 +
 fs/btrfs/lzo.c                           |    1 +
 fs/btrfs/messages.h                      |  226 +++
 fs/btrfs/ordered-data.c                  |    1 +
 fs/btrfs/print-tree.c                    |    2 +
 fs/btrfs/props.c                         |    3 +
 fs/btrfs/qgroup.c                        |    2 +
 fs/btrfs/raid56.c                        |    1 +
 fs/btrfs/ref-verify.c                    |    3 +
 fs/btrfs/reflink.c                       |    5 +-
 fs/btrfs/relocation.c                    |    2 +
 fs/btrfs/root-tree.c                     |    4 +
 fs/btrfs/scrub.c                         |    2 +
 fs/btrfs/send.c                          |    1 +
 fs/btrfs/space-info.c                    |    2 +
 fs/btrfs/subpage.c                       |    1 +
 fs/btrfs/super.c                         |   34 +-
 fs/btrfs/sysfs.c                         |    7 +-
 fs/btrfs/tests/btrfs-tests.c             |    1 +
 fs/btrfs/tests/extent-buffer-tests.c     |    1 +
 fs/btrfs/tests/free-space-tree-tests.c   |    1 +
 fs/btrfs/tests/inode-tests.c             |    1 +
 fs/btrfs/tests/qgroup-tests.c            |    2 +
 fs/btrfs/transaction.c                   |   29 +-
 fs/btrfs/transaction.h                   |    1 -
 fs/btrfs/tree-checker.c                  |    3 +
 fs/btrfs/tree-defrag.c                   |    1 +
 fs/btrfs/tree-log.c                      |    2 +
 fs/btrfs/tree-log.h                      |    1 +
 fs/btrfs/tree-mod-log.c                  |    3 +
 fs/btrfs/ulist.c                         |    1 +
 fs/btrfs/uuid-tree.c                     |    4 +-
 fs/btrfs/verity.c                        |    3 +
 fs/btrfs/volumes.c                       |    2 +
 fs/btrfs/xattr.c                         |    3 +
 fs/btrfs/zoned.c                         |    2 +
 fs/btrfs/zoned.h                         |    1 +
 69 files changed, 1916 insertions(+), 1824 deletions(-)
 rename fs/btrfs/{struct-funcs.c => accessors.c} (96%)
 create mode 100644 fs/btrfs/accessors.h
 create mode 100644 fs/btrfs/fs.c
 create mode 100644 fs/btrfs/fs.h
 create mode 100644 fs/btrfs/messages.h

-- 
2.26.3

