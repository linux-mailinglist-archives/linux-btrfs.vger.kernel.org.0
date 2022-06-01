Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA953B08C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 02:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiFAXKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 19:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiFAXKL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 19:10:11 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3F20E6C9
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 16:10:09 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwXTc-0000tP-Eh by authid <merlin>; Wed, 01 Jun 2022 16:10:08 -0700
Date:   Wed, 1 Jun 2022 16:10:08 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220601231008.GK22722@merlins.org>
References: <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
 <20220601185027.GG22722@merlins.org>
 <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
 <CAEzrpqeTEuRzP_Nj1qoSerCObJLA4fJYDfR1u3XMatuG=RZf-g@mail.gmail.com>
 <20220601214054.GH22722@merlins.org>
 <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
 <20220601223639.GI22722@merlins.org>
 <CAEzrpqdfz5FMFDiBbb1mrUTXqxNvJ2RkuqJCdE2VQ6op01k61g@mail.gmail.com>
 <20220601225643.GJ22722@merlins.org>
 <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
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

On Wed, Jun 01, 2022 at 07:04:32PM -0400, Josef Bacik wrote:
> On Wed, Jun 1, 2022 at 6:56 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Jun 01, 2022 at 06:54:31PM -0400, Josef Bacik wrote:
> > > Ah right, I have to mock up free space since we can't read our normal
> > > stuff.  Fixed, lets go again.  Thanks,
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
> >
> 
> I swear there's so much tech-debt here.  Try again please.  Thanks,

Well, hopefully we'll get to the bottom of it all, thanks again for all
your efforts on this.

Found missing chunk 15772793438208-15773867180032 type 0
Found missing chunk 15773867180032-15774940921856 type 0
Found missing chunk 15774940921856-15776014663680 type 0
Found missing chunk 15776014663680-15777088405504 type 0
Found missing chunk 15777088405504-15778162147328 type 0

Program received signal SIGSEGV, Segmentation fault.
find_free_extent (profile=2, exclude_nr=0, exclude_start=0, ins=0x7fffffffd760, hint_byte=<optimized out>, 
    search_end=18446744073709551615, search_start=0, empty_size=0, num_bytes=16384, root=0x555555650030, trans=0x5555556620f0)
    at kernel-shared/extent-tree.c:2248
2248            ret = find_search_start(root, &block_group, &search_start,
(gdb) bt
#0  find_free_extent (profile=2, exclude_nr=0, exclude_start=0, ins=0x7fffffffd760, hint_byte=<optimized out>, 
    search_end=18446744073709551615, search_start=0, empty_size=0, num_bytes=16384, root=0x555555650030, trans=0x5555556620f0)
    at kernel-shared/extent-tree.c:2248
#1  btrfs_reserve_extent (trans=trans@entry=0x5555556620f0, root=root@entry=0x555555650030, num_bytes=num_bytes@entry=16384, 
    empty_size=empty_size@entry=0, hint_byte=hint_byte@entry=0, search_end=search_end@entry=18446744073709551615, 
    ins=0x7fffffffd760, is_data=false) at kernel-shared/extent-tree.c:2379
#2  0x0000555555582eb0 in alloc_tree_block (ins=0x7fffffffd760, search_end=18446744073709551615, hint_byte=0, empty_size=0, level=0, 
    key=0x7fffffffd880, flags=0, generation=<optimized out>, root_objectid=3, num_bytes=16384, root=0x555555650030, 
    trans=0x5555556620f0) at kernel-shared/extent-tree.c:2514
#3  btrfs_alloc_free_block (trans=trans@entry=0x5555556620f0, root=root@entry=0x555555650030, blocksize=16384, root_objectid=3, 
    key=key@entry=0x7fffffffd880, level=level@entry=0, hint=0, empty_size=0) at kernel-shared/extent-tree.c:2569
#4  0x000055555557243f in __btrfs_cow_block (trans=trans@entry=0x5555556620f0, root=root@entry=0x555555650030, 
    buf=buf@entry=0x555555652b90, parent=parent@entry=0x0, parent_slot=parent_slot@entry=0, cow_ret=cow_ret@entry=0x7fffffffdab8, 
    search_start=0, empty_size=0) at kernel-shared/ctree.c:451
#5  0x0000555555572d2e in btrfs_cow_block (trans=trans@entry=0x5555556620f0, root=root@entry=0x555555650030, buf=0x555555652b90, 
    parent=0x0, parent_slot=0, cow_ret=cow_ret@entry=0x7fffffffdab8) at kernel-shared/ctree.c:544
#6  0x0000555555575730 in btrfs_search_slot (trans=0x5555556620f0, root=root@entry=0x555555650030, key=key@entry=0x55555565e030, 
    p=p@entry=0x555555662180, ins_len=ins_len@entry=105, cow=cow@entry=1) at kernel-shared/ctree.c:1377
#7  0x0000555555576e85 in btrfs_insert_empty_items (trans=trans@entry=0x5555556620f0, root=root@entry=0x555555650030, 
    path=path@entry=0x555555662180, cpu_key=cpu_key@entry=0x55555565e030, data_size=data_size@entry=0x7fffffffdb9c, nr=nr@entry=1)
    at kernel-shared/ctree.c:2824
#8  0x0000555555577295 in btrfs_insert_empty_item (data_size=<optimized out>, key=0x55555565e030, path=0x555555662180, 
    root=0x555555650030, trans=0x5555556620f0) at ./kernel-shared/ctree.h:2780
#9  btrfs_insert_item (trans=trans@entry=0x5555556620f0, root=0x555555650030, cpu_key=cpu_key@entry=0x55555565e030, 
    data=0x55555565df50, data_size=80) at kernel-shared/ctree.c:2923
#10 0x00005555555e3058 in restore_missing_chunks (fs_info=0x55555564fbc0) at ./kernel-shared/ctree.h:322
#11 btrfs_find_recover_chunks (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1") at cmds/rescue-recover-chunks.c:457
#12 0x00005555555d7c25 in cmd_rescue_recover_chunks (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#13 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555645d40 <cmd_struct_rescue_recover_chunks>)
    at cmds/commands.h:125
#14 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#15 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555646cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#16 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
