Return-Path: <linux-btrfs+bounces-6960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6C945DCB
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 14:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AAC8B22E0D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ED71E2893;
	Fri,  2 Aug 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKnt4piW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58F14A0A0;
	Fri,  2 Aug 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722601787; cv=none; b=Xc7EL9Tlmk44NiCjCKeHxztnuiRpjMQ8u9RxUb6KpHpLLrxsHMRVNLME/xFV/SnsYhyn4krrdN0OJlnsv7JwyZaAHxsZY+NyH9jmuJ8ENxRHVec/AnFVGuZrIMTB7grOVPUIBGugGv3nyFJzLE5A4yyQSgt13RZWsRhJvhA6dQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722601787; c=relaxed/simple;
	bh=TPZ8aWuX8dcV5p3KIElIaSI7CNBcw6WTN9JPjFF6k6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRH6XguPlGwo5zYW135ki936A1sVTEZA9Bmyf8C6uHF4UWGiIK6LATjuOVLwK+lZel1aiFptzzaGJYKFUuVH2jBRyxoSagT+wBNQ8th5pQ25b38oc/opN/Xto2zxNeWhZdlJkzH9kEVJnRYor+OJ13ca9AO3pbnhrW/ZTdzU6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKnt4piW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCF0C4AF11;
	Fri,  2 Aug 2024 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722601787;
	bh=TPZ8aWuX8dcV5p3KIElIaSI7CNBcw6WTN9JPjFF6k6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XKnt4piWORyEWiUf3bbdvvWeetpNqC+f7iEkj8//WFYGtw4D1VFrj+steO5E5dDxJ
	 ySK7dm4ZzYa3c2XStQgc0rKVZw5KPcNdya/TaNHY8iLXdm5dU9Z3KVEm/neSX0ULNU
	 WtNCkvOG5y8fRy32LmV8WbqbGll3lUGc7CCehq1JQnk+XgtmBLK8Zio16j5WJmAT9c
	 BfGV7JcJMVlblUNt+xrE4U+3yjhLpGIc91hitcxqZAq/iml0rmvusmId0RPzPev/hy
	 MAp31cVI3+nUCz8sj64WoUkRsQD0Uuj3W18ZUGqSz/v9gLXEjWLRUIuT2mGukAq+4d
	 qgM1LaLjJvWWg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so11736049e87.2;
        Fri, 02 Aug 2024 05:29:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl7Rd70THJb5SnbH5YK2lMaXsV7DbppS7YHz+uDKT2Pwsd8ciyEKECM0XuHSyUISUZa6XannEAri4ra0Vc1eyjD8eBKSJhHoNRO4jNTXi5hfat5o7sFhGKJFTVpiLZgdPcfQhorpIvtlU=
X-Gm-Message-State: AOJu0YxROJIoHbotBAeyYeg1yji/YZrgC7uLLvBErMWAR8ewUIH2PY7f
	OTIV2jlcCSeRH64aTNhRukR4K3T8jJBhN0Dn1ujCFH2aLjxOo6IPnJkM2UqxyyTuIN2+QAG4CX1
	2WvAcOLW4SHlUjjq3kQYO26cHkn0=
X-Google-Smtp-Source: AGHT+IG8bBjNKWGKaKUm9N02/bROr4Jw7YD0IkF2WYIGiUSmueMOUr8Mj5a+pvmWsTT3zT2FcuV8T1kELjQxe5KlLbk=
X-Received: by 2002:a05:6512:a93:b0:52e:9cb1:d254 with SMTP id
 2adb3069b0e04-530bb39dc80mr1949529e87.46.1722601785409; Fri, 02 Aug 2024
 05:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dfd631061eaeb4bc@google.com> <tencent_8F5362E361A97883B8444B1763F777C6DF05@qq.com>
In-Reply-To: <tencent_8F5362E361A97883B8444B1763F777C6DF05@qq.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 2 Aug 2024 13:29:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7d92JC_ZHp2cZ_tWyy-+qQkqG9nVgYSTi06+GAbYpNbg@mail.gmail.com>
Message-ID: <CAL3q7H7d92JC_ZHp2cZ_tWyy-+qQkqG9nVgYSTi06+GAbYpNbg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Add missing skip-lock for locks
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com, clm@fb.com, 
	dsterba@suse.com, fdmanana@suse.com, hreitz@redhat.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 12:59=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> The commit 939b656bc8ab missing a skip-lock in btrfs_sync_file,
> it cause syzbot report WARNING: bad unlock balance in btrfs_direct_write.
>
> Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during =
direct IO append write")
> Reported-and-tested-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7dbbb74af6291b5a5a8b
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

I had already a submitted a fix for this hours ago:

https://lore.kernel.org/linux-btrfs/7aa71067c2946ea3a7165f26899324e0df7d772=
e.1722588255.git.fdmanana@suse.com/

Thanks.

> ---
>  fs/btrfs/file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 9f10a9f23fcc..9914419f3b7d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1868,7 +1868,10 @@ int btrfs_sync_file(struct file *file, loff_t star=
t, loff_t end, int datasync)
>
>  out_release_extents:
>         btrfs_release_log_ctx_extents(&ctx);
> -       btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
> +       if (skip_ilock)
> +               up_write(&inode->i_mmap_lock);
> +       else
> +               btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
>         goto out;
>  }
>
> --
> 2.43.0
>
>

