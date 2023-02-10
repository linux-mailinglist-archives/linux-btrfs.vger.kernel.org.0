Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12487691956
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjBJHsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjBJHsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:48:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827DE5ACD5
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BlNpNXfb66HEXhadau/uohpg9vxb5QrAV0KEi48H0HU=; b=IXfPAkrIh00cg5zXagEZ6yyzgu
        Nu6VOmc2cMIQMBxmrrmF+jsHfpMI6ZgxPVHoIoMIpdhEXvSOfU8KBG897I5JH/SaW1R8bf4BHlG9L
        UrLa/5VA3DOIsBwwUBhAWlx9T39V9572k7n9hH5SxjALBR2ZjxhTwFp0IwpfRxSvS/c1C4gPRnM1v
        TOHCM4T67amUxNsKpH1dje3mBrIl+3qIi3aXyZ0ddU7wnBO2Eh3PZybvgDnFHT7sLror1yR5QlI9c
        3dNLTmOmc5WND2dgLdub26RxkobczoCkCSTUPPVyRwApchXaKbacErwQx6xwHWz3AMEjkFPQHTqOa
        n8Btok7Q==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9G-004fdk-1s; Fri, 10 Feb 2023 07:48:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: compression code cleanups
Date:   Fri, 10 Feb 2023 08:48:33 +0100
Message-Id: <20230210074841.628201-1-hch@lst.de>
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

this series streamlines the compression code.  It embedds the I/O for the
compressed I/O into the compressed_bio structure to avoid an extra memory
allocation and duplicate fields, and tidies up various other loose bits.

Diffstat:
 compression.c |  301 ++++++++++++++++++++++------------------------------------
 compression.h |   17 +--
 extent_io.c   |    2 
 inode.c       |   24 ----
 lzo.c         |    3 
 5 files changed, 133 insertions(+), 214 deletions(-)
