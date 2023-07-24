Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3675F83C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjGXN1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGXN1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ACFE67
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QJ39sX/g+OlzTcai1UpDsajywc2Q0X+fnmWhLmdSVFw=; b=c9azqb2VGFWg558dW7iHrqz1Gx
        yKWjwNyKaMKQfyik8pUM9+rTHX4Aiz3V2e8SeMWcLRgPTP26GyFZqkb5U8EdkxHVCSMWc+HmsrfLh
        1wnset5QT9aZC2KXYxksUkK6dJZjfCKLsA4D5iXjHTpIx1tojuPK4FKjPaQixcqiLArRxrVIS4Cg2
        3y66T+9C4cbtGT50Zetm6R9N3/vmhlORH26Ng3dC2dxoFRxvRgaQyuIqDix/MFbamot981QYznrPm
        39cKEPRKfPYE5W8FAucQ0Ac/9yyGkKUpcfWySQuHK3Tx0DT1JATtwOluxplWibc3U3lO3JaxFEqW/
        /4lletCg==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvaX-004RLT-2Y;
        Mon, 24 Jul 2023 13:27:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: small writeback fixes v2
Date:   Mon, 24 Jul 2023 06:26:52 -0700
Message-Id: <20230724132701.816771-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series has various fixes for bugs found in inspect or only triggered
with upcoming changes that are a fallout from my work on bound lifetimes
for the ordered extent and better confirming to expectations from the
common writeback code.

Note that this series builds on top of the for-next branch.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git btrfs-writeback-fixes

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-writeback-fixes

Changes since v1:
 - rebased to for-next
 - picked up review tags from Josef

Diffatat:
 extent_io.c |  182 ++++++++++++++++++++++++++++++++++++------------------------
 inode.c     |   19 ++----
 2 files changed, 118 insertions(+), 83 deletions(-)
