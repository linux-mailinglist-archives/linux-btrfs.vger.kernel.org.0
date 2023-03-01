Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C526A6D3D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCANmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCANmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:42:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F593E09C
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Y8NMo3cW6/XNLYwHp1mnlzndeW9ThYEJdVBq5VuiCWU=; b=StFARwtE1ll08CUWnNkN9Daahc
        bqP43EOJbPAAEtUvKYe3TH+yagp8+yR2nhf7kxevRmzYN+W+xnkLxAPHUBGGR70YqdUBuoydUhjo4
        p6rfyfuYTDD6spQdiL9w2RQt0NbHHJctGHhfvicV8JluBDHJm5R7nu0voPg4qKEeWjXL+2g+qtdIb
        M2tYMvV4JKhVylrHS/J+nUlQsGPDRMo8zgFZ8xZxZqMras/ZvK4W7g3sdTQ5ztbF0J9F+D7CabFlM
        f13/pIF6+01N3OvHo87EOxgXtvg6ZuX4XpdeYWYAI6NRDMg3WOlA5/OVHbCRNonbFagCI19U41IZA
        A3uW4vmw==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMjC-00GN6O-Ci; Wed, 01 Mar 2023 13:42:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: improve type safety by passing struct btrfs_bio around
Date:   Wed,  1 Mar 2023 06:42:33 -0700
Message-Id: <20230301134244.1378533-1-hch@lst.de>
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

much of the btrfs I/O path work on a struct btrfs_bio but passes pointers
to the bio embedded into that around.  This series improves type safety
by always passing the actual btrfs_bio instead.

Diffstat:
 bio.c         |   53 ++++++++++++++++++++++--------------------
 bio.h         |    8 +++---
 compression.c |   33 ++++++++++++++------------
 compression.h |    4 +--
 extent_io.c   |   72 ++++++++++++++++++++++++++--------------------------------
 inode.c       |   57 +++++++++++++++++++--------------------------
 lzo.c         |   14 ++++-------
 zlib.c        |    2 -
 zstd.c        |    1 
 9 files changed, 114 insertions(+), 130 deletions(-)
