Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BAD4D27F6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 05:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiCIEtG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 23:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCIEtF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 23:49:05 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E711C145632
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 20:48:07 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 2D397244DFD; Tue,  8 Mar 2022 23:48:07 -0500 (EST)
Date:   Tue, 8 Mar 2022 23:48:07 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <Yigxh5upbeBQ4zuw@hungrycats.org>
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
 <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 08, 2022 at 10:57:51PM +0100, Jan Ziak wrote:
> On Mon, Mar 7, 2022 at 3:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > On 2022/3/7 10:23, Jan Ziak wrote:
> > > BTW: "compsize file-with-million-extents" finishes in 0.2 seconds
> > > (uses BTRFS_IOC_TREE_SEARCH_V2 ioctl), but "filefrag
> > > file-with-million-extents" doesn't finish even after several minutes
> > > of time (uses FS_IOC_FIEMAP ioctl - manages to perform only about 5
> > > ioctl syscalls per second - and appears to be slowing down as the
> > > value of the "fm_start" ioctl argument grows; e2fsprogs version
> > > 1.46.5). It would be nice if filefrag was faster than just a few
> > > ioctls per second.
> >
> > This is mostly a race with autodefrag.
> >
> > Both are using file extent map, thus if autodefrag is still trying to
> > redirty the file again and again, it would definitely cause problems for
> > anything also using file extent map.
> 
> It isn't caused by a race with autodefrag, but by something else.
> Autodefrag was turned off when I was running "filefrag
> file-with-million-extents".
> 
> $ /usr/bin/time filefrag file-with-million-extents.sqlite
> Ctrl+C Command terminated by signal 2
> 0.000000 user, 4.327145 system, 0:04.331167 elapsed, 99% CPU

FIEMAP will try to populate the SHARED bit for each extent, which requires
checking every extent that overlaps a block range to see if the block is
present.  It can be very expensive for large, random-written files.

No way to fix that without disabling the SHARED bit in FIEMAP.

> Sincerely
> Jan
