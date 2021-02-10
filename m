Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1208231732C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 23:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhBJWS3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 17:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhBJWSY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 17:18:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A6DC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:17:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f23so5231607lfk.9
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3/OJ0Rl90WRvHPsYsZO3y3DOCqHV1pC8PtLjXTtAkHM=;
        b=qCg9nPCJvUkl0OxyGMjXVoI7NbL5sl/x3fqjfjCNNl69qyWECsoxVnmEC70bQcT3xz
         C/5rJtkjQwUUCcSYFP2iP0d0THq5RW+uU39uuNAxwPzMWc0RWyHCtDr1UYzCen5qibmg
         7AaXcaouqVgyXkLmUdTD8ddptJWDqxhtNPmekNvYDJtvebGcj3ZFuVYVKvqJ6/RyncIv
         i9r2On6Gvfsghaiy3nQzfIvilcD7ek6sO+6gyfsWj10fgnEmQoPUNU5KbW2H4OtVTdVd
         D4jHNbnCtDPm5czxszugWBqeyWz4i3w1RW3tgH32kKWTpwCe3iQFC1Lw4hO+jYWP4cWr
         zsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3/OJ0Rl90WRvHPsYsZO3y3DOCqHV1pC8PtLjXTtAkHM=;
        b=GkL4xgLMFbAJMnRPqSjn7Xnh8NVtQoGnRwxkBWyFtzButiZxYCTVrzxHHgXWXKi/Xw
         B1/rY42PhKcTsaCN8vvl/LU86VMiqmXJj9K+VRVR2UsLLY3C02QfBg2f8wtqv5zAq/VQ
         AchLO68AB1V2Mx20B+w/Sj7SZrUxzftmkrXUoqd35oHQcM3hDYEWJLuKPWrWitaPF5cT
         ynYtI5jGur8EOEo3p5xZdMkLy3MKK3YoZihOFbOgtQyrKv7js8tcKdZj++Ilp7xAs4jU
         J7bPfEeLpTLVvz8lTAZcsFh8FAr4XSD3nKtAtepLDvNKOGgZn7DVW7BDpc6fafxKxT/2
         C7kw==
X-Gm-Message-State: AOAM533qqeh4exwbR3gSKiEY7TOngW/8FBsHWxBRL7XWh7wyhSW34EnM
        5Uu8v8Rfw8Ed2L+WCcIQENDApzSmCQ0Yj2dmJ0/hrwQvC87rePXG
X-Google-Smtp-Source: ABdhPJy42XusU6UcXWEeebostFSWWXsOxh7PgOtQLTH3UBfKvhlcn8R5b8bjDrMevNiIfJh5AwncUiNWSHTgl0SRGII=
X-Received: by 2002:ac2:4dae:: with SMTP id h14mr2649221lfe.4.1612995461784;
 Wed, 10 Feb 2021 14:17:41 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com> <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com> <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com> <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com> <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com>
In-Reply-To: <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Wed, 10 Feb 2021 14:17:30 -0800
Message-ID: <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 9, 2021 at 9:47 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2021/2/6 =E4=B8=8A=E5=8D=889:57, Erik Jensen wrote:
> > On Wed, Feb 3, 2021 at 10:16 PM Erik Jensen <erikjensen@rkjnsn.net> wro=
te:
> >> On Sun, Jan 31, 2021 at 9:50 PM Su Yue <l@damenly.su> wrote:
> >>> On Mon 01 Feb 2021 at 10:35, Qu Wenruo <quwenruo.btrfs@gmx.com>
> >>> wrote:
> >>>> On 2021/1/29 =E4=B8=8B=E5=8D=882:39, Erik Jensen wrote:
> >>>>> On Mon, Jan 25, 2021 at 8:54 PM Erik Jensen
> >>>>> <erikjensen@rkjnsn.net> wrote:
> >>>>>> On Wed, Jan 20, 2021 at 1:08 AM Erik Jensen
> >>>>>> <erikjensen@rkjnsn.net> wrote:
> >>>>>>> On Wed, Jan 20, 2021 at 12:31 AM Qu Wenruo
> >>>>>>> <quwenruo.btrfs@gmx.com> wrote:
> >>>>>>>> On 2021/1/20 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
> >>>>>>>>> On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
> >>>>>>>>>> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen
> >>>>>>>>>> <erikjensen@rkjnsn.net>
> >>>>>>>>>> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen
> >>>>>>>>>>> <erikjensen@rkjnsn.net>
> >>>>>>>>>>> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> The offending system is indeed ARMv7 (specifically a
> >>>>>>>>>>>> Marvell ARMADA=C2=AE
> >>>>>>>>>>>> 388), but I believe the Broadcom BCM2835 in my Raspberry
> >>>>>>>>>>>> Pi is
> >>>>>>>>>>>> actually ARMv6 (with hardware float support).
> >>>>>>>>>>>
> >>>>>>>>>>> Using NBD, I have verified that I receive the same error
> >>>>>>>>>>> when
> >>>>>>>>>>> attempting to mount the filesystem on my ARMv6 Raspberry
> >>>>>>>>>>> Pi:
> >>>>>>>>>>> [ 3491.339572] BTRFS info (device dm-4): disk space
> >>>>>>>>>>> caching is enabled
> >>>>>>>>>>> [ 3491.394584] BTRFS info (device dm-4): has skinny
> >>>>>>>>>>> extents
> >>>>>>>>>>> [ 3492.385095] BTRFS error (device dm-4): bad tree block
> >>>>>>>>>>> start, want
> >>>>>>>>>>> 26207780683776 have 3395945502747707095
> >>>>>>>>>>> [ 3492.514071] BTRFS error (device dm-4): bad tree block
> >>>>>>>>>>> start, want
> >>>>>>>>>>> 26207780683776 have 3395945502747707095
> >>>>>>>>>>> [ 3492.553599] BTRFS warning (device dm-4): failed to
> >>>>>>>>>>> read tree root
> >>>>>>>>>>> [ 3492.865368] BTRFS error (device dm-4): open_ctree
> >>>>>>>>>>> failed
> >>>>>>>>>>>
> >>>>>>>>>>> The Raspberry Pi is running Linux 5.4.83.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Okay, after some more testing, ARM seems to be irrelevant,
> >>>>>>>>>> and 32-bit
> >>>>>>>>>> is the key factor. On a whim, I booted up an i686, 5.8.14
> >>>>>>>>>> kernel in a
> >>>>>>>>>> VM, attached the drives via NBD, ran cryptsetup, tried to
> >>>>>>>>>> mount, and=E2=80=A6
> >>>>>>>>>> I got the exact same error message.
> >>>>>>>>>>
> >>>>>>>>> My educated guess is on 32bit platforms, we passed
> >>>>>>>>> incorrect sector into
> >>>>>>>>> bio, thus gave us garbage.
> >>>>>>>>
> >>>>>>>> To prove that, you can use bcc tool to verify it.
> >>>>>>>> biosnoop can do that:
> >>>>>>>> https://github.com/iovisor/bcc/blob/master/tools/biosnoop_exampl=
e.txt
> >>>>>>>>
> >>>>>>>> Just try mount the fs with biosnoop running.
> >>>>>>>> With "btrfs ins dump-tree -t chunk <dev>", we can manually
> >>>>>>>> calculate the
> >>>>>>>> offset of each read to see if they matches.
> >>>>>>>> If not match, it would prove my assumption and give us a
> >>>>>>>> pretty good
> >>>>>>>> clue to fix.
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Qu
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Is this bug happening only on the fs, or any other btrfs
> >>>>>>>>> can also
> >>>>>>>>> trigger similar problems on 32bit platforms?
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Qu
> >>>>>>>
> >>>>>>> I have only observed this error on this file system.
> >>>>>>> Additionally, the
> >>>>>>> error mounting with the NAS only started after I did a `btrfs
> >>>>>>> replace`
> >>>>>>> on all five 8TB drives using an x86_64 system. (Ironically, I
> >>>>>>> did this
> >>>>>>> with the goal of making it faster to use the filesystem on
> >>>>>>> the NAS by
> >>>>>>> re-encrypting the drives to use a cipher supported by my
> >>>>>>> NAS's crypto
> >>>>>>> accelerator.)
> >>>>>>>
> >>>>>>> Maybe this process of shuffling 40TB around caused some value
> >>>>>>> in the
> >>>>>>> filesystem to increment to the point that a calculation using
> >>>>>>> it
> >>>>>>> overflows on 32-bit systems?
> >>>>>>>
> >>>>>>> I should be able to try biosnoop later this week, and I'll
> >>>>>>> report back
> >>>>>>> with the results.
> >>>>>>
> >>>>>> Okay, I tried running biosnoop, but I seem to be running into
> >>>>>> this
> >>>>>> bug: https://github.com/iovisor/bcc/issues/3241 (That bug was
> >>>>>> reported
> >>>>>> for cpudist, but I'm seeing the same error when I try to run
> >>>>>> biosnoop.)
> >>>>>>
> >>>>>> Anything else I can try?
> >>>>>
> >>>>> Is it possible to add printks to retrieve the same data?
> >>>>>
> >>>> Sorry for the late reply, busying testing subpage patchset. (And
> >>>> unfortunately no much process).
> >>>>
> >>>> If bcc is not possible, you can still use ftrace events, but
> >>>> unfortunately I didn't find good enough one. (In fact, the trace
> >>>> events
> >>>> for block layer is pretty limited).
> >>>>
> >>>> You can try to add printk()s in function blk_account_io_done()
> >>>> to
> >>>> emulate what's done in function trace_req_completion() of
> >>>> biosnoop.
> >>>>
> >>>> The time delta is not important, we only need the device name,
> >>>> sector
> >>>> and length.
> >>>>
> >>>
> >>> Tips: There are ftrace events called block:block_rq_issue and
> >>> block:block_rq_complete to fetch those infomation. No need to
> >>> add printk().
> >>>
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>
> >>
> >> Okay, here's the output of the trace:
> >> https://gist.github.com/rkjnsn/4cf606874962b5a0284249b2f2e934f5
> >>
> >> And here's the output dump-tree:
> >> https://gist.github.com/rkjnsn/630b558eaf90369478d670a1cb54b40f
> >>
> >> One important note is that ftrace only captured requests at the
> >> underlying block device (nbd, in this case), not at the device mapper
> >> level. The encryption header on these drives is 16 MiB, so the offset
> >> reported in the trace will be 16777216 bytes larger than the offset
> >> brtfs was actually trying to read at the time.
> >>
> >> In case it's helpful, I believe this is the mapping of which
> >> (encrypted) nbd device node in the trace corresponds to which
> >> (decrypted) filesystem device:
> >> 43,0    33c75e20-26f2-4328-a565-5ef3484832aa
> >> 43,32   9bdfdb8f-abfb-47c5-90af-d360d754a958
> >> 43,64   39a9463d-65f5-499b-bca8-dae6b52eb729
> >> 43,96   f1174dea-ea10-42f2-96b4-4589a2980684
> >> 43,128  e669d804-6ea2-4516-8536-1d266f88ebad
> >
> > What are the chances it's something simple like a long getting used
> > somewhere in the code that should actually be a 64-bit int?
> >
> That's what I expected, but I didn't find anything obviously suspicious y=
et.
>
> Unfortunately I didn't get much useful info from the trace events.
> As a lot of the values doesn't even make sense to me....
>
> But the chunk tree dump proves to be more useful.
>
> Firstly, the offending tree block doesn't even occur in chunk chunk range=
s.
>
> The offending tree block is 26207780683776, but the tree dump doesn't
> have any range there.
>
> The highest chunk is at 5958289850368 + 4294967296, still one digit
> lower than the expected value.
>
> I'm surprised we didn't even get any error for that, thus it may
> indicate our chunk mapping is incorrect too.
>
> Would you please try the following diff on the 32bit system and report
> back the dmesg?
>
> The diff adds the following debug output:
> - when we try to read one tree block
> - when a bio is mapped to read device
> - when a new chunk is added to chunk tree
>
> Thanks,
> Qu

Okay, here's the dmesg output from attempting to mount the filesystem:
https://gist.github.com/rkjnsn/914651efdca53c83199029de6bb61e20

I captured this on my 32-bit x86 VM, as it's much faster to rebuild
the kernel there than on my ARM board, and it fails with the same
error.
