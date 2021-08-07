Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33C3E37B8
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Aug 2021 02:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhHHAZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Aug 2021 20:25:53 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:47832 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhHHAZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Aug 2021 20:25:53 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Aug 2021 20:25:52 EDT
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mCWCt-002MnW-UK; Sun, 08 Aug 2021 01:58:23 +0200
Date:   Sun, 8 Aug 2021 01:58:23 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Dave T <davestechshop@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Phillip Susi <phill@thesusis.net>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
Message-ID: <YQ8eH/SuXpF6p0b6@angband.pl>
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <87eeb7pysj.fsf@vps.thesusis.net>
 <CAGdWbB5+UOxxF21JxbzvVP3F-0zhDF4rpBc820fmc54Hyv-5WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdWbB5+UOxxF21JxbzvVP3F-0zhDF4rpBc820fmc54Hyv-5WQ@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 05, 2021 at 04:41:03PM -0400, Dave T wrote:
> On Thu, Aug 5, 2021 at 1:49 PM Phillip Susi <phill@thesusis.net> wrote:
> > Dave T <davestechshop@gmail.com> writes:
> >
> > > I'm using btrbk via a systemd timer. I have a daily and hourly timer
> > > set up. Each timer starts by mounting the btrfs root, performing the
> > > btrbk task, and unmounting the btrfs root.

> Not exactly... that path should not be unmounted. I do not mount that
> location explicitly for the btrbk tasks. It is mounted when the server
> boots up with the bind mount line I showed in fstab:
> 
> /var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  0 0
> 
> It should not be unmounted (or remounted) just because the top level
> btrfs volume is (un)mounted for btrbk tasks. That's the part that is
> confusing me.
> 
> There is no command associated with my btrbk tasks that mounts
> /srv/nfs/var/cache/pacman (or /var/cache/pacman). There's no other
> entry in fstab for it except the bind mount I showed.

I've seen systemd randomly mount and/or unmount filesystems listed in fstab
when their state somehow differs from what systemd thinks should be (which
can happen either by you or a program doing a mount, or due to systemd
misreading the state reported by the kernel).

So I wonder, can you test with an init/rc other than systemd?


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ If you ponder doing what Jesus did, remember than flipping tables
⢿⡄⠘⠷⠚⠋⠀ and chasing people with a whip is a prime choice.
⠈⠳⣄⠀⠀⠀⠀
