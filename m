Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05153C5C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 09:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiFCHLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 03:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbiFCHLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 03:11:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18A3633F
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 00:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=llXU7xuV/t5P3atIPWP3FeHZ7M/UkVuEPhPlL7hOIA4=; b=Bz+72VhNEj6iD25FytWk6aikm3
        1QCBqJH8C/HzSwKzOD3F5YP99Mqy27PJutTpW67rSBBj6uOWNbqscTv88IhUy2i4HjpcghV9d158u
        brX/2DK+AnVK9O6Nut3lfeF/COeE3CAizer2E9EtYpsoGA/A+ElNAid7kjz8P95uh4PgWVg1EUmrP
        oyTkSIm9uBzBUUSW+Kypi1ylzyIGuExFwGURacHhEMf69scClMsvCqqrmyi0x4ZoDqUoe+I7Ogmse
        ykQQVRsU0pPIkcjDMlqIp04UFR9Vbghao6/AhPbl2SYJT9PTqBZrSxUTywF7qm1F5Z3mrEqaXaf8q
        iFwp6+LQ==;
Received: from [2001:4bb8:185:a81e:b29a:8b56:eb9a:ca3b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx1Sb-006ElS-7B; Fri, 03 Jun 2022 07:11:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: extent_io bio submission cleanup
Date:   Fri,  3 Jun 2022 09:11:00 +0200
Message-Id: <20220603071103.43440-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series cleans up how extent_io.c submits bios.

Diffstat:
 extent_io.c |  168 +++++++++++++++++++++---------------------------------------
 1 file changed, 61 insertions(+), 107 deletions(-)
