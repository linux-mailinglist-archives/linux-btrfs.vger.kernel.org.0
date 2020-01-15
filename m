Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF613BE52
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 12:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgAOLZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 06:25:38 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35527 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgAOLZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 06:25:38 -0500
Received: by mail-ua1-f67.google.com with SMTP id y23so6080462ual.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=siJxeCZnC8/o1HDVfbR+caSfn7IsUEyp/2GHV/qQ9+E=;
        b=qbgoJoa1A94w4oH1WSk4xbzdYkfP2WJ98BP9rHMgjVXsj2st/sRJF28ubL3GO5C9ox
         Eb1AVPHTbIU2Swd12GL+9LlJXjbgMhrpwN3KZ7lPuAq2OluoiV5Onu1DwQBpEG9rTUzt
         Wte7xljmpwW31hCwY2Trl7K7xiXiVqVTFz9KYouqQfYGdJYPMTWKxSx6SKSLrLKDN32M
         RdGF1lbIVidbBKBdQENEIysm0E0Wn9JfG6MP21GBDXk8q/FH3IeSYV2Q17ID6nRv3w1R
         /KbPJyRtTvjDzWIT2wAeruV4AdwfsK7smJHH/95MNzAUwHlZ3c5ymlk/kozvkbYTM+V3
         WXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=siJxeCZnC8/o1HDVfbR+caSfn7IsUEyp/2GHV/qQ9+E=;
        b=aBvJJGhv4gosqjFJaql5VsImehsKMMHEFUZoSSw8jGhcDNF1BlAjA0J7xWYtGr1KXK
         J4nX05/tpx+l4GOpkB7WFVaGgpXS1vCISUHtwPVunX4GY+HCGHXuzQLhLR7UgRnHkDH9
         cuZKiDXZ6k3swpD9BEHBSTHW5MAmScw48Lgu0XVWnHMh6PfEC3bJXCEHDtPe8uRtcBjR
         xjH3u3Gwccuf6spL2aeEdJxX/cqgyPh8E8YYASeiHoutXdF1kMySq1eFtT4dDM9US4RQ
         lGwKFTX2X0cQdTMgZD7mZXLk0/eNAr7JNOWkriCs3c75MRwxo9vRX1I300qHkkpGMdd9
         zzBQ==
X-Gm-Message-State: APjAAAUR9ouz4eKdYCvS+xMMfS0sfkOo25IhH65GAeXAsFKsixKylbKY
        5+0//mazKf8q4RGpXABwSgf/PqzSRX9GVI6Nj4g=
X-Google-Smtp-Source: APXvYqx9HrfztN7rLzscFQrabD0W1NK59GAEKESKT3dbVfcPY0LaRH5n8cmZcFOMhzuYEjk9QEvVUWfMctiMJcslkQY=
X-Received: by 2002:ab0:724c:: with SMTP id d12mr17391341uap.0.1579087536732;
 Wed, 15 Jan 2020 03:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20200115062818.41268-1-wqu@suse.com> <CAL3q7H5yLcUsmJVnV4A0UQed+oyQipkQ_cpUPZJLxcXruLcpNw@mail.gmail.com>
 <9ccd73d5-e130-279e-dc80-76fcc2aa0200@gmx.com>
In-Reply-To: <9ccd73d5-e130-279e-dc80-76fcc2aa0200@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 11:25:25 +0000
Message-ID: <CAL3q7H7=3f15eYOyyfz0-RQUgRnh8xJQXHboASbc0SAQ8v+NuQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: relocation: Add an introduction for how relocation works.
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 11:11 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/15 =E4=B8=8B=E5=8D=886:34, Filipe Manana wrote:
> > On Wed, Jan 15, 2020 at 6:29 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Relocation is one of the most complex part of btrfs, while it's also t=
he
> >> foundation stone for online resizing, profile converting.
> >>
> >> For such a complex facility, we should at least have some introduction
> >> to it.
> >>
> >> This patch will add an basic introduction at pretty a high level,
> >> explaining:
> >> - What relocation does
> >> - How relocation is done
> >>   Only mentioning how data reloc tree and reloc tree are involved in t=
he
> >>   operation.
> >>   No details like the backref cache, or the data reloc tree contents.
> >> - Which function to refer.
> >>
> >> More detailed comments will be added for reloc tree creation, data rel=
oc
> >> tree creation and backref cache.
> >>
> >> For now the introduction should save reader some time before digging
> >> into the rabbit hole.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  fs/btrfs/relocation.c | 44 ++++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 44 insertions(+)
> >>
> >> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> >> index d897a8e5e430..cd3a15f1716d 100644
> >> --- a/fs/btrfs/relocation.c
> >> +++ b/fs/btrfs/relocation.c
> >> @@ -23,6 +23,50 @@
> >>  #include "delalloc-space.h"
> >>  #include "block-group.h"
> >>
> >> +/*
> >> + * Introduction for btrfs relocation.
> >> + *
> >> + * [What does relocation do]
> >
> > For readability, a blank line here would help.
> >
> >> + * The objective of relocation is to relocate all or some extents of =
one block
> >> + * group to other block groups.
> >
> > Some? We always relocate all extents of a block group (except if
> > errors happen of course).
>
> Error is the exact reason I mention "some".

Then it should be rephrased imo. It's confusing. The objective is to
always relocate all extents.
You can mention instead in parentheses or in a separate statement that
in case of an error only some may be relocated:

The objective of relocation is to relocate all the extents of one
block group to other block groups.
If an error happens during relocation, it's possible that only some
extents were relocated.

Thanks.

>
> Thanks,
> Qu
>
> >
> >> + * This is utilized by resize (shrink only), profile converting, or j=
ust
> >> + * balance routine to free some block groups.
> >> + *
> >> + * In short, relocation wants to do:
> >> + *             Before          |               After
> >> + * ------------------------------------------------------------------
> >> + *  BG A: 10 data extents      | BG A: deleted
> >> + *  BG B:  2 data extents      | BG B: 10 data extents (2 old + 8 rel=
ocated)
> >> + *  BG C:  1 extents           | BG C:  3 data extents (1 old + 2 rel=
ocated)
> >> + *
> >> + * [How does relocation work]
> >> + * 1.   Mark the target bg RO
> >> + *      So that new extents won't be allocated from the target bg.
> >> + *
> >> + * 2.1  Record each extent in the target bg
> >> + *      To build a proper map of extents to be relocated.
> >> + *
> >> + * 2.2  Build data reloc tree and reloc trees
> >> + *      Data reloc tree will contain an inode, recording all newly re=
located
> >> + *      data extents.
> >> + *      There will be only one data reloc tree for one data block gro=
up.
> >> + *
> >> + *      Reloc tree will be a special snapshot of its source tree, con=
taining
> >> + *      relocated tree blocks.
> >> + *      Each tree referring to a tree block in target bg will get its=
 reloc
> >> + *      tree built.
> >> + *
> >> + * 2.3  Swap source tree with its corresponding reloc tree
> >> + *      So that each involved tree only refers to new extents after s=
wap.
> >> + *
> >> + * 3.   Cleanup reloc trees and data reloc tree.
> >> + *      As old extents in the target bg is still referred by reloc tr=
ees,
> >> + *      we need to clean them up before really freeing the target bg.
> >> + *
> >> + * The main complexity is in step 2.2 and 2.3.
> >
> > step -> steps
> >
> > Thanks.
> >
> >> + *
> >> + * The core entrance for relocation is relocate_block_group() functio=
n.
> >> + */
> >>  /*
> >>   * backref_node, mapping_node and tree_block start with this
> >>   */
> >> --
> >> 2.24.1
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
