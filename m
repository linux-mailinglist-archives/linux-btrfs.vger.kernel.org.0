Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D443D09B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 20:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbhJ0SYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbhJ0SYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 14:24:46 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC88C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 11:22:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o12so8642186ybk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c+F0ZGgrPiKcn5WZjwvPaar6kcqrTfl+FC5ERj25P+E=;
        b=fq0YwPi2Kn1aWKrixIPOWF8bfEOP+yR+oj/Tn6XRKz1f9CJluCF2GkB76YF+GtZ1ok
         HNCwCL8HDWAEVUdoA3IA8ietkx+MlQFyj4oZHePKn7Kw1sde9/rfBGHYVt/+HoHqr8Nf
         Fd9gvs68+4/9U79IYNEbvoiLCETB33TqZRUw14ZHx6iE8tGjRfW91LKaB3lsx7nVLmeK
         8UX81+ASjEcUSxFMK/DSzcz//2ZLrpMIUVYUxSmwx335E2nwG27gfBwEPgjrj5kdf5Qn
         bB4rWFcvLmoj0Yc9wadCil/4OZi/wV4XuYSztDvB9t4RrGOPQbJCXCG1kjqnuMo19UdB
         OEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c+F0ZGgrPiKcn5WZjwvPaar6kcqrTfl+FC5ERj25P+E=;
        b=6f9MNZaWg1o+71cnJ33ACiq0XFh8/uwlOcJliOACU/32yBRA7HYupDyd/3D3R5TE+0
         witaXKpsWHfYXHeFY3VNIVybVYq5lWf5DfpLbnI0V+kvqLRSdMlD1YeZtI3n3UQOCJh9
         hK1Nnj9Xe0o5JFvzlfTTVP93IADQgNfjbTkQ4FCJBLXx5q2n1Gb8cIaeccbQeAcnCLNX
         Mrbw0o+F0lcfal2wj+/soeZy2KRbHsZ3O+nxZJSZbkUak3CMppqfvo7BUjfmwUHXl2DG
         4DUXlVMAlhMymHxjIbdFYlCsmmH0xSEeijru/3m47KpOuZFJWCoi6MKjSAQSrBD9/1xe
         NoZA==
X-Gm-Message-State: AOAM532BcuiM1A/1JJhlQHHMODPtklzz4BmP5EJme5jmessVVu650nRE
        byQDt8Wg/DXXL7nwLJOwB8HihSlvOBfTf2knagMeEw==
X-Google-Smtp-Source: ABdhPJxb7Wxtk0NW2JrBs+sMHnK7fRByseW8YKCL3C4ziE/nYZX4aGNSJesg1RP1EAp6dX0PAMMuuLkl0+OZ8m+emP4=
X-Received: by 2002:a25:ce93:: with SMTP id x141mr5986208ybe.341.1635358940468;
 Wed, 27 Oct 2021 11:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com> <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
 <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com> <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
 <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
 <CAJCQCtQ0_iAyC8Tc8OZyf2JGGnboXm8zk9itZaOLAoK=w1qdrg@mail.gmail.com> <b03fb30f-3d4b-413c-0227-6655ffeba75d@suse.com>
In-Reply-To: <b03fb30f-3d4b-413c-0227-6655ffeba75d@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 Oct 2021 14:22:04 -0400
Message-ID: <CAJCQCtQT22cdBPZ+d03m8c_sCtdVaM_Oz705T37v2XPx26SWFg@mail.gmail.com>
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

On Tue, Oct 26, 2021 at 3:14 AM Nikolay Borisov <nborisov@suse.com> wrote:

> I think I identified a race that could cause the crash, can you apply the
> following diff and re-run the tests and leave them for a couple of days.
> Preferably apply it on 5.4.10 so that there is the highest chance to repr=
oduce:
>
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index 309516e6a968..a3d788dcbd34 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -234,6 +234,11 @@ static void run_ordered_work(struct __btrfs_workqueu=
e *wq,
>                                   ordered_list);
>                 if (!test_bit(WORK_DONE_BIT, &work->flags))
>                         break;
> +               /*
> +                * Orders all subsequent loads after WORK_DONE_BIT, paire=
d with
> +                * the smp_mb__before_atomic in btrfs_work_helper
> +                */
> +               smp_rmb();
>
>                 /*
>                  * we are going to call the ordered done function, but
> @@ -317,6 +322,12 @@ static void btrfs_work_helper(struct work_struct *no=
rmal_work)
>         thresh_exec_hook(wq);
>         work->func(work);
>         if (need_order) {
> +               /*
> +                * Ensures all =D0=B2=D1=80=D0=B8=D1=82=D0=B5=D1=81 done =
in ->func are ordered before
> +                * setting the WORK_DONE_BIT making them visible to order=
ed
> +                * func
> +                */
> +               smp_mb__before_atomic();
>                 set_bit(WORK_DONE_BIT, &work->flags);
>                 run_ordered_work(wq, work);
>         } else {
>

So far this appears to be working well - thanks!
https://bugzilla.redhat.com/show_bug.cgi?id=3D2011928#c54


--
Chris Murphy
