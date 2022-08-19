Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA5599BA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348550AbiHSMGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 08:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiHSMGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 08:06:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F8100963;
        Fri, 19 Aug 2022 05:06:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 03DF42020E;
        Fri, 19 Aug 2022 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660910764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=s8JuKXuquxAHWWI+QjuKLmXu6m/+exD+rUksSV7bL9U=;
        b=pGr9BqV15xyOVLEeTm7Gc+cpOYlTyIDe0UvexnFuFVkegZ6kh6jvSu3pCQ35YMGxf+VenF
        i6Y/STjbx5bjc9o2bm0rKfsK1oeVz38UfUsYKTdCj5xjbO3BEXGbpXILbc5CWYKDl91o9b
        JJyrSRx+IoQbJGlzU5YT4H9wPGsYOEk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D298B13AC1;
        Fri, 19 Aug 2022 12:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t8BqMqt8/2JpPQAAMHmgww
        (envelope-from <dsterba@suse.com>); Fri, 19 Aug 2022 12:06:03 +0000
Date:   Fri, 19 Aug 2022 14:00:51 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.0-rc2
Message-ID: <cover.1660908668.git.dsterba@suse.com>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few short fixes and a lockdep warning fix (needs moving some code).
Please pull, thanks.

- tree-log replay fixes
  - fix error handling when looking up extent refs
  - fix warning when setting inode number of links

- relocation fixes
  - reset block group read-only status when relocation fails
  - unset control structure if transaction fails when starting to
    process a block group
  - add lockdep annotations to fix a warning during relocation where
    blocks temporarily belong to another tree and can lead to reversed
    dependencies

- tree-checker verifies if extent items don't overlap

----------------------------------------------------------------
The following changes since commit 0b078d9db8793b1bd911e97be854e3c964235c78:

  btrfs: don't call btrfs_page_set_checked in finish_compressed_bio_read (2022-07-25 19:56:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc1-tag

for you to fetch changes up to 899b7f69f244e539ea5df1b4d756046337de44a5:

  btrfs: tree-checker: check for overlapping extent items (2022-08-17 16:20:25 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix lost error handling when looking up extended ref on log replay
      btrfs: fix warning during log replay when bumping inode link count

Josef Bacik (4):
      btrfs: reset RO counter on block group if we fail to relocate
      btrfs: move lockdep class helpers to locking.c
      btrfs: fix lockdep splat with reloc root extent buffers
      btrfs: tree-checker: check for overlapping extent items

Zixuan Fu (1):
      btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()

 fs/btrfs/block-group.c  |  4 ++-
 fs/btrfs/ctree.c        |  3 ++
 fs/btrfs/ctree.h        |  2 ++
 fs/btrfs/disk-io.c      | 82 --------------------------------------------
 fs/btrfs/disk-io.h      | 10 ------
 fs/btrfs/extent-tree.c  | 18 +++++++++-
 fs/btrfs/extent_io.c    | 11 +++++-
 fs/btrfs/locking.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/locking.h      | 14 ++++++++
 fs/btrfs/relocation.c   |  9 ++++-
 fs/btrfs/tree-checker.c | 25 ++++++++++++--
 fs/btrfs/tree-log.c     |  8 +++--
 12 files changed, 176 insertions(+), 101 deletions(-)
