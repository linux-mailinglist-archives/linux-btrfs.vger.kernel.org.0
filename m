Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73439543959
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbiFHQrx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245733AbiFHQrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:47:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5218E4507D
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:47:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BB7271F9B8;
        Wed,  8 Jun 2022 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=agR3Fzk30M/qC0RiwL7FsHksxV8xGOv3lboaQUxIO0k=;
        b=ND8rZ88Hgl0R6uny+YLR1wNtbeNdX5lQa7F98gB4WSFbDk22cbM9mqxLb/IB9cL/zmZ9qP
        8fJRj66thNS0ziDNAXWwOTlnFRQi3C8NjlDCsBp95955VaeMdzXdpYMox/t4A66ipHgzDs
        tTM07gLMIB2UOtL06xFvHaQh/HKosPY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AE7212C141;
        Wed,  8 Jun 2022 16:47:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1652DA883; Wed,  8 Jun 2022 18:43:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/9] Extent tree search cleanups
Date:   Wed,  8 Jun 2022 18:43:19 +0200
Message-Id: <cover.1654706034.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extent_io_tree search helpers take return parameters and many
callers pass just NULL, which are checked and add a conditionals to some
paths. Reorganize helpers to suit what callers need and drop unnecessary
parameters, open code rbtree search loops and clean up some other
parameters.

This could improve performance in some cases but it's mostly micro
optimizations and I haven't done any measurements.

David Sterba (9):
  btrfs: open code rbtree search into split_state
  btrfs: open code rbtree search in insert_state
  btrfs: lift start and end parameters to callers of insert_state
  btrfs: pass bits by value not pointer for extent_state helpers
  btrfs: add fast path for extent_state insertion
  btrfs: remove node and parent parameters from insert_state
  btrfs: open code inexact rbtree search in tree_search
  btrfs: make tree search for insert more generic and use it for
    tree_search
  btrfs: unify tree search helper returning prev and next nodes

 fs/btrfs/ctree.h     |   4 +-
 fs/btrfs/extent_io.c | 316 +++++++++++++++++++++++--------------------
 fs/btrfs/inode.c     |  24 ++--
 3 files changed, 183 insertions(+), 161 deletions(-)

-- 
2.36.1

