Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD56AE6E9
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 17:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCGQmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 11:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCGQmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 11:42:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9294740
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 08:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zlla5lOQO99ZBBrzjeZopaCStkXMJP4lmw1XG3zxnvQ=; b=k0wSqlTx1Y4KoWkXrrp1v9ClMZ
        SQhhLFlIH6DIdnr1p8WZUqXJd569lAtKqbkQ3oYLjwdE5EGjmP6o7zb9ngg31RP+HkxXelHOsi3KX
        aJ+guVP7Gj61AHxyfviQI7OPSgUTZT8fMVK+RIdXf8e55+CM+pGaxXpRh8d6pZcTbkk3O8JPuvLyy
        PWO2Z1hhZ1bBkeR98LQH8LCjt6jpyDxVVgV+RuWEzT94jf+/dW/G7Sv836OjngpS6Ci1dVi26afz4
        MyE9s5fzLU+x+3SLm/TczfXjVZv8oWsxdEb1npp/dvx+NVUctzD2YRz8gYGPT5x3eCU2dYUZRJ2Dl
        tVzv5igg==;
Received: from [213.208.157.31] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZaLz-001bJO-UA; Tue, 07 Mar 2023 16:39:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: improve type safety by passing struct btrfs_bio where possible v2
Date:   Tue,  7 Mar 2023 17:39:35 +0100
Message-Id: <20230307163945.31770-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
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

much of the btrfs I/O path work on a struct btrfs_bio but passes pointers
to the bio embedded into that around.  This series improves type safety
by always passing the actual btrfs_bio instead.

Changes since v1:
 - fix commit message and commit typos

Diffstat:
 bio.c         |   53 +++++++++++++++++++++--------------------
 bio.h         |    8 +++---
 compression.c |   33 ++++++++++++++-----------
 compression.h |    4 +--
 extent_io.c   |   74 ++++++++++++++++++++++++++--------------------------------
 inode.c       |   57 ++++++++++++++++++--------------------------
 lzo.c         |   14 +++-------
 zlib.c        |    2 -
 zstd.c        |    1 
 9 files changed, 115 insertions(+), 131 deletions(-)
