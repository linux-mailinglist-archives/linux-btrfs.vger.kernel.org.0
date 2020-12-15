Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3C2DB480
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgLOTcY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 15 Dec 2020 14:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgLOTcX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 14:32:23 -0500
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962EC0617A7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 11:31:43 -0800 (PST)
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 9CCA07BF;
        Tue, 15 Dec 2020 19:31:39 +0000 (UTC)
Date:   Wed, 16 Dec 2020 00:31:39 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= 
        <holger@applied-asynchrony.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Odd filesystem issue, reading beyond device
Message-ID: <20201216003139.00922c07@natsu>
In-Reply-To: <CAA85sZs6_tj-vE8Yve5ixTez7-9sompG4P24FKmbpZ3ZOY_HnQ@mail.gmail.com>
References: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
        <ccb8c05e-fa56-c88b-c211-f250fe85d815@applied-asynchrony.com>
        <CAA85sZvFBMad6N8hHR5YM56X9DxKE_3CyOT3xEnp9KsWX=fuHQ@mail.gmail.com>
        <CAA85sZt_deCX-jwtwfT_izf_6nsQXbroe=ksKfNErCwjFXWu_g@mail.gmail.com>
        <CAA85sZseX5FLT-RBFRHjZ0_F0V3X9fFEG4faU02KLaXwgaV=PA@mail.gmail.com>
        <CAA85sZs6_tj-vE8Yve5ixTez7-9sompG4P24FKmbpZ3ZOY_HnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 14 Dec 2020 23:27:51 +0100
Ian Kumlien <ian.kumlien@gmail.com> wrote:

> Aaaand sorry, turns out that my raid device was 1 fifth of its
> original size and it had to be manually remedied...
> 
> Now lets see if data survives this...

So, how did it went, and was all data OK?
This was a really nasty release, there will be many people with the same
issue. For instance, just posted:
https://marc.info/?l=linux-raid&m=160805755832376&w=2
Would be helpful if you could reply there with the steps you took to solve it
and your experiences.

Thanks!

> On Mon, Dec 14, 2020 at 10:18 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > On Mon, Dec 14, 2020 at 9:33 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > >
> > > On Mon, Dec 14, 2020 at 8:57 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 14, 2020 at 5:50 PM Holger Hoffstätte
> > > > <holger@applied-asynchrony.com> wrote:
> > > > >
> > > > > On 2020-12-14 17:28, Ian Kumlien wrote:
> > > > > > Hi,
> > > > > >
> > > > > > Upgraded from 5.9.6 to 5.10 and now I get this:
> > > > > > [  581.665506] BTRFS: device fsid 3c16de2d-33b6-436a-ba17-38b917ae3e33
> > > > > > devid 1 transid 258057 /dev/dm-0 scanned by systemd-udevd (1043)
> > > > > > [  589.602444] BTRFS info (device dm-0): use lzo compression, level 0
> > > > > > [  589.602459] BTRFS info (device dm-0): enabling auto defrag
> > > > > > [  589.602465] BTRFS info (device dm-0): using free space tree
> > > > > > [  589.602470] BTRFS info (device dm-0): has skinny extents
> > > > > > [  589.603082] attempt to access beyond end of device
> > > > > >                 dm-0: rw=4096, want=36461289632, limit=10971543296
> > > > > > [  589.603108] attempt to access beyond end of device
> > > > > >                 dm-0: rw=4096, want=36461355168, limit=10971543296
> > > > > > [  589.603125] BTRFS error (device dm-0): failed to read chunk root
> > > > > > [  589.603412] BTRFS error (device dm-0): open_ctree failed
> > > > > > [  834.619193] BTRFS info (device dm-0): use lzo compression, level 0
> > > > > > [  834.619209] BTRFS info (device dm-0): enabling auto defrag
> > > > > > [  834.619214] BTRFS info (device dm-0): using free space tree
> > > > > > [  834.619219] BTRFS info (device dm-0): has skinny extents
> > > > > > [  834.619825] attempt to access beyond end of device
> > > > > >                 dm-0: rw=4096, want=36461289632, limit=10971543296
> > > > > > [  834.619844] attempt to access beyond end of device
> > > > > >                 dm-0: rw=4096, want=36461355168, limit=10971543296
> > > > > > [  834.619858] BTRFS error (device dm-0): failed to read chunk root
> > > > > > [  834.620205] BTRFS error (device dm-0): open_ctree failed
> > > > > >
> > > > > > Any ideas?
> > > > > >
> > > > >
> > > > > See https://lore.kernel.org/lkml/20201214053147.GA24093@codemonkey.org.uk/
> > > > > + followups. Nothing to do with btrfs.
> > > >
> > > > Thank you! and 5.0.1 has been released with the patches reverted, FYI =)
> > >
> > > No, I'm sad to report that that's not it... or there are other deeper
> > > raid issues...
> > >
> > > [  108.688424] BTRFS info (device dm-0): use lzo compression, level 0
> > > [  108.688439] BTRFS info (device dm-0): enabling auto defrag
> > > [  108.688444] BTRFS info (device dm-0): using free space tree
> > > [  108.688449] BTRFS info (device dm-0): has skinny extents
> > > [  108.688955] attempt to access beyond end of device
> > >                dm-0: rw=4096, want=36461289632, limit=10971543296
> > > [  108.688978] attempt to access beyond end of device
> > >                dm-0: rw=4096, want=36461355168, limit=10971543296
> > > [  108.688994] BTRFS error (device dm-0): failed to read chunk root
> > > [  108.689310] BTRFS error (device dm-0): open_ctree failed
> > >
> > > This is with 5.0.1
> >
> > As an update, 5.9.6 can't mount it either
> >
> > > > > -h


-- 
With respect,
Roman
