Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5DBF5AD4
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 23:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfKHWV7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 8 Nov 2019 17:21:59 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49202 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHWV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 17:21:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F1EC1608325B;
        Fri,  8 Nov 2019 23:21:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zWhUttuOm15m; Fri,  8 Nov 2019 23:21:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 98A0C6083279;
        Fri,  8 Nov 2019 23:21:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gfl3dpalRVCY; Fri,  8 Nov 2019 23:21:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7ABC8608325B;
        Fri,  8 Nov 2019 23:21:56 +0100 (CET)
Date:   Fri, 8 Nov 2019 23:21:56 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at>
In-Reply-To: <20191108220927.GR22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold> <20191108220927.GR22121@hungrycats.org>
Subject: Re: Decoding "unable to fixup (regular)" errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: Decoding "unable to fixup (regular)" errors
Thread-Index: q0XT3yBeEKha7ZKsoWEzCEo8WnuheQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

----- Ursprüngliche Mail -----
> btrfs found corrupted data on md1.  You appear to be using btrfs
> -dsingle on a single mdadm raid1 device, so no recovery is possible
> ("unable to fixup").
> 
>> The system has ECC memory with md1 being a RAID1 which passes all health checks.
> 
> mdadm doesn't have any way to repair data corruption--it can find
> differences, but it cannot identify which version of the data is correct.
> If one of your drives is corrupting data without reporting IO errors,
> mdadm will simply copy the corruption to the other drive.  If one
> drive is failing by intermittently injecting corrupted bits into reads
> (e.g. because of a failure in the RAM on the drive control board),
> this behavior may not show up in mdadm health checks.

Well, this is not cheap hardware...
Possible, but not very likely IMHO

>> I tried to find the inodes behind the erroneous addresses without success.
>> e.g.
>> $ btrfs inspect-internal logical-resolve -v -P 593483341824 /
>> ioctl ret=0, total_size=4096, bytes_left=4080, bytes_missing=0, cnt=0, missed=0
>> $ echo $?
>> 1
> 
> That usually means the file is deleted, or the specific blocks referenced
> have been overwritten (i.e. there are no references to the given block in
> any existing file, but a reference to the extent containing the block
> still exists).  Although it's not possible to reach those blocks by
> reading a file, a scrub or balance will still hit the corrupted blocks.
> 
> You can try adding or subtracting multiples of 4096 to the block number
> to see if you get a hint about which inodes reference this extent.
> The first block found in either direction should be a reference to the
> same extent, though there's no easy way (other than dumping the extent
> tree with 'btrfs ins dump-tree -t 2' and searching for the extent record
> containing the block number) to figure out which.  Extents can be up to
> 128MB long, i.e. 32768 blocks.

Thanks for the hint!

> Or modify 'btrfs ins log' to use LOGICAL_INO_V2 and the IGNORE_OFFSETS
> flag.
> 
>> My kernel is 4.12.14-lp150.12.64-default (OpenSUSE 15.0), so not super recent
>> but AFAICT btrfs should be sane
>> there. :-)
> 
> I don't know of specific problems with csums in 4.12, but I'd upgrade that
> for a dozen other reasons anyway.  One of those is that LOGICAL_INO_V2
> was merged in 4.15.
> 
>> What could cause the errors and how to dig further?
> 
> Probably a silent data corruption on one of the underlying disks.
> If you convert this mdadm raid1 to btrfs raid1, btrfs will tell you
> which disk the errors are coming from while also correcting them.

Hmm, I don't really buy this reasoning. Like I said, this is not
cheap/consumer hardware.

Thanks,
//richard
