Return-Path: <linux-btrfs+bounces-3298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB0387C205
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D361C20C35
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A7745EF;
	Thu, 14 Mar 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYnVVOyw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A81EA6F;
	Thu, 14 Mar 2024 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436715; cv=none; b=mFSBaNMfnCwlHNLcnwdQ7mCEUWVKxr7aSTiXKecjTZC+bnSbG42ToubHqniwQFSUwWHt9mLBKfz6aThWZ9ht1f5qO0+U5QtArh2JzRCdZAem+k+3jWTIiwUABhGFlTV+BOYz7hinvRKXbNWorpJiAQDmcVHQBHq8FQHWnk8Ze9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436715; c=relaxed/simple;
	bh=ohDZGdMDrrJS14ToVZBClFrspQXk+4CJZdS+EJmy7Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU+lWtkXgj01KKzhzXj2fPJDN93nX1s27dp9J1qjwY6J7C65BjPJzBVzsK5Yl3eiCHLj7YXg+S1tsWNOCSPFiCcnBh2PpQrj+os4xVJRcdVg0M5fxbTQ9y+jp7mVR7QyxQZYjHwvnM8NoPFOOXpO3zH0tkudUBBmqnpPiCK64jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYnVVOyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98410C433F1;
	Thu, 14 Mar 2024 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710436714;
	bh=ohDZGdMDrrJS14ToVZBClFrspQXk+4CJZdS+EJmy7Ac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GYnVVOywPAYqGCj4yHOGMwMJvzwGx30unKTxXy/NRdJOrtpoRlIB86SWq7jn7qLeo
	 8utfXyMCpwC17lKhtGf9NjGQ0cPdYEZigEeDE+yGXxOSF5lpogsZB28u2rixjs+PFf
	 AC6R/+sEA7rvLsVk5up+eIOzRcyBjxkrx2d2V1Gub+rUTrZUaC0x6xjH/irvY8XeBI
	 yeu+/Wa8/D9Wo6/A/M7RRhChVJQYhONImqrUk0tHqtLJqNLR9FI+pusy2u48TtfIUQ
	 oB+EAKB0sZbOpuUS1oeU5L08ujk8SFqn8GF9VdO9/y48R/vtetWASkM3Td5Qej5IfZ
	 CkZXFrA0fVftQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46644fee93so171644266b.2;
        Thu, 14 Mar 2024 10:18:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzCAySnt/YRu5n9x62hLdSmYtmT5dxut6I2IFEd22RFLFNY8j4oCISAoo7IQyNqLURHcCsKfvSx193QqViO/ssmA47dOiG
X-Gm-Message-State: AOJu0YwZA0IWZHoecuLm9L+zhbi9HpvC2cUpXsJD3a2oS4Tu7OdQbH4G
	EdPNVzufbDPPhpywIhmXFncBIqzhJQMi7lN/5pRsJB0v+MUS82t7auxjDRSNktrcf8nzDs+M6wW
	3MckdW8ghx5j2++sgdFGpcXPa/v8=
X-Google-Smtp-Source: AGHT+IG/ys2gnE/GEOxAamM1inX7INBoxrWSpB2U3nqqWxpczR+UlJH3889HCYrelziAVG4u4vYWoid19GVGS8luIZU=
X-Received: by 2002:a17:906:3c11:b0:a45:f371:c109 with SMTP id
 h17-20020a1709063c1100b00a45f371c109mr1603163ejg.24.1710436713211; Thu, 14
 Mar 2024 10:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <c54030e9a9e202f36e6002fb533810bc5e8a6b9b.1710409033.git.wqu@suse.com>
In-Reply-To: <c54030e9a9e202f36e6002fb533810bc5e8a6b9b.1710409033.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 14 Mar 2024 17:17:56 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7hMVH+YcTY1LufgjTHjKKc6AQyOb-RmppHBskf4h0wDQ@mail.gmail.com>
Message-ID: <CAL3q7H7hMVH+YcTY1LufgjTHjKKc6AQyOb-RmppHBskf4h0wDQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] btrfs: reduce the log level for btrfs_dev_stat_inc_and_print()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:54=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently when we increase the device statistics, it would always lead
> to an error message in the kernel log.
>
> I would argue this behavior is not ideal:
>
> - It would flood the dmesg and bury real important messages
>   One common scenario is scrub.
>   If scrub hit some errors, it would cause both scrub and
>   btrfs_dev_stat_inc_and_print() to print error messages.
>
>   And in that case, btrfs_dev_stat_inc_and_print() is completely
>   useless.
>
> - The results of btrfs_dev_stat_inc_and_print() is mostly for history
>   monitoring, doesn't has enough details
>
>   If we trigger the errors during regular read, such messages from
>   btrfs_dev_stat_inc_and_print() won't help us to locate the cause
>   either.
>
> The real usage for the btrfs device statistics is for some user space
> daemon to check if there is any new errors, acting like some checks on
> SMART, thus we don't really need/want those messages in dmesg.
>
> This patch would reduce the log level to debug (disabled by default) for
> btrfs_dev_stat_inc_and_print().
> For users really want to utilize btrfs devices statistics, they should
> go check "btrfs device stats" periodically, and we should focus the
> kernel error messages to more important things.

Not sure if this is the right thing to do.

In the scrub context it can be annoying for sure.
Other cases I'm not so sure about, because having error messages in
dmesg/syslog may help notice issues more quickly.

>
> CC: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e49935a54da0..126145950ed3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7828,7 +7828,7 @@ void btrfs_dev_stat_inc_and_print(struct btrfs_devi=
ce *dev, int index)
>
>         if (!dev->dev_stats_valid)
>                 return;
> -       btrfs_err_rl_in_rcu(dev->fs_info,
> +       btrfs_debug_rl_in_rcu(dev->fs_info,
>                 "bdev %s errs: wr %u, rd %u, flush %u, corrupt %u, gen %u=
",
>                            btrfs_dev_name(dev),
>                            btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_WRITE_=
ERRS),
> --
> 2.44.0
>
>

