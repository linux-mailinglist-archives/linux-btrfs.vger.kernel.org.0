Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7FC6B9C59
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCNQ7U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCNQ7T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA79CFE4
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DSlzyXCg+l2oytknQI/vUaXxRd8+c3sP7atoAcWJQ7g=; b=WNpDwcsIoaO4AxrVBFy1PzkY0g
        UQgIlSDuaH7USoTKf50hVMVvpS7mUEPRjYqfai9kQghjVWdng4+CDqhEUeurSs1GrZQvBqJODG4rY
        bA+BSHyUgCpZgSR7csrQ5lktMUA+7iRavDOZ12zyUrxbO3zxv2zuMGW2n1r/UblrLJau+fzY7my9S
        w2PTlQS4s3OSBpTpLYrim/a/zPG1q8n6gjdkKI4RKeRJuV0z62uXS2R7L2ikXXDTaqK1B7N9EyQVM
        hxW4h+XCSLN3EUoLSd7wsK/VxVAe/UdqFUE6QznH4dR6rTmdeOEHLm+TNgbe6uTvvREb75hNsQEgM
        ga7uLe0g==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7zV-00Avl1-1d;
        Tue, 14 Mar 2023 16:59:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: defer all write I/O completions to process context
Date:   Tue, 14 Mar 2023 17:59:00 +0100
Message-Id: <20230314165910.373347-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

based on some of my own projects and Johannes raid-stripe-tree work it has
become a bit painful to drive much of the write I/O completion from the
potential irq context ->bi_end_io handler.  This series follows the steps
that XFS has taken about 10 years ago and defers all the end_io handling
to process contexts using a workqueue, which also allows to remove all
irq locking in btrfs (safe one spot that interacts with the pagecache).

I've run various data and metadata benchmarks, and the only significant
change is that the outliers to the high and low in repeated runs of
metadata heavy workloads seem to reduce while the average remains the
same.  I'm of course also interested in runs of additional workloads or
systems as this is a fairly significant change.

Diffstat:
 async-thread.c   |   17 ++++-------
 bio.c            |   82 ++++++++++++++++++++++++++++++++++++-------------------
 compression.c    |   34 ++++++----------------
 compression.h    |    7 +---
 disk-io.c        |   33 ++++++++++------------
 extent-io-tree.c |   12 ++------
 extent_io.c      |   27 +++++++-----------
 fs.h             |    6 ++--
 inode.c          |   19 +++---------
 ordered-data.c   |   68 ++++++++++++++++-----------------------------
 ordered-data.h   |    2 -
 subpage.c        |   65 +++++++++++++++++--------------------------
 super.c          |    2 -
 tree-log.c       |    4 +-
 14 files changed, 165 insertions(+), 213 deletions(-)
