Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01A84E5633
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiCWQVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiCWQVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822B270044
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA49B61846
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61D8C340E8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052379;
        bh=nYLekwpOsDe3qvY1PZwBbmyEWLpePyU20oXSMKQSZIU=;
        h=From:To:Subject:Date:From;
        b=ZYwRX4AtWylqGxC5YmpLlAYWASJoWZkgK+m3wf8HPHAJZK2iXGQu4c3qQ6eUFrnOK
         FWy/ZGJ/FUQgT111971Dcyltce2SjRbc0EQZBA4GWmFRhhrH0sJbNg7afKjvismvOC
         Wuw+1P9cTm9JHghn7fDg/9U95coNePCvfoGjtFcof2MO6SNQfi1FJHasTNwcX13KQE
         B3YGN5S0NtTPeEi8efyc21iO5ADbpYpQFRJx+6dNgEa5q16uvZcidiVAHNRt3H/Bux
         BJmzwIm5qIIIM+8PWonhWx6t0RRPDobB7jmXT3/mXqyW/0E/+XyCRHNLOWvB7NAVXm
         1SVHgC36gesOw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: some speedups around nowait dio
Date:   Wed, 23 Mar 2022 16:19:22 +0000
Message-Id: <cover.1648051582.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset makes our direct IO code behave better for NOWAIT writes,
avoiding blocking in several places for potentially long periods due to
waits for IO. It also removes running the same nocow checks twice (which
can be expensive) and doing extra path allocations. The last patch in
the series has a test and the results I got before and after applying
this patchset.

Filipe Manana (8):
  btrfs: avoid blocking on page locks with nowait dio on compressed range
  btrfs: avoid blocking nowait dio when locking file range
  btrfs: avoid double nocow check when doing nowait dio writes
  btrfs: stop allocating a path when checking if cross reference exists
  btrfs: free path at can_nocow_extent() before checking for checksum items
  btrfs: release path earlier at can_nocow_extent()
  btrfs: avoid blocking when allocating context for nowait dio read/write
  btrfs: avoid blocking on space revervation when doing nowait dio writes

 fs/btrfs/ctree.h          |   5 +-
 fs/btrfs/delalloc-space.c |   9 +--
 fs/btrfs/extent-tree.c    |   9 +--
 fs/btrfs/file.c           | 104 +++++++++++-----------------------
 fs/btrfs/inode.c          | 116 ++++++++++++++++++++++++++++----------
 fs/btrfs/qgroup.c         |   5 +-
 fs/btrfs/qgroup.h         |  12 ++--
 fs/btrfs/relocation.c     |   3 +-
 fs/btrfs/root-tree.c      |   3 +-
 9 files changed, 144 insertions(+), 122 deletions(-)

-- 
2.33.0

