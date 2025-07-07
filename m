Return-Path: <linux-btrfs+bounces-15283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F2CAFB18F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089064A22E1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50D298CA6;
	Mon,  7 Jul 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="JTrafcw5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D4293C45
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885210; cv=none; b=QMhmmmT8xcazBs//3Vw1Xuo/OZx/McNRLQxaMqWA7B00uE48J2fcLPiiDunDdCuGvp4YU3B4KBLzqlhc32AMumspWsAbZROz40sIPY08mBfeZfOgPePt+jP1z2ZfOmyHRrzJNqLtDsfV5s/CY3GGH8ZcO5XcZwuaUiXLfQUsl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885210; c=relaxed/simple;
	bh=E2dvSMlXafET2m5LuAcf1unj8iXvOVudr/wBzhVvsQ8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mwm441HZM/tLTYecAj9SAudo9whcHBN+pRIFFNEQ9jhLf7L5f6w9LkX9REclR0iQMUcck1Kiw630o0LffZgO5gTv/84/6wwTMQ67oc+Gmy+hnwSq+v258ykKjUSPHE1pAhBimARc44uRIoEtExOongOIY5qPyWd08FXE2gupgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=JTrafcw5; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4656428399D;
	Mon,  7 Jul 2025 12:46:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1751885206; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=A+bMksYUgWdz4dYJtX2+IODbRnf76+bwa4lOmAYXzF0=;
	b=JTrafcw5nHlBbcsV9O/YkGraxJuCjP/jvFiUk4F0a8qcmrQJtzTkYAYXKG8xJcN4zbJEn4
	BcSczatC95sAmIkeZgh5wCj0YqfS58BAsp5xs6dG0+K8mOwQTMK2HSc3FTXbY1d7E3yTES
	QSNTguS5R54LaDrfidGh5+HeLpzC0dUN+V0a7DIuqXRRM5Y/ri2dQHQfA7AzlkVu7Jinu5
	kg2f4Rd94hYqEJbR+7pV/T8rAas8Sv6aK37lI2vjOqoxByfdsFynLtX7hjeeoKgHX/pgnt
	nG7twbKfs29u2zPXd0LhqL9xYJ2RuCDpVpzflgyLUaamrfIK9aRKlvBhIooUdg==
Message-ID: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
Date: Mon, 7 Jul 2025 12:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org, dave@jikos.cz,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dnaim@cachyos.org
From: Peter Jung <ptr1337@cachyos.org>
Subject: Increased reports since 6.15.3 of corruption within the log tree
Organization: CachyOS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

There has been increased reports of users reporting that they could not 
boot into their system anymore - sometimes after a needed force 
shutdown, but also according the users after a normal shutdown/reboot 
process.

The filesystem can be accessible again, after running following command 
in the chroot:

```
sudo btrfs rescue zero-log /dev/sdX
```

There is no way to reproduce this constantly.

Following commits did land in 6.15.3:

btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
btrfs: exit after state split error at set_extent_bit()
btrfs: fix fsync of files with no hard links not persisting deletion
btrfs: fix invalid data space release when truncating block in NOCOW mode
btrfs: fix wrong start offset for delalloc space release during mmap write
btrfs: scrub: fix a wrong error type when metadata bytenr mismatches
btrfs: scrub: update device stats when an error is detected

Some reports:
https://discussion.fedoraproject.org/t/fedora-kde-no-longer-booting-likely-filesystem-btrfs-corruption/157232/10
https://www.reddit.com/r/cachyos/comments/1lmzmm4/failed_to_mount_on_real_rooted/
https://www.reddit.com/r/cachyos/comments/1llin1n/error_failed_to_mount_uuid_on_real_root_cant_boot/
https://www.reddit.com/r/cachyos/comments/1llrpcb/unable_to_boot_os_you_are_in_emergency_mode/
https://www.reddit.com/r/cachyos/comments/1lr5nro/my_cachyos_is_down/

We do not know, if the issues have decreased or improved since 
6.15.4/6.15.5 since we can not ensure, that users have their system 
fully updated.
All in all we got on CachyOS around 50-80 reports since the push of 
6.15.3, but there are also increased reports in Fedora and archlinux


Best regards,

Peter "ptr1337" Jung

