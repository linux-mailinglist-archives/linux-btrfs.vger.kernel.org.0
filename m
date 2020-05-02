Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B021C2297
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 05:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEBDfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 23:35:11 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44212 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgEBDfK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 23:35:10 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D3BE969F87D; Fri,  1 May 2020 23:35:09 -0400 (EDT)
Date:   Fri, 1 May 2020 23:35:09 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phil Karn <karn@ka9q.net>
Cc:     Jean-Denis Girard <jd.girard@sysnux.pf>,
        linux-btrfs@vger.kernel.org
Subject: Re: Extremely slow device removals
Message-ID: <20200502033509.GG10769@hungrycats.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 01, 2020 at 01:05:20AM -0700, Phil Karn wrote:
> On 4/30/20 11:13, Jean-Denis Girard wrote:
> >
> > Hi Phil,
> >
> > I did something similar one month ago. It took less than 4 hours for
> > 1.71 TiB of data:
> >
> > [xxx@taina ~]$ sudo btrfs replace status /home/SysNux
> > Started on 21.Mar 11:13:20, finished on 21.Mar 15:06:33, 0 write errs, 0
> > uncorr. read errs
> 
> I just realized you did a *replace* rather than a *remove*. When I did a
> replace on another drive, it also went much faster. It must copy the
> data from the old drive to the new one in larger and/or more contiguous
> chunks. It's only the remove operation that's painfully slow.

"Replace" is a modified form of scrub which assumes that you want to
reconstruct an entire drive instead of verifying an existing one.
It reads and writes all the blocks roughly in physical disk order,
and doesn't need to update any metadata since it's not changing any of
the data as it passes through.

"Delete" is resize to 0 followed by remove the empty device.  Resize
requires relocating all data onto other disks--or other locations on
the same disk--one extent at a time, and updating all of the reference
pointers in the filesystem.

The difference in speed can be several orders of magnitude.

> Phil
> 
> 
