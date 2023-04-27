Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEEB6F0663
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbjD0NLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243337AbjD0NLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 09:11:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228C2D79
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 06:10:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 829821FE28
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 13:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682601057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ab+TGJrigxAqH0tdLGSP+oV4nCVomTD+zxZ3iMDw8Rk=;
        b=iQQ205Az0kTpKSsJSMsTuNDCv0ig7GNMcg9Tn0md60O/nIAqTKwtKeOUMevlqtAJBj06xg
        7j1u4qeQziVYCyrnAquU/SloKe0PLUYwzv7VjV6P0JwbjmPglIQMVG/5XbYhX84VENrWoR
        jD92o5Rzw1u7TA/nrXMS776mHxqluCo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 774672C141
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 13:10:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9C559DA8D8; Thu, 27 Apr 2023 15:10:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.3
Date:   Thu, 27 Apr 2023 15:10:44 +0200
Message-Id: <20230427131044.6804-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
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

btrfs-progs version 6.3 have been released.

There are some fixes and tweaks, the experimental status of block-group-tree
has been removed, namely the conversion but please still use it with care.

Otherwise there's nothing interesting from users' POV, more documentation is
being moved from archived wiki, updated tests.

The CI on github has been extended to cover devel and pre-release branches,
further enhancements are planned to do e.g. quick build tests for pull requests
or use self-hosted runners for heavier tests that may need to run against a
recent kernel. (https://github.com/kdave/btrfs-progs/actions)

Release process now uses more of the github features, so besides the tag itself
there's also a release with changelog (https://github.com/kdave/btrfs-progs/releases).
This allows to add "artifacts" i.e. other files besides the sources.

There are now static binaries published along with the release. They're built
inside the CI workflow "Static binaries" (also available there for download).
The upload is still done from an intermediate host so if you don't trust github
CI or me copying the files as-is, please build and use your own.

Please let me know if you have suggestions for improvements or if you find
problems with the CI/release things. It's new to me and I'm sure the are
already best practices to follow.

Changelog:
   * mkfs: option -R deprecated, options unified in -O (-R still works)
   * mkfs: fix potential race with udev leading to EBUSY due to repeatedly
     opened file descriptors
   * block-group-tree is out of experimental mode
      * available as 'mkfs.btrfs -O block-group-tree'
      * btrfstune can do in-place conversion to/from (use with care)
   * balance: fix recognizing old and new syntax
   * subvol snapshot: specific error if a failure is caused by an active swapfile
   * tree-stats: rephrase warning when run on a mounted filesystem
   * completion: 'filesystem du' also completes files
   * check: fix docs, help text and warning that --force + --repair works on a
     mounted filesystem
   * build: fix static build when static libudev is available
   * documentation:
      * more updates from wiki, developer docs, changelogs
      * reformatting
      * updates and fixes
   * other:
      * test updates and fixes
      * CI cleanups and old files removed
      * integration with Github actions

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
