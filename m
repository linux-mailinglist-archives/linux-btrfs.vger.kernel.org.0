Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CBF3D850A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 03:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhG1BCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 21:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhG1BCq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 21:02:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EBDC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 18:02:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s48so1116283ybi.7
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m/mROo/pNFzVb7IFMnaBfmctMvLVa9/Yf7JTAxmh7S4=;
        b=hrT2CmmscXZ8ZC0RftM5p/4kWFBGwbGmbY6UyVPS1f+sJfQb2qdgMaarwC7HewIxsR
         05VJKWxZa9Uoj2zoXpG6geBxyiJ6xFXsjbtOe+TMI3pG7mnmqQR3bXXbex+jKcpCESOO
         IpjgdnrTu4GnB1B3yXAA9gZbrxPV+GFea8X64cAZqU22ikUUC5v86Ey5mcJVxG1MQtKX
         ZrmppLuhxsaWLJoEvuwGzZPIym9w7gGyqPYcWol0Pkh1RiloLlg+2EKXtaIfNZnj6uW2
         W3XB1OTYjGbsZ+YYL9t+DPutrtgYFcGHx9jxsCSPUyCtdR8A4cCEUlbD4pI4QYwHgrUN
         HBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m/mROo/pNFzVb7IFMnaBfmctMvLVa9/Yf7JTAxmh7S4=;
        b=BYLnwPnoD93XPrLkPUmvwK4dLnxBRMX0L5UZ8U9ackE1UHiKvSB61LvTfTvERPef+S
         2D5f9AJP8q2RQdpQdY90x/ndzwUjGOcikobSFUe12hDfl6Ucc+zoE/vq2pvcfB2u2wHi
         bSiHTzXsrTR6tq2dybdSnHR/yOQMcFTYCHwH/6JC+wjV1EkALoVJY75tIiw8WbtEE/xX
         90maPc8FEyUA2UnoIgCASeWknooS/Mosex+o8kB3xKdcORW5js3Lc0A86z0nVY8/rDUn
         TgOWBnIGF9cMgVsqb5i6KItrq6weJecGODoG/cSPVWngVLKtA5BJiOTsS3w8FMCNs9w1
         zurA==
X-Gm-Message-State: AOAM531cQ6B5vS07q4zQoHHIBgs+7S9nhCyl31MZ/BbGhdO0WDXMz6+J
        e5SghM4QyPJmZTzLZ8m5tpIKZrr4ebolosepqJURm6AUAys=
X-Google-Smtp-Source: ABdhPJwNtwmSmSv5Qa+UFcP0Hke/g897jlQY7GubmFflf1iS1Woo/TP7jE+wbQFw6y7p117ihjxF3uq5Lbkbt1Viktg=
X-Received: by 2002:a25:9201:: with SMTP id b1mr7375334ybo.354.1627434164591;
 Tue, 27 Jul 2021 18:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <1b0ba76b40a8fc22f8a97124ddcc83d3164f1836.1627429989.git.osandov@fb.com>
In-Reply-To: <1b0ba76b40a8fc22f8a97124ddcc83d3164f1836.1627429989.git.osandov@fb.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 27 Jul 2021 21:02:08 -0400
Message-ID: <CAEg-Je9O=DahOUFCHyZ5+fYOKUUQjHmMAuZVKYPSkeeMsL8V4A@mail.gmail.com>
Subject: Re: [PATCH] libbtrfsutil: fix race between subvolume iterator and deletion
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 7:54 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Subvolume iteration has a window between when we get a root ref (with
> BTRFS_IOC_TREE_SEARCH or BTRFS_IOC_GET_SUBVOL_ROOTREF) and when we look
> up the path of the parent directory (with BTRFS_IOC_INO_LOOKUP{,_USER}).
> If the subvolume is moved or deleted and its old parent directory is
> deleted during that window, then BTRFS_IOC_INO_LOOKUP{,_USER} will fail
> with ENOENT. The iteration will then fail with ENOENT as well.
>
> We originally encountered this bug with an application that called
> `btrfs subvolume show` (which iterates subvolumes to find snapshots) in
> parallel with other threads creating and deleting subvolumes. It can be
> reproduced almost instantly with the following script:
>
>   import multiprocessing
>   import os
>
>   import btrfsutil
>
>   def create_and_delete_subvolume(i):
>       dir_name =3D f"subvol_iter_race{i}"
>       subvol_name =3D dir_name + "/subvol"
>       while True:
>           os.mkdir(dir_name)
>           btrfsutil.create_subvolume(subvol_name)
>           btrfsutil.delete_subvolume(subvol_name)
>           os.rmdir(dir_name)
>
>   def iterate_subvolumes():
>       fd =3D os.open(".", os.O_RDONLY | os.O_DIRECTORY)
>       while True:
>           with btrfsutil.SubvolumeIterator(fd, 5) as it:
>               for _ in it:
>                   pass
>
>   if __name__ =3D=3D "__main__":
>       for i in range(10):
>           multiprocessing.Process(target=3Dcreate_and_delete_subvolume, a=
rgs=3D(i,), daemon=3DTrue).start()
>       iterate_subvolumes()
>
> Subvolume iteration should be robust against concurrent modifications to
> subvolumes. So, if a subvolume's parent directory no longer exists, just
> skip the subvolume, as it must have been deleted or moved elsewhere.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  libbtrfsutil/subvolume.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
> index e30956b1..32086b7f 100644
> --- a/libbtrfsutil/subvolume.c
> +++ b/libbtrfsutil/subvolume.c
> @@ -1469,8 +1469,16 @@ static enum btrfs_util_error subvolume_iterator_ne=
xt_tree_search(struct btrfs_ut
>                 name =3D (const char *)(ref + 1);
>                 err =3D build_subvol_path_privileged(iter, header, ref, n=
ame,
>                                                    &path_len);
> -               if (err)
> +               if (err) {
> +                       /*
> +                        * If the subvolume's parent directory doesn't ex=
ist,
> +                        * then the subvolume was either moved or deleted=
. Skip
> +                        * it.
> +                        */
> +                       if (errno =3D=3D ENOENT)
> +                               continue;
>                         return err;
> +               }
>
>                 err =3D append_to_search_stack(iter,
>                                 btrfs_search_header_offset(header), path_=
len);
> @@ -1539,8 +1547,12 @@ static enum btrfs_util_error subvolume_iterator_ne=
xt_unprivileged(struct btrfs_u
>                 err =3D build_subvol_path_unprivileged(iter, treeid, diri=
d,
>                                                      &path_len);
>                 if (err) {
> -                       /* Skip the subvolume if we can't access it. */
> -                       if (errno =3D=3D EACCES)
> +                       /*
> +                        * If the subvolume's parent directory doesn't ex=
ist,
> +                        * then the subvolume was either moved or deleted=
. Skip
> +                        * it. Also skip it if we can't access it.
> +                        */
> +                       if (errno =3D=3D ENOENT || errno =3D=3D EACCES)
>                                 continue;
>                         return err;
>                 }
> --
> 2.32.0
>

LGTM.

Reviewed-by: Neal Gompa <ngompa13@gmail.com>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
