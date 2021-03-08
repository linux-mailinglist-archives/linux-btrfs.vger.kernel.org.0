Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53A330588
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 02:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhCHBD6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 20:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhCHBD5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 20:03:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177DC06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 17:03:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so9646643wrr.10
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Mar 2021 17:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqEdbxiOingkx9AwdQIuhy2x4SLg4mkHlaNx9zECKxA=;
        b=goxOfTz4W0SP7iSMFhTmc1K1tRDpSyegiYbSd6Z1N2i/+ZX8d/3mP+0q2+LS2+P/h7
         z4rJs99lDIS3wC9I/bphePx2JvlFIr7RfcFtovhNA8dhelqziS3WLBX/HvvU1y9Cbzyo
         ptAjIqP9kihAAEP1xjJcmTxhDXgZvLFRaKPFwi33HPIQc0c6ZLXfBiDE6XsBCCUnYUxf
         55vsFJ3XPQG7rGAlD2ix1ceRpipf2/bAfFl7dj/ydO7bys7+AXpN2tK+iN19TwG4Xbbl
         pTn+mIERw4tUINHplP5TEMLz82NTUYnZYVf0w2avQVnl6gmTYt0IFuwoYSba14MJqlLi
         dl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqEdbxiOingkx9AwdQIuhy2x4SLg4mkHlaNx9zECKxA=;
        b=WGlnck0Mpa6xbOIAORTE25/ZUsf0XZFO+EXLskeWt0SA6nv2THnaztSehl5BXvPhBI
         DKogy3ZE5xD79N7bi+hLpctwY6zss7AW8vh6MlZytWLaxB+ZbCDsfpbZRRsAPCaRUCpu
         AcScfVI0A1OQ0V6BmuGZ2QYG+F2T6rEQsnu6mV3b3UEALLKJUU0ISBX8DxA8fmIHn7Gm
         xsBf/Kki07OK2pieqS6iQY0iym4jvEWIX85X/7OJ1rw0Iz6fP6DsdKOOLspYOPDszJP+
         z0A5eSD0vui+kSN8X2bB6z5qzGq0PrAQHnWk44Jszk6P7YWyliY1f1o2/DW1SfIFFKUL
         7PLw==
X-Gm-Message-State: AOAM530B2uh3sRB/GXNRbValZQNGu8CLBDVUG/uQpLvaGHD+kCWtFf9Q
        BYvoLRle7M259YE/EaVIbw7h+X14kqzO/Fag6f+uFlu2p8ZsMyRg
X-Google-Smtp-Source: ABdhPJwmmrmsnXDxgNWMupgRylZG3mZTsqpE6WZE6+s3e4w8IDY5ZLkUSUhfdJTNdKK7nDYCMxKRoEHffPVte4cvDwk=
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr20325006wra.42.1615165435950;
 Sun, 07 Mar 2021 17:03:55 -0800 (PST)
MIME-Version: 1.0
References: <YEVYbMdXdPzklSVc@bulldog.preining.info>
In-Reply-To: <YEVYbMdXdPzklSVc@bulldog.preining.info>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 7 Mar 2021 18:03:40 -0700
Message-ID: <CAJCQCtSZGGVamOUGRFzPXBejTW9Hx-2EkYUSCXdN6qEY3snW2w@mail.gmail.com>
Subject: Re: btrfs fails to mount on kernel 5.11.4 but works on 5.10.19
To:     Norbert Preining <norbert@preining.info>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 7, 2021 at 4:28 PM Norbert Preining <norbert@preining.info> wrote:
>
> Dear all
>
> (please cc)
>
> not sure this is the right mailing list, but I cannot boot into 5.11.4
> it gives me
>         devid 9 uui .....
>         failed to read the system array: -2
>         open_ctree failed
> (only partial, typed in from photo)

Post the photo? This is a generic message and we need to see more
information. Is devid 9 missing?

Does the initrd on this system contain?

/usr/lib/udev/rules.d/64-btrfs.rules

That will wait until all devices are available before attempting to
mount. If it's not in the initrd, it won't wait and it's prone to
races, and you can often get mount failures because not all devices
are ready to be mounted.







>
> OTOH, 5.10.19 boots without a hinch
> $ btrfs fi show /
> Label: none  uuid: 911600cb-bd76-4299-9445-666382e8ad20
>         Total devices 8 FS bytes used 3.28TiB
>         devid    1 size 899.01GiB used 670.00GiB path /dev/sdb3
>         devid    2 size 489.05GiB used 271.00GiB path /dev/sdd
>         devid    3 size 1.82TiB used 1.58TiB path /dev/sde1
>         devid    4 size 931.51GiB used 708.00GiB path /dev/sdf1
>         devid    5 size 1.82TiB used 1.58TiB path /dev/sdc1
>         devid    7 size 931.51GiB used 675.00GiB path /dev/nvme2n1p1
>         devid    8 size 931.51GiB used 680.03GiB path /dev/nvme1n1p1
>         devid    9 size 931.51GiB used 678.03GiB path /dev/nvme0n1p1

This seems to be a somewhat risky setup or at least highly performance
variable. Any single device that fails will result in boot failure.


-- 
Chris Murphy
