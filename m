Return-Path: <linux-btrfs+bounces-10797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0BFA064BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 19:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B522166E05
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDB6202C3A;
	Wed,  8 Jan 2025 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSRmmm83"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B31204096
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361495; cv=none; b=qou43wyciPozSGdp8YEjjrFs83IyPwsW7N0gM55w+pVUTvUxITHGwGOlG8seSmik4nZd3ZGzJ1iLblgheQC0g9DiQMNbFDCOsJTNVUL3sUKW5+PbZqtIgUwres2TYd8YyfkDbW2Tr581k3haGa3H0vvfLWfu/FPPmd9b2t1PPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361495; c=relaxed/simple;
	bh=Dl973a6I3y2c4btd5ukOXsELFNu3MQ9Gp2qutzamUu4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=e28NWy1hppvX6ULPeKfioEUXtJdpM+kDuqL80cecxG2DQY01j3SSXYWzIN9e/9LW5uhwSisSMpjaDOTQFqigSDz+gOxbWE2pP8q1s99/W0pJPcOQddfStgrR2WLDgWI2LNAkRAyuJAyDB4J+cViA+zVBgdYhIo8Q8yZWA8PtvFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSRmmm83; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166360285dso693395ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2025 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361493; x=1736966293; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s34dAVj1FsAD6xzbSTzXuOqYs1xEEV0s9rXaKWrpfaY=;
        b=PSRmmm83+LEc0rEIlkTemI5IL0vYmkTgFlMzF1wsdjIOZKZd4IvvlRQ/BpTWuHN7Yg
         8GT45eTwvvQkvVthXN+pucnbxKniV51d5ZePj8caCCnwbZVdUiQt7x9LoAoQYro2mU/J
         up+5cjComGKKAab99bWnY1EGq4s/L7BzJ5yVBzTuXDV52gz9uKGz3bOnVTy48cQaRxHu
         JB/LM6O7nVrevZUm1xZY1M9a4rDrzn2csPTi6kAVhKGbuTYmBufMjDGqtjmOskTZcDlE
         KjL5bQDEXrERjjatI7tXD1WHm01NDuFAK1hVefgO9DrU/ytf+VT4VF/JEpJZu0dRhk4m
         XaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361493; x=1736966293;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s34dAVj1FsAD6xzbSTzXuOqYs1xEEV0s9rXaKWrpfaY=;
        b=R8PxWgFIZejE348FzvNr1eL52IcPnCQMD4Kw6IAnekdrggI+Ur5zWR8KXM1gU/ev6W
         iPVYQi2v6bGB9N6ae7aoSmmMBFdevdyICnZNHIXbGDWESLUDNHRW6f2aU/m/wga4ZZMP
         fhODm/iVik0RFSM1LGISmMYfOdeaLGd4Zz4GdEGUTm2xnYrZoM/7MgbexHkc79hccx4k
         GtkUQ6WVs3/ySzz3ZXt4fpkuZZ468a091ceoF6JkrogevdgrcGgpRas7yhMBLg5fVe+r
         EtTCRCmFn1lIs+QKfUAXJxjUHxPHMhmfJWdGdINZwGkwUC+WEilU/cfmz5avT4Gu+wIT
         pTbw==
X-Gm-Message-State: AOJu0YyuI3Tbu8MNHW8WVz6HJmDD2o5aV5NC2ZuOLg63r8CMRUPSaYwP
	pCI+ZyxwSvHLseTOyANZ7JiSI1tM+FgwMq5+moWvXlC1P6hdAqgREebPnyhYMzk9/tIRBJcRKTt
	j4+wQNGsG3RuXvAwZe2BPGyL9VXafS7FqoY4=
X-Gm-Gg: ASbGncvIyjEBWGRqM96gVjKSjKaOaGcpPmsPXTHHDiyWzNn7Ayv9+Iw9BC3dmQq2fms
	rjT8O/nP362nPmg/a21LQ0cHw0Mrk5oVjegjG4g==
X-Google-Smtp-Source: AGHT+IGuU98WclrNfDgO9YKmapnq3NHHqF1IjIWb57ucjKv7bmZxh+RTwEPo8dppoBe/RIffmpDgSSNVuM9+/oJxQ2U=
X-Received: by 2002:a05:6a21:1014:b0:1e1:ab8b:dda1 with SMTP id
 adf61e73a8af0-1e88d2d5ed5mr7755952637.35.1736361493115; Wed, 08 Jan 2025
 10:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Torstein Eide <torsteine@gmail.com>
Date: Wed, 8 Jan 2025 19:38:02 +0100
X-Gm-Features: AbW1kvbIAsqTUWF0RSQctzROUD--BxSJ8XrjiKg7144G2cEuQJIBjFVV8gsNTbU
Message-ID: <CAL5DHTHPWG6r9Q2u3XWnYUSrS9Depw_x2SbDFoL2LnmWzvCyTA@mail.gmail.com>
Subject: Defrag recursively all my subvolumes but not my snapshots.
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
I wanted to defrag all my subvolumes. But I have some issues.

I subvolum tree that looks something this:
/volum1/
=E2=94=9C=E2=94=80=E2=94=80 @home
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsubvol1
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsubvol2
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsubvol3
=E2=94=9C=E2=94=80=E2=94=80 @media
=E2=94=9C=E2=94=80=E2=94=80 @vmDisks
=E2=94=9C=E2=94=80=E2=94=80 @backup
=E2=94=9C=E2=94=80=E2=94=80 @docker/
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsubvol1
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsubvol2
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsubvol3
=E2=94=9C=E2=94=80=E2=94=80 @gitREP
=E2=94=9C=E2=94=80=E2=94=80 @matrix
=E2=94=9C=E2=94=80=E2=94=80 @gitea
=E2=94=9C=E2=94=80=E2=94=80 @borg-cache
=E2=94=9C=E2=94=80=E2=94=80 @homeSync
=E2=94=9C=E2=94=80=E2=94=80 @proxmox
=E2=94=94=E2=94=80=E2=94=80 @home-assistant

Most of the time I am good at using "@" as a prefix for my subvolums,
but as you can see I don't always do.

I was looking in ot the [Github: Kdave
btrfsmaintenance](https://github.com/kdave/btrfsmaintenance/blob/master/btr=
fs-defrag.sh)
It is using a `find -xdev`.

from find man.
> "-xdev  Don't descend directories on other filesystems."

```bash
find "$P" -xdev -size "$BTRFS_DEFRAG_MIN_SIZE" -type f \
-exec btrfs filesystem defrag -t 32m -f $BTRFS_VERBOSITY '{}' \;
```
Issue is that it does not descend directories, and if xdev is removed,
it will include snapshots as well.

I was looking in to `btrfs subvolume list -p /volum1/ | awk '$6 =3D=3D "5"
{print $11}'` and then do a for loop.

-  Issue 1 is that for mounted subvolums, the path is unusable.
```bash
btrfs subvolume list -p / | awk '$6 =3D=3D "5" {print $11}'
@rootfs
```
like i can't do `/$subvolum`, since `@rootfs` is the `/`

- Issue 2 is that nested subvolumes like `/volum1/@home/user/` will not sho=
w up.

I was looking for if `btrfs subvolume list`  was able to list all
subvolum minus all snapshots, preferably in a `ls` format, but was
unable to find any.

How have you solved it?

--=20
Torstein Eide
Torsteine@gmail.com

