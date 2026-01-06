Return-Path: <linux-btrfs+bounces-20175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB88CF991B
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B85F30286FD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A2527C866;
	Tue,  6 Jan 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfPj5gyT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C4275B15
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718885; cv=none; b=dgLieoJosf4rP1GwjSUClU6B37mvRp9x1kpzvCZPhXwhqGC2i5a9kKXhy9ug0oTf/ujw2CGBRjNDi9Wixv2UdCgugOMRJMvJpi2RYQgCHJzcfavrxA1YDjrjIUrepJpz/cFf72TcNhSK64plO/0Cn5CI0aGa97psCQdL3fXa9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718885; c=relaxed/simple;
	bh=BK4xicKtnnC+8n+T04RKoCRQV0z2sI5t77KOfy7q7W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtXOifVVkPKGdGNVJLu0DKgKdxcKY0nnrUzXJtwLmlKvQpSZiRj0RWB+//ZjVZTR1u/3MyQskyzGDaxR1riZk3ixU1YtUFHyhfBt0BYV+bx8jjRbhugg2RpFqHBL8aYyQN9S9Swwq8sD+cfgYjtxFVuOA+8iRJAsYm0W5awUvb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfPj5gyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A798CC116C6
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767718884;
	bh=BK4xicKtnnC+8n+T04RKoCRQV0z2sI5t77KOfy7q7W8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MfPj5gyT4V1bOtm4o+ZVf/ZyGN9i/lk/b3Xz1Z/i9csB+LLId/bhPB46FAYnDNI1P
	 1hVNoX3UqN3gCfkn90SJ/2k8p4VI8Bjlh1zKgEEFxhm1Y66nEJ278zdcbY2DyLXNVu
	 /5Z2xlPQDhBfZQCAfLghPnXD1/2JdjZZa5An94mNMWPmFkjRbYCn0oM/eTZh+gyFQ0
	 LQxB7PHLfUU/2ilZA2wIvFQNOZj0VA4EXx39Re8EbZKYDnMaGY/WyL9waFT6WjF9v9
	 9ULL9+EuOEs8iD3hQFLQeYVwgDyO42FfF2DlJD57uWNH3uuOw0e2VzNTu2DeIw8yXb
	 0Eof/8G3CI6fw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7a6e56193cso213623666b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 09:01:24 -0800 (PST)
X-Gm-Message-State: AOJu0Yz33bfGWzuNpdCOK8vp8SuB3x31uRMEIWMfMtMWF6gaVvXwqg+C
	7vwGDW/vRrPG9/ixsfbzT4XRfcXf7sJVVXd5FsO7x4CvQdD51aOj+xGsCBHeSpaRlrFLdIIW5n0
	892Jr5scnZviCbC8MvrjkSzXP4g0e3B8=
X-Google-Smtp-Source: AGHT+IG3rFczdoyc4DUbIbPvE22uYnMn90ZxV7EA6Qy0knmhwKPMHCsH0YHdbT0IJcq6MhMkVjBDCueAEwuG7RCaKuw=
X-Received: by 2002:a17:907:1b0a:b0:b83:6e2b:890d with SMTP id
 a640c23a62f3a-b8426ac78fbmr404542366b.25.1767718883153; Tue, 06 Jan 2026
 09:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106123028.3105367-1-dsterba@suse.com>
In-Reply-To: <20260106123028.3105367-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 Jan 2026 17:00:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H40sMw0H7Z73mhReRB6FzdsRW6tnjG7tRdHjZfKkC0ucQ@mail.gmail.com>
X-Gm-Features: AQt7F2pMzikh-MavHz0Dh6WSE_e86i5qpMRtqvGFBtF8zz0OfzzSJi6lf4IAs5I
Message-ID: <CAL3q7H40sMw0H7Z73mhReRB6FzdsRW6tnjG7tRdHjZfKkC0ucQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: split btrfs_fs_closing() and change return type to bool
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 12:30=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> There are two tests in btrfs_fs_closing() but checking the
> BTRFS_FS_CLOSING_DONE bit is done only in one place
> load_extent_tree_free(). As this is an inline we can reduce size of the
> generated code. The types can be also changed to bool as this becomes a
> simple condition.

Can you mention here how much was the reduction?

>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/block-group.c |  2 +-
>  fs/btrfs/fs.h          | 21 +++++++++++++--------
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e417aba4c4c7a0..a1119f06b6d106 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -761,7 +761,7 @@ static int load_extent_tree_free(struct btrfs_caching=
_control *caching_ctl)
>         nritems =3D btrfs_header_nritems(leaf);
>
>         while (1) {
> -               if (btrfs_fs_closing(fs_info) > 1) {
> +               if (btrfs_fs_closing_done(fs_info)) {
>                         last =3D (u64)-1;
>                         break;
>                 }
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 0dc851b9c51bc2..e220202e6a10c3 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -1110,15 +1110,20 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_i=
nfo *fs_info, u64 flag,
>  #define btrfs_test_opt(fs_info, opt)   ((fs_info)->mount_opt & \
>                                          BTRFS_MOUNT_##opt)
>
> -static inline int btrfs_fs_closing(const struct btrfs_fs_info *fs_info)
> +static inline bool btrfs_fs_closing(const struct btrfs_fs_info *fs_info)
>  {
> -       /* Do it this way so we only ever do one test_bit in the normal c=
ase. */
> -       if (test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)) {
> -               if (test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags))
> -                       return 2;
> -               return 1;
> -       }
> -       return 0;
> +       if (unlikely(test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)))
> +               return true;
> +
> +       return false;

This can simply be:

return unlikely(test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags));

Thanks.

> +}
> +
> +static inline bool btrfs_fs_closing_done(const struct btrfs_fs_info *fs_=
info)
> +{
> +       if (btrfs_fs_closing(fs_info) && test_bit(BTRFS_FS_CLOSING_DONE, =
&fs_info->flags))
> +               return true;
> +
> +       return false;
>  }
>
>  /*
> --
> 2.51.1
>
>

