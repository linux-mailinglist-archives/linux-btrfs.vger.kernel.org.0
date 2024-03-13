Return-Path: <linux-btrfs+bounces-3267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F187B55F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 00:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3ED1F22C7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 23:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282C5D75A;
	Wed, 13 Mar 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVGIVh6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578401E480;
	Wed, 13 Mar 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373890; cv=none; b=gb8/xnsCeEeVbosmNXzQRLbIspncZPPPJULV53Ochhknheq0H9yfJ97jJqHqTYubLvlhKbGVccGoSLjDEcIvajdYa+IWsMWe8MLjK7Q3NF4hy8miaMh/+ulaL/OkuSyfXaiTWvleKCZAENC1mGGILIO/KxsByMqMVdEjwiHlRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373890; c=relaxed/simple;
	bh=GjpCbexXpLMXd1IAkFUOU7wqs4IKJrvCV6IEnuALe98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOC4s5r7MFZrVjVn+6tPorm59aNqEYeuSrKiBELHrYfKWZwcempgbxhRVe4juCQrdZCky6hEDwTjlgr9nNYlcaudNiuqveOBm8gdwXDqUjAvkjzlDwNgUTsPdgNzcJlXEkdVqJxeLPXKckoKYcxaVlJmnIb0XPAMskn6KmTFbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVGIVh6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03FEC43394;
	Wed, 13 Mar 2024 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710373889;
	bh=GjpCbexXpLMXd1IAkFUOU7wqs4IKJrvCV6IEnuALe98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GVGIVh6IOeTDcCB8cC1zNzFsxvG6HSKYsnSbCTkfVaggCJMHXgEKBYvlz4r+37r+L
	 tD7lvDZTr9+ctljUSVnsy5sTceIdrZhsZNc7XbkdSOjk2BPlsbrL5VlcPyNE0HOTrO
	 ru86NZ8BL/Cv8lDxuSj+qkFAMrRJLe/iKOtt+yAPQ73TnNBXlNDlnCXYYZu0gBkgTK
	 9aWF6bh/TNNfDONIE2FFl+AUdhTS1cJJIqtj0mxt/rL8wy2sS2IQO50jXboPolIZdW
	 QRAD/yFryRJ5oxqf8T5/LaJlCoc9lzXCCWkt0ZR+e+VnOGZvgeGHSb7q1TdgdQOzIA
	 u+jxs+9hw3Tbg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513a08f2263so534101e87.3;
        Wed, 13 Mar 2024 16:51:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFWaWwJkZJrsSE9RH88stvRb16dr2bdB+ir2MVi9Zfzp8L8ZcE3oHDjfiPOfiTpGCTm5g3UubH1jTjtPgDk5Z1du3iXiDTrw==
X-Gm-Message-State: AOJu0YwL5igbSQMum20SC0PyLYLIzE8tI0/XSKoCrIc9Yf3qkcRLG9XJ
	6ArsZjoZsD/KPiE+Wl7VBgHgDMqWluGQ6poDSrUFiIXsbKTWWhgiqtaTVfXi1n2j2Ffc9zwtoPh
	N6DcE7b7DjtNmdHGxUok/4PsbGjA=
X-Google-Smtp-Source: AGHT+IFC5MqtiTG9CU8SOHsz4iN2pmyLhf2pX4wh4MP+q/nEkLjV+TWBOIt1RyzmP2XK7X8aCjpyC1oJ1Z5fPL6cTY4=
X-Received: by 2002:ac2:5b5b:0:b0:513:3435:5120 with SMTP id
 i27-20020ac25b5b000000b0051334355120mr40147lfp.32.1710373887867; Wed, 13 Mar
 2024 16:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
 <37d57d3ae473b67270137151e4fa18ed7464cba1.1710373423.git.boris@bur.io>
In-Reply-To: <37d57d3ae473b67270137151e4fa18ed7464cba1.1710373423.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Mar 2024 23:50:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4yP5r3NOEjT3ddMkaoGhgz39+sJqkdNoBgD9WDG986YQ@mail.gmail.com>
Message-ID: <CAL3q7H4yP5r3NOEjT3ddMkaoGhgz39+sJqkdNoBgD9WDG986YQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix _require_btrfs_mkfs_uuid_option
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 11:46=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> currently, this helper causes tests to fail on my system due to
> unexpected warning messages about dangling '\' characters from grep.
> Change the invocation to not escape the '-' characters but instead to
> use -- to instruct grep that the options list is over. Fixes
> btrfs/31[345] for me (and I believe the btrfs github ci)
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  common/btrfs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index 3eb2a91b7..aa344706c 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -93,7 +93,7 @@ _require_btrfs_mkfs_uuid_option()
>         local cnt
>
>         cnt=3D$($MKFS_BTRFS_PROG --help 2>&1 | \
> -                               grep -E --count "\-\-uuid|\-\-device-uuid=
")
> +                               grep -E --count -- "--uuid|--device-uuid"=
)

This was already fixed and it's in the patches-in-queue branch:

https://lore.kernel.org/fstests/ef2df19486ef71adccd14b3df0bf475ecc7f3b38.17=
09737287.git.fdmanana@suse.com/

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/log/?h=3Dpatches-in-=
queue

>         if [ $cnt !=3D 2 ]; then
>                 _notrun "Require $MKFS_BTRFS_PROG with --uuid and --devic=
e-uuid options"
>         fi
> --
> 2.43.0
>
>

