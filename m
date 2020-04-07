Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A741A0EF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 16:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgDGOOs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 10:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgDGOOs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 10:14:48 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F4037206F7
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Apr 2020 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586268888;
        bh=fOJFhH3O7KhSpBGJhyOdbG1Hzf7l44jNAgm21oTrXvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W0zepVOuxG4pJEnoQ8VHDuBlyJ4Y+e4DLOxdSO/oz5QUQ3al0VZdjBB+uyhMQSmR7
         M3EEzblLFDsCiJ7v1qtj4nqk1AjYa3edSj0zmaorD40VjEa+NV6WDwDUOxEYg5l1a4
         bLO4pxMNS/L/gdlfPdKEjdprX87SLO6wkD/X8cj4=
Received: by mail-ua1-f46.google.com with SMTP id f9so1305698uaq.8
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Apr 2020 07:14:47 -0700 (PDT)
X-Gm-Message-State: AGi0PuaHNF66i+PGwRZnIOuHWBzPelZ13dW6Y5dfVUIWMO4PHxd6JBSO
        gnIkXLuscVMB9W7S7klR7QhVKfvSPHqOeOFOCT0=
X-Google-Smtp-Source: APiQypL5GTdMP/fN1dgTARh+ozxZvY1ELq8kctG5xU+dlBQQLUquE0dYMIsmjovrAqnuOPjo0xjvS5JBVWb+KUfe6AI=
X-Received: by 2002:ab0:158b:: with SMTP id i11mr1889818uae.123.1586268887086;
 Tue, 07 Apr 2020 07:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200407103858.31029-1-fdmanana@kernel.org> <e460bb78-20e7-f792-eb3c-0bd3944319d8@suse.com>
In-Reply-To: <e460bb78-20e7-f792-eb3c-0bd3944319d8@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 7 Apr 2020 15:14:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H45q8Ct_SOO1-zzrGHcDAS4yFeEoQc+8CgzbLPG2miBPw@mail.gmail.com>
Message-ID: <CAL3q7H45q8Ct_SOO1-zzrGHcDAS4yFeEoQc+8CgzbLPG2miBPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Btrfs: remove pointless assertion on reclaim_size counter
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 7, 2020 at 12:32 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 7.04.20 =D0=B3. 13:38 =D1=87., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The reclaim_size counter of a space_info object is unsigned. So its val=
ue
> > can never be negative, it's pointless to have an assertion that checks
> > its value is >=3D 0, therefore remove it.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> True,
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com> I guess this could be
> squashed.

Despite being a trivial and small change, I don't think it should be
squashed into the previous patch, as it's not part of the bug fix
regarding the counter leak.
Different changes and unrelated changes should be separate patches.

Thanks.

>
> > ---
> >  fs/btrfs/space-info.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index ff17a4420358..88d7dea215ff 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -1198,7 +1198,6 @@ static int __reserve_metadata_bytes(struct btrfs_=
fs_info *fs_info,
> >        * the list and we will do our own flushing further down.
> >        */
> >       if (ret && flush !=3D BTRFS_RESERVE_NO_FLUSH) {
> > -             ASSERT(space_info->reclaim_size >=3D 0);
> >               ticket.bytes =3D orig_bytes;
> >               ticket.error =3D 0;
> >               space_info->reclaim_size +=3D ticket.bytes;
> >
