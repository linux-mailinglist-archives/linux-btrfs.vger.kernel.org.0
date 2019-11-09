Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7356CF5E53
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 11:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfKIKAq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 9 Nov 2019 05:00:46 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:56584 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKIKAq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Nov 2019 05:00:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7D6416083247;
        Sat,  9 Nov 2019 11:00:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lg13rXaa8YgE; Sat,  9 Nov 2019 11:00:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D0461608325B;
        Sat,  9 Nov 2019 11:00:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2Dvh_lCnHHHt; Sat,  9 Nov 2019 11:00:42 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id AE64A6083247;
        Sat,  9 Nov 2019 11:00:42 +0100 (CET)
Date:   Sat, 9 Nov 2019 11:00:42 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1389491920.79042.1573293642654.JavaMail.zimbra@nod.at>
In-Reply-To: <20191108233933.GU22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold> <20191108220927.GR22121@hungrycats.org> <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at> <20191108222557.GT22121@hungrycats.org> <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at> <20191108233933.GU22121@hungrycats.org>
Subject: Re: Decoding "unable to fixup (regular)" errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: Decoding "unable to fixup (regular)" errors
Thread-Index: pxZatMlU5PeGAUhQplS2h98257znpA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
> An: "richard" <richard@nod.at>
> CC: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Gesendet: Samstag, 9. November 2019 00:39:33
> Betreff: Re: Decoding "unable to fixup (regular)" errors

> On Fri, Nov 08, 2019 at 11:31:22PM +0100, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>> > Von: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
>> > An: "richard" <richard@nod.at>
>> > CC: "linux-btrfs" <linux-btrfs@vger.kernel.org>
>> > Gesendet: Freitag, 8. November 2019 23:25:57
>> > Betreff: Re: Decoding "unable to fixup (regular)" errors
>> 
>> > On Fri, Nov 08, 2019 at 11:21:56PM +0100, Richard Weinberger wrote:
>> >> ----- Ursprüngliche Mail -----
>> >> > btrfs found corrupted data on md1.  You appear to be using btrfs
>> >> > -dsingle on a single mdadm raid1 device, so no recovery is possible
>> >> > ("unable to fixup").
>> >> > 
>> >> >> The system has ECC memory with md1 being a RAID1 which passes all health checks.
>> >> > 
>> >> > mdadm doesn't have any way to repair data corruption--it can find
>> >> > differences, but it cannot identify which version of the data is correct.
>> >> > If one of your drives is corrupting data without reporting IO errors,
>> >> > mdadm will simply copy the corruption to the other drive.  If one
>> >> > drive is failing by intermittently injecting corrupted bits into reads
>> >> > (e.g. because of a failure in the RAM on the drive control board),
>> >> > this behavior may not show up in mdadm health checks.
>> >> 
>> >> Well, this is not cheap hardware...
>> >> Possible, but not very likely IMHO
>> > 
>> > Even the disks?  We see RAM failures in disk drive embedded boards from
>> > time to time.
>> 
>> Yes. Enterprise-Storage RAID-Edition disks (sorry for the marketing buzzwords).
> 
> Can you share the model numbers and firmware revisions?  There are a
> lot of enterprise RE disks.  Not all of them work.

Yes, will answer in a second mail. I found two more systems with such
errors.
 
> At least one vendor has the same firmware in their enterprise RE disks
> as in their consumer drives, and it's unusually bad.  Apart from the
> identical firmware revision string, the consumer and RE disks have
> indistinguishable behavior in our failure mode testing, e.g.  they both
> have write caching bugs on power failures, they both silently corrupt
> a few blocks of data once or twice a drive-year...
> 
>> Even if one disk is silently corrupting data, having the bad block copied to
>> the second disk is even more less likely to happen.
>> And I run the RAID-Health check often.
> 
> Your setup is not able to detect this kind of failure very well.
> We've had problems with mdadm health-check failing to report errors
> even in deliberate data corruption tests.  If a resync is triggered,
> all data on one drive is blindly copied to the other.  You also have
> nothing checking for integrity failures between mdadm health checks
> (other than btrfs csum failures when the corruption propagates to the
> filesystem layer, as shown above in your log).

I'm aware of this.

> We do a regression test where we corrupt every block on one disk in
> a btrfs raid1 (even the superblocks) and check to ensure they are all
> correctly reported and repaired without interrupting applications running
> on the filesystem.  btrfs has a separate csum so it knows which version
> of the block is wrong, and it checks on every read so it will detect
> and report errors that occur between scrubs.
> 
> The most striking thing about the description of your setup is that you
> have ECC RAM and you have a scrub regime to detect errors...but you have
> both a huge gap in error detection coverage and a mechanism to propagate
> errors across what is supposed to be a fault isolation boundary because
> you're using mdadm raid1 instead of btrfs raid1.  If one of your disks
> goes bad, not only will it break your filesystem, but you won't know
> which disk you need to replace.

I didn't claim that my setup is perfect. What strikes me a little is that
the only possible explanation from your side are super corner cases like
silent data corruption within an enterprise disk, followed by silent failure
of my RAID1, etc..

I fully agree that such things *can* happen but it is not the most likely
kind of failure.
All devices are being checked by SMART. Sure, SMART could also be lying to me, but...

Thanks,
//richard
