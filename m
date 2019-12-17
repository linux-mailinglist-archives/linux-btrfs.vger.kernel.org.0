Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7EE12312D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 17:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfLQQK5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 11:10:57 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36443 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfLQQK5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 11:10:57 -0500
Received: by mail-vs1-f67.google.com with SMTP id u14so2829781vsu.3;
        Tue, 17 Dec 2019 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=klv7YatJjk2cKbu/5CUshoZ5n6UD9+mnIYxhMrt4Z28=;
        b=bVAMj+elRj5gsIbktJ8Qr5w7Xc/4S94AXEP6JPzaosSKj/VnAVspZdH39EbivMHEMu
         7CGevr03OUxFkYpZL1rXGnZ4r/+FJWMJhd4jPlqJEck8HkIAE/+GsLOY5gz17OBZcdIU
         9s69eul2Mg9vJKqfhjQ8pmemfXo57NY/tkIemZm/CUPsw97s46+xS2B3UO4lBm9kSlPD
         flT5SWVgF8pIteS5TKEn8SjySete8v4bNuZqVUZTy87tOUl3L72SdjNO8q3YmaeP7tLs
         hDd+8Jt1PUF/W9a4bktfrOziUBLhK1JqBmFMPFZH/xXU/nb6R2WTn3lePj62SGfPm3M3
         f/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=klv7YatJjk2cKbu/5CUshoZ5n6UD9+mnIYxhMrt4Z28=;
        b=MQso0tNWD03ZcStIGBi5OZD/ajEAVV0l1TAuF5XX3XeA+kRmMymAS47fVcdRcm0Z8/
         5KDLsCYs8UmNEFmbDoZKxnxlFQHa+ZiUOqkksNeP4RSM1S+Fy9jXKf4fswKwNWRZMmTi
         NPk68gTv0qYIkJq/AuSeSp9smrtaO146y7AL22V/6ave7hwFZp4YSLl9NH6WxkejT8lp
         wHk2HD9rqj835AmXxEjNkQDY0qXweMuGsUGMMkzGb1EDbD9CCgYWCs2WhveeyeUbgFBa
         aN0jZrAjkmEZDWsTBkQ6KIQ9UfmfwL8PUVk/Xq34nH1Wm510urpjl8f/V6geGWD93PU0
         eFMg==
X-Gm-Message-State: APjAAAU2n4ls1uDCW1sxtLihXz/jp5A5LQFLeWtl6JGOudxCatx8bo9m
        tDhJviFNguljv71Ivity0Yc4HHsutp42sgb3PCo=
X-Google-Smtp-Source: APXvYqxBLtFHvpCmVJj7oLorQp3/xWjBus5dQWXNf28JDfQmCUJ88JlGiZiui1qLgEGo5NtzVWWHFDycFyn7JsRVqhI=
X-Received: by 2002:a67:8010:: with SMTP id b16mr3321199vsd.90.1576599055524;
 Tue, 17 Dec 2019 08:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20191114155836.3528-1-josef@toxicpanda.com> <20191114155836.3528-4-josef@toxicpanda.com>
In-Reply-To: <20191114155836.3528-4-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 17 Dec 2019 16:10:44 +0000
Message-ID: <CAL3q7H46VjTJ0O9CFz5yGnWXH2SC-o=bvQ83ONuf3tgrtU7RnQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] fsstress: allow operations to use either a directory
 or subvol
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests <fstests@vger.kernel.org>, kernel-team@fb.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 3:59 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Most operations are just looking for a base directory to generate a file
> in, they don't actually need a directory specifically.  Add FT_ANYDIR to
> cover both directories and subvolumes, and then use this in all the
> places where it makes sense.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good and it works for me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  ltp/fsstress.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index f7f5f1dc..30b2bd94 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -200,6 +200,7 @@ struct print_string {
>  #define        FT_ANYm         ((1 << FT_nft) - 1)
>  #define        FT_REGFILE      (FT_REGm | FT_RTFm)
>  #define        FT_NOTDIR       (FT_ANYm & (~FT_DIRm & ~FT_SUBVOLm))
> +#define FT_ANYDIR      (FT_DIRm | FT_SUBVOLm)
>
>  #define        FLIST_SLOT_INCR 16
>  #define        NDCACHE 64
> @@ -3165,7 +3166,7 @@ creat_f(int opno, long r)
>         int             v;
>         int             v1;
>
> -       if (!get_fname(FT_DIRm, r, NULL, NULL, &fep, &v1))
> +       if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v1))
>                 parid =3D -1;
>         else
>                 parid =3D fep->id;
> @@ -3729,7 +3730,7 @@ getdents_f(int opno, long r)
>         int             v;
>
>         init_pathname(&f);
> -       if (!get_fname(FT_DIRm, r, &f, NULL, NULL, &v))
> +       if (!get_fname(FT_ANYDIR, r, &f, NULL, NULL, &v))
>                 append_pathname(&f, ".");
>         dir =3D opendir_path(&f);
>         check_cwd();
> @@ -3761,7 +3762,7 @@ getfattr_f(int opno, long r)
>         int             xattr_num;
>
>         init_pathname(&f);
> -       if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
> +       if (!get_fname(FT_REGFILE | FT_ANYDIR, r, &f, NULL, &fep, &v)) {
>                 if (v)
>                         printf("%d/%d: getfattr - no filename\n", procid,=
 opno);
>                 goto out;
> @@ -3880,7 +3881,7 @@ listfattr_f(int opno, long r)
>         int             buffer_len;
>
>         init_pathname(&f);
> -       if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
> +       if (!get_fname(FT_REGFILE | FT_ANYDIR, r, &f, NULL, &fep, &v)) {
>                 if (v)
>                         printf("%d/%d: listfattr - no filename\n", procid=
, opno);
>                 goto out;
> @@ -3930,7 +3931,7 @@ mkdir_f(int opno, long r)
>         int             v;
>         int             v1;
>
> -       if (!get_fname(FT_DIRm, r, NULL, NULL, &fep, &v))
> +       if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v))
>                 parid =3D -1;
>         else
>                 parid =3D fep->id;
> @@ -3968,7 +3969,7 @@ mknod_f(int opno, long r)
>         int             v;
>         int             v1;
>
> -       if (!get_fname(FT_DIRm, r, NULL, NULL, &fep, &v))
> +       if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v))
>                 parid =3D -1;
>         else
>                 parid =3D fep->id;
> @@ -4326,7 +4327,7 @@ removefattr_f(int opno, long r)
>         int             xattr_num;
>
>         init_pathname(&f);
> -       if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
> +       if (!get_fname(FT_REGFILE | FT_ANYDIR, r, &f, NULL, &fep, &v)) {
>                 if (v)
>                         printf("%d/%d: removefattr - no filename\n", proc=
id, opno);
>                 goto out;
> @@ -4646,7 +4647,7 @@ setfattr_f(int opno, long r)
>         int             xattr_num;
>
>         init_pathname(&f);
> -       if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
> +       if (!get_fname(FT_REGFILE | FT_ANYDIR, r, &f, NULL, &fep, &v)) {
>                 if (v)
>                         printf("%d/%d: setfattr - no filename\n", procid,=
 opno);
>                 goto out;
> @@ -4792,7 +4793,7 @@ subvol_create_f(int opno, long r)
>         int                     err;
>
>         init_pathname(&f);
> -       if (!get_fname(FT_DIRm | FT_SUBVOLm, r, NULL, NULL, &fep, &v))
> +       if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v))
>                 parid =3D -1;
>         else
>                 parid =3D fep->id;
> @@ -4872,7 +4873,7 @@ symlink_f(int opno, long r)
>         int             v1;
>         char            *val;
>
> -       if (!get_fname(FT_DIRm, r, NULL, NULL, &fep, &v))
> +       if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v))
>                 parid =3D -1;
>         else
>                 parid =3D fep->id;
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
