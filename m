Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5550DAAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiDYH7H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiDYH5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 03:57:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E025A18391
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TT4wAoIfI/M50P4uMe9AwtYOJdXhO06N4prwWzsTdV4=; b=A8BrV7A3bgqderHKoTTxsu+szW
        SBWVlN4eSM7VWRNlQtVzXRqwPJF/YbcdrEABb8XykEMLoZNIWfyhRN3qHufzRzS57MWejU9SwgsE8
        7Tk4QnezVaF6d3NuoJNUTSHIoa2nAN91guqfn8ZBFSApjDAQ8xvz2iD3hblAJxxEwZMq1swAWzxVs
        017DUU+Q9iqd5SiDHaVVNFT11z2LhMfbnRvE9GHFBpfqVnVjXaZ8sbSEQQyJlyKitN57cCAl5lntx
        uQL5QKZ5HejZh4UdytsyHBDA1+/2DCXUeTdsRssvKNfguG8lTHBjqJiIpL1pnfu7o97oHV471Nb6l
        /qXi+kSQ==;
Received: from 80-254-69-104.dynamic.monzoon.net ([80.254.69.104] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitY7-008gbr-VG; Mon, 25 Apr 2022 07:54:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: cleanup btrfs bio handling, part 2
Date:   Mon, 25 Apr 2022 09:54:08 +0200
Message-Id: <20220425075418.2192130-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this series removes the need to allocate a separate object for I/O
completions for all read and some write I/Os, and reduced the memory
usage of the low-level bios cloned by btrfs_map_bio by using plain bios
instead of the much larger btrfs_bio.

Note that this series only applies to the for-next tree, as the misc-next
tree seems to miss the workqueue cleanup series.

Diffstat:
 compression.c |   41 +++++------
 compression.h |    7 +-
 ctree.h       |   14 ++--
 disk-io.c     |  144 +++--------------------------------------
 disk-io.h     |   11 ---
 extent_io.c   |   33 +++------
 extent_io.h   |    1 
 inode.c       |  162 ++++++++++++++++++----------------------------
 raid56.c      |  111 ++++++++++++-------------------
 super.c       |   13 ---
 volumes.c     |  203 ++++++++++++++++++++++++++++------------------------------
 volumes.h     |    8 ++
 12 files changed, 271 insertions(+), 477 deletions(-)
