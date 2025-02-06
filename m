Return-Path: <linux-btrfs+bounces-11320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C4A2A91E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 14:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD96D3A8003
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2B22FE0D;
	Thu,  6 Feb 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuXoC8wd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344122FAFF;
	Thu,  6 Feb 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847307; cv=none; b=UpyzDpb67wcaT607nFthB1hK+S1FjaycWcjT6EFJMhTovPjIMvHMFL1QKuaOe0mESHHyIAmnZ9HuG6TiCa/3akAYO1xfk0kV6q8RszPHTUFMLj4ul+ZkbFcBhsZFhUV+qxK2S184kJ8pPRBuUwW76H0+oPimSqd258zRey9XjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847307; c=relaxed/simple;
	bh=rNv9biQc+0iV/Li0s9nFsEAXMuwMEG1FsTECE1TFwMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Io03pZVSsHDGim7RfRSgF/YwHrIRuuvQOKixV6jKbyzJvflqmE1S+9AoOY1uAcJItCra+VE/wXvViCEc+IBgYDlfA47I3WKuiHdGrTGtZzNbAIa4+4pf9d8QpAaZFwvBLndDDK8ZaEOcIuyCTUT9MY3fFVYAznrE0rxh+/ba+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuXoC8wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B7CC4CEE3;
	Thu,  6 Feb 2025 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847306;
	bh=rNv9biQc+0iV/Li0s9nFsEAXMuwMEG1FsTECE1TFwMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TuXoC8wdHzoxbeERD0K8bnJptYfIURVHmX37qnyDxiFgF72qYHKO8OmuCggUHaNiq
	 +QgggzBkWzIm2K0NVj9H3uLyVb3WhlUxutwfysecN9Aoq5k/mozYrc8Moqj45LZWGO
	 Fj4ql3CgbS1Csv8FTpxiFYc/s6hce/Tn085NgF4ZnSStVjV1lqgD8sBll0BGWIz2C/
	 KWEuTBiOGcpOS5f2dk3Jos+MzD+e4jDyWR6BYhQKm4LUcS+nCPydOTHfAL/Qb5bhpF
	 eJqgemPl3CpoUKFhVcrXUVjigrHnveC9juxxChdjJBTQxaKVZiNz7bfKZlrI38iQc/
	 z6cQSGODu2Aow==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso223776866b.2;
        Thu, 06 Feb 2025 05:08:26 -0800 (PST)
X-Gm-Message-State: AOJu0YynzjaaytcThkcnypyC7J7e2zVskO1kwXhk+r+FnTF6181MYIos
	i9avZUSG+god7lNXQlILWjrSCHIB8YqZVQRvhoGLvEk21D1VXT3tzcB+alr6WRRPPVvVSmyqhZd
	84q1hIwMiKeVvfv0KPOV1FyaWBb8=
X-Google-Smtp-Source: AGHT+IGPJXn8KzeJd1boEPY6C3Vig7IocKIxORFUZ0GCidM95aaL+LkXuzn+EHFrRiXGx8k0RM4Z2yi1mFfe3brnmZk=
X-Received: by 2002:a17:906:dc8f:b0:ab3:a190:6cb2 with SMTP id
 a640c23a62f3a-ab75e286959mr801094166b.25.1738847304933; Thu, 06 Feb 2025
 05:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9e38c9daf9d330ad2c3a180df13c4bcc0f115416.1738844738.git.fdmanana@suse.com>
In-Reply-To: <9e38c9daf9d330ad2c3a180df13c4bcc0f115416.1738844738.git.fdmanana@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Feb 2025 13:07:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6EFbOw5_sRUMZSVFB_1h5rfr17kvdOK15GDjyNmxpgFg@mail.gmail.com>
X-Gm-Features: AWEUYZnj7Wa9FrtSenIb9tNpBoKdHPswMCJReT5wMDRDc1wv8Ouh-xAjPBtvgz4
Message-ID: <CAL3q7H6EFbOw5_sRUMZSVFB_1h5rfr17kvdOK15GDjyNmxpgFg@mail.gmail.com>
Subject: Re: [PATCH] generic/631: suggest xfs fix only if the tested
 filesystem is xfs
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 12:26=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> It's odd when a test fails on a filesystem that is not xfs and it suggest=
s
> that a xfs specific fix may be missing, which obviously is irrelevant.
> So suggest the fix only if we are running on xfs.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Scratch that, there are more generic tests doing this, so replacing
this patch with another one to fix all of them:

https://lore.kernel.org/linux-btrfs/8c64ba21953b44b682c72b448bebe273dba6401=
3.1738847088.git.fdmanana@suse.com/

Thanks.

> ---
>  tests/generic/631 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/631 b/tests/generic/631
> index 8e2cf9c6..c38ab771 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -41,7 +41,7 @@ _require_attrs trusted
>  _exclude_fs overlay
>  _require_extra_fs overlay
>
> -_fixed_by_kernel_commit 6da1b4b1ab36 \
> +[ "$FSTYP" =3D "xfs" ] && _fixed_by_kernel_commit 6da1b4b1ab36 \
>         "xfs: fix an ABBA deadlock in xfs_rename"
>
>  _scratch_mkfs >> $seqres.full
> --
> 2.45.2
>
>

