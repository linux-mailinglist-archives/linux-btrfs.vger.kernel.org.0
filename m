Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9C3D1F5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 09:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhGVHOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhGVHOF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:14:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C98C061575;
        Thu, 22 Jul 2021 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nl3M9fyQJINeLUMF6gJtfDfOMcTb90OeAzKs5tU5Z40=; b=U0i+II9WbcZDBaMju7p9mNBcjU
        hrIn1ChgqJtx9lJdLSxpIzvQJaaP2IYb7K4D+Cz9YMoChhb6SHL9TqCc/HeCf36sVfKmEZSqRZl4I
        EQC8JxGDc0FeOWat+cVuGqaLtaCDP3fzlaQ+h53/09goYqzPqLgyZ7qc9BQqqGbQg8ft/ZZXNBLkm
        yRXf2u43z8A4ucv2yMxEEg26GrfNOyVcL0mPq8dbPyqJeW5brldaGAK898XIvNMRmu/G+nbzlyn2r
        RBTuuVoSkRAMLY1m3CbhpGTdGXVRU62hkh/F0XHESamA6o9iBVxejkEGF19y8j5zZVFQZgn9DzOpb
        2xEs6XOQ==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6TWt-00A1Dm-RB; Thu, 22 Jul 2021 07:54:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: fixes and cleanups for block_device refcounting v2
Date:   Thu, 22 Jul 2021 09:53:53 +0200
Message-Id: <20210722075402.983367-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Jens,

this series fixes up a possible race with the block_device lookup
changes, and the finishes off the conversion to stop using the inode
refcount for block devices.

Changes since v1:
 - clean up btrfs even more by storing a bdev instead of the disk
 - keep a persistent disk reference in the bdev
 - a bunch of cleanups to make the above change easier

Diffstat:
 block/genhd.c           |   12 +-----
 block/partitions/core.c |   34 ++++++++++---------
 drivers/block/loop.c    |    5 --
 fs/block_dev.c          |   83 ++++++++++++++----------------------------------
 fs/btrfs/inode.c        |    2 -
 fs/btrfs/ordered-data.c |    2 -
 fs/btrfs/ordered-data.h |    3 -
 fs/btrfs/zoned.c        |   12 ++----
 include/linux/blkdev.h  |    2 -
 9 files changed, 52 insertions(+), 103 deletions(-)
