Return-Path: <linux-btrfs+bounces-10190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092039EAF98
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 12:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A82188C649
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC62223328;
	Tue, 10 Dec 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmwZR4rj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A837212D83;
	Tue, 10 Dec 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829159; cv=none; b=u8wfxLHBzNoawo+z2ZHlINkDJ3tXU6rP2LgIa/3TR5exkrbssV5OYWZxEWx28/Mthld4cG0rg4bb8kZBMAzS59SHIeW9V6jdzCp8xj45fOsNvvqJBPUjyLfgggLajZcJkiP5vlFRqEqv54b/BDjx5X6WNE/m+T4qnOGwuIWXCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829159; c=relaxed/simple;
	bh=O33GV8Sux0/WNmhXmS327Q7pStGSwoMuprQ/gPzNlpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5Mh3u444Hy8B3NF1OD7H+qUdHj6BozVL5Ib0XJwv2wPxEAJ/prTAebaEXOsoSxtmqof7yVLPciRoyiTkWvYOUHJlq3caBc0busR/5oA20hi50PxVcY4X8lq8V8Mw9l8luizmVUTorypBII6sc1vfT2q4hOjVvIIO/MvUbshfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmwZR4rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A73C4CED6;
	Tue, 10 Dec 2024 11:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733829158;
	bh=O33GV8Sux0/WNmhXmS327Q7pStGSwoMuprQ/gPzNlpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AmwZR4rjcSN0F5zt4czwnZk3TR1G1IPp8cbcK2n6MR+akcq9WILmUtkoG1lgq2AGJ
	 wKfOHK4VQ2KqzbfvCdqqDpgrMYZqV6rFJB5xnJrB+rrvE8AU6IiAbidBWnd8LnNiTA
	 41CXjoiF2LwDb+bhcx1V1EOP9cvbSIqjgPyv1bFtvFR3qxMsDH+UMq7m9UfNNR34wx
	 H5Heumqh4OPPX6GpJk/ILiZ2QxWgNtfKTNhLXScjUsBKBB3Fi3l5ZvDU4GngD+N+Ve
	 pPsodjDOF43QUwsVcVnVPHCbu7RhuL+aiXMiQW0unsiWvE4wGM7XOEFjlK2852kA6e
	 kKXTUB2qGfaWg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso5087073a12.3;
        Tue, 10 Dec 2024 03:12:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJiGcs58X8mLYjuaDFZ6pYakKXfaBrrSehPfGWaSJj4UpsU1gS4DJya06FM8f9yC49U6lItjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bHwJNrgWyYu20XiGsKCf0TF4TyrBfBMlavXumftLivXaZCTc
	wqlLKEN2gfONrjRQt3HCEO4zgqq8DKYEHIQ6pL3OYttX7Kw42ZvYLohzlW/i9prqUHFrc+Q4q/W
	HF2k2u1MX4yEkZ3bgK+HPGntCtu8=
X-Google-Smtp-Source: AGHT+IHTarIEHvy+7SBUinFTvo8ADr9FaLU8/YqFdFfqVcpBvLOQaC4xD98d2KrEZ+DMSYy86QHh5dvwzHByv24xmKY=
X-Received: by 2002:a17:906:308d:b0:aa6:7c36:342d with SMTP id
 a640c23a62f3a-aa69cd3734dmr415162066b.3.1733829157536; Tue, 10 Dec 2024
 03:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <037d2532a0f9ef545cf20fee903fc22936ad1bdc.1733806379.git.wqu@suse.com>
In-Reply-To: <037d2532a0f9ef545cf20fee903fc22936ad1bdc.1733806379.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Dec 2024 11:12:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ENE3L126i9uhh2qe_Op1mKeHds6HaQgnUL7F8KS3KAA@mail.gmail.com>
Message-ID: <CAL3q7H5ENE3L126i9uhh2qe_Op1mKeHds6HaQgnUL7F8KS3KAA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: output the reason for open_ctree() failure
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, 
	Christoph Anton Mitterer <calestyo@scientia.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:53=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a recent ML report that mounting a large fs backed by hardware
> RAID56 controller (with one device missing) took too much time, and
> systemd seems to kill the mount attempt.
>
> In that case, the only error message is:
>
>   BTRFS error (device sdj): open_ctree failed
>
> There is no reason on why the failure happened, making it very hard to
> understand the reason.
>
> At least output the error number (in the particular case it should be
> -EINTR) to provide some clue.
>
> Link: https://lore.kernel.org/linux-btrfs/9b9c4d2810abcca2f9f76e32220ed9a=
90febb235.camel@scientia.org/
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7dfe5005129a..f6eaaf20229d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -971,7 +971,7 @@ static int btrfs_fill_super(struct super_block *sb,
>
>         err =3D open_ctree(sb, fs_devices);
>         if (err) {
> -               btrfs_err(fs_info, "open_ctree failed");
> +               btrfs_err(fs_info, "open_ctree failed: %d", err);
>                 return err;
>         }
>
> --
> 2.47.1
>
>

