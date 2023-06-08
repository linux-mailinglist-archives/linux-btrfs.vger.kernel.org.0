Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90C727FB2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjFHMOU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHMOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:14:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76552136
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1l2z/jrGAvmbSgK62MSuZbAjdCeLxWzpvkonct7bDmo=; b=Ohp7s+YptyRBmkFZH246Nccnr/
        E5cFr/Z3HF+8ATYr1cKzyZea7BxnvWODVu4bMO75Z6IJIrHxPW52C3ofmRTinPDP2NEzD1ZnTVTuP
        7durTisjpxF7ZUCOc439f0IuQnT5i6A7zB8Iski7uIkVnq5fxJKd9eJil1CsENnNR/xgqGMMVeWqu
        WKQiG0KoWXKqfNb757plZVZB5/w2eXCVHlLzhuL1z2W5o1tMzXPDzSiMWm+YDLc2I7ANqYVX6A21o
        4sERHXNdJNPXE6IMcjdVuQYxCgOvmBSI1k6LjpEOErAt1hY2BdZcHhwBVit47mNyynHjQq9lU0QEW
        hG0uBT/g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7EWs-009HB1-0f;
        Thu, 08 Jun 2023 12:14:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: fix nodatasum I/O for zone devices v2
Date:   Thu,  8 Jun 2023 14:14:09 +0200
Message-Id: <20230608121410.275766-1-hch@lst.de>
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

my recent series to optimize the ordered_extent splitting for zoned
devices broke nodatasum I/O - this was hidden by the fact that a normal
xfstests run appears to only exercise nodatasum in combination with
dev-replace, which was also broken..

Changes since v1:
 - drop the btrfs_inode_is_nodatasum helper
 - add a new helper to just allocate a dummy ordered_sum structure
 - more comments
