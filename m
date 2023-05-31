Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D905717500
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjEaERr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjEaERp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:17:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD221D9
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sIkIVP1kD7kqKsO/hJwOCB71CPY8+2MwpOx1A5EHqg8=; b=padt9F0TMGW7oplLrBv9qU3Prs
        uzVO9+0wXrvUbN9LACypamF1rLZS7MNxJ9hBffyS2xiI1vjaOTH4hu1T18N3MNWWOy+aTk5/78RRe
        8fXyJVBlj3NVok+d1Y4wP5rzE27q2FLfnMkiOlyPVeOzGDG2OMEQ+u7qTdd0L+1YS6qfXE0tZst4Z
        JvnYAqLBRk74Kt6rAWrVrXvSWr4Yfl/c8RDqTNdEedCwi5P5QPiSMT66LGCnvvYCmzfG3C6wOZqWS
        hDduZCFDNURVDrL9HpfGwYIKUTUEU4scjafRWrm4PC/pMtsBS8RxQZ9QP/B3SGHWyeDH/y8m7iW7n
        sirN6ijA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4DHJ-00G1OL-2r;
        Wed, 31 May 2023 04:17:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup the btrfs_map_block interface
Date:   Wed, 31 May 2023 06:17:33 +0200
Message-Id: <20230531041740.375963-1-hch@lst.de>
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

the interface around btrfs_map_block is a bit confusion, mostly due to
the fact that it has a double-underscored complex version and two
wrappers that just take a few arguments away.  This series cleans up
a few loose ends to make this interface easier to understand.

Diffstat:
 bio.c             |    4 +--
 check-integrity.c |   19 ++++++++++------
 dev-replace.c     |    2 -
 scrub.c           |    9 ++++---
 volumes.c         |   63 ++++++++++++++++--------------------------------------
 volumes.h         |   15 ++----------
 zoned.c           |    4 +--
 7 files changed, 44 insertions(+), 72 deletions(-)
