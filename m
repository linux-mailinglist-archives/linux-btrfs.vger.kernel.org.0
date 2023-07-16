Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9055754E36
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jul 2023 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGPJ5c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jul 2023 05:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGPJ5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jul 2023 05:57:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5E10DA
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 02:57:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5577004e21bso1458904a12.2
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 02:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689501450; x=1692093450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scsLn9jzW3x1hYccqso2UIRZ9MzNU/YPXZAowo518Ns=;
        b=TeOabNOQjWS/AAt5KZrHXzFONi8ONo1cfMdK8r1ieJlG5LPMJRzSPyJBFHZYd4XqqF
         yFrrKaDItlwdMi7jSQrDuR9V6lwrtzLegXM02Ve4IVrfCsQzjBzTJJRtX4okDczrY1ba
         cv8+toy5LzMnpNpfSM9SLG4fb83fRxdm60BbewN6x55CKVnZyg7OsVva/N/S27/2Tb0a
         0Rviix5Nd1d/r91GwSHBE6PlZC5MgZLm72LFeT+T5vd7KSY5pEkXEeKQKkMLXBDqUOlR
         JUbU2aAhQVuEZA/sbQ7rT0C0DGzgbKIDwg1SDejJ3s0o9e3BsrbGsAc8tyIROlz7+C8L
         e//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689501450; x=1692093450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scsLn9jzW3x1hYccqso2UIRZ9MzNU/YPXZAowo518Ns=;
        b=jG1M1DkdlbvxRs4ZBl8dPk6LRR4jWB/bfiqtXPxdjZ4VaWk+r7s7GBrlqTBiy1rtYT
         3hSINm1kcxHOcztsNyXXi47+L/0cKUrsRURtVaPbyKLXgj7f0xIPk5Gv7ukdV2zPiiN5
         eMkt/Et/5QVMjVddS+oEjkcxtN4VnmMa6A3Byu1Vff0PunuizJiBk4C8QX8KEd6QpasY
         o2DjyVe6Fyko3cKCCIVIdzCxgHky6pATc/Vj0P8aM6W3lKVihE4GG2/n5ALpPP/QlXGO
         408K8nEBr+CESD4WlRAlgMbNi6f9bAZFq8tT3+TcfNyYJ/RMdedrEWmRn5rZWJwDe26Z
         CtBQ==
X-Gm-Message-State: ABy/qLbaKFSs0liIgCrU2sYwyn9WRkB4v691eS21VhHNBE1NbnfB2tK2
        frTf3OcmKAvnQMRLcunvzB+GVbtAqsc48L6Xess=
X-Google-Smtp-Source: APBJJlG8u0Fj71tSQenpl0MLLn/Fy1jN5REEG3PhamPFRSCV9dgKwVe1CDz3mDbC06D8tBXFMygWZkU4A4Qr8ErYJ7I=
X-Received: by 2002:a17:90a:5902:b0:263:ea6a:1049 with SMTP id
 k2-20020a17090a590200b00263ea6a1049mr7820713pji.2.1689501449631; Sun, 16 Jul
 2023 02:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2311414.ElGaqSPkdT@lichtvoll.de> <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
 <5977988.lOV4Wx5bFT@lichtvoll.de> <9e05c3b9-301c-84c5-385d-6ca4bfa179f4@gmx.com>
 <3d9af05d-af51-22a4-3dee-2fa9e743ce68@gmx.com>
In-Reply-To: <3d9af05d-af51-22a4-3dee-2fa9e743ce68@gmx.com>
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Sun, 16 Jul 2023 11:57:00 +0200
Message-ID: <CADkZQa=xu7h8jryjUNf_XYh=f88VTU4xNp1c7f=FxVHnmXmYoA@mail.gmail.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

>I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
cache.

>With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) can
only go around 1GB/s.

I'm also observing severely degraded scrub performance (~50%) on a
spinning disk (on top of mdraid and LUKS). Are we sure this regression
is in any way NVME related?

Best regards,
Sebastian

On Fri, Jul 14, 2023 at 3:01=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
> Just a quick update on the situation.
>
> I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
> cache.
>
> With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) can
> only go around 1GB/s.
>
> With dedicated VM and more comprehensive telemetry, it shows there are
> two major problems:
>
> - Lack of block layer merging
>    All 64K stripes are just submitted as is, while the old code can
>    merge its read requests to around 512K.
>
>    The cause is the removal of block layer plug/unplug.
>
>    A quick 4 lines fix can improve the performance to around 1.5GB/s.
>
> - Bad csum distribution
>    With above problem fixed, I observed that the csum verification seems
>    to have only one worker.
>
>    Still investigating the cause.
>
> Thanks,
> Qu
>
> On 2023/7/11 19:33, Qu Wenruo wrote:
> >
> >
> > On 2023/7/11 19:26, Martin Steigerwald wrote:
> >> Qu Wenruo - 11.07.23, 13:05:42 CEST:
> >>> On 2023/7/11 18:56, Martin Steigerwald wrote:
> >>>> Qu Wenruo - 11.07.23, 11:57:52 CEST:
> >>>>> On 2023/7/11 17:25, Martin Steigerwald wrote:
> >>>>>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
> >>>>>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
> >>>>>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
> >>>>>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
> >>>>>>>>> latency
> >>>>>>>>> values from 55 to 85 =C2=B5s which is highly unusual for NVME S=
SD
> >>>>>>>>> ("avio"
> >>>>>>>>> in atop=C2=B9).
> >> [=E2=80=A6]
> >>>>>>> Mind to try the following branch?
> >>>>>>>
> >>>>>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
> >>>>>>>
> >>>>>>> Or you can grab the commit on top and backport to any kernel >=3D
> >>>>>>> 6.4.
> >>>>>>
> >>>>>> Cherry picking the commit on top of v6.4.3 lead to a merge
> >>>>>> conflict.
> >> [=E2=80=A6]
> >>>>> Well, I have only tested that patch on that development branch,
> >>>>> thus I can not ensure the result of the backport.
> >>>>>
> >>>>> But still, here you go the backported patch.
> >>>>>
> >>>>> I'd recommend to test the functionality of scrub on some less
> >>>>> important machine first then on your production latptop though.
> >>>>
> >>>> I took this calculated risk.
> >>>>
> >>>> However, while with the patch applied there seem to be more kworker
> >>>> threads doing work using 500-600% of CPU time in system (8 cores
> >>>> with
> >>>> hyper threading, so 16 logical cores) the result is even less
> >>>> performance. Latency values got even worse going up to 0,2 ms. An
> >>>> unrelated BTRFS filesystem in another logical volume is even stalled
> >>>> to almost a second for (mostly) write accesses.
> >>>>
> >>>> Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of
> >>>> data, mostly in larger files. Now on second attempt even only 620
> >>>> MiB/s. Which is less than before. Before it reaches about 1 GiB/s.
> >>>> I made sure that no desktop search indexing was interfering.
> >>>>
> >>>> Oh, I forgot to mention, BTRFS uses xxhash here. However it was
> >>>> easily scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses
> >>>> zstd compression and free space tree (free space cache v2).
> >>>>
> >>>> So from what I can see here, your patch made it worse.
> >>>
> >>> Thanks for the confirming, this at least prove it's not the hashing
> >>> threads limit causing the regression.
> >>>
> >>> Which is pretty weird, the read pattern is in fact better than the
> >>> original behavior, all read are in 64K (even if there are some holes,
> >>> we are fine reading the garbage, this should reduce IOPS workload),
> >>> and we submit a batch of 8 of such read in one go.
> >>>
> >>> BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
> >>> And what about the latency?
> >>
> >> CPU usage is between 600-700% on 6.3.9, Latency between 50-70 =C2=B5s.=
 And
> >> scrubbing speed is above 2 GiB/s, peaking at 2,27 GiB/s. Later it went
> >> down a bit to 1,7 GiB/s, maybe due to background activity.
> >
> > That 600~700% means btrfs is taking all its available thread_pool
> > (min(nr_cpu + 2, 8)).
> >
> > So although the patch doesn't work as expected, we're still limited by
> > the csum verification part.
> >
> > At least I have some clue now.
> >>
> >> I'd say the CPU usage to result (=3Dscrubbing speed) ratio is much, mu=
ch
> >> better with 6.3. However the latencies during scrubbing are pretty muc=
h
> >> the same. I even seen up to 0.2 ms.
> >>
> >>> Currently I'm out of ideas, for now you can revert that testing patch=
.
> >>>
> >>> If you're interested in more testing, you can apply the following
> >>> small diff, which changed the batch number of scrub.
> >>>
> >>> You can try either double or half the number to see which change help=
s
> >>> more.
> >>
> >> No time for further testing at the moment. Maybe at a later time.
> >>
> >> It might be good you put together a test setup yourself. Any computer
> >> with NVME SSD should do I think. Unless there is something very specia=
l
> >> about my laptop, but I doubt this. This reduces greatly on the turn-
> >> around time.
> >
> > Sure, I'll prepare a dedicated machine for this.
> >
> > Thanks for all your effort!
> > Qu
> >
> >>
> >> I think for now I am back at 6.3. It works. :)
> >>
