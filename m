Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE237703DA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbjEOTXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbjEOTXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 15:23:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7673A8B
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 12:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pX79tHasZpApPtr2fS+89dyt7rfiuPh304MjpZbBAqo=; b=w5ky5797CPGtHXzDFQW4g/ESMJ
        zdwtLbc2QWlaz8e+CwcAsYiNMwzqMBVWskklIjvLytbk4LoRnyoM/iVVkn54Ae+fPd/bVbmPvU93u
        IFt/+V8kTyyriYJ0jdCM7D22X78qxWskB48GyDaI0lBnl3Mmkxkfq3y2ZDvI+jFuxBljBeZc/HLnZ
        I1RmuvpDUUJZhGpYpeow4ZJTD5RbyQutS6b4VZKw9lMKRg/EsaidafO/ztUeke02rKLztNSoYUelH
        3kxiNxsw/bQgi5i91Kvf6TAY7LbHpj12KCMyGmaSiqNkjJjtB8gn/XRVBH2KqP/GQBKVLdBzoWVMK
        ySFTxuUQ==;
Received: from [2001:4bb8:188:2249:ad42:acf3:6731:a041] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pydmg-003HDb-2D;
        Mon, 15 May 2023 19:23:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: simplify dirty buffer tracking
Date:   Mon, 15 May 2023 21:22:50 +0200
Message-Id: <20230515192256.29006-1-hch@lst.de>
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

this series rewrites the tracking and writeback of the per-transaction
or per-tree_log dirty buffers.  It is intended as a first step towards
getting rid of btree_inode, but turns out to be a pretty nice cleanup
on it's own.  I also see minor speedup in fs_mark workloads, but given
how variable they are in general I'm not sure if they really matter.

This series starts out new extent_buffer.[ch].  I plan to eventually
concentrate all code for extent_buffer handling there, but for now
this just has brand-new code.

Note that the series is based on top of net-next because the previous
round of extent_buffer changes has not made it to misc-next yet.

Diffstat:
 fs/btrfs/Makefile                |    2 
 fs/btrfs/ctree.h                 |    3 
 fs/btrfs/disk-io.c               |   72 +++++--------
 fs/btrfs/extent-io-tree.c        |  212 ---------------------------------------
 fs/btrfs/extent-io-tree.h        |   14 --
 fs/btrfs/extent-tree.c           |   21 ---
 fs/btrfs/extent_buffer.c         |  104 +++++++++++++++++++
 fs/btrfs/extent_buffer.h         |   26 ++++
 fs/btrfs/extent_io.c             |  131 ++++++------------------
 fs/btrfs/extent_io.h             |    2 
 fs/btrfs/fs.h                    |    3 
 fs/btrfs/tests/extent-io-tests.c |    2 
 fs/btrfs/transaction.c           |  168 ++----------------------------
 fs/btrfs/transaction.h           |    3 
 fs/btrfs/tree-log.c              |   71 ++++++++-----
 fs/btrfs/zoned.c                 |   11 +-
 include/trace/events/btrfs.h     |   57 ----------
 17 files changed, 278 insertions(+), 624 deletions(-)
