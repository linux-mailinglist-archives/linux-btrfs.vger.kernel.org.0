Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA62353E8E5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiFFJl0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiFFJlY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 05:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07041CC5C0
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 02:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E6861335
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCE5C385A9
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654508482;
        bh=WtTV7nyrQjarwdWf1J55pmq9AMmC89w1vZa/szezE2o=;
        h=From:To:Subject:Date:From;
        b=UPdcGgpv3meqpBHkjv9N5XeqQdicNT12B6WGgQhL+/i/hAiUCtM57OwinbkYbb5oz
         qydo5aeh0yCUOQAVWEe4vzAcuBxPu8+vqiFwweBjaQtcc8V7KH4tSR/rwwaAwKOdK0
         jZTfJqE3Civ17/ktdIdWKUivjFFKriF5cQYAtt9+jL0tYMJE8dxvX/ETUjZdRPUmJV
         FpbFXfNu9bsRkkeSNPlfk9JHXaHpXxHHCpipyPqdOK/apm9YPIIC9DgMwMICiUEE5Y
         6z3nwWQYlkKPum5+xxKz14omXub/NRpneoOCumz1+yAGHRN/pr9QpzPm3MZ4RlZh7Z
         7/b4IRwFE4QtA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: a couple bug fixes around reflinks and fallocate
Date:   Mon,  6 Jun 2022 10:41:16 +0100
Message-Id: <cover.1654508104.git.fdmanana@suse.com>
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

This patchset fixes a couple of bugs, the first one exclusive for reflink
operations while the second one applies to reflink, fallocate and hole
punching operations. Finally the third patch just removes some BUG_ON()s
that are really not needed.
All the patches are independent of each other, they could have been sent
out as individual patches.

Filipe Manana (3):
  btrfs: fix race between reflinking and ordered extent completion
  btrfs: add missing inode updates on each iteration when replacing
    extents
  btrfs: do not BUG_ON() on failure to migrate space when replacing
    extents

 fs/btrfs/ctree.h   |  2 ++
 fs/btrfs/file.c    | 25 +++++++++++++++++++++++--
 fs/btrfs/inode.c   |  1 +
 fs/btrfs/reflink.c | 16 ++++++++++++----
 4 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.35.1

