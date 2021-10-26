Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0307643B2B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhJZMyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbhJZMx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 08:53:57 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836FC061348
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 05:51:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i65so33839542ybb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FLK0n229WLfn8hbOs0oujaX7mffABn71K/sCjQZ17l4=;
        b=zm/LfX3DjgEkvQ+9MylPlpX/WCQVNEjFMEzlmLR9Og/6Hb9ap7R17havy+aULVfSqJ
         BVsiPYfCJQbNWzT1/3w2xgVFczR3c8FxUjbnpvZY/u2uovOyBCHBDuQ62VzmLmJyQNxp
         Rw1Yqp2Qc6k6Wy0gpMswEHvhC+etkw/CXomKuARbiDBTl3n3iWDiFMOz82lpOHHjUBHU
         TsMZxNCtUWEFU6qYVqmU6lYV+D4zJEpF8z4kfQyddAIOEEI0oFuPM68LgzCfVUhPTHal
         f4fE61Z6oVtsNpATKoJvGCcstS3LRZajHcGfvzuiyEbOk1FJ/2FwJVWQ+tK7uBmdoBUM
         W8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FLK0n229WLfn8hbOs0oujaX7mffABn71K/sCjQZ17l4=;
        b=CXbnz2AJaOwxLo6KA+NcQgAP9/A1AV0fwq5wh0apwwt17i5lS0JGlIuL5vkakPtv8g
         mSTzfNBMHsTzP+jCq6FZ6BWK+dpmftvYEJiBGp1yl/1/kLBnzDBdtDqg1h9D+nKSLDoQ
         KBmoIKF2KIhmpnSaPtUUJevQc2JpKY0uyefZzWEPYOIX3Gj3kxuKeepdvIf9mcH1Jzcv
         V9YlI/TtAPb1kACGHeqnsVMX6tjqe48zs0K/LNMyRhO/7NK/I/fVzFvHn0/awM0+gXFy
         sv4ThkypsTC98uh21F1lZhzYLFuLrwdGSBm9fdJAGzg1SRj3sCmZYaZ3yQyt+8o3LYVr
         tlVw==
X-Gm-Message-State: AOAM533UJ0W/zjiioHmHF70bzDUl8TI0JRUWJkknGSJPVjKTzJxTxHgI
        2XEE2d8fMmCNOMeIMjorBnE8z2+6kQOaWKxO/XwvGA==
X-Google-Smtp-Source: ABdhPJyYmb99FUP6eNWdTVNzU2M//tlLaIh5LxSsZC7HHtt8wIPDecz+UOC9mowWZCAO7H7hL4QuY5TItkB9T5bP0D0=
X-Received: by 2002:a05:6902:102f:: with SMTP id x15mr22518293ybt.341.1635252692826;
 Tue, 26 Oct 2021 05:51:32 -0700 (PDT)
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
Date:   Tue, 26 Oct 2021 08:51:16 -0400
Message-ID: <CAJCQCtSrSHrNKV-HKRS0vy0T0ZrL5GR_BqpbG4iMNZZ66PJN5g@mail.gmail.com>
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
>
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

Couple typos: '=D0=B2=D1=80=D0=B8=D1=82=D0=B5=D1=81' looks like keyboard la=
yout hiccup and should be
'writes'; and 5.4.10 should be 5.14.10 (I'm betting all the tea in
China that upstream isn't asking me to test a patch on a two year old
kernel).

Unfortunately the test we have is non-automated, it's "install this
package set" and wait. It always hangs, usually recovers without an
oops, but sometimes there's an oops. So it's pretty tedious to test it
with the "testcase" we currently have. I'd like a better one that
triggers this faster, but more importantly would be a reliable one.
We'll do our best though. Thanks!

--=20
Chris Murphy
