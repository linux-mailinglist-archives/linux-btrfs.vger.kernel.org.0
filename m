Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB555572B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 07:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiFWFxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 01:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiFWFxq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 01:53:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA95B40E77
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 22:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9PHgFSPfGNW2Vx6iLDvDn1zrE1XulvlHDNBWiktgZRg=; b=QZFsnt94j58juh5WGMvC36aybJ
        X4w6La0iSHvqU5t9DVnlnD6+kK5LHdLsaKqvvV8kAEnYnXxZ2hAARcs/4zs9InMJhkffouhylEGJr
        njGhNtDPL4wLdmCehocxXFh0RZ4Js+RtCzXipSSvyxUC/YbXRFV7kD4DcR+LCvwLnP8LKcnfwyA5j
        oIhH05befxxhflVEI+PQ0l4+QHlccGqY4NLwm0oQAjwDwJZArrwtzVFZBrKrz5hQ1icnJKIsv7qd6
        tvdDc6AzzxLsr9RvS3LWVPZK8VbN3iga8ZLc1CnQr+Vqij2olsZhhdol1GjfCP2KySjPH5A/x8i5F
        gPFnJdtw==;
Received: from [2001:4bb8:189:7251:96bf:4177:9572:1a29] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Fme-00DY6x-6H; Thu, 23 Jun 2022 05:53:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: fix read repair on compressed extents
Date:   Thu, 23 Jun 2022 07:53:34 +0200
Message-Id: <20220623055338.3833616-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

while looking into the repair code I found that read repair of compressed
extents is current fundamentally broken, in that repair tries to write
the uncompressed data into a corrupted extent during a repair.  This is
demonstrated by the "btrfs: test read repair on a corrupted compressed
extent" test submitted to xfstests.

This series fixes that, but is a bit invaside as it requires both
refactoring of the compression code and changes to the repair code to
not look up the logic address on every repair attempt.  On the plus
side it removes a whole lot of code.

It is based on the for-next branch plus my "btrfs: repair all known bad
mirrors" patch.

Diffstat:
 compression.c |  287 ++++++++++++++++------------------------------------------
 compression.h |   11 --
 ctree.h       |    4 
 extent_io.c   |   93 +++++++-----------
 extent_io.h   |    9 -
 inode.c       |   34 +++---
 6 files changed, 148 insertions(+), 290 deletions(-)
