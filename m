Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3C40D63F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhIPJch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbhIPJch (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 05:32:37 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80C0C061574;
        Thu, 16 Sep 2021 02:31:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id ay33so6617051qkb.10;
        Thu, 16 Sep 2021 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=A2Iia96pxfixNeVHvIK/3gOcz3FNSlkYOFHSjf8UkDs=;
        b=Z/0MiOhFfYt3ctm+hYPOgoqkeqpc4XfpyHWwVbd74eONJWlNMsho7KwrMoMTt3jmNc
         IHGITiqb+NJVoe+CSKNWczkOZDn/Zeu06X8K+3z/zy+6az59g+6vzCmShp051vzddETE
         SHhCq3ic8q3VPnIrdPGqpQwUXQjnwD0KlCSGP9dy+jSJ4g2uGY2JJojE41TXz+99bJau
         +a1O+gFpE2brtPe39Bvpi0LMUf+djwNgNg28/PyBBOXftD1nkgp2yUAwfslEkO9xLBIi
         JsO2mtUyIjZiGZMf1xv/FcsOj94vHhMUiihKeUIKBa7GwFUt1PenY2fogiXF2bXeAYew
         DHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=A2Iia96pxfixNeVHvIK/3gOcz3FNSlkYOFHSjf8UkDs=;
        b=J0Wu2fHpzw32hMWtvIB+yA6g2ndQ/2MjBMtY+8om3JxWQmvjH2iRtSVZZUkpw4Juwp
         Qiq+XlUlBFxJlKKDOYPaZMchILya7GeWpTBkOnzjatk1dhLo7RRrduYc8+nTfA4ZnJhA
         LMrN3blFhKUr+6mWe/hn4FD+GaPKtmm7diqTIAPMA8+Eoa8TQioNnjJtlUpumC4zC/ag
         uLxzU1nTsLPk3V0/OXMYxmCKUDs2HtIMdCydLA/JKtvVn/hyAQsGBrNmOCURDGHfh+TY
         hISMpCLJc05CuCmNGtlzgQO/5QTN4HyYDWFTOAs1u3WqMwTFfnSSdMTFw+D+zcFVpYwx
         lFtQ==
X-Gm-Message-State: AOAM5316ea3UVjZhUeyyttmUuGIx8zC/l4IdXFsyDL/ptcXGNqAQqbGY
        nX5JM359OugpGA4jFawrbPHaaMZt5rq37DcdtKc=
X-Google-Smtp-Source: ABdhPJw7tjiUFSlwG5uoIbh22odK4hg2khdmS0oT71+TN7k+0N2eSejm6G6mqzqb1Ws5vLyNIF1EGx3aNedCSoF8QMo=
X-Received: by 2002:a05:620a:5a7:: with SMTP id q7mr4114196qkq.163.1631784676081;
 Thu, 16 Sep 2021 02:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210906012559.8605-1-baptiste.lepers@gmail.com>
In-Reply-To: <20210906012559.8605-1-baptiste.lepers@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 16 Sep 2021 10:30:40 +0100
Message-ID: <CAL3q7H65GG54XcOOhn1Xc-4tMBO+NuLKrgC9AiFEY8=iqwGn+g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: transaction: Fix misplaced barrier in btrfs_record_root_in_trans
To:     Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 6, 2021 at 2:38 AM Baptiste Lepers
<baptiste.lepers@gmail.com> wrote:
>
> Per comment, record_root_in_trans orders the writes of the root->state
> and root->last_trans:
>       set_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
>       smp_wmb();
>       root->last_trans =3D trans->transid;
>
> But the barrier that enforces the order on the read side is misplaced:
>      smp_rmb(); <-- misplaced
>      if (root->last_trans =3D=3D trans->transid &&
>     <-- missing barrier here -->
>             !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
>
> This patches fixes the ordering and wraps the racy accesses with
> READ_ONCE and WRITE_ONCE calls to avoid load/store tearing.
>
> Fixes: 7585717f304f5 ("Btrfs: fix relocation races")
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
> ---
>  fs/btrfs/transaction.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 14b9fdc8aaa9..a609222e6704 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -437,7 +437,7 @@ static int record_root_in_trans(struct btrfs_trans_ha=
ndle *trans,
>                                    (unsigned long)root->root_key.objectid=
,
>                                    BTRFS_ROOT_TRANS_TAG);
>                 spin_unlock(&fs_info->fs_roots_radix_lock);
> -               root->last_trans =3D trans->transid;
> +               WRITE_ONCE(root->last_trans, trans->transid);
>
>                 /* this is pretty tricky.  We don't want to
>                  * take the relocation lock in btrfs_record_root_in_trans
> @@ -489,7 +489,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_han=
dle *trans,
>                                struct btrfs_root *root)
>  {
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
> -       int ret;
> +       int ret, last_trans;

last_trans should be u64, as root->last_trans is a u64.

Other than that it looks good to me.
Thanks.

>
>         if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
>                 return 0;
> @@ -498,8 +498,9 @@ int btrfs_record_root_in_trans(struct btrfs_trans_han=
dle *trans,
>          * see record_root_in_trans for comments about IN_TRANS_SETUP usa=
ge
>          * and barriers
>          */
> +       last_trans =3D READ_ONCE(root->last_trans);
>         smp_rmb();
> -       if (root->last_trans =3D=3D trans->transid &&
> +       if (last_trans =3D=3D trans->transid &&
>             !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
>                 return 0;
>
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
