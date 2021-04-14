Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2909735F29A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350560AbhDNLdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350557AbhDNLc7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 07:32:59 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E87C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 04:32:38 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id m16so14487655qtx.9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LRy97ElrL1fzE9iMClEtWuXv6QEVy847yPlaxtePJII=;
        b=DNZjiW8C2ZyoNXZGpIAMlmAELb/UhM+HAwoTF5hc0jIvfurUTr7IcW3hDNvxjgCPvU
         UzQm0ZBPw22BIfNr/rF52gB3HsHysoDdYCJo6pggVe9Nx7+Sfs8lPDbkf+ai53boQSQN
         fvivuxoLFXF/Fww1rP1uFUKHsU667Qx7B4WBz31cg2hirOAAO293lkq9l0ytYnfHFA0n
         47WpoSnRrj9cngsLKLghDoWeh45VWsiTGTJsySRZD1zWJQxm590W7wUyewiJRQSFPuc5
         t6zrXFHLeWT8c0qDa7snDyUEx9vWDvrOCvk4BbWK5HeCDn20yy03a1/gC7sFZ+tGTPSk
         9sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LRy97ElrL1fzE9iMClEtWuXv6QEVy847yPlaxtePJII=;
        b=gC8Bt1mFbKUimLACHCbOjH0kJNfPTRVMP5A112BamNNwMLMpK0yWQiUPGaafa5xDDo
         KQ+M1STGCgw5GeaQq1q0Rv9OIiKbzYNSpkOpEqbb9xfFoiDiBqGDb/A88NloLzfy5JKF
         RjXSz+k+440BZGi7rPRTK3x/GPZdfd9r7GjtNBUF0R/MGbdiAyQYwTFRnqvrAjCQaujZ
         g+VtcLRw3ygIyAZ2B392Vn89xQGN9hz4yp7mik9hmdqEuY3AkUzxAkSej20DKqyP/dxZ
         1VmvX7/FVcvbE80iZSqWBGl3VSqr+DXwse+ETcSpuW4tNsS0gMJoQU225CYwL4RAM+E7
         6ZHA==
X-Gm-Message-State: AOAM532QZoiu5h+f02VNJqcv1BYxbmO5NCBA7N7ELFNncM4bqkchOHjI
        4/cYKTNX09+ugLibBOEtx60dAjx3u9jgy1yEP2s=
X-Google-Smtp-Source: ABdhPJzajL6KSz/sWOhEzWk5wu7cJZCsGuchK8152/O3DvddVbYxpAEhLlBT9Z2Y/t3OhTGFilpii4fYIZ1BGgtZmzQ=
X-Received: by 2002:ac8:5e8e:: with SMTP id r14mr23492858qtx.213.1618399957358;
 Wed, 14 Apr 2021 04:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
 <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5xZLhHrBPJb5jwe8ZxAv=XfFC05kcw5-WqBySQP4uTBg@mail.gmail.com>
 <PH0PR04MB74167FB19522DBEB1F70E80D9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H6Bgqkdf8Z+xRBH8C=XxtrGzXyNUf6BHaLw54LZb3Agsg@mail.gmail.com> <PH0PR04MB7416EE187963A0D7718D57979B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB7416EE187963A0D7718D57979B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 14 Apr 2021 12:32:26 +0100
Message-ID: <CAL3q7H5wPncus-e-pnNJBnkqNxmdsNcD-7rR4qLB6Rxo5dkvPA@mail.gmail.com>
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

On Wed, Apr 14, 2021 at 12:22 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 14/04/2021 13:17, Filipe Manana wrote:
> > Yep, that's what puzzled me, why the need to do it for non-zoned file
> > systems when using -o discard=3Dsync.
> > I assumed you ran into a case where discard was not happening due to
> > some bug bug in the extent pinning/unpinning mechanism.
> >
> >> So the correct fix would
> >> be to get the block group into the 'trans->transaction->deleted_bgs' l=
ist
> >> after relocation, which would work if we wouldn't check for block_grou=
p->ro in
> >> btrfs_delete_unused_bgs(), but I suppose this check is there for a rea=
son.
> >
> > Actually the check for ->ro does not make sense anymore since I
> > introduced the delete_unused_bgs_mutex in commit
> > 67c5e7d464bc466471b05e027abe8a6b29687ebd.
> >
> > When the ->ro check was added
> > (47ab2a6c689913db23ccae38349714edf8365e0a), it was meant to prevent
> > the cleaner kthread and relocation tasks from calling
> > btrfs_remove_chunk() concurrently, but checking for ->ro only was
> > buggy, hence the addition of delete_unused_bgs_mutex later.
> >
>
>
> I'll have a look at these commits.
>
>
> >>
> >> How about changing the patch to the following:
> >
> > Looks good.
> > However would just removing the ->ro check by enough as well?
>
> From how I understand the code, yes. It's a quick test, so let's just do =
it
> and see what breaks.

The thing most worth checking is if concurrent scrubs can cause any
issue with deletion of unused block groups.
I think they won't, but there were races in the past I remember fixing.

Several test cases from btrfs/060 to btrfs/074 exercise scrub running
with fsstress, balance, etc.
They are a good way to stress test this code.

>
> I'd prefer to just drop the ->ro check, it's less special casing for zone=
d
> btrfs that we have to keep in mind when changing things.
>
> Thanks for helping me with this,
>         Johannes



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
