Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2DC53AD09
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiFASub (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFASua (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 14:50:30 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5411269AB
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 11:50:29 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwTQK-0006Mm-8h by authid <merlin>; Wed, 01 Jun 2022 11:50:28 -0700
Date:   Wed, 1 Jun 2022 11:50:28 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220601185027.GG22722@merlins.org>
References: <20220601002552.GD22722@merlins.org>
 <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org>
 <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
 <20220601031536.GD1745079@merlins.org>
 <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org>
 <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
 <20220601180824.GF22722@merlins.org>
 <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
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

On Wed, Jun 01, 2022 at 02:42:55PM -0400, Josef Bacik wrote:
> On Wed, Jun 1, 2022 at 2:08 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Jun 01, 2022 at 02:00:43PM -0400, Josef Bacik wrote:
> > > Ok perfect, now try btrfs rescue recover-chunks <device>, thanks,
> >
> > (gdb) run rescue recover-chunks /dev/mapper/dshelf1
> > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue recover-chunks /dev/mapper/dshelf1
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > FS_INFO IS 0x55555564fbc0
> > Invalid mapping for 15645202989056-15645203005440, got 15664345513984-15665419255808
> > Couldn't map the block 15645202989056
> > Couldn't map the block 15645202989056
> > bad tree block 15645202989056, bytenr mismatch, want=15645202989056, have=0
> > Couldn't read tree root
> > FS_INFO AFTER IS 0x55555564fbc0
> > Walking all our trees and pinning down the currently accessible blocks
> 
> Ok you're ready to go.  Thanks,

Indeed, good job:

FS_INFO IS 0x55555564fbc0
Invalid mapping for 15645202989056-15645203005440, got 15664345513984-15665419255808
Couldn't map the block 15645202989056
Couldn't map the block 15645202989056
bad tree block 15645202989056, bytenr mismatch, want=15645202989056, have=0
Couldn't read tree root
FS_INFO AFTER IS 0x55555564fbc0
Walking all our trees and pinning down the currently accessible blocks
we would add a chunk at 14823605665792-14824679407616 type 0
we would add a chunk at 14824679407616-14825753149440 type 0
we would add a chunk at 14825753149440-14826826891264 type 0
(...)
we would add a chunk at 15772793438208-15773867180032 type 0
we would add a chunk at 15773867180032-15774940921856 type 0
we would add a chunk at 15774940921856-15776014663680 type 0
we would add a chunk at 15776014663680-15777088405504 type 0
we would add a chunk at 15777088405504-15778162147328 type 0
doing close???
Recover chunks succeeded, you can run check now
[Inferior 1 (process 696) exited normally]

Which btrfs check do you want me to run?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
