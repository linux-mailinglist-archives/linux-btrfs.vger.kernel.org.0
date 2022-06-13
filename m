Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC16549DEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiFMTmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbiFMTm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 15:42:28 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71A3644750
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 11:11:12 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id EAC913BD50C; Mon, 13 Jun 2022 14:11:04 -0400 (EDT)
Date:   Mon, 13 Jun 2022 14:10:56 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <Yqd9sIhOiuCSg99Z@hungrycats.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org>
 <20220613022107.6eafbc1c@nvm>
 <20220613174640.GL1664812@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613174640.GL1664812@merlins.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 10:46:40AM -0700, Marc MERLIN wrote:
> On Mon, Jun 13, 2022 at 02:21:07AM +0500, Roman Mamedov wrote:
> > On Sat, 11 Jun 2022 07:52:59 -0700
> > Marc MERLIN <marc@merlins.org> wrote:
> > 
> > > On Sat, Jun 11, 2022 at 02:30:33PM +0500, Roman Mamedov wrote:
> > > > > 2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
> > > > >    gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
> > > > >    [writethrough] writeback writearound none
> > > > 
> > > > Maybe try LVM Cache this time?
> > >  
> > > Hard to know either way, trading one layer for another, and LVM has
> > > always seemed heavier
> > 
> > I'd suggest to put the LUKS volume onto an LV still (in case you don't), so you
> > can add and remove cache just to see how it works; unlike with bcache, an LVM
> > cache can be added to an existing LV and then removed without a trace, all
> > without having to displace 44 TB of data for that.
> 
> Thanks. I've always felt that LVM was heavyweight and required extra
> steps and tools, so I've been avoiding it, but maybe that wasn't
> rational.
> bcache by the way, you can set it up without a backing device and then
> use it normally without the cache layer. I think it's actually pretty
> similar, but you have to set it up beforehand (just like LVM)

You can trivially convert from lvmcache to plain LV on the fly.  It's a
pretty essential capability for long-term maintenance, since you can't
move or resize the LV while it's cached.

If you have a LV and you want it to be cached with bcache, you can hack
up the LVM configuration after the fact with https://github.com/g2p/blocks


> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
> 
