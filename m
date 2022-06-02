Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7504653BE63
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 21:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiFBTIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 15:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbiFBTIv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 15:08:51 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867360DB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 12:08:49 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwqBc-0002FB-M1 by authid <merlin>; Thu, 02 Jun 2022 12:08:48 -0700
Date:   Thu, 2 Jun 2022 12:08:48 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220602190848.GS22722@merlins.org>
References: <20220602000637.GL22722@merlins.org>
 <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
 <20220602015526.GM22722@merlins.org>
 <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org>
 <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
 <20220602142112.GQ22722@merlins.org>
 <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
 <20220602143606.GR22722@merlins.org>
 <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
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

On Thu, Jun 02, 2022 at 02:43:03PM -0400, Josef Bacik wrote:
> Now we run
> 
> btrfs rescue tree-recover <device>
 
It got pretty far, and then
Invalid mapping for 364837339136-364837355520, got 11106814787584-11107888529408
Couldn't map the block 364837339136
Couldn't map the block 364837339136
deleting slot 0 in block 11160501878784
Invalid mapping for 364837306368-364837322752, got 11106814787584-11107888529408
Couldn't map the block 364837306368
Couldn't map the block 364837306368
deleting slot 0 in block 11160501878784
Invalid mapping for 364746457088-364746473472, got 11106814787584-11107888529408
Couldn't map the block 364746457088
Couldn't map the block 364746457088
deleting slot 0 in block 11160501878784
bad tree block 11160501878784, invalid nr_items: 0
kernel-shared/disk-io.c:553: write_tree_block: BUG_ON `1` triggered, value 1
./btrfs(+0x25ae7)[0x55c9d8c1bae7]
./btrfs(write_tree_block+0xb8)[0x55c9d8c1dec9]
./btrfs(+0x8aa38)[0x55c9d8c80a38]
./btrfs(+0x8acbe)[0x55c9d8c80cbe]
./btrfs(+0x8adcb)[0x55c9d8c80dcb]
./btrfs(btrfs_recover_trees+0x628)[0x55c9d8c81a3b]
./btrfs(+0x83f1f)[0x55c9d8c79f1f]
./btrfs(handle_command_group+0x49)[0x55c9d8c0e17b]
./btrfs(main+0x94)[0x55c9d8c0e275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7fe2988107fd]
./btrfs(_start+0x2a)[0x55c9d8c0de1a]
Aborted


> to restore the roots we lost.  After that we run
> 
> btrfs rescue init-extent-tree <device>
> 
> then
> 
> btrfs rescue init-csum-tree <device>
> 
> and then finally we run
> 
> btrfs check <device>
> 
> Now I have to write some code to fix up the device extents for the
> chunks I just added back, but I need to make sure that's the only
> thing check complains about.  Once we have that worked out I'll write
> the code to add the device extents for the restored chunks and then
> theoretically we'll be done.  Thanks,
> 
> Josef
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
