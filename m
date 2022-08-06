Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2651C58B469
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 10:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiHFIDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiHFIDi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 04:03:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D383413DE0
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GJC4Q+mJQUIpRx/HA0j+38zj+4azkMKllT4MqZjoaBg=; b=OsOYHHHAkj3p9zuvhAWBTqZiVg
        yCbkdnQM7+7jY3B9TR/VaLUW/1YPb4XuF+n3C43WavBZgpW1TvFYGW4mwsp8YNpyBCKbRcKoDPVKN
        HmueYrzlQTcfxbZbW+dp/qFItGAjvZWRt5+lmpfVdcMKB9vJHhsv+gu2zZF76HIczZRVXlcbrtgJu
        7BwvU+hVLVcXEPbxcdaS359cc+wo6iFSzxTWRYUPVnqbDJ4KJryNxpkvGyAT8Ak4VfAG2fMPcFr88
        iTvuYcL+ac0S8kW3b8mizwzRM8qpVAneP06+WKDlB0aS463+mTLb50RoFK3b4bfVs7jaBUR7hTkwQ
        7hlhlB4g==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEmS-006LgS-Kn; Sat, 06 Aug 2022 08:03:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: btrfs I/O completion cleanup and single device I/O optimizations v3
Date:   Sat,  6 Aug 2022 10:03:19 +0200
Message-Id: <20220806080330.3823644-1-hch@lst.de>
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
a btrfs_io_context for I/Os that just go to a single device.

Changes since v2:
 - fix a small comment typo

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
