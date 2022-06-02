Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0483853BF25
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 21:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbiFBTvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 15:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiFBTvh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 15:51:37 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC9C08
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 12:51:36 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwqr0-0006nV-6M by authid <merlin>; Thu, 02 Jun 2022 12:51:34 -0700
Date:   Thu, 2 Jun 2022 12:51:34 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220602195134.GT22722@merlins.org>
References: <20220602015526.GM22722@merlins.org>
 <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org>
 <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
 <20220602142112.GQ22722@merlins.org>
 <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
 <20220602143606.GR22722@merlins.org>
 <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
 <20220602190848.GS22722@merlins.org>
 <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
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

On Thu, Jun 02, 2022 at 03:35:46PM -0400, Josef Bacik wrote:
> On Thu, Jun 2, 2022 at 3:08 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Thu, Jun 02, 2022 at 02:43:03PM -0400, Josef Bacik wrote:
> > > Now we run
> > >
> > > btrfs rescue tree-recover <device>
> >
> > It got pretty far, and then
> > Invalid mapping for 364837339136-364837355520, got 11106814787584-11107888529408
> > Couldn't map the block 364837339136
> > Couldn't map the block 364837339136
> > deleting slot 0 in block 11160501878784
> > Invalid mapping for 364837306368-364837322752, got 11106814787584-11107888529408
> > Couldn't map the block 364837306368
> > Couldn't map the block 364837306368
> > deleting slot 0 in block 11160501878784
> > Invalid mapping for 364746457088-364746473472, got 11106814787584-11107888529408
> > Couldn't map the block 364746457088
> > Couldn't map the block 364746457088
> > deleting slot 0 in block 11160501878784
> 
> Was it printing a lot of these messages?  I was sort of hoping we

Yes

> found all the chunks so it didn't feel the need to delete a bunch of
> stuff.  Can you re-run
> 
> btrfs rescue recover-chunks <device>
> 
> and make sure it doesn't find anything new?  Maybe there were some
> system chunks that it found that has the other chunks in it.  Thanks,

output is very long.  I was able to paste a good part in
https://justpaste.it/5cy5s

last lines:
trying bytenr 15645980491776 got 3 blocks 8 bad
Repairing root 163318 bad_blocks 8 update 1
Invalid mapping for 11822436614144-11822436630528, got 14271702368256-14272776110080
Couldn't map the block 11822436614144
Couldn't map the block 11822436614144
deleting slot 0 in block 15645980491776
Invalid mapping for 365011795968-365011812352, got 11106814787584-11107888529408
Couldn't map the block 365011795968
Couldn't map the block 365011795968
deleting slot 0 in block 15645980491776
Invalid mapping for 365043269632-365043286016, got 11106814787584-11107888529408
Couldn't map the block 365043269632
Couldn't map the block 365043269632
deleting slot 0 in block 15645980491776
Invalid mapping for 365031768064-365031784448, got 11106814787584-11107888529408
Couldn't map the block 365031768064
Couldn't map the block 365031768064
deleting slot 0 in block 15645980491776
Invalid mapping for 365028409344-365028425728, got 11106814787584-11107888529408
Couldn't map the block 365028409344
Couldn't map the block 365028409344
deleting slot 0 in block 15645980491776
Invalid mapping for 365033668608-365033684992, got 11106814787584-11107888529408
Couldn't map the block 365033668608
Couldn't map the block 365033668608
deleting slot 0 in block 15645980491776
deleting slot 0 in block 15645980491776
deleting slot 0 in block 15645980491776
bad tree block 15645980491776, invalid nr_items: 0
kernel-shared/disk-io.c:553: write_tree_block: BUG_ON `1` triggered, value 1
./btrfs(+0x25ae7)[0x558782bb4ae7]
./btrfs(write_tree_block+0xb8)[0x558782bb6ec9]
./btrfs(+0x8aa38)[0x558782c19a38]
./btrfs(+0x8adcb)[0x558782c19dcb]
./btrfs(btrfs_recover_trees+0x628)[0x558782c1aa3b]
./btrfs(+0x83f1f)[0x558782c12f1f]
./btrfs(handle_command_group+0x49)[0x558782ba717b]
./btrfs(main+0x94)[0x558782ba7275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f06496ad7fd]
./btrfs(_start+0x2a)[0x558782ba6e1a]
Aborted

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
