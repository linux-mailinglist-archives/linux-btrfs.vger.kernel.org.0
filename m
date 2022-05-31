Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC5B53939F
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbiEaPGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiEaPGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387E10D
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAAA7B80CEF
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD263C385A9
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009607;
        bh=zL7ovjKwQ7bEzMR5mF4tll4oB11kfQj0uvuKijDo/ZM=;
        h=From:To:Subject:Date:From;
        b=PBj0trMbDdIIgLxAKD2JSju4N/R+Kf2kbZskhiilrf+LgwBShNTDgUxpROyrAtC9C
         C6NWeFyLAHfALEsg62jq/X8iEdq20RovnTNIY8LNLvVhaAdUt2F+iMX/iVZ/WiMKcP
         OkMdP57x9W+0p2yGRLqRAnwXggKxcZRKC5jdBBHPJmMx7YWouctRrzzNuTnF9oTUu9
         midIqn6JCcXid/xaEQXhil2wChgmJlb/i/VZyRhZefnVdcIb9tkSc0WVkaGZ6sI2aV
         tapiFvXd1+NUvEc8g1dAYAKvYWZ+dYxU7DyoCTXBTMgc8pvYYpiopWzeZisp0LfXTS
         F7BNlqUdDJBbg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/12] btrfs: some improvements and cleanups around delayed items
Date:   Tue, 31 May 2022 16:06:31 +0100
Message-Id: <cover.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This series does some cleanups and performance improvements related to
delayed items. These are also preparation work for some other changes
coming in the near future.

Filipe Manana (12):
  btrfs: balance btree dirty pages and delayed items after a rename
  btrfs: free the path earlier when creating a new inode
  btrfs: balance btree dirty pages and delayed items after clone and dedupe
  btrfs: add assertions when deleting batches of delayed items
  btrfs: deal with deletion errors when deleting delayed items
  btrfs: refactor the delayed item deletion entry point
  btrfs: improve batch deletion of delayed dir index items
  btrfs: assert that delayed item is a dir index item when adding it
  btrfs: improve batch insertion of delayed dir index items
  btrfs: do not BUG_ON() on failure to reserve metadata for delayed item
  btrfs: set delayed item type when initializing it
  btrfs: reduce amount of reserved metadata for delayed item insertion

 fs/btrfs/delayed-inode.c | 341 ++++++++++++++++++++++++++-------------
 fs/btrfs/delayed-inode.h |   7 +
 fs/btrfs/inode.c         |  25 ++-
 fs/btrfs/reflink.c       |   8 +-
 4 files changed, 260 insertions(+), 121 deletions(-)

-- 
2.35.1

