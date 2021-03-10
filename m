Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F038B3344E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhCJRMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 12:12:31 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33552 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhCJRMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 12:12:22 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8CF779C41DF; Wed, 10 Mar 2021 12:12:21 -0500 (EST)
Date:   Wed, 10 Mar 2021 12:12:21 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     telsch <telsch@gmx.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: no memory is freed after snapshots are deleted
Message-ID: <20210310171221.GN32440@hungrycats.org>
References: <trinity-e300b8c5-315a-4823-8664-4f663481461c-1615378067176@3c-app-gmx-bs66>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-e300b8c5-315a-4823-8664-4f663481461c-1615378067176@3c-app-gmx-bs66>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 10, 2021 at 01:07:47PM +0100, telsch wrote:
> Dear devs,
> 
> after my root partiton was full, i deleted the last monthly snapshots. however, no memory was freed.
> so far rebalancing helped:
> 
> 	btrfs balance start -v -musage=0 /
> 	btrfs balance start -v -dusage=0 /
> 
> i have deleted all snapshots, but no memory is being freed this time.
> 
> du -hcsx /
> 16G     /
> 16G     total
> 
> btrfs-progs v5.10.1
> Linux arch-server 5.10.21-1-lts #1 SMP Sun, 07 Mar 2021 11:56:15 +0000 x86_64 GNU/Linux
> 
> btrfs fi show /
> Label: none  uuid: 3d242677-6a15-4ce7-853a-5c82f0427769
>         Total devices 1 FS bytes used 37.24GiB
>         devid    1 size 39.95GiB used 39.95GiB path /dev/mapper/root
> 
> btrfs fi df /
> Data, single: total=36.45GiB, used=35.86GiB
> System, DUP: total=32.00MiB, used=16.00KiB
> Metadata, DUP: total=1.72GiB, used=1.38GiB
> GlobalReserve, single: total=215.94MiB, used=0.00B

Check

	btrfs sub list -d /

to make sure there are no deleted snapshots pending.  If a snapshot
has a single open file on it (or a bind mount or similar equivalent to
an open file), the cleaner will not delete it until the last open file
descriptor is closed.  You'll have to find the process with the open
file and convince it to close the file (or kill the process).  This can
be tricky since lsof and fuser are not able to identify open files on
deleted snapshots, so these tools are not usable.  Rebooting will force
all the files to be closed.

You can also use 'compsize' and measure the difference in size
between 'referenced' and 'usage' columns.  If referenced is below
usage then you have some big extents with small references (this can
be caused by prealloc and some database write patterns, or by using
a non-btrfs-extent-aware dedupe tool).  Defrag will get rid of those
if you have no snapshots.  You will have to start at the top of the
filesystem tree and work your way down until you find the offending files,
as compsize can only give you a summary.

> any ideas how to solve this without recreating filesystem?
> 
> thx!
