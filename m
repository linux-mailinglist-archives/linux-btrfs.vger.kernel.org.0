Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC7717686
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjEaGFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEaGFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689C911C
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=phMkghrQxTxfVy3yHBj31eexB0hqLGtl2WHyQJF0oyc=; b=rGSe4NxDcD8m2Oo+1j+aJTqfxq
        ppEV9vBzUmuEvI7uTRS47AFSlOA+NpPb4LijUgpKWeq1j68rKPf3LI+ME7u2i9VtA6I644ptoqHWQ
        jPFufHKWIg74Df0ucqP8c2n14WRCLkICKNpe8YM6+CV83UhyJu/x5q7SxhUule5OLazpiAIlFdGUU
        9AWRVZjJEiQJOKltXTEHidlUnwyyIc+ZOiGl+uWKXNMp4S1nkOQjMYfu97apCOx88ozLke4JqcEOU
        smx32QbZtdNjsTmx4Izcdn4hQxicxbjuw4nUY06j4Q2jYK/uwzwXiUdt/L6p2NfjsvQfbGvSK6M8L
        lx64xVUg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4ExJ-00GF21-1g;
        Wed, 31 May 2023 06:05:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: writeback fixlets and tidyups v2
Date:   Wed, 31 May 2023 08:04:49 +0200
Message-Id: <20230531060505.468704-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this little series fixes a few minors bugs found by code inspection in the
writeback code, and then goes on to remove the use of PageError.

This replaces the earlier version in the for-next branch.

Changes:
 - rebased to the latest misc-next tree
 - remove a set but unused variable in pages_processed
 - remove a spurious folio_set_error
 - return bool from btrfs_verify_page
 - update various commit message

Subject:
 compression.c |    2 
 extent_io.c   |  359 +++++++++++++++++++---------------------------------------
 extent_io.h   |    6 
 inode.c       |  180 ++++++++++++-----------------
 subpage.c     |   35 -----
 subpage.h     |   10 -
 6 files changed, 209 insertions(+), 383 deletions(-)
