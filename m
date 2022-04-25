Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954C350D621
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 02:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiDYA1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 20:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiDYA1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 20:27:18 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5559366AB
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 17:24:16 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nimWV-0001YL-LM by authid <merlin>; Sun, 24 Apr 2022 17:24:15 -0700
Date:   Sun, 24 Apr 2022 17:24:15 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220425002415.GG29107@merlins.org>
References: <20220424205454.GB29107@merlins.org>
 <CAEzrpqeVQQ+42Lnn9+3gevnRgrU=vsBEwczF41gmTukn=a2ycw@mail.gmail.com>
 <20220424210732.GC29107@merlins.org>
 <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org>
 <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
 <20220424223819.GE29107@merlins.org>
 <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
 <20220424231446.GF29107@merlins.org>
 <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 07:27:02PM -0400, Josef Bacik wrote:
> On Sun, Apr 24, 2022 at 7:14 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, Apr 24, 2022 at 06:56:01PM -0400, Josef Bacik wrote:
> > > I feel like this thing is purposefully changing itself between each
> > > run so I can't get a grasp on wtf is going on.  I pushed some stuff,
> > > lets see how that goes.  Thanks,
> >
> > After all the tests we did, is it possible that some damaged the FS
> > further?
> >
> 
> That's the thing, we're literally deleting the entire tree and
> starting over, it should do the same thing every time.  I pushed
> another fix, I think I've been messing up the buffers and that's why
> we're getting random values. Lets try this again,

Gotcha.

(gdb) run rescue init-extent-tree /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x55555564cbc0
JOSEF: root 9
checksum verify failed on 15645878108160 wanted 0x1beaa67b found 0x27edb2c4
Couldn't find the last root for 8
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
(...)
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
FS_INFO AFTER IS 0x55555564cbc0
Walking all our trees and pinning down the currently accessible blocks
Clearing the extent root and re-init'ing the block groups
inserting block group 12582912
inserting block group 20971520
inserting block group 29360128
inserting block group 1103101952
(...)
inserting block group 345237356544
inserting block group 346311098368
inserting block group 347384840192
inserting block group 348458582016
inserting block group 349532323840
inserting block group 350606065664
inserting block group 351679807488
inserting block group 352753549312
inserting block group 353827291136
Ignoring transid failure
Ignoring transid failure
ERROR: Error adding block group -17
ERROR: commit_root already set when starting transaction
WARNING: reserved space leaked, flag=0x4 bytes_reserved=81920
extent buffer leak: start 67469312 len 16384
extent buffer leak: start 29540352 len 16384
WARNING: dirty eb leak (aborted trans): start 29540352 len 16384
extent buffer leak: start 29589504 len 16384
WARNING: dirty eb leak (aborted trans): start 29589504 len 16384
extent buffer leak: start 29655040 len 16384
WARNING: dirty eb leak (aborted trans): start 29655040 len 16384
Init extent tree failed
[Inferior 1 (process 6259) exited with code 0357]
(gdb) 


I ran it a second time and got the same output

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
