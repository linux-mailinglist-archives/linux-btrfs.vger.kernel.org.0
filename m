Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB47218E72
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGHRlM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 13:41:12 -0400
Received: from magic.merlins.org ([209.81.13.136]:40498 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgGHRlM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 13:41:12 -0400
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:40354 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1jtE4F-0003ie-1E by authid <merlins.org> with srv_auth_plain; Wed, 08 Jul 2020 10:41:11 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1jtE4E-0004eu-Nl; Wed, 08 Jul 2020 10:41:10 -0700
Date:   Wed, 8 Jul 2020 10:41:10 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200708174110.GU30660@merlins.org>
References: <20200707035530.GP30660@merlins.org>
 <20200708034407.GE10769@hungrycats.org>
 <20200708041041.GN1552@merlins.org>
 <20200708054905.GA8346@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708054905.GA8346@hungrycats.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 08, 2020 at 01:49:05AM -0400, Zygo Blaxell wrote:
> > Sorry, PPL?
> 
> Partial Parity Log.  It can be enabled by mdadm --grow.  It's a mdadm
> consistency policy, like the journal, but uses reserved metadata space
> instead of a separate device.
 
looks like it's incompatible with --bitmap which I was already using.
I'm not sure if --grow was possible to convert from one to another, so I
made a new one, and now I have a 4 day wait for the initial scan
(external array with Sata PMP, those are slow unfortunately)

md6 : active raid5 sdx1[5] sdw1[3] sdv1[2] sdu1[1] sdq1[0]
      23441547264 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/4] [UUUU_]
      [>....................]  recovery =  0.0% (2920544/5860386816) finish=4835.4min speed=20189K/sec

Could you confirm that what I did here is ok?

gargamel:~# mdadm --create --verbose /dev/md6 --level=5 --consistency-policy=ppl --raid-devices=5 /dev/sd[quvwx]1
mdadm: layout defaults to left-symmetric
mdadm: layout defaults to left-symmetric
mdadm: chunk size defaults to 512K
mdadm: /dev/sdq1 appears to be part of a raid array:
       level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
mdadm: /dev/sdu1 appears to be part of a raid array:
       level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
mdadm: /dev/sdv1 appears to be part of a raid array:
       level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
mdadm: /dev/sdw1 appears to be part of a raid array:
       level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
mdadm: /dev/sdx1 appears to be part of a raid array:
       level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
mdadm: size set to 5860386816K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md6 started.

gargamel:~# make-bcache -B /dev/md6
UUID:                   eb898c09-debd-4e86-972f-aecdb59670e2
Set UUID:               e14408a3-8e25-414d-ba4a-a8a7a0d7bdc9
version:                1
block_size:             1
data_offset:            16

gargamel:~# cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64 /dev/bcache4

gargamel:~# cryptsetup luksOpen /dev/bcache4 dshelf6
Enter passphrase for /dev/bcache4:

gargamel:~# /sbin/mkfs.btrfs -L DS6 -O extref -m dup /dev/mapper/dshelf6 


> > wait, if a disk fails, at worst I have a stripe that's half written and
> > hopefully btrfs fails, goes read only and the transaction does not go
> > through, so nothing happens except loss of the last written data?
> 
> If the array is degraded, and stripe is partially updated, then there is
> a crash or power failure, parity will be out of sync with data blocks
> in the stripe, so the missing disk's data cannot be generated from parity.
 
I thought --bitmap would know this and know to discard the last blocks
partiailly written. I guess not?

Either way, it seems that losing just a few blocks in the "wrong" place
is enough to lose most of a btrfs FS. That's disappointing, I thought it
was a bit more fault proof than that.

> > I don't have an external journal because this is an external disk array
> > I can move between machines. Would you suggest I do something else?
> 
> Enable PPL on mdadm, or use btrfs raid5 data + raid1 metadata (it's
> barely usable and some stuff doesn't work properly, but it can run
> a backup server, replace a failed disk, and usually self-repair disk
> corruption too).
 
it's been a while since I've used btrfs raid5, it must have improved
since I last did, but I haven't read that it's become production quality
yet :)

Thanks again for your very helpful answers.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
