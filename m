Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC18339C7D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Mar 2021 08:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhCMHAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Mar 2021 02:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMG7e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Mar 2021 01:59:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497FC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 22:59:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a18so5946594wrc.13
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 22:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0OONeLcLFUs0on6bSK33cR2DqAPXKa+si5CAVf/bOo=;
        b=qWTsEUbLW7soeQPmy4GseP4SaufMIk0fbKK31vBCKgWmi/zyQAcPbhpIcpkI3cQQ0X
         RFg18xtmm4LOPRp16JMyDxQA4z8Cw883XT0hguDFW9ix3O6X/ju0c40dS6pra/+7Zps6
         mMDTVTUfvFhVoMimMFnA+KuYUzZdG/g+CAiQXzGjFXCScg5ySae7jsEVW2MoNsBavYWT
         CtFuQynhdNhtIeG4+Y+VJghtkxx32vsLEFvRIQqZBKEqiekFhqR1cWCe/waa/eIPM5r+
         2KbIS0DDl9Al5MVVVJ7QSdaHCfPsB1GsEk2XaxmHrL7VEsx9LKf1V/KTG5LdV71XI8He
         J1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0OONeLcLFUs0on6bSK33cR2DqAPXKa+si5CAVf/bOo=;
        b=iTOFv16xKcc8hmA4K6PW1QOTGPpoXVnVTAr1vwU9LxI3gr9gz+ZOwEOtJbo4wj5oYG
         vYW0VQ9dKNjbBpko2+jT0CC2IJ+eLSzz1a9XeGXqAOV61BOnkngS9SQG9BXyIdNYBIMV
         6lTPCqbv4reBoSne/GNH9SVuLJmH/4rhfY4t4qum15bgLvML07AhedPFN4IfbmjflKyX
         0Pd78Q+TEKJ/PGECV/sbxy4YWXueVouNi6xXV0RRF5PiU2VS867Lam5ScJ0nWosiDD2V
         +Jq3COvWcBKYRFbkocXQ2wwJn64W0d5qTZdlDL/IKhtLwyMVLcyADd4oBxMXHIJkQGuf
         A2hQ==
X-Gm-Message-State: AOAM533mpmyX0Q+uFALCjN//LPIRTiiku1abpPsgHZB12YCN7ROc6KwJ
        VB+xJ/qgkw3qgyeHu0vBTrTvxGWBdiAbAgAj1OI49HZPLjsyXg/I
X-Google-Smtp-Source: ABdhPJx/bl+qZZmu9sK1gKwKx87cndLvl/ur+fEbD0ti1uuP9ky/9wplK3ChqvBHcdZvqxSbCy+BvZOhzb2+gGRqLxw=
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr17621532wrx.236.1615618772858;
 Fri, 12 Mar 2021 22:59:32 -0800 (PST)
MIME-Version: 1.0
References: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
In-Reply-To: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 12 Mar 2021 23:59:16 -0700
Message-ID: <CAJCQCtStWN30akGRByjA2y=AaTLRXeeEmc4MiNaLgVEPRp=J7g@mail.gmail.com>
Subject: Re: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd
 2719033, flush 0, corrupt 6, gen 0
To:     Thomas <74cmonty@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[    4.365859] usb 8-1: device not accepting address 5, error -71
[    4.365920] usb usb8-port1: unable to enumerate USB device
[    4.433539] BTRFS info (device sda1): bdev /dev/sdb1 errs: wr
2701995, rd 2718862, flush 0, corrupt 6, gen 0

/dev/sdb is dropping a lot of reads and writes. Is /dev/sdb in a
SATA-USB enclosure of some kind?


[   16.914959] blk_update_request: I/O error, dev fd0, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   16.914963] floppy: error 10 while reading block 0

Curious but I don't think it's related.


[   20.685589] attempt to access beyond end of device
               sdb1: rw=524288, want=496544128, limit=496091703
[   20.685798] attempt to access beyond end of device
               sdb1: rw=2049, want=496544128, limit=496091703
[   20.685804] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr
2701996, rd 2718862, flush 0, corrupt 6, gen 0

Something is definitely confused but I'm not sure what or why.

$ sudo btrfs insp dump-s /dev/sdb1 | grep dev_item.total_bytes

Compare that value with (Sectors * 512) from:

$ sudo fdisk -l /dev/sdb

The fdisk number of bytes should be the same as or more than the btrfs bytes.

$ sudo smartctl -x /dev/sdb

That might require installing the smartmontools package.

--
Chris Murphy


--
Chris Murphy
