Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB085A3DA3
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Aug 2022 15:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiH1NCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Aug 2022 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH1NCs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Aug 2022 09:02:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7B310FF1;
        Sun, 28 Aug 2022 06:02:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A4C121DC0;
        Sun, 28 Aug 2022 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661691766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=YSvdQwlgWPKhGLwU84wvz+ZlbVEakmeJ+BiVWWH+6y4=;
        b=D7+3+iIUhd5CAuTCxekl905LZORif3j9tM1rjru5wZos4AeeOwLeEV5NB4W0jKC65t87fj
        UT1yx6EGAQq4Lt+OMxmZQp3oQB5kcc4sl/+i2hR6e4/Oc0Q3MiMcdyr88gw0wQYLyHSeeM
        0LZfi8YhX9s0qGnQxHN91+bDasKPF9Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1189D13ACF;
        Sun, 28 Aug 2022 13:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ldZRA3ZnC2PWRAAAMHmgww
        (envelope-from <dsterba@suse.com>); Sun, 28 Aug 2022 13:02:46 +0000
Date:   Sun, 28 Aug 2022 14:57:29 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for v6.0-rc3
Message-ID: <cover.1661690960.git.dsterba@suse.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

a few more fixes and regressions. Please pull, thanks.

- fixes:
  - check that subvolume is writable when changing xattrs from security
    namespace
  - fix memory leak in device lookup helper
  - update generation of hole file extent item when merging holes
  - fix space cache corruption and potential double allocations; this is
    a rare bug but can be serious once it happens, stable backports and
    analysis tool will be provided
  - fix error handling when deleting root references
  - fix crash due to assert when attempting to cancel suspended device
    replace, add message what to do if mount fails due to missing
    replace item

- regressions:
  - don't merge pages into bio if their page offset is not contiguous
  - don't allow large NOWAIT direct reads, this could lead to short
    reads eg. in io_uring

----------------------------------------------------------------
The following changes since commit 899b7f69f244e539ea5df1b4d756046337de44a5:

  btrfs: tree-checker: check for overlapping extent items (2022-08-17 16:20:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc3-tag

for you to fetch changes up to f2c3bec215694fb8bc0ef5010f2a758d1906fc2d:

  btrfs: add info when mount fails due to stale replace target (2022-08-23 22:15:21 +0200)

----------------------------------------------------------------
Anand Jain (2):
      btrfs: replace: drop assert for suspended replace
      btrfs: add info when mount fails due to stale replace target

Filipe Manana (2):
      btrfs: update generation of hole file extent item when merging holes
      btrfs: fix silent failure when deleting root reference

Goldwyn Rodrigues (1):
      btrfs: check if root is readonly while setting security xattr

Josef Bacik (1):
      btrfs: don't allow large NOWAIT direct reads

Omar Sandoval (1):
      btrfs: fix space cache corruption and potential double allocations

Qu Wenruo (1):
      btrfs: don't merge pages into bio if their page offset is not contiguous

Zixuan Fu (1):
      btrfs: fix possible memory leak in btrfs_get_dev_args_from_path()

 fs/btrfs/block-group.c | 47 +++++++++++++++--------------------------------
 fs/btrfs/block-group.h |  4 +---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/dev-replace.c |  5 ++---
 fs/btrfs/extent-tree.c | 30 ++++++------------------------
 fs/btrfs/extent_io.c   | 33 +++++++++++++++++++++++++++++----
 fs/btrfs/file.c        |  2 ++
 fs/btrfs/inode.c       | 14 ++++++++++++++
 fs/btrfs/root-tree.c   |  5 +++--
 fs/btrfs/volumes.c     |  5 ++++-
 fs/btrfs/xattr.c       |  3 +++
 11 files changed, 79 insertions(+), 70 deletions(-)
