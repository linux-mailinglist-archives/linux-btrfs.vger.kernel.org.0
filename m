Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C760E8B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiJZTLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiJZTLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:19 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488B139C09
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:44 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b25so11370972qkk.7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYBsXI1dsGNMxcHmA37mFjfUHzDFkTjbgwsr1ICZDgk=;
        b=soVv5X/mpWiPN6ssdHsS1xJWM3KYbiKSOcYzNQtm55aYmJhHcQqiwzc7H9laBTEOwl
         C0AhEUhD5g8+jUPX+JmSUxHeNfQrq3+fz7P5Q0Q3tOtujyqZkzrMq7L4x6gAu+2vAoy5
         8QFB7nQdEo0i0KwxBH1o3hbm2dMLg4pcQDV2mXh7sD4rI+tDIYuAlDEfSoN8kJaN40We
         a+oDzVX3nX74b55Kx+gs2I++ctkf7aloDeyT9CtsJn7Mk1oOZfhPJmUxGBKjUqOCYvwu
         XjciWATvwmCczNSMhXx/quRiLarvNhfSr5DjrLyvjuOrl6jCQvUzJxfXEqWPXRwHJ6Ke
         rRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYBsXI1dsGNMxcHmA37mFjfUHzDFkTjbgwsr1ICZDgk=;
        b=XBJhdkax7u7joZp8CHoMwo+x2x8heund18+WnJhNd9QMUfu1Gl7h/nHDyw+HUuGMOx
         H45n9GSF+fL6DSyoQF+XFSfOrYjjiQPqp1AAfykxzXP+fedqejF71Vmzi34MKrp3edmV
         PtUmZH/mNfEpdRjknonFKswR6/JUifmaWj3JR3yZUAO1LlrS2l7jH4qdpJsOC8eRoOI4
         aiF3W/hZXDvB+eXGyhn7si3E8vXCuET9KQBmh+1Oxmj4v7Rxvf4oM2AWU8wOr3j90cQB
         rZuTrwug1dnU2WsCuc/+EpuDywlzqAEd5feiZxE6KGDttiu8NLNe7fUjt0fPN5d2YS+m
         4Qdg==
X-Gm-Message-State: ACrzQf0sM4djsLBXZptgoAmf+laznpwPCW6mTAjSr8WrB99z0nPAmKAl
        se1aAufDGdRHs+FFsQx2kpnFFHXheDnqOQ==
X-Google-Smtp-Source: AMsMyM6sDe3hBpHZTw9YYPeIpjnvEck9vxkcsqx6mTEw0A8uHetMaERaMy7v7UmGd8PMHUVeV7uCYA==
X-Received: by 2002:a37:a49:0:b0:6ee:6816:41e9 with SMTP id 70-20020a370a49000000b006ee681641e9mr31472394qkk.173.1666811323483;
        Wed, 26 Oct 2022 12:08:43 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u6-20020a37ab06000000b006bb2cd2f6d1sm4241876qke.127.2022.10.26.12.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/26] btrfs: final ctree.h cleanups
Date:   Wed, 26 Oct 2022 15:08:15 -0400
Message-Id: <cover.1666811038.git.josef@toxicpanda.com>
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

Hello,

This is the last bit to cleanup ctree.h.  There bulk of this is moving the
prototypes into their own headers, so yes this explodes out the number of files
we have.  I've also moved messages stuff into messages.c, as when I started the
work to sync stuff to btrfs-progs I realized it's kind of annoying having that
code bundled up with other things, so having it separate will make it easier to
deal with that stuff on it's own.

I've also left btrfs_root in ctree.h.  I really, really want to cleanup
disk-io.c, and so I'm holding off moving btrfs_root until I do the disk-io.c
cleanup, hopefully there will be a logical place to move that struct once I've
done that cleanup.

This is the last batch of cleanups for this cycle hopefully.  I may have some
smaller things as I start trying to sync btrfs-progs, but this is the last big
terrible splitting for now.  Thanks,

Josef

Josef Bacik (26):
  btrfs: convert discard stat defs to enum
  btrfs: move btrfs_chunk_item_size out of ctree.h
  btrfs: add dependencies to fs.h and block-rsv.h
  btrfs: add blk_types.h include to compression.h
  btrfs: move the printk and assert helpers to messages.c
  btrfs: move inode prototypes to btrfs_inode.h
  btrfs: rename tree-defrag.c to defrag.c
  btrfs: move the auto defrag code to defrag.c
  btrfs: move the file defrag code into defrag.c
  btrfs: move defrag related prototypes to their own header
  btrfs: move dir-item prototypes into dir-item.h
  btrfs: move file-item prototypes into their own header
  btrfs: move uuid tree prototypes to uuid-tree.h
  btrfs: move ioctl prototypes into ioctl.h
  btrfs: move file prototypes to file.h
  btrfs: move the 32bit warn defines into messages.h
  btrfs: move the snapshot drop related prototypes to extent-tree.h
  btrfs: move acl prototypes into acl.h
  btrfs: move relocation prototypes into relocation.h
  btrfs: move scrub prototypes into scrub.h
  btrfs: move dev-replace prototypes into dev-replace.h
  btrfs: move verity prototypes into verity.h
  btrfs: move CONFIG_BTRFS_FS_RUN_SANITY_TESTS checks to fs.h
  btrfs: move super prototypes into super.h
  btrfs: move super_block specific helpers into super.h
  btrfs: move orphan prototypes into orphan.h

 fs/btrfs/Makefile           |    4 +-
 fs/btrfs/acl.c              |    1 +
 fs/btrfs/acl.h              |   23 +
 fs/btrfs/backref.c          |    1 +
 fs/btrfs/block-rsv.h        |    1 +
 fs/btrfs/btrfs_inode.h      |  137 ++++
 fs/btrfs/compression.c      |    2 +
 fs/btrfs/compression.h      |    1 +
 fs/btrfs/ctree.c            |    1 +
 fs/btrfs/ctree.h            |  402 ----------
 fs/btrfs/defrag.c           | 1381 +++++++++++++++++++++++++++++++++++
 fs/btrfs/defrag.h           |   23 +
 fs/btrfs/delayed-inode.c    |    1 +
 fs/btrfs/dev-replace.c      |    1 +
 fs/btrfs/dev-replace.h      |    8 +
 fs/btrfs/dir-item.c         |    1 +
 fs/btrfs/dir-item.h         |   43 ++
 fs/btrfs/disk-io.c          |    5 +
 fs/btrfs/export.c           |    1 +
 fs/btrfs/extent-tree.c      |    2 +
 fs/btrfs/extent-tree.h      |    6 +
 fs/btrfs/extent_io.c        |    4 +
 fs/btrfs/file-item.c        |    2 +
 fs/btrfs/file-item.h        |   35 +
 fs/btrfs/file.c             |  344 +--------
 fs/btrfs/file.h             |   31 +
 fs/btrfs/free-space-cache.c |    3 +
 fs/btrfs/free-space-cache.h |    8 +-
 fs/btrfs/fs.h               |   35 +-
 fs/btrfs/inode-item.c       |    1 +
 fs/btrfs/inode.c            |   11 +
 fs/btrfs/ioctl.c            |  909 +----------------------
 fs/btrfs/ioctl.h            |   17 +
 fs/btrfs/lzo.c              |    1 +
 fs/btrfs/messages.c         |  353 +++++++++
 fs/btrfs/messages.h         |   13 +
 fs/btrfs/ordered-data.c     |    2 +
 fs/btrfs/orphan.h           |   11 +
 fs/btrfs/props.c            |    1 +
 fs/btrfs/reflink.c          |    3 +
 fs/btrfs/relocation.c       |    3 +
 fs/btrfs/relocation.h       |   25 +
 fs/btrfs/root-tree.c        |    1 +
 fs/btrfs/scrub.c            |    2 +
 fs/btrfs/scrub.h            |   16 +
 fs/btrfs/send.c             |    4 +
 fs/btrfs/super.c            |  352 +--------
 fs/btrfs/super.h            |   29 +
 fs/btrfs/transaction.c      |    6 +
 fs/btrfs/tree-defrag.c      |  133 ----
 fs/btrfs/tree-log.c         |    4 +
 fs/btrfs/uuid-tree.c        |    1 +
 fs/btrfs/uuid-tree.h        |   12 +
 fs/btrfs/verity.c           |    3 +
 fs/btrfs/verity.h           |   27 +
 fs/btrfs/volumes.c          |    5 +
 fs/btrfs/volumes.h          |    9 +
 fs/btrfs/xattr.c            |    1 +
 58 files changed, 2316 insertions(+), 2146 deletions(-)
 create mode 100644 fs/btrfs/acl.h
 create mode 100644 fs/btrfs/defrag.c
 create mode 100644 fs/btrfs/defrag.h
 create mode 100644 fs/btrfs/dir-item.h
 create mode 100644 fs/btrfs/file-item.h
 create mode 100644 fs/btrfs/file.h
 create mode 100644 fs/btrfs/ioctl.h
 create mode 100644 fs/btrfs/messages.c
 create mode 100644 fs/btrfs/orphan.h
 create mode 100644 fs/btrfs/relocation.h
 create mode 100644 fs/btrfs/scrub.h
 create mode 100644 fs/btrfs/super.h
 delete mode 100644 fs/btrfs/tree-defrag.c
 create mode 100644 fs/btrfs/uuid-tree.h
 create mode 100644 fs/btrfs/verity.h

-- 
2.26.3

