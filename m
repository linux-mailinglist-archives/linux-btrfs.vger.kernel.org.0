Return-Path: <linux-btrfs+bounces-2593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7885C1AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73FE2870B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB57641C;
	Tue, 20 Feb 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS0MlfZ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6D626C6;
	Tue, 20 Feb 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447668; cv=none; b=Thsa4V9h1fyKa0ON+AFwBW16Yf2Yed/BRUTyQm5H8Mir7nTicwq5ZlBet1lw28yWF3NO6LIab30I9O3Ci+I/TNfmhZqCxnHFo7s9FmuIMA5FpJtRhrh6Iiyx1HejP1Jt6Ea2GItp7/npqVkCN7nciisSzUk9hO/BdMotlEdtcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447668; c=relaxed/simple;
	bh=FqygevkAe5lcGz7Su6avNkzg3RCKESgcbPZMqlQ1HSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePlw863tEUGUzyfSAF/inq1/8wpQ4894gXgeeRmF7v3mUDFszEDwhJIi+vTn/ZXq4x0Iou0fh27ibf1gjuoXD+Z38fbYx4MvHHz6aviQ0zHFfami2PfnsjQgk0+9g8nsERuRIHvcnr1JdRhmuWwLMj6pi4/jPiVuper9+IWL6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS0MlfZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1544AC433F1;
	Tue, 20 Feb 2024 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708447668;
	bh=FqygevkAe5lcGz7Su6avNkzg3RCKESgcbPZMqlQ1HSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RS0MlfZ15ThXuaqwuIVLYNuwgcbOXEhYFyxCT5nMvfoWPG16S3k5lkVTI7b8CAFQz
	 obmcOdgtRj2hNDjOaYe0Qb25mgzE7Fd8Z1I27utLO5jcqWtuay3yaEPk+3ixQd2fYd
	 CBPeNXt8VuUwEyBaAx5DH7jYZy4UO24J/CVgXYIWiEPoVJZQXTGdcMMCMwre2cl1Su
	 XVgZDaBdfcCuQZa3z54Aeu1al7iqX5rwCpaQDLPyIyDC4XYLUfR/ngy1ztgWXrPdkP
	 5Xwznke5dRr6Hsf5cG3PSJZ+z0m6xmEVIoxCwyS6SfYTjCMrebiKakxmXETSxikhX5
	 NzoHp/RQG8N2g==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e706f50beso334085966b.0;
        Tue, 20 Feb 2024 08:47:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMeaEmMWqxW0gw3oTQLBBTG45YXXzXE25X5LkXGrwE+HWkPbUoYfdapV5G7Tvv+8grJORmoGaSpM/8DDIlRLv1r+ox/+ZNqQ6XS+E=
X-Gm-Message-State: AOJu0Yyt8MgEqccOqydz0teLn+xaqescC0IF9TUafV2bMWpyqvleGdDb
	ij00GPOooaD+07+FnNsWU9l7AkT81eLb96d9Xc5ixlJvsZUSoFeygPZzhkQmKHw9gIgzSLkXXde
	5q379fq9JWgl32waNrk81ZQTFICQ=
X-Google-Smtp-Source: AGHT+IGNaDedGK63L2eKjneJeEryDXwPEq98aAzOfzllmwZGivfthI3VkmkTzObS5KAUvt/ufREITCVmP5LIKv7E8Ks=
X-Received: by 2002:a17:906:3451:b0:a3f:18c4:a2a8 with SMTP id
 d17-20020a170906345100b00a3f18c4a2a8mr818303ejb.29.1708447666426; Tue, 20 Feb
 2024 08:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <664d640d44d787f0b7c5cfba1b57abd2260b747c.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <664d640d44d787f0b7c5cfba1b57abd2260b747c.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 16:47:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6r9mhWQmFbDHTGRa0dD8M8N0WiqOHbP9j2nt7XyQ7PcA@mail.gmail.com>
Message-ID: <CAL3q7H6r9mhWQmFbDHTGRa0dD8M8N0WiqOHbP9j2nt7XyQ7PcA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:49=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> For easier and more effective testing of btrfs tempfsid, newer versions
> of mkfs.btrfs contain options such as --device-uuid. Check if the
> currently running mkfs.btrfs contains this option.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v2:
>  Fix coding style, add space before grep
>  Fix typp option -> options
>
>  common/btrfs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 797f6a794dfc..f694afac3d13 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -88,6 +88,17 @@ _require_btrfs_mkfs_feature()
>                 _notrun "Feature $feat not supported in the available ver=
sion of mkfs.btrfs"
>  }
>
> +_require_btrfs_mkfs_uuid_option()
> +{
> +       local cnt
> +
> +       cnt=3D$($MKFS_BTRFS_PROG --help 2>&1 | \
> +                               grep -E --count "\-\-uuid|\-\-device-uuid=
")
> +       if [ $cnt !=3D 2 ]; then
> +               _notrun "Require $MKFS_BTRFS_PROG with --uuid and --devic=
e-uuid options"
> +       fi
> +}
> +
>  _require_btrfs_fs_feature()
>  {
>         if [ -z $1 ]; then
> --
> 2.39.3
>

