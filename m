Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423384EC698
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiC3OdT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346902AbiC3Oc6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 10:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B404091E
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 07:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46223B81D4A
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 14:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67780C340EE
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648650671;
        bh=KdRieTSPj9unDt0Jo4Tf6HwO3VoxVKeDLSYV+LeyaHQ=;
        h=From:To:Subject:Date:From;
        b=HsPVV9iWsJaPETvmeNAKtlDR6p7h1KCjgs6QIV/lG+bzUGypuaXUrRKmI+mouHfn3
         EW+6hzP8E/4xNIxKBG6G896/YaUdIKIBl93+9P4wrWNrPl6X8JTGkOJY8N8ogasu5Y
         murXcI/fNX9i+rXelBqFbdadhl8ZlnWu7ktuqzOarUmMpb/GjGAML4PPNvK5+9xnDT
         FVQfz4cO0kSDzusAhd1YFVjvPmBf0K1bBCBd+UYgXvxJtXp9zk+lAyzSPf4TqQmnjx
         cRP7Dfx0RcHtLnOpiZfwHO065uzXSgvzNs6LLzrN3nef3vp9Tj761S6d3vnoJT/I4Q
         fcsx0OLeRAA7A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some refactor and cleanup for NOCOW write paths
Date:   Wed, 30 Mar 2022 15:31:05 +0100
Message-Id: <cover.1648650280.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

This refactors some duplicated NOCOW checks into a single helper function,
plus it removes some no longer needed logic. This came out some in progress
work on the NOCOW paths, but has it's fairly indepedent of that work, it
is being sent out in a separate patchset.

Filipe Manana (2):
  btrfs: move common NOCOW checks against a file extent into a helper
  btrfs: do not test for free space inode during NOCOW check against
    file extent

 fs/btrfs/inode.c | 428 ++++++++++++++++++++++++-----------------------
 1 file changed, 216 insertions(+), 212 deletions(-)

-- 
2.33.0

