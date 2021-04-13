Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7924835DF90
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Apr 2021 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbhDMM6L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Apr 2021 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbhDMM6J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Apr 2021 08:58:09 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C2C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Apr 2021 05:57:50 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id d23so5605435qko.12
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Apr 2021 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Oww2UiXHuonYwJSz8hnvu876cqcl0TemNHCrULCAy9c=;
        b=uOnej5PhUlZLVmA3UG+rv9kp1xCFcdfDqvxiBGpU2cV8AdYLNWS4ZhUOvS9x+KApan
         FvcYf7xXLcB6uNG66ekk7+UUt/Mun/Iwhz7DSvXLTlszSa58BXRU8Ue2lwvJtn9exQcQ
         LbWwZBv8e2BMsQcBQQT8MTQ6C+GrgHZqfdjq4pwvRqoc489aTiCqgR1cLpHRhlhZj8QW
         Ml8moGBO38/YFVVAlh3uaBIG4nH5OwOlTTYYM2yT5Xf7BdwetlTlLla8zghsA9QYuunf
         PPZt6wG36mNVllR/+NEzcHnKCrDvQ9fgaXFyNFJ9mBZw64Tg0zgr276WEvK/gG8kPg3S
         ZfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Oww2UiXHuonYwJSz8hnvu876cqcl0TemNHCrULCAy9c=;
        b=J8XIwa0oocmHOpVWVcb/YCHUp+/6+89tPa34jkaWitu1P296YqXrz7I+orCufqSqMy
         lFdwO0h7OmI2GAZ5fbOD0+qCtjs/UyA6Y9Y8NT5BkE2g3EBMSc1SeBgS+9JIURdkpCxM
         r0AMuPXhRXcyxSvdl/fGvP7lhwRgKl7RicYhU2NeYSFjHCJIlSN3UQShMI3BZgCLd1bU
         AEu03HN+iP6BtLgJDaAr/4indtm2+S1saW1Hr/Oqlf+GDlm43m1FkJI6mTcJ986Jq7u2
         lM9MA7hyyYY8YrW7FzasthDtZnqNP5SF08Z1p3A0M3blEXfokJiral7WH/+XG9DS2gI0
         CzDg==
X-Gm-Message-State: AOAM532gw+QBsTTq58nWfPzDpqTvkIn+vuxreBGAdZTK67qkjHzmf/eM
        negW/6iOhrrTR28G1Yaixih3AvBFk/JcZ5VBzLM=
X-Google-Smtp-Source: ABdhPJyuIdI1PO5W+ybWqRFLolUUJHTuS3v6HWQtHQhmsLvELEbZ5gbvq42VIGReJ/NI6rs+QEuX7TJRHfQYyly6uLk=
X-Received: by 2002:a05:620a:65d:: with SMTP id a29mr2651679qka.0.1618318669546;
 Tue, 13 Apr 2021 05:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
 <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 13 Apr 2021 13:57:38 +0100
Message-ID: <CAL3q7H5xZLhHrBPJb5jwe8ZxAv=XfFC05kcw5-WqBySQP4uTBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 13, 2021 at 1:44 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12/04/2021 16:21, Johannes Thumshirn wrote:
> >> If it affects only the zoned case, I also don't see why doing it when
> >> not in zoned mode (and -o discard=3Dsync is set).
> >> Unless of course the default discard mechanism is broken somehow, in
> >> which case we need to find out why and fix it.
> >
> > I'm at it.
> >
>
> OK I've found out what's wrong. In btrfs_relocate_block_group() we're cal=
ling
> btrfs_inc_block_group_ro(). btrfs_update_block_group() will call
> btrfs_mark_bg_unused() to add the block group to the 'fs_info->unused_bgs=
' list.
>
> But in btrfs_delete_unused_bgs() we have this check:
>                 if (block_group->reserved || block_group->pinned ||
>                     block_group->used || block_group->ro ||
>                     list_is_singular(&block_group->list)) {
>                         /*
>                          * We want to bail if we made new allocations or =
have
>                          * outstanding allocations in this block group.  =
We do
>                          * the ro check in case balance is currently acti=
ng on
>                          * this block group.
>                          */
>                         trace_btrfs_skip_unused_block_group(block_group);
>                         spin_unlock(&block_group->lock);
>                         up_write(&space_info->groups_sem);
>                         goto next;
>                 }
>
> So we're skipping over the removal of the block group. I've instrumented =
the
> kernel and also tested with non-zoned devices, this skip is always presen=
t
> with block_group->ro =3D 1.

Yep, expected, see below.

>
> Also the auto-relocation patch has a problem, not decrementing block_grou=
p->ro
> and so it's left at ro =3D 2 after auto relocation got triggered.
>
> So the question is, why are we leaving block_group->ro at 1 after relocat=
ion
> finished? Probably that the allocator doesn't pick the block group for th=
e next
> allocation.

Yes. Otherwise after relocating (or even during relocation), a task
allocates an extent from the block group, and then blindly after we
delete the block group - this would be racy and cause corruption.

>
> What am I missing?

And what about the other mechanism that triggers discards on pinned
extents, after the transaction commits the super blocks?
Why isn't that happening (with -o discard=3Dsync)? We create the delayed
references to drop extents from the relocated block group, which
results in pinning extents.
This is the case that surprised me that it isn't working for you.

Thanks.

>
> Thanks,
>         Johannes



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
