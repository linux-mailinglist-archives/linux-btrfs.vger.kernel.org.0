Return-Path: <linux-btrfs+bounces-20378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD4DD0FA58
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 20:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16ADB304DB68
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90B352F86;
	Sun, 11 Jan 2026 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVKhYBY7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE77346AE8
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159698; cv=none; b=aOgPmfKUOURKJeLki4O9NVx1ry/XdLECzDGVGNqHqG58A0bvuPpOKlRzCckB0JVN7gicGOsBZiIi/Ye/njxVLXTsjR9wSO6bAvr3OlzQkge0z3zLA2YnRTumlfdpqduTK/9xUjPNp4eNgPgiAXu5NDa5oq8y8ZHSV80yH5oaduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159698; c=relaxed/simple;
	bh=qwgxFtIvKs+HmWX3ioaf8GMCr88XYncA99tYlGakRe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZN3e7CFlzNqW5EFQYEA3+fXcjKO12fbveCkwSAOaMSx5sHAqxUqKqQb/YUuE8YALhzc9eyXh/kxJlzN0X0pXJxKY+nA+2ZZHSxcSFkWtzXxCDxTrY0Db6KgqZ0ZP17962jX9eTOBaqNI1H8jK3GJMRki1wLLcWJFRtL6wahjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVKhYBY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED28C2BC86
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768159698;
	bh=qwgxFtIvKs+HmWX3ioaf8GMCr88XYncA99tYlGakRe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tVKhYBY7gY7wTZ/Io61+wS+/SgalGZXu8OtfPFsaJND+6zwc4FAgrifoTssiSlxDR
	 lzN9qs9GIj9JjzSf3519XtiorshwghBlQXX8pSdq3vjotO61MH3YLVc1TRfKesRvcU
	 WVsYI36A5ao13Z62rORRjs97FMs4M7MX/F2byMcbGvNfl5dkXlccIaqcnUcAduTagF
	 tHUumB+3Hs0jFaGEUtba/I9cMs5G2b/gYmftlS6eNZVqGmlQIOaGCjqgefG8YuiBqe
	 1xcD9dIar8mBiv1fB1tIVdEbtJ6yxk8qYYTra3y04NwI1r8YFUzFZ1lqfy5MqQDd3o
	 fP/0U6QlCJ7KQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso11943525a12.1
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 11:28:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgZ3DOTb+wziP+PsiXn6C8zYFj5eh6+8KorlzNksTVnqRXrU6KJecgvSPm724LCovzb/Bf924ZzpkH7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5fyiASm4dFSRXJ2YIajTjL9NdyDtxJVRJa7ihIW3YM6Kq8FW
	C+6GJGSdVok1i0kO1tsoQD4mIteENp3fR9Ydkytw3Nc8LW62dUYUQEls+5jU3xYsVISJ+XEsR5I
	QqQhULfgjcA7bl2x6ozY52tzYcdgo9yc=
X-Google-Smtp-Source: AGHT+IGzAFhXQMgyuM187vc0rCVN7s0pwbmue2MwSXZc1Sxv5PYv/215RZ6bjIEtvxJ4tp167xwfeLKilN3mogGw3HA=
X-Received: by 2002:a17:906:fe0a:b0:b73:8639:334a with SMTP id
 a640c23a62f3a-b844518eb90mr1690039666b.13.1768159696646; Sun, 11 Jan 2026
 11:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110200729.9590-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20260110200729.9590-1-jiashengjiangcool@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 11 Jan 2026 19:27:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6dqV2jF6r-gy1DKBBnq1+mNvvwaQVkAq4VvPYRgVEAfA@mail.gmail.com>
X-Gm-Features: AZwV_QgXuLzsjii78gDKSmesr1SguFmh8sXURsDE0R6s0ptgv06wL1mpWenyzis
Message-ID: <CAL3q7H6dqV2jF6r-gy1DKBBnq1+mNvvwaQVkAq4VvPYRgVEAfA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fail metadata async reclaim early if filesystem is aborted
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 8:07=E2=80=AFPM Jiasheng Jiang
<jiashengjiangcool@gmail.com> wrote:
>
> Currently, do_async_reclaim_metadata_space cycles through all flush
> states even if the filesystem has been aborted. In contrast, the data
> reclaim path (do_async_reclaim_data_space) explicitly checks for
> BTRFS_FS_ERROR and fails all pending tickets immediately.
>
> This inconsistency causes the metadata reclaimer to waste CPU cycles
> performing useless flush operations (like attempting to commit a
> transaction or allocate chunks) on a broken filesystem.

No it doesn't.
If the fs is aborted we can't commit a transaction, etc - all flush
operations return early.

>
> Fix this by adding a BTRFS_FS_ERROR check inside the metadata reclaim
> loop, ensuring that we fail all tickets and exit as soon as a
> filesystem error is detected, matching the behavior of data reclaim.

Honestly I don't think it's worth adding this code.
Not only is flushing a no-op when the fs was aborted, having a
transaction abort is an excepcional and rare event.

Thanks.

>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  fs/btrfs/space-info.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 6babbe333741..b3aae44a1436 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1189,6 +1189,14 @@ static void do_async_reclaim_metadata_space(struct=
 btrfs_space_info *space_info)
>                         spin_unlock(&space_info->lock);
>                         return;
>                 }
> +
> +               if (unlikely(BTRFS_FS_ERROR(fs_info))) {
> +                       maybe_fail_all_tickets(space_info);
> +                       space_info->flush =3D false;
> +                       spin_unlock(&space_info->lock);
> +                       return;
> +               }
> +
>                 to_reclaim =3D btrfs_calc_reclaim_metadata_size(space_inf=
o);
>                 if (last_tickets_id =3D=3D space_info->tickets_id) {
>                         flush_state++;
> --
> 2.25.1
>
>

