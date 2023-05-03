Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A046F5092
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjECHGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 03:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjECHGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 03:06:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BEC3A9B
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1gSFGAq0XwQshw80m0rtfZDGLRjx4zqfj/0FwGM2DXo=; b=hHL4qBOte+Uf0uncsbkPyBNRWa
        wMH7fmOxlUkDIyEmx0q1BpjPdOt3C22hVa240v/8nhvt8svqb7aPobEKbUjPWfOBi/j1IGWH35NQO
        Ag9NcClJAgWNhvdnyhEPl8lpMsGGmhMMrwUrX4G1GnKCh/phr6nTotzeELkC6olSXVcHHLaBcaBQV
        k70/v4hWB9yPWrdCOVEfC3xp/Q7jjPSLNO8D+m8IMhJSIWFjnDOsoUm5XtneRoScUVztm0gJfqUEA
        g8TnawGZHGJi3SITYfRIBykPTmICGA/6qaa3UELbk8ZnRTw0WuNIO4CpbsF79T4O6FieWjLCsIqQc
        V8RfBvzQ==;
Received: from 213-225-6-169.nat.highway.a1.net ([213.225.6.169] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pu6Z8-003aBl-1e;
        Wed, 03 May 2023 07:06:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: don't offload CRCs generation to helpers if it is fast v2
Date:   Wed,  3 May 2023 09:06:12 +0200
Message-Id: <20230503070615.1029820-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

based on various observations from me and Chris, we really should never
offload CRCs generation to helpers if it is hardware accelerated.

This series implements that and also tidies up various lose ends around
that.

Changes since v1:
 - drop already merged patches
 - reordered two patches
 - improve the commit log for one patch


Diffstat:
 bio.c         |   30 ++++++++++++------------------
 btrfs_inode.h |    3 ---
 disk-io.c     |    6 +-----
 file.c        |    9 ---------
 fs.h          |    1 -
 inode.c       |    1 -
 super.c       |    1 -
 transaction.c |    2 --
 8 files changed, 13 insertions(+), 40 deletions(-)
