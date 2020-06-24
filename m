Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817FF207244
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbgFXLjo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 24 Jun 2020 07:39:44 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38558 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbgFXLjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 07:39:42 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C81E372F178; Wed, 24 Jun 2020 07:39:40 -0400 (EDT)
Date:   Wed, 24 Jun 2020 07:39:40 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Russell Coker <russell@coker.com.au>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev sta not updating
Message-ID: <20200624113940.GQ10769@hungrycats.org>
References: <4857863.FCrPRfMyHP@liv>
 <5752066.y3qnG1rHMR@liv>
 <d4c28f49-f6fc-0fc7-0c4d-4fe8b3ce32a9@suse.com>
 <6248217.VoG1EAXHid@liv>
 <00ce925f-e8bb-be84-40bb-25fd215891e6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <00ce925f-e8bb-be84-40bb-25fd215891e6@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 23, 2020 at 02:13:04PM +0300, Nikolay Borisov wrote:
> 
> 
> On 23.06.20 г. 12:48 ч., Russell Coker wrote:
> > On Tuesday, 23 June 2020 6:17:00 PM AEST Nikolay Borisov wrote:
> >>> In this case I'm getting application IO errors and lost data, so if the
> >>> error count is designed to not count recovered errors then it's still not
> >>> doing the right thing.
> >>
> >> In this case yes, however this was utterly not clear from your initial
> >> email. In fact it seems you have omitted quite a lot of information. So
> >> let's step back and start afresh. So first give information about your
> >> current btrfs setup by giving the output of:
> >>
> >> btrfs fi usage /path/to/btrfs
> > 
> > # btrfs fi usa .
> > Overall:
> >     Device size:                  62.50GiB
> >     Device allocated:             19.02GiB
> >     Device unallocated:           43.48GiB
> >     Device missing:                  0.00B
> >     Used:                         16.26GiB
> >     Free (estimated):             44.25GiB      (min: 22.51GiB)
> >     Data ratio:                       1.00
> >     Metadata ratio:                   2.00
> >     Global reserve:               17.06MiB      (used: 0.00B)
> > 
> > Data,single: Size:17.01GiB, Used:16.23GiB (95.43%)
> >    /dev/sdc1      17.01GiB
> > 
> > Metadata,DUP: Size:1.00GiB, Used:17.19MiB (1.68%)
> >    /dev/sdc1       2.00GiB
> > 
> > System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
> >    /dev/sdc1      16.00MiB
> > 
> > Unallocated:
> >    /dev/sdc1      43.48GiB
> 
> Do you use compression on this filesystem i.e have you mounted with
> -ocompression= option ?
> 
> Based on this data alone it's evident that you don't really have mirrors
> of the data, in this case having experienced the checksum errors should
> have indeed resulted in error counters being incremented. I'll look into
> this.

In commit 0cc068e6ee59 "btrfs: don't report readahead errors and don't
update statistics" we stopped counting errors if they occur during
readahead.  If there's a mirror available, we do still correct errors
in that case.  Errors in readahead are fairly common, e.g. there are
usually a few during lvm pvmove operations, so it maybe makes sense
not to count them; however, if the errors are not counted, they should
also not be repaired.  Instead, they should be repaired only during
non-readahead reads (i.e. when the repairs will be counted in dev stats).
Repairing errors without counting is bad because it hides an important
indicator of device failure.

This thread might be a different issue since there aren't any mirrors
with single data, but if you're look at dev stats correctness anyway...

> <snip>
