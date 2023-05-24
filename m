Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6233B70F9A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjEXPDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjEXPDi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F6132
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=W+4+t5smRUpwMnPJ7sXMAxOidowB5dzlaPuTBYysVJ8=; b=IATlzW1jzpy3vBlfIZ86GtHfAY
        swwhQnwC/SUUNyTC6n035e1dx5j5qgajcucsDayMWw3npmK92LR865mjpBKZUdoINDC6BqeGFO8eU
        VCPEC5L6Xa7G149ApKgWKuAQb/AlxJUHcaVxBTPzT6+UI1BJoRO9e/tJXKHW7n2p/lTBsoMrSMLbE
        ZDY/qzvwgVbBGRUzb9AkMmPtDNtOrQjr1Xy6H7e5UOioYEfBTrGHG06qhKd6dmlWiVOIVrPsbHjRR
        11iCi+DHLALpfDcOFspMz3iTlrMr9zoomL8ybwALObf9+eMJOW/Aardg58CvrYreNtW8jeX5ExQkW
        UiILaAxQ==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1J-00DmZt-0h;
        Wed, 24 May 2023 15:03:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: don't split ordered_extents for zoned writes at I/O submission time
Date:   Wed, 24 May 2023 17:03:03 +0200
Message-Id: <20230524150317.1767981-1-hch@lst.de>
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

this series removes the unconditional splitting of ordered extents for
zoned writes at I/O submission time, and instead splits them only when
actually needed in the I/O completion handler.

This something I've been wanting to do for a while as it is a lot more
efficient, but it is also really needed to make the ordered_extent
pointer in the btrfs_bio work for zoned file systems, which made it a bit
more urgent.  This series also borrow two patches from the series that
adds the ordered_extent pointer to the btrfs_bio.

Currently due to the submission time splitting, there is one extra lookup
in both the ordered extent tree and inode extent tree for each bio
submission, and extra ordered extent lookup in the bio completion
handler, and two extent tree lookups per bio / split ordered extent in
the ordered extent completion handler.  With this series this is reduced
to a single inode extent tree lookup for the best case, with an extra
inode extent tree and ordered extent lookup when a split actually needs
to occur due to reordering inside an ordered_extent.

Diffstat:
 bio.c          |   20 -----
 bio.h          |   17 +++-
 btrfs_inode.h  |    2 
 extent_map.c   |  101 ++++++++++++++++++++++++++--
 extent_map.h   |    6 -
 file-item.c    |   15 +++-
 fs.h           |    2 
 inode.c        |  138 +++++++-------------------------------
 ordered-data.c |  205 +++++++++++++++++++++++++++++++++++----------------------
 ordered-data.h |   22 ++----
 relocation.c   |    4 -
 tree-log.c     |   12 +--
 zoned.c        |   94 ++++++++++++++------------
 zoned.h        |    6 -
 14 files changed, 352 insertions(+), 292 deletions(-)
