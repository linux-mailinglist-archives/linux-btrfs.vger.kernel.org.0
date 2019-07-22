Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84976FF5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 14:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfGVMQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 08:16:48 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40309 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGVMQs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 08:16:48 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so24299154vsd.7
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ftsOUFa3c97bimWRm50mNcdS5cg7qa3Sr94P4TFj73c=;
        b=DrIYJX87nPs2lR/iwmXloD/XE6bvP6c2dgLa5DAXrZAkdAMxahl76BDZxr24BnrUbT
         +j7tdWtmFOjzbekujM6ahSmOaj+gy1fK8Np/mFAWU+JE7Pwy5vcjFC97RfIFnb8Y8bqj
         t3SpS+lRCreWA25COqOLlgszr1ROWlhmOzXF5A0aIQhFDB5m7GfoEE20X4DYTo8Az2Rn
         G8JmAjpLqfGOX6CIc0pKQF7O5m1anjITM2uiyACTWnMeumFNzpsQ3jNGavtqpFaLVgc5
         OY/rZw3EN661jYEJ83hUL1cl/W3Tp7xiWlUon3yGrdtPIPo5e00wgCVxzJR76TExGJHI
         krGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ftsOUFa3c97bimWRm50mNcdS5cg7qa3Sr94P4TFj73c=;
        b=EPrgNsJv936PQXwOR14qgDKOTH8f+q1Oyfy4mN8L6qPifaA/nGbUt2q8GwWaCp4weJ
         HKIkkjpxgia/q52v9J6e/y+sSmIVv9D8/X60vzw1T70/PZiVYwnKGS/2Uesi4NeBleVc
         6040DllUrbPhxvntMt2ySHRd74LQ4VBcrlnFJkEOsjXxnDqcpt0ERSnxcCizhlZhHjXF
         rYKdVvNob/OMgEovDCmpyYTEMrtYlUT8ZSNf4cdUSl0f7uWGaEK7SIwGCmZLYs9J7doM
         nEdbGUfcr3+pOyDb8D/idXv+iEvrx/IgR7gyzzGzxbRG7jMmztZUW6hUIkP/ePFlWVcU
         ghbA==
X-Gm-Message-State: APjAAAUvtc1i6gO9eaIJGtTaSSgQo69uOBaSlLzDtUIri0sJswQjadlM
        MCle7n/QEbaeOux/McBXxXvAZsHgE1LaSfx36No=
X-Google-Smtp-Source: APXvYqwcXSGKYCluO25gESTBQjEk6u7hgLuNOvWpxvoTY7n1Un7qKU/e1iOYfAW9oq04rRkD47kBrZj5upNqHzzAQn0=
X-Received: by 2002:a67:bc15:: with SMTP id t21mr37465974vsn.99.1563797806632;
 Mon, 22 Jul 2019 05:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563600688.git.osandov@fb.com> <6af59460e12a8120bf643a923f5fa6bd3b135b20.1563600688.git.osandov@fb.com>
In-Reply-To: <6af59460e12a8120bf643a923f5fa6bd3b135b20.1563600688.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 22 Jul 2019 13:16:35 +0100
Message-ID: <CAL3q7H6Z1RiuGODKfuV3Dq3gge8Bdkocdn0VGOrP=14ftkbe-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs-progs: receive: don't lookup clone root for
 received subvolume
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 20, 2019 at 3:34 PM Omar Sandoval <osandov@osandov.com> wrote:
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
> btrfs subvol create subvol
> dd if=3D/dev/urandom of=3Dsubvol/foo bs=3D1M count=3D1
> cp --reflink subvol/foo subvol/bar
> mkdir subvol/dir
> mv subvol/foo subvol/dir/
> btrfs property set subvol ro true
> btrfs send -f stream subvol
> mkdir first second
> btrfs receive -f stream first
> btrfs receive -f stream second
>
> The second receive results in this error:
>
> ERROR: cannot open first/subvol/o259-7-0/foo: No such file or directory
>
> Fix it by always cloning from the current subvolume if its UUID matches.
> This has the nice side effect of avoiding unnecessary UUID tree lookups
> in that case. Also, while we're here, get rid of some code that has been
> commented out since it was added.
>
> Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  cmds/receive.c | 34 ++++++++--------------------------
>  1 file changed, 8 insertions(+), 26 deletions(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index a3e62985..ed089af2 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -753,15 +753,14 @@ static int process_clone(const char *path, u64 offs=
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

Hi Omar,

This, and the change log, look good.

>                         if (!si)
>                                 ret =3D -ENOENT;
>                         else
> @@ -769,23 +768,6 @@ static int process_clone(const char *path, u64 offse=
t, u64 len,
>                         error("clone: did not find source subvol");
>                         goto out;
>                 }
> -       } else {
> -               /*if (rs_args.ctransid > rs_args.rtransid) {
> -                       if (!r->force) {
> -                               ret =3D -EINVAL;
> -                               fprintf(stderr, "ERROR: subvolume %s was =
"
> -                                               "modified after it was "
> -                                               "received.\n",
> -                                               r->subvol_parent_name);
> -                               goto out;
> -                       } else {
> -                               fprintf(stderr, "WARNING: subvolume %s wa=
s "
> -                                               "modified after it was "
> -                                               "received.\n",
> -                                               r->subvol_parent_name);
> -                       }
> -               }*/
> -

Isn't this unrelated? Shouldn't go to a separate patch?

Also, would you please create a test case as well?

Thanks.

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
