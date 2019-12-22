Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A86128F81
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 19:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLVSvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 13:51:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33879 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfLVSvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 13:51:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so14388250wrr.1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2019 10:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwE5+fUdlYBRM6GUNdGAqgujJ22Km1Dton7VutXrPtg=;
        b=EqCV8e+6t2HkoFjKDXlLOl4fbx/MYZm113Pt7h0MPTkDUpdEjW/EJuoWEaBXj79gHv
         V/E9jl7DPeGD7oWzZUJ3Gj6gsf1CgTxIWrrEewkafg3sHxV2YrL6AbXDdBhWMLUWLgXU
         9B+pWQzzXT597Z3ZVaxRW6fbSRISJ3SizCC8tYvX71Cx4CKm4BnGLRVCIVFVmixabGAt
         JGfgA0q+sRzr4vYhDjWlvCuRKn6CZtk3r/Ot+nZ3dI34LXszIWKsM+EGXVjA0+V5ZmD0
         o8OKXDs+1Hx9Ji9ksB2SJ2DadiHTf0xMObKGjZuQRGaNKf0wHb7p2OtpndUT91RGqYZy
         Ywcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwE5+fUdlYBRM6GUNdGAqgujJ22Km1Dton7VutXrPtg=;
        b=mMbS+Z3WpHnAY7tns58YUCZQIUU/VqDIWOZUBIVhhZT8S4CV3Bq/AeQhzNpsMbLLPQ
         69ZCoTFdMY1Ddef5NC0Xt5awtFrhfs46wFus+NSMmIBZWlYqB8voUsSXtxGUTezREPc1
         cTf3kUsFy/5BbNzmruRMf+UObm0QI6DT+r/IUdgzwXfQHebMizhsR3c9T19lIxawOCdM
         EgNa4b/W1PMPZbEUafLYoai3teZc6N06qQGEya2MWw4q0sSoVU8Cukd40+V4OwqkaRJE
         xxtLd9xxgQT3ItPG0NGoS8g0GRhynPQWilB9gM3FARRJ5QRlRWkRjSZ8wVzKKUYtV02Q
         xHsA==
X-Gm-Message-State: APjAAAW3voMqiSmX2EuBbWRDUdr6F12vWGWNN3wjYY7XjEWpzVl6qw7e
        zs0o8NGQokZOy6N1lOiBymHvcYhEZT3njuxzwOgTgN+MLls25Q==
X-Google-Smtp-Source: APXvYqyilYeKSv/vKZyhYo4AnjjNJl/FuD9s3sQbhtZ/CgVR7jHk6DgtXaOLitLTfl5EdzRSwteCJZqkV+iqBnPQQpQ=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr26541969wre.390.1577040668750;
 Sun, 22 Dec 2019 10:51:08 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
 <c246f5e9-c9b6-8323-9e2d-26f17051df6a@toxicpanda.com> <a6b6cfde-d5df-b68b-cd57-edccc970ad64@suse.com>
 <5e910a0e-2da8-72a0-fa36-7d48f2454ca4@toxicpanda.com>
In-Reply-To: <5e910a0e-2da8-72a0-fa36-7d48f2454ca4@toxicpanda.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 22 Dec 2019 11:50:52 -0700
Message-ID: <CAJCQCtRHp-5y5UA-P8x-i8vBKgiQZg1G7CdzY85OODBTshVbgQ@mail.gmail.com>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 22, 2019 at 11:00 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 12/22/19 12:49 PM, Nikolay Borisov wrote:
> > But aren't those only for inline discards e.g. when you have explicitly
> > mounted with discard. The use case here is using FITRIM ioctl, does
> > Dennis' stuff fix this?
> >
>
> I definitely misread the email, I thought he was talking about the commits being
> slow.  The async discard stuff won't help with fitrim taking forever, there's
> only so much we can do in the face of shitty ssd's.  Thanks,

My concern isn't this particular built-in Samsung NVMe in an HP
laptop, but whether it's sane to enable a weekly fstrim by default in
Fedora 32, via util-linux's fstrim.timer. This can't be an uncommon
situation, it's commodity name brand hardware. And opensuse and
Ubuntu, at least, have enabled this timer by default for years.

While the timer is scheduled for Monday at midnight, it's actually
likely to run during the first boot on Monday. Is it plausible there's
a setup whereby startup is blocked for the duration of this fstrim? If
so, that's way more shitty than having a shitty SSD. And if it's not
plausible, then does it matter if fstrim takes 5 minutes to run once a
week on some SSDs? I'm not seeing blocking, but what about other
shitty SSDs?

Blast from the past, this is 9 years old now: "At any rate, I
definitely think both the online trim and the FITRIM have their uses.
One thing that has burnt us in the past is coding too much for the
performance of the current crop of ssds when the next crop ends up
making our optimizations useless. This is the main reason I think the
online trim is going to be better and better. " Chris Mason
https://lwn.net/Articles/417809/

Really the industry has been schizo about this issue: totally mixed
messaging about the problem, the solution, and providing an interface
for it. In one way or another, most SSDs are shitty, depending on your
metric. Perhaps we're only just now coming out of the SSD stone age,
into the bronze age.

But what I don't want to do is make a "one size fits all" weekly timed
fstrim cause worse problems.


-- 
Chris Murphy
