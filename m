Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C05302BF
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 13:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245448AbiEVLsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiEVLsD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 07:48:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597215FF2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+C2VjhVw1m5ED9+3TvbLKFFIjzUqL0Hg1egmvKR9Lyo=; b=jcdi/BuAbxSGfSbrQ2ByetonG6
        p8QaJIb+wvyMMB/cK408qceMX0cS6GDGMAekEBGsQ5RBu4WxE7D5PRXoQ3HinP6Cq6znrfbNOFABQ
        aua50TDRO9JetxPvzDT/X4Fa5UnoERhlxdt4dYCLkpAUjzuKfY8nqpucEWB5guZDgYsAdbKa1AS4E
        nsnXP4uReRQF0/XTTZapaNMqaCVNE+IpdfXdXUVOdY0ugb19i+oiX/pAwXTMvA0/95yIjtbGyeH6i
        Cdxz/PAePqpDYqReajaWXUBovoIMrogvVXcmHrK1H+f3TA+htZjJSABftZFOvFhYbQkkJPIs1/iis
        A3tnXaUg==;
Received: from [2001:4bb8:19a:6dab:76a3:f7ab:4f04:784a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsk3x-001E0z-Bo; Sun, 22 May 2022 11:47:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: misc btrfs cleanups
Date:   Sun, 22 May 2022 13:47:46 +0200
Message-Id: <20220522114754.173685-1-hch@lst.de>
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

this series has a bunch of random cleanups and factored out helpers split
from the read repair series.

Diffstat:
 compression.c |   13 +----
 ctree.h       |   10 ++++
 extent_io.c   |  137 +++++++++++++++++++++++++++-------------------------------
 inode.c       |  107 ++++++++++++++++++++++-----------------------
 volumes.c     |    6 ++
 volumes.h     |   12 +++++
 6 files changed, 150 insertions(+), 135 deletions(-)
