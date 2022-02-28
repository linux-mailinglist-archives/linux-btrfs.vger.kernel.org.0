Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3AD4C71B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiB1QaO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 11:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiB1QaN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 11:30:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5302B4B1D3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 08:29:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E266161226
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 16:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B919AC340E7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646065773;
        bh=I3eET9CzICO2XFu+gzicmULbkr96KPVdTpz1DK+/KbA=;
        h=From:To:Subject:Date:From;
        b=IMtMZWbTIzSSxZF80im35jvAEZuz2qMEYTL1FGSHoCip9+dLuEAoSygMxnHkmWOoO
         v0LWIN5sxeQbpe1We2ELPOlSMZxWk76pvxyuvTzGgbyCWkMXtyC4OkqVo6+aa9uAfC
         g/tPnOs8W2j8QZzhOHbScoY8rnVLDEINQu33emn4gmNFNcd0oV/dpZ//QjR66MSKut
         SvvumUZpKHYATa8zie3wMfIac7Cm6M2BDYhQdjtTOhg35U6EAmN/RnKDwiuo3Co3sQ
         ZQJN4oAMUF2lZUG9noG03HfH0/Z21TbY1YYOU5jp7L1vP/Ffa7tbEt767hMlkY5F1h
         f7nCsRnNxRs4Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix missing delayed items run after unlink during log replay
Date:   Mon, 28 Feb 2022 16:29:27 +0000
Message-Id: <cover.1646064823.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This fixes a couple places that miss running delayed items after doing an
unlink during log replay. The first patch is the actual fix, while the
second one is just a small refactoring to avoid duplication.

Filipe Manana (2):
  btrfs: add missing run of delayed items after unlink during log replay
  btrfs: add and use helper for unlinking inode during log replay

 fs/btrfs/tree-log.c | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

-- 
2.33.0

