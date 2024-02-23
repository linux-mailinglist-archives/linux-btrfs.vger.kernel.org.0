Return-Path: <linux-btrfs+bounces-2672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0688B861638
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47DE283D4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913982C9B;
	Fri, 23 Feb 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0/hf6Cw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296C22329
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703245; cv=none; b=bYddQVlqfXV+ZBvSzAzGdfn6k40LHMfStDG5DISNaA1TJh7AP8aOcNvy/nXGIHh24a4xZJTTQBg8pJeO2R6PpOQIHA/mGfW9LR/g7HAltNCQQBCcpS81OMNZ+UphgUKYlvD0N1e3iQIkbUit4rTeOQJgdGFmZOTsqCpv6KU5Z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703245; c=relaxed/simple;
	bh=veQMOZMXMb6pmgk6D4KOx3T9PZO3s/UElxGj61/0MvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j95tf2Zii0qtKCvfI+yIPMURsGSJD45MaLGGVcI+6f5ta8WJ1Z5fkAQsgqDHExZglfDzxxs63LsO2OimLTQa1RnANwAxBJqv26zas8Gxjp7BsClv9ZMRAx1oe5ixTgLxrnxEquv73VFtOVQ7ASyhl2SES5OPHqy0PW+fvqYJ6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0/hf6Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D64C433C7
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703244;
	bh=veQMOZMXMb6pmgk6D4KOx3T9PZO3s/UElxGj61/0MvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a0/hf6CwnmRDKgeEkgdQtQ1vwiOFb9lWlJz33NY/Sj9RNhpW+FQ9snDTFXw+gY//j
	 GSSxMTgZ7gcTqEde7V1L7xA/hoGM1dMTiOTg3FkhIC2gibb6EvKz/piwsdMemsA6MY
	 LNxUgVHqISUcjiyiAxsY7G2F3tJkyL9XbtbGX2AAQImD+3GIPC9+jWBwoJS8MFBWOF
	 3B48ulDerJW1he7OOwIg3Kbu/CJxbuUuBT5jXKqP28FQTfPC1KDbr4T+CW5GVmW4OB
	 2GDlLeNlMmIdvcIjaAc70yuBfxps2sxYJ0ji+YV1FgGVBHCYcB4AOYDu862qFstN8V
	 15nPaqDaEfl7g==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so108129666b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 07:47:24 -0800 (PST)
X-Gm-Message-State: AOJu0YxGX9QF1YPnv8WPP4AAhbTn8Z5Xve8Pb6X3ml1zizvvYIokwyHe
	TX66FKghQPMn4oKe/TTJ51IPQN5by7EuBeLJYTPLOSHqcWFBqtFhYFr8Lilw4pQDzQA31zhcpfA
	kAByE+6b5RBWKK6tWYXICxvMhVpg=
X-Google-Smtp-Source: AGHT+IEw1lTtbn4d5dHc+53K/CEeWYrGTE5kNZAV/hODFkxzbzsiCduG5qL0pVcaEBG8myg7bV+qJ35j6BqCypha5wY=
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id
 cb13-20020a170906a44d00b00a3d9a2852e6mr109256ejb.50.1708703243026; Fri, 23
 Feb 2024 07:47:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
In-Reply-To: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 23 Feb 2024 15:46:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7CoDyHqSWEKkzJi+akeTvLDpR__xvGO7aZpV=hUzz75w@mail.gmail.com>
Message-ID: <CAL3q7H7CoDyHqSWEKkzJi+akeTvLDpR__xvGO7aZpV=hUzz75w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: include device major and minor numbers in the
 device scan notice
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 11:27=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> To better debug issues surrounding device scans, include the device's
> major and minor numbers in the device scan notice for btrfs.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 32312f0de2bb..6db37615a3e5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -824,13 +824,15 @@ static noinline struct btrfs_device *device_list_ad=
d(const char *path,
>
>                 if (disk_super->label[0])
>                         pr_info(
> -       "BTRFS: device label %s devid %llu transid %llu %s scanned by %s =
(%d)\n",
> +"BTRFS: device label %s devid %llu transid %llu %s(%d:%d) scanned by %s =
(%d)\n",

Can we please leave a space before the opening parentheses?
So that it's consistent with the rest of the message and more readable
(I believe it's also more formal English).


>                                 disk_super->label, devid, found_transid, =
path,
> +                               MAJOR(path_devt), MINOR(path_devt),
>                                 current->comm, task_pid_nr(current));
>                 else
>                         pr_info(
> -       "BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s =
(%d)\n",
> +"BTRFS: device fsid %pU devid %llu transid %llu %s(%d:%d) scanned by %s =
(%d)\n",

Same here.

With that adjusted:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>                                 disk_super->fsid, devid, found_transid, p=
ath,
> +                               MAJOR(path_devt), MINOR(path_devt),
>                                 current->comm, task_pid_nr(current));
>
>         } else if (!device->name || strcmp(device->name->str, path)) {
> --
> 2.38.1
>
>

