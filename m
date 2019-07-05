Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7102B60D9A
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 00:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfGEWEW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 18:04:22 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35898 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEWEW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 18:04:22 -0400
Received: by mail-wr1-f47.google.com with SMTP id n4so11231452wrs.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8qTpVGIHLTXY5pcHNCO3bdmK2usd5Y1L2hjypDW9vk=;
        b=pobG+EPAfdIbOmtrW9DJMv0zeV2N4mFvfozoUABEk66atVGxRAC2s5fbviP/phjd1B
         VaGQSa5gyxZmvPvlLg4lZoljRdCbC67HXjeasekk2/ym3ub9hUZupb3lKZTETj0IhWFC
         3yPfaZY25N0ytDJQyiuF0L3N3Qm1uKp5s1w3OgQlU80NRidA4ue4PI4k31kSggTRGRd8
         lJnXDDtHhNMYSXoHfVlySp6/XgsLaVdMZ5FNyBZCiMkhrC0V8ojHuUpAvqLfGEEbnA9S
         tCQ5X2Qyei60uAQj0NgWOxFtv7awXFfJQUHzOJEuhmfAGpCRgEdiC0BVJyWp6ZqOBDK+
         ghew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8qTpVGIHLTXY5pcHNCO3bdmK2usd5Y1L2hjypDW9vk=;
        b=pIKQarKvQhnrY204901Q56Rt4cN6xU+s0s+rwMBM0ZzWhaiju3TpFSt3AaL8e8luf3
         VTA6rnex5cW9UfYAU0Vc6YKSy5h8IXIvzf23SXBywGdnsOr617X0SMO5JfqnCDT0zZWG
         fu1IY2mz8qRMajhOCJdKkdNnpdzmcEpKY1RymFGFbeqHk73WeLUZRc0dyTw526ki9RWc
         WTUaQlbKRVeKG4g4fyr5vi43WV8dvqS9cKt58e9bcZkrXwRd3bRZ4Q51cU8wHF8ZnB+E
         /ndIstnxts0u8jOtovnHIxersmyow445ojIrTm8bnSnWnEof0w17Al3UCvn7xEtbBA/d
         LWTw==
X-Gm-Message-State: APjAAAULOlDrp4n7unBWBb2cDaOP36zIYlVmK9GyU8g1uE3CR94ajpSW
        SL+KDxaocpK56fCmYmh76pi/Eny5PoPCOPEngZEKWg==
X-Google-Smtp-Source: APXvYqwwi0M8UkM+q7hiFr2Xi44HZ71DySaqBYgB0r9laswaDdAyevlBylXkzaODgiDnn9J9txemsA025mG/7zpgl3g=
X-Received: by 2002:a5d:4403:: with SMTP id z3mr5614569wrq.29.1562364259614;
 Fri, 05 Jul 2019 15:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <CAA91j0W+UhJ2O+K1SJs3JaOfzkCnRhWgGjfFxXju5_sUsCj18A@mail.gmail.com>
 <a0d34e0a-f2bb-abd5-bb6f-f82a8d2da190@gmail.com> <CAJCQCtTiYn3XrMQVVHhnttt_5ys-gaAq5maihNpDiFPRRqr8YA@mail.gmail.com>
In-Reply-To: <CAJCQCtTiYn3XrMQVVHhnttt_5ys-gaAq5maihNpDiFPRRqr8YA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 5 Jul 2019 16:04:08 -0600
Message-ID: <CAJCQCtTktsGAd0bP+EqyJHpnDtSgLofk5hCMtr_6qrN+tx=qSQ@mail.gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Vladimir Panteleev <thecybershadow@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 3:48 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> We need to see a list of commands issued in order, along with the
> physical connected state of each drive. I thought I understood what
> you did from the previous email, but this paragraph contradicts my
> understanding, especially when you say "correct approach would be
> first to convert all RAID 10 to RAID1 and then remove devices but that
> wasn't an option"
>
> OK so what did you do, in order, each command, interleaving the
> physical device removals.


To put a really fine point on this, in my estimation the data on sdf
and sdd are hanging by a thread. It's likely you have partial data
loss because clearly some Btrfs metadata is missing and there are no
other copies of it. For sure you do not want to try to repair the file
system, or do anything that will cause any writes to happen. Any
changes to the file system now will almost certainly make problems
worse, and the chance of recovery will be reduced.

#1: Reconnect the last missing device. Obviously Btrfs wants it
because there's necessary metadata on that drive that doesn't exist on
sdf or sdd.
#2: Only mount the volume ro from here on out. Even a rw mount might
make things worse.
#3: Rsync copy everything you care about off this volume onto a new
volume. At some point this rsync will fail when Btrfs discovers the
missing metadata, which is why you really need to follow step #1. But
if that missing drive is already wiped and retasked for some other
purpose, you're looking at a data recovery operation. Not a file
system repair operation.

Your best chance to avoid total data loss is to get as much off the
volume as you can while you still can. And then after that see if you
can get more off of it - which I think is doubtful.


-- 
Chris Murphy
