Return-Path: <linux-btrfs+bounces-11017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E6A1731E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 20:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5789C3A60B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369491EEA46;
	Mon, 20 Jan 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqvLQ8y8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7318E743
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401289; cv=none; b=bTUF6i3hK78aD7NacHUzwnUtQCKKbLr6CIcgmgdQI4acpw0djFVKr6i/ejXTcrtC6J+olCVM206fNVDL5XtdKF8UH/4MVDEmAgCYxEOpQiltmaXFpN4yuGtxCWdoiCfzNjbNr9iL14D36x+fln9ihHTtUy7Sq9hs2NK2z/DPgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401289; c=relaxed/simple;
	bh=LcBBnpp/aZ3ck41ZwEuY6Qoq2oqJZ51Ai2KDhD5Ns3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvIebd8MdQc5ztmsAUizl53kLsE3JLLhS4XVQAHTHarPc3MCFHAP6QjNMsGVsuKfmYLbbhlwshh1076QMNNlxAn8Yi04S/kqRAi16l6ik2r6mtUB369i+UppFYwlFCn3+cldTA1OxYIUoWC4NxMrMvb0W8wJgHOzmfkTuHK9mQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqvLQ8y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E03C4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737401288;
	bh=LcBBnpp/aZ3ck41ZwEuY6Qoq2oqJZ51Ai2KDhD5Ns3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KqvLQ8y8LzVrin4A0hJU12CEZsM/AHM7oantmvHGBwAC7hYRNmyjOSF+XbeaDz6nY
	 VYEEDMaOSYIYRPw/0zbQSJogPi5VLD4y6WbkGlLtmDAlfswv7omptJH1ecU7h9NtTO
	 M3Qa55W0/P270SihO9hpBtPv8Hij6OeXb3rXEDOMmaXz1QjHyRmiqpfngttegwQYhg
	 S4VZPqBqd6YVim7COhDwVdYRaqh9rBqYElkGLVtYfMme+qc0/NEc+78jE8rDfUEj1G
	 K9ZOlejQ3Rl/mgqgfcrydZ6M4j9QXU73z6WckAcNHpK5SYluEtdX7GseY7rhjsaUOr
	 0efD5jwOFHoog==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec111762bso918492366b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 11:28:08 -0800 (PST)
X-Gm-Message-State: AOJu0YzQ3Ox6BVrdW+HWi96FirvJcGTE1wbUp8S7wCZGpJPcuUU898Ac
	FRDD8Wg8ivTWjIbtqict65tAvVulBZ2+4qiCEDtH9MuCBCsjoX0KBpYeZgSu0gNhc2xuF1qCCmM
	2X/G/Y8vhEX1Bu5Ootn4pE96lD+k=
X-Google-Smtp-Source: AGHT+IGnJcDh75Bpdns8tazBCN4+lPnbz3VeeJYnCJ8uuRtDhBusROjAn/hMq0wx+YKa4XdLUPiNuaJ8+6FL11DbEsk=
X-Received: by 2002:a17:907:3da5:b0:aae:b259:ef6c with SMTP id
 a640c23a62f3a-ab38ada039bmr1235066366b.0.1737401287388; Mon, 20 Jan 2025
 11:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d538309bf9cbfb732b4f9c3bc174ccdcfe9ccafa.1737328208.git.wqu@suse.com>
In-Reply-To: <d538309bf9cbfb732b4f9c3bc174ccdcfe9ccafa.1737328208.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 Jan 2025 19:27:30 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6oWBvr1GiQ4+wr_mwSDrg28PuwcmbLe=9iGiDEHLPvhw@mail.gmail.com>
X-Gm-Features: AbW1kvbm0EoeH22wNqkN8NIviL-gZQjSdXhGMQdJQ14jf8Qw-CZeEynN_dWn21I
Message-ID: <CAL3q7H6oWBvr1GiQ4+wr_mwSDrg28PuwcmbLe=9iGiDEHLPvhw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not output error message if a qgroup is already
 cleaned up
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, John Shand <jshand2013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 11:11=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a bug report that btrfs outputs the following error message:
>
>  BTRFS info (device nvme0n1p2): qgroup scan completed (inconsistency flag=
 cleared)
>  BTRFS warning (device nvme0n1p2): failed to cleanup qgroup 0/1179: -2
>
> [CAUSE]
> The error itself is pretty harmless, and the end user should ignore it.
>
> When a subvolume is fully dropped, btrfs will call
> btrfs_qgroup_cleanup_dropped_subvolume() to delete the qgroup.
>
> However if a qgroup rescan happened before a subvolume fully dropped,
> qgroup for that subvolume will not be re-created, as rescan will only
> create new qgroup if there is a BTRFS_ROOT_REF_KEY found.
>
> But before we drop a subvolume, the subvolume is unlinked thus there is n=
o
> BTRFS_ROOT_REF_KEY.
>
> In that case, btrfs_remove_qgroup() will fail with -ENOENT and trigger
> the above error message.
>
> [FIX]
> Just ignore -ENOENT error from btrfs_remove_qgroup() inside
> btrfs_qgroup_cleanup_dropped_subvolume().
>
> Reported-by: John Shand <jshand2013@gmail.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1236056
> Fixes: 839d6ea4f86d ("btrfs: automatically remove the subvolume qgroup")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/qgroup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index b90fabe302e6..aaf16019d829 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1897,8 +1897,11 @@ int btrfs_qgroup_cleanup_dropped_subvolume(struct =
btrfs_fs_info *fs_info, u64 su
>         /*
>          * It's squota and the subvolume still has numbers needed for fut=
ure
>          * accounting, in this case we can not delete it.  Just skip it.
> +        *
> +        * Or the qgroup is already removed by a qgroup rescan. For both =
cases we're
> +        * safe to ignore them.
>          */
> -       if (ret =3D=3D -EBUSY)
> +       if (ret =3D=3D -EBUSY || ret =3D=3D -ENOENT)
>                 ret =3D 0;
>         return ret;
>  }
> --
> 2.48.0
>
>

