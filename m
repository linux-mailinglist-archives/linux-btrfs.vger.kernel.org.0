Return-Path: <linux-btrfs+bounces-2635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193E85F753
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 12:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3316BB218A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478245BF9;
	Thu, 22 Feb 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUth5Jko"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2904177B;
	Thu, 22 Feb 2024 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601688; cv=none; b=mdLnSjT1scpRjhisH7xM42gqEto4+8AGQNgQqCD0TFcws/bT/J0CssJUbt1RUXBgIPtmdUuaQfPDib7kB6ZJ3dAsDu0WPfPgAPShFWUtTWc5w0LiZ48k1lc11VB/hIsxJnlKtj0nUyWJ4dvYQwfohuYR64CYgT0fK8Fwtoq6lWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601688; c=relaxed/simple;
	bh=rMiMAEb7nUNSzhkc7g3QGXI5Phx0NHOmHBi7tHgSals=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceMxiV4HXjPSn3M7wghlOZQtlQnwY0SP4+5BlDTqRtnyewnYCMY6tmsgRq3a3UkzpT+RPA229LrRhYiuQSrSARAJwvhZeYwOfpc8eXqiZdc5aTj/EtCiPnpdby1kp7b2z4yIHyMoRnRNYuh0mXRcU5yMp8rQZhTmQDfC/VtZot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUth5Jko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5E6C43394;
	Thu, 22 Feb 2024 11:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708601688;
	bh=rMiMAEb7nUNSzhkc7g3QGXI5Phx0NHOmHBi7tHgSals=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NUth5JkoDE+XvAweiXk4LCFZbipWIqT7tg+jQzeNlyq75AarJzlOa/D5t6q40RXcO
	 N+/wbg9s/8mxRZd8gpGpCGYmvusE5yHhuhm1kILeGfgna5iI+/YbR8iyhhQs5N/0zT
	 O5+av7LXVRSk03BUVotwKjbpAUGXbAmq0SHXsyfP3DORSwo/fKzEXtXafiBvwWqPZn
	 /3medkL0Nn6BpEDn/0t18qxHOCJpKJxe2V/NQV8xLvvGn5vbTX95YRF26QPmN9Qr9h
	 b7vTt58KBpH/vX8aefWihUnKC0tHeSMib1UcRXreCCVAZqQl24Qx/lUXJPuNIs4itX
	 XV2wTkuT43mpw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a34c5ca2537so221153066b.0;
        Thu, 22 Feb 2024 03:34:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIDBOuvtTul0GjNcCZfPBdbr5CWEob9wMrZHRFJpjJGvSSDF9Pf3pQV9IsI9iIzwHh7qjEunSmH89ePA0T+iBM5p8w34Hrv6K7ilI=
X-Gm-Message-State: AOJu0YzW0fW4aeG0UQAx7I9PFhWZEuFyZSiRd4ChtkHVQ/AqlIz/J7uX
	EMXpOxDBdtRxZnW6P9fkkhAuYU+z/Qh5yZufGT3u/KQFng4mC1fPUPjJF7kSEUGHQ0aQ7NpXKfL
	kMBJlVSwyZoMdLJfNGMbtWo2Olqg=
X-Google-Smtp-Source: AGHT+IFGvwjYBcgmTTJtVkkDCNpJGtunfio5QLEKK2HJ7sg35sHM8VqlyCwJir0FZbcjuq1Kdz4xS5QkpCeyVSDJV5Y=
X-Received: by 2002:a17:906:4ecf:b0:a3f:583c:b00c with SMTP id
 i15-20020a1709064ecf00b00a3f583cb00cmr2194344ejv.43.1708601686663; Thu, 22
 Feb 2024 03:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222095048.14211-1-dsterba@suse.com>
In-Reply-To: <20240222095048.14211-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 22 Feb 2024 11:34:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6myPAEAkfz68pw8e6FS-WDx3j+1GAN1dJ-rQ07YBucmA@mail.gmail.com>
Message-ID: <CAL3q7H6myPAEAkfz68pw8e6FS-WDx3j+1GAN1dJ-rQ07YBucmA@mail.gmail.com>
Subject: Re: [PATCH] generic/733: disable for btrfs
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:51=E2=80=AFAM David Sterba <dsterba@suse.com> wro=
te:
>
> This tests if a clone source can be read but in btrfs there's an
> exclusive lock and the test always fails. The functionality might be
> implemented in btrfs in the future but for now disable the test.
>
> CC: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/generic/733 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/733 b/tests/generic/733
> index d88d92a4705add..b26fa47dad776f 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
>  . ./common/reflink
>
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs generic ^btrfs
>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "fpunch"
> --
> 2.42.1
>
>

