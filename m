Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60835407C04
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 08:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhILGNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 02:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhILGNi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 02:13:38 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F67DC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Sep 2021 23:12:25 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id g2so4029239uad.4
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Sep 2021 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNi6stothPxaJHAxFaXuEG7Q1bc8S9CfCXMQeGQvkIU=;
        b=RwVj/CeLhT5r3BQFD2+XCBvdfopLp537fE6bkCfdmfstS1+dTlGDu/delAlU0hEKf8
         RApqM8g9PLLbvbyoiPZlDiklcsz2sRJhgqJ6xsbaWpnapaiVB3RKbkB7vE7OBFhP12iN
         iAuDokKXiNM0MbXDz8PcjyoljDZOMH//AGNehZEtvlXoVrcizJrcAUnMgZY4fpnwzUlB
         44lGLVcn2Xnvxr/nrCKtg/8AyTS3plqFk5tFRebRX5bAw7F9PXIhAEVJ2V6eXHcLjzH+
         zkgrmLHpLE9Kp6JoWi4GicaGSy5I3GfuxatTlnGoCZPX4qTQWBBAxUOTyO5iqkbK2Fcz
         bG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNi6stothPxaJHAxFaXuEG7Q1bc8S9CfCXMQeGQvkIU=;
        b=cSQAGOEO6OTLWgIFt8oEEWhpitmgBQIhUCg27lGQ9iAqGW9bsMJO+OfrQIKTrw2N2y
         oLjbekuCOY6Q8inQmQlfrPNn2gLb84TdeB0JgH/F7r4mmnY2FjpKjjW84/9yZV98BBeV
         7TjsPUIqlCG2W6bKi3XvKzAyO3UQxKbk0ivXnswakMCd1jlwbxxVlMlN8WBSnl2mqNOq
         gl173HtvBsZFk9OecBIDsQPoMfii6MTxtLkRIiu/z3A17X8dJKbcU4Xc9kYKst0F7pfX
         h6RzwpWuqVKuuwEUU271hKPoSdFWgjJK9pqLwSgE8e6btdFwlw3H35+e/95RQbDCdiie
         URWQ==
X-Gm-Message-State: AOAM5303UjnrfYmdLRwonrQBk0OTOrSewUnoJq59tzqgh2qP6peuTPK0
        12Hyocm3kQGRnWiJa4F8l/UmSI0L8wS/xaxwX4ckDlxu5RM=
X-Google-Smtp-Source: ABdhPJzxmsodGEJPKXZ1Lij3DqlJhwNgLJc8OoNjiJaksGkIcLXQVZZuwcRbno/s14PD/BQRdokJeri8KQAsDlYTQO0=
X-Received: by 2002:ab0:448:: with SMTP id 66mr2278374uav.64.1631427144287;
 Sat, 11 Sep 2021 23:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
 <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com> <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
 <20210911042414.GJ29026@hungrycats.org> <CAH5Ym4jNgs1iJufbmCDOS6N=k+YH4nZTSQ7j-MrM3mp8M0Yn2g@mail.gmail.com>
 <20210911165634.GK29026@hungrycats.org>
In-Reply-To: <20210911165634.GK29026@hungrycats.org>
From:   Sam Edwards <cfsworks@gmail.com>
Date:   Sun, 12 Sep 2021 00:12:13 -0600
Message-ID: <CAH5Ym4isja5hs73ibcACH5cm00=F43cG+m_sNtFjkJ_oRZJT1g@mail.gmail.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 11, 2021 at 10:56 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
> It's not one I've seen previously reported, but there's a huge variety
> of SSD firmware in the field.

It seems to be a very newly released SSD. It's possible that the
reason nobody else has reported issues with it yet is that nobody else
who owns one of these has yet met the conditions for this problem to
occur. All the more reason to figure this out, I say.

I've been working to verify what you've said previously (and to rule
out any contrary hypotheses - like chunks momentarily having the wrong
physical offset). One point I can't corroborate is:

> There are roughly 40 distinct block addresses affected in your check log,
> clustered in two separate 256 MB blocks.

The only missing writes that I see are in a single 256 MiB cluster
(belonging to chunk 1065173909504). What is the other 256 MiB cluster
that you are seeing? What shows that writes to that range went
missing, too? (Or by "affected" do you only mean "involved in the
damaged transactions in some way"?)

I do find it interesting that, of a few dozen missing writes, all of
them are clustered together, while other writes in the same
transactions appear to have had a perfect success rate. My expectation
for drive cache failure would have been that *all* writes (during the
incident) get the same probability of being dropped. All of the
failures being grouped like that can only mean one thing... I just
don't know what it is. :)

So, the prime suspect at this point is the SSD firmware. Once I have a
little more information, I'll (try to) share what I find with the
vendor. Ideally I'd like to narrow down which of 3 components of the
firmware apparently contains the fault:
1. Write back cache: Most likely, although not certain at this point.
If I turn off the write cache and the problem goes away, I'll know.
2. NVMe command queues: Perhaps there is some race condition where 2
writes submitted on different queues will, under some circumstances,
cause one/both of the writes to be ignored.
3. LBA mapper: Given the pattern of torn writes, it's possible that
some LBAs were not updated to the new PBAs after some of the writes. I
find this pretty unlikely for a handful of reasons (trying to write a
non-erased block should result in an internal error, old PBA should be
erased, ...)

However, even if this is a firmware/hardware issue, I remain
unconvinced that it's purely coincidence just how quickly this
happened after the upgrade to 5.14.x. In addition to this corruption,
there are the 2 incidents where the system became unresponsive under
I/O load (and the second was purely reads from trying to image the
SSD). Those problems didn't occur when booting a rescue USB with an
older kernel. So some change which landed in 5.14.x may have changed
the drive command pattern in some important way to trigger the SSD
fault (esp, in the case of possibility #2 above). That gives me hope
that, if nothing else, we may be able to add a device quirk to Linux
and minimize future damage that way. :)

Bayes calls out from beyond the grave and demands that, before I try
any experiments, I first establish the base rate of these corruptions
under current conditions. So that means rebuilding my filesystem from
backups and continuing to use it exactly as I have been, prepared for
this problem to happen again. Being prepared means stepping up my
backup frequency, so I'll first set up a btrbk server that can accept
hourly backups.

Wish me luck,
Sam
