Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2594342DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 03:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJTB2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 21:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJTB2F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 21:28:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62961C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 18:25:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s64so11480143yba.11
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 18:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyQSDbYQrKLzzgMPY+e1uHSsP4pG/LPWvGmbDKrDCuw=;
        b=6h0f12ZomJ875jlGltHkPQzKvVK8GaacJ9PN8pyU+S1x3/+YQ+GpJHHgbwHCXkTzBE
         WC1JWcg1labD+v+zc1fNpuME3NRLKI5390yK6hghqvu3EcqvQ7ESYfgOj2UlPqdHh6J1
         QHcYSJnEBvPr0Wa3xUTMm7F5H7rDtFL18r2pP+bHqVsKeQA0I8xxeuKsKvpwqESKwo0a
         mXctSxSXi3hmpDZqC7D91sf3JeGAQmEisunV51q30DjLbOKyA3TmUoWT9UKuXDEfH602
         FpkXhXdqqB0v90e7TEPbpM2sgLJ+780DGglHSgUZWUx5DLu4Y1F8L4TkHclglgniOEe6
         ESHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyQSDbYQrKLzzgMPY+e1uHSsP4pG/LPWvGmbDKrDCuw=;
        b=rEqIpnH43FB4HDWBzDbjE998K2VdDI0nfnLy6gMdbDWvwn2/Cypt+CQ9SSkg+847az
         OTTLz9AxSf4jvH86VCOd0EpBEO1BZmbF2xtj/d7qARgwvesqpqk6YnalhP6fJlSQRC/r
         eFxHeH6wCmay9gOIX/SCtnUOVtM471grXfZ6sWEscBV4kYFylW1X5nMBWeQS35da+XjV
         hR+tpw0H2tshUVf0MwblYv+c4ndG4jJdRpuxm6mQknPj4VKq+DaxeMfwrXJz8USrqNcV
         6LGruY1pHwS1QPrVUxj1qAv1LmSoo09ezkmV32+9YeEEQeqhSVhSH4Sot0trpP3zWSoj
         EVJA==
X-Gm-Message-State: AOAM532V/IGpjerxu7WKFqMVZQx6cGzMNYxdykVKpSbhDV1FYW886tA0
        R91yPRjnYwFzg4knMOxxP7CJWkVkCokuPXWMq75COStlVYG3LoNO
X-Google-Smtp-Source: ABdhPJww+370h51T744JT021Lqr4ZLq4DXJJCHYTYXCv0b4P3LwWME8cBDii5FrZ3jiRis2fUvz52MVbt9SoX0l9U+4=
X-Received: by 2002:a25:db91:: with SMTP id g139mr38191257ybf.391.1634693150307;
 Tue, 19 Oct 2021 18:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
In-Reply-To: <35owijrm.fsf@damenly.su>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 19 Oct 2021 21:25:34 -0400
Message-ID: <CAJCQCtRCN0nXP=MMpeKmF0n94pK+PkhKNn=U_EFfb_NDFiVpEA@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Su Yue <l@damenly.su>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 9:10 PM Su Yue <l@damenly.su> wrote:
>
>
> On Tue 19 Oct 2021 at 14:26, Chris Murphy
> <lists@colorremedies.com> wrote:
>
> > Still working on the kernel core dump and should have something
> > soon
> > (I blew up the VM and had to start over); should I run the
> > 'crash'
> > command on it afterward? Or upload the dump file to e.g. google
> > drive?
> >
> Dump file and vmlinu[zx] kernel file are needed.
>
> > Also, I came across this ext4 issue happening on aarch64
> > (openstack
> > too), but I have no idea if it's related. And if so, whether it
> > means
> > there's a common problem outside of btrfs?
> > https://github.com/coreos/fedora-coreos-tracker/issues/965
> >
> Already noticed the thing. Let's wait for the vmcore.
>
> Any idea, Qu?
>

So it's been compiling for multiple hours while also doing a large
package installation at the same time for about an hour of that time,
and still no oops or kernel messages...


-- 
Chris Murphy
