Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB703716D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbfGWLT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 07:19:57 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37993 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfGWLT5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 07:19:57 -0400
Received: by mail-ua1-f66.google.com with SMTP id j2so16738929uaq.5
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2019 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YatXsPUEdYXRnfXWA2Le+KDS9fpZ+ipZtvKn0tURA5o=;
        b=YsohI6EeAVWFk6OBG6a/gc4MPpeqKIzEHrySQgBNVnFmj48w2SMAtPBAgTw9o1uScX
         hu41DT1AXnFDKxC8Q77mDQWufmum4lTCu7LU42wuR6xantya4A1iYnXZ/smtV8QiP+qw
         hFKZqx0yX+HtRST94A+89+47Ur8FEbevyle8ZEJGNQ+mTNjy+/pyJr/9+WzuFYzNooOV
         6d6jsb43be2FTKQsqOE8LPPyQs9KlaAsRXkBjkdeL97e7e0/LjLtDIEok78x4uXVkGjB
         tFfNvMn9lDPKq2pc32n+R3DYDFFS1UA0EF1vkbwBAk5R5RT1SIcZE4RBcZm4dz6PwjNb
         oaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YatXsPUEdYXRnfXWA2Le+KDS9fpZ+ipZtvKn0tURA5o=;
        b=NHMHtovXwa3aEgusPCVCcP+eWb9ua1r0scSy24I38/fMF4/a7XhsBmi4SovyWfJhO7
         cRgjSYeE++ybkLZvKq6lUkaj71qD6JvWyThwFL4YSCwMwqBNE1zPiCMPPtwXrjKfWp8j
         cM7zy5d95/i5rKo/qsP/SXBI5tCJNW1OeaWUl8hungXz89AxgFMTIo2ywJMOarccpPav
         MuEgnjE/mQG5Uq2pHnwGQKy1uxXJC6EIUIjw1sOApUTlMxFiF6Q90xbdD1embjJtgYoF
         1OvBZfWaimDsak0Q4awLKhkiM0lOLlNqfrjw6nL2TC+UURqkHX7InjL3JeAyJLDykknK
         EPYg==
X-Gm-Message-State: APjAAAVonvjxsZVLx53J5jyu4ZlCeCO6bVSjA2IFntGM4xOHyV31sRUP
        9zU2uUmx5LbLA3K3YesdgXKiUNXDwJHOo7tcIp0=
X-Google-Smtp-Source: APXvYqyftPo5jil93L105LLwDsY4FvrmpPV9wv2j1SeXwC57T6j4OqunPm33VGh2sqlb0VLb0D66r3LVcl9+zvt80Nc=
X-Received: by 2002:ab0:7555:: with SMTP id k21mr1792820uaq.0.1563880796106;
 Tue, 23 Jul 2019 04:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563822638.git.osandov@fb.com> <66ec0a6323c64aec74336e99696b6ad6576e091e.1563822638.git.osandov@fb.com>
In-Reply-To: <66ec0a6323c64aec74336e99696b6ad6576e091e.1563822638.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 23 Jul 2019 12:19:45 +0100
Message-ID: <CAL3q7H6sDTbMrjQqu_6Q6fy=Do0pgayHM-EGLXnG47BoitCScA@mail.gmail.com>
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

On Tue, Jul 23, 2019 at 3:25 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> When we process a clone request, we look up the source subvolume by
> UUID, even if the source is the subvolume that we're currently
> receiving. Usually, this is fine. However, if for some reason we
> previously received the same subvolume, then this will use paths
> relative to the previously received subvolume instead of the current
> one. This is incorrect, since the send stream may use temporary names
> for the clone source. This can be reproduced as follows:
>
> btrfs subvolume create subvol
> dd if=3D/dev/urandom of=3Dsubvol/foo bs=3D1M count=3D1
> cp --reflink subvol/foo subvol/bar
> mkdir subvol/dir
> mv subvol/foo subvol/dir/
> btrfs property set subvol ro true
> btrfs send -f send.data subvol
> mkdir first second
> btrfs receive -f send.data first
> btrfs receive -f send.data second
>
> The second receive results in this error:
>
> ERROR: cannot open first/subvol/o259-7-0/foo: No such file or directory
>
> Fix it by always cloning from the current subvolume if its UUID matches.
> This has the nice side effect of avoiding unnecessary UUID tree lookups
> in that case.
>
> Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks!

> ---
>  cmds/receive.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index dba05982..1e6a29dd 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -744,15 +744,14 @@ static int process_clone(const char *path, u64 offs=
et, u64 len,
>         if (ret < 0)
>                 goto out;
>
> -       si =3D subvol_uuid_search(&rctx->sus, 0, clone_uuid, clone_ctrans=
id,
> -                               NULL,
> -                               subvol_search_by_received_uuid);
> -       if (IS_ERR_OR_NULL(si)) {
> -               if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
> -                               BTRFS_UUID_SIZE) =3D=3D 0) {
> -                       /* TODO check generation of extent */
> -                       subvol_path =3D rctx->cur_subvol_path;
> -               } else {
> +       if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
> +                  BTRFS_UUID_SIZE) =3D=3D 0) {
> +               subvol_path =3D rctx->cur_subvol_path;
> +       } else {
> +               si =3D subvol_uuid_search(&rctx->sus, 0, clone_uuid, clon=
e_ctransid,
> +                                       NULL,
> +                                       subvol_search_by_received_uuid);
> +               if (IS_ERR_OR_NULL(si)) {
>                         if (!si)
>                                 ret =3D -ENOENT;
>                         else
> @@ -760,7 +759,6 @@ static int process_clone(const char *path, u64 offset=
, u64 len,
>                         error("clone: did not find source subvol");
>                         goto out;
>                 }
> -       } else {
>                 /* strip the subvolume that we are receiving to from the =
start of subvol_path */
>                 if (rctx->full_root_path) {
>                         size_t root_len =3D strlen(rctx->full_root_path);
> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
