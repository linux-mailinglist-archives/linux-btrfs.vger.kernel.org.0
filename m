Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA530EC64
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 07:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhBDGRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 01:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhBDGRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 01:17:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5742DC061573
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 22:17:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m13so2037679wro.12
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Feb 2021 22:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P6gvMkB/MmcTsfrQsGh/vvtP9+bkjZRH1lHqzTaaXl8=;
        b=sOqs8MFNJF0Gr7Zm+lTd4Crkqo9xG2cvF33BuN5ONZql+aJRMU3qBwmZQdm4fc50zr
         38HSz1yx/JOIhRyE3+mYcyUkkGVmBJhgJGrjZ+cpaBq5mDaG8yD7oxjfEvuby/n6G20A
         G0BBRSoqj+X3cvMakrw9GD7m4CjsszmZxY5y8V9BjPZJbmyLTr2JAjb8iJZHrfBntAHM
         bYHjWZN6/AVkaGbW+T+nKQx5LW3/ZvqaY+8doMtehyzN2iLQ4KSO0c3xqnLhQ8qha7Qf
         JHtX3h6axmD021YGf0+HV9zQI3KHauuf081eciP+FzEGERr/w5+rMl6228Rjz3/9V7p8
         lBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P6gvMkB/MmcTsfrQsGh/vvtP9+bkjZRH1lHqzTaaXl8=;
        b=qpFan3duOAzHDh2YIor9reTWFg5y457ABS1TqqUGEoeMGbFJSA7/0GauAw234lMswv
         xvso2kHHhEJd77E8QlZoUydvOJlAs+KZ1dM+vyAIfh7AwxDs1VcV2Ece1Dgi1SfJ6R0F
         p3R5vtVRxpi6IoUaqHWhHLUltmMEl4BNnxv2uZLiwQvYMDGaNY90vEDhTsg2r3F3O7Bf
         N2TPdcgIGWAbz+mcqeYz6zI5SsJqo8iUvOARYJyMsOmuW5Il6yG6RK6qLYb0s9mLjEUV
         CyKZNwI7tAc1pHyFJoHkyDZB//I5z51H9eSyS/Af8/Z8/PXPW9gg4ZdIQv9y3RV7Z47V
         zb6A==
X-Gm-Message-State: AOAM533bQukNzad9y1I0E1+B45/WcstDkxixtKVO5sZXv7pf7/GcMCYj
        1YxTqt5HwYZJ+zjMdtHbM9JHCrVVVDio8fISzGgd5g==
X-Google-Smtp-Source: ABdhPJw8m3CVeHTjyLqeNgtRUej/C2g5jJzgmo2rNbouhKBfIiuQXLvc2//HGE1ZwG7pqLLOwYONFc4nKzn8lUjXn40=
X-Received: by 2002:a5d:6cb4:: with SMTP id a20mr7369818wra.192.1612419424018;
 Wed, 03 Feb 2021 22:17:04 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com> <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com> <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com> <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com> <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com> <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
In-Reply-To: <mtwofibp.fsf@damenly.su>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Wed, 3 Feb 2021 22:16:52 -0800
Message-ID: <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Su Yue <l@damenly.su>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 31, 2021 at 9:50 PM Su Yue <l@damenly.su> wrote:
> On Mon 01 Feb 2021 at 10:35, Qu Wenruo <quwenruo.btrfs@gmx.com>
> wrote:
> > On 2021/1/29 =E4=B8=8B=E5=8D=882:39, Erik Jensen wrote:
> >> On Mon, Jan 25, 2021 at 8:54 PM Erik Jensen
> >> <erikjensen@rkjnsn.net> wrote:
> >>> On Wed, Jan 20, 2021 at 1:08 AM Erik Jensen
> >>> <erikjensen@rkjnsn.net> wrote:
> >>>> On Wed, Jan 20, 2021 at 12:31 AM Qu Wenruo
> >>>> <quwenruo.btrfs@gmx.com> wrote:
> >>>>> On 2021/1/20 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
> >>>>>> On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
> >>>>>>> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen
> >>>>>>> <erikjensen@rkjnsn.net>
> >>>>>>> wrote:
> >>>>>>>>
> >>>>>>>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen
> >>>>>>>> <erikjensen@rkjnsn.net>
> >>>>>>>> wrote:
> >>>>>>>>>
> >>>>>>>>> The offending system is indeed ARMv7 (specifically a
> >>>>>>>>> Marvell ARMADA=C2=AE
> >>>>>>>>> 388), but I believe the Broadcom BCM2835 in my Raspberry
> >>>>>>>>> Pi is
> >>>>>>>>> actually ARMv6 (with hardware float support).
> >>>>>>>>
> >>>>>>>> Using NBD, I have verified that I receive the same error
> >>>>>>>> when
> >>>>>>>> attempting to mount the filesystem on my ARMv6 Raspberry
> >>>>>>>> Pi:
> >>>>>>>> [ 3491.339572] BTRFS info (device dm-4): disk space
> >>>>>>>> caching is enabled
> >>>>>>>> [ 3491.394584] BTRFS info (device dm-4): has skinny
> >>>>>>>> extents
> >>>>>>>> [ 3492.385095] BTRFS error (device dm-4): bad tree block
> >>>>>>>> start, want
> >>>>>>>> 26207780683776 have 3395945502747707095
> >>>>>>>> [ 3492.514071] BTRFS error (device dm-4): bad tree block
> >>>>>>>> start, want
> >>>>>>>> 26207780683776 have 3395945502747707095
> >>>>>>>> [ 3492.553599] BTRFS warning (device dm-4): failed to
> >>>>>>>> read tree root
> >>>>>>>> [ 3492.865368] BTRFS error (device dm-4): open_ctree
> >>>>>>>> failed
> >>>>>>>>
> >>>>>>>> The Raspberry Pi is running Linux 5.4.83.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Okay, after some more testing, ARM seems to be irrelevant,
> >>>>>>> and 32-bit
> >>>>>>> is the key factor. On a whim, I booted up an i686, 5.8.14
> >>>>>>> kernel in a
> >>>>>>> VM, attached the drives via NBD, ran cryptsetup, tried to
> >>>>>>> mount, and=E2=80=A6
> >>>>>>> I got the exact same error message.
> >>>>>>>
> >>>>>> My educated guess is on 32bit platforms, we passed
> >>>>>> incorrect sector into
> >>>>>> bio, thus gave us garbage.
> >>>>>
> >>>>> To prove that, you can use bcc tool to verify it.
> >>>>> biosnoop can do that:
> >>>>> https://github.com/iovisor/bcc/blob/master/tools/biosnoop_example.t=
xt
> >>>>>
> >>>>> Just try mount the fs with biosnoop running.
> >>>>> With "btrfs ins dump-tree -t chunk <dev>", we can manually
> >>>>> calculate the
> >>>>> offset of each read to see if they matches.
> >>>>> If not match, it would prove my assumption and give us a
> >>>>> pretty good
> >>>>> clue to fix.
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>>
> >>>>>> Is this bug happening only on the fs, or any other btrfs
> >>>>>> can also
> >>>>>> trigger similar problems on 32bit platforms?
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>
> >>>> I have only observed this error on this file system.
> >>>> Additionally, the
> >>>> error mounting with the NAS only started after I did a `btrfs
> >>>> replace`
> >>>> on all five 8TB drives using an x86_64 system. (Ironically, I
> >>>> did this
> >>>> with the goal of making it faster to use the filesystem on
> >>>> the NAS by
> >>>> re-encrypting the drives to use a cipher supported by my
> >>>> NAS's crypto
> >>>> accelerator.)
> >>>>
> >>>> Maybe this process of shuffling 40TB around caused some value
> >>>> in the
> >>>> filesystem to increment to the point that a calculation using
> >>>> it
> >>>> overflows on 32-bit systems?
> >>>>
> >>>> I should be able to try biosnoop later this week, and I'll
> >>>> report back
> >>>> with the results.
> >>>
> >>> Okay, I tried running biosnoop, but I seem to be running into
> >>> this
> >>> bug: https://github.com/iovisor/bcc/issues/3241 (That bug was
> >>> reported
> >>> for cpudist, but I'm seeing the same error when I try to run
> >>> biosnoop.)
> >>>
> >>> Anything else I can try?
> >>
> >> Is it possible to add printks to retrieve the same data?
> >>
> > Sorry for the late reply, busying testing subpage patchset. (And
> > unfortunately no much process).
> >
> > If bcc is not possible, you can still use ftrace events, but
> > unfortunately I didn't find good enough one. (In fact, the trace
> > events
> > for block layer is pretty limited).
> >
> > You can try to add printk()s in function blk_account_io_done()
> > to
> > emulate what's done in function trace_req_completion() of
> > biosnoop.
> >
> > The time delta is not important, we only need the device name,
> > sector
> > and length.
> >
>
> Tips: There are ftrace events called block:block_rq_issue and
> block:block_rq_complete to fetch those infomation. No need to
> add printk().
>
> >
> > Thanks,
> > Qu
>

Okay, here's the output of the trace:
https://gist.github.com/rkjnsn/4cf606874962b5a0284249b2f2e934f5

And here's the output dump-tree:
https://gist.github.com/rkjnsn/630b558eaf90369478d670a1cb54b40f

One important note is that ftrace only captured requests at the
underlying block device (nbd, in this case), not at the device mapper
level. The encryption header on these drives is 16 MiB, so the offset
reported in the trace will be 16777216 bytes larger than the offset
brtfs was actually trying to read at the time.

In case it's helpful, I believe this is the mapping of which
(encrypted) nbd device node in the trace corresponds to which
(decrypted) filesystem device:
43,0    33c75e20-26f2-4328-a565-5ef3484832aa
43,32   9bdfdb8f-abfb-47c5-90af-d360d754a958
43,64   39a9463d-65f5-499b-bca8-dae6b52eb729
43,96   f1174dea-ea10-42f2-96b4-4589a2980684
43,128  e669d804-6ea2-4516-8536-1d266f88ebad
