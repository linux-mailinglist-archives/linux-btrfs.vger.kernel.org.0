Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 186A811B90E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfLKQol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 11:44:41 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:53122 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfLKQoj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 11:44:39 -0500
X-Greylist: delayed 2674 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 11:44:38 EST
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1if4PA-0000Si-Jj; Wed, 11 Dec 2019 17:00:00 +0100
Date:   Wed, 11 Dec 2019 17:00:00 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl
 succeeds?
Message-ID: <20191211160000.GB14837@angband.pl>
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 04:11:05PM +0300, Cerem Cem ASLAN wrote:
> This is the second time after a year that the server's disk throws
> "INPUT OUTPUT ERROR" and "btrfs scrub" finds some uncorrectable errors
> along with some corrected errors. However, "smartctl -x" displays
> "SMART overall-health self-assessment test result: PASSED".
> 
> Should we interpret "btrfs scrub"'s "uncorrectable error count" as
> "time to replace the disk" or are those unrelated events?

"btrfs scrub" operates on a higher layer, and can detect more errors, some
of which may have a cause elsewhere.  For example, dodgy memory very often
corrupts data this way; you can retry the scrub to see if the corruption
happened during write (so the data is lost) or during read (so retrying
should work).  In that case, you may want to test and/or replace your
memory, motherboard, processor, etc.

Or, the disk's firmware may fail to detect errors.  It's supposed to verify
disk's internal checksum but detecting errors is another place where a dodgy
manufacturer can shave some costs -- either intentionally, or by neglecting
testing.

Or, some buggy software (which may even include btrfs itself, albeit
unlikely) might scribble on wrong areas of the disk.

Or...


Anyway, all you know for sure that you have _some_ breakage, which a
filesystem without data checksums would fail to detect, allowing silent data
corruption.  Finding the cause is another story.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ A MAP07 (Dead Simple) raspberry tincture recipe: 0.5l 95% alcohol,
⣾⠁⢠⠒⠀⣿⡁ 1kg raspberries, 0.4kg sugar; put into a big jar for 1 month.
⢿⡄⠘⠷⠚⠋⠀ Filter out and throw away the fruits (can dump them into a cake,
⠈⠳⣄⠀⠀⠀⠀ etc), let the drink age at least 3-6 months.
