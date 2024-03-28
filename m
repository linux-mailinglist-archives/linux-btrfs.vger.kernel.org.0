Return-Path: <linux-btrfs+bounces-3723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6688FEBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 13:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D44728F9D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF07EF0E;
	Thu, 28 Mar 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b="WITTt+CX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.tnonline.net (mx.tnonline.net [65.109.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3C5474B
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627879; cv=none; b=LJ5zQShWFg5+TpJWI+cnUKmsC/ycz//bzHhGZdqxa8svU9yYAIKh+pHXlV+GiRZrqG5TC7JCQtPJ6Wks4djespJhevSiDpXJcbeAptyQT/GAQaA9W14j7hPgwinwOEFpTKH8FaagGkopsueiDKFQU3+n6VCYT9r57EfErVOA0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627879; c=relaxed/simple;
	bh=kcES+pSCgITsCL1uOeN01tZWb6ZNeXonCSkk6BUoy0M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WZ+HfJr4KOIHXNimMWHf5IT3BOqSfdFLesWvqupN4+CjyhpWkdDcupOLODfSIFxdEJkV1wxDeOS46oUZug3ht7FRCWmZRQW2CFfvRB49l6XlRclj3huVbL+6zCbaCvD+vtPpP3VGcC4UjGObpRfjlIuM5YMvkH+r7b2bTnA8iKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net; spf=pass smtp.mailfrom=tnonline.net; dkim=pass (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b=WITTt+CX; arc=none smtp.client-ip=65.109.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnonline.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XU/76tvjGLNBiqeocGO1CYXuUYKE3yM5qtt+D1lBZe0=; t=1711627877; x=1712837477; 
	b=WITTt+CXTovFjs7tEdmUm2VbuMsPJs/tN9FQhF9XF9shDWGU8jXpiezBB+DsKm9/ct7qYNd/FJQ
	ktYyHF+QNMilYXCR+XyG+Bdq0u8ltVrOOjAdpg2TrF78xzNIKEoi/+zQ2GmtVKhQsn0z4UzwoefoS
	nE+QnQny2/cPWj3aqXA1BN+aOSX6aDYEVKJrn9OFr3OXkJfIOn2nJ44TZNg/fHO0E3V03NxRT4Psl
	95oOD1h/4C1Z67kUxoc2vpzFnTzY6ZGxNvMYNCkeMB2D8H5Qy6Es0Q9MKLT+IOZshlvlrLIsSE4p2
	VVW54Kp5YsDFkHIWdv78Ol17WijkNHjzmpaw==;
Received: from tnonline.net ([2001:470:28:704::1]:35344)
	by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <postmaster@tnonline.net>)
	id 1rpo9P-000000000lW-2M6c;
	Thu, 28 Mar 2024 11:42:32 +0000
Received: from [138.106.53.101] (port=10425 helo=[10.99.217.191])
	by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <forza@tnonline.net>)
	id 1rpo9M-000000000q4-2p7o;
	Thu, 28 Mar 2024 12:42:28 +0100
Date: Thu, 28 Mar 2024 12:42:27 +0100 (GMT+01:00)
From: Forza <forza@tnonline.net>
To: Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
	Matthew Warren <matthewwarren101010@gmail.com>
Message-ID: <5c2a178.354ec378.18e84de55cf@tnonline.net>
In-Reply-To: <CAOLfK3UuMNn1Q2t-seqcOXu4xVbWQU4rOSVkY2qn4RsyOcBCAA@mail.gmail.com>
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com> <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com> <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com> <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com> <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com> <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net> <CAOLfK3UuMNn1Q2t-seqcOXu4xVbWQU4rOSVkY2qn4RsyOcBCAA@mail.gmail.com>
Subject: Re: raid1 root device with efi
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
X-Spam-Score: -0.7 (/)



---- From: Matt Zagrabelny <mzagrabe@d.umn.edu> -- Sent: 2024-03-27 - 21:21=
 ----
>=20
> Are folks using the "degraded" option in /etc/fstab or the grub mount
> options for the btrfs mount?
>=20
> I've read online [0] that the degraded option can cause issues due to
> timeouts being exceeded.

No, i do not recommend it. The issue isn't with grub, but if a device is mi=
ssing during boot (hotplug, cables, errors, etc), and the system continues =
to use the remaining disk and later the disk comes back online you would ha=
ve a split-brain situation. As far as I know there is no specific handling =
in btrfs for this, and the recommended way is to wipefs a removed device be=
fore adding it back.=20

For this reason it is better to be forced to manually handle the situation.=
 You could, for example have a second boot entry for degraded mode, etc.=20


>=20
> Also, I'm seeing some confusing results of looking at the UUID of my disk=
s:
>=20
> root@achilles:~# blkid | grep /dev/sd
> /dev/sdb2: UUID=3D"9a46a8ad-de37-48c0-ad96-2c54df42dd5a"
> UUID_SUB=3D"7737fc5f-036d-4126-9d7c-f1726d550444" BLOCK_SIZE=3D"4096"
> TYPE=3D"btrfs" PARTUUID=3D"3a22621c-a4e1-8641-aa0f-990a824fabf4"
> /dev/sdb1: UUID=3D"BD42-AEB1" BLOCK_SIZE=3D"512" TYPE=3D"vfat"
> PARTUUID=3D"43e432b1-6c68-4b5c-9c30-793fcc10a700"
> /dev/sda2: UUID=3D"9a46a8ad-de37-48c0-ad96-2c54df42dd5a"
> UUID_SUB=3D"9436f570-6d15-4c74-aff8-5bd85995d92d" BLOCK_SIZE=3D"4096"
> TYPE=3D"btrfs" PARTUUID=3D"e3b4b268-99e8-4043-a879-acfc8318232b"
> /dev/sda1: UUID=3D"BD42-AEB1" BLOCK_SIZE=3D"512" TYPE=3D"vfat"
> PARTUUID=3D"02568ee9-db21-4d03-a898-3d1a106ecbec"
>=20
> ...why does /dev/sdb2 show up in the following /dev/disk/by-uuid, but
> not /dev/sda2:
>=20
> root@achilles:~# ls -alh /dev/disk/by-uuid/
> total 0
> drwxr-xr-x 2 root root  80 Mar 25 21:16 .
> drwxr-xr-x 7 root root 140 Mar 25 21:16 ..
> lrwxrwxrwx 1 root root  10 Mar 25 21:16
> 9a46a8ad-de37-48c0-ad96-2c54df42dd5a -> ../../sdb2
> lrwxrwxrwx 1 root root  10 Mar 25 21:16 BD42-AEB1 -> ../../sda1

I believe only the first device found can have a link. It is not possible t=
o have multiple link from one UUID to several devices.=20

>=20
> What do folks think about the following fstab?
>=20
> root@achilles:~# cat /etc/fstab

> #
> # <file system>                           <mount point>   <type>
> <options>                      <dump>  <pass>
> # / was on /dev/sda2 during installation
> UUID=3D9a46a8ad-de37-48c0-ad96-2c54df42dd5a /               btrfs
> defaults,degraded,subvol=3D@     0       0
> UUID=3D9a46a8ad-de37-48c0-ad96-2c54df42dd5a /home           btrfs
> defaults,degraded,subvol=3D@home 0       0
> # /boot/efi was on /dev/sda1 during installation
> UUID=3DBD42-AEB1                            /boot/efi       vfat
> umask=3D0077                     0       1
>=20

I recommend you do not use degraded. Instead maybe you'd want noatime, unle=
ss you have strong reasons for using atime system-wide. The keyword "defaul=
ts" is  mostly a placeholder and isn't needed if you have other options.=20

https://github.com/kdave/btrfs-progs/issues/377

~ Forza=20



