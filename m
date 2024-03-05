Return-Path: <linux-btrfs+bounces-3013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98067871C53
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 11:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79BD1C22E0C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C935810C;
	Tue,  5 Mar 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6APm+q4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A17548F6
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635634; cv=none; b=kQ9EODQ+mBro66OszBz2CdTYoleks/rcrd/9LHMsARwUG61IREr7NMzXWADPQLTCsk8vFGgban0b/Vwjz0ffXnXveV8VpdHkOVt/o7HF1RiBhiyqkts00sggwdPkrRN6/VZHHFZgGq8yIQB1WArU1hFsy+fwfkuRlip1kZvZDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635634; c=relaxed/simple;
	bh=UAvw/o5DWI7aRcrPu2A0EsK+imRicMtNovVvt3PK57A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGQ5KI0xbyBcLpIZ2NjXUroqcnUotc00wwcfXyzPNsvQ6iGsn97fcrRMDaB+IysnTF0/aZSG0qn89UsndU9PCfpM00k8VY5SvKbXneNu8x2hM2RqIIFrp4SZW4uAr6lPTF4ChzprrIZQmaCs+iMTDzfHQyPQi+U5nx1cJJ9mKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6APm+q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8AAC433F1
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 10:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635633;
	bh=UAvw/o5DWI7aRcrPu2A0EsK+imRicMtNovVvt3PK57A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S6APm+q4fnCFlJUETVVZp0WJgj8hNMCA1bRMw8jlmPmFd6AbHxLh/W4H3ELGXmbxJ
	 bJipdi3giM7uqDML+1Y2mIMxXYaozSIPcDSm9Exv19uwnuqCL06Gsy39o2ybrRzfQf
	 kRnWRXC0ntnjA1OoL3F3NZm4yY5RBbpFubKvgLjoj6rJGOha7ob8gcgSCxg+t8TSgs
	 EEp/0qiqMT7H6RLMjZ7WQyMw/Dbr97a8ETZztE+SJj4+DFkB9zCum29PtO8Ft3EJZQ
	 y0n3KuLKPwsF8gjLUQ89oUCNPh8YKqdAf/KyaGZeVm+rY+mCfITMxK4EK9mEHbv1fQ
	 J1G7zXJt6ysMQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a456ab934eeso244088166b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 02:47:13 -0800 (PST)
X-Gm-Message-State: AOJu0YwlkLVECVebqZn52WRC1eHTfUmbQLFNIvj7Z68XuqTzdOEZzrQF
	CnxWjrJ9Af7Q/SNFPxIQvcfExHXf48/JggZDkgwjPIDl2tDQ0qQm9J6+HEpPW/7CP5eBz/ddgIV
	n4uCL1wRv+KsdVHCLUQrbIHkSygg=
X-Google-Smtp-Source: AGHT+IFEv02+1oD5gK7pLuiVVQzbCvAd1nyyD6dXT+MRXTkhWNP3JBIMOZre8IwYbNxIN55AzDr/1VfPp3oRNPWs3tg=
X-Received: by 2002:a17:906:3b17:b0:a45:47c6:84d8 with SMTP id
 g23-20020a1709063b1700b00a4547c684d8mr3537450ejf.13.1709635632282; Tue, 05
 Mar 2024 02:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fb513314c27317128426ab6e84bbb644603e65f5.1709628782.git.jth@kernel.org>
In-Reply-To: <fb513314c27317128426ab6e84bbb644603e65f5.1709628782.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Mar 2024 10:46:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7-GVYr8S1mgim9khOLM7y-6rAhGyj7auEPX_BMUFpHGg@mail.gmail.com>
Message-ID: <CAL3q7H7-GVYr8S1mgim9khOLM7y-6rAhGyj7auEPX_BMUFpHGg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix memory leak in btrfs_read_folio
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 8:54=E2=80=AFAM Johannes Thumshirn <jth@kernel.org> =
wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> A recent fstests run with enabled kmemleak revealed the following splat:
>
>   unreferenced object 0xffff88810276bf80 (size 128):
>     comm "fssum", pid 2428, jiffies 4294909974
>     hex dump (first 32 bytes):
>       80 bf 76 02 81 88 ff ff 00 00 00 00 00 00 00 00  ..v.............
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace (crc 1d0b936a):
>       [<000000000fe42cf8>] kmem_cache_alloc+0x196/0x310
>       [<00000000adb72ffd>] alloc_extent_map+0x15/0x40
>       [<000000008d9259d5>] btrfs_get_extent+0xa3/0x8e0
>       [<0000000015a05e9a>] btrfs_do_readpage+0x1a5/0x730
>       [<0000000060fddacb>] btrfs_read_folio+0x77/0x90
>       [<00000000509dda36>] filemap_read_folio+0x24/0x1e0
>       [<00000000dee3c1b4>] do_read_cache_folio+0x79/0x2c0
>       [<00000000bf294762>] read_cache_page+0x14/0x40
>       [<0000000048653172>] page_get_link+0x25/0xe0
>       [<0000000094b5d096>] vfs_readlink+0x86/0xf0
>       [<00000000698ab966>] do_readlinkat+0x97/0xf0
>       [<00000000a55a2b4c>] __x64_sys_readlink+0x19/0x20
>       [<000000006e1b608e>] do_syscall_64+0x77/0x150
>       [<000000008fcc6e49>] entry_SYSCALL_64_afer_hwframe+0x6e/0x76
>
> This leaked object is the 'em_cached' extent map, which will not be freed
> when btrfs_read_folio() finishes if it is set.

Ok, so this fixes "btrfs: pass a valid extent map cache pointer to
__get_extent_map()".

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/extent_io.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 65e4c8fc89b1..832be9030aa1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1162,6 +1162,8 @@ int btrfs_read_folio(struct file *file, struct foli=
o *folio)
>         btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>
>         ret =3D btrfs_do_readpage(page, &em_cached, &bio_ctrl, NULL);
> +       if (em_cached)
> +               free_extent_map(em_cached);

There's no need for the if not-NULL check.
Like most freeing functions in the kernel (kfree, kvfree, most of
btrfs' own) and user space, free_extent_map() ignores a NULL pointer.

Otherwise it looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>         /*
>          * If btrfs_do_readpage() failed we will want to submit the assem=
bled
>          * bio to do the cleanup.
> --
> 2.35.3
>
>

