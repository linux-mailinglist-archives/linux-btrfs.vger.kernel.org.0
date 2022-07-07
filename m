Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7D5699E1
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiGGFdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiGGFdk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521492AC54
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Xj8YaDAMGyJ1PZxDGjV3hyhZBx4iR2xWYe4m15YS6h4=; b=blyPIuWD838Uo9Rs/i6Xd3G/AT
        Qfcje1kZp03HjX+WTphiywuQ1WXInx1YUECNePJUgPCyXZjkvZdZtoZoTq0UAer6hrX1dR7hT7ns3
        uCwaG3UZk4LGJxU5/CmHrX6SzLoR6LPNgq/0PuP5ImcvoyvbD40ZrtmVpqnJXYa3yhmXpR5OzVSWS
        CBqCLhw/O/qHx8cSiANXiAbiguQ1yDN0eVxluN+PpPDdw2gt3q8tZH1fmn+l2RZYsqjJ18VdnGkC5
        eoJAqd6esJtEkCckj3R1jRDWzqH1LUj83bz4R1AQQXR770uXZNj6iY1ZwR58+L6gMhO3eSCl6IN62
        KbqK0ZIw==;
Received: from [2001:4bb8:189:3c4a:8caf:7f2b:dda6:253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9K8s-00DlWf-Ud; Thu, 07 Jul 2022 05:33:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: fix read repair on compressed extents v3
Date:   Thu,  7 Jul 2022 07:33:25 +0200
Message-Id: <20220707053331.211259-1-hch@lst.de>
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

while looking into the repair code I found that read repair of compressed
extents is current fundamentally broken, in that repair tries to write
the uncompressed data into a corrupted extent during a repair.  This is
demonstrated by the "btrfs: test read repair on a corrupted compressed
extent" test submitted to xfstests.

This series fixes that, but is a bit invaside as it requires both
refactoring of the compression code and changes to the repair code to
not look up the logic address on every repair attempt.  On the plus
side it removes a whole lot of code.

The series is on top of the for-next branch, as that includes other
bio changes not in misc-next yet.

Changes since v2:
 - include the previous submitted and reviewed repair all mirrors patch
   to simplify the stack of patches
 - include an additional cleanup patch at the end
 - improve a commit log
 
Changes since v1:
 - describe the partial revert that happens in patch 1 better in the
   commit log
 - drop a now incorrect comment
 - do not add a prototype for a non-existent function

Diffstat:
 compression.c |  287 ++++++++++++++++------------------------------------------
 compression.h |   11 --
 ctree.h       |    2 
 extent_io.c   |   93 +++++++-----------
 extent_io.h   |    9 -
 inode.c       |   34 +++---
 volumes.h     |    2 
 7 files changed, 146 insertions(+), 292 deletions(-)
 compression.c |  311 ++++++++++++++++------------------------------------------
 compression.h |   11 --
 ctree.h       |    4 
 extent_io.c   |  202 ++++++++++++++++---------------------
 extent_io.h   |   10 -
 inode.c       |   39 +++----
 6 files changed, 203 insertions(+), 374 deletions(-)
