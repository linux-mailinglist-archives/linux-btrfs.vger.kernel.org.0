Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20093AE108
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 00:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhFTW4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTW4C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 18:56:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8481C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 15:53:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y7so17371250wrh.7
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 15:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6+t6JI32h8FBP8VdKZSBSJ2ui+O3cEBx9++kn97Y7U=;
        b=1TcZC+ErarOyk874R3qFjJ7N4AHgctug0GIYBoQTy3l6IVrBYjYvIzZL9vWLTx4ZWH
         gK6P4NHOklUfBZYE3+R3hmEsohvGUTTwaH1kt4pRYRO2c+D8EKn4Nz4p7IVUJElVoFuW
         DJpZU4QEOdg1s8j2t6Fx6T4Gl5S0SI1pp41IugXaVLBdUTf8GMdmpLXUgHbTRNuoUCuT
         VrBsq5sOZISPGJ4+T30Dgq3+GBxXXdL7tqR3HsZys9Znlv8dfjpCAnG0IB+JLHofvzIk
         h7dQbwL8IXCUUA9Y+/DZpToMIcGUwVBPQ/KbmCkbdFKPhfO2N3p8zQYLqwlzdwC7yH5i
         pIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6+t6JI32h8FBP8VdKZSBSJ2ui+O3cEBx9++kn97Y7U=;
        b=Bf+jnl6XjWuhW57WC00kQAviP9MgJcTGi/Ah9MyUMSgYZzTfofiyVmTFsD/rT8kAki
         yYPfrgOg1qv2Iyfv6T72rq7WcCAxtTTQYUFjsoUN1kZW92qgOmRM0HS3wFmfo9HTndxh
         wCR8iPBCDAnZFkKmPRwMJIqgKbH2AY7GD6R0MSzT/8jAByzr/wOyTMsmHd0mgOnrQNvW
         fyjyy4bsVsEIRAzF2hNC+XWUyOen47WPhnkGTV0Bq5O1p73YmCTk6QyibWI3irs3rqB9
         D+orKSpH9IABVpPATtgWzqqC2YI7Rb93bLyTK+3qLHRibb03W+HrHwC4mXnONMBgDwGH
         Lsjg==
X-Gm-Message-State: AOAM533lknSjAwiRpd2ddOmpWpngxanzj5/IN4/R+ydllzW5JfaGmnLF
        yjFiR5c80L0aUvZVFSfdoJz4j8kvSWKGeNiyiCJl3A==
X-Google-Smtp-Source: ABdhPJy1uyjwPeY/SzTh2QAWsbfbf906iFywy5QjzGGYumCSyvqCaUCbjb2Uah00kqLlsLtCUcB4dt4G5UKK9ewUPsM=
X-Received: by 2002:a05:6000:1883:: with SMTP id a3mr25163205wri.65.1624229626398;
 Sun, 20 Jun 2021 15:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
 <CAJCQCtQVqPbwnQXjEECxO-YQVp5XV3cLip8izbTVUkPtOL7P2g@mail.gmail.com> <CAEEhgEv1D9XBCazAn+h1ZfPqGct9PcLpTTn0vtUNh9Yny3XAAg@mail.gmail.com>
In-Reply-To: <CAEEhgEv1D9XBCazAn+h1ZfPqGct9PcLpTTn0vtUNh9Yny3XAAg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Jun 2021 16:53:30 -0600
Message-ID: <CAJCQCtQUF9Sp=f3rrd5MMe4tLkDoh8GYFXSRTECxKqtRFwgUzw@mail.gmail.com>
Subject: Re: Recover from "couldn't read tree root"?
To:     Nathan Dehnel <ncdehnel@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 20, 2021 at 3:31 PM Nathan Dehnel <ncdehnel@gmail.com> wrote:
>
> >Was bcache in write back or write through mode?
> Writeback.

Ok that's bad in this configuration because it means all the writes go
to the SSD and could be there for minutes, hours, days, or longer.
That means it's even possible the current supers are only on the SSDs,
as well as other critical btrfs metadata.

My best guess now is to assume one of the drives is bad and spewing
garbage or zeros. And assemble the array degraded with just one SSD
drive, and see if you can mount. If not, then it's the other SSD you
need to assemble degraded. There's a way to set a drive manually as
faulty so it won't assemble; I also thought of using sysfs but on my
own system, /sys/block/nvme0n1/device/delete does not exist like it
does for SATA SSDs.

Next you have to wrestle with this dilemma. If you pick the bad SSD,
you don't want bcache flushing anything from it to your HDDs or it'll
just corrupt them, right? if you pick the good SSD, you actually do
want bcache to flush it all to the drives, so they're in a good state
and you can optionally decouple the SSD entirely so that you're left
with just the individual drives again.

I think you might want to use 'blockdev --setro' on all the block
devices, SSD and HDD, to prevent any changes. You might get some
complaints from bcache if it can't write to HDDs or even to the SSDs,
so that might look like you've picked the bad SSD. But the real test
is if you can mount the btrfs. Try that with 'mount -o
ro,nologreplay,usebackuproot' and if you can at least get that far and
do some basic navigation, that's probably the good SSD. If you still
get mount failure, it's probably the bad one.

If you get a successful ro mount, I'd take advantage of it and backup
anything important. Just get it out now. And then you can try it all
again with everything read write; but with the bad SSD still disabled
and md array assemble degraded with the good SSD; and see if you can
mount read-write again. You need to be read write at the block device
layer to get bcache to flush SSD state to the drives, which I think is
done by setting the mode to writethrough and then waiting until
bcache/state is clean. HDDs need to be writable but btrfs doesn't need
to be mounted for this.

The other possibility is that there some bad data on both SSDs, in
which case it fails and chances are the btrfs is toast.


-- 
Chris Murphy
