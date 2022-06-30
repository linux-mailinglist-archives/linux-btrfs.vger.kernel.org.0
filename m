Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41EC561FD9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 18:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiF3QBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiF3QBk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 12:01:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CE9344E8
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=w3eR9CImvlW8xOg//JabhmcYRQ54PCzLlqrXxVAY3Rc=; b=c5zZNijg39llu+GoIepsA/SlGH
        0jDoZ5JoI2DSHPS/9EezP5d9HsK0bBN+SP81nnS2tcSpcuL6VLGKx1z/KUIRAkI8OojdgKJJyBAJ9
        vr5WbPJsRcGX6hd1W3pBIv3LkNkPxPAqWSF+TBm2cn3JMQFbrLfdmgwQiH/48zplur8gXHiSHm7tJ
        PF/gVQJWuv7I/1wMS9HzRKLgjUA+3+f+DFoBwDROYkZZu3ZwtVzumbVjHCj7+1h0wlhx2mTtNP5SK
        Htv60YLhVA2Pqws+RklbiL34gTrgUrvIeykVI1i5lKb6AVqGskBsIXuGjeP3tgJYGD3LDWKjwzPWU
        ConOM6Dw==;
Received: from [2001:4bb8:199:3788:3ea8:4fde:60a4:7dbf] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6wbl-000TKl-PP; Thu, 30 Jun 2022 16:01:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: fix read repair on compressed extents v2
Date:   Thu, 30 Jun 2022 18:01:26 +0200
Message-Id: <20220630160130.2550001-1-hch@lst.de>
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

while looking into the repair code I found that read repair of compressed
extents is current fundamentally broken, in that repair tries to write
the uncompressed data into a corrupted extent during a repair.  This is
demonstrated by the "btrfs: test read repair on a corrupted compressed
extent" test submitted to xfstests.

This series fixes that, but is a bit invaside as it requires both
refactoring of the compression code and changes to the repair code to
not look up the logic address on every repair attempt.  On the plus
side it removes a whole lot of code.

It is based on the for-next branch plus my "btrfs: repair all known bad
mirrors" patch.

Changes since v1:
 - describe the partial revert that happens in patch 1 better in the
   commit log
 - drop a now incorrect comment
 - do not add a prototype for a non-existent function

Diffstat:
 compression.c |  287 ++++++++++++++++------------------------------------------
 compression.h |   11 --
 ctree.h       |    2 
 extent_io.c   |   93 +++++++-----------
 extent_io.h   |    9 -
 inode.c       |   34 +++---
 volumes.h     |    2 
 7 files changed, 146 insertions(+), 292 deletions(-)
