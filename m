Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E5604A15
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJSO54 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiJSO5g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:36 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA65B514
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:03 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t25so10836406qkm.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZJYHFKPnUECzjk7GRdRY+3U8OcYHf4bOfRsc1Nl/4s=;
        b=xg7kD47tkG2YBE2pqfLVxOrfOLkuYpCBTGUA3rK6OUzy/tFqMTYVG1QslSAkHfLJ6g
         Xu8rKYT19MueQJVKIYKcnEtQVdiJzGHCltHPi4XxT57HEHNLwjGTko8rlCq/xNHdx50h
         hsht8C/apRKDPcZc7A6UfCVXE7pG6DEE/axefJBl3/WZ0qW4GEIjuDObJEZ5MpR4L5cb
         Sb8ZQ9mriqLn/3KSve+itjcVAs1HVHX5PTzNDblrI8RUXWoufS9vbUWGClD3m7S9y/40
         fYnqFkdZ5YIMjT4zqBKncD7B4982m2cDAMfHdxzmFc9XvMoKUBiOMAWjgNFOVw2M52r4
         4rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZJYHFKPnUECzjk7GRdRY+3U8OcYHf4bOfRsc1Nl/4s=;
        b=xXs9jZV1RA/I0mmUNRNaQCNAkb2VIwlUSqN32E38rPHfzMBALfx0e3xqW5JCLt2fGH
         8+OjQvE08sh2MYzP3mn++8nqguG1zQFVMtv18209LAlXUtmYN9oO9iP733mA2Mfrj3op
         3S4eP3l5AgFXKeEYDbamWUtg9RbF7nYtbFe72DOzJwpNmv3M5IAhV6VOSAKmwOqtgi1h
         0f+PTdYvA53IRvw7hO30jBy8ZIX5FG7T++t9ImRQhqw35MJ5xS21xEb6QjdhkWXuPzq9
         JBcKZTtoltrsKV7V32W1eiOeX9qf3qjLaSXPYlG8UGYNahxJoRNI4f6wjxpuVnkQecEc
         qTfA==
X-Gm-Message-State: ACrzQf1nfOt+16KKmB6dj2YI22bfc+ZzyRGZqv64p/3MC8UAu8fwiy94
        Fk92wacxr8v1rJswStMwjZpPWCwwXCE1uQ==
X-Google-Smtp-Source: AMsMyM4f1Zm8HRxll5082coZQ4FTbAurTuDopYU1r/4LLZcgf29GI9lYoJFHtgMTHNkX4JkGKD8o3A==
X-Received: by 2002:a05:620a:1082:b0:6eb:a13b:2460 with SMTP id g2-20020a05620a108200b006eba13b2460mr5840190qkk.156.1666191062582;
        Wed, 19 Oct 2022 07:51:02 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y21-20020a37e315000000b006ecb3694163sm4786466qki.95.2022.10.19.07.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 00/15] btrfs: split out larger chunks of ctree.h
Date:   Wed, 19 Oct 2022 10:50:46 -0400
Message-Id: <cover.1666190849.git.josef@toxicpanda.com>
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

v2->v3:
- Merged the moving of the printk helpers out of ctree.h and then moving some of
  the larger helpers into their own c file into one patch.
- Moved the assert helper patch to before the printk moving patch so I don't
  move the code twice.
- Adjusted the commit log to indicate I was un-inlining the btrfs_map_token_init
  funciton.
- Added some missing newlines at the end of headers.

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

Josef

Josef Bacik (15):
  btrfs: move fs wide helpers out of ctree.h
  btrfs: move assert helpers out of ctree.h
  btrfs: move the printk helpers out of ctree.h
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
 fs/btrfs/accessors.h                     | 1105 ++++++++++++++
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
 fs/btrfs/messages.h                      |  229 +++
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
 fs/btrfs/super.c                         |   32 +-
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
 69 files changed, 1919 insertions(+), 1823 deletions(-)
 rename fs/btrfs/{struct-funcs.c => accessors.c} (96%)
 create mode 100644 fs/btrfs/accessors.h
 create mode 100644 fs/btrfs/fs.c
 create mode 100644 fs/btrfs/fs.h
 create mode 100644 fs/btrfs/messages.h

-- 
2.26.3

