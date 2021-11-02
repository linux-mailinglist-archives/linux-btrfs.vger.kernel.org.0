Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A41443049
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 15:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhKBO0Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhKBO0Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 10:26:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9361C061767
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 07:23:49 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j75so25790205ybj.6
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o9LvHf4tEDu95jHqBmDHYQ21lIObZPeskqbsrF2TeqQ=;
        b=VeYV8df2pmekKXpmsAN9ystpYHRqb/uNT8g2sV5XQ7WRdY02dfevRXNnTJ2uGOL1Xg
         IOEEAXuMC5r8+8KCtDy3y6lK523BfVbemA51CJJ0V72BVQa7R/cvE4zvenuD1q5iTQnR
         //pkW/ECsG0PpAUw0MYRpToP3ZjxcVxXt7qUThRm+9JSBl1iewcny1nSW+XYu9iTpiiP
         hYowZR8vRy1MB7t0afRQO0XhyWTBGUXzwWV5M9Tuv5vSzg9nZ1uNgtC9S3edaRl00glr
         Jdmm9YY/d/ldngDIu08tCuBWwcdhuNvxks4lgIOcFJBQxAUsboTonRzgRtLIztqvsvpj
         hTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o9LvHf4tEDu95jHqBmDHYQ21lIObZPeskqbsrF2TeqQ=;
        b=cMv5npDlKqJIbJtilTaprHhwZ01k1T7pQhAOvWv5yjglIBPrtVBfHPqs/3FkkScVvl
         E6PIzuzuPzyCyVGzP8wAdI8VCTx+gOkZcggeV3etQNEslRjs/BnoKlG19qN6M6+5nlQ6
         9fpQXBHf1OBOl0UFGsWq0+0Zc142G+/2Yue+h+K1aKr4cz8x5Jy1XYHpPX5jEz+2U/1N
         wCJ4KrSNYiMQjCBJD9sGuO1miYo14r9IjjQrytAayVv7nDrsk2fSa8JWzL8AZPdJIyFQ
         iLZ/1zR+p4HAI1tB4xiiqv+4H/x7+2DSC7lR/kkiF6tbt4xDfa4y1thBbjjJg+Ad1K28
         8ehA==
X-Gm-Message-State: AOAM530+tBCj9F4Wha73JXqGx/ic/lrwrZrdFCBQLs/iry2iwSt7UjHO
        ZhDtEswt4OfkPoXvSSO5FCMJ3MEWEQI/18G8ZTCyC0lCy28rK25D
X-Google-Smtp-Source: ABdhPJyTw94jTsNKnLsu13KnfxsLNudt4hep3bULy9WVG7yl8qUIxgKtc30aptgYouf9pa9bbOVlRKFaKBnzA8J9i3Y=
X-Received: by 2002:a25:4d83:: with SMTP id a125mr39644665ybb.277.1635863029091;
 Tue, 02 Nov 2021 07:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com> <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com> <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
 <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com> <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
 <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
 <CAJCQCtQ0_iAyC8Tc8OZyf2JGGnboXm8zk9itZaOLAoK=w1qdrg@mail.gmail.com>
 <b03fb30f-3d4b-413c-0227-6655ffeba75d@suse.com> <CAJCQCtQT22cdBPZ+d03m8c_sCtdVaM_Oz705T37v2XPx26SWFg@mail.gmail.com>
 <420a1889-6a35-c7d2-b4f7-735a922fe469@suse.com>
In-Reply-To: <420a1889-6a35-c7d2-b4f7-735a922fe469@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 2 Nov 2021 10:23:32 -0400
Message-ID: <CAJCQCtTwGvk4zCAQ16L5Pq5+Us4JprKw1LQse_3Nodt_nn3CXQ@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 1:36 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 27.10.21 =D0=B3. 21:22, Chris Murphy wrote:
> > On Tue, Oct 26, 2021 at 3:14 AM Nikolay Borisov <nborisov@suse.com> wro=
te:
> >
> >> I think I identified a race that could cause the crash, can you apply =
the
> >> following diff and re-run the tests and leave them for a couple of day=
s.
> >> Preferably apply it on 5.4.10 so that there is the highest chance to r=
eproduce:
> >>
> >> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> >> index 309516e6a968..a3d788dcbd34 100644
> >> --- a/fs/btrfs/async-thread.c
> >> +++ b/fs/btrfs/async-thread.c
> >> @@ -234,6 +234,11 @@ static void run_ordered_work(struct __btrfs_workq=
ueue *wq,
> >>                                   ordered_list);
> >>                 if (!test_bit(WORK_DONE_BIT, &work->flags))
> >>                         break;
> >> +               /*
> >> +                * Orders all subsequent loads after WORK_DONE_BIT, pa=
ired with
> >> +                * the smp_mb__before_atomic in btrfs_work_helper
> >> +                */
> >> +               smp_rmb();
> >>
> >>                 /*
> >>                  * we are going to call the ordered done function, but
> >> @@ -317,6 +322,12 @@ static void btrfs_work_helper(struct work_struct =
*normal_work)
> >>         thresh_exec_hook(wq);
> >>         work->func(work);
> >>         if (need_order) {
> >> +               /*
> >> +                * Ensures all =D0=B2=D1=80=D0=B8=D1=82=D0=B5=D1=81 do=
ne in ->func are ordered before
> >> +                * setting the WORK_DONE_BIT making them visible to or=
dered
> >> +                * func
> >> +                */
> >> +               smp_mb__before_atomic();
> >>                 set_bit(WORK_DONE_BIT, &work->flags);
> >>                 run_ordered_work(wq, work);
> >>         } else {
> >>
> >
> > So far this appears to be working well - thanks!
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2011928#c54
>
> Great, but due to the nature of the bug I'd rather wait at least until
> the beginning of next week before sending an official patch so that this
> can be tested more. In your comment you state 3/3 kernel debug info
> installs and 6/6 libreoffice installs, how do those numbers compare
> without the fix?

More than 1/2 of the time there'd be an indefinite hang. Perhaps 1/3
of those would result in a call trace.



--
Chris Murphy
