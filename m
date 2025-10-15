Return-Path: <linux-btrfs+bounces-17834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8948FBDE35C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD54019A40B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017DC31CA75;
	Wed, 15 Oct 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epo8xP7+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577ED31C588
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526582; cv=none; b=QsawCFH6QCz4PwHLUGHIG+Twucu+GD59rVIYUnyC+aLIFJXumPTmeMUntfAz5kq6LpcmWZLVL5jb3g+2VZUrSipKTO0hodsA8ormxfLeQxa2v/hXzqZORruxKJfI+cvY4YJYhWNCLaLGVbZbPoGISsU/3Hc+jIxQFLkgjjth0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526582; c=relaxed/simple;
	bh=88TkFDgRlIfQHgl5zZUJJfAxExgz6tw1uTTkiNBGftA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptX64Jlg8NI6AItfc40cO1MvqB7bLgv3ULgaXAJQH/rIH/jfLKGErmzIrqWfbzUMdyVJw3GaamDLyTAXmnkEaAWd6pI9TvyWMy+T6lzedkxN7bxeOIp92y2g9IG0VDDZkiJqWNumvQFr4jOZxmITjp5R4gSct0WuDQJvgtdoayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epo8xP7+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b48d8deaef9so1157620766b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760526578; x=1761131378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88TkFDgRlIfQHgl5zZUJJfAxExgz6tw1uTTkiNBGftA=;
        b=epo8xP7+PpLAo2TvR6GGCT3BgTQ0F/9gYN+cbz/m5/0aiMoNHQ2vfuJHdnEEg23LJF
         ga+iJMPws3j6dAU0D1JDRG5kEOnP6Kl/Np9Z7MBnsTVdzWjmoEPQBZrt2v3NQH/dnL2V
         6wyVSHLCKS+sNBnDMa3DrrSplTVp1T43XuJKJHoofz5qncS6fVlBBhJby9l0O2dzsn22
         BDCCut63+tIaIi1Nk5hOkPRc0aaFrR4FgAuzxtuOZ6nECGHJ7ivjj0A77HxXLNV9KHrR
         bE48VMKYKCw4llZ0ETy6yRx9NWlhvN8w/CSYgqkpxsj+xOrRQorWkVFncuSpBZuMOfbw
         Bd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760526578; x=1761131378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88TkFDgRlIfQHgl5zZUJJfAxExgz6tw1uTTkiNBGftA=;
        b=nWjHIV9dQbSKatReXuwP6OpU0PSko91kkgvVwV9KPsj3FGPpAw7CrLPkFl99gnO48f
         44TY/bWVb6Q/P7VQ0rnZw+5KT1umncb5n61Hde7W/5LClPCoILVlfXKQDuPVt8hqd5gp
         nAVcP+7ju8jocvo4ya+exPBHKmYMKy4w1AlRtxjkvbJ9rj2vUKx+Ouv2tHAJd6bLru4T
         p9cSZToRFdGWc3QinepWlDaxXHPiGmm91shG0k7+TKcUe4k3POp+lT0krOm/BtKQNSL+
         BdHY0brJyy7ZYdPC7HOHDj3aurqnZ+2Hy0LCtTEPbBo37+dENPIAflnBJ1cgq3ANDLKk
         34Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUSMH1c/vjzYveb3NCHUCcc/EqRkXYxBHmCAMZj/ggPPQjmriUjQj/FYRo8gTv+4OvnEFeCXeTvyV1idA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Y75dxujspqqAJrF8+PkY3r2V/6s7RK0VmnUWYslkXPqmsHlT
	6iEb2kFR6JFIMe/NDdaPuotgf6XpIQDLQGAwMsyElL5cs8C0fEyu1CV38jpELqxPj0Fz0efqYZT
	eOiBXWI9zDabtGKpq9xLobCMkRdHQKT4=
X-Gm-Gg: ASbGncvkEsrybu8TjXR+4HHDZYceDz1tP+kSt9VfxGGq/D15UqrD1ulKWcWpCW5EKOo
	bppPG2tw4ortJKlCiKt56V1kiHhR8h4lRhT3U4x/63CaEgOJy8QR9C7yeTkbj2avDSHlR8hFulC
	24VW5XwWPykqbN0KOeC1EJP6we43ybmi2kb0CvWJ31zbNyZNBZj0F2cGczX+iHz5fb6Vsdsr7Vs
	d/syWl0c6ANtqXzhcnUSAP0F+QBRIrssW3wQklLId5j9kPeeaW2QlmmGjWuE08hDi5VTA==
X-Google-Smtp-Source: AGHT+IENjDPxTkztbzr5F/4b/vkt/9YGbwIRgds1ThqVuYJojpUBDdNcgRHeSnatUXLVLK+HdDDWjzqOKNDZToZ4Kf4=
X-Received: by 2002:a17:907:2d0d:b0:b4e:f7cc:72f1 with SMTP id
 a640c23a62f3a-b50aaba1161mr2875382066b.22.1760526577879; Wed, 15 Oct 2025
 04:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014015707.129013-1-andrealmeid@igalia.com>
In-Reply-To: <20251014015707.129013-1-andrealmeid@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Oct 2025 13:09:26 +0200
X-Gm-Features: AS18NWCfEzFg8NKV02k0sHR2LvSmLeMLWcVIZrTlRnWiT-LzhBHhe8mgd_BcgMg
Message-ID: <CAOQ4uxhrQQmK+tc+eOjm7Pz2u=S6_2cnneyo4mNjVgyA7RNooA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl index=on
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>, 
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:57=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Hi everyone,
>
> When using overlayfs with the mount option index=3Don, the first time a d=
irectory is
> used as upper dir, overlayfs stores in a xattr "overlay.origin" the UUID =
of the
> filesystem being used in the layers. If the upper dir is reused, overlayf=
s
> refuses to mount for a different filesystem, by comparing the UUID with w=
hat's
> stored at overlay.origin, and it fails with "failed to verify upper root =
origin"
> on dmesg. Remounting with the very same fs is supported and works fine.
>
> However, btrfs mounts may have volatiles UUIDs. When mounting the exact s=
ame
> disk image with btrfs, a random UUID is assigned for the following disks =
each
> time they are mounted, stored at temp_fsid and used across the kernel as =
the
> disk UUID. `btrfs filesystem show` presents that. Calling statfs() howeve=
r shows
> the original (and duplicated) UUID for all disks.
>
> This feature doesn't work well with overlayfs with index=3Don, as when th=
e image
> is mounted a second time, will get a different UUID and ovl will refuse t=
o
> mount, breaking the user expectation that using the same image should wor=
k. A
> small script can be find in the end of this cover letter that illustrates=
 this.
>
> From this, I can think of some options:
>
> - Use statfs() internally to always get the fsid, that is persistent. The=
 patch
> here illustrates that approach, but doesn't fully implement it.
> - Create a new sb op, called get_uuid() so the filesystem returns what's
> appropriated.

FWIW this operation already exists in export_operations.
It is currently only used by pnfs and only implemented by xfs.
I would nor object for overlayfs to use this method if implemented
and fall back to copying uuid directly from s_uuid
(better yet make it a vfs helper)
Note that commit
8f720d9f892e0 xfs: publish UUID in struct super_block
was done for a similar reason.
The xfs mount option nouuid is the poor man's solution for
mounting cloned disk images.

Thanks,
Amir.

