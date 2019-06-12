Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615E2427AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfFLNeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 09:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfFLNeT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 09:34:19 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A3120866
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560346459;
        bh=apD2io9kx0KukrTznB3uyqAj/V2LOTivfJxd1ap+sNk=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=pQaSuxhUWNoatm/5DPfLsPhqI6/qAjFgsVCY3pkii3imYJC4iEJ2+FyoA8Y5iMJwQ
         MQvni/I4w8PauCilQsyGY7QvXMl2ptz8Sxt6b4EReZloujlUPlQANMI+p8T4jpwnm1
         Hhfa02Zx4oZMBpafeaCsm83Go48hYjcUc7WNSpdo=
Received: by mail-vs1-f52.google.com with SMTP id v6so10242804vsq.4
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 06:34:18 -0700 (PDT)
X-Gm-Message-State: APjAAAXOHmzD7NFuyB4yB3G7VeOBWibHTknj863tysoUERB3Avms/VG9
        b+P5z/vQSbmhHGf92UTrEKWPdAuTMdlMkLdpzY0=
X-Google-Smtp-Source: APXvYqxCMAgZw4RdKZwCrUnt132WAhAwpppahU3rGHHipIcwCeviSEciHFaD3el++gzzOePryRhDvwXa9L2CHRJM4ak=
X-Received: by 2002:a67:de08:: with SMTP id q8mr26318938vsk.206.1560346458119;
 Wed, 12 Jun 2019 06:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190612100542.1848-1-fdmanana@kernel.org> <20190612132301.GI3563@twin.jikos.cz>
In-Reply-To: <20190612132301.GI3563@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 12 Jun 2019 14:34:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H609xx4j4mJXjTfC2Bo-6S1Lua+rHS=LPkET=y=X=VbjQ@mail.gmail.com>
Message-ID: <CAL3q7H609xx4j4mJXjTfC2Bo-6S1Lua+rHS=LPkET=y=X=VbjQ@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix race between block group removal and block
 group allocation
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 2:22 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jun 12, 2019 at 11:05:42AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
>
> > Fixes: 04216820fe83d5 ("Btrfs: fix race between fs trimming and block group remove/allocation")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> > NOTE: this applies only to a 5.2 kernel, although the problem exists in previous
> >       kernels starting from 3.19, due to recent changes in the 5.2 merge window
> >       that removed the fs_info->pending_chunks, a slightly different version of
> >       this patch is needed, one which locks and unlocks the chunk mutex inside
> >       the moved block.
>
> Thanks, I'll add it to misc-5.2, the type of the fix qualifies for a
> late rc, so I'll send it by the end of the week.
>
>
> >       Such patch version can be found here:
> >
> >       https://www.dropbox.com/s/1sv0hd2xbsn9jrt/Btrfs-fix-race-between-block-group-removal-and-block.patch?dl=0
>
> I'd prefer to get patches instead of links to dropbox. You can send more
> patches in a series or as a reply to one of them and put the expected
> target version to the subject to eg. like [PATCH for 5.2] or [PATCH for
> <= 5.1] and put the note like the above with further details. Thanks.

It was just a note, I meant to send a proper patch once I got mail
from the stable guys mentioning that the patch fails to apply.
Thanks.
