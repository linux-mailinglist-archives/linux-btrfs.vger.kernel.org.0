Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7B16A8D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 15:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgBXOyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 09:54:04 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46344 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgBXOyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 09:54:03 -0500
Received: by mail-ua1-f67.google.com with SMTP id l6so3285939uap.13
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 06:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hj7aVEDgGw3n2atYrZR8LxjrrJ9LdMIEuJ7GPO0ZKos=;
        b=IEKw2VXrIus664PXNZbdp7PaqLgMKQNF/FYZNnFPtyKnDJH8OwSqUCAy9K9nqcIuXW
         4BEycEBomEk0Qdw3KyhMl70VMyih4VC8SJw0W95x4UbXjRpMTIeuYmT2GwqOgtLF4uTW
         HGaHjEdl3umH3pFXdaM3Um6aEX+VfbySaUfULs3+Zy8yrCttB53eeuApWouna0Pt6W7M
         Jf4vxhBc6hiEszRB8kRvDDcnudl6wBuJIT/XPAVtuibXz9Alc6tstEjDkuJMqiRMKMbx
         d+aW6yFknknxAe/ZZmfH0DXARi+j010vV1rngzD6r/yxMzAqJs++MBgj6BkwDdEOdEDC
         5U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hj7aVEDgGw3n2atYrZR8LxjrrJ9LdMIEuJ7GPO0ZKos=;
        b=Tog1ylpdkJSsbGDy4Y5VNKQwYmCYnXln1sClmkHz5lw/RulLk4jewjJ1L04zmYC/9J
         fQJNI8m8K/uYusOAZ4TT77Vaqe1JNK/xzF1r83yPcu6NyODCzV8q2KT2cepPG/LqCfGk
         chr1b+HBtmbWBUmNLyiNS+tlXvok9W9zKykeEL1pv8oJPyqBj80ReGEI2VbzsbG6az2C
         uK8BjcaNu965+NLGQjZUY8sjAL0RgWAfsg4FQVw7tvwd5PCEtJPIJ1jYpT4Xlf2YH3Oy
         9oKd9gIZcBp5mhQGjkMHcsCgGULHPYRtvbCFNmrnOMU3GUFMd5neMNOyY42H55uEFBBg
         3auQ==
X-Gm-Message-State: APjAAAVW+zm8/xKA02/WSZ4Rt4/UH2cCZ/PYEbYeRcv7ckO9Mz+tdy2Y
        uDkbd2y5nPIShXWb8qI4t6bQerPj0viSq3u3nWvt+A==
X-Google-Smtp-Source: APXvYqzoJ+tijNyQR+x5VwSoqSoC/FrltC3HHpjWJdzalSwEVTPJ+lYEzfi0uYQ0cJzAP6oanhFZX99z+QpeyYhDwbo=
X-Received: by 2002:a9f:3e84:: with SMTP id x4mr24578061uai.83.1582556042647;
 Mon, 24 Feb 2020 06:54:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1563822638.git.osandov@fb.com> <66ec0a6323c64aec74336e99696b6ad6576e091e.1563822638.git.osandov@fb.com>
 <CAL3q7H6sDTbMrjQqu_6Q6fy=Do0pgayHM-EGLXnG47BoitCScA@mail.gmail.com>
In-Reply-To: <CAL3q7H6sDTbMrjQqu_6Q6fy=Do0pgayHM-EGLXnG47BoitCScA@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 24 Feb 2020 14:53:51 +0000
Message-ID: <CAL3q7H7Yv+OjcJ4cDxwZ7x+k2z10s7yin0FTkNxaZvZ7AkVJ3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] btrfs-progs: receive: don't lookup clone root for
 received subvolume
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 23, 2019 at 12:19 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Tue, Jul 23, 2019 at 3:25 AM Omar Sandoval <osandov@osandov.com> wrote=
:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > When we process a clone request, we look up the source subvolume by
> > UUID, even if the source is the subvolume that we're currently
> > receiving. Usually, this is fine. However, if for some reason we
> > previously received the same subvolume, then this will use paths
> > relative to the previously received subvolume instead of the current
> > one. This is incorrect, since the send stream may use temporary names
> > for the clone source. This can be reproduced as follows:
> >
> > btrfs subvolume create subvol
> > dd if=3D/dev/urandom of=3Dsubvol/foo bs=3D1M count=3D1
> > cp --reflink subvol/foo subvol/bar
> > mkdir subvol/dir
> > mv subvol/foo subvol/dir/
> > btrfs property set subvol ro true
> > btrfs send -f send.data subvol
> > mkdir first second
> > btrfs receive -f send.data first
> > btrfs receive -f send.data second
> >
> > The second receive results in this error:
> >
> > ERROR: cannot open first/subvol/o259-7-0/foo: No such file or directory
> >
> > Fix it by always cloning from the current subvolume if its UUID matches=
.
> > This has the nice side effect of avoiding unnecessary UUID tree lookups
> > in that case.
> >
> > Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

I can't find this patch in btrfs-progs. Any reason why it was never applied=
?

thanks

>
> Thanks!
>
> > ---
> >  cmds/receive.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/cmds/receive.c b/cmds/receive.c
> > index dba05982..1e6a29dd 100644
> > --- a/cmds/receive.c
> > +++ b/cmds/receive.c
> > @@ -744,15 +744,14 @@ static int process_clone(const char *path, u64 of=
fset, u64 len,
> >         if (ret < 0)
> >                 goto out;
> >
> > -       si =3D subvol_uuid_search(&rctx->sus, 0, clone_uuid, clone_ctra=
nsid,
> > -                               NULL,
> > -                               subvol_search_by_received_uuid);
> > -       if (IS_ERR_OR_NULL(si)) {
> > -               if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
> > -                               BTRFS_UUID_SIZE) =3D=3D 0) {
> > -                       /* TODO check generation of extent */
> > -                       subvol_path =3D rctx->cur_subvol_path;
> > -               } else {
> > +       if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
> > +                  BTRFS_UUID_SIZE) =3D=3D 0) {
> > +               subvol_path =3D rctx->cur_subvol_path;
> > +       } else {
> > +               si =3D subvol_uuid_search(&rctx->sus, 0, clone_uuid, cl=
one_ctransid,
> > +                                       NULL,
> > +                                       subvol_search_by_received_uuid)=
;
> > +               if (IS_ERR_OR_NULL(si)) {
> >                         if (!si)
> >                                 ret =3D -ENOENT;
> >                         else
> > @@ -760,7 +759,6 @@ static int process_clone(const char *path, u64 offs=
et, u64 len,
> >                         error("clone: did not find source subvol");
> >                         goto out;
> >                 }
> > -       } else {
> >                 /* strip the subvolume that we are receiving to from th=
e start of subvol_path */
> >                 if (rctx->full_root_path) {
> >                         size_t root_len =3D strlen(rctx->full_root_path=
);
> > --
> > 2.22.0
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
