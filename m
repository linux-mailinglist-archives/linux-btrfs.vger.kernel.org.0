Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81F07AED1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjIZMpb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 08:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjIZMpa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4580AC9
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 05:45:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6471BC433C7
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732323;
        bh=vBmhhVqSdaDzqPx5CSWYwBoEztoAqNA84TotQtAU/Zw=;
        h=From:To:Subject:Date:From;
        b=lfVEq0MO0JbN5eCUP8v+nVb9d3I6HuCXaf4fvBwXGWlLXay/BOXgmMoNE4Ac953pu
         CH+/E+eb+LY2L6ndKg+eCWfFzjWBTvSn+ldgx1Psi0/FBHU+05yhoftynC58o+s2R4
         +m/f65fb2LLv6oyGX5uo41Y/YFE4aekw7mAXItjITw5a9qcx9VRN2bPB708fJNJrmq
         QoD1m3tAW88PDuQ6LW+8DLkO+PRAfzIchHqvc28nuSIOWOw4uxdBZmywA8PEGZDdIm
         Lp5qea9s6IZtLgTKGeNSkcE0A9U9NN44pPq9RA4MGuZI0/ymcNpqsLxJ7zwj9cpXqC
         9/WHYH1VqGB7A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: some fixes and cleanups around btrfs_cow_block()
Date:   Tue, 26 Sep 2023 13:45:12 +0100
Message-Id: <cover.1695731838.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This adds some missing error handling for highly unexpected but critical
conditions when COWing a tree block, some cleanups and moving some defrag
specific code out of ctree.c into defrag.c. More details on the changelogs.

Filipe Manana (8):
  btrfs: error out when COWing block using a stale transaction
  btrfs: error when COWing block from a root that is being deleted
  btrfs: error out when reallocating block for defrag using a stale transaction
  btrfs: remove noinline attribute from btrfs_cow_block()
  btrfs: use round_down() to align block offset at btrfs_cow_block()
  btrfs: rename and export __btrfs_cow_block()
  btrfs: export comp_keys() from ctree.c as btrfs_comp_keys()
  btrfs: move btrfs_realloc_node() from ctree.c into defrag.h

 fs/btrfs/ctree.c  | 200 ++++++++++------------------------------------
 fs/btrfs/ctree.h  |  41 +++++++++-
 fs/btrfs/defrag.c | 106 ++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 162 deletions(-)

-- 
2.40.1

