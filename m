Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03DF52A53E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349280AbiEQOvX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349294AbiEQOuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:50:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031685FB7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1HjzfEAbQIsZM9ETJ78XOFTAq7JrHDRhyhQDHrXwL9Y=; b=RJAdw3+aAC1qoJxKkzRss5qmfr
        Qaek0LamR1+YxGGrPBdZJjWpYbA9yyQJjboZfdcTc/h7N1D/mfCn2g5GGrD2RsZSujKSbqoDZNcbQ
        wPLi4/orZ2lT1P5p0+riHH40b4Ri2u5QgTEP9glfT7Voiq/ZXb6OwvcDReQXqtJoKnDz09QobHo6d
        KjRha87JjcnieQ7NewaP4Qal58piGoLYNZKO54zIi0Urj+eHsDXXp0ieN0U72+PA6kDP0roZvtGxs
        9jJ5T1cZDAeYIaa5ldjucnMavvvWuniO7G47/GVC14Dg075n2WrTxa+YLh3d2pN350UKms/eFvJ2v
        yTMrO58Q==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyX5-00EX9o-Pr; Tue, 17 May 2022 14:50:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: simple synchronous read repair
Date:   Tue, 17 May 2022 16:50:24 +0200
Message-Id: <20220517145039.3202184-1-hch@lst.de>
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

this is my take on the read repair code.  It borrow a lot of concepts
and patches from Qu's attempt.  The big difference is that it does away
with multiple in-flight repair bios, but instead just does one at a
time, but tries to make it as big as possible.

My aim here is mostly to fix up the messy I/O completions for the
direct I/O path, that make further bio optimizations rather annoying,
but it also gives better I/O patterns for repair (although I'm not sure
anyone cares) and removes a fair chunk of code.

Git tree:

   git://git.infradead.org/users/hch/misc.git read_repair

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/read_repair

Diffstat:
 fs/btrfs/Makefile            |    2 
 fs/btrfs/btrfs_inode.h       |    5 
 fs/btrfs/compression.c       |   13 
 fs/btrfs/ctree.h             |    9 
 fs/btrfs/extent-io-tree.h    |   15 -
 fs/btrfs/extent_io.c         |  597 ++++++++-----------------------------------
 fs/btrfs/extent_io.h         |   27 -
 fs/btrfs/inode.c             |  138 +++------
 fs/btrfs/read-repair.c       |  211 +++++++++++++++
 fs/btrfs/read-repair.h       |   33 ++
 fs/btrfs/super.c             |    9 
 fs/btrfs/volumes.c           |   27 +
 fs/btrfs/volumes.h           |   14 +
 include/trace/events/btrfs.h |    1 
 14 files changed, 480 insertions(+), 621 deletions(-)
