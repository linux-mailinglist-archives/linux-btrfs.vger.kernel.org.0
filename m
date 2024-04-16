Return-Path: <linux-btrfs+bounces-4313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930808A71D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7EF1C2275D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF18131E21;
	Tue, 16 Apr 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b="Rvqx8CXr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.tnonline.net (mx.tnonline.net [65.109.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317042055
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286848; cv=none; b=SUbF0FfBPyykB0N5yI7dj2ZCj/nvJZr5hZO1bLl0MtYkD8uLOEnPYqVMhKQLXsfI/J1M6rAVfjsxWrGqwYIpQIez/fkQhVDitPoI3Kh/73SZYpJb4DxdoSs5rn4caB7/3iOar+ExeWGqDXjTzb5iBbav8cM0LPQxvHsDyY8IfP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286848; c=relaxed/simple;
	bh=x6r5o+Y1uVuGcoWsA5eKhPku/gOCM3vSqbcKMRBS2Zs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=D15oy+piu6EAJREDyYt5ofWL1NZh+B+lCN0iQcxPOHM319bneXjlxDo0VgYW+n56fde1ln8vriwWZ52v6pPXhik+UinDZ4FKZJM4gj4akultS1tNTL1lulBOJBF2/NAdtM3pN+KrPHq0Y0PdlHlfOfP8LgIae2KRl+c5f8uinuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net; spf=pass smtp.mailfrom=tnonline.net; dkim=pass (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b=Rvqx8CXr; arc=none smtp.client-ip=65.109.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnonline.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:References:In-Reply-To:Message-ID:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NaJ505wUKlADMx2acrhRWTEiCP9hfkPkdlBmEy3cY48=; t=1713286846; x=1714496446; 
	b=Rvqx8CXrOg+S+cRgXR7KegHbz5cwS/raipjpylcuBDU+2E0+YQkRQ32K+J+sAbwg5FQuG1tHnVJ
	O3RVf16sb5C2Ay2SFGUtDJy8B5cQa2hAcyf3Ofgmxgy0ztL98N2Ca7yT1fke8YWfX1tbJuKtWaT+A
	DbLu0EbNtw0ogIfDvALCyn9zg7S63g/VtVgrQ1iUjdUSprIQS+RF7mIdNpjRrwBz+D0XLUj3ctckC
	WD3aZJjzXrGWSJ2UcvYMaqsXBaHGsYTeoCKc3XnPaSvKpg7GzIC1xCRtSwDVz6UL2bzlHtHOq1V63
	DK/B6p8StR3dZoBCqvZW9MZRhVjJmlmjpOnQ==;
Received: from tnonline.net ([2001:470:28:704::1]:51054)
	by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <postmaster@tnonline.net>)
	id 1rwmAV-000000005V1-1xpf;
	Tue, 16 Apr 2024 17:00:28 +0000
Received: from [192.168.0.132] (port=53870)
	by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <forza@tnonline.net>)
	id 1rwmAR-00000000ETJ-2lFJ;
	Tue, 16 Apr 2024 19:00:23 +0200
Date: Tue, 16 Apr 2024 19:00:23 +0200 (GMT+02:00)
From: Forza <forza@tnonline.net>
To: Leszek Dubiel <leszek@dubiel.pl>, HAN Yuwei <hrx@bupt.moe>,
	linux-btrfs@vger.kernel.org
Message-ID: <3aefeb1.20bf1a80.18ee7da3d40@tnonline.net>
In-Reply-To: <b2806d95-a50c-41a2-b321-cf62c4f28966@dubiel.pl>
References: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl> <79D2FA23B59927D1+bde927bc-1ccf-4a5d-95fb-9389906d33f6@bupt.moe> <b2806d95-a50c-41a2-b321-cf62c4f28966@dubiel.pl>
Subject: =?UTF-8?Q?Re:_enospc_errors_during_balanc?=
 =?UTF-8?Q?e_=E2=80=94_how_to_prevent_out_of_space?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
X-Spam-Score: -1.6 (-)



---- From: Leszek Dubiel <leszek@dubiel.pl> -- Sent: 2024-04-16 - 17:17 ---=
-

>=20
>=20
>>>
>>>
>>> I noticed 1Mb for Unallocated space, so
>>> I have run multiple times balance (data usage filter):
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs balance start -d=
usage=3DXX,limit=3D1 /
>>>
>>>
>>> and it didn't help.
>> You can try add a small device (USB stick) and rebalance.
>>> It even got error no space when balancing:
>=20
>=20
> When it refused to balance i tried musage, dusage, few times and it helpe=
d.
> Thanks for tip.
>=20

It is not wise to balance metadata block groups because it can directly lea=
d to the situation you ended up with. Btrfs needs unallocated disk space to=
 be able to allocate new data or metadata chunks If it cannot allocate new =
data chunks you will see an out of disk space error. However if btrfs canno=
t allocate new metadata chunks, the filesystem will turn read-only, making =
it much harder to fix - as you cannot balance or add additional space in an=
 read-only filesystem.=20


>=20
>=20
>=20
>> If you have zabbix or other monitoring mechanism, you can try=20
>> monitoring "Unallocated" and reserve at least 2 block group (2GiB). Or=
=20
>> you can have a weekly timer to rebalance your btrfs volume.
>> kdave/btrfsmaintenance should helps you.
>=20
> I started to run this script from cron every 10 minutes:
>=20
>=20
> #!/usr/bin/bash
>=20
> mount | sed -nr 's%^/dev/sd[a-z][0-9] on (/[/_[:alnum:]]+) type btrfs=20
> .*$%\1%; T; p' |
> while read mnt; do
>  =C2=A0=C2=A0 =C2=A0if
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 btrfs dev usage "$mnt" -g |
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 perl -ne '/Unallocated: +([0-9]+\.=
[0-9]{2})GiB/ and $1 < 64 and=20
> print $1' |
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 grep -q .
>  =C2=A0=C2=A0 =C2=A0then
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 echo "porz=C4=85dkowa=C4=87 $mnt"
>=20
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 for usa in $(seq 0 10 100); do
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # I don't know =
whether to start with "dusage" or "musage",=20
> so i shuffle it;
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # 15 april 2024=
 my serwer was locked, "dusage" returned=20
> "enospace", and it
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # got unlocked =
after "musage=3D0"
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 echo d $usa
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 echo m $usa
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 } | shuf
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 done |
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 while read typ usa; do
>=20
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 echo; echo; dat=
e; echo "balance type=3D$typ, usage=3D$usa"
>=20
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 out=3D"$(btrfs =
balance start -${typ}usage=3D$usa,limit=3D3 "$mnt"=20
> 2>&1)"
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 echo "$out"
>=20
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # if nothing wa=
s done, then try higher usage
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 echo "$out" | g=
rep -q "had to relocate 0 out of" && continue
>=20
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # otherwise fin=
ish: on error or on successful relocate
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 done
>  =C2=A0=C2=A0 =C2=A0fi
> done
>=20
>=20
>=20

Do you mean you run this continuously on your filesystem? This is normally =
not required and will increase wear on your disks.=20
>=20
>=20
>=20
>=20
>> "Unallocated" and reserve at least If you have zabbix or other=20
>> monitoring mechanism, you can try monitoring 2 block group (2GiB). Or=20
>> you can have a weekly timer to rebalance your btrfs volume.
>> kdave/btrfsmaintenance should helps you.=20
>=20
> Thanks for hints :) :)
>=20
> This solves my questions:
>=20
> 1. i have to rebalance when Unallocated is low
>=20
> 2. i have to keep 2Gb at least.

You should keep at least 1GB x profile mode. That is for DUP, 2GB, and for =
RAID1, at least 1GB on two devices.

It would be better to have more, to be safe.

An option that could be used is 'bg_reclaim_threshold', which is a sysfs kn=
ob to let the kernel automatically reclaim (balance) block groups that fall=
 under a specific threshold.

https://btrfs.readthedocs.io/en/latest/ch-sysfs.html

>=20
>=20
>=20
>=20
>=20



