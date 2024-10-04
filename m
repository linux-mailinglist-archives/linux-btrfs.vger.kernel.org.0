Return-Path: <linux-btrfs+bounces-8561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832199905F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D18A1C21FB4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528A217330;
	Fri,  4 Oct 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt6CT1tz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B9215F6A;
	Fri,  4 Oct 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051919; cv=none; b=MQuQUrhkKF6Jht7OcERBs+zbRNyS6Gx9SklUETAtLnAfZsY0FbRAeQAXklPU6CLh4ohIuFuVjzg8iJOLDExNJ7yfTJgqsyrjTlyr4S8TNKfSrOrESlzVAnnMnObaGq2exaaihOg9Xn9Fz6pu5eHRb9i3guOJJqpRB8EKplEhuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051919; c=relaxed/simple;
	bh=wp87TzXy8arOOizSxy3nPf0PPkUbIlH0ZKswDWUROkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnRaiMlBi1xbR2iKgW99Efw/trhfEN+oTVCfV6Rv+cd/BLZ4TdA8x5W41fFNInUxEdPeS7jE8nfDiFHZN2Fel1ROiWwRyPA1i6UJWEn28YdyV/yS6L+COgI5qsDJxht/9f8I0iu5laBrslKDYspUybl2lZVu9J94hfBAiuzcLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt6CT1tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1D2C4CECF;
	Fri,  4 Oct 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051918;
	bh=wp87TzXy8arOOizSxy3nPf0PPkUbIlH0ZKswDWUROkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xt6CT1tzAyUvGuvWWqFcHNtzgz8NWRQnKRDa2T8kQ7WGvHiERZZbV3a1JQvN7tX6c
	 otWpG739daOu6B7rwu3fBTK3uQTExcD0mNI80Stk3gwK04ofIr9HTdAY9yThCS9WvO
	 rkWBKHGPG3ZGabPkFBM30NhGd8db30/+jbRuXTzNXLp5JVCn4Xjrl6XtAqFSnlzTVf
	 H9iy9f+bjghl/HinJtBCJ/pHY9UGx1wGUlYqe/aQL+vrh43Qthghr+2KjZZ+4wjY4O
	 X2Qd5Q34JA8AOHyGFUgttaUvEqsnWoDFb9Ok53G16nNMWGwIsNsWb4tFLauBdFstwz
	 1F6VbF8KCc9lg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8ce5db8668so343899366b.1;
        Fri, 04 Oct 2024 07:25:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg9BD1UDLxDke5CTa8Xw8kxk9dOpAv7tlUubp/qYKA45EiXvxac0dEA3eG6bvOnY8evtH6E/lRrIA4gg==@vger.kernel.org, AJvYcCWlsArqJEC2505+0EoO1l5hRY02Qxh0e3nzdcaKUS7ljwACJbqRydgZ8di0py+qmsS0ynqdH2cV/x9xJNEL@vger.kernel.org
X-Gm-Message-State: AOJu0YwexKYO5GX9Vvzii3xIinzeX1cHco3/lNfPsgkoHZphtxZtUfWP
	zOpkvFwHt17r3S3guF6Wlz48GQHKWUMVqDNR8iAg/pOO58VnoUqGHZ9BJ6Wmw2sB/LHg9M/isfg
	Qxs4wuPMoI3HN1t99+4uvYqN/LL4=
X-Google-Smtp-Source: AGHT+IG9JcV+Te1SmvxoahUcxOg6QuaJAQN16qmFLfUGKgYUBZVSSC2m6JqzJk6Cm2lD0uIUsWOcf5QNy+dJvIhUIpY=
X-Received: by 2002:a17:907:6eab:b0:a86:9793:350d with SMTP id
 a640c23a62f3a-a991c077e20mr343049866b.62.1728051916466; Fri, 04 Oct 2024
 07:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004131901.21720-1-jth@kernel.org>
In-Reply-To: <20241004131901.21720-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 4 Oct 2024 15:24:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6JVtZsr38yy9cwGA8kHvO=r2FpkHdTQVeVRbUrK8UbnA@mail.gmail.com>
Message-ID: <CAL3q7H6JVtZsr38yy9cwGA8kHvO=r2FpkHdTQVeVRbUrK8UbnA@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: don't BUG_ON() NOCOW ordered-extents with
 checksum list
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Qu Wenruo <wqu@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:21=E2=80=AFPM Johannes Thumshirn <jth@kernel.org> =
wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Currently we BUG_ON() in btrfs_finish_one_ordered() if we finishing an
> ordered-extent that is flagged as NOCOW, but it's checsum list is non-emp=
ty.
>
> This is clearly a logic error which we can recover from by aborting the
> transaction.
>
> For developer builds which enable CONFIG_BTRFS_ASSERT, also ASSERT() that=
 the
> list is empty.
>
> Suggested-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changes to v2:
> * Move ASSERT() out of if () block (Filipe)
> * goto 'out' after aborting the transaction (Filipe)
>
> Changes to v1:
> * Fixup if () and ASSERT() (Qu)
> * Fix spelling of 'Currently'
> ---
>  fs/btrfs/inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 103ec917ca9d..ef82579dfe09 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3088,7 +3088,12 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>
>         if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
>                 /* Logic error */
> -               BUG_ON(!list_empty(&ordered_extent->list));
> +               ASSERT(list_empty(&ordered_extent->list));
> +               if (!list_empty(&ordered_extent->list)) {
> +                       ret =3D -EINVAL;
> +                       btrfs_abort_transaction(trans, ret);
> +                       goto out;
> +               }
>
>                 btrfs_inode_safe_disk_i_size_write(inode, 0);
>                 ret =3D btrfs_update_inode_fallback(trans, inode);
> --
> 2.43.0
>
>

