Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F66B8B0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCNGRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCNGRI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B269B7A90A
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IvA9ri6q2JfX1qveleIGcPZzK5wBY/znCNce3ZztAOQ=; b=c9kP7JWnwDhRlH8nFUEVsfH/e2
        OPJl5lgFeA4qHTrlFvJZEhAqyopCv4BNOn3mY5+ZSsNzgPWTNrmv+N8izj3iU4WtuT2zQGpJa7Uxf
        7qjeoAjPhwXd+u1T+vNYbtHGx3RlnRYNwGxdEeL7W1M3coxMySPCqFoSQBn1dlOckcRStkPUg6V5X
        0HxrXlAFIDezXnJ2tsU0n9J9Gu6qKBV7Gs39QRae/syU1Zy4jdgQmhZlsy2D2FGSsMGv/zyXYPCez
        t+tGJCb4tcZNPRlPCTbYEeR+Q52s/5c8Vzt7G34QapSdvk/eMaL8wtwd2m90ZqcwGCZxDbpDv+bxe
        n0YGg29g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxy0-009AfL-EP; Tue, 14 Mar 2023 06:17:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: simplify extent_buffer reading and writing v2
Date:   Tue, 14 Mar 2023 07:16:34 +0100
Message-Id: <20230314061655.245340-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

currently reading and writing of extent_buffers is very complicated as it
tries to work in a page oriented way.  Switch as much as possible to work
based on the extent_buffer object to simplify the code.

I suspect in the long run switching to dedicated object based writeback
and reclaim similar to the XFS buffer cache would be a good idea, but as
that involves pretty big behavior changes that's better left for a
separate series.

Changes since v1:
 - fix a pre-existing bug clearing the uptodate bit for subpage eb
   write errors
 - clean up extent_buffer_write_end_io a bit more

Diffstat:
 compression.c |    4 
 compression.h |    2 
 disk-io.c     |  276 +++-----------------------
 disk-io.h     |    5 
 extent_io.c   |  605 ++++++++++++++--------------------------------------------
 extent_io.h   |    3 
 6 files changed, 197 insertions(+), 698 deletions(-)
