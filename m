Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895294D6C18
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 03:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiCLCss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 21:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLCss (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 21:48:48 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CD9118A78F
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 18:47:43 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 6F4962502AA; Fri, 11 Mar 2022 21:47:41 -0500 (EST)
Date:   Fri, 11 Mar 2022 21:47:40 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     ov2k <ov2k.github@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: FIDEDUPERANGE and compression
Message-ID: <YiwJzPEk6xfrjdx/@hungrycats.org>
References: <CADwZqEvZQmwnY7e5LcUmgQ7EMmMx1XV-znnQMJG3D_fKtpDcdw@mail.gmail.com>
 <YhMzKeX3FvJPvtmR@hungrycats.org>
 <CADwZqEts39gdoLKCN2t18UByo_WnLmoRPCbja61wVwSt3wvuhQ@mail.gmail.com>
 <YiQ8HgWVNAnBFjVj@hungrycats.org>
 <CADwZqEs8PHvmGAg4=+qwiQgrY1gFksoNkLZi3rne7uTFzZhoeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADwZqEs8PHvmGAg4=+qwiQgrY1gFksoNkLZi3rne7uTFzZhoeA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 09, 2022 at 03:04:40PM -0500, ov2k wrote:
> On Sat, Mar 5, 2022 at 11:44 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Mon, Feb 21, 2022 at 05:31:13PM -0500, ov2k wrote:
> > > It looks like btrfs coalesces adjacent uncompressed extents.  I'm not
> > > sure whether this is done by FIDEDUPERANGE or FS_IOC_FIEMAP.  I think
> > > the problem is that adjacent decompressed ranges (defined by #3 and
> > > #4) within the same compressed block are not coalesced in a similar
> > > manner.  Is there a particular reason why this isn't done, or is this
> > > simply a case of nobody having done it?
> >
> > It hasn't been done because FIEMAP can't produce results for compressed
> > extents that aren't nonsense.  The interface can't cope with compressed
> > data.
> >
> 
> I think there's a misunderstanding here.  The issue isn't making FS_IOC_FIEMAP
> represent compressed data sensibly.  The goal is for btrfs_fiemap() to handle
> adjacent subranges of a compressed extent in much the same way as it handles
> adjacent uncompressed extents.  The result should be no more or less
> nonsensical than it already is.
[...]
> I'm talking about emitting a single struct fiemap_extent that corresponds to
> two adjacent subranges of the same compressed btrfs extent.  The two btrfs
> extents would simply have to satisfy:
> 
>         extent 1 #2 (bytenr) == extent2 #2 (bytenr)
> 
>         extent 1 #1 (seek offset) + extent 1 #3 (decompressed subrange length)
>         == extent 2 #1 (seek offset)
> 
>         extent 1 #4 (decompressed subrange offset) + extent 1 #3 (decompressed
>         subrange length) == extent 2 #4 (decompressed subrange offset)
> 
> The resulting struct fiemap_extent would have:
> 
>         fe_logical: extent 1 #1 (seek offset)
> 
>         fe_physical: extent 1 #2 (bytenr)
> 
>         fe_length: extent 1 #3 (decompressed subrange length) + extent 2 #3
>         (decompressed subrange length)

OK, FIEMAP could handle that one special case.  And it is a frequently
requested feature--filefrag's physically-contiguous-extent counter report
doesn't work at all on compressed files, and it could work in the common
case of a simple sequential write (or reflink thereof).

On the other hand, if you're trying to do dedupe on btrfs, you'll need
access to all the other extent fields to avoid bookending issues.
