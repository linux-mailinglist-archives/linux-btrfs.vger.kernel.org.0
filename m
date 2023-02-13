Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC4693DDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 06:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBMF04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 00:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMF0z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 00:26:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEAEB5A
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 21:26:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A42C820255
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676266012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EqszHPqocpq1mQD7ZNmt/Ojb/oUrBgCrpB9PoE1yv88=;
        b=Ozs/F0dza/80v6YTSUOLUFDyZYj8bq9+gsa/2Ys9Oob4ShiB2uotLIZHmJz03zFf10KG9U
        l/h6aNTHDPZ1MM7zXE7eNKUZiwdL8G16wP0Be/RQyvRLYzlZXfo7PbS3URsfdqpgE2C064
        4w2cUjMV9anXPIDX0D83jCf/JdHoFFY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBE5513A1F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lTL/KxvK6WOAbQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fixes for the cli test group
Date:   Mon, 13 Feb 2023 13:26:31 +0800
Message-Id: <cover.1676265837.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the current devel branch, there are two failures for the cli test group:

- cli/009
  This is caused by a very recent (only in devel branch) refactor for
  btrfstune, which removes the ability to customize the return value.

  Fix it by adding a new @ret argument for usage() helper.

- cli/017
  This exists for a while, and it's caused by a recent kernel change.

  Fix the test case to handle it better.

Qu Wenruo (2):
  btrfs-progs: make usage() call to properly return an exit value
  btrfs-progs: tests: cli: fix 017 test case failure

 check/main.c                                | 4 ++--
 cmds/device.c                               | 4 ++--
 cmds/filesystem.c                           | 2 +-
 cmds/qgroup.c                               | 2 +-
 cmds/quota.c                                | 4 ++--
 cmds/receive.c                              | 4 ++--
 cmds/restore.c                              | 4 ++--
 cmds/subvolume-list.c                       | 2 +-
 cmds/subvolume.c                            | 2 +-
 common/help.c                               | 6 +++---
 common/help.h                               | 2 +-
 image/main.c                                | 3 +--
 mkfs/main.c                                 | 3 +--
 tests/cli-tests/017-fi-show-missing/test.sh | 2 +-
 tune/main.c                                 | 3 +--
 15 files changed, 22 insertions(+), 25 deletions(-)

-- 
2.39.1

