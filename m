Return-Path: <linux-btrfs+bounces-10696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE8BA00220
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 01:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945223A3995
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 00:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3522619;
	Fri,  3 Jan 2025 00:47:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D042594A0
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735865227; cv=none; b=T0Ajozlf1a6NUYiCDgY3ZDGBADgLlI9kwS95fWrzMNiHwJdSy88/N7yAYVujz//1t5isAzcReY+mPYhb+/+eCX3mhZuTJL6Zmepb2ajMlfNuRm+ib0X6AUwNAorTJ2AGQOdbDykX8avyFbX4ZXOdGAWwus6uAYMDz7zsCFMPTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735865227; c=relaxed/simple;
	bh=1aKSWDrve4JZsPHzTQAuvJ64Yk1TfJSRZJX6c2Evb+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbkxIIVOZp8Lv9Vjn1lSdBsheEXl9oNR7cdEBW7SLEKltw4Un5ELpGom+iFHnIfW8XHHxBw5byAy6dQk1yC+f7Ooi9VJ/KixHQeouNqDXVygW0elrYfhcaaJEyGSKJq9n0L+DW9QkbrFoknXt/PdywVcGPl95v9xM7zbHkkAMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa692211331so2240567766b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2025 16:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735865223; x=1736470023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G973nDCrR7Uc/XZlOUlsaCHoNiDiWWMKsCikZU5twC4=;
        b=jTLbTNWihxglpFh8leCGplPxwJ3qtzJv2IAlGr7J+n9NpfAMEezIqBY4Qh5j28t9CH
         OPGfsoFy5I8l/+3NkhC8UGdpz0u19QpEt53XDZe5c7gktCLaBsCRx8RLdOyDYt6wOBoG
         chFFGOHStdPbDVY7xAyduZ6qtRh6PWIjRfXn4FxNzor9Wfhbo9x2Xy29zVF9/GoHm+Uc
         jB8tRBj9Lh/iSvhuxaKQpcJwBUBDGcZGStdROqtwCD92mmrFDK8F33nt7SNPiBpbuSYR
         XSQPXw32gOQLA/i7KrhhQvOhDH8Nt6E09KEp4iWsQKGnLX+ouaVoHqT1bYtxhVvxThHq
         61Yg==
X-Gm-Message-State: AOJu0YwHuZ0YifQlLQPOp+ra0miCE3kT4ZoHHunyqsHKEGbgSU3CI37j
	JdBM1CjdEtfGWE/wVgGuhrMrxfTMb3DOTpcNubl0azsZBBpKbemYNjnS93+A
X-Gm-Gg: ASbGncv0PQTPty0aaTnAmb0YHRgeUpGTZLA+TryJh6eEIZYVYyn0fXqRS4zY8xjG1YE
	F2j3o0zQKxcBOD7gcwi2ubV1U9AgLlPIFnUBvEiw+flKzyDMJ15VhuaW7WxLCGu8viOV6X5YPy/
	fAxQo8HN3Gi/0GSKtxirkph1Ey7Qzd2IeH6PEovtUE2nSRa1Xs55Y7kvxla/ytq+Auyqb7q+p6a
	+Ce9AhpQTl7g32k2I5Hpm+WHBgHCgw7HKFtpfHTgtZUlLLBZCgBCwO6v3itPJTXI/VqVnF45Wr8
	G1I+A/XBB6Q=
X-Google-Smtp-Source: AGHT+IHvWbrcjx9KaQTLfpqXphv1O9eslA055YHF7BrUK15R6zXRplRz63m3AoEQvx9Uss/eqfkRAg==
X-Received: by 2002:a17:907:3fa3:b0:aa6:945c:4531 with SMTP id a640c23a62f3a-aac3349e34amr3110658666b.7.1735865222941;
        Thu, 02 Jan 2025 16:47:02 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e830daasm1821072866b.13.2025.01.02.16.47.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 16:47:02 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa692211331so2240566566b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2025 16:47:02 -0800 (PST)
X-Received: by 2002:a17:907:9482:b0:aa6:8096:2049 with SMTP id
 a640c23a62f3a-aac3350c059mr4184711366b.13.1735865222501; Thu, 02 Jan 2025
 16:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fb12d07525d725188649f8dae90c0cfc8d31a0db.1735767974.git.wqu@suse.com>
In-Reply-To: <fb12d07525d725188649f8dae90c0cfc8d31a0db.1735767974.git.wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 2 Jan 2025 19:46:26 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9P=dvNbA9FiYgaXixs78T7PofhHy02P-ON7BWe=9qcww@mail.gmail.com>
Message-ID: <CAEg-Je9P=dvNbA9FiYgaXixs78T7PofhHy02P-ON7BWe=9qcww@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: prefer to use "/dev/mapper/name" soft link
 instead of "/dev/dm-*"
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Duchesne <aether@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 4:47=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a gentoo bug report that upstream commit a5d74fa24752
> ("btrfs: avoid unnecessary device path update for the same device") break=
s
> 6.6 LTS kernel behavior where previously lsblk can properly show multiple
> mount points of the same btrfs:
>
>  With kernel 6.6.62:
>  NAME         MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
>  sdb            8:16   0   9,1T  0 disk
>  `-sdb1         8:17   0   9,1T  0 part
>    `-hdd2     254:6    0   9,1T  0 crypt /mnt/hdd2
>                                          /var/cache/distfiles
>                                          /var/cache/binpkgs
>
> But not with that upstream commit backported:
>
>  With kernel 6.6.67:
>  sdb            8:16   0   9,1T  0 disk
>  `-sdb1         8:17   0   9,1T  0 part
>    `-hdd2     254:6    0   9,1T  0 crypt /mnt/hdd2
>
> [CAUSE]
> With that upstream patch backported to 6.6 LTS, the main change is in
> the mount info result:
>
> Before:
>  /dev/mapper/hdd2 /mnt/hdd2 btrfs rw,relatime,space_cache=3Dv2,subvolid=
=3D382,subvol=3D/hdd2 0 0
>  /dev/mapper/hdd2 /mnt/dump btrfs rw,relatime,space_cache=3Dv2,subvolid=
=3D393,subvol=3D/dump 0 0
>
> After:
>  /dev/dm-1 /mnt/hdd2 btrfs rw,relatime,space_cache=3Dv2,subvolid=3D382,su=
bvol=3D/hdd2 0 0
>  /dev/dm-1 /mnt/dump btrfs rw,relatime,space_cache=3Dv2,subvolid=3D393,su=
bvol=3D/dump 0 0
>
> I believe that change of mount device is causing problems for lsblk.
>
> And before that patch, even if udev registered "/dev/dm-1" to btrfs,
> later mount triggered a rescan and change the name back to
> "/dev/mapper/hdd2" thus older kernels will work as expected.
>
> But after that patch, if udev registered "/dev/dm-1", then mount
> triggered a rescan, but since btrfs detects both "/dev/dm-1" and
> "/dev/mapper/hdd2" are pointing to the same block device, btrfs refuses
> to do the rename, causing the less human readable "/dev/dm-1" to be
> there forever, and trigger the bug for lsblk.
>
> Fortunately for newer kernels, I guess due to the migration to fsconfig
> mount API, even if the end user explicitly mount the fs using
> "/dev/dm-1", the mount will resolve the path to "/dev/mapper/hdd2" link
> anyway.
>
> So for newer kernels it won't be a big deal but one extra safety net.
>
> [FIX]
> Add an extra exception for is_same_device(), that if both paths are
> pointing to the same device, but the newer path begins with "/dev/mapper"
> and the older path is not, then still treat them as different devices,
> so that we can rename to use the more human readable device path.
>
> Reported-by: David Duchesne <aether@disroot.org>
> Link: https://bugs.gentoo.org/947126
> Fixes: a5d74fa24752 ("btrfs: avoid unnecessary device path update for the=
 same device")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix unnecessary rename where the filename is the same
>   The problem is in the exception handling that if both old and new path
>   matches, we will still do the rename.
>   Fix it by revert the exception check condition and setting is_same to t=
rue when
>   path_equal() is true.
>
> - Fix special chars in the commit message
> ---
>  fs/btrfs/volumes.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c8b079ad1dfa..5a0327e11807 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -832,8 +832,21 @@ static bool is_same_device(struct btrfs_device *devi=
ce, const char *new_path)
>         ret =3D kern_path(new_path, LOOKUP_FOLLOW, &new);
>         if (ret)
>                 goto out;
> -       if (path_equal(&old, &new))
> +       if (path_equal(&old, &new)) {
>                 is_same =3D true;
> +               /*
> +                * Special case for device mapper with its soft links.
> +                *
> +                * We can have the old path as "/dev/dm-3", but udev trig=
gered
> +                * rescan on the soft link "/dev/mapper/test".
> +                * In that case we want to rename to that mapper link, to=
 avoid
> +                * a bug in libblkid where it can not handle multiple mou=
nt
> +                * points if the device is "/dev/dm-3".
> +                */
> +               if (strncmp(old_path, "/dev/mapper/", strlen("/dev/mapper=
")) &&
> +                   !strncmp(new_path, "/dev/mapper/", strlen("/dev/mappe=
r")))
> +                       is_same =3D false;
> +       }
>  out:
>         kfree(old_path);
>         path_put(&old);
> --
> 2.47.1
>
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

