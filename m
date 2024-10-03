Return-Path: <linux-btrfs+bounces-8488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B04298ECB3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A41E281A1E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C04149C6F;
	Thu,  3 Oct 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGcOYX7o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED513B780
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727950298; cv=none; b=sdKcTGjKxwfI6Ish7I6EsF3yPBhWrVHZnfumPOapVZjvalL2e2Or5oIZFZAEQREbXrzfrZXu/o2f2uFll/qzwVR69NWBqAXBdXJa/nTslo3y5daNHVzzcG8HdgVYf8hLiTntoQEqaXb5bNJrYraECOcQW0tfGlEcCKF3X2+sDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727950298; c=relaxed/simple;
	bh=HE4jXSU8wO/AZjliEAWVcfcc4RGpdnDOK0+72y9rico=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3yK9/wnrjawgXqYqz2qFCNtTSBFX4UlVkjTXuHBt4TzxbyEgHRz9KRWGNlnWsENH8wwf+0gGBN4thY4FA5neDRuwoIsfe087QuFD/FbqVirsLdMa+fTI8UX+2+7GDWKEOSBbigaVwU0Bc7fBcGgqmD50oaHIrHNz1a4oBzE6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGcOYX7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29EFC4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 10:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727950297;
	bh=HE4jXSU8wO/AZjliEAWVcfcc4RGpdnDOK0+72y9rico=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MGcOYX7o/yAazJES3rGDvJq7NOt/aTJRzCd8dv2nCXWMeamXjq+C86AoaDdpe7UfW
	 b/rHLbVGaytnvJTDwsKEC+aGhDdTHb2FftKH80gTQ+im4gdT3I+LdWM+oMVEPrGto3
	 PKdo5eAAzfRd9wjZOkW4Z8M1YSi2TssdMzbaPOY6y5CPc5gImi/sjn1fYt+J5bKlMI
	 XDSv1Cj8FkkPI+u4aMHx3J1AZMlo9yJUGK+1TAl5OsdfJ928E1IN6DN/BDhOuNTyhj
	 74tV2GsuDScEJ7ZYtKrs0NbN7F0hJqO/6qfjozzvpn0JXAshTfvcA8BU+JFZtDU8n7
	 6/IeKSqNY5PAQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a98f6f777f1so96158566b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 03:11:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx8v9Eji91h3TvksiPpNhYccPH5suJ7qZtNk0UWCHV8G/8gk68h
	nCDx34Y5su7H+drLXGI16tGg8r/bPvA2PI7lCSImO4a0bUL2thtxYKJnhz7HzorTyCJeaWccUHz
	lCeHzC5ERjKif/IQlNSbcOh18I7Q=
X-Google-Smtp-Source: AGHT+IGnElDgeZJ1olApYbYEBL2X3qLu7hwPO5POyiSe9BkY+eXthXLRtw/o0BZWZ2wPdzcn6SLU5KIL+V0PuBRQ1eI=
X-Received: by 2002:a17:907:6093:b0:a8a:58c5:78f1 with SMTP id
 a640c23a62f3a-a98f8201512mr594197766b.11.1727950296358; Thu, 03 Oct 2024
 03:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4a0faeba1d195f2eb71fcaae388f5976f822dc2.1727904561.git.wqu@suse.com>
In-Reply-To: <a4a0faeba1d195f2eb71fcaae388f5976f822dc2.1727904561.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 3 Oct 2024 11:10:59 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6f0Qcqc7+q042s83A7aTNKiOddtbx=kjpiXfXZbQMy0A@mail.gmail.com>
Message-ID: <CAL3q7H6f0Qcqc7+q042s83A7aTNKiOddtbx=kjpiXfXZbQMy0A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix the wrong rcu_str_deref() usage
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:39=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> For rcu_str_deref(), it should be called with rcu read lock hold.
> But inside the function is_same_device(), the rcu string is accessed
> without holding the rcu read lock, causing rcu warnings.
>
> Fix it by holding the rcu read lock during the path resolution of the
> existing device.
>
> This will be folded into the offending patch "btrfs: avoid unnecessary
> device path update for the same device"
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/volumes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 35c4d151b5b0..3867d3c18be5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -807,8 +807,10 @@ static bool is_same_device(struct btrfs_device *devi=
ce, const char *new_path)
>         if (!device->name)
>                 goto out;
>
> +       rcu_read_lock();
>         old_path =3D rcu_str_deref(device->name);
>         ret =3D kern_path(old_path, LOOKUP_FOLLOW, &old);
> +       rcu_read_unlock();
>         if (ret)
>                 goto out;
>         ret =3D kern_path(new_path, LOOKUP_FOLLOW, &new);
> --
> 2.46.2
>
>

