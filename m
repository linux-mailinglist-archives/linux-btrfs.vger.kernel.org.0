Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A10454E5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbhKQUXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhKQUXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:01 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24435C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:02 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l8so3878821qtk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WboE1i575kwAiSNSQjw8ulMWedkG+3xpiQ5CiK3Uugw=;
        b=NyIUtyBYJmHtzuH9Q0loKPEz8nc7AoP97WqnrermlJmAk484knY8ieROs0we+1jN4j
         B8JghvZ2jaocUfQHDTH2YJbInxiKyYTGWUDR483O8Qp3MdQPZC07HMw9Fng1MclZQCnp
         k1jlKxLXYXG8TZsvhkfrrnuvi0uwf6iWDKgKG53MR9P3SYd/91YaiRF71WmLp+6LKLng
         Szump7BG3PiiY1BgrDXxwAetuYbRUQZeBBnJxPqpEGpxwXiewHZUFSioUNFRNFakHgEt
         a/YA0ZuVoqgp01uSxgC8OQfD8Kr1e04rmK6UQIvple4VvI7WTGn1UUfJ04MIgRqeL9vP
         KI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WboE1i575kwAiSNSQjw8ulMWedkG+3xpiQ5CiK3Uugw=;
        b=QZViEI9t0qAaxrOnUDMuPnAcY0ueBTRPNzvPoW6yohVa6pvlRr1y5uHI5ahUcHOrj0
         u3de5g4+tlv30P6vfUGaNwRVZF+IH8dopk10MmCR494F3CDcf46KCwiuwDBPzWPMppUS
         Jb0WXjlNDiey3G2Q76LcUGEuMqD7NX/4lPYJsJnliBEMUcBa+wY/HTsOBKbgLXPdktOF
         G/DiVoNLetzYyCNwYLJwAR3O6tuPl2FGID5htg98mNw2FoHGCClctP5H0MAQwWQ/pIuS
         bJUgyXWdyiNmwFASMeNrD3nfFKqtdtj5hhNJgEuMOE2vSUSGCN2FGpo6iQaoI2B98bMk
         smtg==
X-Gm-Message-State: AOAM530zADcNTEWtlM76uUywx46hhPSW6TI2Z0AmBc5BS6mn4TGm9y1w
        5RpaEhPdzX97+ojlqXBAau2KRlZdxrD5Sg==
X-Google-Smtp-Source: ABdhPJyeFxdLvSaW91A7c6SCF+u+9dudtVee7IpTSeaZzCQpA2czUhiaNtKeB2l5GoUeYv+rq9WFhQ==
X-Received: by 2002:a05:622a:3d3:: with SMTP id k19mr20106985qtx.334.1637180400874;
        Wed, 17 Nov 2021 12:20:00 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:00 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 00/17] btrfs: add ioctls and send/receive support for reading/writing compressed data
Date:   Wed, 17 Nov 2021 12:19:10 -0800
Message-Id: <cover.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
which is in turn currently based on v5.16-rc1. Test cases are here [3].

Changes since v11 [4]:

- Rebased.
- Reworked send stream protocol versioning based on Dave's approach.
- Split up cow_file_range_inline() change into refactoring change and
  functional change.
- Added enforcement that BTRFS_SEND_A_DATA is always sent last.
- Fixed uninitialized variable reported by kernel test robot.
- Cleaned up some more style nits.
- Added and clarified some comments.
- Changed "page" nomenclature to "sector" for LZO.

1: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
2: https://github.com/kdave/btrfs-devel/tree/misc-next
3: https://github.com/osandov/xfstests/tree/btrfs-encoded-io
4: https://lore.kernel.org/linux-btrfs/cover.1630514529.git.osandov@fb.com/

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
  btrfs: send: fix maximum command numbering
  btrfs: add send stream v2 definitions
  btrfs: send: write larger chunks when using stream v2
  btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
  btrfs: send: send compressed extents with encoded writes
  btrfs: send: enable support for stream v2 and compressed writes

 fs/btrfs/compression.c     |  10 +-
 fs/btrfs/compression.h     |   6 +-
 fs/btrfs/ctree.h           |  17 +-
 fs/btrfs/delalloc-space.c  |  18 +-
 fs/btrfs/file-item.c       |  32 +-
 fs/btrfs/file.c            |  68 ++-
 fs/btrfs/inode.c           | 927 +++++++++++++++++++++++++++++++++----
 fs/btrfs/ioctl.c           | 208 +++++++++
 fs/btrfs/ordered-data.c    | 131 ++----
 fs/btrfs/ordered-data.h    |  25 +-
 fs/btrfs/relocation.c      |   2 +-
 fs/btrfs/send.c            | 324 +++++++++++--
 fs/btrfs/send.h            |  39 +-
 fs/internal.h              |   5 -
 fs/read_write.c            |  34 +-
 include/linux/fs.h         |   2 +
 include/uapi/linux/btrfs.h | 142 +++++-
 17 files changed, 1704 insertions(+), 286 deletions(-)

The btrfs-progs patches were written by Boris Burkov with some updates
from me. Patches 1-4 are preparation. Patch 5 implements encoded writes.
Patch 6 implements the fallback to decompressing. Patches 7 and 8
implement the other commands. Patch 9 adds the new `btrfs send` options.
Patch 10 adds a test case.

Boris Burkov (10):
  btrfs-progs: receive: support v2 send stream larger tlv_len
  btrfs-progs: receive: dynamically allocate sctx->read_buf
  btrfs-progs: receive: support v2 send stream DATA tlv format
  btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
  btrfs-progs: receive: process encoded_write commands
  btrfs-progs: receive: encoded_write fallback to explicit decode and
    write
  btrfs-progs: receive: process fallocate commands
  btrfs-progs: receive: process setflags ioctl commands
  btrfs-progs: send: stream v2 ioctl flags
  btrfs-progs: receive: add tests for basic encoded_write send/receive

 Documentation/btrfs-receive.asciidoc          |   4 +
 Documentation/btrfs-send.asciidoc             |  18 +-
 cmds/receive-dump.c                           |  31 +-
 cmds/receive.c                                | 347 +++++++++++++++++-
 cmds/send.c                                   |  92 ++++-
 common/send-stream.c                          | 165 +++++++--
 common/send-stream.h                          |   7 +
 ioctl.h                                       | 151 +++++++-
 kernel-shared/send.h                          |  39 +-
 libbtrfs/send-stream.c                        |   2 +-
 .../052-receive-write-encoded/test.sh         | 114 ++++++
 11 files changed, 924 insertions(+), 46 deletions(-)
 create mode 100755 tests/misc-tests/052-receive-write-encoded/test.sh

-- 
2.34.0

