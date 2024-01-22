Return-Path: <linux-btrfs+bounces-1587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3B83592C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 02:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A8AB2205C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 01:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A035185E;
	Mon, 22 Jan 2024 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d67/cZwe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE715BA;
	Mon, 22 Jan 2024 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705887992; cv=none; b=GIuBH6knAAcnob7o11ijCn5UcUu/xBmcqCPbaPfTLXJaP+9a01MnG72taELe19H3e2WWczHMzSZvmZ+C+ifoCIH5WTnk41hO2UMITj3I3JafrheCUmMKBZZyBT33FBjrgeZIiXV+VjBSdCZV4hbJXBYAk1tHhswvKi/b/oZs89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705887992; c=relaxed/simple;
	bh=mdOWFPQKK4Gv4Noq5npy1Ht8YfA9l6yE26DvapcDA80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEmwFwGHBqrOibqpurNW3HemPsbo6RmXYKcZdMMcekmYrVHCrG3NzJEPzm6A7s+WgzXJ2zjXEwazxy87FdVKWkIghz223K5VmFMhgsT+aRnFH6yQn79adlDezAvWJm8I9QZ6tXPglPzhmHSu8JgmWv94rc8s03ulzw/xqPgFw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d67/cZwe; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc223463ee4so2009537276.2;
        Sun, 21 Jan 2024 17:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705887990; x=1706492790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQfVtOz+HFJQtItzfaIVVASjhcqOtKuku6JlXDLa/IU=;
        b=d67/cZwepfb+4G2DYiD7Hq+XkoxzMIMABr/P9ngpvVI1xYWnlQqLOfomoT6yZD6PLz
         gqEI5KQlD5+MHPr+UhtI/rERgf3XR06g5yYmJfdkl4mHHiu6WWeZYad1bzMK6d6YnE0Q
         lvb5pieziQ0Ll1+6qLTrSVqFTnvSfHD06Lt41XnT4jghcGgIJ0HUXjSZqWoOUvjSCGZV
         zUulVo43qIxY8l1hZihxPFNtLLYN/50qkU8Rvqwr8Id/06Q/4i+UyI/znwnHkFl7tH3T
         8buq5j++4sAcN3oLcjz2iu39FE3m+5Iv8EKKAS1WCcTVw3Tv8r4WLOgBu4yt6GulQnKN
         IkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705887990; x=1706492790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQfVtOz+HFJQtItzfaIVVASjhcqOtKuku6JlXDLa/IU=;
        b=gxwuigDbCYg4Ktk0NhnK1G4pO0+YDdDljNjPvWXLv1AA5siRWfshd++hTTLVqb6E1W
         t92X8OPCtzW7qretOoLscJEve3hetWW1rh+79xwZvHX7Sk+Vf1ZJ4xwhwRBrBdSnBAMJ
         AJovfd5GCMX2o84Rz0tHXAmzjTVOfAFxtHMzq5lghlkojuQ7UXORi9xvdlyw6clB5qzx
         UskfEbA2yk4aFldlACFGYe3H0hCIxKVU4nJzcyWnRgdFaNJKJunxlK/98HG7KENoLBPs
         1dWK8lDaakIqy9vWxD5FLy7D9S0JUVdnCoosjsoxJ2HAHUA/GrDR0QWFtwfuOFolbPFq
         1gyQ==
X-Gm-Message-State: AOJu0Yyd2soPlMkWEtAyugBYpkVXZ7Oc9cPYF+jacdS6pAH5NtJStJtR
	qoLxrZz8nKmnRtxv2jmqf3GZzgRYSpSrF1oq/qD4smUkERDupdoHnNURk/g1FKLKpEmKilpNpgm
	F74AfwFZT85uS18d4vIgUUe1fkvw=
X-Google-Smtp-Source: AGHT+IFsJZJU1ElMcyjUj/RT6QzsPObVUM4KEdPf/ayE1ZmZ9eSMWBHPy0WhR4SoH2g45YWOAoa9l+1/ZPJJKO1W7Wg=
X-Received: by 2002:a25:aa01:0:b0:dbf:c7f:7062 with SMTP id
 s1-20020a25aa01000000b00dbf0c7f7062mr1550277ybi.35.1705887989952; Sun, 21 Jan
 2024 17:46:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info> <20240111155056.GG31555@twin.jikos.cz>
 <20240111170644.GK31555@twin.jikos.cz> <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
 <CAKLYge+x9kxLBaJGyk_gTMK2kQ=+Lhg00jgXe=P=jmBUq=cmfA@mail.gmail.com> <7d28b18c-3477-83ec-ef89-cdaf6ca7ebee@oracle.com>
In-Reply-To: <7d28b18c-3477-83ec-ef89-cdaf6ca7ebee@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Mon, 22 Jan 2024 02:46:18 +0100
Message-ID: <CAKLYgeKjkCJ2d0_5uDaH6C7wc4YpX9s6TnQVNDuSr8MsiYbujw@mail.gmail.com>
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks update-grub
To: Anand Jain <anand.jain@oracle.com>
Cc: CHECK_1234543212345@protonmail.com, brauner@kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-kernel@vger.kernel.org, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:35=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
>
>
> On 22/01/2024 08:07, Alex Romosan wrote:
> > update-grub still doesn't work 6.8-rc1
> >
> > so i did:
> >
> > # cat /proc/self/mountinfo | grep btrfs
> > 21 1 0:19 / / rw,relatime shared:1 - btrfs /dev/root
> > rw,ssd,discard=3Dasync,space_cache,subvolid=3D5,subvol=3D/
> >
>
> The latest Btrfs kernel expect one MAJ:MIN for a block device,
> but multiple nodes here point to the same root device:
>
>    /dev/root MAJ1:MIN1 \___ root-device
>    /dev/sda1 MAJ2:MIN2 /
>
> To fix, I'm exploring communication through block-device nodes
> with a temporary signature tag on the superblock for identification.
> Community feedback is pending, and potentially synchronization issues
> maybe a concer.
>
> > the difference from your test case is that it doesn't reference
> > the disk device but /dev/root which on my system doesn't exist. could t=
his
> > be the problem?
> >
>
> How are you reproducing this? I tried with Oracle Linux (OL), Fedora,
> and Arch Linux, but they didn't show /dev/root as the root device.

i'm running debian on a lenovo x1. this is my /etc/fstab

# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/nvme0n1p3 during installation
#UUID=3D695aa7ac-862a-4de3-ae59-c96f784600a0 /               btrfs
defaults        0       0
PARTUUID=3D43094f42-5f54-4456-9d14-3c41e92326e1 /               btrfs
defaults        0       0
# /boot/efi was on /dev/nvme0n1p1 during installation
#UUID=3DA4A3-9199  /boot/efi       vfat    umask=3D0077      0       1
PARTUUID=3D05e00aed-a6ad-4cdc-9a40-4b775dbf87a9  /boot/efi       vfat
umask=3D0077      0       1
# swap was on /dev/nvme0n1p2 during installation
#UUID=3D6b9a36ed-14d8-458d-8575-c8d29dc80bdf none            swap    sw
            0       0
PARTUUID=3Ddb40aeb2-88b4-46eb-970f-58a410bf272e none            swap
sw              0       0

i'm running my own compiled kernel without initrd. the disk with the btrfs
filesystem is the only disk on that laptop. i'm just booting the kernel
(everything works fine there) but when i try to run update-grub i get:

# update-grub
/usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?).

--alex--

