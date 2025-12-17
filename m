Return-Path: <linux-btrfs+bounces-19843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB392CC8BCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9914C30B601E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9BD336EE7;
	Wed, 17 Dec 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc67esoJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA72D0C9C
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987598; cv=none; b=ikkA/+I8JQlO3T0g06PE/jzt7LXhuALVX/vug9TeAGeP0EMZVjuZjUj4XHq2ZCGnBB4J8S7c+1lOKReYGIlDElsMMHvtFz5R9GFdG4rkp/o7fIzAZhzJUEQltxaWA2hucMsxyLptGG3fesHJ3wTADz5k9GytcAIJ1kgwqHwpUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987598; c=relaxed/simple;
	bh=QIUXseVnIlLDevsAN/EJ+K5Sy6kHt1begLNPif3qWB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MO2B2bVbZ1tke8czn2G8Ny2LsSnVONDEjFeTTY6YyR+OmCwddKy2JkAz4vZxiGwbqVJJJG5vAOkxnoORyWGYSBh5l34BO2zoetqy4BqM2m5m+Z/ouhFrCy0bjSxBH5X6lRaPdfxp72AfULhEEkhRVHjvP5MuJN0rGuph7FjeR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc67esoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71236C4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765987597;
	bh=QIUXseVnIlLDevsAN/EJ+K5Sy6kHt1begLNPif3qWB8=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=Bc67esoJsLgc4SE34zwDr6zfWNNFUxAKB/lGfEJBi+X6MBlTxuqW7vkZFgLHfkWAw
	 AZtlg6BCQ8Krag9OXPAZSXKxMLb1DRyjDZzsIffIZE2tI4CBCwXl71oc2PeRioOcZT
	 OhaMXnMaKc1kWyM2LF8AYLHOIH+NUVgTIZSlneEIjFMlgrZ4AC5WrRUHh7LB3upNmF
	 Qsm8ADhy5lYYQ/Oni0QHD018TtTPnNF3E2yMQl5nyWv/pV42p6NczKoZyDLAlKIjXh
	 WRsvmvbpO1KCpoWTrNny3yJAvDxX89Cahsj777WBoAbEIWdwj2zgJWy6yskWIF7364
	 szve3cpSec7LA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8018eba13cso66806466b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:06:37 -0800 (PST)
X-Gm-Message-State: AOJu0Yxxjh5EeAjHUJdRnSDdbQ4Za5yzzKEesAxfytW1Llj8bLPgUxWI
	XTnjJEwNq+1CxXFOzCBOCs9Knh7FcByGoQs886lo/19t/7trq6umC3HENxfTZFN93T0MrClI+NV
	5iNLtjhiMN+ZDAIYQyXaEebrdoz4x/8U=
X-Google-Smtp-Source: AGHT+IG4OChRzNJ2LFEY7QasPEBfBudZ/dL6zRV6bkjAhzgJxbJ8tS1hxGnklXmYR9jvUDY3W4yUHFwlPIA1drs17eA=
X-Received: by 2002:a17:906:c148:b0:b70:aa96:6023 with SMTP id
 a640c23a62f3a-b7d236e0348mr1892219366b.24.1765987595928; Wed, 17 Dec 2025
 08:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <de940c4488c9be72d8df22f48651b3c2f7d2978f.1765900568.git.fdmanana@suse.com>
In-Reply-To: <de940c4488c9be72d8df22f48651b3c2f7d2978f.1765900568.git.fdmanana@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Dec 2025 16:05:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Qixe0JaS_TMUKxZQ63LKVMatp_ufNu-fBRvQm-XYwQQ@mail.gmail.com>
X-Gm-Features: AQt7F2pma_iNTu3GsDVKni1_LZT01uy9Y1JwnLBOBqYD1PUY09_sF7P4y7Tfmts
Message-ID: <CAL3q7H4Qixe0JaS_TMUKxZQ63LKVMatp_ufNu-fBRvQm-XYwQQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid transaction commit on error in del_balance_item()
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 4:13=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> There's no point in committing the transaction if we failed to delete the
> item, since we haven't done anything before. Also stop using two variable=
s
> for tracking the return value and use only 'ret'.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/volumes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d580d8669668..102f7b85206c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3689,7 +3689,7 @@ static int del_balance_item(struct btrfs_fs_info *f=
s_info)
>         struct btrfs_trans_handle *trans;
>         struct btrfs_path *path;
>         struct btrfs_key key;
> -       int ret, err;
> +       int ret;
>
>         path =3D btrfs_alloc_path();
>         if (!path)
> @@ -3716,9 +3716,9 @@ static int del_balance_item(struct btrfs_fs_info *f=
s_info)
>         ret =3D btrfs_del_item(trans, root, path);
>  out:
>         btrfs_free_path(path);
> -       err =3D btrfs_commit_transaction(trans);
> -       if (err && !ret)
> -               ret =3D err;
> +       if (ret =3D=3D 0)
> +               ret =3D btrfs_commit_transaction(trans);

This misses an:

else
     btrfs_end_transaction(trans)

Otherwise we leak a transaction handle on error.
Will update it on for-next.

> +
>         return ret;
>  }
>
> --
> 2.47.2
>
>

