Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295485424FE
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiFHBil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 21:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386954AbiFHBhV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 21:37:21 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90D01A070
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 17:07:00 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyjDw-0008GJ-EO by authid <merlin>; Tue, 07 Jun 2022 17:07:00 -0700
Date:   Tue, 7 Jun 2022 17:07:00 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220608000700.GB22722@merlins.org>
References: <20220607182737.GU1745079@merlins.org>
 <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org>
 <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org>
 <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org>
 <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
 <20220607233734.GA22722@merlins.org>
 <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
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

On Tue, Jun 07, 2022 at 07:41:32PM -0400, Josef Bacik wrote:
> > > Ugh come on, this must get triggered because we clean up some stuff
> > > and then the corrupt blocks are suddenly right next to eachother.  Can
> > > you re-run tree-recover and see if it deletes those keys?  Thanks,
> >
> > Sorry :(
> >
> Ok I think it's just the check is wrong, I removed the check, maybe
> I'll get lucky for once?  Thanks,

that helped.

(...)
Found an extent we don't have a block group for in the file 652682866688

Found an extent we don't have a block group for in the file 652682862592

Found an extent we don't have a block group for in the file 652723212288

Found an extent we don't have a block group for in the file 390870233088
ref to path failed
Couldn't find any paths for this inode
Deleting [69105, 108, 0] root 15645018226688 path top 15645018226688 top slot 11 leaf 15645020864512 slot 1 nr 118

searching 164823 for bad extents
processed 163840 of 63193088 possible bytes, 0%
Found an extent we don't have a block group for in the file 390870233088
Couldn't find any paths for this inode
Deleting [69134, 108, 36012032] root 15645018587136 path top 15645018587136 top slot 10 leaf 15645019553792 slot 45 nr 1

searching 164823 for bad extents
processed 196608 of 63193088 possible bytes, 0%
Recording extents for root 3
processed 180224 of 0 possible bytes, 0%
Recording extents for root 1
processed 999424 of 0 possible bytes, 0%
doing roots
Recording extents for root 4
processed 163840 of 1064960 possible bytes, 15%
Recording extents for root 5
processed 65536 of 10960896 possible bytes, 0%
Recording extents for root 7
processed 16384 of 16570974208 possible bytes, 0%
Recording extents for root 9
processed 16384 of 16384 possible bytes, 100%
Recording extents for root 161197
processed 131072 of 108986368 possible bytes, 0%
Recording extents for root 161199
processed 196608 of 49479680 possible bytes, 0%
Recording extents for root 161200
processed 180224 of 254214144 possible bytes, 0%
Recording extents for root 161889
processed 196608 of 49446912 possible bytes, 0%
Recording extents for root 162628
processed 49152 of 49463296 possible bytes, 0%
Recording extents for root 162632
processed 114688 of 94633984 possible bytes, 0%
Recording extents for root 163298
processed 49152 of 49463296 possible bytes, 0%
Recording extents for root 163302
processed 98304 of 94633984 possible bytes, 0%
Recording extents for root 163303
processed 131072 of 76333056 possible bytes, 0%
Recording extents for root 163316
processed 98304 of 108544000 possible bytes, 0%
Recording extents for root 163920
processed 16384 of 108691456 possible bytes, 0%
Recording extents for root 164620
processed 49152 of 49463296 possible bytes, 0%
Recording extents for root 164623
processed 311296 of 63193088 possible bytes, 0%
Recording extents for root 164624
processed 933888 of 108822528 possible bytes, 0%
Recording extents for root 164629
processed 622592 of 108838912 possible bytes, 0%
Recording extents for root 164631
ERROR: failed to insert the ref for the root block -17
wtf
it failed?? -17
doing close???
ERROR: attempt to start transaction over already running one
WARNING: reserved space leaked, flag=0x4 bytes_reserved=32768
extent buffer leak: start 15645019488256 len 16384
WARNING: dirty eb leak (aborted trans): start 15645019488256 len 16384
extent buffer leak: start 15645020061696 len 16384
WARNING: dirty eb leak (aborted trans): start 15645020061696 len 16384
Init extent tree failed
[Inferior 1 (process 7259) exited with code 0357]

So can I go back to  check --repair /dev/mapper/dshelf1  ?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
