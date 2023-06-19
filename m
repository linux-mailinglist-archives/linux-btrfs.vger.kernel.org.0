Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F666734BDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjFSGsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 02:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSGsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 02:48:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E1513D
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jun 2023 23:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MA/scusGI4Xbiy9z3n4wDSbyE8K4jgIoWvCOdFwHHTQ=; b=jtY4TV+MyKHs4EQjJ8862DC4Pj
        u1jX6wzkiYeOWRFrPQ/BMmJCpo4la3p3dHUgDN6Ct2Aqsh/Nq2SGTmSV9n51rkRuLs+YndONOSR3Y
        7a/xbcgVe0DkDhxXwpv+c7FBr6RRluqQmhnLOYLlzr8mRiUUpMa76AVeF3Uk9rKqSIy04fG1ucHyy
        Y1lonYYhrFZav2nOCoo7lwy4Pwf5POd7S+PjTdewg87rlSnhrTckFndZ0CEpBhTTJ9GISV2hVD956
        QGAnH4PHuKSTFX/D+arTcb1RT7Qc5TaqV8Uuba0LiP28zhr7D6SHg3Wwnjr67rm3OorT1HbE+Basd
        fgWTouug==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qB8g8-007cu2-2w;
        Mon, 19 Jun 2023 06:47:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: don't create inline extents in fallback_to_cow
Date:   Mon, 19 Jun 2023 08:47:40 +0200
Message-Id: <20230619064742.629345-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this is a little thing I found during code inspection, let me know if
the fix makes sense or if there is some other good way to avoid dropping
the page_started flag on the floor here.

Diffstat:
 inode.c |   83 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 42 insertions(+), 41 deletions(-)
