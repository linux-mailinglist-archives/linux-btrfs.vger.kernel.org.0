Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08AA6F6974
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjEDLEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjEDLEg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523B19A2
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D1A46129B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A18C433D2
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198271;
        bh=EGjOFHkl+N/3kWIxZlYhT0VaaVBTvY8BXBsDAEi4bRs=;
        h=From:To:Subject:Date:From;
        b=H1GvN6kqRhLM4er+jGfFU5IhKiWDzjAf4iDdHHkp+m1cAcsQ0wwujuRE4fHhOZNGO
         z1jyKNTG4B4cNsaxjUgrTIeE20In2tmzBBUVKibR1awsAtoL+eOu3BxCv5dwKuHkBj
         h8eAlR7ES79x06HrfqmIJKdbACM/DI+FUwk5HDZ3MWPxMxrDKYvo+mco6ZtXBJSfl/
         xOqSnV2iYTRm4YjroylXWwJ2UT97MCrassRdiSL0aFQ67C4/gaVUNWSm0TBuDzZcT+
         x1WemJKVC0F1TMvomyZhRuF76QZnuq+GgjCX6BUoXyPInc27tAFODgsMnCJc7JDw/m
         Ryu6xA8ZuBo9A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9] btrfs: some free space cache fixes and updates
Date:   Thu,  4 May 2023 12:04:17 +0100
Message-Id: <cover.1683196407.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Several updates to the free space cache code (most of it to the in memory
data structure, shared between the free space cache and the free space
tree). A bug fix, some cleanups, minor optimizations and adding several
asserts to verify we are holding the necessary lock(s) when udpating the
in memory space cache - this was motivated by an attempt to debug an
invalid memory access when manipulating the in memory free space cache,
as I suspected we had some code path not taking a required lock before
manipulating the in memory red black tree of free space entries.

Filipe Manana (9):
  btrfs: fix space cache inconsistency after error loading it from disk
  btrfs: avoid extra memory allocation when copying free space cache
  btrfs: avoid searching twice for previous node when merging free space entries
  btrfs: use precomputed end offsets at do_trimming()
  btrfs: simplify arguments to tree_insert_offset()
  btrfs: assert proper locks are held at tree_insert_offset()
  btrfs: assert tree lock is held when searching for free space entries
  btrfs: assert tree lock is held when linking free space
  btrfs: assert tree lock is held when removing free space entries

 fs/btrfs/free-space-cache.c | 111 +++++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 39 deletions(-)

-- 
2.35.1

