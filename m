Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6814821305F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 02:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGCAKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 20:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCAKG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 20:10:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44111C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 17:10:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y2so30801798ioy.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wEsZLGXLqLq8N2Gz9pYo/zJ/1T7uihenCmZsS4aMJmY=;
        b=sB13O6uh7cpnA8KfRg0QE6o4OM2UDdHcUJ9UkAQCEmR0WLI2q7LeoLbcMCxCzCedto
         PZEF3/QvHkg2Km4J1ftKhoO6KAdnxUC5TYg6MAVl+dXMNTJcnQ310oKap3jHcNr95Sbq
         Qh6+8y2G9kkjE8Is3z94hFwWEdHNHaJWTHSqxU8PTaxsVQ4GRVRHGLbu+F0iA5P04v2i
         NLTsjmmUqqCw3VVLPDMroE67OhZzTstpb3AW612d8YFXB08a+C/QplpYbdMVj/o37ilO
         hqGAPE+nOUsfJvkaf/VZScyNu1TLX/6gPkdHKm4hKEao5IcrsIRmfIIIusL2/jAn/Ymp
         HC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wEsZLGXLqLq8N2Gz9pYo/zJ/1T7uihenCmZsS4aMJmY=;
        b=gPH7dMDnULuH9KHOfd0CtOXA3vQ66ChGt6pnY1hR1JFrq2Lt+LgaoK4Yx2Ly9xoKbc
         2gAnOVKGNT3WOi4MwrNEbdJgMnQPc0HDqmvcQOUZF3KV3zJgaV5tOMjPzUnHhRabyhe5
         PruDueqwyiUi7d/UCMOw0z0/w/9mMUIMbqeQeZExMo++l21wULeQ7nFuqXE0b+QICSSA
         J6bAAxl07qlywA3inS5YucHAC97pnawfYSmas4AQfRirk6OJBysuJBxlqM7xb/VKiUJT
         rvDlsw96m13aa15/UL/9PsRTfuavtiFRA891m0iVKhADF+XGs686bMrDT1RdsBObQkCF
         mR1g==
X-Gm-Message-State: AOAM5329EFt68uj3rYQPmkRqjgZryNpYF4s9N9EBL0aKUjj2/Z6AffXH
        +fyogoCVg65J3kQL0e5IVCtGWacrrFtMMLxil4Q=
X-Google-Smtp-Source: ABdhPJwPtLWTRK8yX18xLa2Pmmza1BTrlglREmQv+EQqLfqAKji+xlO0JAD0J/9L+VeO4p8CFnfIA4oQDjXlsDt7IHo=
X-Received: by 2002:a6b:3b46:: with SMTP id i67mr9697199ioa.205.1593735004620;
 Thu, 02 Jul 2020 17:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200701144438.7613-1-josef@toxicpanda.com> <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com> <e0294251-606e-b08f-6df7-20a225de8630@gmx.com>
 <2630e0b0-00a4-6258-f253-cbc6f0fb9847@toxicpanda.com> <8e14c765-dad1-1bbb-b856-afcd4ffc0731@gmx.com>
In-Reply-To: <8e14c765-dad1-1bbb-b856-afcd4ffc0731@gmx.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 2 Jul 2020 20:09:28 -0400
Message-ID: <CAEg-Je_8XPOCHAvrQECEYrz_Q3VGr4o=zVQ20j+M1dvmfweFew@mail.gmail.com>
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, waxhead@dirtcellar.net,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 2, 2020 at 7:38 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/7/2 =E4=B8=8B=E5=8D=8811:28, Josef Bacik wrote:
> > On 7/1/20 11:09 PM, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/7/2 =E4=B8=8A=E5=8D=883:53, Josef Bacik wrote:
> >>> On 7/1/20 3:43 PM, waxhead wrote:
> >>>>
> >>>>
> >>>> Josef Bacik wrote:
> >>>>> One of the things that came up consistently in talking with Fedora
> >>>>> about
> >>>>> switching to btrfs as default is that btrfs is particularly vulnera=
ble
> >>>>> to metadata corruption.  If any of the core global roots are
> >>>>> corrupted,
> >>>>> the fs is unmountable and fsck can't usually do anything for you
> >>>>> without
> >>>>> some special options.
> >>>>>
> >>>>> Qu addressed this sort of with rescue=3Dskipbg, but that's poorly
> >>>>> named as
> >>>>> what it really does is just allow you to operate without an extent
> >>>>> root.
> >>>>> However there are a lot of other roots, and I'd rather not have to =
do
> >>>>>
> >>>>> mount -o
> >>>>> rescue=3Dskipbg,rescue=3Dnocsum,rescue=3Dnofreespacetree,rescue=3Db=
lah
> >>>>>
> >>>>> Instead take his original idea and modify it so it just works for
> >>>>> everything.  Turn it into rescue=3Donlyfs, and then any major root =
we
> >>>>> fail
> >>>>> to read just gets left empty and we carry on.
> >>>>>
> >>>>> Obviously if the fs roots are screwed then the user is in trouble, =
but
> >>>>> otherwise this makes it much easier to pull stuff off the disk with=
out
> >>>>> needing our special rescue tools.  I tested this with my TEST_DEV t=
hat
> >>>>> had a bunch of data on it by corrupting the csum tree and then read=
ing
> >>>>> files off the disk.
> >>>>>
> >>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >>>>> ---
> >>>>
> >>>> Just an idea inspired from RAID1c3 and RAID1c3, how about introducin=
g
> >>>> DUP2 and/or even DUP3 making multiple copies of the metadata to
> >>>> increase the chance to recover metadata on even a single storage
> >>>> device?
> >>>
> >>> Because this only works on HDD.  On SSD's concurrent writes will ofte=
n
> >>> be shunted to the same erase block, and if the whole erase block goes=
,
> >>> so do all of your copies.  This is why we default to 'single' for SSD=
's.
> >>>
> >>> The one thing I _do_ want to do is make better use of the backup root=
s.
> >>> Right now we always free the pinned extents once the transaction
> >>> commits, which makes the backup roots useless as we're likely to re-u=
se
> >>> those blocks.
> >>
> >> IIRC Filipe tried this before and didn't go that direction due to ENOS=
PC.
> >> As we need to commit multiple transactions to free the pinned extents.
> >>
> >> But maybe the latest async pinned extent drop could solve the problem?
> >>
> >
> > Yeah before it was tricky, but with Nikolay's work it made async pinned
> > extent drop possible, I've been testing that patch internally.
> >
> > Now it's just a matter of keeping the last 4 transactions worth of
> > pinned around and only unpinning under enospc conditions.  I'll dig out
> > the async unpinning and send that up next week since that's already
> > valuable by itself, and then we can talk about wiring up the ENOSPC par=
t
> > of it.  Thanks,
>
> That's really awesome, let make btrfs the most bullet proof fs then!
>

Woohoo, yes! Go! =F0=9F=92=AA


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
