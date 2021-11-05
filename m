Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F04466C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhKEQPM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 12:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhKEQPL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 12:15:11 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F829C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 09:12:31 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v64so24066953ybi.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yeJuHFw+98AYulbtgah2GdlzxizxivI2CEoNtqcsWcA=;
        b=w7/mKHmUpX6u3IuNg7GnLJschYHiRTThGnTldAxqXq/GdInqPKozMUvSC1PiAW7YHq
         RblU+LLCPw2iyIVLUd0qBK0AhMtqwW/JBY4Edz/ThxuAZVHNOin9rH6aXOw3jFZ8j06f
         uKV7r4KKcvh+wgOFdtZvBBFT3QUinDsq64IMLaP1OotwzoW5omXSeoFKlOCYtdecmyQ2
         B6s4xozhzjjFNLBWZGzfMhz4IHjPATe5FloQZIUVuT8tEvK0l9duSJwIzXk2K0LoVMFL
         +q7EPzjHpxd094c5+XD2Wzmne1HO80IuOR7N/X4kG+Qf80Y6HNH0CfPWKAd9NVIRmb23
         li4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yeJuHFw+98AYulbtgah2GdlzxizxivI2CEoNtqcsWcA=;
        b=N2GEBZkfqwJE4Ir6NaGd58x6RSvgXEZPgX9ERXkAOTUo15TVcOE1LS9PRc7toyT58B
         zPlvh1BlPefLsazTFT4QXjH5oapkP7ad8VSzcSvquSzDoUU04NJfjoVHZo0BHVOJ6OgA
         GJ/2cnNcGMmAaYcLcQTukodaj412CHirAV6Zh9sKe10s6Kd17QbwM4J9e6V+AqYSuV/f
         IKfzEk4tNBirhdmRsg+BA5QPyHgVZZB5s+CbmNnZOGwTqgSZ2qUC8Lak9Esl/iCAMmtE
         5/zbia7Or+4XA3yN7LMg2GHc0/smDiiVjodvGqUJaZZEVMPOBBG37L6XkFB++Q5/V2zH
         /atA==
X-Gm-Message-State: AOAM533LCP2iC6/2xyD+f5QDROInAyb1OVSs3/D5rYprTwzxvpParmaj
        kPOxvecPziyaHmAJx7tcUyOKyVUWFK8PNUuc4a2Bzw==
X-Google-Smtp-Source: ABdhPJz/y/bslrGF3hvbLng4gucnnD/h4tSZ+WAt3Mzv7KMSvTdAP6V5p4Yy2pmeDTZiwiY/lTqhkZnBsy8Q0Qrmc+k=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr57544502ybe.455.1636128750741;
 Fri, 05 Nov 2021 09:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com> <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
 <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com> <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
 <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
 <CAJCQCtQ0_iAyC8Tc8OZyf2JGGnboXm8zk9itZaOLAoK=w1qdrg@mail.gmail.com>
 <b03fb30f-3d4b-413c-0227-6655ffeba75d@suse.com> <CAJCQCtQT22cdBPZ+d03m8c_sCtdVaM_Oz705T37v2XPx26SWFg@mail.gmail.com>
 <420a1889-6a35-c7d2-b4f7-735a922fe469@suse.com> <CAJCQCtTwGvk4zCAQ16L5Pq5+Us4JprKw1LQse_3Nodt_nn3CXQ@mail.gmail.com>
 <a1087c57-06a8-65e9-a4e0-b9f81a58b2f5@suse.com>
In-Reply-To: <a1087c57-06a8-65e9-a4e0-b9f81a58b2f5@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 5 Nov 2021 12:12:14 -0400
Message-ID: <CAJCQCtSVEortM-UT-=kfFuJsKX5xsSYKS+g-NAwwYXZjo=_iDw@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 10:25 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 2.11.21 =D0=B3. 16:23, Chris Murphy wrote:
> > On Thu, Oct 28, 2021 at 1:36 AM Nikolay Borisov <nborisov@suse.com> wro=
te:
>
> <snip>
>
> >>>
> >>> So far this appears to be working well - thanks!
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2011928#c54
> >>
> >> Great, but due to the nature of the bug I'd rather wait at least until
> >> the beginning of next week before sending an official patch so that th=
is
> >> can be tested more. In your comment you state 3/3 kernel debug info
> >> installs and 6/6 libreoffice installs, how do those numbers compare
> >> without the fix?
> >
> > More than 1/2 of the time there'd be an indefinite hang. Perhaps 1/3
> > of those would result in a call trace.
>
> As you might have seen I did send a proper patch, if you've continued
> testing it over the weekend and still haven't encountered an issue you
> can reply with a Tested-by to the patch .

Did that.

Also, I just noticed the downstream bug comment that another tester
has run the original patch for several days and can't reproduce the
problem.

But the side note is that without the patch, they were experiencing
file system corruption, i.e. it would not mount following the crash.
Let me know if it's worth asking the tester for mount time failure
kernel messages; or a btrfs check of the corrupted system. I guess
this race is expected to never manifest on x86?
https://bugzilla.redhat.com/show_bug.cgi?id=3D2011928#c55



--=20
Chris Murphy
