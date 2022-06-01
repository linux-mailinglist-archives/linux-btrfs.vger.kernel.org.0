Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC24539B86
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349274AbiFADPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 23:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiFADPj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 23:15:39 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF15C91581
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 20:15:37 -0700 (PDT)
Received: from [104.132.0.109] (port=57520 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nwE7F-0003im-Lf by authid <merlins.org> with srv_auth_plain; Tue, 31 May 2022 20:15:36 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nwEpc-008YHJ-OY; Tue, 31 May 2022 20:15:36 -0700
Date:   Tue, 31 May 2022 20:15:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220601031536.GD1745079@merlins.org>
References: <20220530191834.GK24951@merlins.org>
 <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
 <20220531011224.GA1745079@merlins.org>
 <CAEzrpqco_RyUBK=dngrv54u8WE2uhSGrJaB9aRY5nUmKNzN32Q@mail.gmail.com>
 <20220531224951.GC22722@merlins.org>
 <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
 <20220601002552.GD22722@merlins.org>
 <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org>
 <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 104.132.0.109
X-SA-Exim-Connect-IP: 104.132.0.109
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 31, 2022 at 10:10:49PM -0400, Josef Bacik wrote:
> On Tue, May 31, 2022 at 9:29 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, May 31, 2022 at 09:26:03PM -0400, Josef Bacik wrote:
> > > On Tue, May 31, 2022 at 8:25 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Tue, May 31, 2022 at 08:14:27PM -0400, Josef Bacik wrote:
> > > > > Wtf, we're clearly writing the chunk root properly because I have to
> > > > > re-open it to recover the tree root, and that's where it fails, but
> > > > > then the chunk restore can't open the root, despite it being correctly
> > > > > read in the tree recover.  I've pushed new code, try tree-recover and
> > > > > then recover-chunks again and capture the output please.  Thanks,
> > > >
> > > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > >
> > > Ah ok, I wasn't actually updating the pointer, fixed that, lets try
> > > the same sequence again.  Thanks,
> >
> 
> Ok backup roots don't work if we didn't read them, try again please.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# git pull
Already up-to-date.
gargamel:/var/local/src/btrfs-progs-josefbacik# gdb ./btrfs rescue tree-recover /dev/mapper/dshelf1
Excess command line arguments ignored. (tree-recover ...)
GNU gdb (Debian 7.12-6+b2) 7.12.0.20161007-git
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./btrfs...done.
/var/local/src/btrfs-progs-josefbacik/rescue: No such file or directory.
(gdb) run rescue tree-recover /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue tree-recover /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
WARNING: cannot read chunk root, continue anyway
none of our backups was sufficient, scanning for a root
scanning, best has 0 found 1 bad
ret is 0 offset 20971520 len 8388608
ret is -2 offset 20971520 len 8388608
checking block 22495232 generation 1572124 fs info generation 2582703
trying bytenr 22495232 got 1 blocks 0 bad
checking block 22462464 generation 1479229 fs info generation 2582703
trying bytenr 22462464 got 1 blocks 0 bad
checking block 22528000 generation 1572115 fs info generation 2582703
trying bytenr 22528000 got 1 blocks 0 bad
checking block 22446080 generation 1571791 fs info generation 2582703
trying bytenr 22446080 got 1 blocks 0 bad
checking block 22544384 generation 1556078 fs info generation 2582703
trying bytenr 22544384 got 1 blocks 0 bad
checking block 22511616 generation 1555799 fs info generation 2582703
trying bytenr 22511616 got 1 blocks 0 bad
checking block 22577152 generation 1586277 fs info generation 2582703
trying bytenr 22577152 got 1 blocks 0 bad
checking block 22478848 generation 1561557 fs info generation 2582703
trying bytenr 22478848 got 1 blocks 0 bad
checking block 22593536 generation 1590219 fs info generation 2582703
trying bytenr 22593536 got 1 blocks 0 bad
checking block 22609920 generation 1551635 fs info generation 2582703
trying bytenr 22609920 got 1 blocks 0 bad
checking block 22560768 generation 1590217 fs info generation 2582703
trying bytenr 22560768 got 1 blocks 0 bad
ret is 0 offset 20971520 len 8388608
ret is -2 offset 20971520 len 8388608
setting chunk root to 22593536

Program received signal SIGSEGV, Segmentation fault.
0x000055555557b328 in backup_super_roots (info=0x55555564fbc0) at kernel-shared/disk-io.c:2027
2027            if (!info->chunk_root->node ||
(gdb) bt
#0  0x000055555557b328 in backup_super_roots (info=0x55555564fbc0) at kernel-shared/disk-io.c:2027
#1  write_all_supers (fs_info=fs_info@entry=0x55555564fbc0) at kernel-shared/disk-io.c:2110
#2  0x00005555555df4ef in repair_super_root (fs_info_ptr=fs_info_ptr@entry=0x7fffffffdce8, ocf=ocf@entry=0x7fffffffdcc0, 
    objectid=objectid@entry=3) at cmds/rescue-tree-recover.c:958
#3  0x00005555555df67d in btrfs_recover_trees (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1")
    at cmds/rescue-tree-recover.c:1194
#4  0x00005555555d80df in cmd_rescue_tree_recover (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:176
#5  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555645c20 <cmd_struct_rescue_tree_recover>)
    at cmds/commands.h:125
#6  handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#7  0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555646cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#8  main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
