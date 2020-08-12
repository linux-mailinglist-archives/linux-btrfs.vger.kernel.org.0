Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD82430D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 00:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHLWef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 18:34:35 -0400
Received: from magic.merlins.org ([209.81.13.136]:54988 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgHLWef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 18:34:35 -0400
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48412 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1k5zKL-0000KN-J6 by authid <merlins.org> with srv_auth_plain; Wed, 12 Aug 2020 15:34:33 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1k5zKL-0003gP-9V; Wed, 12 Aug 2020 15:34:33 -0700
Date:   Wed, 12 Aug 2020 15:34:33 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200812223433.GA533@merlins.org>
References: <20200707035530.GP30660@merlins.org>
 <20200708034407.GE10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708034407.GE10769@hungrycats.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 11:44:07PM -0400, Zygo Blaxell wrote:
> sdd is running firmware 0957, also found in circa-2014 WD Green.
> The others are running 01.01RA2 firmware that appears in a model family
> that includes some broken WD Green and Red models from a few years back
> (including the venerable datavore 80.00A80).  I have a few of the WD
> branded versions of these drives.  They are unusable with write cache
> enabled.  1 in 10 unclean shutdowns lead to filesystem corruption on
> btrfs; on ext4, git and postgresql database corruption.  After disabling
> write cache, I've used them for years with no problems.
> 
> Hopefully your bcache drive is OK, you didn't post any details on that.
> bcache on a drive with buggy firmware write caching fails *spectacularly*.
> 
> You can work around buggy write cache firmware with a udev rule like
> this to disable write cache on all the drives:
> 
>         ACTION=="add|change", SUBSYSTEM=="block", DRIVERS=="sd", KERNEL=="sd*[!0-9]", RUN+="/sbin/hdparm -W 0 $devnode"
> 
> Note that in your logs, the kernel reports that 'sdd' has write cache
> disabled already, maybe due to lack of firmware support or a conservative
> default setting.  That makes it probably the only drive in that array
> that is working properly.

Hi Zygo, took a while to rebuild the array, but it's back up, thanks for
your tips.

To avoid such pain in the future, is there a way for me to find out if
my other drives have such problems so that I disable write caching on
them now?

WDC WD10EADS-00L 01.0 PQ: 0 ANSI: 6
SAMSUNG HD102UJ  1AA0 PQ: 0 ANSI: 6
ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5


As for the failure you helped me with (thanks):
In hindsight, I think I know what went wrong. I was running bees on the
array to reclaim duplicate space (1.2TB saved, so it was worth it).
bees does lots of metadata operations, so that would explain why the
last operations that didn't get saved/got corrupted caused the fatal
corruption I ended up with.

Because it's an external array, I do stop it to save power and do this:
umount /dev/mapper/crypt_bcache0
sync
dmsetup remove crypt_bcache0
echo 1 > /sys/block/md6/bcache/stop
mdadm --stop /dev/md6
/etc/init.d/smartmontools stop
sleep 5
pdu disk3 off  <= cuts power

Note that I umount, then sync just in case, then a bunch of stuff to
free up block devices, but by then the btrfs FS has been unmounted and
synced.
Yet, I added sleep 5 for good measure before turning the drives off.
Do you think the cache was so broken that even with all the steps I
took, it failed to flush?

Either way, I now do this as per your recommenation:
grep md6 /proc/mdstat | sed "s/.*raid5 //" | tr ' ' '\012' | sed "s/1.*//" | while read d; do /sbin/hdparm -v -W 0 /dev/$d; done

Thanks
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
