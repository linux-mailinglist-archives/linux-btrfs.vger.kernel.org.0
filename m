Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73850D5D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 00:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiDXWlY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiDXWlX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 18:41:23 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994CB24F31
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 15:38:20 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nikrz-0001ot-VO by authid <merlin>; Sun, 24 Apr 2022 15:38:19 -0700
Date:   Sun, 24 Apr 2022 15:38:19 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220424223819.GE29107@merlins.org>
References: <20220424194444.GA12542@merlins.org>
 <CAEzrpqeY_BAMLdL7NQmtC7ROBkZLrx=FHr=JC4KHoPF6Kwn3Kg@mail.gmail.com>
 <20220424203133.GA29107@merlins.org>
 <CAEzrpqemyJ8PS5-eF3iSKugy6u3UAzkwwM=o+bHPOh2_7aPHFA@mail.gmail.com>
 <20220424205454.GB29107@merlins.org>
 <CAEzrpqeVQQ+42Lnn9+3gevnRgrU=vsBEwczF41gmTukn=a2ycw@mail.gmail.com>
 <20220424210732.GC29107@merlins.org>
 <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org>
 <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 05:26:11PM -0400, Josef Bacik wrote:
> On Sun, Apr 24, 2022 at 5:20 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, Apr 24, 2022 at 05:13:22PM -0400, Josef Bacik wrote:
> > > On Sun, Apr 24, 2022 at 5:07 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Sun, Apr 24, 2022 at 05:01:38PM -0400, Josef Bacik wrote:
> > > > > Wtf, it's reading the right bytenr, but it's not failing here but
> > > > > failing when we do the init-extent-tree.  I've pushed something again
> > > > > to force reads, maybe that's the problem, can you run tree-recover and
> > > > > then init-extent-tree again?  Thanks,
> > > >
> > > > off-list:
> > > > Seeing this, that kind of worried me so I stopped it. Is it ok to
> > > > continue?
> > >
> > > Sorry, my printf was wrong, pushed.  Thanks,
> >
> > Better?
> > Do I worry about those new "had to be read from a different mirror" ?
> >
> 
> Ooooh ok, the other mirror is bad, but it finds the right thing.  Ok
> that makes sense.  I pushed another patch just to make sure.  Once
> this is all done you'll need to run a scrub to fix the mirrors but
> this is fine.  Thanks,

No more crash, but:
ERROR: Error adding block group
ERROR: commit_root already set when starting transaction


(gdb) run rescue tree-recover /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue tree-recover /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x55555564cbc0
JOSEF: root 9
block 15645878108160 had to be read from a different mirror, ret 0
Couldn't find the last root for 8
block 58720256 had to be read from a different mirror, ret 0
block 58720256 had to be read from a different mirror, ret 0
FS_INFO AFTER IS 0x55555564cbc0
block 13577220816896 had to be read from a different mirror, ret 0
block 13577870934016 had to be read from a different mirror, ret 0
(...)
block 13577821011968 had to be read from a different mirror, ret 0
block 15645781196800 had to be read from a different mirror, ret 0
Checking root 2 bytenr 67387392
block 58720256 had to be read from a different mirror, ret 0
Checking root 4 bytenr 15645196861440
Checking root 5 bytenr 13577660252160
block 11970891186176 had to be read from a different mirror, ret 0
block 12511729680384 had to be read from a different mirror, ret 0
(...)
block 13577726541824 had to be read from a different mirror, ret 0
block 13577776611328 had to be read from a different mirror, ret 0
block 364637798400 had to be read from a different mirror, ret 0
block 364637962240 had to be read from a different mirror, ret 0
Checking root 7 bytenr 13577819963392
block 210337792 had to be read from a different mirror, ret 0
block 595607552 had to be read from a different mirror, ret 0
block 949698560 had to be read from a different mirror, ret 0
(...)
Checking root 165299 bytenr 13577191505920
block 364679708672 had to be read from a different mirror, ret 0
block 364713902080 had to be read from a different mirror, ret 0
(...)
block 13577821011968 had to be read from a different mirror, ret 0
block 15645781196800 had to be read from a different mirror, ret 0
Checking root 18446744073709551607 bytenr 13576823685120
Tree recovery finished, you can run check now
[Inferior 1 (process 5587) exited normally]
(gdb) quit


Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x55555564cbc0
JOSEF: root 9
checksum verify failed on 15645878108160 wanted 0x1beaa67b found 0x27edb2c4
block 15645878108160 had to be read from a different mirror, ret 0
Couldn't find the last root for 8
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
block 58720256 had to be read from a different mirror, ret 0
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
block 58720256 had to be read from a different mirror, ret 0
(...)
block 58720256 had to be read from a different mirror, ret 0
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
block 58720256 had to be read from a different mirror, ret 0
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
block 58720256 had to be read from a different mirror, ret 0
FS_INFO AFTER IS 0x55555564cbc0
Walking all our trees and pinning down the currently accessible blocks
checksum verify failed on 11651824091136 wanted 0x6d411825 found 0x3cf07c9d
block 11651824091136 had to be read from a different mirror, ret 0
checksum verify failed on 606126080 wanted 0x8e0fb704 found 0xfc183188
block 606126080 had to be read from a different mirror, ret 0
checksum verify failed on 15645807640576 wanted 0xe97841cd found 0x4fa14858
block 15645807640576 had to be read from a different mirror, ret 0
checksum verify failed on 364863324160 wanted 0x741855d8 found 0x5aec3f82
block 364863324160 had to be read from a different mirror, ret 0
(...)
checksum verify failed on 15645419667456 wanted 0xde0dab28 found 0x3ceddd16
block 15645419667456 had to be read from a different mirror, ret 0
checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
block 13577821011968 had to be read from a different mirror, ret 0
checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
block 15645781196800 had to be read from a different mirror, ret 0
Clearing the extent root and re-init'ing the block groups
parent transid verify failed on 29442048 wanted 1619017 found 1619015
parent transid verify failed on 29442048 wanted 1619017 found 1619015
parent transid verify failed on 29442048 wanted 1619017 found 1619015
parent transid verify failed on 29556736 wanted 1619017 found 1619013
parent transid verify failed on 29556736 wanted 1619017 found 1619013
parent transid verify failed on 29556736 wanted 1619017 found 1619013
parent transid verify failed on 29589504 wanted 1619017 found 1619013
parent transid verify failed on 29589504 wanted 1619017 found 1619013
parent transid verify failed on 29589504 wanted 1619017 found 1619013
ERROR: Error adding block group
ERROR: commit_root already set when starting transaction
WARNING: reserved space leaked, flag=0x4 bytes_reserved=81920
extent buffer leak: start 67469312 len 16384
extent buffer leak: start 29540352 len 16384
extent buffer leak: start 29540352 len 16384
WARNING: dirty eb leak (aborted trans): start 29540352 len 16384
extent buffer leak: start 29655040 len 16384
WARNING: dirty eb leak (aborted trans): start 29655040 len 16384
extent buffer leak: start 29589504 len 16384
extent buffer leak: start 29589504 len 16384
WARNING: dirty eb leak (aborted trans): start 29589504 len 16384
extent buffer leak: start 34504704 len 16384
WARNING: dirty eb leak (aborted trans): start 34504704 len 16384
Init extent tree failed
[Inferior 1 (process 11217) exited with code 0357]
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
