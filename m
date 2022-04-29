Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B876514CFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377370AbiD2OeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377410AbiD2OeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:34:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21889F7A
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OwEQ0Ke45seOE+EHALp3Lfop7ruVd5lgEAvQlWDtyiQ=; b=Kca3tArW9fIMNEM2m1dqNKtAd1
        bHoUuAji6ti71ryStKdp/6WkjhHnedXReGWwKTHdXEOIID9qkjF7wuCXEhSq6Ww8CU68lzehl2bEu
        Fmrq3x86ctP6nZUt6cxae+f+J50iUMWjiHk85sBfe1ISFrWjLLsT2OHuS7tZ12Z6zq4IiysJ/w/2k
        Lb8aOdlPFIjV/i5vercNLyi4W/RtIj1qSpxLfihqgInuAhRSfWqDqtPNH4US85XuyxBb5bvVjGR76
        lsU6IOuC6+A1Dbv+cE7zXdknYo5qeN0j0wPuKgNRQr7x/vgPaddJ1FYM36ggDCZstuZkKifKdglmN
        Mofr9XZg==;
Received: from [2607:fb90:27d7:71af:6ca1:91e8:bf19:edd2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkRdp-00Baij-Oo; Fri, 29 Apr 2022 14:30:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup btrfs bio handling, part 2 v2
Date:   Fri, 29 Apr 2022 07:30:30 -0700
Message-Id: <20220429143040.106889-1-hch@lst.de>
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

this series removes the need to allocate a separate object for I/O
completions for all read and some write I/Os, and reduced the memory
usage of the low-level bios cloned by btrfs_map_bio by using plain bios
instead of the much larger btrfs_bio.

Changes since v1:
 - rebased to the latests misc-next tree
 - don't call destroy_workqueue on NULL workqueues
 - drop a marginal and slightly controversial cleanup to btrfs_map_bio

Diffstat:
 compression.c |   41 +++++-------
 compression.h |    7 +-
 ctree.h       |   14 ++--
 disk-io.c     |  148 +++++-----------------------------------------
 disk-io.h     |   11 ---
 extent_io.c   |   33 +++-------
 extent_io.h   |    1 
 inode.c       |  162 +++++++++++++++++++--------------------------------
 raid56.c      |  111 +++++++++++++---------------------
 super.c       |   13 ----
 volumes.c     |  184 +++++++++++++++++++++++++++-------------------------------
 volumes.h     |    8 ++
 12 files changed, 262 insertions(+), 471 deletions(-)
