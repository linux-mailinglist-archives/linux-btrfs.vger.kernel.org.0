Return-Path: <linux-btrfs+bounces-17875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F36EBE20E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A508F3BC158
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 07:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985322FDC52;
	Thu, 16 Oct 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgU5E4Pz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663F27732
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601520; cv=none; b=CEAqu5Z9Vxa24MT2uyZU/pBgaQvKN/nBFNiIdyJx1w1xr4w3se9u3pkRP0v1lfKV40DsWJHFrDVyAruBvWa9H2T8s9AJHmJcMzzd2nLJpnrE7rHzBAjF2rlusiQ2tbdn2y81m9dMrI/ofbVQy4bYG4OgZE1uqZqZCTgCdsa0Xkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601520; c=relaxed/simple;
	bh=ePCJWYNo2Pxecix7Z6FWF49WfbjlA24J20KmDYBT7ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVBl6exwzfgROwop6oycNIiPX0stTac+79VXreUd/O2J8Dn4jhLjS7g+IVhtCrqB0R7Li3vyGoN9OEWFU1/VdZ8XTQAq9mUqbLcJSLXcD7/egL7FT7hWTUkEKyqMS1P4/pZhmW/f+2GZhqXd/bSwkDWzBYAxl5Rc1iL8exmIlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgU5E4Pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB48C4CEF1
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760601520;
	bh=ePCJWYNo2Pxecix7Z6FWF49WfbjlA24J20KmDYBT7ZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DgU5E4Pzw6HSMuOYA66e/GbbsP7roT6hHWY66m94hG81HDnvmrN57Z55Sqi1vnLkT
	 LKMGbWjrvlXn99MUm0LpH9tDyluwl5GwqoQdT/aSfjRXZ9oD/wlKWe/UaD5nAXBHmN
	 xWSqvc0zJRuxfBnRLWpOWNcH7vHUaVSRNMoIcvvvOAu0xxwasLo2wHZCaLBipQkToD
	 7k3YYx0hVQrBklbjoEWRwDtHQyI7OaZrJqyZYLbcIKvT1BqCANioBCprLGAXMVnDhR
	 qHPNcW5g03wO8n7pSu5/vktgwa2K/1brCKXgK447jqXlHqTxrf+VvAd9g+vsWK/aq2
	 ArAORmA6rWqzw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso3228237a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 00:58:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YyUdvhG1G38kOwHdrEkJuLgfcKzc7+phlHSMgmVTWKVWOa8ud5D
	AUYW6CykjhKERyB8uqJYKJHZZyM1kn5eOAimqKkdBu9+ceiIQmzu/gtOEZMvxnFSDzZjVeFhJIM
	IoZkIjicwegqwIXjVUqtZ5X9nRko3fl4=
X-Google-Smtp-Source: AGHT+IG1OCZCcVfUNKDY8tlStlBg3wgyfRRwbAahdKUT5nPos7j85ml4w/8kIetGt5mvkly32hx4pK7Wo4RwVel/zEE=
X-Received: by 2002:a17:907:890b:b0:b07:e348:8278 with SMTP id
 a640c23a62f3a-b6054cdd6d3mr294324266b.25.1760601518816; Thu, 16 Oct 2025
 00:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760588662.git.wqu@suse.com> <33c132d328ad7020d68724b1c6918846382438a8.1760588662.git.wqu@suse.com>
In-Reply-To: <33c132d328ad7020d68724b1c6918846382438a8.1760588662.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 16 Oct 2025 08:58:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5xWqyfU=ia=fh6oP4F4yvjTvGuGR_z-cHdpufdy74J8A@mail.gmail.com>
X-Gm-Features: AS18NWAaszLZcBa2mROOepc__LVZoFbeSL7v_o4l1LoEUE2oNPpVoYc4gudi3zk
Message-ID: <CAL3q7H5xWqyfU=ia=fh6oP4F4yvjTvGuGR_z-cHdpufdy74J8A@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: scrub: cancel the run if there is a pending signal
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Unlike relocation, scrub never checks pending signals, and even for
> relocation is only explicitly checking for fatal signal (SIGKILL), not
> for regular ones.
>
> Thankfully relocation can still be interrupted by regular signals by
> the usage of wait_on_bit(), which is interruptible by regular signals.
>
> So add the proper signal pending checks for scrub, by checking all
> pending signals, and if we hit one signal cancel the scrub run since the
> signal handling can only be done in the user space.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/scrub.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 728d4e666054..f3dfb7023499 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2080,6 +2080,13 @@ static bool should_cancel_scrub(struct btrfs_fs_in=
fo *fs_info)
>         if (fs_info->sb->s_writers.frozen > SB_UNFROZEN ||
>             freezing(current))
>                 return true;
> +       /*
> +        * Signal handling is also done in user space, so we have to retu=
rn
> +        * to user space by canceling the run when there is a pending sig=
nal.
> +        * (including non-fatal ones like SIGINT)
> +        */
> +       if (signal_pending(current))
> +               return true;
>         return false;
>  }
>
> --
> 2.51.0
>
>

