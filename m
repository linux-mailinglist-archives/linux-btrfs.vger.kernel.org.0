Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1704B7093
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiBOOvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 09:51:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbiBOOuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 09:50:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5896129BBF;
        Tue, 15 Feb 2022 06:48:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9EF37210FA;
        Tue, 15 Feb 2022 14:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644936515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+yhpPTea/DqMlskYIss7cvQ5ZGd0scwjXa1I33ua2hg=;
        b=vCogXRX9gwyCVqmqrQoZpcqRCMT/RAnB+gHyB1EB8ZFVOUQfLs9dbBYVk75RE5Hos/Srbl
        /xLJBKlF9ibMbjqlFeMUOvXbFcIH25cHEhjCgJYA1X3F0uQkvRj6PNu1VEm94lzv4Ys0Ep
        K+q9HywEzRlYDjcCqPQ0i1CbVxOY7b0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 97523A3B89;
        Tue, 15 Feb 2022 14:48:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96B8FDA818; Tue, 15 Feb 2022 15:44:51 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.17-rc5
Date:   Tue, 15 Feb 2022 15:44:49 +0100
Message-Id: <cover.1644935941.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixups. Please pull, thanks.

* yield CPU more often when defragmenting a large file

* skip defragmenting extents already under writeback

* improve error message when send fails to write file data

* get rid of warning when mounted with flushoncommit

----------------------------------------------------------------
The following changes since commit 40cdc509877bacb438213b83c7541c5e24a1d9ec:

  btrfs: skip reserved bytes warning on unmount after log cleanup failure (2022-01-31 16:06:50 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc4-tag

for you to fetch changes up to 2e7be9db125a0bf940c5d65eb5c40d8700f738b5:

  btrfs: send: in case of IO error log it (2022-02-09 18:53:26 +0100)

----------------------------------------------------------------
Dāvis Mosāns (1):
      btrfs: send: in case of IO error log it

Filipe Manana (1):
      btrfs: get rid of warning on transaction commit when using flushoncommit

Qu Wenruo (2):
      btrfs: don't hold CPU for too long when defragging a file
      btrfs: defrag: don't try to defrag extents which are under writeback

 fs/btrfs/ioctl.c       |  5 +++++
 fs/btrfs/send.c        |  4 ++++
 fs/btrfs/transaction.c | 12 ++++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)
