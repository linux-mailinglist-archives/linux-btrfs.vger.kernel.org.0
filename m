Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7F4E6752
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 17:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352046AbiCXQ4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351971AbiCXQyq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 12:54:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3DB2473
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gaq/fj5deajDP+JgXYVamlCcYTyL7tLiFX2rnDZz0gk=; b=yFJMX99ERlExkB4gDO2wnSoynD
        zJuY++mPFnXw15trKq+6e2++MQ4YGCBnwdQhYAmAdJd8pQfn/l+xi+IyfDnXKWnsELu14csN9b3A8
        lqmuAM2svANU3SQVWG1k++Ihi/3CV0iWsCsmCyY+oY6ySu/N8wCP6wbdupt41lJUtPHrvxUR8u+YD
        n/84rGYdb6TQVhhCAHIzkv9xx3A1C1lsNSkCYLgQff8lWP3EmOso/VYtaki9mKoABHj2eGwHfcYXo
        /3evwAs+eYDKv8MjQi3Ia+I9MBmw1mdnWt7FeGrFdeidnsQYlGxtu7IaNJSxFzu8R0N17JnuccAOE
        NCFs/zxA==;
Received: from [2001:4bb8:19a:b822:2a44:1428:2337:3096] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXQh2-00HFwp-JK; Thu, 24 Mar 2022 16:52:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: btrfs zoned fixlets
Date:   Thu, 24 Mar 2022 17:52:08 +0100
Message-Id: <20220324165210.1586851-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this series fixes a minor and slightly less minor problem in the btrfs
zoned device code.  Note that for the second patch the comment might
not be correct any more - AFAICS 5.18 added support for the dup
profile for zoned devices, which means we do have a real issue now
if different devices have different hardware limitations.  I think we'll
need some code to check that all zoned devices have the exact same
hardware limits (max_sectors, max_segments, max_segment_size,
queue_boundary, virt_boundary), but I don't know the code well enough
to implement that myself

Found by code inspection as part of my bio cleanups.
