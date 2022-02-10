Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65714B15F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244657AbiBJTKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiBJTKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:30 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A800F10BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y9so6047413pjf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHmsR67tAZzWsX2EgQilpmPu8dbVpZxHUGkX5TXXUig=;
        b=qC9Hxb4xhJwUy0iJ6gi0n/kL02YjqZN56RFCjUTlrFt4LWyk2n964nYwJcPuTVmhkH
         edwjjPBhst1qrWHcUNBLaee6sJa220sMlIogduw0zyNh6OH1uy+e9sLeQ4pXQ742FIln
         wt9fffgFD11V3kJalTT+7LHQsgRV8qOGtf3w8HY3DOFSii3F6xJOpAvZkFeblbrwImzP
         a7nH6uVLODnovp/Pks5cklrlbxvGNCK44e2R4DJCq/N3DJJdmzLN8eRNkxj3NYMsLWeO
         p7pq1uqgR6Mp4TIuIVTU6ob93Z1LG2NfzhUYqrZAkzGjpQnj3iLMNq+HPB7ASjOVO+d7
         +h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHmsR67tAZzWsX2EgQilpmPu8dbVpZxHUGkX5TXXUig=;
        b=4YyYxdu0dlAkWJAIIBBYpuz/MnBapAMrr4vLRikyyQpqoLKJriFGT1oo8OBuEM+HRi
         NeSe7n4z5Tyvl+FElK1sx1nZDBRuTngJf2DNVj2LEY/wl0Ci9XCU2YIyykmNhzYfqX4O
         DpGxwCTZ5HNBK9mILWGLKhtx1hi2cWJThdp4Juq3LDdM9CR5CuZXKTrRoGHQ4zdDmP7S
         oGHTSD8lbD9YE+KaTKSI5dfMGdsX2QTmp96Mx74t6X/Zh5PUZ75s3jjOZEJGrS06HCmB
         GGbZFDFGS/HgKvswEgTnd+IufrN1h6vhN52Chq81LYIySisErsNRUjBVhZcNOImd2gxj
         IJ1A==
X-Gm-Message-State: AOAM532wWoSdp0NpKd/j/CkZxYz9Wxt+lYjYX0ks8NrH8fNe3y7c1+gH
        Djmyd6ESlTIxYYsIIrfdph6EVccr2hfapg==
X-Google-Smtp-Source: ABdhPJz/HXvIFlE+p+VNKm2Ii79STRiIa0lvs+z6PX9/gFZ4bNX/iMXjXr8f3jl0PPUKvp5LYUV7kw==
X-Received: by 2002:a17:903:2cb:: with SMTP id s11mr8839683plk.112.1644520229755;
        Thu, 10 Feb 2022 11:10:29 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:29 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 00/17] btrfs: add ioctls and send/receive support for reading/writing compressed data
Date:   Thu, 10 Feb 2022 11:09:50 -0800
Message-Id: <cover.1644519257.git.osandov@fb.com>
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

This series has three parts: new Btrfs ioctls for reading/writing
compressed data, support for sending compressed data via Btrfs send, and
btrfs-progs support for sending/receiving compressed data and writing it
with the new ioctl.

Patches 1 and 2 are VFS changes exporting a couple of helpers for checks
needed by reads and writes. Patches 3-8 are preparatory Btrfs changes
for compressed reads and writes. Patch 6 is a cleanup. Patch 9 adds the
compressed read ioctl and patch 10 adds the compressed write ioctl.

The main use-case for this interface is Btrfs send/receive. Currently,
when sending data from one compressed filesystem to another, the sending
side decompresses the data and the receiving side recompresses it before
writing it out. This is wasteful and can be avoided if we can just send
and write compressed extents.

Patches 11 and 12 are cleanups for Btrfs send. Patches 13-17 add the
Btrfs send support. See the previous posting for more details and
benchmarks [1]. Patches 13-15 prepare some protocol changes for send
stream v2. Patch 16 implements compressed send. Patch 17 enables send
stream v2 and compressed send in the send ioctl when requested.

These patches are based on Dave Sterba's Btrfs misc-next branch [2],
which is in turn currently based on v5.17-rc3. Test cases are here [3].

Changes since v12 [4]:

- Changed some LZO code to use filesystem sector size instead of page
  size.
- Changed to use btrfs_inode_lock() instead of inode_lock().
- Added explanation of why we don't need to hold mmap lock for encoded
  reads to commit message.
- Got rid of GFP_HIGHMEM allocations.
- Changed send protocol definitions to use explicit numbers.
- Changed btrfs send patch to default to protocol v1 for now.
- Style cleanups.

1: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
2: https://github.com/kdave/btrfs-devel/tree/misc-next
3: https://github.com/osandov/xfstests/tree/btrfs-encoded-io
4: https://lore.kernel.org/linux-btrfs/cover.1637179348.git.osandov@fb.com/

Omar Sandoval (17):
  fs: export rw_verify_area()
  fs: export variant of generic_write_checks without iov_iter
  btrfs: don't advance offset for compressed bios in
    btrfs_csum_one_bio()
  btrfs: add ram_bytes and offset to btrfs_ordered_extent
  btrfs: support different disk extent size for delalloc
  btrfs: clean up cow_file_range_inline()
  btrfs: optionally extend i_size in cow_file_range_inline()
  btrfs: add definitions + documentation for encoded I/O ioctls
  btrfs: add BTRFS_IOC_ENCODED_READ
  btrfs: add BTRFS_IOC_ENCODED_WRITE
  btrfs: send: remove unused send_ctx::{total,cmd}_send_size
  btrfs: send: explicitly number commands and attributes
  btrfs: add send stream v2 definitions
  btrfs: send: write larger chunks when using stream v2
  btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
  btrfs: send: send compressed extents with encoded writes
  btrfs: send: enable support for stream v2 and compressed writes

 fs/btrfs/compression.c     |  10 +-
 fs/btrfs/compression.h     |   6 +-
 fs/btrfs/ctree.h           |  19 +-
 fs/btrfs/delalloc-space.c  |  18 +-
 fs/btrfs/file-item.c       |  32 +-
 fs/btrfs/file.c            |  68 ++-
 fs/btrfs/inode.c           | 930 +++++++++++++++++++++++++++++++++----
 fs/btrfs/ioctl.c           | 208 +++++++++
 fs/btrfs/ordered-data.c    | 131 ++----
 fs/btrfs/ordered-data.h    |  25 +-
 fs/btrfs/relocation.c      |   2 +-
 fs/btrfs/send.c            | 324 +++++++++++--
 fs/btrfs/send.h            | 142 +++---
 fs/internal.h              |   5 -
 fs/read_write.c            |  34 +-
 include/linux/fs.h         |   2 +
 include/uapi/linux/btrfs.h | 142 +++++-
 17 files changed, 1760 insertions(+), 338 deletions(-)

The btrfs-progs patches were written by Boris Burkov with some updates
from me. Patches 1-4 are preparation. Patch 5 implements encoded writes.
Patch 6 implements the fallback to decompressing. Patches 7 and 8
implement the other commands. Patch 9 adds the new `btrfs send` options.
Patch 10 adds a test case.

Boris Burkov (8):
  btrfs-progs: receive: support v2 send stream larger tlv_len
  btrfs-progs: receive: dynamically allocate sctx->read_buf
  btrfs-progs: receive: support v2 send stream DATA tlv format
  btrfs-progs: receive: process encoded_write commands
  btrfs-progs: receive: encoded_write fallback to explicit decode and
    write
  btrfs-progs: receive: process fallocate commands
  btrfs-progs: receive: process setflags ioctl commands
  btrfs-progs: receive: add tests for basic encoded_write send/receive

Omar Sandoval (2):
  btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
  btrfs-progs: send: stream v2 ioctl flags

 Documentation/btrfs-receive.rst               |   5 +
 Documentation/btrfs-send.rst                  |  22 ++
 cmds/receive-dump.c                           |  31 +-
 cmds/receive.c                                | 347 +++++++++++++++++-
 cmds/send.c                                   | 100 ++++-
 common/send-stream.c                          | 165 +++++++--
 common/send-stream.h                          |   7 +
 ioctl.h                                       | 151 +++++++-
 kernel-shared/send.h                          | 146 +++++---
 libbtrfs/send-stream.c                        |   2 +-
 .../052-receive-write-encoded/test.sh         | 114 ++++++
 11 files changed, 993 insertions(+), 97 deletions(-)
 create mode 100755 tests/misc-tests/052-receive-write-encoded/test.sh

-- 
2.35.1

