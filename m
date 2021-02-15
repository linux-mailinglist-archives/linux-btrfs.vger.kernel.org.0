Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F5C31C278
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhBOTbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 14:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBOTbu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 14:31:50 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DB6C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 11:31:09 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v24so12256215lfr.7
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 11:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vlad.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zPXDioDZGdc+1bB05jzydP75wzl7p311MAbt9sldGjI=;
        b=G+v9r+hxZClcrJSeCO/7HQ3npbBsc7jBHLVczvYrlWlGad7zRRFB0c7nWWt7xkcJA5
         Ebo4ivn+mHWzeDDV/Fu1L/3v7pHmRweO6PQOOqlqyOAPzOxW1M+Uz0rk8JX+iVQ/Nmt/
         ilaVC7ht60bRt5eBzZNZGGyzsTG0N8msSa+fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zPXDioDZGdc+1bB05jzydP75wzl7p311MAbt9sldGjI=;
        b=uCEriJ8aepuhiliKUif3OeQ8xgrt3Csf9u4luHRGmhMqyloMvp4Vha+JeAOh4w4X+L
         SGAT4/ca76oqOGKCQFqs5ipJJfbJpWcT1aSxqGJGAuRHdvf9v5k56qdu6Rat85yip/1x
         e38dPyLaaxhhRiNTupH7PRmOqwS+RSorf1b9tWUbtL7T4iBSg/NQqE/tu5xjAtRRg/Fh
         mgQzxqQmFZMyCjnHjBDz2ci28DrMQ3RAwkDc4hospDZhvayc9O9PCkgOqY1/yRi5+uZw
         wjS8psPDdvMKt98XDfd5BMTZXErkMG3ncJDaod0P8E3VRcDZ0qczWIua8+Ln66zC/an6
         3u9w==
X-Gm-Message-State: AOAM533agaSNy1biZ+h6Z2d6+uCOcg2TUGctYtnI1J7wnIKi8CPoSr8+
        0Qr29mFUlBMLTmSHVvb0wfKw/DpCalYHZHuhHTgqIf6sgsdINKHFyRs=
X-Google-Smtp-Source: ABdhPJwPHNYGJEHJBORt1wZRfJ/+ESV0fyorItfq55UsIgjrZSOprheihK4rKkfOfJJ89MvAFh+CtsAjvgAs7ZN/WAU=
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr9832155lfe.200.1613417467740;
 Mon, 15 Feb 2021 11:31:07 -0800 (PST)
MIME-Version: 1.0
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
In-Reply-To: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
From:   "Pal, Laszlo" <vlad@vlad.hu>
Date:   Mon, 15 Feb 2021 20:30:31 +0100
Message-ID: <CAFTxqD8fGcL1j904b=yFPUwYjJi_bz5iVcxkNC5BoLZ8Wm12ZA@mail.gmail.com>
Subject: Re: performance recommendations
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So,

I'm trying to recover this stuff... this is a CentOS7 based system
running for almost two years. It was never too fast, but did what I
intended to do, but today I've observed very very bad performance on
ls, rm and other complicated commands. Like rm <any single file> takes
forever and in iotop I can see this command is using 50% of i/o
together with btrfs-transacti, so something definitely wrong

I've added ram and cpu to the VM, but it does not help. Now, I'm also
trying to modify fstab to add noatime, autodefrag

In the journal I can see some "free cache file invalid, skip" warnings

Can anyone offer me some help, so at least I can boot the machine
(right now the boot times out on mount task, so I can have either
emergency mode or rescuecd)

Thank you
Laszlo

On Mon, Feb 15, 2021 at 3:53 PM Pal, Laszlo <vlad@vlad.hu> wrote:
>
> Hi,
>
> I'm not sure this is the right place to ask, but let me try :) I have
> a server where I mainly using btrfs because of the builtin compress
> feature. This is a central log server, storing logs from tens of
> thousands devices, using a text files in thousands of directories in
> millions of files.
>
> I've started to think it was not the best idea to choose btrfs for this :)
>
> The performance of this server was always worst than others where I
> don't use btrfs, but I thought this is just because the i/o overhead
> of compression and the not-so-good esx host providing the disk to this
> machine. But now, even rm a single file takes ages, so there is
> something definitely wrong. So, I'm looking for some recommendations
> for such an environment where the data-security functions of btrfs is
> not as important than the performance.
>
> I was searching the net for some comprehensive performance documents
> for months, but I cannot find it so far.
>
> Thank you in advance
> Laszlo
