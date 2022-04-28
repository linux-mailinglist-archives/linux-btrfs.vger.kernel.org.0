Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509AF5129DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 05:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbiD1DOr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 23:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiD1DOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 23:14:45 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA44E61280
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 20:11:31 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1njuZ1-0000NH-7N by authid <merlin>; Wed, 27 Apr 2022 20:11:31 -0700
Date:   Wed, 27 Apr 2022 20:11:31 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220428031131.GO29107@merlins.org>
References: <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org>
 <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org>
 <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
 <20220428001822.GZ12542@merlins.org>
 <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org>
 <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 11:08:02PM -0400, Josef Bacik wrote:
> On Wed, Apr 27, 2022 at 11:00 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 08:44:01PM -0400, Josef Bacik wrote:
> > > Ok it should work now.  Thanks,
> >
> > Mmmh, it got worse, unfortunately
> >
> 
> Well not worse, just failed earlier because that's where the new code
> is.  I think I just made a simple mistake, but I added some print'fs
> just in case.  Thanks,

That helped:
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 1474560 of 18446744073706422272 possible bytes
Recording extents for root 4
processed 1032192 of 1064960 possible bytes
Recording extents for root 5
processed 10960896 of 10977280 possible bytes
Recording extents for root 7
processed 1707278336 of 16545742848 possible byteskernel-shared/extent-tree.c:1193: insert_inline_extent_backref: BUG_ON `owner < BTRFS_FIRST_FREE_OBJECTID` triggered, value 1
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x2975e)[0x55555557d75e]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_inc_extent_ref+0x138)[0x55555557ed77]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8be01)[0x5555555dfe01]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8beab)[0x5555555dfeab]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8beab)[0x5555555dfeab]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8c116)[0x5555555e0116]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_init_extent_tree+0xe96)[0x5555555e1089]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x83a43)[0x5555555d7a43]
/var/local/src/btrfs-progs-josefbacik/btrfs(handle_command_group+0x49)[0x55555556c17b]
/var/local/src/btrfs-progs-josefbacik/btrfs(main+0x94)[0x55555556c275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7ffff78617fd]
/var/local/src/btrfs-progs-josefbacik/btrfs(_start+0x2a)[0x55555556be1a]

Program received signal SIGABRT, Aborted.
0x00007ffff78768a1 in raise () from /lib/x86_64-linux-gnu/libc.so.6

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
