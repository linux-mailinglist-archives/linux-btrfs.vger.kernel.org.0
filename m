Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1C132EA5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 19:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgAGSpB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 13:45:01 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40903 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGSpB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 13:45:01 -0500
Received: by mail-wm1-f42.google.com with SMTP id t14so622760wmi.5
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcPoKdHCG8dItQpD90eHEy8k83Mf7B48j2uZuyR50xE=;
        b=Dz6QfAHp+oUFa+IgHqJR8wpalZ6WrSKDCfyxa1+mUABOPfr9ydr8FtNRc0hPXX+mgo
         L117xkLypLjOuL337IlE5RqWFEVHfdu5GZl7UAVvb9BlBcAf12UM7gryxi3WlZ0lVqK/
         Z5+KxdKjyB4O4Rql9oF4JF0nJAuolYBHvVKslCleOH5DOMq54gyNoJIghdtZJw6m/L82
         Mskahjv/je3d7SbIV6vU+WgXm9Gj2gmv8P5mmajwsoy6nw7XN3WcDnSN4qQmalFLscYD
         QJIxnKZewDRRQLdb8h1GqYbxoJoIFnx09GN96MNS1GEvApMViiMvkpT93Nx4FH/aXw8r
         zU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcPoKdHCG8dItQpD90eHEy8k83Mf7B48j2uZuyR50xE=;
        b=sigY0xLKUSlDmSjBH9by6ZqbDx0y3hdZbadIC4Qto+xFGml4N1Za5mqLUKUVeNrevC
         Pus8uGMfajAu2G7H31sdKFIbEl7gVFJx1800iIyGY86VjPzdVDtG/nzgYEy5/M8JdKg2
         MrUf8jLDSSEOfXeT+smoeYPcnTIodLD+kCvphUvovVHT4/A/Pfawt1zfLjCEQIHJqJsz
         iOdkcitWrb/aoTfeOB9rntms2y1hFTrSedLxHitaUl7UFn27ch7NX6UI7zXh1OFRied6
         K3SSZPSQ2BDNrwJfCx4Zrh3eaxkwiBn/cLtg8MlMD5mQY9r5tu46z+gmRUW1vuBFux0C
         Lr8Q==
X-Gm-Message-State: APjAAAV7zkUDd5PjsAQI/WICe+6V1IGskBUz8dAhvi1FBl/GAztiz7Bk
        d63w6ECzMpIQGdh7mWJiO3ruRj6rb3iGlhXayNvY9eOMc38=
X-Google-Smtp-Source: APXvYqyAk5Ee95fUrfXk9ECi4aeCbuPsJMQFagCmqcv0i7X6Lj2muASopPHOelUomrlQINhdgcFJVPxewhQEKSzReug=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr440291wmi.101.1578422699049;
 Tue, 07 Jan 2020 10:44:59 -0800 (PST)
MIME-Version: 1.0
References: <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl> <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl> <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org> <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl> <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
 <20200104053843.GK13306@hungrycats.org>
In-Reply-To: <20200104053843.GK13306@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Jan 2020 11:44:43 -0700
Message-ID: <CAJCQCtTvTbr9Civ5DLhTPRsMZ2qK2=YWFLB3JMSRRzZS9v-iNA@mail.gmail.com>
Subject: write amplification, was: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 3, 2020 at 10:38 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Thu, Jan 02, 2020 at 04:22:37PM -0700, Chris Murphy wrote:

> > I've seen with 16KiB leaf size, often small files that could be
> > inlined, are instead put into a data block group, taking up a minimum
> > 4KiB block size (on x64_64 anyway). I'm not sure why, but I suspect
> > there just isn't enough room in that leaf to always use inline
> > extents, and yet there is enough room to just reference it as a data
> > block group extent. When using a larger node size, a larger percentage
> > of small files ended up using inline extents. I'd expect this to be
> > quite a bit more efficient, because it eliminates a time expensive (on
> > HDD anyway) seek.
>
> Putting a lot of inline file data into metadata pages makes them less
> dense, which is either good or bad depending on which bottleneck you're
> currently hitting.  If you have snapshots there is an up-to-300x metadata
> write amplification penalty to update extent item references every time
> a shared metadata page is unshared.  Inline extents reduce the write
> amplification.  On the other hand, if you are doing a lot of 'find'-style
> tree sweeps, then inline extents will reduce their efficiency because more
> pages will have to be read to scan the same number of dirents and inodes.

Egads! Soo... total tangent. I'll change the subject.

I have had multiple flash drive failures while using Btrfs: all
Samsung, several SD Cards, and so far two USB sticks. They all fail in
the essentially the same way, the media itself becomes read only. USB:
writes succeed but they do not persist. Write data to the media, and
there is no error. Read that same sector back, old data is there. SD
Card: writes fail with a call trace and diagnostic info unique to the
sd card kernel code, and everything just goes belly up. This happens
inside of 6 months of rather casual use as rootfs. And BTW Samsung
always replaces the media under warranty without complaint.

It's not a scientific sample. Could be the host device, which is the
same in each case. Could be a bug in the firmware. I have nothing to
go on really.

But I wonder if this is due to write amplification that's just not
anticipated by the manufacturers? Is there any way to test for this or
estimate the amount of amplification? This class of media doesn't
report LBA's written, so I'm at quite a lack of useful information to
know what the cause is. The relevance here though is, I really like
the idea of Btrfs used as a rootfs for things like IoT because of
compression, ostensibly there are ssd optimizations, and always on
checksumming to catch what often can be questionable media: like USB
sticks, SD Cards, eMMC, etc. But not if the write amplication has a
good chance of killing people's hardware (I have no proof of this but
now I wonder, as I read your email).

I'm aware of write amplification, I just didn't realize it could be
this massive. It's is 300x just by having snapshots at all? Or does it
get worse with each additional snapshot? And is it multiplicative or
exponentially worse?

In the most prolific snapshotting case, I had two subvolumes, each
with 20 snapshots (at most). I used default ssd mount option for the
sdcards, most recently ssd_spread with the usb sticks. And now nossd
with the most recent USB stick I just started to use.

-- 
Chris Murphy
