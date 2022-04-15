Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585D502BF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbiDOOgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiDOOgF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 10:36:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DEDA94D6
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lE+7XAdmLyM7Qd/LHhEjv+RLKWGwzaAKiN+gL4A3p/4=; b=ZXEaHA86Im2n35r1rOn469K4/R
        xDOYLf+65T1dCgfLaA0wa3Zy13VJNVxXF3WnvXBHx/8bj1Tm5SzRBQ7Qzjry4TJMK1PeS9q/M3NYa
        iTNO+0aq9+1mRvXDKFAV55jR/7EfZyu7d6Ktp2F20xBV+jWwxOd1BsnhZQ2nsloKIxw4tLso8aBSM
        u3Mj5C4xZaaWF1aqmJBNRNTnHt90t2a/VXWxHXTx6GPcITD8CV71xAc+zyM93/zfYeMAkFDxpURJm
        wZqh39jb99pwI5ZuY2jvTFusPPHVBuHsYUfCpfrNg4PZpyD0OyLw5y+k+gSqQlBHazcCpOtryjzQU
        ZPKRcopQ==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfN0t-00AMqe-Dy; Fri, 15 Apr 2022 14:33:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: minor bio submission cleanups
Date:   Fri, 15 Apr 2022 16:33:23 +0200
Message-Id: <20220415143328.349010-1-hch@lst.de>
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

this series cleans up a few loose ends in the btrfs bio submission path.

Diffstat:
 compression.c |   11 +++++------
 compression.h |    4 ++--
 ctree.h       |    5 ++---
 disk-io.c     |   26 ++++++++++----------------
 disk-io.h     |    4 ++--
 extent_io.c   |   39 +++++++++++++++++++++++++++++++++++----
 extent_io.h   |   18 ++----------------
 inode.c       |   49 ++++++++++---------------------------------------
 8 files changed, 68 insertions(+), 88 deletions(-)
