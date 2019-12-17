Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B66312311C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 17:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfLQQGv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 11:06:51 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43307 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfLQQGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 11:06:51 -0500
Received: by mail-ua1-f65.google.com with SMTP id o42so3607338uad.10;
        Tue, 17 Dec 2019 08:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=67jY2dfupyUgudSQIPQMKibfXNp2rZfUJ94zrvS6ZX4=;
        b=hqMGWbib5zCtCofQR+kyIYdaWH7F08iXD29eS+59WYe6lOLyoFVw+Y6hkcHmblg7OP
         Md2mhd0j/QgU4bo8rzje1meIawPlnbLQmHyC5xuSHdAyvwAsssCcFBbSYWVKptN0W46/
         19zNvSFxwcJ2LvRh/36qFKSX+xEH1NqdMyfDRRGRHdtXOPWYv9NNGwtc2UIgqDYreaR5
         zGpuUFal0QAQgm0IeITzXTGdFvcrvOxngQNqjMZbv7taNMA2/nLN0l6yW+CWErHXpClu
         /C4qBtLHeNyqm7a/O3MHUU1gMwjpZ6QwMO/wf681gbdcmWGtmM1nXlMfU6Ipii1BeLWL
         QfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=67jY2dfupyUgudSQIPQMKibfXNp2rZfUJ94zrvS6ZX4=;
        b=Ssxnw19zU5tayi2C8xMwBAp0xOkaUDuSub0SBZePVMadxbd3tPbZYZQ8BHXgcgt3E9
         t/EZphCcD4m0eWSP7HGLmY7RdnEtFr3M81+gtBzFHFGigaCMGGxx5nIstkudHKsQkF4z
         /+QnfHV8hxmeOcm9kc3Usl9Wb2PXDM6+I1XuROHOxyT4hVHSD1j8jd/Rshz4qUdQs/Yz
         Y4RCE8m/uuNpMwm/WXcau6xoMkwZD38MswxQZuYqqz1+BytW4rCBQcPrCz01RqgTe3Yh
         WQWFpOTx/7E4cxtZ2TrViT98jeKahQztd+SEZ9B23pkKIr3vCMcCyc6/i5zuEZAsK8p8
         h2bQ==
X-Gm-Message-State: APjAAAW8cix2kZl7nlxrky01vQvlD1wQFwmAT0VQFJovUFoRpZROfJOC
        L3ikDttQRAsx7YAQWsUUwOvYupa/djIVZwCOioM=
X-Google-Smtp-Source: APXvYqylGIYI9trRKDygWNLrrYljOCG9nlet7yHlfllPKZ7z4G8B16iO7tdM7SGRSkKPVbFX5ikc1i140mGlXsJ35ec=
X-Received: by 2002:a9f:3e84:: with SMTP id x4mr3600376uai.83.1576598809729;
 Tue, 17 Dec 2019 08:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20191114155836.3528-1-josef@toxicpanda.com> <20191114155836.3528-3-josef@toxicpanda.com>
In-Reply-To: <20191114155836.3528-3-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 17 Dec 2019 16:06:38 +0000
Message-ID: <CAL3q7H4t_L3JrmP1NNf8VTb+UApbLWC8f69UzsMen1hGzXzb=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] fsstress: add the ability to create snapshots
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
> Snapshots are just fancy subvolumes, add this ability so we can stress
> snapshot creation.  We get the deletion with SUBVOL_DELETE.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good, and it works on my test boxes.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  ltp/fsstress.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index e0636a12..f7f5f1dc 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -129,6 +129,7 @@ typedef enum {
>         OP_SETATTR,
>         OP_SETFATTR,
>         OP_SETXATTR,
> +       OP_SNAPSHOT,
>         OP_SPLICE,
>         OP_STAT,
>         OP_SUBVOL_CREATE,
> @@ -255,6 +256,7 @@ void        rmdir_f(int, long);
>  void   setattr_f(int, long);
>  void   setfattr_f(int, long);
>  void   setxattr_f(int, long);
> +void   snapshot_f(int, long);
>  void   splice_f(int, long);
>  void   stat_f(int, long);
>  void   subvol_create_f(int, long);
> @@ -322,6 +324,7 @@ opdesc_t    ops[] =3D {
>         { OP_SETFATTR, "setfattr", setfattr_f, 2, 1 },
>         /* set project id (XFS_IOC_FSSETXATTR ioctl) */
>         { OP_SETXATTR, "setxattr", setxattr_f, 1, 1 },
> +       { OP_SNAPSHOT, "snapshot", snapshot_f, 1, 1 },
>         { OP_SPLICE, "splice", splice_f, 1, 1 },
>         { OP_STAT, "stat", stat_f, 1, 0 },
>         { OP_SUBVOL_CREATE, "subvol_create", subvol_create_f, 1, 1},
> @@ -1903,6 +1906,7 @@ zero_freq(void)
>  #define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
>
>  opty_t btrfs_ops[] =3D {
> +       OP_SNAPSHOT,
>         OP_SUBVOL_CREATE,
>         OP_SUBVOL_DELETE,
>  };
> @@ -4703,6 +4707,55 @@ out:
>         free_pathname(&f);
>  }
>
> +void
> +snapshot_f(int opno, long r)
> +{
> +#ifdef HAVE_BTRFSUTIL_H
> +       enum btrfs_util_error   e;
> +       pathname_t              f;
> +       pathname_t              newf;
> +       fent_t                  *fep;
> +       int                     id;
> +       int                     parid;
> +       int                     v;
> +       int                     v1;
> +       int                     err;
> +
> +       init_pathname(&f);
> +       if (!get_fname(FT_SUBVOLm, r, &f, NULL, &fep, &v)) {
> +               if (v)
> +                       printf("%d/%d: snapshot - no subvolume\n", procid=
,
> +                              opno);
> +               free_pathname(&f);
> +               return;
> +       }
> +       init_pathname(&newf);
> +       parid =3D fep->id;
> +       err =3D generate_fname(fep, FT_SUBVOL, &newf, &id, &v1);
> +       v |=3D v1;
> +       if (!err) {
> +               if (v) {
> +                       (void)fent_to_name(&f, fep);
> +                       printf("%d/%d: snapshot - no filename from %s\n",
> +                              procid, opno, f.path);
> +               }
> +               free_pathname(&f);
> +               return;
> +       }
> +       e =3D btrfs_util_create_snapshot(f.path, newf.path, 0, NULL, NULL=
);
> +       if (e =3D=3D BTRFS_UTIL_OK)
> +               add_to_flist(FT_SUBVOL, id, parid, 0);
> +       if (v) {
> +               printf("%d/%d: snapshot %s->%s %d(%s)\n", procid, opno,
> +                      f.path, newf.path, e, btrfs_util_strerror(e));
> +               printf("%d/%d: snapshot add id=3D%d,parent=3D%d\n", proci=
d, opno,
> +                      id, parid);
> +       }
> +       free_pathname(&newf);
> +       free_pathname(&f);
> +#endif
> +}
> +
>  void
>  stat_f(int opno, long r)
>  {
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
