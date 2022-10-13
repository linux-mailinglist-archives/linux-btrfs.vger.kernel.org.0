Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA55FD7D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJMKgh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 06:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJMKgg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 06:36:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A2B4896
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 03:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75B6EB81CF6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 10:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935CAC433D6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665657393;
        bh=L0rpJFX9VVU3M810aNZgr67qr6zVvD3WxPqClWGXz4A=;
        h=From:To:Subject:Date:From;
        b=hQ52azAQHho3yY67zmjmTh2Y65fTDCyzYw3XR3/gc0vFDrBJbg5RliHKrEh/d9n7U
         UGWknirjGFTz+VTwNqcwz+PWA77owa8Vpj03wRTHd/mlIl84fnLjQTRILpG4NJbcFS
         T/1erkLQgRX8gaitRdAdDf7ZzwCB7xbU/4DSXBoRLIolNZBsBjQ2VTV/cdTwF39pk9
         C6sAbUT2LFTaYj5Ef0KDdjXwRptdsvCAPUBf/UV3kgUOVnmYd8O1b8FwNsym/pWNf+
         4U69cXctZR74O3XemLHJNqYG7S+R4gRhUltMzaCGMHBDKUru9R7zwRAF7wHgUbtjt8
         813URXWnf2XOA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: drop no longer needed atomic allocation for tree mod log operations
Date:   Thu, 13 Oct 2022 11:36:24 +0100
Message-Id: <cover.1665656353.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We are still doing an atomic memory allocation for tree mod log operations
which is not needed anymore after we switch extent buffer locks to rw
semaphores. This replaces that atomic allocation with a GFP_NOFS one, and
then removes redundant gfp_t argument for btrfs_tree_mod_log_insert_key().

Filipe Manana (2):
  btrfs: switch GFP_ATOMIC to GFP_NOFS when fixing up low keys
  btrfs: remove gfp_t flag from btrfs_tree_mod_log_insert_key()

 fs/btrfs/ctree.c        | 16 ++++++++--------
 fs/btrfs/tree-mod-log.c |  4 ++--
 fs/btrfs/tree-mod-log.h |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.35.1

