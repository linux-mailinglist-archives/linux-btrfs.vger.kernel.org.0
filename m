Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0968055326D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350574AbiFUMpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350547AbiFUMpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 08:45:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6B1EC5F;
        Tue, 21 Jun 2022 05:45:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C85F1F8A3;
        Tue, 21 Jun 2022 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655815552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gOBExk5CeiV+de5yPYSWWhO9HrXnqPSCpeLO4mmWiBc=;
        b=YXhDQgpM1Uo0PIOJUVO9FnjzR0ytrwEfg74iGRDftfhFLVs8mpTkhhw7b59Uj+KDFje6vJ
        l+7nVPRBX0cCJzGLM5SeyT9SDCHZ/TSzhISTMBSLBmVJFF81FWJVZ+fQ9j5UItRgCvUez9
        0m8sDhAQLIpj8wsMgwxB/0R2i16G590=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 42DB12C141;
        Tue, 21 Jun 2022 12:45:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4627ADA853; Tue, 21 Jun 2022 14:41:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Fixes for btrfs 5.19-rc4
Date:   Tue, 21 Jun 2022 14:41:15 +0200
Message-Id: <cover.1655815078.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes. Please pull thanks.

- print more error messages for invalid mount option values

- prevent remount with v1 space cache for subpage filesystem

- fix hang during unmount when block group reclaim task is running


----------------------------------------------------------------
The following changes since commit 0a05fafe9def0d9f0fbef3dfc8094925af9e3185:

  btrfs: zoned: introduce a minimal zone size 4M and reject mount (2022-05-17 20:15:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc3-tag

for you to fetch changes up to e3a4167c880cf889f66887a152799df4d609dd21:

  btrfs: add error messages to all unrecognized mount options (2022-06-07 17:29:50 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: add error messages to all unrecognized mount options

Filipe Manana (1):
      btrfs: fix hang during unmount when block group reclaim task is running

Qu Wenruo (1):
      btrfs: prevent remounting to v1 space cache for subpage mount

 fs/btrfs/disk-io.c | 13 +++++++++++--
 fs/btrfs/super.c   | 47 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 9 deletions(-)
