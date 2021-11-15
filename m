Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE38B45157D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 21:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351121AbhKOUjc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 15:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbhKOTYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 14:24:02 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6057EC08889D
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 10:29:38 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id y5so18939456ual.7
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 10:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PnDdrevb9nSGUmL3gzNwkVQJn/IV+cjKA0jm/JvfUoI=;
        b=QfpImCTHcEedabi7Twm+iNpK61zb8q6hr4z1JK5deq3zx8cbhQv5HbX6KLuAzg7CAr
         c+6n+Fsf+VSxXxHzAfubwrsj9zYLyZ9tlwykpzeVGke8tDb6bvJYdNgQwD3lc11F1sMY
         VewmOpW9He7n2MP8KPpLPmneHTBtIKv3Hj2x8Aw263ucMMOaOWtLL/4Ngj12zBXRBVVn
         DN1IZ3NcbiW2fmicJy+6dtwlFKpgICe+Jikd7adXo3sOymF7y22IVG3lVNLERB3sc5m6
         RejSPNE0+6dbySBzmfYStcNUA8giWRs+igPuY1p25i2B9NpD70qHX1zBXR8QC6Bn1umT
         DHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PnDdrevb9nSGUmL3gzNwkVQJn/IV+cjKA0jm/JvfUoI=;
        b=bB2m+7EQwfIr7Db3gCXWwSoO/0CgeaKqLOv4jvx4EZ/xTk1PQ1BPqOPAEINaaUL+YD
         8qODQLq9iMhJD9BkezLWFSrZ28l8iNrsZ6+xhD3nESpchhjMYrOWwGjxKZHs5uWKsIGy
         qxoOiONBi++jqFUSKIUmH3daVK4LePC3Sp0JP598lN66tmUQqFUV6XUBp+nk+OIk+WpZ
         kT+8zx0lExnvNLL2rfp1LTK7hg1s8oKBtDl+fgTZHDIl/JKMi9aVovYfAK7bAQ3MT7C8
         43nzOnzEHJVEU5/bbqBY8z79eWa7pisdQ64K6CI5ZRS8DVU/K7zajoNsgZRTgX6KnOrl
         5n4Q==
X-Gm-Message-State: AOAM530Q0vf7usp5/cWwfB0RCstmKRMwosOtFxeDA6CTPbXkO/vOUFY3
        6At8pfiTl4DA13qjGL0AMYQwLGBOZVASsNqhPLzBvJ+wVSQ=
X-Google-Smtp-Source: ABdhPJyYe4AQDX86qjCT+GGIxqCXOyhySSJDS/+XhvYf28XSMLwj4I6YW127HfcPgO1ITWab/NGLfLR2jwHSMaZ6dbg=
X-Received: by 2002:a05:6130:305:: with SMTP id ay5mr1291128uab.73.1637000977360;
 Mon, 15 Nov 2021 10:29:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSh2WT3fijK4sYEdfYpp09ehA+SA75rLyiJ6guUtyWjyw@mail.gmail.com>
 <CAJCQCtQ=JsO6bH=vJE2aZDS_7FDq+y-yHFVm4NTaf7QLArWGAw@mail.gmail.com>
 <9f7d7997-b1a1-9c4f-8e2f-56e28a54c8c6@suse.com> <CAJCQCtQ4JwAD8Nw-mHWxoXtJT7m0d-d+gi23_JgU=C8dvTtEOA@mail.gmail.com>
 <41cabdcf-894f-353b-0c9d-98635b26fe30@suse.com>
In-Reply-To: <41cabdcf-894f-353b-0c9d-98635b26fe30@suse.com>
From:   Omar Sandoval <osandov@osandov.com>
Date:   Mon, 15 Nov 2021 10:29:26 -0800
Message-ID: <CAB+W2CxYcbZFWepm-9145bUGwFq8daxu64u6rdWdsrSG0U03yA@mail.gmail.com>
Subject: Re: 5.15+, blocked tasks, folio_wait_bit_common
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 08:46:43PM +0200, Nikolay Borisov wrote:
> [CC'ing Omar as Kyber is mentioned]
>
> On 12.11.21 =D0=B3. 20:06, Chris Murphy wrote:
> > On Fri, Nov 12, 2021 at 1:55 AM Nikolay Borisov <nborisov@suse.com> wro=
te:
> >>
> >>
> >>
> >> On 11.11.21 =D0=B3. 22:57, Chris Murphy wrote:
> >>> On Thu, Nov 11, 2021 at 3:24 PM Chris Murphy <lists@colorremedies.com=
> wrote:
> >>>>
> >>>> Soon after logging in and launching some apps, I get a hang. Althoug=
h
> >>>> there's lots of btrfs stuff in the call traces, I think we're stuck =
in
> >>>> writeback so everything else just piles up and it all hangs
> >>>> indefinitely.
> >>>>
> >>>> Happening since at least
> >>>> 5.16.0-0.rc0.20211109gitd2f38a3c6507.9.fc36.x86_64 and is still happ=
ening with
> >>>> 5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64
> >>>>
> >>>> Full dmesg including sysrq+w when the journal becomes unresponsive a=
nd
> >>>> then a bunch of block tasks  > 120s roll in on their own.
> >>>>
> >>>> https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1841283
> >>>
> >>
> >>
> >> The btrfs traces in this one doesn't look interesting, what's
> >> interesting is you have a bunch of tasks, including btrfs transaction
> >> commit which are stuck waiting to get a tag from the underlying block
> >> device - blk_mq_get_tag function. This indicates something's going on
> >> with the underlying block device.
> >
> > Well the hang doesn't ever happen with 5.14.x or 5.15.x kernels, only
> > the misc-next (Fedora rc0) kernels. And also I just discovered that
> > it's not happening (or not as quickly) with IO scheduler none. I've
> > been using kyber and when I switch back to it, the hang happens almost
> > immediately.
>
> Well I see a bunch of WARN_ONs being triggered, so is it possible that
> this is some issue which is going to be fixed in some future RC ? Omar
> what steps should be taken to try and debug this from the Kyber side of
> things?

Chris, does this happen on upstream 5.16-rc1? I couldn't reproduce it.
