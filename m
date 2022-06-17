Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8654F4C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380547AbiFQKEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiFQKEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732FE6668E
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5jEWzVU3X5DLNjojlgkn+jWvfhs3/koICnyw02KIInM=; b=3yTXPQ7nDi0apb28NwB4BGR9sg
        LqCB61g61non2VCmw9gbdFKrbQW+eNUxCM5hnOdaFM1B4F01HXXwclM7GYWIpLIgd8DyFkFbkvti3
        Pd5WHUUHOBaiHZzxYll20GimDK1FOuIbqB4rcGsznVE+NNS1HzWyvc1WXQ7F8Ve5A1S2yr6Hz41WA
        uI1NJHytewt9gyqVSu9ePSWcZTsDLMPUL3PjEF/rlXb7QLrLf0rkv4jS8MXKGblSpG1jCsZAmWp+z
        o2f5WfmG5C43bqOEKSjyTSiVrR2X6VxpItSJp7c4OWweONdwtH5WgDn/k++4GFd+5SF1/bCV0+IBC
        hypXaOCQ==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28ps-006sie-Vq; Fri, 17 Jun 2022 10:04:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup btrfs bio submission v2
Date:   Fri, 17 Jun 2022 12:04:04 +0200
Message-Id: <20220617100414.1159680-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series removes a bunch of pointlessly passed arguments in the
raid56 code and then cleans up the btrfs_bio submission to always
return errors through the end I/O handler.

Changes since v1:
 - split the raid submission patches up a little better
 - fix a whitespace issue
 - add a new patch to properly deal with memory allocation failures in
   btrfs_wq_submit_bio
 - add more clean to prepare for and go along with the above new change

Diffstat:
 compression.c |    8 ---
 disk-io.c     |   46 +++++++++----------
 disk-io.h     |    6 +-
 inode.c       |   86 +++++++++++++++---------------------
 raid56.c      |  127 ++++++++++++++++++++++++-----------------------------
 raid56.h      |   14 ++---
 scrub.c       |   19 ++-----
 volumes.c     |  138 ++++++++++++++++++++++++++++------------------------------
 volumes.h     |    5 --
 9 files changed, 202 insertions(+), 247 deletions(-)
