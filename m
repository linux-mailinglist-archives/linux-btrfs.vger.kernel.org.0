Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35486313F4
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Nov 2022 13:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKTMrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Nov 2022 07:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKTMrq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Nov 2022 07:47:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0CD2BC3;
        Sun, 20 Nov 2022 04:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OSHVCyrxQkeV4gAG1qYXat9Mie+lxTI3guPqxQgb2Qw=; b=wCXRUYXWhmDyQR6TNc8Fk6q8PS
        ZVGPlebSHl2PkwGiHUZClQ1b10S1Jt4oGFIRH5IgTvs+fCa2k/VOq77ukY+N7EAVlNVkFk7NtGYww
        +S1zBaZW2HXJqHYFPHP8KfIkQSRD/aIZL3UkXMbGXCXqLQGQ/sENRzUUx+eFHTyX6cZqYJ9gz+qNb
        21hJKd8Q2tZhh10jPN0M/CWz6Xyv9Ho+/rb0I8QAesuETqFQvgVN1QMcuLPXfroxiC+cHgpEsD/Qm
        04I1ZBujqOlki3bMtKL4YZKd3VVge+rBE+c3KnDQ59OdpH8WY+skbamYKa+56LK4fHjKGHYJ2JZri
        xzFy2t3Q==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjjU-004I4U-NT; Sun, 20 Nov 2022 12:47:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: consolidate btrfs checksumming, repair and bio splitting v2
Date:   Sun, 20 Nov 2022 13:47:15 +0100
Message-Id: <20221120124734.18634-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series moves a large amount of duplicate code below btrfs_submit_bio
into what I call the 'storage' layer.  Instead of duplicating code to
checksum, check checksums and repair and split bios in all the caller
of btrfs_submit_bio (buffered I/O, direct I/O, compressed I/O, encoded
I/O), the work is done one in a central place, often more optiomal and
without slight changes in behavior.  Once that is done the upper layers
also don't need to split the bios for extent boundaries, as the storage
layer can do that itself, including splitting the bios for the zone
append limits for zoned I/O.

The split work is inspired by an earlier series from Qu, from which it
also reuses a few patches.

The rebasing against the latest misc-next was a bit painful due to the
various large cleanups, but very little logic changed, so I've kept the
review tags for now, but I'd appreciated another careful round of eyes.

A git tree is also available:

    git://git.infradead.org/users/hch/misc.git btrfs-bio-split

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-split

Changes since v1:
 - rebased to latest btrfs/misc-next
 - added a new patch to remove the fs_info argument to btrfs_submit_bio
 - clean up the repair_one_sector calling convention a bit
 - don't move file_offset for ONE_ORDERED bios in btrfs_split_bio
 - temporarily use btrfs_zoned_get_device in alloc_compressed_bio
 - minor refactoring of some of the checksum helpers
 - split up a few patches
 - drop a few of the blk_status_t to int conversion for now
 - various whitespace fixes

Diffstat:
 block/blk-merge.c         |    3 
 fs/btrfs/bio.c            |  547 ++++++++++++++++++++++++++++++++++++----
 fs/btrfs/bio.h            |   67 +---
 fs/btrfs/btrfs_inode.h    |   22 -
 fs/btrfs/compression.c    |  273 +++-----------------
 fs/btrfs/compression.h    |    3 
 fs/btrfs/disk-io.c        |  199 +-------------
 fs/btrfs/disk-io.h        |   11 
 fs/btrfs/extent-io-tree.h |    1 
 fs/btrfs/extent_io.c      |  554 +++--------------------------------------
 fs/btrfs/extent_io.h      |   31 --
 fs/btrfs/file-item.c      |   74 +----
 fs/btrfs/file-item.h      |    8 
 fs/btrfs/fs.h             |    5 
 fs/btrfs/inode.c          |  621 ++++++----------------------------------------
 fs/btrfs/volumes.c        |  115 ++------
 fs/btrfs/volumes.h        |   18 -
 fs/btrfs/zoned.c          |   85 ++----
 fs/btrfs/zoned.h          |   16 -
 fs/iomap/direct-io.c      |   10 
 include/linux/bio.h       |    4 
 include/linux/iomap.h     |    1 
 22 files changed, 817 insertions(+), 1851 deletions(-)
