Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5939C41B6CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbhI1TBH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbhI1TBH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 15:01:07 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1A0C061745
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 11:59:27 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v10so33920858ybq.7
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohUEXRX8bI5E04MYftBrXPE717n4epVOAb5yqdni/qM=;
        b=A3hLye8s6PrQfi5BTrr1NRq4IBgtcR+rsFvcdeI/sSZZnp4pY4K4YnPWfl8oZHwBgz
         u4/7wtzjZ5fhbhp+K8F9Hk7sDheFDckLEvPVyP2faDFrDefBhCsvJqicepcrTFShHQa3
         tyQNEJYqWGbMA65KWw+jrb8onO+9swEgVD08NhuCmfICawOSsr75FdqbHO98QtV4TAis
         bChqTQbFROvfSOs/vUxpA/gnCW+ix5740Bh1Gsrpp8tLenJI+ztQlpJIUJ05tjM3eqXQ
         brYVYOACEKwsr2nOlZVmDVQmsilVbH2khazfU99HSRPRc2nhxwV/i8uaqIpp3ArJjVsH
         Eb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohUEXRX8bI5E04MYftBrXPE717n4epVOAb5yqdni/qM=;
        b=32RMn8Plbk/9dCn/2hptLo3/QNMIIZjfrsrUX4iMMn81EZF6XpTWf8aBovA0uP3qZz
         hoxNzoJPuPJau23XyxvYl/n9Zl4/XWp4IzE9rDvsj+eSomqKBX2n5o2p58aAMPwgHsVw
         tL7uPnSNY0PhU0vP9ntWrusRP2Xly9o9fTpFrMEComdpeoR8H3vckkTvNVUjq4Cf24mk
         cYGMJYsT6C3nv9CH6XnFUTTYfZI8q9SR4yLk5TJJmFxbsg0wW6Qilbdy/qCpRcyRA4Mk
         JAkmhfqfT3jNQzMQwW092wsq5MQ/r0/I1/8vqVumcX2AKRTjRSQj75vk/T8n/ehQsQRC
         18Zw==
X-Gm-Message-State: AOAM532i9rBzOhkhMTwkwHdSWnFAKJO8gTMLfMasQUm0IWu/ldsCgkV0
        S2X+gVh2hhc9ObL9dgvXrUUdf860VyReKJUA+e0INj7XRPMiBg==
X-Google-Smtp-Source: ABdhPJz6HtNNIrPcIuLWHYgGdBDRQCj2VcmG4L4GpntK1P6wPEmF11qY2fXn2IOoxA0t5Syf+/ZVIG4PBTo8viQefw8=
X-Received: by 2002:a25:abcc:: with SMTP id v70mr8544160ybi.277.1632855566780;
 Tue, 28 Sep 2021 11:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3VL5P7uAPAqvaRHv5gcoT5hdVqkSR5Nz+hTcb=FRmj9ZQ@mail.gmail.com>
In-Reply-To: <CAOLfK3VL5P7uAPAqvaRHv5gcoT5hdVqkSR5Nz+hTcb=FRmj9ZQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 28 Sep 2021 14:59:11 -0400
Message-ID: <CAJCQCtT0CvQ1Rmwpq3_nu1+G5wVx7+5ivDxLMTRG+=Vk0Fh0-g@mail.gmail.com>
Subject: Re: unable to mount disk?
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 28, 2021 at 2:53 PM Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
>
> Greetings btrfs folks,
>
> I am attempting to mount a filesystem on a (likely) failing disk:
>
> $ mount /var/local/media
> mount: /var/local/media: wrong fs type, bad option, bad superblock on
> /dev/sdb, missing codepage or helper program, or other error.
>
> excerpt from dmesg:
>
> [  352.642893] BTRFS info (device sdb): disk space caching is enabled
> [  352.642897] BTRFS info (device sdb): has skinny extents
> [  352.645562] BTRFS error (device sdb): devid 2 uuid
> bf09cc8f-44d6-412e-bc42-214ff122584a is missing
> [  352.645570] BTRFS error (device sdb): failed to read the system array: -2
> [  352.646770] BTRFS error (device sdb): open_ctree failed
>
> Is there anything I can do to attempt to recover this hardware issue?


This is a 2+ device Btrfs file system? And one of the devices, devid2,
is missing. So you need to figure out why. If the drive has in fact
failed, rather than just missing power/data connection, you can mount
degraded using the 'degraded' mount option. Just be advised that there
are potentially some consequences to operating under degraded mode,
depending on the specific configuration.

-- 
Chris Murphy
