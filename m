Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6395841B782
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbhI1TZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 15:25:36 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:43276 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbhI1TZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 15:25:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4HJqDq3kwmz9vKTB
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 19:23:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D1nMkkkxiZ8Q for <linux-btrfs@vger.kernel.org>;
        Tue, 28 Sep 2021 14:23:55 -0500 (CDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4HJqDq22Jnz9vKSh
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 14:23:55 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4HJqDq22Jnz9vKSh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4HJqDq22Jnz9vKSh
Received: by mail-qk1-f197.google.com with SMTP id bi20-20020a05620a319400b0045df2735d63so52836834qkb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GYI3uKp9aUSUVSjtEiBNkdWU3cU0XjFZnVy6k9iwHIc=;
        b=KtB/W9mdxyTVOoWw2mriu+IQTRE2rKlldigyyaIUYDceefevbv0KhAz7j5KjV+ggiW
         h/v6fu+tnHWTFa5u/V0Y5PAlR5LzFTb8N4XYuVtJEEfme1hSN082AsNMrsa9VCVoahnD
         3Vntjyl5WYKHwuApzMc8jlfqliMUU8aDlx5GonFLxi75tZvue+6BPP1fIzXbHlYkZ2hf
         lrOD6jDfAzP+/unwL9z30k3ngjWcqr6h3ca9EbcidJo9Jm2AQ5OHjB+ivjpfexFN1Pw4
         YXW6uK8W1Z4McUWb3ZtNLCiEiOPpGeHIAMBVmYNoh8aFn5M0aOkixGvP9nQuCD1qMv+R
         By7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GYI3uKp9aUSUVSjtEiBNkdWU3cU0XjFZnVy6k9iwHIc=;
        b=bLig7TvgHRjw/v3btWDz8J/Mq9utDBEJ/JZLClhvdSHNBrcI14YZdAxdvu1VtSY0vj
         gbhMt/kCTi1wq3MCOJS3e10NR5Q7sjPjI+yNgv4Ubz1UsLIz1REwIlkDrHtSIHJkMqU7
         iBS+OjD3mZpK0cdBpyZAo/eOd1MAQ+3KhM76HB8zM/8N6xJGzmwFm+NezJlO1NUwxFTz
         OZvkFI42EkZXzyerkFRnL8kkDIE9SPehEIBsH7Nk2QhtSm4ruKbqH+HAKUl0gExJKdM7
         hj/ubk45GCZU+8fj5mP+faIFefKYi6Jn4mJNOLP3yHHytztQYuvQLAdtzjHBatjF/VEz
         EPRA==
X-Gm-Message-State: AOAM530+MuOCM1ZtwqCVhCG+5V3fPeJChOMWOz2bvAFDj08H4MuPhBNk
        8o7o3FVYHhrT8jKUfSHKAKRL3GiR2Df1c2TeoNpioqwLNqnaJ+DVuzyuigAuXeqQya5V7/Z2hdr
        /dhTF5RiFK6pxko0fSn0rTjohi1jiek1DcyGN+6uksP0=
X-Received: by 2002:ac8:1386:: with SMTP id h6mr7816549qtj.36.1632857034567;
        Tue, 28 Sep 2021 12:23:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx34sNkChrMbhzPlZiRV9E/oRSamcfYaMsAc9Y2GaLgZgvGpM2GYUzm40ETuyweTaywlBNupon5tWCp8TZBx5I=
X-Received: by 2002:ac8:1386:: with SMTP id h6mr7816507qtj.36.1632857034145;
 Tue, 28 Sep 2021 12:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3VL5P7uAPAqvaRHv5gcoT5hdVqkSR5Nz+hTcb=FRmj9ZQ@mail.gmail.com>
 <CAJCQCtT0CvQ1Rmwpq3_nu1+G5wVx7+5ivDxLMTRG+=Vk0Fh0-g@mail.gmail.com>
In-Reply-To: <CAJCQCtT0CvQ1Rmwpq3_nu1+G5wVx7+5ivDxLMTRG+=Vk0Fh0-g@mail.gmail.com>
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Tue, 28 Sep 2021 14:23:41 -0500
Message-ID: <CAOLfK3UEeDT0N+jCd_M=JsW2V8N_t_XQzHBk4OQmqHD3_o6WdA@mail.gmail.com>
Subject: Re: unable to mount disk?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 28, 2021 at 1:59 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Tue, Sep 28, 2021 at 2:53 PM Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
> >
> > Greetings btrfs folks,
> >
> > I am attempting to mount a filesystem on a (likely) failing disk:
> >
> > $ mount /var/local/media
> > mount: /var/local/media: wrong fs type, bad option, bad superblock on
> > /dev/sdb, missing codepage or helper program, or other error.
> >
> > excerpt from dmesg:
> >
> > [  352.642893] BTRFS info (device sdb): disk space caching is enabled
> > [  352.642897] BTRFS info (device sdb): has skinny extents
> > [  352.645562] BTRFS error (device sdb): devid 2 uuid
> > bf09cc8f-44d6-412e-bc42-214ff122584a is missing
> > [  352.645570] BTRFS error (device sdb): failed to read the system array: -2
> > [  352.646770] BTRFS error (device sdb): open_ctree failed
> >
> > Is there anything I can do to attempt to recover this hardware issue?
>
>
> This is a 2+ device Btrfs file system? And one of the devices, devid2,
> is missing. So you need to figure out why. If the drive has in fact
> failed, rather than just missing power/data connection, you can mount
> degraded using the 'degraded' mount option. Just be advised that there
> are potentially some consequences to operating under degraded mode,
> depending on the specific configuration.

Thanks for the hints, Chris. Appreciated.

What sort of potential consequences are we talking about, if you could
elaborate?

Cheers,

-m
