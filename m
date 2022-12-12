Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D264999A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiLLHhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiLLHhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:37:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B364D2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+UvjrCHahRjBa+BIsXqGGmP6pMVicITaS1JcmvRz3eg=; b=vt/YqbzeyOjaijn4kwkAY5KWHs
        fCMC907kaD83zIj7oaGGO83UO0LeKLWg018TvgPWKaNbCHavufJ7iW37uIDqPUMXj/eVp5FxxymLg
        BILk8r53C5x8gLSK6W+SrSiq8vueae5pXGf92pDJ9apWPEnmcmuZFcdWwKffNEnCuz2QeQWMlPyg0
        Pdc/n3UB/K+sv7yu7fft2nw0dNSKI0kj9dSyGtHTtHFfjiEw5VADialq/t5AjzF7KMbqY16UOtHSe
        su7CAUVq9PkCSK785Xc7/seWv6mZq5W+VGTr56WGSF1kEoAO843+Vh5Zhs2E4Hu6tz+SD+7RBq6bc
        NUwV+/hg==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4dNP-009WCK-3f; Mon, 12 Dec 2022 07:37:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: small btrfs-zoned fixlets and optimizations
Date:   Mon, 12 Dec 2022 08:37:17 +0100
Message-Id: <20221212073724.12637-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
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

this fixes a minor correctness issue and adds some minor
optimizations to the btrfs zoned code.

It sits on top of the

  "consolidate btrfs checksumming, repair and bio splitting v2"

series.

Diffstat:
 fs/btrfs/bio.c                    |    2 -
 fs/btrfs/block-group.c            |    9 +-----
 fs/btrfs/block-group.h            |    3 --
 fs/btrfs/extent_io.c              |   10 ++----
 fs/btrfs/inode.c                  |   22 +++++++-------
 fs/btrfs/ordered-data.c           |   10 +++---
 fs/btrfs/ordered-data.h           |    3 --
 fs/btrfs/relocation.c             |    2 -
 fs/btrfs/tests/extent-map-tests.c |    2 -
 fs/btrfs/zoned.c                  |   56 +++++++++++++++++++++-----------------
 fs/btrfs/zoned.h                  |    4 +-
 include/trace/events/btrfs.h      |    2 -
 12 files changed, 61 insertions(+), 64 deletions(-)
