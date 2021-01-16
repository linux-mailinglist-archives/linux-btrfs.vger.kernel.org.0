Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC72F8DCC
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbhAPRJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 12:09:15 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:36988 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbhAPRIr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 12:08:47 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jan 2021 12:08:46 EST
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1l0nMT-001aGs-NI; Sat, 16 Jan 2021 16:19:33 +0100
Date:   Sat, 16 Jan 2021 16:19:33 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, dsterba@suse.cz,
        waxhead <waxhead@dirtcellar.net>, linux-btrfs@vger.kernel.org
Subject: Re: Why do we need these mount options?
Message-ID: <20210116151933.GA374963@angband.pl>
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz>
 <20210115035448.GD31381@hungrycats.org>
 <94a65b16-3a23-6862-9de6-169620302308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94a65b16-3a23-6862-9de6-169620302308@gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 10:39:51AM +0300, Andrei Borzenkov wrote:
> 15.01.2021 06:54, Zygo Blaxell пишет:
> > On the other hand, I'm in favor of deprecating the whole discard option
> > and going with fstrim instead.  discard in its current form tends to
> > increase write wear rather than decrease it, especially on metadata-heavy
> > workloads.  discard is roughly equivalent to running fstrim thousands
> > of times a day, which is clearly bad for many (most?  all?) SSDs.
> 
> My (probably naive) understanding so far was that trim on SSD marks
> areas as "unused" which means SSD need to copy less residual data from
> erase block when reusing it. Assuming TRIM unit is (significantly)
> smaller than erase block.
> 
> I would appreciate if you elaborate how trim results in more write on SSD?

The areas are not only marked as unused, but also zeroed.  To keep the
zeroing semantic, every discard must be persisted, thus requiring a write
to the SSD's metadata (not btrfs metadata) area.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ .--[ Makefile ]
⣾⠁⢠⠒⠀⣿⡁ # beware of races
⢿⡄⠘⠷⠚⠋⠀ all: pillage burn
⠈⠳⣄⠀⠀⠀⠀ `----
