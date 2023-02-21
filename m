Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E894869E933
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 21:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBUU5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 15:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBUU5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 15:57:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC3AB761
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qCq9t9/vIYKtyFvrygD+M2wtUHTOgbQhJS47y8GNgoI=; b=Zwt/Zw2Nl9Xs5yf704XDT40gOQ
        QbEC0ViiscCFtppx32VhcKNPVCHn2eta39nSL5vi3X5whh1VkuwmmEBJ8peX+C4bgKUBvnHrV7gi2
        CQR3Iq93GySCsPOVHZcksGvQZzSMJHylH9+c02gC7WFtc1+A9oKN73+l22fxwrqnI4Kfenh8IzvWI
        V0jYraHUkNmI+snPPZu6muURVxE59AaX3NDv7mSND4sVpoFPovLYXWVGoQNdbFSL/e0DRawbfmh30
        J400/Qi6jeUH+jCXfHm0MY7pmu5TWqNqMloIQETSpyZrlNkiShKf/0hiYMxkJe33PYSTT/sorWqvM
        fxCBD57A==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUZh7-009lKH-IV; Tue, 21 Feb 2023 20:57:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup btrfs_lookup_bio_sums
Date:   Tue, 21 Feb 2023 12:56:57 -0800
Message-Id: <20230221205659.530284-1-hch@lst.de>
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

Diffstat:
 file-item.c |   81 ++++++++----------------------------------------------------
 1 file changed, 11 insertions(+), 70 deletions(-)
