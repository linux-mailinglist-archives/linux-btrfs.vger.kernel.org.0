Return-Path: <linux-btrfs+bounces-6954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F394945BC5
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 12:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A40283454
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE21DAC4C;
	Fri,  2 Aug 2024 10:05:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD814B952
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722593122; cv=none; b=CyGYeB5QeaDQboo9t5yV8bV4Mh8JuvKtbImUxDWx9XL7f8aAEfJ9NHSouM4PnxNRxCJLlpIuWHm0bxv74bWDzeqafz9CKSy4XGcbYyTeC4k0w3Sb4JIOjYn/sqNV7fauLsUnKN8WMyOEsIDuO0MkZuTLdN5a7ex1mQGsRqLiZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722593122; c=relaxed/simple;
	bh=NGPf0VbCXvlqYbOGaOEuH7RcGocW3kV/BHBDQBCGlMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqYkWlQl7VsqTLtuZ4Ckr9WjnuYXjtzXzCOWK9n4bIRTb+NnpdBCkAfzswoHfW3cS6fLa6g1G/RVK+m0rq61tnu4Wl18WKNlcSMKKLO2pD5b4VzPAWoFtZvKGPEVWPvPktSUmss7LFqfSMEjBl0gCx9BSLqE4gSfYjZb4gjRhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ef95ec938so9506958e87.3
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 03:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722593118; x=1723197918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Wg5jFQZkI8UOSqcY8UXsMwZtt4k7CR/aqiBcQAv/UE=;
        b=iSWZFikOcNlcYaSJzFNh+FWREPGdI6EMyCj58guYKtMzR0yaeqzOLWsGMl3pz2H4bm
         98V39GVRSi08SHVe8Ptp3P+oJeSU2o/FhIiwkdkT9jMEQ/ReEnRN43vr6fqlTunNqbow
         HsIce/KRZ5p/B2tbz2bGDkXgY917QLDT9x5RJktnNIioodfy1QVn9oUNKA206OEgE10Y
         mTsiEy65X9TLfsTBg7zqLTlB7QxKRhxE9cIarI4pcoy7h0Uk29xJGxnxqxJjlSzAdr0o
         KOLkPm6+andS0NZfSUuY+hJm8jdC9zwjARRIlqOX2r9CG8pNosgJIuQzQCHHxxjtbpf1
         AaCg==
X-Gm-Message-State: AOJu0Ywoqh95ARyA1LLJhu/h38AvCndR4F8zQQ6ULTjnv+RUTXmiXalo
	F5K7Uit2XW6B5uoDddTou5ISpNCxogfzxKTdDpv7oQn1K1Yb7vnm8meL0fxZ
X-Google-Smtp-Source: AGHT+IG3mmJFmNPmbEMZVYqJi0/Rpb7l7D0zxxUh3yoeeHxUMIk4ihswaUL905H5btah+5R/nH3sKg==
X-Received: by 2002:a05:6512:b08:b0:52e:9694:3f98 with SMTP id 2adb3069b0e04-530bb3a05c4mr1929622e87.27.1722593117940;
        Fri, 02 Aug 2024 03:05:17 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0ca17sm80139866b.84.2024.08.02.03.05.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 03:05:17 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so799996866b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 03:05:17 -0700 (PDT)
X-Received: by 2002:a17:906:d253:b0:a77:e48d:bc8 with SMTP id
 a640c23a62f3a-a7dc4e69cb8mr248978966b.21.1722593117014; Fri, 02 Aug 2024
 03:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627152156.1349692-1-maharmstone@fb.com>
In-Reply-To: <20240627152156.1349692-1-maharmstone@fb.com>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 2 Aug 2024 06:04:40 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8_FvnaH1AH+k3YPPT4Tmvn-e1xvsPYxo0rd946-MvTxw@mail.gmail.com>
Message-ID: <CAEg-Je8_FvnaH1AH+k3YPPT4Tmvn-e1xvsPYxo0rd946-MvTxw@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: add recursive subvol delete
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>, 
	Mark Harmstone <maharmstone@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:22=E2=80=AFAM Mark Harmstone <maharmstone@fb.com=
> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Adds a --recursive option to btrfs subvol delete, causing it to pass the
> BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE flag through to libbtrfsutil.
>
> This is a resubmission of part of a patch that Omar Sandoval sent in
> 2018, which appears to have been overlooked:
> https://lore.kernel.org/linux-btrfs/e42cdc5d5287269faf4d09e8c9786d0b3adeb=
658.1516991902.git.osandov@fb.com/
>
> Signed-off-by: Mark Harmstone <maharmstone@meta.com>
> Co-authored-by: Mark Harmstone <maharmstone@meta.com>
> ---
>  Documentation/btrfs-subvolume.rst |  4 ++++
>  cmds/subvolume.c                  | 15 +++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subv=
olume.rst
> index d1e89f15..b1f22344 100644
> --- a/Documentation/btrfs-subvolume.rst
> +++ b/Documentation/btrfs-subvolume.rst
> @@ -112,6 +112,10 @@ delete [options] [<subvolume> [<subvolume>...]], del=
ete -i|--subvolid <subvolid>
>          -i|--subvolid <subvolid>
>                  subvolume id to be removed instead of the <path> that sh=
ould point to the
>                  filesystem with the subvolume
> +
> +        -R|--recursive
> +                delete subvolumes beneath each subvolume recursively
> +
>          -v|--verbose
>                  (deprecated) alias for global *-v* option
>
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 52bc8850..b4151af2 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -347,6 +347,7 @@ static const char * const cmd_subvolume_delete_usage[=
] =3D {
>         OPTLINE("-c|--commit-after", "wait for transaction commit at the =
end of the operation"),
>         OPTLINE("-C|--commit-each", "wait for transaction commit after de=
leting each subvolume"),
>         OPTLINE("-i|--subvolid", "subvolume id of the to be removed subvo=
lume"),
> +       OPTLINE("-R|--recursive", "delete subvolumes beneath each subvolu=
me recursively"),
>         OPTLINE("-v|--verbose", "deprecated, alias for global -v option")=
,
>         HELPINFO_INSERT_GLOBALS,
>         HELPINFO_INSERT_VERBOSE,
> @@ -367,6 +368,7 @@ static int cmd_subvolume_delete(const struct cmd_stru=
ct *cmd, int argc, char **a
>         char    *path =3D NULL;
>         int commit_mode =3D 0;
>         bool subvol_path_not_found =3D false;
> +       int flags =3D 0;
>         u8 fsid[BTRFS_FSID_SIZE];
>         u64 subvolid =3D 0;
>         char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
> @@ -383,11 +385,12 @@ static int cmd_subvolume_delete(const struct cmd_st=
ruct *cmd, int argc, char **a
>                         {"commit-after", no_argument, NULL, 'c'},
>                         {"commit-each", no_argument, NULL, 'C'},
>                         {"subvolid", required_argument, NULL, 'i'},
> +                       {"recursive", no_argument, NULL, 'R'},
>                         {"verbose", no_argument, NULL, 'v'},
>                         {NULL, 0, NULL, 0}
>                 };
>
> -               c =3D getopt_long(argc, argv, "cCi:v", long_options, NULL=
);
> +               c =3D getopt_long(argc, argv, "cCi:Rv", long_options, NUL=
L);
>                 if (c < 0)
>                         break;
>
> @@ -401,6 +404,9 @@ static int cmd_subvolume_delete(const struct cmd_stru=
ct *cmd, int argc, char **a
>                 case 'i':
>                         subvolid =3D arg_strtou64(optarg);
>                         break;
> +               case 'R':
> +                       flags |=3D BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE;
> +                       break;
>                 case 'v':
>                         bconf_be_verbose();
>                         break;
> @@ -416,6 +422,11 @@ static int cmd_subvolume_delete(const struct cmd_str=
uct *cmd, int argc, char **a
>         if (subvolid > 0 && check_argc_exact(argc - optind, 1))
>                 return 1;
>
> +       if (subvolid > 0 && flags & BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE=
) {
> +               error("option --recursive not supported with --subvolid")=
;
> +               return 1;
> +       }
> +
>         pr_verbose(LOG_INFO, "Transaction commit: %s\n",
>                    !commit_mode ? "none (default)" :
>                    commit_mode =3D=3D COMMIT_AFTER ? "at the end" : "afte=
r each");
> @@ -528,7 +539,7 @@ again:
>
>         /* Start deleting. */
>         if (subvolid =3D=3D 0)
> -               err =3D btrfs_util_delete_subvolume_fd(fd, vname, 0);
> +               err =3D btrfs_util_delete_subvolume_fd(fd, vname, flags);
>         else
>                 err =3D btrfs_util_delete_subvolume_by_id_fd(fd, subvolid=
);
>         if (err) {
> --
> 2.44.2
>
>

Looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

