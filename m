Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C378181CDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 16:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgCKPux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 11:50:53 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36836 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgCKPux (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 11:50:53 -0400
Received: by mail-vs1-f65.google.com with SMTP id n6so1652863vsc.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dCNTZNZf/b634i1DN7OtrVegqEtHKJgFPQt3IWZzA4c=;
        b=Iz5XAdkNg4J1+ZlvrQBvBTe7LS/9qRmsWPi1ha6dW3eWCvZToIRUFBBWJD2qGRI+e6
         B/1yw2Gojbcuc4TzvxlXEUDyufy602XvZtN1ftldoflPYFzjLT6T3ct42nguzLz6zmya
         zgT5PF8APl3qDG94WjY8KlB7DOzpfrFHHCo9bctaOqtZPX7UoNiP7QugPXwSHaf/1Ru+
         m3i2f+GHOqVn6XbcOHIajjPx2cQ0h32sYFhBw1H2+p/RxlIuZiCUX24OW850kXIf+roM
         a1c0Xkq0tzheoPXoYetcK9I4eig2QuSiAVFxTnBjWfg4b3TgL5t4MPiUmYnEqcBjHeyy
         J+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dCNTZNZf/b634i1DN7OtrVegqEtHKJgFPQt3IWZzA4c=;
        b=JmObNJwZNF5ZYB4AQzgvXkqbupLzEDF3m/4M2s2Ojx+e668Ey/XCsZcWxr6SUPChxe
         YFX8/OLMtJHd+AYfZxkwRfcFnxVDL+x3xYU5Hx9DcTf6Zt+21KuXT1m/DvF89LUi83ib
         yDxDGTk8GM+wf8QQ47PDm4SK2IStbTARtfMbAo97HhiJUnfLiCZWddDbw40h5BmfZPLi
         P3QW+ZpA5KD79w7kUh8eVfisJnEn9mfXC61LivQa/AvYeN2LaLoXAx4AHkkmkVtdzxK3
         D/VLoXmvAIX7a2ORzgLYfs2deDmc3H0wt31CYElnefneLujfvUVsmJKNQcfaltWLnIF/
         27wg==
X-Gm-Message-State: ANhLgQ37dFO7fQ1dhp1/JXdsX81PYpBv06QOTJk1VkLkXtRw0TP7K1hn
        7sMdKQkN5HiuovlLOa2HNhHU2/C8YP52rpKHfWorCDqK
X-Google-Smtp-Source: ADFU+vuSBHsGn3DNces1dmlpH6xgICdR4zUDLbqoD7FyCrbJa1NiV7HK+m3hojUnWONl0VPiILYdN3tslmbodJgTLmg=
X-Received: by 2002:a67:7c8f:: with SMTP id x137mr2140786vsc.99.1583941851577;
 Wed, 11 Mar 2020 08:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583914311.git.osandov@fb.com> <ba4cd47585197cb490afbd5ad22725adfd909381.1583914311.git.osandov@fb.com>
In-Reply-To: <ba4cd47585197cb490afbd5ad22725adfd909381.1583914311.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 11 Mar 2020 15:50:40 +0000
Message-ID: <CAL3q7H5bbJV21PRFC_f-+hqvckc5dinQK=Nt4cK9bUzp10=3uQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/3] btrfs-progs: receive: remove commented out
 transid checks
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 8:17 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> The checks for a subvolume being modified after it was received have
> been commented out since they were added back in commit f1c24cd80dfd
> ("Btrfs-progs: add btrfs send/receive commands"). Let's just get rid of
> the noise.

Indeed. If they were ever in place, it would have never been possible
to do an incremental send and running dedupe against the parent
snapshot.
That particular use case used to cause send, the kernel side, to fail
(initially with a BUG_ON() and later with -EIO returned to user
space):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Db4f9a1a87a48c255bb90d8a6c3d555a1abb88130

If this code in btrfs-progs was not commented, it would have been
easier to find that problem.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.



>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  cmds/receive.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index c4827c1d..a4bf8787 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -345,15 +345,6 @@ static int process_snapshot(const char *path, const =
u8 *uuid, u64 ctransid,
>                         parent_subvol->path[sub_len - root_len - 1] =3D '=
\0';
>                 }
>         }
> -       /*if (rs_args.ctransid > rs_args.rtransid) {
> -               if (!r->force) {
> -                       ret =3D -EINVAL;
> -                       fprintf(stderr, "ERROR: subvolume %s was modified=
 after it was received.\n", r->subvol_parent_name);
> -                       goto out;
> -               } else {
> -                       fprintf(stderr, "WARNING: subvolume %s was modifi=
ed after it was received.\n", r->subvol_parent_name);
> -               }
> -       }*/
>
>         if (*parent_subvol->path =3D=3D 0)
>                 args_v2.fd =3D dup(rctx->mnt_fd);
> @@ -771,22 +762,6 @@ static int process_clone(const char *path, u64 offse=
t, u64 len,
>                         goto out;
>                 }
>         } else {
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
>                 /* strip the subvolume that we are receiving to from the =
start of subvol_path */
>                 if (rctx->full_root_path) {
>                         size_t root_len =3D strlen(rctx->full_root_path);
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
