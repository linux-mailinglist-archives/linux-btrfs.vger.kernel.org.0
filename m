Return-Path: <linux-btrfs+bounces-4473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6C98AD17F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4771B288081
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35583153589;
	Mon, 22 Apr 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuFQzXWs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F1152E05
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801889; cv=none; b=AC2ldHfSnM2Sf4v+DcPCbnLBNG15j1/Gp4v1ZQelKVP4I076+6SH4uChWF724wYTH7NyEo4QsNBAQRGOGfeD7Rk4HlXbF1HYtk4NKbsuaCqk1ygaqnzG8b+SFq5mcHvCQMq6w4jN135qcg14qk+M2meW3mAVY6E/OghZe0F6QY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801889; c=relaxed/simple;
	bh=3C4oGkSoF2yuYMypv61m78g6ZtmU4xPiRym/GHkqRtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLnIpmCsf96wGGo03S1Yes7TU9a8mfYT0pOvPJleOejDQzdlOpYorVlwtkQ2e2JnpEUEynbXP5vaNznrsKoM2Lq3pXPEHKaI9zj838JaBFR6Zo4rDXn/1NiScg+gKlplCTwqgmEAkbYcxh8Cn6megH3k/1mWeSlZyWZxdASeSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuFQzXWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E855BC116B1
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713801888;
	bh=3C4oGkSoF2yuYMypv61m78g6ZtmU4xPiRym/GHkqRtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZuFQzXWsuyLx1xrcnzNUkbPA/Niv/193NNSIC+MvA/R/Jk2FaThMd9dsoVPP+LnQ0
	 81oS9VlnJpIJiVD8L3nGvf54/4SG+OMbIB3/JPPYgSYVy8oAo7IJ0IsBefDUwNRcIg
	 x92hcapEYBxCNFJSfdu4A4q2IC4ZaJjAdCfPpTeST86viU0iANnhyWqD109MuxZZfS
	 xx4kgrs2oBRhavvGBm3MClMfmCfcKju9oPpxMvj+GKc1/q60xl9I7MMhGjxi1XGdhQ
	 WQSUBQRjBLhsfHkunLDlAe/7DyZgV4nO1E54OlrXfyMrA1KW+82WrtjLabA0t+DktU
	 NpckDNU7CvVrQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a52aa665747so558759666b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 09:04:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YyLBeGmu/ve6DnQMYKaDPXlFjF8j5ggdZTeKs2g6PtNMuC17lrG
	AgOwJhA110gE4s7icNckkpc+5Ii9aL3M+rVl5t7X0vl/JfWk4XP/7XMBugZKEr+eykL74AWOR07
	ZMXEmD248Zbn1z0Qqpe5KKwMtIMA=
X-Google-Smtp-Source: AGHT+IEvKpEc21HbmzUef1B5Ts9nIjFcqrEZBRkReKH/7drJRousXYHpxiJht7HyrpJVOu90rqoplFVLenPqM+oIWxA=
X-Received: by 2002:a17:906:f757:b0:a58:72ae:722c with SMTP id
 jp23-20020a170906f75700b00a5872ae722cmr434658ejb.29.1713801887340; Mon, 22
 Apr 2024 09:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd677611fcbd89c21d60585e22c8d4aed3b90090.1713599418.git.wqu@suse.com>
In-Reply-To: <bd677611fcbd89c21d60585e22c8d4aed3b90090.1713599418.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 22 Apr 2024 17:04:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5CNfN8mPuwSfK3Xq9eTjxX4e9jgLErqUFakDM5OxjxMQ@mail.gmail.com>
Message-ID: <CAL3q7H5CNfN8mPuwSfK3Xq9eTjxX4e9jgLErqUFakDM5OxjxMQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: do not check qgroup inherit if qgroup is disabled
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 8:52=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> After kernel commit 86211eea8ae1 ("btrfs: qgroup: validate
> btrfs_qgroup_inherit parameter"), user space tool snapper will fail to
> create snapshot using its timeline feature.
>
> [CAUSE]
> It turns out that, if using timeline snapper would unconditionally pass
> btrfs_qgroup_inherit parameter (assigning the new snapshot to qgroup 1/0)
> for snapshot creation.
>
> In that case, since qgroup is disabled there would be no qgroup 1/0, and
> btrfs_qgroup_check_inherit() would return -ENOENT and fail the whole
> snapshot creation.
>
> [FIX]
> Just skip the check if qgroup is not enabled.
> This is to keep the older behavior for user space tools, as if the
> kernel behavior changed for user space, it is a regression of kernel.
>
> Thankfully snapper is also fixing the behavior by detecting if qgroup is
> running in the first place, so the effect should not be that huge.
>
> Link: https://github.com/openSUSE/snapper/issues/894
> Fixes: 86211eea8ae1 ("btrfs: qgroup: validate btrfs_qgroup_inherit parame=
ter")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9aeb740388ab..2f55a89709b3 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3138,6 +3138,9 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info=
 *fs_info,
>                                struct btrfs_qgroup_inherit *inherit,
>                                size_t size)
>  {
> +       /* Qgroup not enabled, ignore the inherit parameter. */
> +       if (!btrfs_qgroup_enabled(fs_info))

Well, the comment is quite redundant as the expression is
self-explaining... I would leave it out.

Anyway, it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +               return 0;
>         if (inherit->flags & ~BTRFS_QGROUP_INHERIT_FLAGS_SUPP)
>                 return -EOPNOTSUPP;
>         if (size < sizeof(*inherit) || size > PAGE_SIZE)
> --
> 2.44.0
>
>

