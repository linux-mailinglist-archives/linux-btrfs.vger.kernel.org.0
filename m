Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201EE71791F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjEaH4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjEaHze (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:55:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A03F1992
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9LnFcU4LadDDHP4/6gASZvAXqD9NcWbm+yDYVLPtrPE=; b=35AxSgsTvvEZYjc9dmnXvMMbO6
        cMUYd18rOFj0hyKU3u8HtUr09YxFIRDgGRhZQclluDXdKkbi3iLQKs454i8jIiDEG+11qqf2g8xCA
        5fIODqXLUnZAzLxjPhh3PoFH2UHySi8atuvzwbon/zi+pQGqo63VTLa6buro99koxW6F4l4tb6Iq1
        5Cqkh/TiuzvLLPXV3xv2DQZ3Ml+/Y3wuWe4T3cku7wnXEFeIgvGIlcIJ8lVvCA+whXpUz+Ju/+Bws
        j8WwwmUNiXi6fzYm22/7Qx/XFhdrbbXiKOZdWdQJbeaYn4nQO4h1wz5bPuNrH+re/qfNX+K/WGVcR
        Fq3rFTdw==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Geq-00GWor-3D;
        Wed, 31 May 2023 07:54:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: add an ordered_extent pointer to struct btrfs_bio v2
Date:   Wed, 31 May 2023 09:53:53 +0200
Message-Id: <20230531075410.480499-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series adds a pointer to the ordered_extent to struct btrfs_bio to
reduce the repeated lookups in the rbtree.  For non-buffered I/Os the
I/O will now never do a lookup of the ordered extent tree (other places
like waiting for I/O still do).  For buffered I/O there is still a lookup
as the writepages code is structured in a way that makes it impossible
to just pass the ordered_extent down.  With some of the work from Goldwyn
this should eventually become possible as well, though.

Changes since v1:
 - rebased to the latest misc-next tree with the changes to not split
   ordered extents for zoned writes
 - rename is_data_bio to is_data_bbio
 - add a new bbio_has_ordered_extent helper

Diffstat:
 fs/btrfs/bio.c               |   61 ++++++++++++---
 fs/btrfs/bio.h               |   12 ---
 fs/btrfs/compression.c       |   40 ++++------
 fs/btrfs/compression.h       |    5 -
 fs/btrfs/extent_io.c         |   28 +++----
 fs/btrfs/file-item.c         |   59 ---------------
 fs/btrfs/inode.c             |  108 ++++++++++++++-------------
 fs/btrfs/ordered-data.c      |  169 +++++++++++++++++++++++--------------------
 fs/btrfs/ordered-data.h      |    7 -
 fs/btrfs/relocation.c        |   36 +++------
 fs/btrfs/relocation.h        |    2 
 include/trace/events/btrfs.h |   29 +++++++
 12 files changed, 278 insertions(+), 278 deletions(-)
