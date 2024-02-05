Return-Path: <linux-btrfs+bounces-2109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD762849A8F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 13:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811751F21534
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899051BDD6;
	Mon,  5 Feb 2024 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1I49Jex"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346B1BC37;
	Mon,  5 Feb 2024 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136716; cv=none; b=MW1ANAL2ZZFgyddzcqlzhn8Z9Ty/BzNdNZ5R6+L4xQfMVOw4cJwNTaXHeR+WB4biuj0Mn9ajSGklddEOiSMINYcFxKiEBFjRtx3GwnPBCo2U9Tj0qQ3zfQgz3y4Cgm5BanqkW+/UTj3vxZBaikumTRflKlW2yNbXWG+mtwHFEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136716; c=relaxed/simple;
	bh=ZjyQvDoFp8Iz2SVNGI6LFFX46oN/i7mz7hhxREWzs8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGm/G/F1mtqfRVlebnhnqfNklA1XJ3hjyfnQ2zxAk3D6Zpps+LClvyDc4UpmL9JbEa0jrbH2q87410mmNMR+Zw2oV7xypnvFLTsCEyxqJHJxVkZO6Rdk+ecrDrzHsST4Q23nEhZ+E9MkcDxGDJwVtR9UwfJx8sbvT9dkKlAEm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1I49Jex; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ffdf06e009so37169337b3.3;
        Mon, 05 Feb 2024 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707136714; x=1707741514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjyQvDoFp8Iz2SVNGI6LFFX46oN/i7mz7hhxREWzs8w=;
        b=J1I49JexAB6PE/BYae1TnNp3VhKNxI1Pu5dTWJW6J60XTVYxCrOMkNWA9lYM0zoPcC
         65gu5KlxWA8aXTO1otMEW444GMLO9wKUZzj/jJdueW55y7D3e86cUaG+j6b4v9q1+xXA
         XNUhZyCHMubFSmsDC1T8orqBUdh9XIgy3Mih2+O2zO8fF8pTVewe/fUVE0hL5fWS5pTN
         84WqltCrcCp1jGd84lsGj/c5csv+WjfwJlnc+yyWD91Ana/clpy7Y92/H8NdNz+m8m3T
         YWMlXJVisXJD1M8ub3n2ixoQ3dBEqpd09KAbVGsFgbgQa1ogTs17LUWWKxDCtj+fk7qO
         Awdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136714; x=1707741514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjyQvDoFp8Iz2SVNGI6LFFX46oN/i7mz7hhxREWzs8w=;
        b=V8zihvmnmvsGIbkKr4qMHeT+sXdg+VCBVY040BTjLgSi6FUd2o/JKFpMFKdzMGzdDZ
         FYiS32pxdXCIFKLe40ywOMqITpmXHjffBCgmYnPGm/X9dPUFIVV65Vl1E2GmuZiwDrr9
         kNntQGx9NjPq9tgOYgmGfcpCMiy3btYnhjfsZ/YC2c09Q6ar3O5Wd/x9QOsmf86l7q2r
         V3BV17+LZn8rEul5rpqRLT0TTvi1WzgzKzVyitM6tQKVkBr/r+pnWuNgCDStoSh9DcRi
         u7RmtfG2V4T5K8zSNYOmn7yI4NaY7bEgqoL0jRzatWTEzyCKp6vIMiEu5xwmIHjsqvi1
         BBKA==
X-Gm-Message-State: AOJu0YySxFz9dQpQxdkx8LP0C2gS+rTTPWj0MI0WIHkMgCTApbPMB4Y6
	VfF6uFrUr1fVNZX6f4dNsCUVRj2kLL3F9Kg3A1DL/Fx8h26P3bDIfsbCPpki94KL1yB6wTf7MPS
	1+6BruWgw5445ZrSJJgAhYGeUoJI=
X-Google-Smtp-Source: AGHT+IED7kOb/CTGUQsjCMQwiFvHcr73C4qzzSvs1YNrN19FZXiTn8fx9WHoc17GvdpKwLrWsPYV7AoAmypKzVM+8/Q=
X-Received: by 2002:a25:145:0:b0:dc6:e75d:d828 with SMTP id
 66-20020a250145000000b00dc6e75dd828mr7804555ybb.18.1707136714056; Mon, 05 Feb
 2024 04:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info> <20240111155056.GG31555@twin.jikos.cz>
 <20240111170644.GK31555@twin.jikos.cz> <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
 <7d3cee75-ee74-4348-947a-7e4bce5484b2@leemhuis.info> <CAKLYgeLhcE5+Td9eGKAi0xeXSsom381RxuJgKiQ0+oHDNS_DJA@mail.gmail.com>
 <CAKLYgeKCuDmnuGHuQYPdZZA1_H3s9_9oh+vT_FMpFZqxKSvjzw@mail.gmail.com> <20240205112619.GC355@twin.jikos.cz>
In-Reply-To: <20240205112619.GC355@twin.jikos.cz>
From: Alex Romosan <aromosan@gmail.com>
Date: Mon, 5 Feb 2024 13:38:23 +0100
Message-ID: <CAKLYgeK835ESfJ-rNzRsLHKUMQ8rU6HzV3_x6XaUu=HX0sg1=A@mail.gmail.com>
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks update-grub
To: dsterba@suse.cz
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Anand Jain <anand.jain@oracle.com>, 
	CHECK_1234543212345@protonmail.com, brauner@kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

i can confirm that with this patch applied on top of 6.8-rc3 i can now
run update-grub. thank you. checked the kernel logs for btrfs related
messages and everything seems fine:

Btrfs loaded, zoned=3Dno, fsverity=3Dno
BTRFS: device fsid 695aa7ac-862a-4de3-ae59-c96f784600a0 devid 1
transid 1990924 /dev/root scanned by swapper/0 (1)
BTRFS info (device nvme0n1p3): first mount of filesystem
695aa7ac-862a-4de3-ae59-c96f784600a0
BTRFS info (device nvme0n1p3): using crc32c (crc32c-generic) checksum algor=
ithm
BTRFS info (device nvme0n1p3): disk space caching is enabled
VFS: Mounted root (btrfs filesystem) readonly on device 0:19.
BTRFS info (device nvme0n1p3): the free space cache file
(604538667008) is invalid, skip it
BTRFS info: devid 1 device path /dev/root changed to /dev/nvme0n1p3
scanned by (udev-worker) (277)
BTRFS info (device nvme0n1p3): the free space cache file
(675405627392) is invalid, skip it
BTRFS info (device nvme0n1p3): the free space cache file
(696880463872) is invalid, skip it
BTRFS info (device nvme0n1p3): the free space cache file
(725871493120) is invalid, skip it
BTRFS info (device nvme0n1p3): the free space cache file
(799959678976) is invalid, skip it
BTRFS info (device nvme0n1p3): the free space cache file
(1658160414720) is invalid, skip it

not sure what's going on with the free space cache file, it wasn't
that long ago i mounted the disk with the clear_cache option after
which those messages disappeared but now it's back again...

--alex--

On Mon, Feb 5, 2024 at 12:26=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Sun, Feb 04, 2024 at 07:29:29PM +0100, Alex Romosan wrote:
> > sorry about the html post (in case somebody actually got it). as i was
> > saying, just for the record it's still not fixed in 6.8-rc3. thanks.
>
> I've updated the bug with link to fix
>
> https://github.com/kdave/btrfs-devel/commit/b80f3ec6592c69f88ebc74a4e1667=
6af161e2759
>
> but would like to ask for testing.

