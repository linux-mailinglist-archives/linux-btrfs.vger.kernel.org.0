Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632DE62305A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKIQpI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 11:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIQpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 11:45:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CAC26CE;
        Wed,  9 Nov 2022 08:45:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 454256198C;
        Wed,  9 Nov 2022 16:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA51DC433D6;
        Wed,  9 Nov 2022 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668012303;
        bh=L1VHbjXgUfD55+rqJ+AXP/m5O+iQQdA5dVZfMbVnhLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5r6SeLRmNIF5NOTDiqYYMvhHs75p2+1uIDOdnZ4kdASIwQVRfWc1eZJCah0w3dBX
         aud3jPq0mycGH1xm8BZ4RRDI8M7JLpPkXEySdqvlTyu9GAmsPzBu6Zjr7cOa9oQ8k7
         WRB04IXsvxkiD2f5TaboSpjCFi5MDqzjNCHsyl9hVqjqE1hRjGZdzmaLPe+MP5ESnk
         o4S7J9bRbvdYecBWFc6iVK9CCvBvqCGRyXRUtutkpmW/3d8leJNiG67DEOskpDf7mt
         Izjjns9fARhIbhzB9HCenJb1SYXIna4eUqKEQ3GbONAL14rwxaXnA7auDDuVr3qd4i
         p0RK5H4QejEQA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 0/3] btrfs: fix some test failures with btrfs-progs 5.19 and 6.0
Date:   Wed,  9 Nov 2022 16:44:55 +0000
Message-Id: <cover.1668011769.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667993961.git.fdmanana@suse.com>
References: <cover.1667993961.git.fdmanana@suse.com>
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

The output of some commands changed with btrfs-progs 5.19 and 6.0, as well
as the --leafsize/-l command line option was removed from mkfs. These make
some tests fail. This patchset changes the tests so that they work with the
new btrfs-progs versions as well as older versions.

v2: Updated patch 02/03, redirect mkfs output to log file and explicitly
    fail if mkfs failed.

Filipe Manana (3):
  btrfs/003: fix failure on new btrfs-progs versions
  btrfs/053: fix test failure when running with btrfs-progs v6.0+
  btrfs: fix failure of tests that use defrag on btrfs-progs v6.0+

 tests/btrfs/003 | 5 +++--
 tests/btrfs/021 | 4 +++-
 tests/btrfs/053 | 4 ++--
 tests/btrfs/256 | 4 +++-
 4 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.35.1

