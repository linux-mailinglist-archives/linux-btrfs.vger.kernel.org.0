Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122AE727CBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbjFHK14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjFHK1z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:27:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8A1FFE
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC34960A13
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA64C433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220073;
        bh=3l1XBbd+BXKn+btpmkw+zPuRUlNZkcfr3mmiY8GRXWk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X3y/yQ/n9YqOJHTpNlnSCq5EM5Nvo/4xjaIw1+SWO+cQyhroJc1LouXFyvfAG/ZAv
         Izq7Xb6tcQi0a3/8iaLQnTVlY2JC4pajVOFQGgSP2wm2+D+KpZtRttjs6AEAxY9/3/
         Wjz/BAPpZhLvtWA1T+7ak8Kmy4X3bJ01mMuTmLC8ERbXSbmPHKyIsncfaLP5suNm1U
         vKBrce68t6i8KYV4vGN79sbAEfY9rXSzTLUub6MSuRVlg4efgi7IBV7+bTM/ZImzxg
         Ku/XMJEmF69PRXq4bqhTi0fXPtFOiYFWuPL+Q0n5WiU4RZrvs9zdl8GGPnarhh2STp
         sJ69noodq5iFw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/13] btrfs: some fixes and updates around handling errors for tree mod log operations
Date:   Thu,  8 Jun 2023 11:27:36 +0100
Message-Id: <cover.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686164789.git.fdmanana@suse.com>
References: <cover.1686164789.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

V2: Add explicit error messages in patches 8/13 and 9/13.
    Add missing unlock and ref count drop of 'right' extent buffer to patch 12/13.
    Add missing extent buffer ref count drops for right and mid extent buffers in
    error paths of balance_level() to patch 13/13.
    Fix subject of patch 2/13 (removed duplicated word).
    Added Reviewed-by tags where appropriate.

Filipe Manana (13):
  btrfs: add missing error handling when logging operation while COWing extent buffer
  btrfs: fix extent buffer leak after tree mod log failure at split_node()
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

 fs/btrfs/ctree.c        | 221 +++++++++++++++++++++++++++++-----------
 fs/btrfs/ctree.h        |   4 +-
 fs/btrfs/tree-mod-log.c | 148 ++++++++++++++++++++-------
 3 files changed, 279 insertions(+), 94 deletions(-)

-- 
2.34.1

