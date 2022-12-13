Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD6F64B14C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiLMIlc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiLMIlb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:41:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFF19290
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Hjwn/g5Nu2zZxzSztYEojQfXbXgvnXVQ27H4QRKtBlQ=; b=iPpDRVVFZgNGvl94KWC/iHVZn7
        wxdZ9lS41nKdXiDUup65iIkfmLhtkq2R33R/qXNJgYV1+BuIljIU7CLlBdkax44JluMWb4LiBlNsn
        kL2DX5FFBUNTKOgYNT0RS04LlGvxlsru1KL5J4mBQG6YJOWH61jgKnxMj2agFQVh8rytjC971gI1K
        iH3hfdxxNTRlTIyesALKYaLlk+Hxy0sa6uodX171jZqMWoO0/242Hkw3mn/sL8BGMPRWVrq3s5SKw
        Hsx+rLWPSGD/VfPpIEE6a/coQnIAtRUS/Mubd6A/JywBgnVb+CnPzW/GAPAg6oq3nRtdNFhYf/DwY
        PTib1ijg==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p50qs-00E0hY-Mq; Tue, 13 Dec 2022 08:41:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: small raid56 cleanups v2
Date:   Tue, 13 Dec 2022 09:41:15 +0100
Message-Id: <20221213084123.309790-1-hch@lst.de>
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

Changes since v1:
 - cleanup more of the work handlers
 - cleanup cleaning up unused bios

Diffstat:
 raid56.c |  167 +++++++++++++++++++++------------------------------------------
 1 file changed, 58 insertions(+), 109 deletions(-)
