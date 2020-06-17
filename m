Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4561FD423
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgFQSLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgFQSLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 14:11:25 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABE9C06174E;
        Wed, 17 Jun 2020 11:11:24 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id b13so1081789uav.3;
        Wed, 17 Jun 2020 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TgIyMa1CctmQcSZLAmrSG7rwQurThEwDHaP5GpA9R/I=;
        b=VzcbBNyMKtjusnqKH9zyLNJei05jzxOq8wyyeiRlWd8Ig/atvJbp1ot4w4OwEyPSxI
         2OHXMCyESJz+FON5p4cLukOMZsOzXQjsid2XbLJ+7IZ6o3Duz6S37bVf1K6TIFsx6Tfp
         8j2DQCHnAUSRpy1c6zvGPUXo9GZG7WmgA47Zviq0RUweckwUSXxi7HLTPWQNrm7tGfoF
         IosjClDcZSjdEzCQ6YqatjZFklgmFjRVLuuijNgG740P6wFYwAtYltvwJR0cVDLDTQ4W
         RuzkCgzMwXnuCFLfOPJbjqR6b8UQl/RghcsfWsZ6xgk7UEsC9QH8mv1hKDMBZ4k1w+aA
         39RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TgIyMa1CctmQcSZLAmrSG7rwQurThEwDHaP5GpA9R/I=;
        b=KFEmHK2GevYrc4jLkRaQGdXH8IUVZ9bTNiouGfj5a0Y3F8Q1vtecj0xklZeViTOx21
         I5lvAm/n7LCNIIPm5h3Zp7VI6TsHD4takcmSTy9HnPI6r/4ELSSXdAI6XBVar+IxB1UI
         v3j4HfLgLTzMML5StLSTXWCKgTRgIaDIHN3ngak6A+7aNa0V8UHPlaWUHC1ccq4/1WIn
         kQ028IX3v+9zzYilrxrHy/INcAj5Y32FqLOt4Z8BcQ5rN1XIa5nMaFoFEAXXvlv+Ns5G
         jD/6UdtP9/LRK3Sckg6Fpb3AERRLKtZeoKvpEqeGLpY4cMDLsbxaoCichwnF+vXHprie
         sQkQ==
X-Gm-Message-State: AOAM5305tGfmijtw1ZykMYABykHX3aB4gWq4uhlnLult28YxEBhUhinf
        X8lpyYYsNEiPTCqW3wYX8P9Zyszf0OmZIibKEei/MXrP
X-Google-Smtp-Source: ABdhPJyv9Wh4QjgVp4W1UTsTMuTeUx3oyZVKNsRJZcHECQX89fBVrLcIbjSQQrQ5szpGpNWvdCOWVl7ddq6tpAK3XjQ=
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr243440uav.0.1592417483265;
 Wed, 17 Jun 2020 11:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162746.3780660-1-boris@bur.io> <CAL3q7H47P6E9zn3Zk9C2LX8-1g2QNiCGgbcRMDQDk+JBCoOhzg@mail.gmail.com>
 <ADB20899-1E88-4546-BEB5-4F2165386184@fb.com>
In-Reply-To: <ADB20899-1E88-4546-BEB5-4F2165386184@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Jun 2020 19:11:12 +0100
Message-ID: <CAL3q7H5q1ocLa6HjSfiXgVJ67kyfqNBDhcwMqeRVDfbiyr5-tg@mail.gmail.com>
Subject: Re: [PATCH btrfs/for-next] btrfs: fix fatal extent_buffer readahead
 vs releasepage race
To:     Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 6:43 PM Chris Mason <clm@fb.com> wrote:
>
> On 17 Jun 2020, at 13:20, Filipe Manana wrote:
>
> > On Wed, Jun 17, 2020 at 5:32 PM Boris Burkov <boris@bur.io> wrote:
> >
> >> ---
> >>  fs/btrfs/extent_io.c | 45
> >> ++++++++++++++++++++++++++++----------------
> >>  1 file changed, 29 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index c59e07360083..f6758ebbb6a2 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -3927,6 +3927,11 @@ static noinline_for_stack int
> >> write_one_eb(struct extent_buffer *eb,
> >>         clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
> >>         num_pages =3D num_extent_pages(eb);
> >>         atomic_set(&eb->io_pages, num_pages);
> >> +       /*
> >> +        * It is possible for releasepage to clear the TREE_REF bit
> >> before we
> >> +        * set io_pages. See check_buffer_tree_ref for a more
> >> detailed comment.
> >> +        */
> >> +       check_buffer_tree_ref(eb);
> >
> > This is a whole different case from the one described in the
> > changelog, as this is in the write path.
> > Why do we need this one?
>
> This was Josef=E2=80=99s idea, but I really like the symmetry.  You set
> io_pages, you do the tree_ref dance.  Everyone fiddling with the write
> back bit right now correctly clears writeback after doing the atomic_dec
> on io_pages, but the race is tiny and prone to getting exposed again by
> shifting code around.  Tree ref checks around io_pages are the most
> reliable way to prevent this bug from coming back again later.

Ok, but that still doesn't answer my question.
Is there an actual race/problem this hunk solves?

Before calling write_one_eb() we increment the ref on the eb and we
also call lock_extent_buffer_for_io(),
which clears the dirty bit and sets the writeback bit on the eb while
holding its ref_locks spin_lock.

Even if we get to try_release_extent_buffer, it calls
extent_buffer_under_io(eb) while holding the ref_locks spin_lock,
so at any time it should return true, as either the dirty or the
writeback bit is set.

Is this purely a safety guard that is being introduced?

Can we at least describe in the changelog why we are adding this hunk
in the write path?
All it mentions is a race between reading and releasing pages, there's
nothing mentioned about races with writeback.

Thanks.

>
> -chris



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
