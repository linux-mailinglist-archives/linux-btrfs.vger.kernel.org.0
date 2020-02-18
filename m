Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D8161F1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 03:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgBRCuR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 21:50:17 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:33676 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgBRCuR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 21:50:17 -0500
X-Greylist: delayed 2132 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 21:50:16 EST
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1j3sPJ-0006mJ-MM; Tue, 18 Feb 2020 03:14:41 +0100
Date:   Tue, 18 Feb 2020 03:14:41 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Simeon Felis <simeon_btrfs@sfelis.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: kernel incompatibility?
Message-ID: <20200218021441.GA24450@angband.pl>
References: <8fb8442b-dbf9-4d4b-42bb-ce460048f891@sfelis.de>
 <CAJCQCtSUxC8uF5fAFSOGUDHfRJCY_x8uCSGZ_r_63961Tb17+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJCQCtSUxC8uF5fAFSOGUDHfRJCY_x8uCSGZ_r_63961Tb17+g@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 17, 2020 at 03:55:02PM -0700, Chris Murphy wrote:
> On Sun, Feb 16, 2020 at 2:25 AM Simeon Felis <simeon_btrfs@sfelis.de> wrote:
> > I had a btrfs raid1 running on raspbian (linux 4.19 arm) which
> > overheated.  To fix corruptions I attached the raid1 on my workstation
> > (linux 5.5 x86_64) and performed scrub, defrag and --full-balance (not
> > necessarily in this order) and fixed the corruptions.
> >
> > Back on raspbian a mount fails:
> >
> > root@omv:~# mount /dev/disk/by-label/URAID /mnt/URAID/
> > mount: /mnt/URAID: wrong fs type, bad option, bad superblock on /dev/sda1, missing codepage or helper program, or other error.
> > [   27.304203] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096

> Because you get this on 4.19.97 (which is the latest kernel on Arch
> for ARM v7l), but it mounts OK on 5.5 on x86_64, I'm suspicious it's
> an arch specific bug. I don't offhand see any applicable updates
> through 4.19.103 that would fix this problem.

In particular, you have a filesystem 8TB in size on a 32-bit machine.
That's just below the limit of brokenness.  If the balance allocated
enough new logical addresses...

On the other hand, the addresses mentioned here are just below 4TB.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Remember, the S in "IoT" stands for Security, while P stands
⢿⡄⠘⠷⠚⠋⠀ for Privacy.
⠈⠳⣄⠀⠀⠀⠀
