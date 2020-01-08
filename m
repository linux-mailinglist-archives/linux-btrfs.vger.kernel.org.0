Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F145813394A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 03:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAHCyl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 21:54:41 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37187 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCyl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 21:54:41 -0500
Received: by mail-wr1-f51.google.com with SMTP id w15so1777756wru.4
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 18:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XeTV7cWBoamZfu7CeehVbcjbu+8N1lDGQTbcvxEo4t4=;
        b=n7KrcIIIWixG2KdVuxSotLg1AxSGzGuq0QqLsvdaKRvKtyT+t6BaPYfa0d0+ahVN2S
         u/jyN6t6Bspd5q3J+RXlr1VQo2tGVwr4zgC1l9tIC4p4c9uCD2n2Ao/64cfn4LScttJM
         uh8OYHfteaktvtz+EwBsos2B628t5W5LeR2tqLcmAPqPKzSUKDUsTYB5QZIFQJx28tgH
         BS5lm9iZKYeHHMVZhQQe+EKU0iekUSTw6XtmSjeC4bTKwLBaEspc2txcBX/CptoqgBdK
         O3tP8hQxLH8uyZrueDppSKlfaOpoxPhCJhLaW8tV/B/I+ICfMO3N7TWD2yxor6mxYspP
         vJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XeTV7cWBoamZfu7CeehVbcjbu+8N1lDGQTbcvxEo4t4=;
        b=ZHmCEGpesIaEBRZyPMIqIAl0HPL3ji80pypArQjVAL2NzMgpDMCssDDIN54Z9aHw/l
         YY1PmuP0YzpC2qI/GUfQxp4fDqi6crvnvMTCrLYR12ev+CQa7rwVCq0k9I4kvrpTlekB
         pLpIYsFx/gwWGOJRGA/8iT3+jdgwKe2EcJJMZvlIZp2nYJSZfdprPWCrO+jabeyyxaCI
         2pmnNMgT889EDrrl8M00zTbMF3YJR6imPCVN6buv3vh7Ha8Lp2dQBLWkDx3R1p/KwOCE
         G8XtGbo7zDFoiIeKxJgjCQr8J6ou4slP408gD+aGSVq2QT2jC0phsul2dSmqRTvJtYjm
         cHUg==
X-Gm-Message-State: APjAAAVXYWdGDQWSapSxMs2pTmAI92YnA8i1K/YFZndqrnSy1uz0RBLs
        1aeCXSgooqhBNodp4ik57BqLb3UTEPpcmkv82ekPFu0rqKk=
X-Google-Smtp-Source: APXvYqwHGf83duD4XcwZ2NfLBmsw6eH6gcA9Xtl2WR5o86Lbp5DU8FBKW9a3UVuOc0J0ahfMuUWRn+3E+d908mCeUDc=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr2021317wrm.262.1578452079036;
 Tue, 07 Jan 2020 18:54:39 -0800 (PST)
MIME-Version: 1.0
References: <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org> <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl> <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
 <20200104053843.GK13306@hungrycats.org> <CAJCQCtTvTbr9Civ5DLhTPRsMZ2qK2=YWFLB3JMSRRzZS9v-iNA@mail.gmail.com>
 <20200107233237.GC24056@hungrycats.org> <CAJCQCtRUtdBe7gBeRwMyWg40if8wJKgCvCF--yWTXORXDiDJJQ@mail.gmail.com>
 <20200108014102.GD24056@hungrycats.org>
In-Reply-To: <20200108014102.GD24056@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Jan 2020 19:54:22 -0700
Message-ID: <CAJCQCtSg9Fkdh=T+LBqUhvVGj-Ci7ob7WNOD=AsZQOx4Ju+e0w@mail.gmail.com>
Subject: Re: write amplification, was: very slow "btrfs dev delete" 3x6Tb, 7Tb
 of data
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 7, 2020 at 6:41 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> Consumer SD cards have been ruthlessly optimized for decades, mostly
> for cost.  It will take a while for the consumer-facing part of the
> industry to dig itself out of that hole.  In the meantime, we can expect
> silent data corruption, bad wear leveling, and power failure corruption
> to be part of the default feature set.

I cackled out loud at this.


> I run btrfs with dup data and dup metadata on the Pis, with minimized
> write workloads (i.e. I turn off all the local log files, sending the
> data to other machines or putting it on tmpfs with periodic uploads,
> and I use compression to reduce write volume).  I don't use snapshots on
> these devices--they do get backups, but they are fine with plain rsync,
> given the minimized write workloads.  I haven't tried changing filesystem
> parameters like node size.  Dup data doesn't help the SD card last any
> longer, but it does keep the device operating long enough to build and
> deploy a new SD card.

I use zstd:1, space_cache v2, and dsingle mdup. Curiously I've not
seen any read errors on these. They just stop writing. I can mount and
read from them fine, just writes file (silently on the USB sticks,
kinda hilarious: yep, yep, i'm writing, no problem, yep, oh you want
back what you just wrote, yeah no you get yesterday's data).


> Samsung is making SD cards with 10-year warranties and a 300 TBW rating
> (equivalent, it is specified in units of "hours of HD video").  They are
> USD$25 for 128GB, 100MB/s read 90MB/s write.  No idea what they're like
> in the field, I start test deployments next week...

Yeah the Samsung SD cards I have also are 10 year, but I have no idea
what the TBW is and they don't report writes. EVO Plus, U3, is
supposed to do 30M/s writes but no matter the file system I get 20MB/s
out of it. I get a statistically significant extra ~350K/s with Btrfs.
Reads are around 80-90M/s. Of course effective reads/writes is higher
with compression. USB sticks I think are a few years warranty.


-- 
Chris Murphy
