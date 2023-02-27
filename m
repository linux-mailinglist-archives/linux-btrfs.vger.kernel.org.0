Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8C6A45BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjB0PRQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjB0PRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D692278F
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fIZeP+/6kfTGGTYe4cThnxuNlE1vaWXBbUrR5SvkEGs=; b=CQ0Cit42mPzT2utHTLFLdHkSIW
        b6M1E5oKTftLCM1TJ5s5/jcQEph4s6cRFMKbzR6caadrzw07zN3Z/EDHHpt2bl/vjt17hlEWqSLRD
        0xdOoX1JHuCkoCIsi8fYP2AmoA6JfjYDNbpgrULzU5VXbfeLa8eXP2ln74F/PvFDoEYP8g08ETmqQ
        9dKMJcRUJyNTDeKlprvKU3lmw3TE20/6PVMAau7SpJtHrrlEsGgUU+3xPJ/DbsP7/hSFMrmJSCUfb
        sDNVKhi9oiGDWll5XH2lgRlmP0UiHcKecoDzfdMR0qD/re9m5zVtkC7fkLAlEtskDiiTWT/TmvmYQ
        0ogsYuNw==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFQ-00AAsP-KE; Mon, 27 Feb 2023 15:17:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup submit_extent_page and friends v2
Date:   Mon, 27 Feb 2023 08:16:52 -0700
Message-Id: <20230227151704.1224688-1-hch@lst.de>
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

Changes since v1:

 - remove a trailing whitespace (tab) added in an earlier patch that
   gets removed until the end
 - make a commit message more detailed
 - minor tweak to a comment
 - reorder the first two patches

Diffstat:
 extent_io.c |  451 ++++++++++++++++++------------------------------------------
 1 file changed, 142 insertions(+), 309 deletions(-)
