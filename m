Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693C27927AF
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjIEQDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353745AbjIEHwP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 03:52:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4FCCB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 00:52:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D658211B7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693900328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IinGMK0dG+S73irNwFie4MS7xok2MtWz2KkIF/ZTsUQ=;
        b=R2PqSySulmFbScnfSMlrIy88SyHez6OpBWtZAFqM9lFfVnzuK6apUBttG7qP/8/g6uScol
        lNz4pKeA8veR2nMhRDveVUw8Rde/aUJNFR1BXmtqIPKKmO8WfHZYbsENDSajhSfbq+v8qZ
        UfSKnQPXWij0lYrWbyfJjlwS/ZsJqZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E633713911
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wBjTKife9mTFeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 07:52:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs-progs: cmds/tune: add set/clear features
Date:   Tue,  5 Sep 2023 15:51:42 +0800
Message-ID: <cover.1693900169.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the first step to convert btrfstune functionality to "btrfs
tune" subcommand group.

For now only binary features, aka set and clear, is supported,
thus uuid and csum change is not yet implemented.
(Both need their own subcommand groups other than set/clear groups)

And even for set/clear, there is some changes to btrfstune:

- Merge seed feature into set/clear
  To enable seeding, just go "btrfs tune set seed <device>".

- All supported features can be checked by "list-all" feature
  Please note that, "btrfs tune set list-all" and
  "btrfs tune clear list-all" will have different output.

  The reason is some fundamental features like no-holes can not be
  disabled.


Qu Wenruo (7):
  btrfs-progs: export btrfs_feature structure
  btrfs-progs: cmds: add "btrfs tune set" subcommand group
  btrfs-progs: cmds/tune: add set support for free-space-tree feature
  btrfs-progs: cmds/tune: add set support for block-group-tree feature
  btrfs-progs: cmds/tune: add set support for seeding device
  btrfs-progs: cmds/tune: add "btrfs tune clear" subcommand
  btrfs-progs: tests/cli: add a test case for "btrfs tune" subcommand

 Documentation/btrfs-tune.rst           |  47 +++
 Documentation/btrfs.rst                |   5 +
 Documentation/conf.py                  |   1 +
 Documentation/man-index.rst            |   1 +
 Makefile                               |   4 +-
 btrfs.c                                |   1 +
 cmds/commands.h                        |   1 +
 cmds/tune.c                            | 448 +++++++++++++++++++++++++
 common/fsfeatures.c                    |  53 ---
 common/fsfeatures.h                    |  50 +++
 tests/cli-tests/018-btrfs-tune/test.sh |  40 +++
 11 files changed, 596 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/btrfs-tune.rst
 create mode 100644 cmds/tune.c
 create mode 100755 tests/cli-tests/018-btrfs-tune/test.sh

--
2.42.0

