Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089126F4FDC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 08:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjECGEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 02:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECGEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 02:04:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6A72D6B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 23:04:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48CA0222BF
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683093842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9PwmFNq+rthkMU+ZeWYjpfW982kO0APnujoTNFKApa0=;
        b=czCKkYa487sQ3Zs32ovOMmyrtCglX/jcCpYRch43otICTqIUugz0AadndYab7g/PEwckd0
        dH0mLBPV4/b6dXzyXmKh5p961yi/GlYFnaxZVtX+slbwmA64LpI3uLXi1m0Fsdfdy0nM/K
        fjWrWI/1zWyq/6OMogIu2svoD2ROtQk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FAF213584
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tLVsFVH5UWSTJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:04:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/7] btrfs-progs: fix -Wmissing-prototypes warnings and enable that warning option
Date:   Wed,  3 May 2023 14:03:36 +0800
Message-Id: <cover.1683093416.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have at least one case that some function is exported but never got
utilized in the first place.

Let's prevent this problem from happening again by enable
-Wmissing-prototypes to debug builds at least.

Fixes for  the existing warnings are split into several patches:

- Remove unused functions
  Two patches, the first is to remove a function that never got
  utilized from the introduction.

  The second is to remove a very old feature (only for <3.12 kernels)
  in libbtrfs.
  In fact this functionality for fs without an UUID tree is already
  broken during previous cleanups.
  (Need to export subvol_uuid_search_add() and
   subvol_uuid_search_finit(), as it's callers' responsibility to
   search for the target subvolume by themselves)

  And since no one is complaining ever since, there is really no need
  to maintain such an old and deprecated feature in libbtrfs.

- Fixes for crypto related function
  Two patches, one for each csum algo (blake2 and sha256).
  Involves extra declarations in the headers.

- Trivial fixes
  Mostly unexport and add needed headers.

Qu Wenruo (7):
  btrfs-progs: remove function btrfs_check_allocatable_zones()
  btrfs-progs: libbtrfs: remove the support for fs without uuid tree
  btrfs-progs: crypto/blake2: remove blake2 simple API
  btrfs-progs: crypto/blake2: move optimized declarations to blake2b.h
  btrfs-progs: crypto/sha: declare the x86 optimized implementation
  btrfs-progs: fix -Wmissing-prototypes warnings
  btrfs-progs: Makefile: enable -Wmissing-prototypes

 Makefile              |   3 +-
 cmds/qgroup.c         |   2 +-
 cmds/reflink.c        |   2 +-
 cmds/subvolume-list.c |   2 +-
 common/device-utils.c |   2 +-
 common/utils.c        |   2 +-
 crypto/blake2.h       |   5 +
 crypto/blake2b-ref.c  |   8 -
 crypto/sha.h          |   3 +
 crypto/sha256-x86.c   |   2 +
 kernel-shared/ulist.c |   2 +-
 kernel-shared/zoned.c |  60 +------
 libbtrfs/send-utils.c | 396 ------------------------------------------
 libbtrfs/send-utils.h |  20 ---
 tune/change-csum.c    |   1 +
 tune/change-uuid.c    |   1 +
 tune/convert-bgt.c    |   1 +
 tune/seeding.c        |   1 +
 tune/tune.h           |   2 +
 19 files changed, 25 insertions(+), 490 deletions(-)

-- 
2.39.2

