Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD778F62C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 23:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfHOVEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 17:04:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41329 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOVET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 17:04:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so1825594pgg.8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PhYJ6U6NK+oxP27nWnEBxU1W8qEer2SMNn6tFNQWEVw=;
        b=UIB0c/wi1sxecAFtkdr61TbRQc7r/mGCDPpa/3DoPJ/e3xGylVqj+hHd3G/uEQqPgB
         CLic3EHTFd1hphgcwCN2r/QTFeSsQXUYp0j9ehbXZckAg2z3z2w55sX99VN50LE8mwPq
         11HAzYNNCB6/KQ8oRakZfGq8mSrajWab8fbsDaNKgHfvFjHlmb4X31zEs4JnwyqE4tcK
         5iuTdHZJG3xQmSGCexFbv2uoexoP9nsAgolc+XdYQtDEqS5RhxkqEkA+Pfwz23sKCODa
         fhjVo/bCr/I09vl04oalKaTqmir81GeO9zYLviqB59t1WUPDbdplkYvyeyKTN39jzYjl
         32bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PhYJ6U6NK+oxP27nWnEBxU1W8qEer2SMNn6tFNQWEVw=;
        b=BVKK7tiM3ya3/rJbMuYlVAIrZ5ZxBgfaoWDTIoIwCp8eJ6g7RKaYbEWxzACQU0G+K3
         zrFhwxjXNoao5fWII+BlAfQP7xNW06uWqohEC0z+KKN2IMUE73m1izoPRgoho2UlxmN2
         DEcYJcD9kJDMpZEv68AgasdiD3g5/m6UuUPxOaFfxJT/+crGhct8g/FBHd6LcdRIF89i
         GTQSFoIsjKDU0joKuMVby9S1nQNnFfdBQDC75hdeBb7f/pKO4OmYGvEJnSxmGufCDLJS
         xWJhHQci62xMaO/8t5rigqHImAVd8JRCWRBcJid8bbNJRm6mLCRf8qBg2vjzZGHnzZII
         b5Hw==
X-Gm-Message-State: APjAAAXVFyY+XbGXbeycG2/gWjtzhuIICaykK2izCpOW8TsPNJw9/eDQ
        a+LtdB2N41+OVZJHF2o1+B992Rd2N5k=
X-Google-Smtp-Source: APXvYqx2sgrkYYEfaNc3RyniERUrtzmo0y74OSDVvbkMid3CrdYlCRD9i4FMCOiv5gIE/lwruVbnnw==
X-Received: by 2002:a65:504c:: with SMTP id k12mr5041140pgo.252.1565903057673;
        Thu, 15 Aug 2019 14:04:17 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:2aa9])
        by smtp.gmail.com with ESMTPSA id i124sm4073230pfe.61.2019.08.15.14.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:04:17 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [RFC PATCH 0/5] Btrfs: add interface for writing compressed extent directly
Date:   Thu, 15 Aug 2019 14:04:01 -0700
Message-Id: <cover.1565900769.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hello,

This series adds a way to write compressed data directly to Btrfs. The
intended use case is making send/receive on compressed file systems more
efficient; however, the interface is general enough that it could be
used in other scenarios. Patch 5 is the main change; see that for more
details.

Patches 1-3 are small fixes/cleanups that I ran into while implementing
this; they should go in regardless of the remainder of the series. Patch
4 exports a required VFS interface.

An example program and test case are available at [1].

To preemptively address a few concerns:

- Writing arbitrary, untrusted data which we feed to the decompression
  algorithm can be a security risk. For that reason, the ioctl is
  restricted to CAP_SYS_ADMIN. The Btrfs code is properly hardened
  against invalid compressed data/incorrect lengths, and the compression
  libraries are mature, but better safe than sorry for now.
- If the user is writing their own compressed data rather than just
  blindly feeding in something from btrfs send, they need to know some
  implementation details about the compression format. For zlib, there
  are no special requirements. For zstd, a non-default compression
  parameter must be used. For lzo, we have our own wrapper format since
  lzo doesn't have a standard wrapper format. It feels a little wrong to
  expose these details, but they are part of the on-disk format, so they
  must be stable regardless.
- The permissions checks duplicated from the VFS code are fairly
  minimal.

This series is based on misc-next.

This is an RFC, so please, comment away.

Thanks!

1: https://github.com/osandov/xfstests/tree/btrfs-compressed-write

Omar Sandoval (5):
  Btrfs: use correct count in btrfs_file_write_iter()
  Btrfs: treat RWF_{,D}SYNC writes as sync for CRCs
  Btrfs: stop clearing EXTENT_DIRTY in inode I/O tree
  fs: export rw_verify_area()
  Btrfs: add ioctl for directly writing compressed data

 fs/btrfs/compression.c       |   6 +-
 fs/btrfs/compression.h       |  14 +--
 fs/btrfs/ctree.h             |  12 ++
 fs/btrfs/extent_io.c         |   6 +-
 fs/btrfs/file.c              |  22 ++--
 fs/btrfs/free-space-cache.c  |   9 +-
 fs/btrfs/inode.c             | 232 +++++++++++++++++++++++++++++++----
 fs/btrfs/ioctl.c             | 101 ++++++++++++++-
 fs/btrfs/tests/inode-tests.c |  12 +-
 fs/internal.h                |   5 -
 fs/read_write.c              |   1 +
 include/linux/fs.h           |   1 +
 include/uapi/linux/btrfs.h   |  63 ++++++++++
 13 files changed, 415 insertions(+), 69 deletions(-)

-- 
2.17.1

