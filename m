Return-Path: <linux-btrfs+bounces-4631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06A8B6456
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 23:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC8A283942
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC78179641;
	Mon, 29 Apr 2024 21:05:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650841779BD
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424752; cv=none; b=IvRuMCWR1ezCaB4z2EQBKGFLJccPIr/M0BQP+AYROsvyuN2eb383Wt2HE7iKxLoEw9eDNUthN7lrA8MrWyw7JGM8WyPN2WUA/NxLvjSiCQXw642u52FgmJJw0bXeGwNQvUp+IVLVkn/GhOp45qD00SgUqil08f68efj+x3BI62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424752; c=relaxed/simple;
	bh=FgaeYgDDKeMdi1lyteI5WvxKvFbCXmfjBvPsZneJoFU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Z+k0dLD6QxZm4pHQ7+IkDd4xPK/aEc2Fvj4/P/mnQHRinp/LHUdEV1VRfB9H4bNjudbNHxJT2FuIgAb9t2YVKf7BGLHy4dX/XlE39qsFNkjf5AbdyzSAYcUHYRvqoHW4FUeDidMYxRxTVWxgQqCOupbcpH/00bTmTcaE5vFauk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 41FD6C032C6
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 23:05:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4ZRvpGcHNPvJ for <linux-btrfs@vger.kernel.org>;
	Mon, 29 Apr 2024 23:05:37 +0200 (CEST)
Received: from [192.168.55.110] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 90093C046AB
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 23:05:37 +0200 (CEST)
Message-ID: <df6e9442-2144-462a-b339-1b385a1324ba@dubiel.pl>
Date: Mon, 29 Apr 2024 23:05:34 +0200
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



Final report for "no space" and balancing.
I write it for maybe it will help someone.


My problem was identical to this one:

https://superuser.com/questions/1573030/cannot-repair-btrfs-partition-because-there-is-too-little-space-left



While mounting it went "read only" because of errors:

         errs: wr: 0, rd 0, flush 0, corrupt: 35967, gen 0

         "No space left failed to recover relocation"

         space_info: metadata ... is full



On "read only" you cannot add more devices, you canot finish balance.



Tried to repair system — no errors.



It was done on terminal, co I uploaded photos here:

https://postimg.cc/gallery/09dzGRG



Finally I have cleared disks and start to rebuild system from scratch.





Balancing script reworked to start balancing earlier and slower,
then go faster:



     findmnt --types btrfs --output SOURCE --nofsroot --noheadings | 
sort | uniq |
     while read dev; do

         # mount point
         mnt=$(findmnt --source "$dev" --output TARGET --first-only 
--noheadings)
         test -d "$mnt" || continue

         # lowest unallocated space from all disks in btrfs filesystem
         una=$(
             btrfs dev usage "$mnt" -g |
             sed -nr 's/.*Unallocated: +([0-9]+)\.[0-9]{2}GiB.*/\1/; T; p' |
             sort -n | head -n1
         )
         echo -n "$una" | tr -c "[[:print:]]" "#" | grep -Eq '^[0-9]+$' 
|| continue

         # if lots of unallocated space do nothing
         if test "$una" -ge 32; then
             : # do nothing

         # if going low, then optimize "dusage" slowly
         elif test "$una" -ge 16; then
             seq --format "-dusage=%g,limit=2" 0 20 100

         elif test "$una" -ge 8; then
             seq --format "-dusage=%g,limit=3" 0 10 100

         # if critically low, then balnace both "dusage" and "musage"
         else
             seq --format "-dusage=%g,limit=4" 0 10 100
             seq --format "-musage=%g,limit=1" 0 10 100
         fi |

         # balance for options above until any extents rellocated
         while read opt; do

             btrfs balance start "$opt" "$mnt" 2>&1 |
             grep -Eq "Done, had to relocate [1-9][0-9]* out of [0-9]+ 
chunks" &&

             # if relocated, then get out of two loops for next "$dev"
             break 2
         done
     done







