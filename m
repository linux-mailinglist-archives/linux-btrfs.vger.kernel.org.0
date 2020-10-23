Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C863E296C84
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 12:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461862AbgJWKL5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374103AbgJWKL4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 06:11:56 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA61C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 03:11:56 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kVu2z-0006ov-58; Fri, 23 Oct 2020 12:11:45 +0200
Date:   Fri, 23 Oct 2020 12:11:45 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
Message-ID: <20201023101145.GB19860@angband.pl>
References: <20200405082636.18016-1-kreijack@libero.it>
 <20200405082636.18016-2-kreijack@libero.it>
 <20201023152329.E7FF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201023152329.E7FF.409509F4@e16-tech.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 03:23:30PM +0800, Wang Yugui wrote:
> Hi, Goffredo Baroncelli 
> 
> We can move 'rotational of struct btrfs_device_info' to  'bool rotating
> of struct btrfs_device'.
> 
> 1, it will be more close to 'bool rotating of struct btrfs_fs_devices'.
> 
> 2, it maybe used to enhance the path of '[PATCH] btrfs: balance RAID1/RAID10 mirror selection'.
> https://lore.kernel.org/linux-btrfs/3bddd73e-cb60-b716-4e98-61ff24beb570@oracle.com/T/#t

I don't think it should be a bool -- or at least, turned into a bool
late in the processing.

There are many storage tiers; rotational applies only to one of the
coldest.  In my use case, at least, I've added the following patchlet:

-               devices_info[ndevs].rotational = !test_bit(QUEUE_FLAG_NONROT,
+               devices_info[ndevs].rotational = !test_bit(QUEUE_FLAG_DAX,

Or, you may want Optane NVMe vs legacy (ie, NAND) NVMe.

The tiers look like:
* DIMM-connected Optane (dax=1)
* NVMe-connected Optane
* NVMe-connected flash
* SATA-connected flash
* SATA-connected spinning rust (rotational=1)
* IDE-connected spinning rust (rotational=1)
* SD cards
* floppies?

And even that is just for local storage only.

Thus, please don't hardcode the notion of "rotational", what we want is
"faster but smaller" vs "slower but bigger".

> > From: Goffredo Baroncelli <kreijack@inwind.it>
> > 
> > When this mode is enabled, the allocation policy of the chunk
> > is so modified:
> > - allocation of metadata chunk: priority is given to ssd disk.
> > - allocation of data chunk: priority is given to a rotational disk.
> > 
> > When a striped profile is involved (like RAID0,5,6), the logic
> > is a bit more complex. If there are enough disks, the data profiles
> > are stored on the rotational disks only; instead the metadata profiles
> > are stored on the non rotational disk only.
> > If the disks are not enough, then the profiles is stored on all
> > the disks.

And, a newer version of Goffredo's patchset already had
"preferred_metadata".  It did not assign the preference automatically,
but if we want god defaults, they should be smarter than just rotationality.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Imagine there are bandits in your house, your kid is bleeding out,
⢿⡄⠘⠷⠚⠋⠀ the house is on fire, and seven giant trumpets are playing in the
⠈⠳⣄⠀⠀⠀⠀ sky.  Your cat demands food.  The priority should be obvious...
