Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA0D4D60B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 12:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348282AbiCKLgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 06:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiCKLgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 06:36:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A1214F283
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 03:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 143D561B23
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C41C340E9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646998538;
        bh=69DwyNo22Rnym4rDadEAb1WBoyjyHcGbCyc6h6XdwdY=;
        h=From:To:Subject:Date:From;
        b=ukH2RckzcVHTAIqQuUOykdEkv/3ABSt0lIMImAhheYmzGB5CrdsrAiWuvBgEtVYeZ
         5oK/u5iemOimzhrkqTydOJZmWbUbg7AfF5qQFYDb28OjjZcfaMTkag8XMcDgKB2mJ2
         ojEaOzTt+bCZayEAdpPAeKsO1lqHJpl/BeuFJ9PF9dR2R3deSjN5FjeI6dFPiR5Z6F
         LBk9E2PAbD2snKYT/H63h8CbLuWhBk6gkMZabxO0BgFXV2s9MJ4nabzqj1hgqhSz6n
         0czJg/tbng7cnELWCrOw0XnOkJZIGa9PDTG01VheqLEMOG+Pi1W+YuEjYnHceDHtm3
         wa/WeRl1O5tvQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: fix inefficiencies when reading extent buffers and some cleanups
Date:   Fri, 11 Mar 2022 11:35:30 +0000
Message-Id: <cover.1646998177.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Fix a couple inefficiencies when reading an extent buffer while searching
a btree plus a couple cleanups in the same area. Spotted while working on
other stuff, but this is separate and independent enough to be in its own
small patchset.

Filipe Manana (4):
  btrfs: avoid unnecessary btree search restarts when reading node
  btrfs: release upper nodes when reading stale btree node from disk
  btrfs: update outdated comment for read_block_for_search()
  btrfs: remove trivial wrapper btrfs_read_buffer()

 fs/btrfs/ctree.c    | 57 ++++++++++++++++++++++++++++++---------------
 fs/btrfs/disk-io.c  | 16 ++++---------
 fs/btrfs/disk-io.h  |  4 ++--
 fs/btrfs/qgroup.c   |  2 +-
 fs/btrfs/tree-log.c |  9 +++----
 5 files changed, 50 insertions(+), 38 deletions(-)

-- 
2.33.0

