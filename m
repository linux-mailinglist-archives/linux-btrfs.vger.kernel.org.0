Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4E44F2017
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 01:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbiDDXQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 19:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbiDDXQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 19:16:25 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C908E2DD6A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 16:05:49 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id C6D2B2AA342; Mon,  4 Apr 2022 19:05:46 -0400 (EDT)
Date:   Mon, 4 Apr 2022 19:05:44 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Pierre Abbat <phma@bezitopo.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Computer stalled, apparently from filesystem corruption
Message-ID: <Ykt5yORl1OsMRODL@hungrycats.org>
References: <12976593.dW097sEU6C@puma>
 <YiwKA1LTrX56dd9T@hungrycats.org>
 <3205109.rnzMqkiUVr@puma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3205109.rnzMqkiUVr@puma>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 03, 2022 at 02:14:34AM -0400, Pierre Abbat wrote:
> On Friday, March 11, 2022 9:48:35 PM EDT Zygo Blaxell wrote:
> > There's no indication of corruption in those logs.  Above the kernel
> > is complaining that it's taking too long to finish transactions, which
> > could be a btrfs problem, or a hardware problem, or even simply a large
> > filesystem running normally on very slow disks.  Not enough information
> > to tell.
> 
> It couldn't be a very slow disk, because all the drives are NVM or SSD.

Those can be slow too.  It's up to the firmware and the health of the
underlying flash media, and some devices also implement throttling when
over temperature.

e.g. Samsung 860 EVO has a firmware quirk that makes them significantly
slower than spinning drives under continuous load.  The drive drops to
2 iops every 5 seconds, an almost complete stop.

> > When posting logs, extract all lines with 'btrfs' on them, plus context
> > lines, e.g.
> > 
> > 	grep -B9 -i btrfs /var/log/kern.log
> > 
> > or
> > 
> > 	dmesg | grep -B9 -i btrfs
> > 
> > If you can reproduce the hang, enable sysrq and do Alt-SysRq-W when it
> > hangs (or run
> > 
> > 	echo w > /proc/sysrq-trigger
> > 
> > from a command line).  This will provide stack traces of all blocked
> > processes so we can see what the transaction is waiting for.
> 
> Here are the whole sections of the logfiles from the first error until the 
> computer hung, compressed. I'm afraid to run the rsync script again because it 
> might hang the computer. 

It's probably not the rsync--I've retired quite a few btrfs bugs triggered
by rsync, and your stack traces are pointing to system calls that rsync
never uses (though rsync is caught up in the hang which affects everything
writing the filesystem).

> Is there a way to find out if the filesystem access 
> hung on a bad sector or something?

Generally that would eventually trigger a timeout which would be reported
by the device layer, but some device drivers fail to recover from those.

If the device is truly hung, then you wouldn't be able to access the
device while the filesystem is locked up.  Try this command (with "..."
replaced with the device name):

	dd if=/dev/... of=/dev/null bs=4k status=progress

If it shows progress as data is read from the device, then the device
isn't hung.  If it shows very slow progress (like <100K per 5 seconds)
then the device isn't hung, but it is having some kind of problem
that needs to be addressed (pick a different device model, add a heat
sink, replace a failing device, replace a failing HBA, whatever).

This looks like a more conventional btrfs deadlock bug, though:
everything seems to be waiting for a fsync on a directory.  You might
try a different kernel, either the previous LTS (5.10) or the next one
(5.15) or the current release (5.17) to see if it is already resolved.

If it still happens on a current release, try

	echo w > /proc/sysrq-trigger
	echo d > /proc/sysrq-trigger

and post the logs.  Maybe someone can figure out what the deadlock is.

> Pierre
> 
> -- 
> Lanthanidia deliciosa: What the kiwifruit would be
> if it weren't so radioactive.


