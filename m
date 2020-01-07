Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2461337BD
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 00:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgAGXxb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 18:53:31 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38540 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgAGXxb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 18:53:31 -0500
Received: by mail-wr1-f47.google.com with SMTP id y17so1501727wrh.5
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 15:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUiqwmsKl7RYGZ7l4+5yBOjiRbyyj3AmzKcSPRaIXI8=;
        b=vF0zDOQeTL2wIFYcLKt89sF6W9Cmb/gsA1Hej6XLzMRV1BUVRzNCxY9z7Y97CyjAsZ
         miOWNWxZorw+GW+zmpaZfk1RBm1glpCRlSlT6EspJu7C/OyVWI0cuCgzsruSweJXjp4O
         qrS4QNuMPclYSiRwKIPHASYQ+f235hhAoPOeVkGac6hqZqqF8cLvoZZGuBjn/Z/PPS4i
         kx+Yg7DKDb0cUQKCc/V3bhu/jlzjpULHQf8HK4FCTiWn9Fu6fWcq/VGnRNkKw/tl4MVX
         v4Pd8iK/ax0K5c8NQQ8BUjzeokMJ+ZPJcg7wpzoRsQvihDJtR6so6gWCZ4hBbMWGwu5g
         pYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUiqwmsKl7RYGZ7l4+5yBOjiRbyyj3AmzKcSPRaIXI8=;
        b=tE6EM16eVXsIj2XdpBck0g+oZR4p4lxqabJBTTW9bm5oPdYAzB8J9CbnUV6hDdwIQc
         h3HJmPqsNvy5+unuqrQa2OFkt1Z0M1rOXWfmM7jXFkEdWsGQwXlqtpb3CWIHHOAKBesx
         kGvdSMIQ7VySXWX1AmQR4O7AlAAj3gl6Y7QZctLurX/el8nOirpjFheZTKftt0EkhdAX
         XLbsmzkPI6hCJBYh9pOxnNiuPp4RR9R0UtE0lyNdvtdI0H6YLr6JMBAg15NvO/7immZQ
         +cCJr4JDBXK4aw57spIXlWnLVdkJBe7Nj/aKvlihxaiVSCvJFclvaEhB+ziFkKlSH/Fg
         SzHA==
X-Gm-Message-State: APjAAAXC+Otzf8J77m/UB9M0PAtiig/ReZvaoaHyA6WhjRzQveS7icHy
        ELKGxILa9hQXs2aF54qSPR/lQvJI4/BPFJ5Kf4wbNw==
X-Google-Smtp-Source: APXvYqxSc56C4g3qk3/71LZXE+Y9YLgmU+fMEKeKlTTJoI9j8fgDSte6ck0PeMSwFwgbaxxOKhvpyGrh1KOzSjlRIaQ=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr1492348wre.390.1578441209853;
 Tue, 07 Jan 2020 15:53:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl> <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org> <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl> <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
 <20200104053843.GK13306@hungrycats.org> <CAJCQCtTvTbr9Civ5DLhTPRsMZ2qK2=YWFLB3JMSRRzZS9v-iNA@mail.gmail.com>
 <20200107233237.GC24056@hungrycats.org>
In-Reply-To: <20200107233237.GC24056@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Jan 2020 16:53:13 -0700
Message-ID: <CAJCQCtRUtdBe7gBeRwMyWg40if8wJKgCvCF--yWTXORXDiDJJQ@mail.gmail.com>
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

On Tue, Jan 7, 2020 at 4:32 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> It seems to be normal behavior for USB sticks and SD cards.  I've also
> had USB sticks degrade (bit errors) simply from sitting unused on a shelf
> for six months.  Some low-end SATA SSDs (like $20/TB drives from Amazon)
> are giant USB sticks with a SATA interface, and will fail the same way.
>
> SD card vendors are starting to notice, and there are now SD card options
> with higher endurance ratings.  Still "putting this card in a dashcam
> voids the warranty" in most cases.
>
> ext2 and msdos both make USB sticks last longer, but they have obvious
> other problems.  From my fleet of raspberry pis, I find that SD cards
> last longer on btrfs than ext4 with comparable write loads, but they
> are still both lead very short lives, and the biggest life expectancy
> improvement (up to a couple of years) comes from eliminating local
> writes entirely.

It's long been an accepted fact in professional photography circles
that CF/SD card corruption is due to crappy firmware in cameras. Ergo,
format (FAT32/exFAT) only with that camera's firmware, don't delete
files using the camera's interface, suck off all the files (back them
up too) then format the card in that particular camera, etc.

I've wondered for a while now, if all of that was flash manufacturer
buck passing.


>
> > In the most prolific snapshotting case, I had two subvolumes, each
> > with 20 snapshots (at most). I used default ssd mount option for the
> > sdcards, most recently ssd_spread with the usb sticks. And now nossd
> > with the most recent USB stick I just started to use.
>
> The number of snapshots doesn't really matter:  you get the up-to-300x
> write multiple from writing to a subvol that has shared metadata pages,
> which happens when you have just one snapshot.  It doesn't matter if
> you have 1 snapshot or 10000 (at least, not for _this_ reason).

Gotcha. So I wonder if the cheap consumer USB/SD card use case,
Raspberry Pi and such, rootfs or general purpose use, should use a
4KiB node instead of default 16KiB? I read on HN someone using much
much more expensive industrial SD cards and this problem  has entirely
vanished for them (Pi use case). I've looked around and they are a lot
smaller and more expensive but for a Pi rootfs it's pretty sane
really, USD$56 for a 4G card that won't die every 6 months? They are
slower too. *shrug*


-- 
Chris Murphy
