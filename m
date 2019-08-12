Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9A8968D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 07:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfHLFEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 01:04:14 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40541 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfHLFEO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 01:04:14 -0400
Received: by mail-wm1-f52.google.com with SMTP id v19so10575842wmj.5
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2019 22:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AMPnVB5BkvTsHYxkji6HzCjtpeDjGfqgFEldZAo5Rg0=;
        b=Js6Kn1mURM1cHXcBKHvON4CwoEW7e74zFHjo2lfS0lEGKn79+wy9SrZuH4Do3lmT8m
         AmxOmJsGigLuMzdkPX1b/RXkZ290gfPc2Ng/AG0q2+Pkr3fiCjF8Ib2a2giPisrToGmw
         jXRzjrxBaBWKXsv0nnK9QpM+cLuZ6uZNdmnsUxn5Mn4KV55jhR+48ZBZ3aKKveF2RUcE
         3+YHBZJ4nheiYM64Z6DFgXX4ww8XNb9kdvPcD0wh+cWWFZKuEe/f4Ek9goeRgIkGYzpe
         5ymOh/hez7hq2HtckPLKMskSCagYMXILm76cxf+i6Q9uRXmvTw6Jgx6X2/eByP5AbFY8
         6ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=AMPnVB5BkvTsHYxkji6HzCjtpeDjGfqgFEldZAo5Rg0=;
        b=QWE7pJot7DJlWXzbB5dkLi3JYqjCXzQC3QZAZypmsMPCQ90nWdjDgJNh9qxyIZ+Cxy
         2lCPT9zNv8txxYkyjgJb/snsdRADdZ73cOzuiYx/Nm6ooyLsytVCsps90IuUxdS3dKTp
         VS8XgI4y5oRmoK0zKQcKyLxeTRtHcKxUMr171egh2sQbn8sltGpAXJ3QBcLxkSonQetg
         NBfmnxxTTIO4ucSBHjAJDP2SujAdLLe10o65Frb/2mLH7vNdo+ljovxHg2/O3ZoL+60Y
         sMzXsgYaXmvfQYQZb/RTGB/1laXNXXYyxU4dtcQsSOK3ZXHKdwIVDiV4CNnM/rEptH/B
         JTAg==
X-Gm-Message-State: APjAAAVdDGPI6GcSstcYEgYXgBYdARwZTJ2rlSBzcgXwA+VvLNsvViAQ
        GsapZbSxW0yeVx5cpTykxJLvsohXKVWkAws74ky4884o8dg=
X-Google-Smtp-Source: APXvYqz9R6U753lhPv/huG7xKDSFt33L43Fw5quPJtFbTf1wvqoqM8lPfHWwqhuykhw/7q2zWW2Go/EBciBVN+Z75ZM=
X-Received: by 2002:a7b:c453:: with SMTP id l19mr24721459wmi.106.1565586252238;
 Sun, 11 Aug 2019 22:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQrLLpX8uZwp2BYfgaF1QPfuf1_XRjVxG24cbDHfEo2uA@mail.gmail.com>
 <4dfdc5a4-a6d7-e96b-afa1-a9c71b123a96@gmx.com> <CAJCQCtT+VnSp_8i-QWT6iwCv9yaqQv2XfsVtsdvQmoG70aQZ7w@mail.gmail.com>
 <afe23216-7d73-4d33-d80c-15d29f24c64f@gmx.com> <CAJCQCtRyStqPLOXHVWkcha3GkA7wt2u00qSH7DfUyL_ift5ppQ@mail.gmail.com>
 <CAJCQCtQ7aFpyQ+g_YWZJCuwuqOSXH-Gany9s-CgEQM6f2RK5bA@mail.gmail.com>
 <CAJCQCtTwxW65Ftiu6Ts3FKF8bKef9cvnOrFrXo8ikvGcwog+9Q@mail.gmail.com> <1f386080-e460-bb51-5c89-47fc986564f4@gmx.com>
In-Reply-To: <1f386080-e460-bb51-5c89-47fc986564f4@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 11 Aug 2019 23:04:01 -0600
Message-ID: <CAJCQCtQ224w-WfSkjG2WVFmgY5TY7uvqMAYOgkhihOQ8U8c5vw@mail.gmail.com>
Subject: Re: [bug] btrfs check clear-space-cache v1 corrupted file system
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 11, 2019 at 10:54 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/8/12 =E4=B8=8B=E5=8D=8812:24, Chris Murphy wrote:
> > On Sun, Mar 10, 2019 at 5:20 PM Chris Murphy <lists@colorremedies.com> =
wrote:
> >>
> >> On Sat, Mar 2, 2019 at 11:18 AM Chris Murphy <lists@colorremedies.com>=
 wrote:
> >>>
> >>> Sending URL for dump-tree output offlist. Conversation should still b=
e on-list.
> >>
> >>
> >> Any more information required from me at this point?
> >
> > This file system has been on a shelf since the problem happened. Is
> > the lack of COW repairs with btrfs check solved? Can this file system
> > be fixed? Maybe --init-extent-tree is worth a shot?
> >
> >
> Latest btrfs check has solved the problem of bad CoW. In fact it's
> solved in btrfs-progs v5.1 release.
>
> So, if you run btrfs check --clear-space-cache v1 again, it shouldn't
> cause transid mismatch problem any more.

That's good news.

>
> Although IIRC that fs already got transid error, thus enhanced
> btrfs-check won't help much to solve the existing transid mismatch proble=
m.

OK and the other bug report I just posted is this same file system
failing to ro scrub. It's not obvious that the failure is due to
transid mismatch.

If the file system can't be fixed, I'll wipe it.

--=20
Chris Murphy
