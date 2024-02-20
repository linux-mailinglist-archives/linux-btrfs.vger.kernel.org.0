Return-Path: <linux-btrfs+bounces-2581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43E85BA15
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32461F215E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592D664B2;
	Tue, 20 Feb 2024 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0tGIYHt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CB65E04;
	Tue, 20 Feb 2024 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427550; cv=none; b=OuK/O1KkXj3JdZPKn4I1K/Gp/4Qy8fy9Miw7IDxe3xhvquYjrFl97EreNuSYqctgjdVwY5FwJKIH2ZCQGjGSZYwqzsV1DO698owgzsePjUaosg/mL1XVcfgHbl/JL9JGH/qD+iirjYbUyFjRNp1+MBLx/NJ2JpaoxklIjP5CBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427550; c=relaxed/simple;
	bh=Xb4/s+kosKU2CuRPNlHl4pCLV+8G+VKyqXf1AIQiJqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjD8tUhxKCDOEhFAuOXjYk9zr0zu7KYatUslatqV2Dx4uIBD+yojeyZA3Tyudo2ixAyn/OEHOm67PQA+GXk8+mqiSUpZx6Q1Jq9ADY+1FYvdhd1ReYZGm/XhI2Lflb+wTOGUeCaaZwmXMul/cIFwDGZjXEPbsMDDCVkVEEIfiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0tGIYHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F39C433F1;
	Tue, 20 Feb 2024 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708427549;
	bh=Xb4/s+kosKU2CuRPNlHl4pCLV+8G+VKyqXf1AIQiJqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A0tGIYHtipcHQuah6pptgAlEPnA8rm/5y0WhSiZyH8c9YO0lsGBjlcX69zyRlkTZz
	 4DsJWSXYmf7tlFsZT+jbpTb7zq7KuQJA8IBtpgKJywtY1q14/oCxI0mZZXfHEdghtk
	 yBy3PwiHbrqXMF2hsutjws9epH19apBrOymVLUV6bnYARYtHQ3sHpSU3VgpIQw43rp
	 ewTI+La43z/FT5K4JZ9GfZBwb3PCeTZ+JBnWsHCDym8Vt3qMZ9GvR79q2VPwHE5I7W
	 TA9x8b5d9nZteUSFVwk5dIhhNs7P2Yf1AzTJNIccJ2VpZ4x6wdtFyETi9c1Ctoq2Ys
	 FCQGAj3v+haCQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e82664d53so267132066b.3;
        Tue, 20 Feb 2024 03:12:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlcWZiS4yiDhP9CdEayLFik+WCRI7u2xGigzkhUzMn+QgunYuq/eEcR863RYU55iH3rPGGC5W9phT7zAtclnKaqBdmM/vgVA==
X-Gm-Message-State: AOJu0YyhZ3w9NkGMtpgAELCnoS9dIUP5/rCmrlO+jlWO9odhjhUOdaU3
	d1GJ8ECcs/so0es3ekTCoQErjK02rILn1B7yQ6nEz+E3mZ+tqPX7xPYCvRu3KhJgHNEp0WrJKPW
	7/cir+joO0Er8Wyj6unZ7O6siaec=
X-Google-Smtp-Source: AGHT+IHSz2aKT6H24/ToIuzfIUS0cAOdmdauKfNGuVy9PwQ9kOgq40GlcKnK2JBIzGmsP5uixsQjW7bHdILAoWoAn9E=
X-Received: by 2002:a17:906:1d51:b0:a3e:f0ee:fc73 with SMTP id
 o17-20020a1709061d5100b00a3ef0eefc73mr1360863ejh.1.1708427548049; Tue, 20 Feb
 2024 03:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220040134.81084-1-wqu@suse.com>
In-Reply-To: <20240220040134.81084-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 11:11:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H61S_DF9oBOwN6FDCgVYaqD53KtHXOMdsqq67S+BhSYzw@mail.gmail.com>
Message-ID: <CAL3q7H61S_DF9oBOwN6FDCgVYaqD53KtHXOMdsqq67S+BhSYzw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: detect regular qgroup for older kernels correctly
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:01=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running an older (vendoer v6.4) kernel, some qgroup test cases
> would be skipped:
>
>   btrfs/017 1s ... [not run] not running normal qgroups
>
> [CAUSE]
> With the introduce of simple quota mode, there is a new sysfs interface,
> /sys/fs/btrfs/<uuid>/qgroups/mode to indicate the currently running
> qgroup modes.
>
> And _qgroup_mode() from `common/btrfs` is using that new interface to
> detect the mode.
>
> Unfortuantely for older kernels without simple quota support,
> _qgroup_mode() would return "disabled" directly, causing those test case
> to be skipped.
>
> [FIX]
> Fallback to regular qgroup if that sysfs interface is not accessible, as
> qgroup is introduced from the very beginning of btrfs, thus the regular
> qgroup is always supported.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  common/btrfs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index e1b29c61..0a3f0f0b 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -728,7 +728,7 @@ _qgroup_mode()
>         if _has_fs_sysfs_attr $dev /qgroups/mode; then
>                 _get_fs_sysfs_attr $dev qgroups/mode
>         else
> -               echo "disabled"
> +               echo "qgroup"
>         fi
>  }
>
> --
> 2.42.0
>
>

