Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6744F5454
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiDFEsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2361235AbiDFEZl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 00:25:41 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7182F5ABD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 17:30:54 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbtZU-0006Xl-O5 by authid <merlin>; Tue, 05 Apr 2022 17:30:52 -0700
Date:   Tue, 5 Apr 2022 17:30:52 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220406003052.GL28707@merlins.org>
References: <20220405203737.GE28707@merlins.org>
 <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
 <20220405211412.GF28707@merlins.org>
 <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
 <20220405212655.GH28707@merlins.org>
 <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
 <20220405214309.GI28707@merlins.org>
 <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org>
 <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
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

On Tue, Apr 05, 2022 at 08:23:42PM -0400, Josef Bacik wrote:
> On Tue, Apr 5, 2022 at 6:58 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Apr 05, 2022 at 06:41:02PM -0400, Josef Bacik wrote:
> > > I'm wandering down this rabbit hole because if I'm able to read the
> > > blocks fine, wtf is the device root not being found.  I've pushed more
> > > printfs, lets see what that says.  Thanks,
> >
> > Sure thing. Output is kind of big, summary here, full output bzipped and
> > attached
> > But isn't the tree found at the end?
> > Found tree root at 13577814573056 gen 1602089 level 1
> >
> 
> Alright it's time for the crazy.  Go ahead and pull and start running.
> This is going to take a while to run, we're basically going to walk
> and check all the node pointers in the tree root, if it doesn't look
> right we're going to search the metadata for the best copy to use, and
> then update the block to point at the new block.  It has to do the
> full search every time, because we don't have time for me to properly
> implement a cache, so don't be worried if it takes a while.

Cool, thanks again for all your help, I hope it helps improving the tools
and recovery for all

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/outn
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x562612a192a0
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x562612a192a0

I'll let it run and report back.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
