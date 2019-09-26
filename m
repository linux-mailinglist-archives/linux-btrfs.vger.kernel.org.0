Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA182BEE7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfIZJbw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 05:31:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35104 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfIZJbv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 05:31:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id s7so1156482vsl.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wG/D1dY9g0+MHDsZy3ankxTdhBdPo2euATVyKnQZAY0=;
        b=VBZSzyzUufx/A5urXZsyYthq6bVnMs2ufvMHUd8LcpDmal1movX2sG2jdmqYU009tZ
         PyNBJh9it+v8mEFbOsUJuZc9AZArcAdnIdte6y7FLSI1NSgZTwHCjZUlbK3QfojwAy5X
         tEJ50COW+tbr6hbrDhPiblpBXrauGWsn9XwG9/Hg8XEKLun32NneE9DTcnC6cZAbpyac
         yoZht7EcpOotgHHfT4QIgKMy2kQkkP+v1RZdMYnOMYI13MtpELsj1UNU5cEYeb9knqec
         dyDZLtheRYRF1nNHTRcbY/JrLe07KpTdXVOAJfOlXiePGYA/Z2U3HrySkgFhrBc4DID9
         oE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wG/D1dY9g0+MHDsZy3ankxTdhBdPo2euATVyKnQZAY0=;
        b=rbTrTo1KiR5/aaHh4GFB9EIDur8YqZBQdUIVjpUnkiQRJW4Js2LvCk6DIm92EmkGEZ
         b9nHnbnjJfnTafEaiUWkzm4ilAmUaD/Fh29VGX21RbTeJ+Cexh7Q7JqOvJXxsUmZewGQ
         2QeaTrukfWGDlXAdo/ydaqNFeICXHc6gFetntee/KVKuQbDOe8Xych6w5gQCiZncNThA
         9I/s/vwuwwvpneOtyQbKO0hIY1zOGhfUB1arZIqmOVQxDrwlT06iAQsVWdUJ2YBKE+2X
         IASQJepIgoSoqqbAf8w6d2xrS5lOO7cN8Ev3Tg6JG+2zlDb5Uld2HtusQvI8xgrFElKn
         qIhQ==
X-Gm-Message-State: APjAAAW6uwbrvmzCkqHdi3tGfNCGnTw/GNnte1RTVucV/QVDQmr0vLnL
        OCfpPn8/RSpS19XW91cgBExeBCs4qwO95uq3q7rFEjlz
X-Google-Smtp-Source: APXvYqy0L/45utalS02B8jyBnrqWb1RR12V3JGZrdHUIlHZ1sGtMOMKdZLaEKPBEScq9SLXUmiLTfKXTjBwYODFF9kk=
X-Received: by 2002:a67:6044:: with SMTP id u65mr1123991vsb.95.1569490309210;
 Thu, 26 Sep 2019 02:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190924170920.GB2751@twin.jikos.cz> <20190925110303.20466-1-nborisov@suse.com>
In-Reply-To: <20190925110303.20466-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 26 Sep 2019 10:31:38 +0100
Message-ID: <CAL3q7H6mZTNN2NuZ8dudR=F=MHVsjbyK6=3ELCOhnQJb_AFhWg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Properly handle backref_in_log retval
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 10:27 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> This function can return a negative error value if btrfs_search_slot
> errors for whatever reason or if btrfs_alloc_path runs out of memory.
> This is currently problemattic because backref_in_log is treated by its
> callers as if it returns boolean.
>
> Fix this by adding proper error handling in callers. That also enables
> the function to return the direct error code from btrfs_search_slot.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>
> v2:
>  * Return 0 from backref_in_log in case btrfs_search_slot returns 1 (mean=
ing it
>  didn't find appropriate item in the btree).
>
>  fs/btrfs/tree-log.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 7cac09a6f007..7332f7a00790 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -952,7 +952,9 @@ static noinline int backref_in_log(struct btrfs_root =
*log,
>                 return -ENOMEM;
>
>         ret =3D btrfs_search_slot(NULL, log, key, path, 0, 0);
> -       if (ret !=3D 0) {
> +       if (ret < 0) {
> +               goto out;
> +       } else if (ret =3D=3D 1) {
>                 ret =3D 0;
>                 goto out;
>         }
> @@ -1026,10 +1028,13 @@ static inline int __add_inode_ref(struct btrfs_tr=
ans_handle *trans,
>                                            (unsigned long)(victim_ref + 1=
),
>                                            victim_name_len);
>
> -                       if (!backref_in_log(log_root, &search_key,
> -                                           parent_objectid,
> -                                           victim_name,
> -                                           victim_name_len)) {
> +                       ret =3D backref_in_log(log_root, &search_key,
> +                                            parent_objectid, victim_name=
,
> +                                            victim_name_len);
> +                       if (ret < 0) {
> +                               kfree(victim_name);
> +                               return ret;
> +                       } else if (!ret) {
>                                 inc_nlink(&inode->vfs_inode);
>                                 btrfs_release_path(path);
>
> @@ -1091,10 +1096,12 @@ static inline int __add_inode_ref(struct btrfs_tr=
ans_handle *trans,
>                         search_key.offset =3D btrfs_extref_hash(parent_ob=
jectid,
>                                                               victim_name=
,
>                                                               victim_name=
_len);
> -                       ret =3D 0;
> -                       if (!backref_in_log(log_root, &search_key,
> -                                           parent_objectid, victim_name,
> -                                           victim_name_len)) {
> +                       ret =3D backref_in_log(log_root, &search_key,
> +                                            parent_objectid, victim_name=
,
> +                                            victim_name_len);
> +                       if (ret < 0) {
> +                               return ret;
> +                       } else if (!ret) {
>                                 ret =3D -ENOENT;
>                                 victim_parent =3D read_one_inode(root,
>                                                 parent_objectid);
> @@ -1869,16 +1876,19 @@ static bool name_in_log_ref(struct btrfs_root *lo=
g_root,
>                             const u64 dirid, const u64 ino)
>  {
>         struct btrfs_key search_key;
> +       int ret;
>
>         search_key.objectid =3D ino;
>         search_key.type =3D BTRFS_INODE_REF_KEY;
>         search_key.offset =3D dirid;
> -       if (backref_in_log(log_root, &search_key, dirid, name, name_len))
> +       ret =3D backref_in_log(log_root, &search_key, dirid, name, name_l=
en);
> +       if (ret =3D=3D 1)
>                 return true;
>
>         search_key.type =3D BTRFS_INODE_EXTREF_KEY;
>         search_key.offset =3D btrfs_extref_hash(dirid, name, name_len);
> -       if (backref_in_log(log_root, &search_key, dirid, name, name_len))
> +       ret =3D backref_in_log(log_root, &search_key, dirid, name, name_l=
en);
> +       if (ret =3D=3D 1)
>                 return true;

This function also needs to be able to return errors and its caller
check for errors.

Thanks.

>
>         return false;
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
