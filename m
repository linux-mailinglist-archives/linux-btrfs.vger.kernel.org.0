Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB73519F3E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349402AbiEDM3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349531AbiEDM3F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:29:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340CD2649
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KwyOluDkHAMMhRaqtrqT3q8d60iuysQea/fxqI2YUI4=; b=QfuFvZBNu6SA0nqP3oYOd3WUBg
        ngFYklwMuTBytez2Dhh/LGyN4MS9HGtSUVTh8s6A5LqaiIrVTMdAnLm/BsUyfwDDGJ/cgOQMBjLtf
        QOqcMfv82l3hd4wxwrtwwkruYxtS51K/MH5zM9oIF1e4UjNrga4UfYp9n7doxPkssMBdJsO9xAu31
        j+PtmFlmIiRdeCCHK9wrRX9GxcQ4dP2XYb7PFCk2Y9s8EH5304uSMB6c8jXBgdzmaZsjf5V+4OJRB
        UvCKFyLQW7V0Vww21hnco2w9nFNDi1ERb1ifEgDqHZ9aI1HHk5omJ7G8BZc50ambXxnS7dcEIPRpp
        2sr/6lNg==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmE4L-00Ahlu-2z; Wed, 04 May 2022 12:25:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup btrfs bio handling, part 2 v3
Date:   Wed,  4 May 2022 05:25:14 -0700
Message-Id: <20220504122524.558088-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v2:
 - rebased to the latests misc-next tree
 - fixed an incorrectly assigned bi_end_io handler in the raid56 code

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
 extent_io.c   |   35 ++++-------
 extent_io.h   |    1 
 inode.c       |  162 +++++++++++++++++++--------------------------------
 raid56.c      |  109 +++++++++++++---------------------
 super.c       |   13 ----
 volumes.c     |  184 +++++++++++++++++++++++++++-------------------------------
 volumes.h     |    8 ++
 12 files changed, 262 insertions(+), 471 deletions(-)
