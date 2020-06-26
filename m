Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002EA20B956
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 21:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgFZTeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFZTeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 15:34:03 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EECC03E979
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 12:34:02 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e13so9846889qkg.5
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mhXo3IG+5HphlTa85M0ZOrkAXP1Zies41Kd6MUO+p10=;
        b=LsieQRxGuFmo2D6UoiEmLTxK/gXA7pKqsLnP+zZkc2CXStZoCHe55Kbp09jm0y5N/u
         MXSm3pcq0Hor7akyV/E1/rmt1T4/gAZcmCt9m0c2MhJQVomEx9Uo4hdcwqZHmIaG+QZu
         T62TeP5AU7rPhx0YmXWM1Z2A87RHH3kLjby08+KiAv0snZsddGTC7j8kc2dJmxFV1bJ8
         +2kPlxaPmAraIIcCGIEkRWwvWLG+LuVHglQX2f9UUsve9W1qQhLpaD2nZp8//6SQd4us
         e+9QYhjMZHlGMQaovfy3JVlXj8KLewLKBOinUHrHz1Qc6hE4VOobhpkz45QHv+kBoOdU
         uGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mhXo3IG+5HphlTa85M0ZOrkAXP1Zies41Kd6MUO+p10=;
        b=rSx85DIEGlglMYNbEreTHobbJKWILkbVfoESLsmEiK1D+xAm7KarNPojPogRtaaUjt
         l3Vf9zFkWpJc5AxYuZfv5QdAjX8+Xlo7+ZMHlnWdWFKoY+fRjJe7HZXO6eNDbHLTZGqa
         J3MC+ynZ7SJuyrWofSxe6mZ3sz4vOzguOfzbgAsseW4GoY/KEAofVXVDPWZtIrGT+DeJ
         vYmOlC37GICVHUKyPsqMck5BvmjGAFGq3k0T7oPs3XJKga/XhiWxA0VHLpT1Qo95+ezl
         VB4Se30NAZghE4rX+23NF8Sprw7tIQrfE8eHGDCw1JatawXKWI/Kvvm+xwZcqsARimgj
         bFtQ==
X-Gm-Message-State: AOAM531TK7adsihyAdNxzmOGQHeabCAz6UyVwKtknQykPq6CX/13rOzY
        MuC8mjlWJab9MvUg1h7qyQmCBloTDfei34Sb+JGJjw==
X-Google-Smtp-Source: ABdhPJyXHGrY2fxfaGGlV0K079nLirfcBPiMyDhNC99YPX2djKP2afJY4MbnsAFsZ7Uq8iCP4rdpuAUrU+T8OZUbwqs=
X-Received: by 2002:ae9:f803:: with SMTP id x3mr4218372qkh.488.1593200041976;
 Fri, 26 Jun 2020 12:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de> <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de> <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de> <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de> <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com> <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
 <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com> <CAAKzf7kMFqkrQyRzJ6WHVE95PBm2e0BX+QBua-2-rasp=BR7FQ@mail.gmail.com>
In-Reply-To: <CAAKzf7kMFqkrQyRzJ6WHVE95PBm2e0BX+QBua-2-rasp=BR7FQ@mail.gmail.com>
From:   Tim Cuthbertson <ratcheer@gmail.com>
Date:   Fri, 26 Jun 2020 14:33:50 -0500
Message-ID: <CAAKzf7mLDwSxaY_THbA45EEHwV9x7vdgcMo1Q4-TSfkq1yj7=A@mail.gmail.com>
Subject: Fwd: weekly fstrim (still) necessary?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

---------- Forwarded message ---------
From: Tim Cuthbertson <ratcheer@gmail.com>
Date: Fri, Jun 26, 2020 at 2:30 PM
Subject: Re: weekly fstrim (still) necessary?
To: Chris Mason <clm@fb.com>


Well, I am going back to using a weekly, manual fstrim. I have been
doing that for many months with no issues.

I cannot be certain that discard=3Dasync caused the problem. However, I
had implemented that for the first time less than two days before I
discovered the problem. My system was still booting and seeming to run
fine, but then Firefox refused to start. I was looking for the problem
and I found csum errors in the systemd journal. Then, I ran btrfs
scrub, and found that there were 12,936 csum errors.

The systemd journals should still be available, if you'd like me to post th=
em.

Tim

On Fri, Jun 26, 2020 at 10:40 AM Chris Mason <clm@fb.com> wrote:
>
> On 26 Jun 2020, at 8:08, Tim Cuthbertson wrote:
>
> > ---------- Forwarded message ---------
> > From: Chris Mason <clm@fb.com>
> > Date: Mon, Jun 22, 2020 at 10:57 AM
> > Subject: Re: weekly fstrim (still) necessary?
> > To: David Sterba <dsterba@suse.cz>
> > Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
> >
> >
> > On 22 Jun 2020, at 10:23, David Sterba wrote:
> >
> >> On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
> >>> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
> >>>
> >>>>>> You need to check fstrim.timer, which in turn triggers
> >>>>>> fstrim.service.
> >>>>>
> >>>>> root@fex:~# cat /lib/systemd/system/fstrim.timer
> >>>>>
> >>>>> root@fex:~# cat /lib/systemd/system/fstrim.service
> >>>
> >>>> I'm familiar with the contents of the files. Do you have a
> >>>> question?
> >>>
> >>>
> >>> You have deleted my question, it have asked:
> >>>
> >>> This means: an extra fstrim (via btrfsmaintenance script, etc) is
> >>> unnecessary?
> >>
> >> You need only one service, either from the fstrim or from
> >> btrfsmaintenance.
> >
> > Dennis=E2=80=99s async discard features are working much better here th=
an
> > either periodic trims or the traditional mount -o discard.  I=E2=80=99d
> > suggest moving to mount -o discard=3Dasync instead.
> >
> > -chris
> >
> > Apparently, discard=3Dasync is still unsafe on Samsung SSDs, at least
> > older models. I enabled it on my 850 Pro, and within two days I was
> > getting uncorrectable errors (for csums). Scrub showed 12,936
> > uncorrectable errors.
> >
> > While I was trying to recover, a long SMART analysis showed the actual
> > drive to have no errors.
> >
> > Then, the first recovery attempt failed. I had deleted and recreated
> > the partition. When I was copying the backup snapshots back to the
> > SSD, uncorrectable errors showed up, again (4,119 of them after
> > copying one snapshot). I then overwrote the partition with all zeros,
> > and when I copied the snapshots back to it, there were no errors.
> > After recovering my filesystem, scrub still showed no errors. So, alls
> > well that ends well, I guess.
>
> We=E2=80=99re using this on a pretty wide variety of hardware, so I=E2=80=
=99m
> surprised to hear this.  Are you able to reproduce the problem?  Is a
> periodic fstrim still happening?
>
> -chris
