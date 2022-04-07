Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA04F74E0
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 06:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiDGEmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 00:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiDGEmI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 00:42:08 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E19D65E0
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 21:40:07 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1ncJwE-00026e-G8 by authid <merlin>; Wed, 06 Apr 2022 21:40:06 -0700
Date:   Wed, 6 Apr 2022 21:40:06 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220407044006.GB25669@merlins.org>
References: <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org>
 <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
 <20220406203445.GE14804@merlins.org>
 <CAEzrpqdW-Kf7agSfTy_EK6UYUt2Wkf53j-WTzKjSPXWYgEUNkw@mail.gmail.com>
 <20220406205621.GF3307770@merlins.org>
 <CAEzrpqekB7GZ7wytx-Q2D7AnidBwVK2P5sc-NcBww0J666M5oA@mail.gmail.com>
 <20220407010819.GG14804@merlins.org>
 <CAEzrpqcFRaq9vrfLi_VcxWi9ZQGj+LgpXr5xwzw-2vWYHM6vJg@mail.gmail.com>
 <20220407043717.GA25669@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407043717.GA25669@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Damn, it's hosed so badly that even sysrq-o isn't working, never seen
that before.

[733866.717217] sysrq: Terminate All Tasks
[733866.740424] elogind-daemon[9054]: Received signal 15 [TERM]
[733868.540292] sysrq: Emergency Remount R/O
[733870.249149] sysrq: Emergency Sync
[733904.793816] BUG: workqueue lockup - pool cpus=6 node=0 flags=0x1 nice=0 stuck for 988s!
[733904.818717] Showing busy workqueues and worker pools:
[733904.834771] workqueue events: flags=0x0
[733904.847171]   pwq 12: cpus=6 node=0 flags=0x1 nice=0 active=5/256 refcnt=6
[733904.847174]     pending: cache_reap, drm_fb_helper_damage_work [drm_kms_helper], free_work, do_emergency_remount, do_sync_work
[733904.847205] workqueue writeback: flags=0x4a
[733904.917846]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/256 refcnt=4
[733904.917849]     in-flight: 8793:wb_workfn, 8613:wb_workfn
[733904.917868] workqueue btrfs-delalloc: flags=0xe
[733904.969635]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/8 refcnt=4
[733904.969637]     in-flight: 8795:btrfs_work_helper, 29765:btrfs_work_helper
[733904.969652] workqueue btrfs-worker: flags=0xe
[733905.024811]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=1/8 refcnt=3
[733905.024813]     in-flight: 25134:btrfs_work_helper
[733905.024817] workqueue btrfs-endio-write: flags=0xe
[733905.075033]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/8 refcnt=4
[733905.075035]     in-flight: 6405:btrfs_work_helper, 25135:btrfs_work_helper
[733905.075039] workqueue btrfs-delalloc: flags=0xe
[733905.130695]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=1/8 refcnt=3
[733905.130697]     in-flight: 25030:btrfs_work_helper
[733905.130709] workqueue cifsiod: flags=0xc
[733905.178289]   pwq 12: cpus=6 node=0 flags=0x1 nice=0 active=2/256 refcnt=4
[733905.178291]     in-flight: 9189:cifs_echo_request [cifs], 26186(RESCUER):cifs_resolve_server [cifs]
[733905.178363] pool 12: cpus=6 node=0 flags=0x1 nice=0 hung=988s workers=2 manager: 17834
[733905.178366] pool 16: cpus=0-7 flags=0x5 nice=0 hung=0s workers=11 manager: 6295 idle: 2903
[733909.916792] sysrq: Power Off
[733966.261816] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x1 nice=0 stuck for 55s!
[733966.286477] BUG: workqueue lockup - pool cpus=6 node=0 flags=0x1 nice=0 stuck for 1049s!
[733966.311622] Showing busy workqueues and worker pools:
[733966.327664] workqueue events: flags=0x0
[733966.340063]   pwq 12: cpus=6 node=0 flags=0x1 nice=0 active=5/256 refcnt=6
[733966.340067]     pending: cache_reap, drm_fb_helper_damage_work [drm_kms_helper], free_work, do_emergency_remount, do_sync_work
[733966.340093]   pwq 0: cpus=0 node=0 flags=0x1 nice=0 active=3/256 refcnt=4
[733966.340095]     in-flight: 17295:do_poweroff
[733966.340098]     pending: vmstat_shepherd, cache_reap
[733966.340106] workqueue writeback: flags=0x4a
[733966.461521]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/256 refcnt=4
[733966.461524]     in-flight: 8793:wb_workfn, 8613:wb_workfn
[733966.461543] workqueue btrfs-delalloc: flags=0xe
[733966.513325]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/8 refcnt=4
[733966.513328]     in-flight: 8795:btrfs_work_helper, 29765:btrfs_work_helper
[733966.513344] workqueue btrfs-worker: flags=0xe
[733966.568487]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=1/8 refcnt=3
[733966.568489]     in-flight: 25134:btrfs_work_helper
[733966.568492] workqueue btrfs-endio-write: flags=0xe
[733966.618683]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/8 refcnt=4
[733966.618685]     in-flight: 6405:btrfs_work_helper, 25135:btrfs_work_helper
[733966.618698] workqueue btrfs-delalloc: flags=0xe
[733966.674361]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=1/8 refcnt=3
[733966.674364]     in-flight: 25030:btrfs_work_helper
[733966.674376] workqueue cifsiod: flags=0xc
[733966.721929]   pwq 12: cpus=6 node=0 flags=0x1 nice=0 active=2/256 refcnt=4
[733966.721932]     in-flight: 9189:cifs_echo_request [cifs], 26186(RESCUER):cifs_resolve_server [cifs]
[733966.722002] pool 0: cpus=0 node=0 flags=0x1 nice=0 hung=55s workers=2 manager: 9899
[733966.722006] pool 12: cpus=6 node=0 flags=0x1 nice=0 hung=1049s workers=2 manager: 17834
[733966.722008] pool 16: cpus=0-7 flags=0x5 nice=0 hung=0s workers=11 manager: 6295


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
