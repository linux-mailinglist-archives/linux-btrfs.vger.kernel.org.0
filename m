Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F8F39478E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 21:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhE1Twt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 28 May 2021 15:52:49 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38266 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE1Twt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 15:52:49 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 83EE5A7E99D; Fri, 28 May 2021 15:51:13 -0400 (EDT)
Date:   Fri, 28 May 2021 15:51:13 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Cc:     arvidjaar <arvidjaar@gmail.com>,
        Btrfs ML <linux-btrfs@vger.kernel.org>
Subject: Re: some principal questions to "disk full"
Message-ID: <20210528195113.GF11733@hungrycats.org>
References: <1771321158.76542899.1621959622455.JavaMail.zimbra@helmholtz-muenchen.de>
 <2c00a97f-ac79-147c-ddd2-7ff4a90ca941@gmail.com>
 <647580601.78931938.1622022062919.JavaMail.zimbra@helmholtz-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <647580601.78931938.1622022062919.JavaMail.zimbra@helmholtz-muenchen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 26, 2021 at 11:41:02AM +0200, Lentes, Bernd wrote:
> 
> 
> ----- On May 26, 2021, at 7:36 AM, arvidjaar arvidjaar@gmail.com wrote:
> 
> > On 25.05.2021 19:20, Lentes, Bernd wrote:
>  
> 
> >> What can i do to prevent a "disk full" situation ?
> >> Running regulary "btrfs balance" in a cron job ?

Run

	btrfs balance start -dlimit=1 /path/to/your/fs

about once a day.  This will force the filesystem to free up some
allocated but unused space in data chunks, making them unallocated.
This will ensure you have enough unallocated space to allow you to
allocate a new metadata chunk when needed.

btrfs might allocate a new metadata chunk at any time, so it is a good
idea to ensure at least 1GB (preferably 5 or 10 GB) is always unallocated.
The filesystem does have workarounds that will let it continue to work
with very low disk space, but they can degrade performance, increase
write wear, and increase exposure to firmware bugs if your drive has them.

Never balance metadata (full balance or btrfs balance start -m) from a
maintenance script.  This will free metadata chunks and lead directly to
ENOSPC gotchas.  The kernel deals with metadata allocations fairly well
for most users--but only if you don't break it with metadata balances.

If possible, resize your filesystem to about 5GB less than the underlying
device size.  That way, if you get stuck with low space for metadata, you
can do 'btrfs fi resize 1:max /fs' to get some quick and safe emergency
space to complete a balance or a snapshot delete.  Don't forget to resize
back to 5GB less than full size when the crisis is resolved.

> > If you are using more or less recent kernel version, you need not run
> > btrfs balance at all except when possibly converting profiles or adding
> > new device. btrfs became reasonably good at managing free space.
> 
> What is "more or less recent" ? Which version numbers ?

3.18 or later.  It's certainly not a new feature.

> Bernd


