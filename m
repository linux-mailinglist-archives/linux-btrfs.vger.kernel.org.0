Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5D653B004
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 00:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiFAWgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 18:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiFAWgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 18:36:41 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C8613F05
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 15:36:40 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwWxD-0007DI-VI by authid <merlin>; Wed, 01 Jun 2022 15:36:39 -0700
Date:   Wed, 1 Jun 2022 15:36:39 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220601223639.GI22722@merlins.org>
References: <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org>
 <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
 <20220601180824.GF22722@merlins.org>
 <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
 <20220601185027.GG22722@merlins.org>
 <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
 <CAEzrpqeTEuRzP_Nj1qoSerCObJLA4fJYDfR1u3XMatuG=RZf-g@mail.gmail.com>
 <20220601214054.GH22722@merlins.org>
 <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
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

On Wed, Jun 01, 2022 at 06:34:51PM -0400, Josef Bacik wrote:
> On Wed, Jun 1, 2022 at 5:40 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Jun 01, 2022 at 04:57:34PM -0400, Josef Bacik wrote:
> > > Ok I've committed the code, but I forsee all sorts of wonky problems
> > > since we don't have a tree root yet, there may be a variety of
> > > segfaults I have to run down before it actually works.  So go ahead
> > > and do
> > >
> > > btrfs rescue recover-chunks <device>
> > >
> > > if by some miracle it completes, you'll then want to run
> >
> > Found missing chunk 15483956887552-15485030629376 type 0
> > Found missing chunk 15485030629376-15486104371200 type 0
> > Found missing chunk 15486104371200-15487178113024 type 0
> > Found missing chunk 15487178113024-15488251854848 type 0
> > Found missing chunk 15488251854848-15489325596672 type 0
> > Found missing chunk 15671861706752-15672935448576 type 0
> > Found missing chunk 15672935448576-15674009190400 type 0
> > Found missing chunk 15772793438208-15773867180032 type 0
> > Found missing chunk 15773867180032-15774940921856 type 0
> > Found missing chunk 15774940921856-15776014663680 type 0
> > Found missing chunk 15776014663680-15777088405504 type 0
> > Found missing chunk 15777088405504-15778162147328 type 0
> > ERROR: Corrupted fs, no valid METADATA block group found
> > Inserting chunk 14823605665792wtf transid 2582704
> 
> Fixed, lets try that again please.  Thanks,

Found missing chunk 15672935448576-15674009190400 type 0
Found missing chunk 15772793438208-15773867180032 type 0
Found missing chunk 15773867180032-15774940921856 type 0
Found missing chunk 15774940921856-15776014663680 type 0
Found missing chunk 15776014663680-15777088405504 type 0
Found missing chunk 15777088405504-15778162147328 type 0
 Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
Inserting chunk 14823605665792wtf transid 2582704

Program received signal SIGSEGV, Segmentation fault.
btrfs_print_leaf (eb=0x0, mode=mode@entry=0) at kernel-shared/print-tree.c:1274
1274            u32 leaf_data_size = __BTRFS_LEAF_DATA_SIZE(eb->len);
(gdb)  bt
#0  btrfs_print_leaf (eb=0x0, mode=mode@entry=0) at kernel-shared/print-tree.c:1274
#1  0x000055555557730d in btrfs_insert_item (trans=trans@entry=0x555555662000, root=<optimized out>, 
    cpu_key=cpu_key@entry=0x55555564fb70, data=0x55555565de80, data_size=80) at kernel-shared/ctree.c:2931
#2  0x00005555555e2fb3 in restore_missing_chunks (fs_info=0x55555564fbc0) at ./kernel-shared/ctree.h:322
#3  btrfs_find_recover_chunks (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1") at cmds/rescue-recover-chunks.c:424
#4  0x00005555555d7c3a in cmd_rescue_recover_chunks (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#5  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555645d40 <cmd_struct_rescue_recover_chunks>)
    at cmds/commands.h:125
#6  handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#7  0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555646cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#8  main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
