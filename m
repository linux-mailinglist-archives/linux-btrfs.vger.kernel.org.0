Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0FF5AE9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 23:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfKHWbZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 8 Nov 2019 17:31:25 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49374 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHWbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 17:31:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F14EF608325B;
        Fri,  8 Nov 2019 23:31:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZYzhx6KYWC5T; Fri,  8 Nov 2019 23:31:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 869936083247;
        Fri,  8 Nov 2019 23:31:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ugJMxzoWzmfO; Fri,  8 Nov 2019 23:31:22 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 703F062EBCAD;
        Fri,  8 Nov 2019 23:31:22 +0100 (CET)
Date:   Fri, 8 Nov 2019 23:31:22 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at>
In-Reply-To: <20191108222557.GT22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold> <20191108220927.GR22121@hungrycats.org> <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at> <20191108222557.GT22121@hungrycats.org>
Subject: Re: Decoding "unable to fixup (regular)" errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: Decoding "unable to fixup (regular)" errors
Thread-Index: 5dyL/1ARMN5KXUWchrZow1pgnfi70Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
> An: "richard" <richard@nod.at>
> CC: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Gesendet: Freitag, 8. November 2019 23:25:57
> Betreff: Re: Decoding "unable to fixup (regular)" errors

> On Fri, Nov 08, 2019 at 11:21:56PM +0100, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>> > btrfs found corrupted data on md1.  You appear to be using btrfs
>> > -dsingle on a single mdadm raid1 device, so no recovery is possible
>> > ("unable to fixup").
>> > 
>> >> The system has ECC memory with md1 being a RAID1 which passes all health checks.
>> > 
>> > mdadm doesn't have any way to repair data corruption--it can find
>> > differences, but it cannot identify which version of the data is correct.
>> > If one of your drives is corrupting data without reporting IO errors,
>> > mdadm will simply copy the corruption to the other drive.  If one
>> > drive is failing by intermittently injecting corrupted bits into reads
>> > (e.g. because of a failure in the RAM on the drive control board),
>> > this behavior may not show up in mdadm health checks.
>> 
>> Well, this is not cheap hardware...
>> Possible, but not very likely IMHO
> 
> Even the disks?  We see RAM failures in disk drive embedded boards from
> time to time.

Yes. Enterprise-Storage RAID-Edition disks (sorry for the marketing buzzwords).

Even if one disk is silently corrupting data, having the bad block copied to
the second disk is even more less likely to happen.
And I run the RAID-Health check often.

Thanks,
//richard
