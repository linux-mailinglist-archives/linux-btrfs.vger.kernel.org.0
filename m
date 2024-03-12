Return-Path: <linux-btrfs+bounces-3222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8C87941E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0408C1C23147
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78F07A155;
	Tue, 12 Mar 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1dLmOtS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556022E3E9
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246268; cv=none; b=n+82r4gvmb42VCMflzVGjRlFcqQnLtlWpoloqCvs+hBH+uq4pSzTOx9+8eV4neTGb56nmgIb17vn+grHSW9bBFkJIhCd8+zbQnOyu8H1Zyj93woRwMXLHAk1eZR1xhhJVWqVx+BS1Q+7WqW+JHKTUId2+ZQkbqp8Q6kRNEfTKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246268; c=relaxed/simple;
	bh=QjriiTKiG5oOA/JS4bhAlyGIzM3dSnpqWFcZG39/yGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eHG+yO63zrn+oE1k1tQfJ7/hpLrHVjvqrbsdCXa4nokU/GzZuGCMhNqx8ia6KKbVXG/a7Fk2JU7WzGPLo2+TJNzuiLQqIAkc1sEBkmwu6GXcFZpUR4WZlzruc7aZJBWnTQGe5f8gslownUU5pL4HTO19wzrLukRddV/B+bX1QVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1dLmOtS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d45f5c1988so504701fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 05:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710246264; x=1710851064; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkh/0nqY/+aKZ14sKeS98SlFDb4vO3h84v2KwS326Zw=;
        b=h1dLmOtS26oZ3IPFq/4HT1xfwjMLFMPqBv7IJqpjROEzyCTkDTNlULXnV7uHcFmBxZ
         rCAZ/B4r4GCAn89Q+iJEe7lEIjhzsCorxzVtY/EWf9h/4WWp43v+IJWGpJn79oN6wq5T
         IE40Qz9a9jsXb+tz4tCsXYZQSnkfuvGCdnc9ulndOuRqgD74BIM1ZdwWn/cdvBU9vdrR
         rDde5DL7LWn/xHrUoW+QtI1Q94H7l+pOOL8Q8xl/y+p8HdiGVenAQ+bJFPmrnFhiodZQ
         qIMKrB3GnzQWMAkAi/UOdi77YOlvve4R7VRiU1HKiaAtsDfWeubyjJRMHemkeuv3z/aw
         gDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710246264; x=1710851064;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkh/0nqY/+aKZ14sKeS98SlFDb4vO3h84v2KwS326Zw=;
        b=p69pu+q3VaIMFGuL1mjLoND0fVT/li4kV/UaBoA2UgTL9ibTy02xKWfj1TuRq0Z+o9
         e5w2ijANTbr/LWAdYx0paU2po3uayfG3BMBLE3MZBQqL6sSz3RaWN3zTxm4V0g0/32pA
         /tB3LWJwJKuogcbx7DC5CwpoAeXw/u8HOf9PgIa2keYAUgUfOEMjTrcADDWkyNmBxJKm
         h3D4QbaLUIaI2uuaNcuhtn3pxSUu3n9VGTvcApK1tNUSu3rFTAXcH0p4xzGtXBcmgtln
         f8fpWAb50OUbxZWeb+scaHJAVn8vpLMkdr/V/TqUK5fCBRLKQt2wtKmYNVlAnQKBmSp2
         eUzQ==
X-Gm-Message-State: AOJu0YzG7XH+BHGEuQrHjc/7ek+nf6QQ9WOtz+4j09RpokhiBofnvNvK
	NchF42mWxWVhNsDo/Mo7iswrqE+wJQrYiHdtQEDaIy43gXqqUSqQ/G2JQoZK5ZfxcUYfXMe0fjP
	LuNSnFvSt3U1fgG2r13ofOEJoGBz+QwKs
X-Google-Smtp-Source: AGHT+IE4ABFctwE4jnWg+dwanjB6OaIF3lZrpEUKzFnCH1/9BiXKvXM95SZyxjIOSZrfF7tatUje43tId+ImuDVzxOY=
X-Received: by 2002:a05:6512:3c9f:b0:513:9d6b:6d6d with SMTP id
 h31-20020a0565123c9f00b005139d6b6d6dmr6202114lfv.5.1710246263924; Tue, 12 Mar
 2024 05:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312103918.GA374710@tik.uni-stuttgart.de>
In-Reply-To: <20240312103918.GA374710@tik.uni-stuttgart.de>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Tue, 12 Mar 2024 15:24:12 +0300
Message-ID: <CAA91j0XZGSA1oNTDZXm_PRTjnaFcYbf5F+gXTSJ9kCivPuZ1gQ@mail.gmail.com>
Subject: Re: mount ... or other error?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 1:50=E2=80=AFPM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
>
> I have (on Ubuntu 22.04):
>
> root@fextest:~# lsblk -o NAME,SIZE,FSTYPE,LABEL /dev/sdd
> NAME    SIZE FSTYPE LABEL
> sdd    13.5T
> `-sdd1 13.5T btrfs  spool
>
> root@fextest:~# blkid | grep sdd1
> /dev/sdd1: LABEL=3D"spool" UUID=3D"4d8b313d-5710-406b-bdba-b01625bf45ef" =
UUID_SUB=3D"a57d255f-24af-4562-9421-a1eb6e76c051" BLOCK_SIZE=3D"4096" TYPE=
=3D"btrfs" PARTUUID=3D"a409c49c-2b2d-654f-a0aa-9d0b5ea4307f"
>
> root@fextest:~# file -s /dev/sdd1
> /dev/sdd1: BTRFS Filesystem label "spool", sectorsize 4096, nodesize 1638=
4, leafsize 16384, UUID=3D4d8b313d-5710-406b-bdba-b01625bf45ef, 22364351283=
2/44530217717760 bytes used, 3 devices
>
> root@fextest:~# mount -t btrfs /dev/sdd1 /mnt/tmp
> mount: /mnt/tmp: wrong fs type, bad option, bad superblock on /dev/sdd1, =
missing codepage or helper program, or other error.
>
> How can I debug this further?
>

dmesg output would be useful.

