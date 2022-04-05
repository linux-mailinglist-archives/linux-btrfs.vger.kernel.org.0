Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974264F219F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiDEC5c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiDEC5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:57:20 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2621022F3C2
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 19:07:30 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbYbR-0000lj-DX by authid <merlin>; Mon, 04 Apr 2022 19:07:29 -0700
Date:   Mon, 4 Apr 2022 19:07:29 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405020729.GH5566@merlins.org>
References: <20220405001808.GC5566@merlins.org>
 <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org>
 <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org>
 <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org>
 <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org>
 <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
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

On Mon, Apr 04, 2022 at 09:55:41PM -0400, Josef Bacik wrote:
> On Mon, Apr 4, 2022 at 9:43 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, Apr 04, 2022 at 09:22:26PM -0400, Josef Bacik wrote:
> > > Ok lets try again with -b 13577821667328, and if the owner doesn't say
> > > ROOT_TREE try 13577775284224 and then 13577814573056.  Thanks,
> >
> > EXTENT_TREE, FS_TREE, and FS_TREE
> >
> > And shit, I got distracted and sent the text output to
> > /dev/mapper/dshelf1a, so I clobbered about 30K of the device.
> > I'm assuming there was probably something there?
> 
> Yes the chunk tree, but your FS is DUP so we'll find the other copy,
> it'll be fine.

Great news, thanks.

> Do you have any subvolumes that aren't snapshots?  I think I can
> re-create everything without knowing what other roots there are, but
> if you have snapshots/subvolumes I need to be more careful.
 
6 subvolumes plus snwpshots of them:
media other Soft Sound Video Win

Maybe 50 to 100 snapshots total (mostly snapshots)

> In any case I'm going to go to bed, it's been a long week.  I'll start
> working on a tool to re-create your root tree in the morning, and then
> hopefully we can go from there.  Thanks,

Thanks for your help, have a good night.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
