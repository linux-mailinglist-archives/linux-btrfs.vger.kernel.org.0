Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C39F5421A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384830AbiFHA3Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 20:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588681AbiFGXy4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 19:54:56 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61F61BC7AF
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 16:37:35 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyilS-0006HS-9c by authid <merlin>; Tue, 07 Jun 2022 16:37:34 -0700
Date:   Tue, 7 Jun 2022 16:37:34 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220607233734.GA22722@merlins.org>
References: <20220607153257.GR1745079@merlins.org>
 <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org>
 <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org>
 <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org>
 <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org>
 <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
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

On Tue, Jun 07, 2022 at 07:33:00PM -0400, Josef Bacik wrote:
> On Tue, Jun 7, 2022 at 5:25 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Jun 07, 2022 at 04:58:57PM -0400, Josef Bacik wrote:
> > > Ok I think I fixed that, but I also updated the loop to bulk delete as
> > > many bad items in a leaf at a time, hopefully this will make it go
> > > much faster.  Expect more fireworks with the new code.  Thanks,
> >
> > Found an extent we don't have a block group for in the file 10741731311616
> > ref to path failed
> > Couldn't find any paths for this inode
> > Deleting [73101, 108, 0] root 15645020241920 path top 15645020241920 top slot 49 leaf 15645020766208 slot 26 nr 73
> >
> > searching 164629 for bad extents
> > processed 802816 of 108838912 possible bytes, 0%
> > Found an extent we don't have a block group for in the file 10741731311616
> >
> > Found an extent we don't have a block group for in the file 743378268160
> >
> > Found an extent we don't have a block group for in the file 946736541696
> > ref to path failed
> > Couldn't find any paths for this inode
> > Deleting [73101, 108, 427687936] root 15645019537408 path top 15645019537408 top slot 49 leaf 15645020766208 slot 26 nr 148
> >
> > searching 164629 for bad extents
> > processed 802816 of 108838912 possible bytes, 0%
> > Found an extent we don't have a block group for in the file 946736541696
> > ref to path failed
> > Couldn't find any paths for this inode
> > Deleting [73101, 108, 1747189760] root 15645020241920 path top 15645020241920 top slot 49 leaf 15645020782592 slot 26 nr 1
> >
> > searching 164629 for bad extents
> > processed 835584 of 108838912 possible bytes, 0%
> > corrupt leaf: root=164629 root bytenr 15645020241920 commit bytenr 0 block=15645020438528 physical=15054974140416 slot=0 level 0, invalid level for node, have 0 expect [1, 7]
> > kernel-shared/ctree.c:148: btrfs_release_path: BUG_ON `ret` triggered, value -5
> 
> Ugh come on, this must get triggered because we clean up some stuff
> and then the corrupt blocks are suddenly right next to eachother.  Can
> you re-run tree-recover and see if it deletes those keys?  Thanks,

Sorry :(

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x559148b31bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x559148b31bc0
Checking root 2 bytenr 15645020913664
Checking root 4 bytenr 15645019078656
Checking root 5 bytenr 15645018161152
Checking root 7 bytenr 15645019586560
Checking root 9 bytenr 15645740367872
Checking root 161197 bytenr 15645018341376
Checking root 161199 bytenr 15645018652672
Checking root 161200 bytenr 15645018750976
Checking root 161889 bytenr 11160502124544
Checking root 162628 bytenr 15645018931200
Checking root 162632 bytenr 15645018210304
Checking root 163298 bytenr 15645019045888
Checking root 163302 bytenr 15645018685440
Checking root 163303 bytenr 15645019095040
Checking root 163316 bytenr 15645018996736
Checking root 163920 bytenr 15645019144192
Checking root 164620 bytenr 15645019275264
Checking root 164623 bytenr 15645019226112
Checking root 164624 bytenr 15645018275840
Checking root 164629 bytenr 15645020241920
Checking root 164631 bytenr 15645496983552
Checking root 164633 bytenr 15645526884352
Checking root 164823 bytenr 15645999005696
Tree recovery finished, you can run check now
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
