Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4664F1C42
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbiDDV0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379618AbiDDRqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:46:02 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B8DFBC
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:44:02 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48690 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nbQkA-0003qY-4z by authid <merlins.org> with srv_auth_plain; Mon, 04 Apr 2022 10:43:58 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nbQk9-00ByCz-Qe; Mon, 04 Apr 2022 10:43:57 -0700
Date:   Mon, 4 Apr 2022 10:43:57 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220404174357.GT1314726@merlins.org>
References: <20220329171818.GD1314726@merlins.org>
 <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
 <20220330143944.GE14158@merlins.org>
 <20220331171927.GL1314726@merlins.org>
 <Ykoux6Oczf6+hmGg@localhost.localdomain>
 <20220404010101.GQ1314726@merlins.org>
 <20220404150858.GS1314726@merlins.org>
 <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 04, 2022 at 01:18:48PM -0400, Josef Bacik wrote:
> On Mon, Apr 4, 2022 at 11:09 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, Apr 03, 2022 at 06:01:01PM -0700, Marc MERLIN wrote:
> > > gargamel:~# btrfs rescue chunk-recover /dev/mapper/dshelf1a
> > > Scanning: 1509736448 in dev0
> > >
> > > I'll let this run, looks like it might take a while.
> >
> > 14h later, still going on. I'll update when it's done, it may take a few
> > days.
> > gargamel:~# btrfs rescue chunk-recover /dev/mapper/dshelf1a
> > Scanning: 7049296592896 in dev0
> >
> > Please let me know about the backup chunk roots that all seemed to be
> > the same and were apparently all pointing to the same corrupted version?
> 
> Ok cool apparently we have code that does this already, can you do
> 
> btrfs-find-root -o 3 /dev/whatever
> and then use the bytenr's it finds like you did with the backup roots
 
gargamel:~# btrfs-find-root -o 3 /dev/mapper/dshelf1a 
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
leaf parent key incorrect 13577821667328
WARNING: could not setup extent tree, skipping it
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
leaf parent key incorrect 13577821667328
Couldn't setup device tree
Superblock thinks the generation is 1600938
Superblock thinks the level is 1
Found tree root at 21069824 gen 1600938 level 1
Well block 21053440(gen: 1822 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
Well block 21004288(gen: 1692 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
Well block 20987904(gen: 1443 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
Well block 20971520(gen: 1293 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
Well block 21037056(gen: 1170 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
Well block 21020672(gen: 773 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1

Not a good sign I assume?


> btrfs check --chunk-bytenr <bytenr> /dev/whatever
> 
> and see if one of them works.  You can do this without stopping the
> chunk recovery if you want to let that keep going.  Thanks,
> 
> Josef
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
