Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF75D771E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 21:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfGZTKp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 15:10:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38048 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfGZTKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 15:10:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so55477576wrr.5
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2019 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8CuRXMXrUZ1AACmNbFXBcIsdlJEkTedjFr/PwtDrJPI=;
        b=CR3zpUQVsaj27yhYXOxHfUsIZTvhx8s37Pz7MUeqc1eT4fCjVDnV50MImkjVW+pmJW
         +OElGoFplgAD86jUFmArO+ikOEA2KKIhhygOslb0mPf4PUULcYUkbhi/blCxK8NrP2ev
         RieHAanKp+HkrV+M94VmA/988Sbu7cuTyhplEAuHh/FfPuvrUieeeGhEfnxGAXew9t/z
         w9QhwGtG9RQK7HEseBQQ6JsqEsD2kI5O4ZdmFBQk+xpd4M4PY+HqeZzqP9lWDWJXwFn+
         wwtFmQrTWQ9fX3CkLvw4TT59l+kniHmyhUn+sN+ItusipCksmHH9T4O4+mY9lVoTVfrg
         n5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8CuRXMXrUZ1AACmNbFXBcIsdlJEkTedjFr/PwtDrJPI=;
        b=s/gt518t4ft9DCmkoB0kuOpRbqERI3HYIxlzYC23ieeHMLeumuHN0pNooWZcmHcyGD
         CLxlHn5jJLsPEhFsUWu0tMEB8fjJrGjGTucppOIxSsigKBu6iULujRj9cUpDACl+94Se
         wordaWcBahglsU3eCytJUKqITZ2hI5TY78jrsXD8tKUoGbDPZi1H4EZIr3OhPYDdpJPz
         URC+T7Yo+OkBzt5xRLZlantGe8FNpAOGaS2bkR/UNmyxXrTTAKfGzr0ODxE8Jz0HzwA8
         E3kzlwEgidUd5pPlsG0Gnds8eA38NY4GDvEPRw24qx+zWubD8bbzFzBTdff27xMsZZ74
         jfzg==
X-Gm-Message-State: APjAAAXvK7gTpNG1M89StEqR75GoyUbXO7IVCJ3jNQZiB1uGqoRAstxT
        igGrS4/lPxRiy5Fbq79vzAgzMnXSZ+zYjFbVKXbQZlb0
X-Google-Smtp-Source: APXvYqwRhXzkWRgPgboPqtnOnM6ZjNXdsJ3VNPozA7FanA18FzGxAX8q0fB0F5+LiVu+izPWvYhmIaZllLGJfPrh5XE=
X-Received: by 2002:a5d:6911:: with SMTP id t17mr1541324wru.268.1564168243514;
 Fri, 26 Jul 2019 12:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRGNrKDBBFOZ3=Say=STMBAGMNKBwe4xsdJZL7mCRw98g@mail.gmail.com>
 <CAJCQCtSFNVTNNAEP9hSY3cbWike5VkdH8EZnaojjgZZ3tf-SfQ@mail.gmail.com> <a06193db-a690-49cd-0f04-0a8f7a680951@suse.com>
In-Reply-To: <a06193db-a690-49cd-0f04-0a8f7a680951@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 26 Jul 2019 13:10:32 -0600
Message-ID: <CAJCQCtQMcrAv9eQbHXenYzmbeEpFG+jkCm5Hqs75vXCyX29amg@mail.gmail.com>
Subject: Re: 5.3.0-0.rc1 various tasks blocked for more than 120 seconds
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 1:07 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 26.07.19 =D0=B3. 22:00 =D1=87., Chris Murphy wrote:
> > On Fri, Jul 26, 2019 at 12:43 PM Chris Murphy <lists@colorremedies.com>=
 wrote:
> >>
> >> Seeing this with Fedora kernel 5.3.0-0.rc1.git3.1.fc31.x86_64 which
> >> translates to git bed38c3e2dca
> >>
> >> It's causing automated OS installations to hang indefinitely, only on
> >> Btrfs. This is an excerpt of the first of many call traces:
> >>
> >> 15:52:20,316 ERR kernel:INFO: task kworker/u4:0:7 blocked for more
> >> than 122 seconds.
> >> 15:52:20,316 ERR kernel:      Not tainted 5.3.0-0.rc1.git3.1.fc31.x86_=
64 #1
> >> 15:52:20,316 ERR kernel:"echo 0 >
> >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> 15:52:20,316 INFO kernel:kworker/u4:0    D12192     7      2 0x8000400=
0
> >> 15:52:20,317 INFO kernel:Workqueue: btrfs-endio-write
> >> btrfs_endio_write_helper [btrfs]
> >> 15:52:20,317 WARNING kernel:Call Trace:
> >> 15:52:20,317 WARNING kernel: ? __schedule+0x352/0x900
> >> 15:52:20,317 WARNING kernel: schedule+0x3a/0xb0
> >> 15:52:20,317 WARNING kernel: btrfs_tree_read_lock+0xa3/0x260 [btrfs]
> >> 15:52:20,317 WARNING kernel: ? finish_wait+0x90/0x90
> >> 15:52:20,317 WARNING kernel: btrfs_read_lock_root_node+0x2f/0x40 [btrf=
s]
> >> 15:52:20,317 WARNING kernel: btrfs_search_slot+0x601/0x9d0 [btrfs]
> >> 15:52:20,317 WARNING kernel: btrfs_lookup_file_extent+0x4c/0x70 [btrfs=
]
> >> 15:52:20,317 WARNING kernel: __btrfs_drop_extents+0x16e/0xe00 [btrfs]
> >> 15:52:20,317 WARNING kernel: ? __set_extent_bit+0x55f/0x6a0 [btrfs]
> >> 15:52:20,317 WARNING kernel: ? kmem_cache_free+0x368/0x420
> >> 15:52:20,318 WARNING kernel:
> >> insert_reserved_file_extent.constprop.0+0x93/0x2e0 [btrfs]
> >> 15:52:20,318 WARNING kernel: ? start_transaction+0x95/0x4e0 [btrfs]
> >> 15:52:20,318 WARNING kernel: btrfs_finish_ordered_io+0x3da/0x840 [btrf=
s]
> >> 15:52:20,318 WARNING kernel: normal_work_helper+0xd7/0x500 [btrfs]
> >> 15:52:20,318 WARNING kernel: process_one_work+0x272/0x5a0
> >> 15:52:20,318 WARNING kernel: worker_thread+0x50/0x3b0
> >> 15:52:20,318 WARNING kernel: kthread+0x108/0x140
> >> 15:52:20,318 WARNING kernel: ? process_one_work+0x5a0/0x5a0
> >> 15:52:20,318 WARNING kernel: ? kthread_park+0x80/0x80
> >> 15:52:20,318 WARNING kernel: ret_from_fork+0x3a/0x50
> >> 15:52:20,318 ERR kernel:INFO: task kworker/u4:1:31 blocked for more
> >> than 122 seconds.
> >
> > Is it related to this and maybe already fixed? Or is it a different pro=
blem?
> > https://lore.kernel.org/linux-btrfs/20190725082729.14109-3-nborisov@sus=
e.com/
>
> Likely yes.

Yes it's fixed, or yes it's different?

--=20
Chris Murphy
