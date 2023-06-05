Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6FC722155
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 10:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjFEIpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjFEIp2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 04:45:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A4FA
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=R6INfJIWsaR05IcIKBLaPN0KQiOQHx+bEK3rsb3gZpU=; b=2oJ3QwxVnr2cvfgpkVTb2DGw4g
        xHXjgbRzD8zrCqLkKa5G7t6OXSpIy2z0m+6q9Ded5EG0uwNn/xCEN5eL3904uNAWLdxo9yP7gBp5x
        9FxuG6Ee+bCTGkpbnTfnv7HAlTOpXE0itnie/hpxtFU3e5BCCQbHSMgXZ6tkuoOEdaDA6YXZ/sec4
        /IW0NHMFTn4HAeVDSNMY4zOaysMud4oEZGaEdtRZ0j3UmpKc1eXKhDoFrs8PL0+YIwMZ0aEb/JUG6
        TuXHuw0TkHqr59VhA1wM03JMSJ1w5iDx5YORfH4fyrgKBG/S1ZM9dXN1w1cNCrYkgHx+RCXCdio62
        zCx3OIHQ==;
Received: from [2001:4bb8:191:e9d5:e931:d7f5:9239:69f3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q65q6-00EkZS-0J;
        Mon, 05 Jun 2023 08:45:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: fix nodatasum I/O for zone devices
Date:   Mon,  5 Jun 2023 10:45:17 +0200
Message-Id: <20230605084519.580346-1-hch@lst.de>
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

my recent series to optimize the ordered_extent splitting for zoned
devices broke nodatasum I/O - this was hidden by the fact that a normal
xfstests run appears to only exercise nodatasum in combination with
dev-replace, which was also broken..

Note that there is a very minor context-only conflict with work in
for-next.
