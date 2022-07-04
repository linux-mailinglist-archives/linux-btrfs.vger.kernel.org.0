Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA13564FF0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiGDIoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiGDIoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:44:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B695F6C
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ASAeDGbbRvWrYVTOth1hiAFaBmMoxniN8D79CW6DMqQ=; b=nouExwatJAPCIEngVoST1Yc992
        P7uJHI1FOZtIrO51PQ5CyYswdmxSu05J6KaP2Wl45oVSdU/o2SY826h3/0z9JYRBfHmgY8LosrYVY
        UcT1Lzc8kCc8jqEoQF1W464+TH0YQb49Gov2z1WXYkwSlqdUTPcs+3QfwQ+5dB52LsSfLpMUHq8ri
        kq0jYdt65uFwvOm8MXKm3fVX2/mVawHjiQ9klhEdgHkjLP6I/DdNWf6DkRkwu1/mLhM274J80nJqi
        UKwfMcLgYQgh9VMTBU3hhIVPq10d1YzRnfHRS/ce1YLIfC7lcFAY7DNhPwHg++ZTCsHl5dIE+0vCx
        RvCV/zng==;
Received: from [2001:4bb8:189:3c4a:9cc7:69df:e5dc:ef11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hge-0068GV-DC; Mon, 04 Jul 2022 08:44:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: btrfs I/O completion cleanup and single device I/O optimizations
Date:   Mon,  4 Jul 2022 10:43:59 +0200
Message-Id: <20220704084406.106929-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series cleans up the btrfs_bio API, most prominently by splitting
the end_io handler for the highlevel bio from the low-level bio
bi_end_io, which are really confusingly coupled in the current code.
Once that is done it then optimizes the bio submission to not allocate
a btrfs_io_context for I/Os tht just go to a single device.

This series sits on top of the "fix read repair on compressed extents v2"
series submitted.  To make everyones life easier a git tree is also
available:

    git://git.infradead.org/users/hch/misc.git btrfs-bio-api-cleanup

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-api-cleanup

Diffstat:
 compression.c    |   50 +++-----
 disk-io.c        |   16 +-
 extent-io-tree.h |    4 
 extent_io.c      |  117 +++----------------
 extent_io.h      |    3 
 inode.c          |   57 ++++-----
 raid56.c         |   45 +------
 raid56.h         |    4 
 scrub.c          |    7 -
 super.c          |    6 -
 volumes.c        |  330 ++++++++++++++++++++++++++++++++++++++-----------------
 volumes.h        |   19 ++-
 12 files changed, 343 insertions(+), 315 deletions(-)
