Return-Path: <linux-btrfs+bounces-6905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC359424C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 05:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804A61F248FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97D117BBF;
	Wed, 31 Jul 2024 03:08:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A714F70
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395331; cv=none; b=drh3ZAKWWWXvz1PvaSLBmIkFtMgdzzxIBmwCRdTzm4+UVzkuo8FOvbpyAyoDNexYKdivBdyPhnV123dkeYAs9Mfe94OyMHJkM17BdKpSOP/5pgp4SAsoQhvCzbkPpGGorRA7HFRcDbS+cYk9Ts1wyrSkh310uhsIbNcJ3VNLmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395331; c=relaxed/simple;
	bh=jAdomWYtR3X99mtQgZlNf52ED+6X5Gj4+JdLITTdTmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL3n3S0k/IafGnEBAzbiPjKyWUfWyB7IcYUy7Pi1YcgvPGIIXqixxFjFeewiX7iafGLlB1M6EmHfF5mvbTIOzeprdgmUOxrFi5KHPHLEonBTF3iqp7MqeJcfNSEBv/9rydxWer8Sy43JUAlTMn3D0nUnSuct/LdC77nOSRr66yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so619534566b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 20:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395328; x=1723000128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVRzHHCmRZEwExTQjPLjv6ZZAlypOTv6McvT5KdgMdo=;
        b=l7/S8Iak0IZy7TiD38u1Po9HCssd41uOxhaubRd85n2sD0mFRlVxKFPACn+67Aw9OJ
         QWogX9X3AvgVMD6xu7xfFzyWl3NOY1vmoczTmNJjK/t808D8NaXD/h2SOdWLFdlvafVU
         hqLQ0LKo7OyJBqTwVHrAMhTqz2lEF8AFvlqJC5dEqVdptP483bNmMmZ90eioptZkXmCv
         XYHGcZ2QkcNOofPH4hGhiX41e03w5GZG1HrWjbMHi7o9IeDFTzAMM6AU0vl1RkAxlZEe
         GZf+4kU/t5+Ans7YksoKOnwUZoNwoRj3xepaW+l/r0Msx1wV7AJlTszlCMvAkQwtwXaI
         XYyg==
X-Gm-Message-State: AOJu0YwFLAomz9+vWE4Es0BftzLK/1XFrpq1q8DfWQtHntNrbyrCsgkx
	jShcGlMCKyk5Ljfa5yuYhgHiVtBmSXfZ2WIIzh9NzAGJL8Tak3Wq6Iaf4kuE
X-Google-Smtp-Source: AGHT+IEa7PvG9+jK2A+WEd1yjkeov+TPAlWWdHJFOsgH314UoE20lc2RtCmeohEpC5pq9FIz3+lcyA==
X-Received: by 2002:a17:907:e89:b0:a77:d85c:86f5 with SMTP id a640c23a62f3a-a7d401361f3mr610526866b.53.1722395327454;
        Tue, 30 Jul 2024 20:08:47 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de7asm715083166b.66.2024.07.30.20.08.47
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 20:08:47 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34677so7721528a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 20:08:47 -0700 (PDT)
X-Received: by 2002:a05:6402:5190:b0:5aa:32bb:161 with SMTP id
 4fb4d7f45d1cf-5b021f0c55cmr10245298a12.22.1722395327046; Tue, 30 Jul 2024
 20:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <51e96d7a2754991bc369065d74290e7a436934c7.1722358018.git.josef@toxicpanda.com>
In-Reply-To: <51e96d7a2754991bc369065d74290e7a436934c7.1722358018.git.josef@toxicpanda.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 30 Jul 2024 23:08:10 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8a+_GnkxKHG2zmhHrofsV2nsM7ubq0xGtjuNj7Jen_Hw@mail.gmail.com>
Message-ID: <CAEg-Je8a+_GnkxKHG2zmhHrofsV2nsM7ubq0xGtjuNj7Jen_Hw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: emit a warning about space cache v1 being deprecated
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:47=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We've been wanting to get rid of this for a while, add a message to
> indicate that this feature is going away and when so we can finally have
> a date when we're going to remove it.  The output looks like this
>
> BTRFS warning (device nvme0n1): space cache v1 is being deprecated and wi=
ll be removed in a future release, please use -o space_cache=3Dv2
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Made it all one line as per Dave's comment.
>
>  fs/btrfs/super.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 0eda8c21d861..1eed1a42db22 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -682,8 +682,11 @@ bool btrfs_check_options(const struct btrfs_fs_info =
*info, unsigned long *mount_
>                 ret =3D false;
>
>         if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
> -               if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
> +               if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
>                         btrfs_info(info, "disk space caching is enabled")=
;
> +                       btrfs_warn(info,
> +"space cache v1 is being deprecated and will be removed in a future rele=
ase, please use -o space_cache=3Dv2");
> +               }
>                 if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
>                         btrfs_info(info, "using free-space-tree");
>         }
> --
> 2.43.0
>
>

Do we want to declare specifically when we'll get rid of this?
Otherwise this looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

