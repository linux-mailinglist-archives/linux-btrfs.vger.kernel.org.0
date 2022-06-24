Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517ED559B1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiFXOGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiFXOGR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 10:06:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A918B4EDE7
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 07:06:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 11AF821A9A;
        Fri, 24 Jun 2022 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656079572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dbxmj9XcFqRnYOJ4yfdFK3bzNH+wsw2xdqJt6DCxQs8=;
        b=JVWyXcyZToLqWTFuFcFj5e501sa3spuQ5qTEzLVFEzh3IPnZrJy3yi0OpCRZ4rK8Z0gfNy
        UvM+bjxpCkQpt/HJAdBKxG05jExqcdKkHuiWmcISNSeimXDbOrc+EJa9MJOV1qMxbK3aq/
        YGy46RkTmLWFnPu0ZUyi7QuLg8FXguI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0936A2C24A;
        Fri, 24 Jun 2022 14:06:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B026DA82F; Fri, 24 Jun 2022 16:01:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Cleanup short int types in block group reserve
Date:   Fri, 24 Jun 2022 16:01:34 +0200
Message-Id: <cover.1656079178.git.dsterba@suse.com>
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

Using the short type in btrfs_block_rsv is not needed for bool
indicators and we can make the structure smaller.

David Sterba (3):
  btrfs: switch btrfs_block_rsv::full to bool
  btrfs: switch btrfs_block_rsv::failfast to bool
  btrfs: use u8 type for btrfs_block_rsv::type

 fs/btrfs/block-rsv.c   | 22 +++++++++-------------
 fs/btrfs/block-rsv.h   | 14 +++++++-------
 fs/btrfs/delayed-ref.c |  4 ++--
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       |  4 ++--
 5 files changed, 21 insertions(+), 25 deletions(-)

-- 
2.36.1

