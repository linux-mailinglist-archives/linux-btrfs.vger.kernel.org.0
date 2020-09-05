Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59C25E54B
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Sep 2020 06:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgIEEHg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 5 Sep 2020 00:07:36 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43998 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIEEHg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Sep 2020 00:07:36 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8E0657EB809; Sat,  5 Sep 2020 00:07:33 -0400 (EDT)
Date:   Sat, 5 Sep 2020 00:07:33 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hamish Moffatt <hamish-btrfs@moffatt.email>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: new database files not compressed
Message-ID: <20200905040733.GD5890@hungrycats.org>
References: <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
 <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
 <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
 <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email>
 <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
 <dede53e.d98f7053.1744e402728@lechevalier.se>
 <20200902161621.GA5890@hungrycats.org>
 <f32f6fdf-bc20-b1d1-d0ea-08f779723066@moffatt.email>
 <20200903194437.GA21815@hungrycats.org>
 <0c74cc4a-3644-805c-9501-6888c2a03f24@moffatt.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0c74cc4a-3644-805c-9501-6888c2a03f24@moffatt.email>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 04, 2020 at 06:07:32PM +1000, Hamish Moffatt wrote:
> On 4/9/20 5:44 am, Zygo Blaxell wrote:
> > On Thu, Sep 03, 2020 at 10:53:23PM +1000, Hamish Moffatt wrote:
> > 
> > > I recompiled Firebird with fallocate disabled (it has a fallback for
> > > non-linux OSs), and now I have compressed database files.
> > > 
> > > It may be that de-duplication suits my application better anyway. Will
> > > compsize tell me how much space is being saved by de-duplication, or is
> > > there another way to find out?
> > Compsize reports "Uncompressed" and "Referenced" columns.  "Uncompressed"
> > is the physical size of the uncompressed data (i.e. how many bytes
> > you would need to hold all of the extents on disk without compression
> > but with dedupe).  "Referenced" is the logical size of the data, after
> > counting each reference (i.e. how many bytes you would need to hold all
> > of the data without compression or dedupe).
> > 
> > The "none" and "zstd" rows will tell you how much dedupe you're getting
> > on uncompressed and compressed extents separately.
> 
> 
> Great, I have it bees running and I see the deduplication in compsize as you
> said.
> 
> What is the appropriate place to ask question about bees - here, github or
> elsewhere?

I'm in all three places, though I might miss it if it's only posted to
the linux-btrfs list.  If you need to send a log file and you don't want it
to be fully public, there's an email address in the bees README.

> I added some files, restarted bees and it ran a deduplication, but then I
> added some more files (8 hours ago) and there's been some regularly logging
> but the new files haven't been deduplicated.

Information we'd need for this:

	- kernel version you're running

	- bees log, preferably at a level high enough to see the individual
	dedupe ops

	- btrfs dump-tree of the subvol trees containing the files

or a small reproducer.

If there's something like this in the log:

	2020-09-05 04:03:13 4464.4468<5> crawl_5: WORKAROUND: toxic address: addr = 0x544eb000, sys_usage_delta = 0.136, user_usage_delta = 0.02, rt_age = 0.251574, refs 1
	2020-09-05 04:03:13 4464.4468<4> crawl_5: WORKAROUND: discovered toxic match at found_addr 0x544eb000 matching bbd BeesBlockData { 4K 0x1db000 fd = 9 '/try/31264-2', address = 0x54823000, hash = 0x9a2052ab5fe19ae, data[4096] }

then it's bees detecting btrfs taking too long to do an extent lookup, and
blacklisting the extent to avoid crippling performance problems.  On 5.7
it seems to be happening a lot...ironic, given that 5.7 has much faster
backref code.


> Hamish
> 
> 
