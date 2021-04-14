Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C4B35F47D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 15:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351104AbhDNNHB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 09:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232933AbhDNNGx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:06:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 573B561176
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618405591;
        bh=tOCLBciEoxenLAsp6LJqigbsCLcZjMC4kmIAQaO+P9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DvA3aDw8jPzvPRx8N8Sdha4IEHtBUE05EVujD5OSC87zh1qwPF2/ceR3lZuap727G
         IH0wRv8hvEeB9nQctluxaAkD9WSs1gtsLITbJ1XxvSJ/x7jpvJujopJL8zvz4UZfMY
         0TTdxrxPRVBbqThus5Sg2uqsIxxr7ZhIwaHXbIY0uZbdqMmkEWBiEiL1+08QScxOOE
         rvphX0y5Gi5eptG/37Iz7sdipggGENvyfZrX+yjLGZF5NoWjok8tSokjATDqTDf6gU
         Tf5VHFjgWFVyrQwVMKy8/6EK3O2y08j0X5mFpIk6Y3KSepRPd48OPne0awdAROb6DQ
         pv/vI1P/QAvPw==
Received: by mail-qk1-f172.google.com with SMTP id q136so337095qka.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 06:06:31 -0700 (PDT)
X-Gm-Message-State: AOAM5316IDCnkq++DyTnDl1o1ENfWycMqMJlhcTIIwzsPwuaX0BbGJZp
        hja/fSHhzpXtMJqYuG4ZFj4fQVF7wtCEK1/OjX4=
X-Google-Smtp-Source: ABdhPJx/qiy53+R8Rvhv/Yxr+KXyHi+di1Ic5mPM268bv18mtv59aN1qDXcfBds05raju6T7eRh6u1dpyb12Wu5Ohm8=
X-Received: by 2002:a05:620a:65d:: with SMTP id a29mr7850873qka.0.1618405590471;
 Wed, 14 Apr 2021 06:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <a76c376dfb6b391b96986c03664ecb657a24b012.1618402032.git.fdmanana@suse.com>
 <PH0PR04MB74163160735912B977C1E0C79B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB74163160735912B977C1E0C79B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 14 Apr 2021 14:06:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H78f7rdYv0i_QBkrvV9ZCsCOde=KcUAkUucoWTb5MNNoQ@mail.gmail.com>
Message-ID: <CAL3q7H78f7rdYv0i_QBkrvV9ZCsCOde=KcUAkUucoWTb5MNNoQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: fix unpaired block group unfreeze during
 device replace
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 14, 2021 at 1:35 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 14/04/2021 14:09, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When doing a device replace on a zoned filesystem, if we find a block
> > group with ->to_copy == 0, we jump to the label 'done', which will result
> > in later calling btrfs_unfreeze_block_group(), even though at this point
> > we never called btrfs_freeze_block_group().
> >
> > Since at this point we have neither turned the block group to RO mode nor
> > made any progress, we don't need to jump to the label 'done'. So fix this
> > by jumping instead to the label 'skip' and dropping our reference on the
> > block group before the jump.
> >
> > Fixes: 78ce9fc269af6e ("btrfs: zoned: mark block groups to copy for device-replace")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/scrub.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index 17e49caad1f9..e0d54ed9acee 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -3674,8 +3674,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
> >                       spin_lock(&cache->lock);
> >                       if (!cache->to_copy) {
> >                               spin_unlock(&cache->lock);
> > -                             ro_set = 0;
> > -                             goto done;
> > +                             btrfs_put_block_group(cache);
> > +                             goto skip;
> >                       }
> >                       spin_unlock(&cache->lock);
> >               }
> >
>
> I think we can remove the 'done' label as well, as after this patch it is
> unused (at least on my clone of misc-next).

Indeed, I missed that.
Removed in v2, thanks.

>
> Otherwise,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
