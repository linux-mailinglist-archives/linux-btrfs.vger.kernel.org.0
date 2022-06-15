Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2A454CC62
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347987AbiFOPPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244854AbiFOPPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 11:15:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4C3A711
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=M3pe7rSmIwyTNsuVVF61xprnWi4KFOm8g69IT92Siac=; b=DqBZ9MNzWIu6Fqnl5URBy99L9U
        FKjA6gzf3KSaj2yiMx9SPw23TzZytstH1rAVoxEikis+yo4TG06VfXTru4y8vT99AziUIBmWpDqwS
        2MD9dqfm5Lullo87t9WTRoUNJWyeU0EBUS9z0aTw7DlyeG26Q1rAZQGwiJ7rJcHl7MXBp4VBNXvCe
        0//xNVmGaWUwziQguXYXyjiSeMhuewh/0EdXiLdQVNKd08A5HKN5PWcMzNs9PtCSBajZSiWYRXttO
        9FPJelMnRzbn58hhWdkS17r6NvBpo/s7spVdD6dCi9IwpEhoWSarHR5hszk+NrGFhOqpb279Ed7s3
        EHXgR/RA==;
Received: from [2001:4bb8:180:36f6:5ab4:8a8:5e48:3d75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Ujm-00F8qj-Tb; Wed, 15 Jun 2022 15:15:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup btrfs bio submission
Date:   Wed, 15 Jun 2022 17:15:10 +0200
Message-Id: <20220615151515.888424-1-hch@lst.de>
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

this series removes a bunch of pointlessly passed arguments in the
raid56 code and then cleans up the btrfs_bio submission to always
return errors through the end I/O handler.

Diffstat:
 compression.c |    8 ---
 disk-io.c     |   21 ++++----
 inode.c       |   25 ++++------
 raid56.c      |  108 +++++++++++++++++++++------------------------
 raid56.h      |   14 ++---
 scrub.c       |   19 ++-----
 volumes.c     |  138 ++++++++++++++++++++++++++++------------------------------
 volumes.h     |    5 --
 8 files changed, 154 insertions(+), 184 deletions(-)
