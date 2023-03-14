Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7543E6B9C22
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCNQvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCNQvU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:51:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDF94F5A
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cOwKIVPgXnL0CYsW1ji9+3JAuuvrwMdAlFAqtGrsoy8=; b=DKa7yrpmpv73Hw6trLVOz6WOdr
        BL23yX+anUnXW13IRZowo7TWsMxPVcuexm1XYVIdxvYIKYSrA19fUBjmjEfb20H3QHrtEVCH2x1DA
        IL3az5ZvqN/rPBrhAFGm77fvAGeO2GJN9qjzvhm/H6kJMJ0fsO2UU6A/PHAyWgkTXdw7owqEdW4Gm
        ABAGWhjkkawIG5XPFCCLniBgXDSWAYFlTzzv++77Uh+Emm+THGl8lmMZNavFXu6fCfiMK0i2L4s6D
        fmIQYQs8fg02wuiAlZ4NKFKkmnhm6HUjwCESFUswEm3b2rw9jcOtgLfS0xpA1Ef9Lc9y9gIpdsNqb
        4T3XIdhA==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7rn-00Aul5-2i;
        Tue, 14 Mar 2023 16:51:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup btrfs_add_compressed_bio_pages
Date:   Tue, 14 Mar 2023 17:51:08 +0100
Message-Id: <20230314165110.372858-1-hch@lst.de>
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

when I factored out btrfs_add_compressed_bio_pages from the two duplicate
copies a while ago I left the code very much as it was then except for
splitting out the helper.  But this helper is very convoluted for what
it does, so this tiny series cleans it up a bit.

Diffstat:
 compression.c |   45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)
