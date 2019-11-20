Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C9104349
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 19:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfKTSYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 13:24:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40059 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfKTSYx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 13:24:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so136140pfl.7
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PXD//6WrPBRhsvE5giN/WmOWadViwlcdeow7qHG1Yg=;
        b=i7C9fWefiG45890v92dmtktYJ6XfEqm4kghBTpT8CBm6yzpip1eo5BE9orVOuyKZx1
         EJQaRbLioHg9brDNfxtyjnDCM9ZFWh7uZVVrUg0/Bczm/QAisGztOINIjwWSBQ9oCFlU
         XuUvvHjjaKZd0Omc9HRaw/QBBlKsnP/SwZU044kjeB7UXD0d1hcsQHZA4IuVZiKKPQq4
         Vi3cQfXhijp3xL7EJMkvlx3chEsDGhilSaAcrdfrWgRGrWNvf4Q719vMIBcopdhmPe7n
         DxlLxjakWUrU3ANIZ0dN/dwbf0OILMGp1dSyXHXwKbzGaP5Qej26ZSSozMgSt1DFroGh
         uyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PXD//6WrPBRhsvE5giN/WmOWadViwlcdeow7qHG1Yg=;
        b=eWUP97DX1HkuvYtl8VLAzorn4HWFvr4iBkSCwIMZJY7dVaUfsKI6o4VPrb/dCcz49G
         chPQL1lrlwmjCKIYd4YNFzS7UyFDu20+A5KrLHrWcIz+N7aluz9hSlZOFrAoDocedwf5
         CJqbUck1+pDrkekvIjEA6KiPMoEv9kqdZxlC2l3X8Bo2c7b/dIJcXMBx8Loppl+hOOee
         LqZSdwGnKNfw2mSR/OaGBKUURJnseEU9Nh4I1haXcDwdxtuYticj8kq0ezJpojO43AFu
         HRjb/JPR5s1kc9g/Re1WWftjLHv9RbVqfJdB8axb787uJUwqZ/xv7IhrfztCjf/pzFQB
         6JIQ==
X-Gm-Message-State: APjAAAX4NssRVqBefLLKmgcwwlbTw4UI+SuNShrH6Mv9wszSMOnmMEf8
        niM2wXhNN/X4nlbd7ZhD6KsYroF/IvI=
X-Google-Smtp-Source: APXvYqzVGw0WSTC2BVey7p8UO9YvMhLr0qgDMP8fugz6TLmkavJyl4dsfswEh8eCAuXDnDVMKH9/7A==
X-Received: by 2002:a63:3d8a:: with SMTP id k132mr4934419pga.167.1574274290375;
        Wed, 20 Nov 2019 10:24:50 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:24:49 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 00/12] fs: interface for directly reading/writing compressed data
Date:   Wed, 20 Nov 2019 10:24:20 -0800
Message-Id: <cover.1574273658.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <4d5bf2e4c2a22a6c195c79e0ae09a4475f1f9bdc.1574274173.git.osandov@fb.com>
References: <cover.1574273658.git.osandov@fb.com>
 <4d5bf2e4c2a22a6c195c79e0ae09a4475f1f9bdc.1574274173.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hello,

This series adds an API for reading compressed data on a filesystem
without decompressing it as well as support for writing compressed data
directly to the filesystem. As with the previous submissions, I've
included a man page patch describing the API, and test cases and example
programs are available [1].

This version reworks the VFS interface to be backward and forward
compatible and support for writing inline and bookend extents to the
Btrfs implementation.

Patches 1-3 add the VFS support. Patches 4-7 are Btrfs cleanups
necessary for the encoded I/O support that can go in independently of
this series. Patches 8-10 are Btrfs prep patches. Patch 11 adds Btrfs
encoded read support and patch 12 adds Btrfs encoded write support.

A few TODOs remain:

- Once we've settled on the interface, I'll add RWF_ENCODED support to
  fsstress and friends and send up the xfstests patches in [1].
- btrfs_encoded_read() still doesn't implement repair.

Changes from v2 [2]:

- Rebase on v5.4-rc8
- Add patch 1 introducing copy_struct_from_iter() as suggested by Aleksa
- Rename O_ENCODED to O_ALLOW_ENCODED as suggested by Amir
- Add arch-specific definitions of O_ALLOW_ENCODED for alpha, parisc,
  and sparc
- Rework the VFS interface to be backward and forward compatible
- Document the VFS interface as requested by Dave
- Use __aligned_u64 for struct encoded_iov as noted by Aleksa
- Fix len/unencoded_len mixup in mm/filemap.c as noted by Nikolay
- Add support for writing inline and bookend extents to Btrfs
- Use ENOBUFS for "buffers not big enough for encoded extent" case and
  E2BIG for "encoded_iov has unsupported fields" case

Please share any comments on the API or implementation. Thanks!

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://lore.kernel.org/linux-btrfs/cover.1571164762.git.osandov@fb.com/

Omar Sandoval (12):
  iov_iter: add copy_struct_from_iter()
  fs: add O_ALLOW_ENCODED open flag
  fs: add RWF_ENCODED for reading/writing compressed data
  btrfs: get rid of trivial __btrfs_lookup_bio_sums() wrappers
  btrfs: don't advance offset for compressed bios in
    btrfs_csum_one_bio()
  btrfs: remove dead snapshot-aware defrag code
  btrfs: make btrfs_ordered_extent naming consistent with
    btrfs_file_extent_item
  btrfs: add ram_bytes and offset to btrfs_ordered_extent
  btrfs: support different disk extent size for delalloc
  btrfs: optionally extend i_size in cow_file_range_inline()
  btrfs: implement RWF_ENCODED reads
  btrfs: implement RWF_ENCODED writes

 Documentation/filesystems/encoded_io.rst |   79 +
 Documentation/filesystems/index.rst      |    1 +
 arch/alpha/include/uapi/asm/fcntl.h      |    1 +
 arch/parisc/include/uapi/asm/fcntl.h     |    1 +
 arch/sparc/include/uapi/asm/fcntl.h      |    1 +
 fs/btrfs/compression.c                   |   15 +-
 fs/btrfs/compression.h                   |    5 +-
 fs/btrfs/ctree.h                         |   13 +-
 fs/btrfs/delalloc-space.c                |   38 +-
 fs/btrfs/delalloc-space.h                |    4 +-
 fs/btrfs/file-item.c                     |   54 +-
 fs/btrfs/file.c                          |   61 +-
 fs/btrfs/inode.c                         | 2463 +++++++++++-----------
 fs/btrfs/ordered-data.c                  |  106 +-
 fs/btrfs/ordered-data.h                  |   28 +-
 fs/btrfs/relocation.c                    |    9 +-
 fs/fcntl.c                               |   10 +-
 fs/namei.c                               |    4 +
 include/linux/fcntl.h                    |    2 +-
 include/linux/fs.h                       |   16 +
 include/linux/uio.h                      |    2 +
 include/trace/events/btrfs.h             |    6 +-
 include/uapi/asm-generic/fcntl.h         |    4 +
 include/uapi/linux/fs.h                  |   33 +-
 lib/iov_iter.c                           |   82 +
 mm/filemap.c                             |  165 +-
 26 files changed, 1807 insertions(+), 1396 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst

-- 
2.24.0

