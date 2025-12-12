Return-Path: <linux-btrfs+bounces-19699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F8CB883C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF8C3045A43
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F99313E0A;
	Fri, 12 Dec 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjyVode3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705E2C0273
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532532; cv=none; b=RQoRBwaPJRRvMkxAfXl6QuaGRdBhCV8HCKAwSwmmC1v3cphu11aAjPV4M4lZYLsXhISXARAjKPrCiOk7y7nEjNx4l/ARAuvWuUMl+yK6nFJ7XfOJm0mb7Td8CbVkPQ+Hdd9jKdPj+EiIXGRYwJ6Moj/MUPTKtzJQtHpSWwdVYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532532; c=relaxed/simple;
	bh=NHGzB8PztEk5lSWWQcxEdojOuFlJ2rF5a33GJeV4G1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBqLDGYNMm1FcUomzuTz6g2jv8X5dOECBk3lEvEcCI+DMjRUeSoBX66WqobYYuPLjvY7Xq3pvtQIPRdYrri6pHYxAD0dhGtOH7YoCDiH3rtS8Rs6BVAldMk8JUoX6UZ1wzcP+gGslpvC5Ca4cLEGA61FKMk4Fm7MkEHgPJ+eOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjyVode3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45774C4CEF5
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765532531;
	bh=NHGzB8PztEk5lSWWQcxEdojOuFlJ2rF5a33GJeV4G1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RjyVode3/bssNAy00bgBgG1fxIqyY1QwoXdXpLW+avM7ZBVyMefcMAoiGCo5YZVrC
	 ftt4C4+q4bxEgRp+8XXeu9qfXFE6PVl3wez3SYV3/mMB1IlkLUVxP6j41LQfl7bGwG
	 4aJWSR2wsvy27SVAmEGRjBKI6P3q4O+g3YtCqrRrkAHz7ynPFqmq1dslMVguPX3dV/
	 8bxqMUoz9lFSNvJG5cqQ365/7l/SqVsunkfAq06M8wHLCSDy4WcPz5fnYtdD/RQ9NV
	 m8QPi+f8Qqr06I8Ou1QeE+bCwKPtWIu+PWEEZkYzpt3eP8+5ZB/n7+PF3OJBNw6Bhh
	 1lyAQG4tZqKnA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so1977551a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 01:42:11 -0800 (PST)
X-Gm-Message-State: AOJu0YzjAXg113o/F4sUXhWujUxwmROiHql/7L3Rbp/UIvqIYFb55pX9
	FRsSuakKtWC9uT9w6SJk9K256v0cB0xHPJ4h7nN8gB92jLS5iOxapj51yIO8h9A7xbPEmwsn+8/
	XFfLoYot7Pt3ZulTWO7MzZdrehmQV8v4=
X-Google-Smtp-Source: AGHT+IF+AvvtMbEooIML7GXCsG0ED88QrCU462PHyQtw+Nu7hCkynaGL8XLC5KSMc30h4kxwAPPPWDHiInVz4m+xHq4=
X-Received: by 2002:a17:907:9307:b0:b71:9c99:7b8a with SMTP id
 a640c23a62f3a-b7d23c73f2emr111523666b.49.1765532529909; Fri, 12 Dec 2025
 01:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com> <20251212071000.135950-4-johannes.thumshirn@wdc.com>
In-Reply-To: <20251212071000.135950-4-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Dec 2025 09:41:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6N=mrwBDsPd+EG2OBstZkWJA5q+K=PiiA7n0ySiF1tcw@mail.gmail.com>
X-Gm-Features: AQt7F2p96Diwq0pWCS61yTvV07OEYBtHMaSFi9vn5w9w6YtAAbGAvOVLWX6qrf0
Message-ID: <CAL3q7H6N=mrwBDsPd+EG2OBstZkWJA5q+K=PiiA7n0ySiF1tcw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] btrfs: zoned: print block-group type for zoned statistics
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 7:10=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> When printing the zoned statistics, also include the block-group type in
> the block-group listing output.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/zoned.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 2235187a2807..63588f445268 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -3018,9 +3018,9 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *f=
s_info, struct seq_file *s)
>         seq_puts(s, "\tactive zones:\n");
>         list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list=
) {
>                 seq_printf(s,
> -                          "\t  start: %llu, wp: %llu used: %llu, reserve=
d: %llu, unusable: %llu\n",
> +                          "\t  start: %llu, wp: %llu used: %llu, reserve=
d: %llu, unusable: %llu (%s)\n",
>                            bg->start, bg->alloc_offset, bg->used, bg->res=
erved,
> -                          bg->zone_unusable);
> +                          bg->zone_unusable, btrfs_space_info_type_str(b=
g->space_info));
>         }
>         spin_unlock(&fs_info->zone_active_bgs_lock);
>  }
> --
> 2.52.0
>
>

