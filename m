Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0C5F4DA8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 04:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJECZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 22:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJECZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 22:25:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3C1E708
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 19:25:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3054C21979
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664936732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7QPZOmdCRR/LwgYBnN6zIGU5yx7xPW8USyp0Y7+O9HY=;
        b=kf/HPlYcgoK2JsAcJTgPMzf0PtxCMMvRzn9u0pmD1ZZfaUCJ16w4tzVSpaZmOLw76DWYBW
        53Pi84H8QQAM9JqeHv1AGjTA/24XCnzgnDv2zzlQ850N9l39n2J1NUHFekZ1s+uK/t1DsB
        /9QR7jspBrNyLzH7SbmhVBQ7Du7Dnqo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8548313345
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j+3uExvrPGPddgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Oct 2022 02:25:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: selftests fixes
Date:   Wed,  5 Oct 2022 10:25:11 +0800
Message-Id: <cover.1664936628.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are 3 bugs exposed during my tests for unified mkfs features, and
they are all from the selftest itself:

- check_min_kernel_version() doesn't handle 6.x kernels at all
  The original check never handles major number check properly.
  And when we change major number, returns in correct number now.

- Missing a space between "!" and function call
  This bug is there for a long time. 

  Without previous fix, one may incorrectly remove the "!" and cause
  new problems.

- Convert/022 doesn't check if we have support for reiserfs

Qu Wenruo (3):
  btrfs-progs: tests: fix the wrong kernel version check
  btrfs-progs: mkfs-tests/025: fix the wrong function call
  btrfs-progs: convert-tests/022: add reiserfs support check

 tests/common                                  | 23 +++++++++++++++----
 .../022-reiserfs-parent-ref/test.sh           |  5 ++++
 tests/mkfs-tests/025-zoned-parallel/test.sh   |  2 +-
 3 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.37.3

