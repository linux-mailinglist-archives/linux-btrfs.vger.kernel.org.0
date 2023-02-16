Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20942699A1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBPQes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBPQer (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:34:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A11DC
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fN0lZgK9e40n4glmfTB9COaKYfpT/i42z6eg7N/IN7E=; b=UN9CSqGY6A1uDQ93AD56rPFbB5
        v7jij8qCwiMmKoP7shwlMomx0u8rVWirCu6usDy9UDzDr5ojkH7q60WfoX1fyM/fd+C6xZviL6KUM
        nrcqExOtgdinh+aEM0yAzB3hYDhLHV9HJ82SPU4HmhBA7PAu3KNtQK8O26JhXaViuJE8ljdbW8wp+
        8tOYxxZzyRDLOtw78xhLjyfFsp7/SpQvDNcIPZ4BgYGg10T4H/8SxV0QVNlpkjnU+6f/MmH3Ohpch
        Xx0Ar4qzpwPdi0ouSb7wgxDsGt/F+LLiKYDCz3tbNjRDQkI10gMIaQLYU37a96vYSiIDKb7i1Q2hq
        F/dZ5fLQ==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pShDU-00BCvW-1R; Thu, 16 Feb 2023 16:34:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup submit_extent_page and friends
Date:   Thu, 16 Feb 2023 17:34:25 +0100
Message-Id: <20230216163437.2370948-1-hch@lst.de>
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

this series cleans up submit_extent_page and it's callers and callees.

Diffstat:
 extent_io.c |  451 ++++++++++++++++++------------------------------------------
 1 file changed, 142 insertions(+), 309 deletions(-)
