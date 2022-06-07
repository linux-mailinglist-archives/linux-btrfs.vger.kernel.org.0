Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313235426F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiFHDMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 23:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiFHDLG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 23:11:06 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F622ABDA
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 14:25:23 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyghX-0002Ow-2F by authid <merlin>; Tue, 07 Jun 2022 14:25:23 -0700
Date:   Tue, 7 Jun 2022 14:25:23 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220607212523.GZ22722@merlins.org>
References: <20220607151829.GQ1745079@merlins.org>
 <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org>
 <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org>
 <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org>
 <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org>
 <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 04:58:57PM -0400, Josef Bacik wrote:
> Ok I think I fixed that, but I also updated the loop to bulk delete as
> many bad items in a leaf at a time, hopefully this will make it go
> much faster.  Expect more fireworks with the new code.  Thanks,

Found an extent we don't have a block group for in the file 10741731311616
ref to path failed
Couldn't find any paths for this inode
Deleting [73101, 108, 0] root 15645020241920 path top 15645020241920 top slot 49 leaf 15645020766208 slot 26 nr 73

searching 164629 for bad extents
processed 802816 of 108838912 possible bytes, 0%
Found an extent we don't have a block group for in the file 10741731311616

Found an extent we don't have a block group for in the file 743378268160

Found an extent we don't have a block group for in the file 946736541696
ref to path failed
Couldn't find any paths for this inode
Deleting [73101, 108, 427687936] root 15645019537408 path top 15645019537408 top slot 49 leaf 15645020766208 slot 26 nr 148

searching 164629 for bad extents
processed 802816 of 108838912 possible bytes, 0%
Found an extent we don't have a block group for in the file 946736541696
ref to path failed
Couldn't find any paths for this inode
Deleting [73101, 108, 1747189760] root 15645020241920 path top 15645020241920 top slot 49 leaf 15645020782592 slot 26 nr 1

searching 164629 for bad extents
processed 835584 of 108838912 possible bytes, 0%
corrupt leaf: root=164629 root bytenr 15645020241920 commit bytenr 0 block=15645020438528 physical=15054974140416 slot=0 level 0, invalid level for node, have 0 expect [1, 7]
kernel-shared/ctree.c:148: btrfs_release_path: BUG_ON `ret` triggered, value -5
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_release_path+0x62)[0x555555573667]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8d1fe)[0x5555555e11fe]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_init_extent_tree+0xc83)[0x5555555e2fd0]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x845dd)[0x5555555d85dd]
/var/local/src/btrfs-progs-josefbacik/btrfs(handle_command_group+0x49)[0x55555556c17b]
/var/local/src/btrfs-progs-josefbacik/btrfs(main+0x94)[0x55555556c275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7ffff78617fd]
/var/local/src/btrfs-progs-josefbacik/btrfs(_start+0x2a)[0x55555556be1a]

Program received signal SIGABRT, Aborted.
0x00007ffff78768a1 in raise () from /lib/x86_64-linux-gnu/libc.so.6

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
