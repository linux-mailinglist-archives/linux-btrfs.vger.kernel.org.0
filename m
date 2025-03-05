Return-Path: <linux-btrfs+bounces-12024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 280AAA4FE0D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 12:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF50F188D716
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F324290B;
	Wed,  5 Mar 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQkPTaO2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA5235BE4;
	Wed,  5 Mar 2025 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175637; cv=none; b=f3HjBbqoufF+v+CSGQFtmYvfT4i/KtB1DL5i/tST8nJM/9fvH66WEL0Yy1O5By+qOzpl1zUq84OUEcuO3cmZYUwuLynIkH8SfmfrWxN16mdF1x4FLCQDJdKWY8aCsuItIy66Mts5EXinFOMfNorhoe89MmmjbZ1ashaOnMLTzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175637; c=relaxed/simple;
	bh=gArcLFfpKivakEz7CtL6CfPKFdqu7fmiUQZy/61/I7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnpxRXKnjZg/qFp/2gEsxJt0hoa16z5KRCO3BU+sj/BgpFIKGoezTCGY9NMd3VQJE6QMy9BB9eETmKxPcpZKvRgXhe99BGwoZt6YDNlh+4jPQvqzodp/ySh54GzxSGr+ulvD55PoUe17RSNO+x2pcLB/yTYhMATEC6GdJo02BKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQkPTaO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34DFC4CEE7;
	Wed,  5 Mar 2025 11:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175636;
	bh=gArcLFfpKivakEz7CtL6CfPKFdqu7fmiUQZy/61/I7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eQkPTaO2ybpDpyvxRBnZCwEJiDOUYN34PexWdJkR/ybt/YYmcnUm6M3vwVJ7jgQ1x
	 R76lHi1X6N+ht923+ud27JAVo9KZ40fD60HCR4sO1zNoSZy6F7Kf51N6Sk9DlCNtme
	 07kuzx6MGUxFagV6b5aENy5t2vz/ai++KdkjMoNTviNwNcnYradekUKb0FwdnmVzrr
	 eFib51GlMZa6kZl0aOWSACyLUTAyUqg1+NOlKY74GwoqiAGzsZPm7PjJRcfzdofZqb
	 uXnrZ4QQkAuO/0fYtG2g1jewDRyDGciHqg6ja3gZ3LKA7u+ibG+sndoiLKCvGP9FJH
	 A8oXRr9av5CYQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4ebc78da5so10179316a12.2;
        Wed, 05 Mar 2025 03:53:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXDHp2Az+zyjraeAUu2cpZ887Iv11KnX5jmSNkRDdtz2EGnrmvp2tJ8xsSk7CKI/xo5XXd0Rmjx1nizaWm@vger.kernel.org, AJvYcCW4Vv6rX/bKK6941mdzh/NYIJqyPzaDlkXHm9cTt+MsGPaeaQUCVaGspojZ8/oEj6sqNjz8b3mCcBuOPg==@vger.kernel.org, AJvYcCX6+GsV9Ncpmzh253XDF/HjhFa09w/tWvgx0apxNxnGkW56RhOl7ufoYzWQPymYkjKYqHVJGNPG@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6d9t0kx9XI7p9+oHCQWlT57qM9rx3SfFMHYRUhg1BW1xuDaj
	ohdJ5or1RtZ7uqxEGVeCyMTZIwR/mIATz3aZEZ+9+oNb+ZqcpNMOC8Zkd8eDpV4BtDcWU1r2srg
	qWGb1I5MAHxHdy17T0YgAGMsiLNU=
X-Google-Smtp-Source: AGHT+IEtu/EQCES06k/Bc8EPSEewrmkKqHE7wO1dQxTrgUo47y+6mmHiwOWvaRXnymriudN4xCZdwdaV6KPcNhmHTpk=
X-Received: by 2002:a17:907:7da6:b0:abf:b2d5:9692 with SMTP id
 a640c23a62f3a-ac20d930712mr234821366b.29.1741175635065; Wed, 05 Mar 2025
 03:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303024233.3865292-1-haoxiang_li2024@163.com>
In-Reply-To: <20250303024233.3865292-1-haoxiang_li2024@163.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 5 Mar 2025 11:53:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7btKGFi9iVrYgo0RoKrkW8uXBvmng0UekSLB-OhUp1WQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrhSNzMCD5RQ-nIUwOTJLLFTxwB7sNQ-rT-XLzQHwX1r7N5jhuhXra2eRo
Message-ID: <CAL3q7H7btKGFi9iVrYgo0RoKrkW8uXBvmng0UekSLB-OhUp1WQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a memory leak issue in read_one_chunk()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, fdmanana@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:43=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.com=
> wrote:
>
> Add btrfs_free_chunk_map() to free the memory allocated
> by btrfs_alloc_chunk_map() if btrfs_add_chunk_map() fails.
>
> Fixes: 7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk map=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Pushed into the github for-next branch, thanks.



> ---
>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fb22d4425cb0..3f8afbd1ebb5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7155,6 +7155,7 @@ static int read_one_chunk(struct btrfs_key *key, st=
ruct extent_buffer *leaf,
>                 btrfs_err(fs_info,
>                           "failed to add chunk map, start=3D%llu len=3D%l=
lu: %d",
>                           map->start, map->chunk_len, ret);
> +               btrfs_free_chunk_map(map);
>         }
>
>         return ret;
> --
> 2.25.1
>
>

