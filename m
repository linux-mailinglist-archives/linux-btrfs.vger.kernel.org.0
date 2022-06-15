Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4854CBF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbiFOOzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbiFOOzu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 10:55:50 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDC35264
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 07:55:48 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1o1UQt-0000Sc-H9 by authid <merlin>; Wed, 15 Jun 2022 07:55:47 -0700
Date:   Wed, 15 Jun 2022 07:55:47 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220615145547.GQ22722@merlins.org>
References: <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
 <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220615142929.GP22722@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615142929.GP22722@merlins.org>
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

On Wed, Jun 15, 2022 at 07:29:29AM -0700, Marc MERLIN wrote:
> gargamel:/mnt/mnt# btrfs scrub start -B .
> running that now, I expect it will take a while.
 
Never mind, it was fast:
gargamel:/mnt/mnt# btrfs scrub start -B .
scrub done for 96539b8c-ccc9-47bf-9e6c-29305890941e
Scrub started:    Wed Jun 15 07:28:02 2022
Status:           finished
Duration:         0:03:33
Total to scrub:   111.00GiB
Rate:             98.39MiB/s
Error summary:    verify=14
  Corrected:      14
  Uncorrectable:  0
  Unverified:     0
WARNING: errors detected during scrubbing, corrected

> > The next thing is to fix the fs errors, which I imagine will cause
> > other problems like not being able to find directories and files and
> > such.  Once we've gotten the csum tree and the scrub done we can
> > tackle the remaining fs error problems which should be less terrifying
> > to mess with.  Thanks,
> 
> would that be check --repair ?

here's check without repair:

[1/7] checking root items
[2/7] checking extents
ref mismatch on [11160501911552 16384] extent item 1, found 0
backref 11160501911552 root 7 not referenced back 0x56389bce5cd0
incorrect global backref count on 11160501911552 found 1 wanted 0
backpointer mismatch on [11160501911552 16384]
owner ref check failed [11160501911552 16384]
ref mismatch on [11160502042624 16384] extent item 1, found 0
backref 11160502042624 root 7 not referenced back 0x56389bce44d0
incorrect global backref count on 11160502042624 found 1 wanted 0
backpointer mismatch on [11160502042624 16384]
owner ref check failed [11160502042624 16384]
ref mismatch on [11160502845440 16384] extent item 1, found 0
backref 11160502845440 root 7 not referenced back 0x56389be42060
incorrect global backref count on 11160502845440 found 1 wanted 0
backpointer mismatch on [11160502845440 16384]
owner ref check failed [11160502845440 16384]
ref mismatch on [11160502927360 16384] extent item 1, found 0
backref 11160502927360 root 7 not referenced back 0x56389be42560
incorrect global backref count on 11160502927360 found 1 wanted 0
backpointer mismatch on [11160502927360 16384]
owner ref check failed [11160502927360 16384]
ref mismatch on [15645021241344 16384] extent item 1, found 0
backref 15645021241344 root 7 not referenced back 0x56389bdc98a0
incorrect global backref count on 15645021241344 found 1 wanted 0
backpointer mismatch on [15645021241344 16384]
owner ref check failed [15645021241344 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
Couldn't find free space inode 1
Couldn't find free space inode 1
(...)
Couldn't find free space inode 1
Couldn't find free space inode 1
[4/7] checking fs roots
root 161199 inode 54988 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 1572864
root 161199 inode 54989 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 16252928, len: 91824128
	unresolved ref dir 54974 index 16 name foo filetype 0 errors 3, no dir item, no dir index
root 161199 inode 55003 errors 500, file extent discount, nbytes wrong
Found file extent holes:
	start: 0, len: 1048576
root 161199 inode 55004 errors 500, file extent discount, nbytes wrong
Found file extent holes:
	start: 0, len: 1048576
	unresolved ref dir 56235 index 12 name foo filetype mismatch
root 161199 inode 55409 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 524288
	unresolved ref dir 55399 index 11 name foo filetype 0 errors 3, no dir item, no dir index
root 161199 inode 55410 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 1572864
root 161199 inode 55411 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 524288
	unresolved ref dir 55399 index 13 name foo filetype 0 errors 3, no dir item, no dir index
root 161199 inode 55412 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 1048576
	unresolved ref dir 55399 index 14 name foo filetype 0 errors 3, no dir item, no dir index
root 161199 inode 55413 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 24117248, len: 34611200
	unresolved ref dir 55399 index 15 name foo filetype 0 errors 3, no dir item, no dir index
root 161199 inode 55459 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 56098816, len: 265449472
	unresolved ref dir 55437 index 23 name foo filetype 0 errors 3, no dir item, no dir index
root 161199 inode 55468 errors 100, file extent discount
Found file extent holes:
	start: 27787264, len: 302174208
root 161199 inode 55475 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 1048576
root 161199 inode 55476 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 28803072, len: 459870208
	unresolved ref dir 55437 index 40 name foo filetype 0 errors 3, no dir item, no dir index
root 161199 inode 55526 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 524288
root 161199 inode 55527 errors 100, file extent discount
Found file extent holes:
	start: 26738688, len: 462848
root 161199 inode 55528 errors 100, file extent discount
Found file extent holes:
	start: 16252928, len: 184320
root 161199 inode 55530 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 524288
root 161199 inode 55531 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 4194304, len: 11001856
	unresolved ref dir 55511 index 21 name foo filetype 0 errors 3, no dir item, no dir index
root 161889 inode 54988 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 1572864
root 161889 inode 54989 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 16252928, len: 91824128
	unresolved ref dir 54974 index 16 name foo filetype 0 errors 3, no dir item, no dir index
root 161889 inode 55003 errors 500, file extent discount, nbytes wrong
Found file extent holes:
	start: 0, len: 1048576
root 161889 inode 55004 errors 500, file extent discount, nbytes wrong
Found file extent holes:
	start: 0, len: 1048576
	unresolved ref dir 56235 index 48 name foo filetype mismatch
root 161889 inode 55409 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 524288
	unresolved ref dir 55399 index 11 name foo filetype 0 errors 3, no dir item, no dir index
root 161889 inode 55410 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 1572864
root 161889 inode 55411 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 524288
	unresolved ref dir 55399 index 13 name foo filetype 0 errors 3, no dir item, no dir index
root 161889 inode 55412 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 1048576
	unresolved ref dir 55399 index 14 name foo filetype 0 errors 3, no dir item, no dir index
root 161889 inode 55413 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 24117248, len: 34611200
	unresolved ref dir 55399 index 15 name foo filetype 0 errors 3, no dir item, no dir index
root 161889 inode 55459 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 56098816, len: 265449472
	unresolved ref dir 55437 index 23 name foo filetype 0 errors 3, no dir item, no dir index
root 161889 inode 55468 errors 100, file extent discount
Found file extent holes:
	start: 27787264, len: 302174208
root 161889 inode 55475 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 1048576
root 161889 inode 55476 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 28803072, len: 459870208
	unresolved ref dir 55437 index 40 name foo filetype 0 errors 3, no dir item, no dir index
root 161889 inode 55526 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 524288
root 161889 inode 55527 errors 100, file extent discount
Found file extent holes:
	start: 26738688, len: 462848
root 161889 inode 55528 errors 100, file extent discount
Found file extent holes:
	start: 16252928, len: 184320
root 161889 inode 55530 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 524288
root 161889 inode 55531 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 4194304, len: 11001856
	unresolved ref dir 55511 index 21 name foo filetype 0 errors 3, no dir item, no dir index
root 163920 inode 76551 errors 100, file extent discount
Found file extent holes:
	start: 1037262848, len: 184238080
root 163920 inode 76556 errors 100, file extent discount
Found file extent holes:
	start: 1639038976, len: 213225472
	unresolved ref dir 791 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 3676 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 72785 index 720 name foo filetype mismatch
	unresolved ref dir 791 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 3676 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 73103 index 544 name foo filetype mismatch
	unresolved ref dir 73103 index 672 name foo filetype mismatch
	unresolved ref dir 4179 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 4698 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 5506 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 5546 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
root 164624 inode 25918 errors 500, file extent discount, nbytes wrong
Found file extent holes:
	start: 0, len: 1262850048
root 164624 inode 72429 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 1333788672, len: 3217154048
	unresolved ref dir 72438 index 4 name foo filetype 0 errors 3, no dir item, no dir index
root 164624 inode 72433 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 892338176, len: 14957748224
	unresolved ref dir 34951 index 13 name foo filetype 0 errors 3, no dir item, no dir index
root 164624 inode 72593 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 42074112, len: 413642752
	unresolved ref dir 75036 index 19 name foo filetype 0 errors 3, no dir item, no dir index
	unresolved ref dir 73103 index 1524 name foo filetype mismatch
root 164624 inode 73009 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 13869056, len: 53100544
	unresolved ref dir 72672 index 134 name foo filetype 1 errors 1, no dir item
root 164624 inode 73083 errors 500, file extent discount, nbytes wrong
Found file extent holes:
	start: 197263360, len: 399777792
root 164624 inode 73094 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 524288
	unresolved ref dir 74963 index 32 name foo filetype 0 errors 3, no dir item, no dir index
root 164624 inode 73097 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 524288
	unresolved ref dir 74963 index 36 name foo filetype 0 errors 3, no dir item, no dir index
	unresolved ref dir 791 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 3676 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 73103 index 540 name foo filetype mismatch
	unresolved ref dir 4179 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 4698 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 5506 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 5546 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 39921 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 759824384, len: 2143326208
	unresolved ref dir 10205 index 356 name foo filetype 0 errors 3, no dir item, no dir index
root 164629 inode 72429 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 1333788672, len: 3217154048
	unresolved ref dir 72438 index 4 name foo filetype 0 errors 3, no dir item, no dir index
root 164629 inode 72433 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 892338176, len: 14957748224
	unresolved ref dir 34951 index 13 name foo filetype 0 errors 3, no dir item, no dir index
root 164629 inode 72593 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 42074112, len: 413642752
	unresolved ref dir 75036 index 19 name foo filetype 0 errors 3, no dir item, no dir index
	unresolved ref dir 73103 index 1386 name foo filetype mismatch
root 164629 inode 73009 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 13869056, len: 53100544
	unresolved ref dir 72672 index 134 name foo filetype 1 errors 1, no dir item
root 164629 inode 73083 errors 500, file extent discount, nbytes wrong
Found file extent holes:
	start: 197263360, len: 399777792
root 164629 inode 73094 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 524288
	unresolved ref dir 74963 index 32 name foo filetype 0 errors 3, no dir item, no dir index
root 164629 inode 73097 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes:
	start: 0, len: 524288
	unresolved ref dir 74963 index 36 name foo filetype 0 errors 3, no dir item, no dir index
	unresolved ref dir 791 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
	unresolved ref dir 3676 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
found 21941104640 bytes used, error(s) found
total csum bytes: 21390908
total tree bytes: 33587200
total fs tree bytes: 6799360
total extent tree bytes: 655360
btree space waste bytes: 5863130
file data blocks allocated: 36729012224
 referenced 36727418880

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
