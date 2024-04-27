Return-Path: <linux-btrfs+bounces-4564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77E8B464A
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 14:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254A11F25495
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 12:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB004D9F3;
	Sat, 27 Apr 2024 12:03:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434F4CB36
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Apr 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714219406; cv=none; b=EvUFZmkggKOGOG5zVVH5ECCBaFrtpMjerXIZWAH6eTJrX9CjOtEgx6PHUmOZQqkgrnoG1+awvRsUiPRNQjrzk3bunJWatbnaqJzK5Qap79horozHjMYjodPEUi15QPZg5Zzy3OKSGman/3WyySCsxaPa0JH4WeJTtLEivpbz3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714219406; c=relaxed/simple;
	bh=QZIzC/9FTu29gtM1T/bDn6MLSEL7XR4iCe3mUxJb5kg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=UiXirKRUEIDj9vCBjvoOlDCwy2OZPR7SgNaEIv57+ucvFhw1R+ZJfcpghYynW5rmiqJaLjx+kCSXc2mKACMELHaHS/ayuAcfnMg2nGkF8bXkox1U/SGL9dq9Qa3ScPu5x32vAE8ARvOtWZ/fhCsY11K2KddFjKrdFg/KzYqBUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 5B386C04968
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Apr 2024 14:03:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Pgr3VWsCuq01 for <linux-btrfs@vger.kernel.org>;
	Sat, 27 Apr 2024 14:03:11 +0200 (CEST)
Received: from [192.168.18.34] (unknown [157.25.148.26])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 7C53AC0492A
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Apr 2024 14:03:11 +0200 (CEST)
Message-ID: <79263790-8ced-4b01-a4f2-4c9fd3f3ab97@dubiel.pl>
Date: Sat, 27 Apr 2024 14:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leszek Dubiel <leszek@dubiel.pl>
Subject: =?UTF-8?Q?Re=3A_enospc_errors_during_balance_=E2=80=94_how_to_preve?=
 =?UTF-8?Q?nt_out_of_space?=
To: linux-btrfs@vger.kernel.org
References: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl>
 <79D2FA23B59927D1+bde927bc-1ccf-4a5d-95fb-9389906d33f6@bupt.moe>
 <b2806d95-a50c-41a2-b321-cf62c4f28966@dubiel.pl>
 <3aefeb1.20bf1a80.18ee7da3d40@tnonline.net>
 <99701acc-161b-477c-b1b3-d61e95903045@dubiel.pl>
 <909ed27.f7893fdf.18f020ff6fc@tnonline.net>
Content-Language: pl-PL
In-Reply-To: <909ed27.f7893fdf.18f020ff6fc@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



My system was making backups for about one week.

It was doing automatic "btrfs balance".



Yesterday it went through:

btrfs balance -dusage=0
btrfs balance -dusage=10
btrfs balance -dusage=20
btrfs balance -dusage=30
...
btrfs balance -dusage=100
...
btrfs balance -musage=0
btrfs balance -dusage=10
btrfs balance -dusage=20
...


Something went wrong when balancing musage (m, as metadata).
System got "read only".



While this happened btrfs was in a process of deleting four snapshots 
(btrfs sub list / -d  — not empty).




It had 450 GB of free space (shown for df -h).

It had almost no Unallocated space (btrfs dev usa /).



After reboot system is mounted read-only.
Kernel shows (Ctrl+D or give root password for maintenance).


Tried to run    btrfs balance -dusage /      on read only system failed.

Tried to mount -oremount,rw    hanged.


Reboot.




Started from USB key Finnix to repair.


Started to mount system.


Dmesg shows:

              bdev /dev/sdc3 errs: wr 0, rd 0, flush 0, corrupt 35967, gen 0


It mounts for a long time now.
Nothing more in dmesg.
Mount command seems stalled, but on iotop I see "btrfs-transaction" 
running — write about 10 M/s



I will leave the system over night and check tommorow or on monday if 
mount was successful.




PS. script that was balancing:


         findmnt --types btrfs --output SOURCE --nofsroot --noheadings | 
sort | uniq |
         while read dev; do
                 mnt=$(findmnt --source "$dev" --output TARGET 
--first-only --noheadings)
                 test -d "$mnt" || continue

                 # no balance if plenty of unallocated space
                 btrfs dev usage "$mnt" -g |
                 perl -ne '/Unallocated: +([0-9]+\.[0-9]{2})GiB/ and $1 
< 21 and print $1' |
                 grep -q . || continue

                 for typ in dusage musage; do
                         for usa in $(seq 0 10 100); do
                                 # if relocated, then get out of two 
loops for next "$dev"
                                 btrfs balance start -$typ=$usa,limit=3 
"$mnt" 2>&1 |
                                 grep -Eq "Done, had to relocate 
[1-9][0-9]* out of [0-9]+ chunks" &&
                                 break 2
                         done
                 done
         done






