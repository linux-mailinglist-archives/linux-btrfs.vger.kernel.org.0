Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176653CD63
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbiFCQnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbiFCQm7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 12:42:59 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103A3BBE9
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 09:42:57 -0700 (PDT)
Received: from [76.132.34.178] (port=59168 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nx9fZ-0005LK-Lv by authid <merlins.org> with srv_auth_plain; Fri, 03 Jun 2022 09:42:55 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nxANw-00CH0d-KJ; Fri, 03 Jun 2022 09:42:52 -0700
Date:   Fri, 3 Jun 2022 09:42:52 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220603164252.GH1745079@merlins.org>
References: <20220602190848.GS22722@merlins.org>
 <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
 <20220602195134.GT22722@merlins.org>
 <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org>
 <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org>
 <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org>
 <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 03, 2022 at 12:17:15PM -0400, Josef Bacik wrote:
> On Fri, Jun 3, 2022 at 10:47 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Thu, Jun 02, 2022 at 10:20:13PM -0400, Josef Bacik wrote:
> > > Sorry daughters graduation thing took forever, I've updated the code,
> > > it should work now.  Thanks,
> >
> > Not sorry, congrats ;)
> >
> > It works better but seems to be looping on the same thing now (it has
> > all night):
> 
> Ok I think I know what it is, try again please.  Thanks,

Woohoo, that worked:

Invalid mapping for 365033668608-365033684992, got 11106814787584-11107888529408
Couldn't map the block 365033668608
Couldn't map the block 365033668608
deleting slot 0 in block 15646000562176
deleting slot 0 in block 15646000562176
deleting slot 0 in block 15646000562176
Root 164824 was completely cleared, deleting it
Checking root 164825 bytenr 15646001872896
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164825, we're going to clear it and hope for the best
We thought root 164825 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 164910 bytenr 10194254020608
Invalid mapping for 10194254020608-10194254036992, got 11106814787584-11107888529408
Couldn't map the block 10194254020608
Couldn't map the block 10194254020608
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164910, we're going to clear it and hope for the best
We thought root 164910 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 164911 bytenr 10194440339456
Invalid mapping for 10194440339456-10194440355840, got 11106814787584-11107888529408
Couldn't map the block 10194440339456
Couldn't map the block 10194440339456
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164911, we're going to clear it and hope for the best
We thought root 164911 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 164912 bytenr 10194209554432
Invalid mapping for 10194209554432-10194209570816, got 11106814787584-11107888529408
Couldn't map the block 10194209554432
Couldn't map the block 10194209554432
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164912, we're going to clear it and hope for the best
We thought root 164912 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 164913 bytenr 10194353700864
Invalid mapping for 10194353700864-10194353717248, got 11106814787584-11107888529408
Couldn't map the block 10194353700864
Couldn't map the block 10194353700864
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164913, we're going to clear it and hope for the best
We thought root 164913 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 164914 bytenr 10194543017984
Invalid mapping for 10194543017984-10194543034368, got 11106814787584-11107888529408
Couldn't map the block 10194543017984
Couldn't map the block 10194543017984
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164914, we're going to clear it and hope for the best
We thought root 164914 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 164915 bytenr 10678962552832
Invalid mapping for 10678962552832-10678962569216, got 11106814787584-11107888529408
Couldn't map the block 10678962552832
Couldn't map the block 10678962552832
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164915, we're going to clear it and hope for the best
We thought root 164915 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 164916 bytenr 10679219617792
Invalid mapping for 10679219617792-10679219634176, got 11106814787584-11107888529408
Couldn't map the block 10679219617792
Couldn't map the block 10679219617792
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164916, we're going to clear it and hope for the best
We thought root 164916 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 164917 bytenr 10678998777856
Invalid mapping for 10678998777856-10678998794240, got 11106814787584-11107888529408
Couldn't map the block 10678998777856
Couldn't map the block 10678998777856
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 164917, we're going to clear it and hope for the best
We thought root 164917 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Checking root 18446744073709551607 bytenr 8733327196160
Invalid mapping for 8733327196160-8733327212544, got 11106814787584-11107888529408
Couldn't map the block 8733327196160
Couldn't map the block 8733327196160
scanning, best has 0 found 0 bad
ERROR: Couldn't find a valid root block for 18446744073709551607, we're going to clear it and hope for the best
We thought root 18446744073709551607 could be found at 18446744073709551615 level 255 but didn't find anything, deleting it.
Tree recovery finished, you can run check now
gargamel:/var/local/src/btrfs-progs-josefbacik# 

Now running the next step:

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
FS_INFO IS 0x55d3c8ad6bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55d3c8ad6bc0
Walking all our trees and pinning down the currently accessible blocks
Clearing the extent root and re-init'ing the block groups
deleting space cache for 11106814787584
deleting space cache for 11108962271232
deleting space cache for 11110036013056
deleting space cache for 11111109754880
deleting space cache for 11112183496704
deleting space cache for 11113257238528
deleting space cache for 11114330980352
deleting space cache for 11115404722176
deleting space cache for 11116478464000
deleting space cache for 11118625947648
deleting space cache for 11119699689472
deleting space cache for 11120773431296
deleting space cache for 11121847173120
deleting space cache for 11122920914944
deleting space cache for 11123994656768
deleting space cache for 11125068398592
deleting space cache for 11126142140416
deleting space cache for 11127215882240
deleting space cache for 11128289624064
deleting space cache for 11129363365888
deleting space cache for 11130437107712
deleting space cache for 11131510849536
deleting space cache for 11132584591360
deleting space cache for 11133658333184
(...)


searching 1 for bad extents
processed 81920 of 18446744073709518848 possible bytes, 0%
Found an extent we don't have a block group for in the file
Couldn't find any paths for this inode
Deleting [4483, 108, 0] root 15645018226688 path top 15645018226688 top slot 5 leaf 15645018243072 slot 11

searching 1 for bad extents
processed 81920 of 18446744073709518848 possible bytes, 0%
Found an extent we don't have a block group for in the file
Couldn't find any paths for this inode
Deleting [4484, 108, 0] root 15645018161152 path top 15645018161152 top slot 5 leaf 15645018177536 slot 12

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
