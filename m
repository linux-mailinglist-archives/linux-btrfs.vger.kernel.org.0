Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADB753BFDB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiFBUcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 16:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbiFBUc1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 16:32:27 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985110F4
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 13:32:26 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwrUW-0002jB-G7 by authid <merlin>; Thu, 02 Jun 2022 13:32:24 -0700
Date:   Thu, 2 Jun 2022 13:32:24 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220602203224.GV22722@merlins.org>
References: <20220602142112.GQ22722@merlins.org>
 <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
 <20220602143606.GR22722@merlins.org>
 <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
 <20220602190848.GS22722@merlins.org>
 <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
 <20220602195134.GT22722@merlins.org>
 <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org>
 <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
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

On Thu, Jun 02, 2022 at 04:06:00PM -0400, Josef Bacik wrote:
> On Thu, Jun 2, 2022 at 3:56 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Thu, Jun 02, 2022 at 03:53:00PM -0400, Josef Bacik wrote:
> > > Ok it seems like we're still missing some chunks, hopefully re-running
> > > btrfs rescue recover-chunks <device> will find the remaining, there
> > > must have been system chunks that got discovered.  Thanks,
> >
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > FS_INFO IS 0x55f3efdd3bc0
> > Couldn't find the last root for 8
> > FS_INFO AFTER IS 0x55f3efdd3bc0
> > Walking all our trees and pinning down the currently accessible blocks
> > Invalid mapping for 11822437826560-11822437842944, got 14271702368256-14272776110080
> > Couldn't map the block 11822437826560
> > Couldn't map the block 11822437826560
> > Error reading root block
> > ERROR: Couldn't pin down excluded extents, if there were errors run btrfs rescue tree-recover
> > doing close???
> > Recover chunks tree failed
> 
> Pushed, try again please.  Thanks,

That worked:
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue
recover-chunks /dev/mapper/dshelf1
FS_INFO IS 0x5594c8305bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5594c8305bc0
Walking all our trees and pinning down the currently accessible blocks
No missing chunks, we're all done
doing close???
Recover chunks succeeded, you can run check now


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x564be0ed2bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x564be0ed2bc0
Checking root 2 bytenr 15645200318464
Checking root 4 bytenr 15645019078656
Checking root 5 bytenr 15645740302336
Checking root 7 bytenr 15645188767744
Checking root 9 bytenr 15645740367872
Checking root 161197 bytenr 15645190864896
Checking root 161199 bytenr 15645198614528
Checking root 161200 bytenr 15646048272384
Checking root 161889 bytenr 15645940285440
Checking root 162628 bytenr 15645764812800
Checking root 162632 bytenr 15645196845056
Checking root 163298 bytenr 15645124263936
Checking root 163302 bytenr 15645198188544
Checking root 163303 bytenr 15645199499264
Checking root 163316 bytenr 15645199728640
Checking root 163318 bytenr 15645980491776
scanning, best has 0 found 0 bad
checking block 15645980491776 generation 1597265 fs info generation 2582703
trying bytenr 15645980491776 got 2 blocks 1 bad
Repairing root 163318 bad_blocks 1 update 1
deleting slot 0 in block 15645980491776
bad tree block 15645980491776, invalid nr_items: 0
kernel-shared/disk-io.c:553: write_tree_block: BUG_ON `1` triggered, value 1
./btrfs(+0x25ae7)[0x564be025eae7]
./btrfs(write_tree_block+0xb8)[0x564be0260ec9]
./btrfs(+0x8aa3d)[0x564be02c3a3d]
./btrfs(+0x8add0)[0x564be02c3dd0]
./btrfs(btrfs_recover_trees+0x628)[0x564be02c4a40]
./btrfs(+0x83f24)[0x564be02bcf24]
./btrfs(handle_command_group+0x49)[0x564be025117b]
./btrfs(main+0x94)[0x564be0251275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f55d1ef47fd]
./btrfs(_start+0x2a)[0x564be0250e1a]
Aborted

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
