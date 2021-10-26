Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEDB43B908
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 20:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhJZSLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhJZSLY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 14:11:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243BC061745
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:09:00 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y80so19115492ybe.12
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aocynj/qMtU2FfSJqdMDC9gbMAsZ1y2cVw/kaklxC3w=;
        b=E9dKbETNhZIfG9990PAzFz9zib1K/zfVdck+Z4H/eyVZJcAfY2P+6oOxHeKKLreWKD
         h1vbcipgWtiI4LHpN95Cx/WlcSc8Xn/GB93Lo/YUjFlfTB8YRB3RV8yuFhImmFNR+VyO
         R6Jky1KNOnUldWf17uZet5XwJaEoAx2b+w78sR66GqsqnFsR76mdmC5RMJuUH5msDc+I
         ++/0RFLi+3nius1QZthoTcvEFJCCR9D6rMYOmLkTOdCBFvZrvyFkZxmSgiblGpAi0P0a
         b6JMrWmS+HfXEuEhAvCR+WG5qGDTiGtYvAcLA3Ngz2lXFsxos9G5z+9v5c4nEHWWePJI
         57Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aocynj/qMtU2FfSJqdMDC9gbMAsZ1y2cVw/kaklxC3w=;
        b=SEqHlaNuoOPxyNox2cCDIdiwd0nguJSsrOhsmUU6SxUuzrZUsW9UjLYJC0D501h2/w
         E+FQny/8G5OSpa5QV0sR4wnICTcdV3kSpGPylr7Y/EhXzzf2lYVLxtGW63YwH7wImQY3
         D3Abuc8G0a5kAw8bEaPmgEycBrSU+8GUuDnn/FypE4VpYdfkDJbP8lTq7Lua4yg9FZDa
         qJ/8CAoe4RSRfBJY8MiMqQ2yRojsa+gX8Gt07sAYLdDzl4WpBnlEo2BcWE8hFqgp9gBG
         jlE5sZRXkLJH0FTWNqLzoziMVktjjJwBgD1V+AtbFkJXf9VqpowCoNYJn0ND/ze8yTQV
         FSnw==
X-Gm-Message-State: AOAM532IhKE95RTzJacdSrPo6kVpwAFhCTt+J4nOrNthRd9sdgwrz0eO
        FHFFVN5cCuKvS1TtldYKmArhdFjU4mrcbZWCUKF5Kv8wBUAEZsBVSCs=
X-Google-Smtp-Source: ABdhPJzwJM/oiZWxaYGQds2BJby7QhzyiJGHAR1/G+Zi+ZVDV+ywNugcWohSlol5VnHTCceTm9espTBgVv26RtlLmmE=
X-Received: by 2002:a25:2e52:: with SMTP id b18mr17127923ybn.391.1635271739512;
 Tue, 26 Oct 2021 11:08:59 -0700 (PDT)
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
 <b03fb30f-3d4b-413c-0227-6655ffeba75d@suse.com> <CAJCQCtSrSHrNKV-HKRS0vy0T0ZrL5GR_BqpbG4iMNZZ66PJN5g@mail.gmail.com>
 <435c0ba3-dab9-3d01-7d43-0d370ffa36aa@suse.com>
In-Reply-To: <435c0ba3-dab9-3d01-7d43-0d370ffa36aa@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 26 Oct 2021 14:08:43 -0400
Message-ID: <CAJCQCtT02w+62mpRCxYNH07YatToQYFyaxuU=+8G_B5+QNgK8w@mail.gmail.com>
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

On Tue, Oct 26, 2021 at 9:05 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 26.10.21 =D0=B3. 15:51, Chris Murphy wrote:

> > Unfortunately the test we have is non-automated, it's "install this
> > package set" and wait. It always hangs, usually recovers without an
> > oops, but sometimes there's an oops. So it's pretty tedious to test it
> > with the "testcase" we currently have. I'd like a better one that
> > triggers this faster, but more importantly would be a reliable one.
> > We'll do our best though. Thanks!
>
> I thought the hang and the crash one are two different issues. What the
> above diff is supposed to solve is the case in which
> submit_compressed_extent is called with async_chunk->inode is null.

I don't know whether the hang and crash are related at all. I've been
unable to get a sysrq+t that shows anything when "dnf install
libreoffice" hangs, which I suspect could be dbus related where a
bunch of services get clobbered and restarted during the metric ton of
dependencies that libreoffice brings into a cloud base image. But
there is a consistent hang just installing kernel debug info and maybe
half the time the VM just falls over and isn't responsive at all -
later we sometimes see the submit_compressed_extent call trace in
virtual serial console. So yeah, I don't know...


> For the lockup issue it might or might not be related to this. But it
> will be best if a crashdump is provided when the hang has occurred.

How do I trigger the crashdump for the hang? Maybe set one of these to 1?

kernel.hardlockup_panic =3D 0
kernel.hung_task_panic =3D 0
kernel.max_rcu_stall_to_panic =3D 0
kernel.panic_on_rcu_stall =3D 0

> Looking at the task call trace in
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1836995
> doesn't point at a hang. Just a bunch of threads waiting on IO in the
> metadata reclaim path.

Well it stayed that way for hours and never recovered, I couldn't ssh
in either. And in the most recent case there was an oops with the
submit_compressed_extent call trace.



--=20
Chris Murphy
