Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45712665479
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjAKGYA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjAKGXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:23:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630DC10FD1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XFQq2jW9J18xUCZYh8hfs2A6ucQV7iZMJ0/q/rQsNec=; b=cKSg+Sc/ilCWak1CR3Q4QLk4NE
        TOz80pzLMFDOib6rItUnpLAEoDtrR5RstDyTcyPeCcRquMw81+Vxfg+i5/EYSshBjuGd2xSLzqqEA
        MUGEEGSzIF/ThTRFq6t4xe4/bJ0Jb/3GJelspbLGX7D4VYt56wxZ9/xraWHzMsLSmO5S3vMiVzKic
        j3yrdz4E1mvozC4+gQE96DlX5ODZeWXQaRHu50mmGlo67BtMDERaPXMHG4Y8rb5u1U13Z7v6OlqBE
        HQUTKrh9GkGW8JLfdW7IYEs8KBBV2xNsPpDJecjtppu6fqX+DPrfbDhz3YVZqUAxi/r2gxNTaTV0L
        KiaReDSA==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWP-009r9U-5D; Wed, 11 Jan 2023 06:23:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: small raid56 cleanups v3
Date:   Wed, 11 Jan 2023 07:23:24 +0100
Message-Id: <20230111062335.1023353-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
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

this series has a few trivial code cleanups for the raid56 code while
I looked at it for another project.

Changes since v2:
 - lots of reshuffling based on feedback from qu

Changes since v1:
 - cleanup more of the work handlers
 - cleanup cleaning up unused bios

Diffstat:
 raid56.c |  324 ++++++++++++++++++++++-----------------------------------------
 1 file changed, 114 insertions(+), 210 deletions(-)
