Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105D7269A7
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFGTYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFGTYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05D1FD5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED17639BC
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B509C433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165880;
        bh=N7+ZWxwYAIIkHdRHyARQ8DC2ErpApPJbhdYahZjGw74=;
        h=From:To:Subject:Date:From;
        b=ME4Skrwdi+4wfrs/+djl7lU/J1yNC6BM/UHTJ2ABURK5R0xMdr2rDwFQnPIqhqrbM
         V0DZg/FLBctLWEX9MVL3WGNuXWGJ1exY5mqO1E1oGMYvunQHp8ysnLUPJwfRh7p2vJ
         GeYE3KKqsYj+8E0QIvTj2xvn4nzXvcPO9xXAa0zdmuP9WN0fMlw+xJBHVE+365/Ga/
         HfyPpokueGgsW5AT9gY23n5TFb73N5a/AodADpxcfjITKScy/Jk+ay58HrtrELJe/b
         LE0Cdkvhg05BURtnCxUsJou/xQPFAIas8STTLYeoSlE4cByJPdiV0KeaRASEMEVqVN
         gMsyeYXofzamA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/13] btrfs: some fixes and updates around handling errors for tree mod log operations
Date:   Wed,  7 Jun 2023 20:24:24 +0100
Message-Id: <cover.1686164789.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This mostly helps avoid some unnecessary enomem failures when logging
tree mod log operations and replace some BUG_ON()'s when dealing with
such failures. There's also 2 bug fixes (the first two patches) and
some cleanups. More details on the changelogs.

Filipe Manana (13):
  btrfs: add missing error handling when logging operation while COWing extent buffer
  btrfs: fix extent buffer leak after failure tree mod log failure at split_node()
  btrfs: avoid tree mod log ENOMEM failures when we don't need to log
  btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()
  btrfs: do not BUG_ON() on tree mod log failure at balance_level()
  btrfs: rename enospc label to out at balance_level()
  btrfs: avoid unnecessarily setting the fs to RO and error state at balance_level()
  btrfs: abort transaction at balance_level() when left child is missing
  btrfs: abort transaction at update_ref_for_cow() when ref count is zero
  btrfs: do not BUG_ON() on tree mod log failures at push_nodes_for_insert()
  btrfs: do not BUG_ON() on tree mod log failure at insert_new_root()
  btrfs: do not BUG_ON() on tree mod log failures at insert_ptr()
  btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()

 fs/btrfs/ctree.c        | 204 ++++++++++++++++++++++++++++------------
 fs/btrfs/ctree.h        |   4 +-
 fs/btrfs/tree-mod-log.c | 148 ++++++++++++++++++++++-------
 3 files changed, 262 insertions(+), 94 deletions(-)

-- 
2.34.1

