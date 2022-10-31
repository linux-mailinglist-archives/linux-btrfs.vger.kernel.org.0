Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC8613432
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 12:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJaLLe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaLLd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 07:11:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2201FB847;
        Mon, 31 Oct 2022 04:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF6E1B815DE;
        Mon, 31 Oct 2022 11:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5518C433D6;
        Mon, 31 Oct 2022 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667214690;
        bh=7YmBhYVeDFrzS1hsd7DBgfZ85UL/8wACDPHpLw5wSK0=;
        h=From:To:Cc:Subject:Date:From;
        b=mdO9swI6x7uUEYbHqzV25VxS0Kc5pnhKAEuzZrCCMTDGo9G6SQyD5HsjVYYXmFT7J
         a0F+5zfDluRf0pRU9zjvBS6SOWXFRqvF04zCHY3HtEIg3BoCzDVsx80OSdq3S7C7m8
         yiVtclVDlnKL6v9BuHSo5FPdvFWro0qW6v4Ayzg3vje0F7gVmucciFTYuoRnNwcwqH
         jqGlNcFRbs+mr0B1Z9R20w3J6VOAkerwC2MjKr+UZkl7rFvYHnV/MQ8c6UTYeJ5463
         qteDv3LIDuHSzOn7/igkafTdIeGc/KwgPVc/cZWh6JqZbhpydz/gz9+Hnt9dF4mlTJ
         vZEYOaLECc2CQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/3] btrfs: add couple tests to check fiemap correctly reports extent sharedness
Date:   Mon, 31 Oct 2022 11:11:18 +0000
Message-Id: <cover.1667214081.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This adds two new btrfs specific tests to verify fiemap correctly reports
extent sharedness in a couple of scenarios recently fixed in kernel 6.1-rc2.
More details on the test files.

Filipe Manana (3):
  common/punch: fix flags printing for filter _filter_fiemap_flags
  btrfs: test that fiemap reports extent as not shared after deleting file
  btrfs: test fiemap reports extent as not shared after COWing it in snapshot

 common/punch        |  2 ++
 tests/btrfs/279     | 82 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/279.out | 39 +++++++++++++++++++++
 tests/btrfs/280     | 64 +++++++++++++++++++++++++++++++++++
 tests/btrfs/280.out | 21 ++++++++++++
 5 files changed, 208 insertions(+)
 create mode 100755 tests/btrfs/279
 create mode 100644 tests/btrfs/279.out
 create mode 100755 tests/btrfs/280
 create mode 100644 tests/btrfs/280.out

-- 
2.35.1

