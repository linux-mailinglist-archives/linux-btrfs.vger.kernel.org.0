Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708E5534ADD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbiEZHgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 03:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiEZHgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 03:36:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EDC2E0BE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MfHlPWagXhqCX2pgMZ9B5uAZUgcjWmyDrz6uxpsTLSQ=; b=Vz1WGHShG29k2jGAb8wzZG0jm9
        mxQah4OE5SyfT4sygPHHGuSt9TAef2ExKtN5YR2GJfbh7wPiiv9heH49ki9WoLyJ4eQzhPE+uDqOH
        N7YhuOG4zNU6WpcNrDpav1W6l8vnogrpleYEgKSJ7HS0bUlMvoYnbhdoMgYZVengqW9ZUHY/uHmPV
        1uaXpEDJlAi/KfcDG+0/rJulBIIw7CVAvC/+u4kOljWNTODmoCWJ3R1BCeldwclgBpeFt8xF77UXW
        GfPuE7uwfv0hINAvMZoVxnYXHDNxYLq0JIM7cfBsSwP5WIwLznXTagVA0NkNKZns4oaf8E/mgib8E
        +/2iUURg==;
Received: from [2001:4bb8:18c:7298:d94:e0f5:2d65:4015] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nu832-00DpV7-KG; Thu, 26 May 2022 07:36:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: cleanup btrfs bio handling, part 2 v4
Date:   Thu, 26 May 2022 09:36:32 +0200
Message-Id: <20220526073642.1773373-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series removes the need to allocate a separate object for I/O
completions for all read and some write I/Os, and reduced the memory
usage of the low-level bios cloned by btrfs_map_bio by using plain bios
instead of the much larger btrfs_bio.

Changes since v3:
 - rebased to the latest for-next tree
 - move "btrfs: don't double-defer bio completions for compressed reads"
   back to where it was before in the patch order

Changes since v2:
 - rebased to the latests misc-next tree
 - fixed an incorrectly assigned bi_end_io handler in the raid56 code

Changes since v1:
 - rebased to the latests misc-next tree
 - don't call destroy_workqueue on NULL workqueues
 - drop a marginal and slightly controversial cleanup to btrfs_map_bio

Diffstat:
