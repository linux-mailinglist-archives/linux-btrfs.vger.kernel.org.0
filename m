Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF316FB4BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjEHQIv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjEHQIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8E658C
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hSxFG7KbS5+bUhMU5o5AHbwxV3oNdUKEI09g2VXXyLQ=; b=NHrmZNLEcj/wdH6qoC4wzl7Xvw
        wVxQYaqxI8V83eCD6I9yJee7YIYB1GtmLchhUcvZ1HyFKmIqlYN5Kr4P8WOaLEwXIWKR9GqWC+5Fs
        EFzXyCLOPdM1BczqEXXsDwAfhfDCUeTiLoZEVrKN+aAMJNaOvINoST+OZ4/5LvEF9agMJdB0+4tD7
        iISM/JB3JaZIUajR4VueCNI266vCsdHEux7hjiux0on1IojNg2+bLq4AYWFGRTg84PICymY+HOl2V
        IOPCTZu053C0SVYQdF2lPkbVkRbBJI0YeDhCUfQ7N+1o+fW085gKWrbGHPB6SPiPNIRv6JVEnGXeb
        o4CrHhnQ==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pn-000vyo-2W;
        Mon, 08 May 2023 16:08:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: add an ordered_extent pointer to struct btrfs_bio
Date:   Mon,  8 May 2023 09:08:22 -0700
Message-Id: <20230508160843.133013-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

this series adds a pointer to the ordered_extent to struct btrfs_bio to
reduce the repeated lookups in the rbtree.  For non-buffered I/Os the
I/O will now never do a lookup of the ordered extent tree (other places
like waiting for I/O still do).  For buffered I/O there is still a lookup
as the writepages code is structured in a way that makes it impossible
to just pass the ordered_extent down.  With some of the work from Goldwyn
this should eventually become possible as well, though.

Note that the first patch from Johannes is included here to avoid a
conflict.  It really should be merged independently and ASAP.

Diffstat:
 fs/btrfs/bio.c               |   87 ++++++++++++-------
 fs/btrfs/bio.h               |   19 +---
 fs/btrfs/compression.c       |   40 +++------
 fs/btrfs/compression.h       |    5 -
 fs/btrfs/extent_io.c         |   29 ++----
 fs/btrfs/file-item.c         |   52 -----------
 fs/btrfs/inode.c             |  128 +++++++++++++++--------------
 fs/btrfs/ordered-data.c      |  188 +++++++++++++++++++++++--------------------
 fs/btrfs/ordered-data.h      |   10 +-
 fs/btrfs/relocation.c        |   35 +++-----
 fs/btrfs/relocation.h        |    2 
 fs/btrfs/zoned.c             |   13 --
 fs/btrfs/zoned.h             |    5 -
 include/trace/events/btrfs.h |   29 ++++++
 14 files changed, 314 insertions(+), 328 deletions(-)
