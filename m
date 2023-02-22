Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E9669F999
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 18:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjBVRHI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 12:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjBVRHH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 12:07:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5614C3B0F5
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eP+M+m3fiMmCSkvuLMiVbdYQYBFclb/ImusEJu5Debs=; b=NnWLLmNHsN8YO4tQDKgr0MACnX
        lLumrhqcTbaWpgwpe1pl6RwH9zLbo+Xfi1xY+qbhInpc4p6PykrpFaDTvOdILC70T/2MevbsJlH6l
        6B4KlDXMStf4mBK4YFnIaKqa5VDPFAF/p7DA1hOEnBS7Lml/FBjbRf67ZRbYYG9JNYLUSye/tKImY
        9s8GvCbl0F1HW9kf88fnA8CZmC3z06Xqaae/d3Gjj3RGLkXSfLYtcKUZ2pj4pjllwxLd73pDnXrcv
        O3T88MY91GXhGaprGZTxiKHH/Bom79J1i2LqWlLPdXaDtrK4OOM4X2qsM3waggrQV9VzAGfS6vN4H
        zu+hsF0g==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUsa7-00D9OC-DX; Wed, 22 Feb 2023 17:07:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup btrfs_lookup_bio_sums v2
Date:   Wed, 22 Feb 2023 09:07:00 -0800
Message-Id: <20230222170702.713521-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
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

this series takes advantage of the file_offset now provided in each btrfs_bio
to clean up btrfs_lookup_bio_sums.

Changs since v1:
 - keep the count variable signed
 - remove the search_len variable

Diffstat:
 file-item.c |   82 ++++++++----------------------------------------------------
 1 file changed, 11 insertions(+), 71 deletions(-)
