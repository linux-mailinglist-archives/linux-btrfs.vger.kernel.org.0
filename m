Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4754931CFCF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 19:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBPSDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 13:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhBPSDG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 13:03:06 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECFBC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 10:02:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h26so17396605lfm.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vlad.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mnZudgudpTrQqmAYhURTk96KhkGS1dCnCf33agB7luA=;
        b=f4+WZRbhvbQhFNtpmAYx8ZjF2FR38VSiPem9se7xLPs17m86G7FWoE791fOLHNHb6P
         4n/6TBoFeJK8zcSe/SufubMbNQ7pgo+QhjgtzKb1jXBgcj0KUkMjnjtUV8hg7uqgfR92
         Mc8bXovpazd7/VX0WClRTF0Z6bRdNRgiRiVsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mnZudgudpTrQqmAYhURTk96KhkGS1dCnCf33agB7luA=;
        b=EAxEVtpJrPQRBNDmm2zcRmFyEOdeFmqNAbqdE5zgdL97tyDZwxkHpfqswrGyq4abHr
         oEAF8/0i+/T0oJA+7TITKz0tsKcLUT/HDO6yZ64Q0pV0jdE+wcAgNr/Q20QGuyGPc6NA
         HvqoJpIGYC77pqovg6luG3/MBPdypCQ0mGU31wvu7uTctzD3qDoa3FYT2a6RbkHoD1NE
         NtZemTbf6+4LR5OyespXwFvScwLJ4Fcvsi+rdz/dT0skhFn0xjB4+rl3HT1gsX5VgBVc
         e8tfdNr0IINbd/8NUjGIh3ahg31tYmCd6AIBdnq7xPReeyX+qE2r0fx6j5ttHYfMj5XO
         SfPg==
X-Gm-Message-State: AOAM531Ajy8iq/OR8Ka2gKWEcG+QMbcF9Qmy1gPiVbEYvjetX8/HdnJB
        R3xUqFvcassqoUhsqAWikGJD5pdb3E4qG9ODV7fZOQ==
X-Google-Smtp-Source: ABdhPJw1qnhDlSBVo4fVnCrDnOZM2e2slR+mMIDPCKmEHkVT/bP48nvouGNjRliQj00I+PR899U1GpSZOkigGqjGupg=
X-Received: by 2002:ac2:5982:: with SMTP id w2mr5497389lfn.338.1613498543856;
 Tue, 16 Feb 2021 10:02:23 -0800 (PST)
MIME-Version: 1.0
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <e70bbe98-f6dc-9eaa-8506-cd356a1c2ed8@suse.com> <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
 <aeed56c3-e641-46a1-5692-04c6ae75d212@gmail.com> <CAFTxqD-SpnKBRY9Ri9xWFfNgWuHYVggYwCPdyXgF6ipUAzxNTg@mail.gmail.com>
 <20210216174906.iv5ylu3p7jn347kb@tiamat>
In-Reply-To: <20210216174906.iv5ylu3p7jn347kb@tiamat>
From:   "Pal, Laszlo" <vlad@vlad.hu>
Date:   Tue, 16 Feb 2021 19:01:47 +0100
Message-ID: <CAFTxqD_RgvZTPCZywE28nW==PjT5N68_8q7zr1Te-VAiHMp1oQ@mail.gmail.com>
Subject: Re: performance recommendations
To:     Leonidas Spyropoulos <artafinde@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Thank you. If I have to clone, I think I'll just get rid of the
machine and recreate with some other file system. I'm aware, this is
my fault -lack of research and time pressure-, but I think if I can
boot it with the old kernel I'll keep it running as long as it can and
I'll use this time to create another, better designed machine.

Answering your question regarding the ctree, no there is nothing else
in the log but when I check dmesg on the booted rescueCD during mount,
I can see some similar message "btrfs transaction blocked more than
xxx seconds" and the the end "open_ctree", so it seems I really have
some file system corruption as the root cause (maybe created by some
bugs in the old code, or some unexpected reboot)

Thx
Laszlo

On Tue, Feb 16, 2021 at 6:52 PM Leonidas Spyropoulos
<artafinde@gmail.com> wrote:
>
> Hi Laszlo,
>
> On 16/02/21, Pal, Laszlo wrote:
> > Hi,
> >
> > Thank you. So, I've installed a new centos7 with the same
> > configuration, old kernel and using btrfs. Then, upgraded the kernel
> > to 5.11 and all went well, so I thought let's do it on the prod server
> >
> Since this is a VM can you clone the disk / partition and attach it to
> another VM which running a newer kernel and btrfs progs?
>
> This way you can try debugging it without affecting prod server.
>
> > Unfortunately when I boot on 5.11 sysroot mount times out and I have
> > something like this in log
> >
> > btrfs open ctree failed
> So before that `dmesg` doesn't have any relevant logs?
> >
> > Any quick fix for this? I'm able to mount btrfs volume using a rescuCD
> > but I have the same issues, like rm a big file takes 10 minutes....
>
> If you manage to mount the disk in a newer kernel and btrfs progs try
> creating a new file system to take advantage of the new feature (on
> creation) - then migrate the data and follow the recommendations
> mentioned already.
>
> Cheers,
>
> --
> Leonidas Spyropoulos
>
> A: Because it messes up the order in which people normally read text.
> Q: Why is it such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing on usenet and in e-mail?
>
