Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C15B3313
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiIIJMA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiIIJL6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 05:11:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B94456A;
        Fri,  9 Sep 2022 02:11:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E475822967;
        Fri,  9 Sep 2022 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662714715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=svGDPDOlBsrr/PzVyaO8AuSzY/ZDrtuMQ12+XBnVxBs=;
        b=RLBjohMY6pdEMaLqrf0v3PyX6+x42o0Yuh5szP3JltpH1+PkbSf/82TOVeFMqmzOSr9ORP
        KZmFqUd/jKUcWrLWY9Esrvru9o42baCo0iFU/tPeUOXFwyHMFRhp00z/F5g5je9BIhvQZZ
        BTQNE4lAb59qUYj0potDj88zXwFQ7cc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DA9C32C142;
        Fri,  9 Sep 2022 09:11:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DDCD6DA8C5; Fri,  9 Sep 2022 11:06:32 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.0-rc5
Date:   Fri,  9 Sep 2022 11:06:31 +0200
Message-Id: <cover.1662664764.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
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

a few more fixes to zoned mode and one regression fix for chunk limit.
Please pull, thanks.

- zoned fixes:
  - fix how wait/wake up is done when finishing zone
  - fix zone append limit in emulated mode
  - fix mount on devices with conventional zones

- fix regression, user settable data chunk limit got accidentally
  lowered and causes allocation problems on some profiles (raid0, raid1)

----------------------------------------------------------------
The following changes since commit f2c3bec215694fb8bc0ef5010f2a758d1906fc2d:

  btrfs: add info when mount fails due to stale replace target (2022-08-23 22:15:21 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc4-tag

for you to fetch changes up to 5da431b71d4b9be3c8cf6786eff9e2d41a5f9f65:

  btrfs: fix the max chunk size and stripe length calculation (2022-09-06 17:49:58 +0200)

----------------------------------------------------------------
Johannes Thumshirn (1):
      btrfs: zoned: fix mounting with conventional zones

Naohiro Aota (1):
      btrfs: zoned: fix API misuse of zone finish waiting

Qu Wenruo (1):
      btrfs: fix the max chunk size and stripe length calculation

Shin'ichiro Kawasaki (1):
      btrfs: zoned: set pseudo max append zone limit in zone emulation mode

 fs/btrfs/ctree.h      |  2 --
 fs/btrfs/disk-io.c    |  1 -
 fs/btrfs/inode.c      |  7 ++--
 fs/btrfs/space-info.c |  2 +-
 fs/btrfs/volumes.c    |  3 ++
 fs/btrfs/zoned.c      | 99 +++++++++++++++++++++++++++------------------------
 6 files changed, 60 insertions(+), 54 deletions(-)
