Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6164364D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 16:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJUO6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJUO6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 10:58:12 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C91CC0613B9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 07:55:56 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id o134so814073ybc.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fGSUOs6qx66HX8N8/YvakFivM4ONE5oac9MBEj2RmaY=;
        b=R443o0f80dAbn5IEFG/5bWYJYO+6P2K52VrEcJ8EPyo5oMiUmvDMMwmNM7/GPvQekA
         +Su47e03OMmEwMgC/TDuacBVSSe+o/pz5p42U8dLdMhgq3IdjPzFh394uMt8/8NqkBDQ
         t6QqgNacKzByFivVQHff2ym/oOsETm3Nx+sDANzA2zp6EyA9JKu8ocDeCZAlvLou3cMJ
         vvvJEh5O+Vpyarc/pLRwj74IfcHM9cTVXqoiSaRo3l2y31m0N22tKX6ePJHuGBF8ERkq
         96E+DlgQaUQne/z+Tf2UUN69qy21LflUyr+T2zfOyZR7WUDjg2DbZl8PfO+yb7n54MpU
         GrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fGSUOs6qx66HX8N8/YvakFivM4ONE5oac9MBEj2RmaY=;
        b=tDIKORXJcMjZRjXrp0D7eAh1wNGZC3o/terknGlVstHrLv7NSOM3mJYKonYE6dhdF5
         r4iJpODAU7BUwjNsdiODGP2GIdmpvquFoitWa3NGjM/+Cu/j0Bg1wJu++QUz8UjXkwHG
         R6LWQqObpjxWup9enK+Vhg4q4SpiKJirFSjFIRTpVY+F1wSGf4h3cUw+RtZDUgJIVO4v
         8LGeGjO8LyInrYVEt+CYvNUveVjLvrEnQ0TOfPuVCwC1mcPw/zbnZti0j9HNrdmX+dCt
         Xic6ZUdXZmI1SKLpGU7J0jiO+3gyhOT3Va6ZhOLRNFHGlPNoJVW8AUq+SHLc31kyFVTG
         lvOw==
X-Gm-Message-State: AOAM5326oYda7DisQaQCs1PXazV2JV2f9q1QE1qhxJvuCnj2aI+fAIu8
        ISn/5aEHJLSrOfJMTURJ6Su8wVWaLDvd6ufrLxiUBQ==
X-Google-Smtp-Source: ABdhPJzLAp/v1C2g5kkMkcync3ABm47Vh+I4jai0W34Vx1m0L6s+DRE98fudGva/SE5T7gJKpnvDLnkstJ99FsPTLAk=
X-Received: by 2002:a25:db91:: with SMTP id g139mr6183415ybf.391.1634828155567;
 Thu, 21 Oct 2021 07:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
 <y26ngqqg.fsf@damenly.su> <CAJCQCtScczmps7+NfNEObqOnsU64QHhjRRy0Fmj7W8z=ZJNK0g@mail.gmail.com>
 <CAJCQCtQuuzrzLDDZZ0jExeZ6RbDXH3wF7WFq02W77REMn4YJNA@mail.gmail.com> <2e18d933-a56e-198d-20c8-ab3038d3f390@suse.com>
In-Reply-To: <2e18d933-a56e-198d-20c8-ab3038d3f390@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 21 Oct 2021 10:55:39 -0400
Message-ID: <CAJCQCtQ+23cQCZQrwPO7Yq1G48yEoUT2CbLH9GdytP6zYXux3g@mail.gmail.com>
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

On Thu, Oct 21, 2021 at 10:51 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 21.10.21 =D0=B3. 17:48, Chris Murphy wrote:
> > [  287.139760] Call trace:
> > [  287.141784]  submit_compressed_extents+0x38/0x3d0
> > [  287.145620]  async_cow_submit+0x50/0xd0
> > [  287.148801]  run_ordered_work+0xc8/0x280
> > [  287.152005]  btrfs_work_helper+0x98/0x250
> > [  287.155450]  process_one_work+0x1f0/0x4ac
> > [  287.161577]  worker_thread+0x188/0x504
> > [  287.167461]  kthread+0x110/0x114
> > [  287.172872]  ret_from_fork+0x10/0x18
> > [  287.178558] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356)
> > [  287.186268] ---[ end trace 41ec405ced3786b6 ]---
> > [61620.974232] audit: audit_backlog=3D2976 > audit_backlog_limit=3D64
> > [61620.978698] audit: audit_lost=3D1 audit_rate_limit=3D0 audit_backlog=
_limit=3D64
> >
> >
> > So it's at least 17 hours later since the splat. Is it worth sysrq+c
> > now this long after? Or should I set it up like Nikolay suggests with
> > kernel.panic_on_warn =3D 1? Maybe I should also put /var/crash on XFS t=
o
> > avoid problems dumping the kernel core file?
>
> Doing sysrq+c would not have yileded any useful information it was a red
> herring. In order to have actionable information the core dump needs to
> be initiated from offending context, this means either having a BUG_ON
> or a WARN which triggers the panic.


OK so I'll put /var/crash on XFS and set kernel.panic_on_warn =3D 1 and
try to reproduce the problem; and hopefully that triggers kdump.


--=20
Chris Murphy
