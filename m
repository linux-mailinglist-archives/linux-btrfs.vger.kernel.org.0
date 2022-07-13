Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7A572DFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiGMGOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiGMGOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:14:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA1B5D3F
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DnjHfYAYTotEJPAMO21k9b9bhX3estu0kyHVSHX9VyM=; b=hbIcu3xzNHK4euks3t1J9Xmnnz
        3vHZPPoZRLlZRd5xBXBTkGV/WfJ9TXVE9M74n2jVRwTbRyLQI0Bjy3fwntP+ISGUJdgi3zvE9NPLW
        XWJAHoY3XKDCZXCB/aUqtIKCn0JSuwjENiQLvwktXztUPnM+sZ/jILsCGgqKeAXkjipJlkE4NDnWQ
        JSiIW5qjZSjG8GyUo54GnmfcX7k0NZ3wuB+SFxqrlMlxP+E2Cor3drIhhkQ8wWXrKobIeKjlzNWAm
        8ZYPJs7JXIU7oCter+mMXhge/kTywUqk39tT+JojS+PVk5mssRcfnYBXt+xw/oC4WpGUrfoGtRCsT
        1LJhVgcQ==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVdJ-000T0S-W2; Wed, 13 Jul 2022 06:14:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: btrfs I/O completion cleanup and single device I/O optimizations v2
Date:   Wed, 13 Jul 2022 08:13:48 +0200
Message-Id: <20220713061359.1980118-1-hch@lst.de>
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

This series sits on top of the for-next tree that has the "fix read
repair on compressed extents v2" series included.  To make everyones life
easier a git tree is also available:

    git://git.infradead.org/users/hch/misc.git btrfs-bio-api-cleanup

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-api-cleanup

Note that I've picked up the reviews and tested tags from the last
posting for the patches that are relatively unchainged or just split,
so they might appear a little inconsistent.

Changes since v1:
 - add two previously submitted patches skipped from an earlier
   series
 - merged one of those patches with one from this series
 - split one of the patches in this series into three
 - improve various commit logs

Diffstat:
 compression.c    |   43 ++-----
 ctree.h          |    1 
 dev-replace.c    |    5 
 disk-io.c        |   16 +-
 extent-io-tree.h |    4 
 extent_io.c      |  117 +++----------------
 extent_io.h      |    3 
 inode.c          |   57 ++++-----
 raid56.c         |   45 +------
 raid56.h         |    4 
 scrub.c          |    7 -
 super.c          |    6 
 volumes.c        |  337 ++++++++++++++++++++++++++++++++++++++-----------------
 volumes.h        |   20 ++-
 14 files changed, 340 insertions(+), 325 deletions(-)
