Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B331FD485
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 20:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFQS0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 14:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFQS0j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 14:26:39 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F112C06174E;
        Wed, 17 Jun 2020 11:26:39 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id u15so809886vkk.6;
        Wed, 17 Jun 2020 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zbw5pHB4aa6KZyY8LuNglIK8PBRnGceAc1YUqLNwsOI=;
        b=Ysrv7po1s/74ZcgNjAO+mAgOY+MJeSc0i8E8BJeFQQryHAKjQePpY1ihTijBzs+YYi
         XERuPGeHf/lmyG9hMF5gkLdZ8HT020QOeTdXQGK6kCS50srJiFocd5izGjRbnEvsYEUZ
         KiQgoX4aHZTamjG2GdM77rWVR0vSviMXUpZXxtvHO6JUSkI4IHp4d1+EH8nd11sGnvRF
         W2tOLLkQ6S71dhwLs4Sy6XDET3wNjJ2dCM32zRGbWEvqphEWIO9rmGKrxTxIV+A68NY+
         brwgjwmC3tNrbEOuD3wniYBVIhSCUoerqBEVgHJWb7Vo5Ej+nwaBNRPAJzziinZm+Fyn
         f+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zbw5pHB4aa6KZyY8LuNglIK8PBRnGceAc1YUqLNwsOI=;
        b=RFq4GlRR+MgNWHmLHwt2m7m8uKMInZ1fQHn2YJorqHDNeaR7KOht8SKmyirz+LZpjh
         A9jidV2KCIOYxzvbucDHU3WztQBhZeyKqymVB1AhEqY8eYP2Fz1KkjVmDJgTR4mTmBLa
         WK7oZwUgqBzJ4dEDvPxxxlL1ILiB8MXfsmq0+ESwZGrQsjsqBTOREnLrwCUrx21+4OPV
         X8GBZ2todFcZXOspPreKfkMx7YX7O0ysIyACcUZSis1RmIBkEmavhtBnY/oWhB7z6w+E
         +fhHfTdS1H0KwW11/2AOZmOATU1cQwsqLGfoacFl9zXKwzgvBHcil0aoglcQBoPZPfIS
         sqPA==
X-Gm-Message-State: AOAM530p4F4LNg6M58gOM1Gny007NuPjQXOCc7I4ZnfCt3YUZZ2TrSRz
        Dhrn2CqgSWj4QimJ19fMZUAaxtud29GU0BlXe+k=
X-Google-Smtp-Source: ABdhPJyYSJRIVuArMT/e6ZjcZOy5AgqF7XGfKrhc3eYg6qu20j5dyYj/KdjVzQtDpOza54IFvOFMDUSaVo42My+DaKc=
X-Received: by 2002:a1f:de43:: with SMTP id v64mr645681vkg.13.1592418398476;
 Wed, 17 Jun 2020 11:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162746.3780660-1-boris@bur.io> <CAL3q7H47P6E9zn3Zk9C2LX8-1g2QNiCGgbcRMDQDk+JBCoOhzg@mail.gmail.com>
 <ADB20899-1E88-4546-BEB5-4F2165386184@fb.com> <CAL3q7H5q1ocLa6HjSfiXgVJ67kyfqNBDhcwMqeRVDfbiyr5-tg@mail.gmail.com>
 <1fdc19e9-8517-efb3-78c7-6f4d0152d87f@toxicpanda.com>
In-Reply-To: <1fdc19e9-8517-efb3-78c7-6f4d0152d87f@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Jun 2020 19:26:27 +0100
Message-ID: <CAL3q7H4GqjcesWir69PULr4a9rSi2cVQ366y5bAEU23wS6xJkA@mail.gmail.com>
Subject: Re: [PATCH btrfs/for-next] btrfs: fix fatal extent_buffer readahead
 vs releasepage race
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Chris Mason <clm@fb.com>, Boris Burkov <boris@bur.io>,
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

On Wed, Jun 17, 2020 at 7:19 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 6/17/20 2:11 PM, Filipe Manana wrote:
> > On Wed, Jun 17, 2020 at 6:43 PM Chris Mason <clm@fb.com> wrote:
> >>
> >> On 17 Jun 2020, at 13:20, Filipe Manana wrote:
> >>
> >>> On Wed, Jun 17, 2020 at 5:32 PM Boris Burkov <boris@bur.io> wrote:
> >>>
> >>>> ---
> >>>>   fs/btrfs/extent_io.c | 45
> >>>> ++++++++++++++++++++++++++++----------------
> >>>>   1 file changed, 29 insertions(+), 16 deletions(-)
> >>>>
> >>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >>>> index c59e07360083..f6758ebbb6a2 100644
> >>>> --- a/fs/btrfs/extent_io.c
> >>>> +++ b/fs/btrfs/extent_io.c
> >>>> @@ -3927,6 +3927,11 @@ static noinline_for_stack int
> >>>> write_one_eb(struct extent_buffer *eb,
> >>>>          clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
> >>>>          num_pages =3D num_extent_pages(eb);
> >>>>          atomic_set(&eb->io_pages, num_pages);
> >>>> +       /*
> >>>> +        * It is possible for releasepage to clear the TREE_REF bit
> >>>> before we
> >>>> +        * set io_pages. See check_buffer_tree_ref for a more
> >>>> detailed comment.
> >>>> +        */
> >>>> +       check_buffer_tree_ref(eb);
> >>>
> >>> This is a whole different case from the one described in the
> >>> changelog, as this is in the write path.
> >>> Why do we need this one?
> >>
> >> This was Josef=E2=80=99s idea, but I really like the symmetry.  You se=
t
> >> io_pages, you do the tree_ref dance.  Everyone fiddling with the write
> >> back bit right now correctly clears writeback after doing the atomic_d=
ec
> >> on io_pages, but the race is tiny and prone to getting exposed again b=
y
> >> shifting code around.  Tree ref checks around io_pages are the most
> >> reliable way to prevent this bug from coming back again later.
> >
> > Ok, but that still doesn't answer my question.
> > Is there an actual race/problem this hunk solves?
> >
> > Before calling write_one_eb() we increment the ref on the eb and we
> > also call lock_extent_buffer_for_io(),
> > which clears the dirty bit and sets the writeback bit on the eb while
> > holding its ref_locks spin_lock.
> >
> > Even if we get to try_release_extent_buffer, it calls
> > extent_buffer_under_io(eb) while holding the ref_locks spin_lock,
> > so at any time it should return true, as either the dirty or the
> > writeback bit is set.
> >
> > Is this purely a safety guard that is being introduced?
> >
> > Can we at least describe in the changelog why we are adding this hunk
> > in the write path?
> > All it mentions is a race between reading and releasing pages, there's
> > nothing mentioned about races with writeback.
> >
>
> I think maybe we make that bit a separate patch, and leave the panic fix =
on it's
> own.  I suggested this because I have lofty ideas of killing the refs_loc=
k, and
> this would at least keep us consistent in our usage TREE_REF to save us f=
rom
> freeing stuff that may be currently under IO.
>
> I'm super not happy with our reference handling coupled with releasepage,=
 but
> these are the kind of hoops we're going to have to jump through until we =
have
> some better infrastructure in place to handle metadata.  Thanks,

Ok, so it's just a safety guard then.
Yes, either a separate patch or at the very least mention why we are
adding that in the change log.

Thanks.

>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
