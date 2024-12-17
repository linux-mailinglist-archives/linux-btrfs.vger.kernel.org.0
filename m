Return-Path: <linux-btrfs+bounces-10491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89449F50F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 941D47A2BC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E641DF251;
	Tue, 17 Dec 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdMvtGPP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24517753
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452686; cv=none; b=pqOHu+ckQ4nLvcfZGGgw7IxIuxTtjk+B0BPyetTKNmPELdKVT4pPRrj1HRsg90e4jGHrPMrJexYCljkeJaQNmQiVQX0JW5kujtPHOkvjUChRPrR7sve+1DB5NMgD/09rAE9s6DHElP4SVac4fAger8Xv+CJ5c/VV+0mJcNLTDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452686; c=relaxed/simple;
	bh=ZHti1waYZgSw4zT6TVa6q3ZnV7LypwJzjKTKUDoEVqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuXsjskftt4rIJEpSbXM7Ynl362KQvZmJnOnT8i+BIH+ZIdf8zY8m/49j5X8aEbYKKbbAkT9zq8B59q7KBuCS/ocZbU4nWKPuBefmUp26x5spjoDxGK+ynazZymgY/zXeXtRtT8tC0Xgpo5WtCaLmS83z27k51xXgkzYbxbFBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdMvtGPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A302C4AF0B
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734452686;
	bh=ZHti1waYZgSw4zT6TVa6q3ZnV7LypwJzjKTKUDoEVqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pdMvtGPPQx9cXKua3IHqxwjbbvDh/JmU0b5inj7uYUcvzizfh6v7eDwX3ACRITEGy
	 1gmMLZrrFs8XkaknW3wXzDJixpm9u37B09iiMR7Ksmu1hc6QvPiPzjqRKEaEmHgF8h
	 x/gkPStIgb3gxSUyIVLasS3m46mz2mu3OKgKAvwiDJbCMbf+p4E1JZVc97Wlh+BdEF
	 ae003KoJiM/opiHFGQTd5ks1XiVFIrikj+vdo6zEZx5oFjivZJRGp+5fh0L4kPx7Ae
	 esKk2P0LCdij/4vha7d1sihOtswSJSC1Bz6zsRJ5rzjWY3J2I3hupnGPEYb6ECpQSz
	 b6r3XpnYfch2A==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso945270866b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:24:46 -0800 (PST)
X-Gm-Message-State: AOJu0YxUvfb/fjQqYNSh8yMOzX2z7ZQNeKIY/K+6C4KkB9z1UvAvLx/x
	oxgQTyD/IMOTSz9Ro9fw2CIpFGnbisYJWzcs39DsMOsW0YRg3mndmGK187y2PS71cIAWNNNrBq4
	QaZ8UjchKM18SXt6Qc8DC0t+25XY=
X-Google-Smtp-Source: AGHT+IFUb2l/oI7oKSsXNBGCqfqM1OMIGE4HLQO45Im1zSBAtpDphSRoOEYsPbaaCeG0kwXow4F37rgB8Nh+ilzvq6s=
X-Received: by 2002:a17:907:3f14:b0:a99:f6ee:1ee3 with SMTP id
 a640c23a62f3a-aab77e7b564mr1783959866b.43.1734452684930; Tue, 17 Dec 2024
 08:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <001ec4d2336af581f1014c6a3ec96c24ba6e5dba.1733989299.git.jth@kernel.org>
In-Reply-To: <001ec4d2336af581f1014c6a3ec96c24ba6e5dba.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 16:24:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5cKE+-GgWmGayZ6kLT9=1JeogGVXYNon9jw_ZDqFj4xw@mail.gmail.com>
Message-ID: <CAL3q7H5cKE+-GgWmGayZ6kLT9=1JeogGVXYNon9jw_ZDqFj4xw@mail.gmail.com>
Subject: Re: [PATCH 09/14] btrfs: selftests: check for correct return value of
 failed lookup
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:56=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Commit 5e72aabc1fff ("btrfs: return ENODATA in case RST lookup fails")
> changed btrfs_get_raid_extent_offset()'s return value to ENODATA in case
> the RAID stripe-tree lookup failed.
>
> Adjust the test cases which check for absence of a given range to check
> for ENODATA as return value in this case.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index f060c04c7f76..19f6147a38a5 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -125,7 +125,7 @@ static int test_front_delete(struct btrfs_trans_handl=
e *trans)
>         }
>
>         ret =3D btrfs_get_raid_extent_offset(fs_info, logical, &len, map_=
type, 0, &io_stripe);
> -       if (!ret) {
> +       if (ret !=3D -ENODATA) {
>                 ret =3D -EINVAL;
>                 test_err("lookup of RAID extent [%llu, %llu] succeeded, s=
hould fail",
>                          logical, logical + SZ_32K);
> --
> 2.43.0
>
>

