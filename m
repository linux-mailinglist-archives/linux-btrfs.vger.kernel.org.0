Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B68B754F8D
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jul 2023 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjGPQCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jul 2023 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPQCU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jul 2023 12:02:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FDE4
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 09:02:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55c85b4b06bso1956146a12.2
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689523338; x=1692115338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ4sFKoQxe0ZvG+nG+yTiMZfNedE6kQyvBlhRZ2n0TI=;
        b=SEUgu/t9OFQWzDlNGcnkv8QNaM8wLV+xsJU523iBnm5hotPoMhH1+FWJ4kukF6ZoOQ
         P8wA8PhEQxFkmW4LrbYdq4djOTmLONH1f9H09KM26GgUTsmNuxNNP4vKjLKO7db74mQ7
         z2XfQoMpynWyRvYqtlUeb5bpRYMzE6+tAqMxjBbTIDfNwglCKbLFy4aoRfAu9aO4VDwR
         PUISHJvDJVKC1Aa1iVyUuvkwueEEI+01YyvrGPpZLr8k85NI5aMQkwxvtuXkoES4w7p1
         IXcfxLz+xoPDlxxdZ8atGWZY2BSb8dABb9grX34uInwexYuK3mJibgFbQ1FMOwLnUhLe
         bSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689523338; x=1692115338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ4sFKoQxe0ZvG+nG+yTiMZfNedE6kQyvBlhRZ2n0TI=;
        b=J609Mt7LYdY0XyxFGiyYsi+uwnfd68mweukxtUm/aZlED+s/I9+6+noVSfB1ktqGDz
         IHB97hDdlhzreJyzOGfTPxXpm5DrXF0Xx96hizLDcHmFgORQFBOenj4GZ5cvUTHaBeOn
         mwx1TEmyEPi3XAvmc/7gvUXyrCmEtZ4UZFGVMK7RPnCu92cSds49hESZFe4MoBRa8LDg
         xlb9/e7AdaRxPn+PMNl5YTa7s4DenEjwYgU5gt7OtSNx48BgKY3k4SAkQlu4rELShLNq
         qCNVAS4nFdEaYZqSOcIDXG0MpJe6QbwNj4W83LFe5BofLimKYoLyQp4fG40JhR8KzRdC
         vjfA==
X-Gm-Message-State: ABy/qLbboPkwUHDbn03/bQM0I4BYXVHhbu2Zopz/xN1cBCSsl0Z/1ozB
        Q4SLdIJL1d5PpT8/HgnYX0NP7wqOE0ZFMCuToZdkqjG3hFs=
X-Google-Smtp-Source: APBJJlEogNHChzUweOhkNfEZr+2/EdxzrBG0vpFrurVO0bJrrLHU3b+fCgE/5LgMsBZgXqQGL4FS5RWWPes0lpkAVDc=
X-Received: by 2002:a17:903:228b:b0:1b8:3590:358a with SMTP id
 b11-20020a170903228b00b001b83590358amr10142574plh.19.1689523338185; Sun, 16
 Jul 2023 09:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2311414.ElGaqSPkdT@lichtvoll.de> <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
 <5977988.lOV4Wx5bFT@lichtvoll.de> <9e05c3b9-301c-84c5-385d-6ca4bfa179f4@gmx.com>
 <3d9af05d-af51-22a4-3dee-2fa9e743ce68@gmx.com> <CADkZQa=xu7h8jryjUNf_XYh=f88VTU4xNp1c7f=FxVHnmXmYoA@mail.gmail.com>
 <d18c2da7-17f7-4d39-c511-8123484b3c08@gmx.com>
In-Reply-To: <d18c2da7-17f7-4d39-c511-8123484b3c08@gmx.com>
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Sun, 16 Jul 2023 18:01:51 +0200
Message-ID: <CADkZQamJ0U9c_77prc-bFoyu+NgiyVsjo8dKYHdXOBHqAi=1Fw@mail.gmail.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

>You can try this patch to see if it helps with your setup:

>https://patchwork.kernel.org/project/linux-btrfs/patch/ef3951fa130f9b61fe0=
97e8d5f6e425525165a28.1689330324.git.wqu@suse.com/

I gave this patch a shot, applied to 6.4.3, and it did indeed return
scrub performance to 6.3.*-ish levels for me (at least in this short 5
minute test):

rockpro64 ~ # scrub canceled for 0a1dfaa5-e448-44df-b5ca-3024b9f35b43
Scrub started:    Sun Jul 16 17:48:48 2023
Status:           aborted
Duration:         0:05:28
Total to scrub:   103.34GiB
Rate:             322.61MiB/s
Error summary:    no errors found

Unpatched, I saw around ~140MiB/s.

As an aside, are you aware that the "Total to scrub" seems totally
borked in per device scrub status (-d flag)?

Scrub device /dev/mapper/disk5-6 (id 1) status
Scrub resumed:    Sun Jul 16 17:56:53 2023
Status:           running
Duration:         33:32:24
Time left:        0:00:00
ETA:              Sun Jul 16 17:59:36 2023
Total to scrub:   7.49TiB
Bytes scrubbed:   7.49TiB  (100.00%)
Rate:             65.03MiB/s
Error summary:    no errors found

Scrub device /dev/mapper/disk7-8 (id 2) status
Scrub resumed:    Sun Jul 16 17:56:53 2023
Status:           running
Duration:         33:32:24
Time left:        0:00:00
ETA:              Sun Jul 16 17:59:36 2023
Total to scrub:   8.35TiB
Bytes scrubbed:   8.35TiB  (100.00%)
Rate:             72.48MiB/s
Error summary:    no errors found


Best regards,
Sebastian

On Sun, Jul 16, 2023 at 12:55=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> On 2023/7/16 17:57, Sebastian D=C3=B6ring wrote:
> > Hi all,
> >
> >> I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
> > cache.
> >
> >> With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) c=
an
> > only go around 1GB/s.
> >
> > I'm also observing severely degraded scrub performance (~50%) on a
> > spinning disk (on top of mdraid and LUKS). Are we sure this regression
> > is in any way NVME related?
>
> The regression would happen if the storage devices don't have any
> firmware level request merge (SATA NCQ feature).
>
> In that case, the rework scrub block size is way smaller than the old
> one (64K vs 512K), which would cause performance regression.
>
> You can try this patch to see if it helps with your setup:
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/ef3951fa130f9b61fe=
097e8d5f6e425525165a28.1689330324.git.wqu@suse.com/
>
> For NVME, it still doesn't reach the old performance, but for SATA HDDs
> even without NCQ, it should more or less reach the old performance.
>
> Thanks,
> Qu
>
> >
> > Best regards,
> > Sebastian
> >
> > On Fri, Jul 14, 2023 at 3:01=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> >>
> >> Just a quick update on the situation.
> >>
> >> I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
> >> cache.
> >>
> >> With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) c=
an
> >> only go around 1GB/s.
> >>
> >> With dedicated VM and more comprehensive telemetry, it shows there are
> >> two major problems:
> >>
> >> - Lack of block layer merging
> >>     All 64K stripes are just submitted as is, while the old code can
> >>     merge its read requests to around 512K.
> >>
> >>     The cause is the removal of block layer plug/unplug.
> >>
> >>     A quick 4 lines fix can improve the performance to around 1.5GB/s.
> >>
> >> - Bad csum distribution
> >>     With above problem fixed, I observed that the csum verification se=
ems
> >>     to have only one worker.
> >>
> >>     Still investigating the cause.
> >>
> >> Thanks,
> >> Qu
> >>
> >> On 2023/7/11 19:33, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2023/7/11 19:26, Martin Steigerwald wrote:
> >>>> Qu Wenruo - 11.07.23, 13:05:42 CEST:
> >>>>> On 2023/7/11 18:56, Martin Steigerwald wrote:
> >>>>>> Qu Wenruo - 11.07.23, 11:57:52 CEST:
> >>>>>>> On 2023/7/11 17:25, Martin Steigerwald wrote:
> >>>>>>>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
> >>>>>>>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
> >>>>>>>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
> >>>>>>>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
> >>>>>>>>>>> latency
> >>>>>>>>>>> values from 55 to 85 =C2=B5s which is highly unusual for NVME=
 SSD
> >>>>>>>>>>> ("avio"
> >>>>>>>>>>> in atop=C2=B9).
> >>>> [=E2=80=A6]
> >>>>>>>>> Mind to try the following branch?
> >>>>>>>>>
> >>>>>>>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
> >>>>>>>>>
> >>>>>>>>> Or you can grab the commit on top and backport to any kernel >=
=3D
> >>>>>>>>> 6.4.
> >>>>>>>>
> >>>>>>>> Cherry picking the commit on top of v6.4.3 lead to a merge
> >>>>>>>> conflict.
> >>>> [=E2=80=A6]
> >>>>>>> Well, I have only tested that patch on that development branch,
> >>>>>>> thus I can not ensure the result of the backport.
> >>>>>>>
> >>>>>>> But still, here you go the backported patch.
> >>>>>>>
> >>>>>>> I'd recommend to test the functionality of scrub on some less
> >>>>>>> important machine first then on your production latptop though.
> >>>>>>
> >>>>>> I took this calculated risk.
> >>>>>>
> >>>>>> However, while with the patch applied there seem to be more kworke=
r
> >>>>>> threads doing work using 500-600% of CPU time in system (8 cores
> >>>>>> with
> >>>>>> hyper threading, so 16 logical cores) the result is even less
> >>>>>> performance. Latency values got even worse going up to 0,2 ms. An
> >>>>>> unrelated BTRFS filesystem in another logical volume is even stall=
ed
> >>>>>> to almost a second for (mostly) write accesses.
> >>>>>>
> >>>>>> Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB o=
f
> >>>>>> data, mostly in larger files. Now on second attempt even only 620
> >>>>>> MiB/s. Which is less than before. Before it reaches about 1 GiB/s.
> >>>>>> I made sure that no desktop search indexing was interfering.
> >>>>>>
> >>>>>> Oh, I forgot to mention, BTRFS uses xxhash here. However it was
> >>>>>> easily scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses
> >>>>>> zstd compression and free space tree (free space cache v2).
> >>>>>>
> >>>>>> So from what I can see here, your patch made it worse.
> >>>>>
> >>>>> Thanks for the confirming, this at least prove it's not the hashing
> >>>>> threads limit causing the regression.
> >>>>>
> >>>>> Which is pretty weird, the read pattern is in fact better than the
> >>>>> original behavior, all read are in 64K (even if there are some hole=
s,
> >>>>> we are fine reading the garbage, this should reduce IOPS workload),
> >>>>> and we submit a batch of 8 of such read in one go.
> >>>>>
> >>>>> BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
> >>>>> And what about the latency?
> >>>>
> >>>> CPU usage is between 600-700% on 6.3.9, Latency between 50-70 =C2=B5=
s. And
> >>>> scrubbing speed is above 2 GiB/s, peaking at 2,27 GiB/s. Later it we=
nt
> >>>> down a bit to 1,7 GiB/s, maybe due to background activity.
> >>>
> >>> That 600~700% means btrfs is taking all its available thread_pool
> >>> (min(nr_cpu + 2, 8)).
> >>>
> >>> So although the patch doesn't work as expected, we're still limited b=
y
> >>> the csum verification part.
> >>>
> >>> At least I have some clue now.
> >>>>
> >>>> I'd say the CPU usage to result (=3Dscrubbing speed) ratio is much, =
much
> >>>> better with 6.3. However the latencies during scrubbing are pretty m=
uch
> >>>> the same. I even seen up to 0.2 ms.
> >>>>
> >>>>> Currently I'm out of ideas, for now you can revert that testing pat=
ch.
> >>>>>
> >>>>> If you're interested in more testing, you can apply the following
> >>>>> small diff, which changed the batch number of scrub.
> >>>>>
> >>>>> You can try either double or half the number to see which change he=
lps
> >>>>> more.
> >>>>
> >>>> No time for further testing at the moment. Maybe at a later time.
> >>>>
> >>>> It might be good you put together a test setup yourself. Any compute=
r
> >>>> with NVME SSD should do I think. Unless there is something very spec=
ial
> >>>> about my laptop, but I doubt this. This reduces greatly on the turn-
> >>>> around time.
> >>>
> >>> Sure, I'll prepare a dedicated machine for this.
> >>>
> >>> Thanks for all your effort!
> >>> Qu
> >>>
> >>>>
> >>>> I think for now I am back at 6.3. It works. :)
> >>>>
