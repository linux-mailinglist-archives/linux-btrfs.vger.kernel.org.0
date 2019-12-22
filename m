Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA37A129027
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 23:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLVWMM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 17:12:12 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39767 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLVWML (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 17:12:11 -0500
Received: by mail-wm1-f44.google.com with SMTP id 20so14357892wmj.4
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2019 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SvDD4LM9T/TOm6pbXCJ8qPVa4gkj04GDx7AF8DLozLE=;
        b=Po9CBo9W1SI4KB5R8y24EJ4VF4VmXaM8rJHlPx2w3PPDqPhoaImIjjZCzlCh5LqaFt
         azGAz03TbHh5YXwcynTWKuHoOSji4J67cxPuEkinMGvdwIFGcqOumkubjcSSB94pa38P
         hJHx/bNGs0zrjbDZSp1Z7lZCr5N/7uWzPaeI22zgJabSbb8QiCALERgGN4Me+XKfbNIv
         NGXwfTve6cKQsp+ZFfHnvjJfgP1zN0ws8MnseWekLb3xIgU/KstEW1EfbWT/IP3ZIVJn
         YKwcLcROLnbBSHxK/DsuW6WWQnX/19ycT9fEub6WEDXk6pj37VmpSkx9kOtgq6VUTXQp
         xoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SvDD4LM9T/TOm6pbXCJ8qPVa4gkj04GDx7AF8DLozLE=;
        b=SolbKrWmbXdVDcqGJf0jk/VfD6DcKm4H2EEp+CNVsASzwHsuXXAZ5JFYgsiNGdotlC
         4KxmxdyZhuteoqBFKOHPmpgTeL0npJ0h/Z5cbqAcwpOXepj8aCcL+x6rMUDjPbUj5xpC
         cARcwoh6cBTE37j8K3H2rayGXyy3PMM9Hh6yst+j1xlGPsPV3gG1KYIfUWFx+XLv49Su
         qFef6z5bSPHJ3lJmSV0dd3w8+JAE/a7R9SvDz+ZmduzMqhNj8GcKkqesc0zVEBaBfxMh
         suHaUioBpcHvFblIXEjcWWjG6ac5iU1+Q6XrDB8sJOYDQUXHM6vCft4+kxhwYaD/omdg
         lwBQ==
X-Gm-Message-State: APjAAAXU12ZQeO6BEsJT98WZXwITvGMMNXKJhaJnm0zAUAWKEhaJ03SO
        ENffc6l8bk67GabNwwbUI40ZaeDKlJ498zmGll6lbQ==
X-Google-Smtp-Source: APXvYqw2/LqnGZQkdIeauUc/PEQxu95H1994nf1gEYhHPNKKbLIAipFKla60t7dZPy01yDfwE4Vlbi0hyoVusTBfxYQ=
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr27667920wmk.97.1577052727971;
 Sun, 22 Dec 2019 14:12:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
 <c246f5e9-c9b6-8323-9e2d-26f17051df6a@toxicpanda.com> <a6b6cfde-d5df-b68b-cd57-edccc970ad64@suse.com>
 <5e910a0e-2da8-72a0-fa36-7d48f2454ca4@toxicpanda.com> <a6488349-301f-1071-0d96-4970ca50c3cd@suse.com>
 <20191223001512.6477bd8f@natsu>
In-Reply-To: <20191223001512.6477bd8f@natsu>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 22 Dec 2019 15:11:52 -0700
Message-ID: <CAJCQCtSDxOa29cTNgr_cpJ5vT0boKRz2+nHLv2oUHiWYrGpkag@mail.gmail.com>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 22, 2019 at 12:15 PM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Sun, 22 Dec 2019 20:06:57 +0200
> Nikolay Borisov <nborisov@suse.com> wrote:
>
> > Well, if we rework how fitrim is implemented - e.g. make discards async
> > and have some sort of locking to exclude queued extents being allocated
> > we can alleviate the problem somewhat.
>
> Please keep fstrim synchronous, in many cases TRIM is expected to be completed
> as it returns, for the next step of making a snapshot of a thin LV for backup,
> to shutdown a VM for migration, and so on.

XFS already does async discards. What's the effect of FIFREEZE on
discards? An LV snapshot freezes the file system on the LV just prior
to the snapshot.

> I don't think many really care about how long fstrim takes, it's not a typical
> interactive end-user task.

I only care if I notice it affecting user space (excepting my timed
use of fstrim for testing).

Speculation: If a scheduled fstrim can block startup, that's not OK. I
don't have enough data to know if it's possible, let alone likely. But
when fstrim takes a minute to discard the unused blocks in only 51GiB
of used block groups (likely highly fragmented free space), and only a
fraction of a second to discard the unused block *groups*, I'm
suspicious startup delays may be possible.

Found this, from 2019 LSFMM
https://lwn.net/Articles/787272/



-- 
Chris Murphy
