Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F883627076
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiKMQY1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 11:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 11:24:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF56251
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YAuDgyi8bHfUTl0/4/aZf2vO/ByfQ8rx6d1AK9TiVcA=; b=Alk/9VDf/+zTjA3qJuiSWSSBhq
        l8cZ+GZLNV8+4PgnfwdWOkfTSWpYj61cDx+2qAeiVrB8vKGQ5sJPSpZwkZ5nsJRj5NUMeDemZ93vw
        hliJ07aZcyGw0T9rdwUSu5F77habEkekVWA8W6cUZyeWxW7hxcepAj1zWeV/dAMMpoe4Gze/0XS+l
        SSYNF+Ucaadh2+oWLWCMGx/XTOF/6x4Z2o+O0M5wy4xUgE6/BaeWw0cHAPaYzqPcogAKczlfCC+OI
        jRDbHqdG3+8wH+yCl36MunUGINSszQa+VaoMyctbYVa2Myk+BMNPc+tCfNBzL9Xspz7cas+euv/H/
        v/uqhQsw==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFmN-00CIZQ-7u; Sun, 13 Nov 2022 16:24:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: move the low-level btrfs_bio code into a separate file v2
Date:   Sun, 13 Nov 2022 17:24:13 +0100
Message-Id: <20221113162416.883652-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this small series creates a new bio.c file (and a bio.h header for it)
to contain all the "storage" layer code below btrfs_submit_bio.  The
amount of code sitting below btrfs_submit_bio will grow a lot with
the "consolidate btrfs checksumming, repair and bio splitting" series,
so this pure code move series triest to prepare for that by making
sure we have a neat file to add it to.

Changes since v1:
 - rebased to the latest misc-next branch
 - added a new patch to move struct btrfs_tree_parent_check into a new
   header to invoide include hell
