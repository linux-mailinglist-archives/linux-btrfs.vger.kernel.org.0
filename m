Return-Path: <linux-btrfs+bounces-19846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5BCCC9500
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 19:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B039430813D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782862D7DF5;
	Wed, 17 Dec 2025 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mikkel.cc header.i=@mikkel.cc header.b="LT+FIGRb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F397263C7F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996992; cv=none; b=kUfrwEH6BXiCc7dhN0iXqlQx//SldDnT8WRLUl6awpZwhvE7aVbeLOjRmYOMThCvLblZshxSosEj/i+QJoG+sRlOT/pBjlLJBc7kUACF+asi+0RqanCwuOUrDumwZ6GxC8nHSzjGmU9tLsBNbaqO+b4Y6ClbD1JQn4lzE3NIip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996992; c=relaxed/simple;
	bh=NzNssUly8EEbo1qyZwBDHTvd7Mc1I4mRFVCJXLlDaX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3TxzEOYqgLEaD0jO2ZvxdJ1Jq31pk+EW6aC3XfrI5QiRV6ym9mMOdIwrqGM1sZE2UP9OffWmY0VgHlvcrCIKoUot9bCuhA5UQQlDC+Cz/eL3PrY5iCXih3dSibUzKruo+xA2Tp8ZkaGmfP2kQrvmhbpIy8WHSk5zpSa9Q3/2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mikkel.cc; spf=pass smtp.mailfrom=mikkel.cc; dkim=pass (2048-bit key) header.d=mikkel.cc header.i=@mikkel.cc header.b=LT+FIGRb; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mikkel.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikkel.cc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikkel.cc; s=key1;
	t=1765996988; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvIQNliw0BfrPa6VkpGbc3rru9XwSKwk1HajNWA1nWM=;
	b=LT+FIGRbB2o9gIJsYvlyoNDtRjh/kefEssCrrCmXXOYfthc9m/w6Dc1Daaa7I8u88F+bXG
	uMVP+yVtkyPkkOASbhfV9lb7EvoLvI4NCsMd7eQpSRbKZVkI8CIWPyuzNbTqMEQfIP94R5
	zJrQJ8dtLPlWx48k82yx7UNv+x/pjNfBbRWcun1BK5E95LT+nbrrApT1n9DzuCwhmosvUw
	9yeud/CE/b+1jhTaZj0HyC2LCAmDL/KSQ29kljPzkAIqs0s77ROE2Rb2vffT6Nw2pMZg6E
	FML6lHIpWc8NFSkYjjrvXU5nHu2cBNTm9VXEB8NlLcv8iuR3MLMRcW10gIQvgg==
From: Mikkel Jeppesen <mikkel@mikkel.cc>
To: mikkel+btrfs@mikkel.cc, Qu Wenruo <wqu@suse.com>, lists@colorremedies.com,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Reply-To: mikkel+btrfs@mikkel.cc
Cc: linux-btrfs@vger.kernel.org
Subject: Re: kernel 6.17 and 6.18,
 WARNING: CPU: 5 PID: 7181 at fs/btrfs/inode.c:4297 __btrfs_unlink_inode,
 forced readonly
Date: Wed, 17 Dec 2025 19:42:54 +0100
Message-ID: <2234039.9o76ZdvQCi@localhost-live>
In-Reply-To: <5d5e344e-96be-4436-9a58-d60ba14fdb4f@gmx.com>
References:
 <3187ffcc-bbaa-45a3-9839-bb266f188b47@app.fastmail.com>
 <bc11ac085b08b3e55e79d1d5ffb85d7a62672b6b@mikkel.cc>
 <5d5e344e-96be-4436-9a58-d60ba14fdb4f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On Tuesday, December 16, 2025 6:42:28=E2=80=AFAM Central European Standard =
Time Qu=20
Wenruo wrote:
> =E5=9C=A8 2025/12/16 11:44, mikkel@mikkel.cc =E5=86=99=E9=81=93:
> > On Tuesday, December 16, 2025 12:05:54 AM Central European Standard Time
> > Qu
>=20
> > Wenruo wrote:
> [...]
> It's indeed a bitflip, and in a pretty bad location, making the initial
> repair doing a bad job.
>=20
>=20
> Firstly there is a DIR_ITEM that is the offending one in subvolume 256:
>=20
> 	item 148 key (1924 DIR_ITEM 2435677723) itemoff 5853 itemsize 70
> 		location key (730455 INODE_ITEM 0) type FILE
> 		transid 7280 data_len 0 name_len 40
> 		name: AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E
>=20
> However there is no DIR_INDEX one for it.
> I believe this is caused by the initial repair.
>=20
> Then for the offending inode, it exists!
>=20
> 	item 10 key (730455 INODE_ITEM 0) itemoff 15456 itemsize 160
> 		generation 7280 transid 9794 size 13829 nbytes 16384
> 		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev=20
0
> 		sequence 11 flags 0x0(none)
> 		atime 1765397443.29231914 (2025-12-11 06:40:43)
> 		ctime 1764798591.882909548 (2025-12-04 08:19:51)
> 		mtime 1764798591.882909548 (2025-12-04 08:19:51)
> 		otime 1764712848.413821734 (2025-12-03 08:30:48)
> 	item 11 key (730455 UNKNOWN.8 1924) itemoff 15406 itemsize 50
>=20
> Note the item 11, which has an unknown type 8. But normally this should
> be INODE_REF, and the size matches the namelen + 10.
>=20
> bin(8)  =3D 0b1000
> bin(12) =3D 0b1100
>=20
> Diff is exact one bit, so it's again a bitflip.
>=20
> This means there are several problems in the original mode at
> least:(lowmem mode should be able to do better, but the metadata is too
> large thus lowmem mode is too slow to be practical)
>=20
> - Unknown key type detection
>    Every time we hit an unknown key type, we should give some warning to
>    help debugging at least.
>=20
> - Inode nlink checks is not properly checking INODE_REF
>=20
> Since this has a back INODE_REF item, I have to manually fix it, you can
> fetch the following branch:
>=20
>    https://github.com/adam900710/btrfs-progs/tree/dirty_fix
>=20
> Then compile it, you will get "btrfs-corrupt-block" at the project top
> directory.
>=20
> Then:
>    ./btrfs-corrupt-block -X <device>
>=20
> Which will fix the inode ref.
>=20
> Now btrfs check should report a different error:
>=20
>   ...
>   [5/8] checking fs roots
>   	unresolved ref dir 1924 index 134016 namelen 40 name
> AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 2, no dir index
>   ERROR: errors found in fs roots
>   ...
>=20
> This is the indicator that the repair is done correctly (errors 2).
>=20
> Then "btrfs check --repair" should be able to repair it:
>=20
>   enabling repair mode
>   Opening filesystem to check...
>   Checking filesystem on /home/adam/test.img
>   UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
>   [1/8] checking log skipped (none written)
>   [2/8] checking root items
>   Fixed 0 roots.
>   [3/8] checking extents
>   super bytes used 166880690176 mismatches actual used 166880575488
>   No device size related problem found
>   [4/8] checking free space tree
>   [5/8] checking fs roots
>   repairing missing dir index item for inode 730455
>   reset isize for dir 1924 root 256
>   [6/8] checking only csums items (without verifying data)
>   [7/8] checking root refs
>   [8/8] checking quota groups skipped (not enabled on this FS)
>   found 333761265664 bytes used, no error found
>   total csum bytes: 322896656
>   total tree bytes: 2385526784
>   total fs tree bytes: 1857060864
>   total extent tree bytes: 164102144
>   btree space waste bytes: 411870645
>   file data blocks allocated: 1029749325824
>    referenced 404780113920
>=20
> Thanks,
> Qu

This did indeed do the trick! :)

sudo ./btrfs-corrupt-block -X /dev/sda3
Repaired the bad inode ref key

sudo btrfs check /dev/sda3
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
[5/8] checking fs roots
        unresolved ref dir 1924 index 134016 namelen 40 name=20
AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 2, no dir index
ERROR: errors found in fs roots
found 167377907712 bytes used, error(s) found
total csum bytes: 161874964
total tree bytes: 1243725824
total fs tree bytes: 976257024
total extent tree bytes: 84213760
btree space waste bytes: 214400581
file data blocks allocated: 511281180672
 referenced 203289292800

sudo btrfs check --repair /dev/sda3=20
enabling repair mode
WARNING:

        Do not use --repair unless you are advised to do so by a developer
        or an experienced user, and then only after having accepted that no
        fsck can successfully repair all types of filesystem corruption. E.=
g.
        some software or hardware bugs can fatally damage a volume.
        The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
[1/8] checking log skipped (none written)
[2/8] checking root items
=46ixed 0 roots.
[3/8] checking extents
No device size related problem found
[4/8] checking free space tree
[5/8] checking fs roots
repairing missing dir index item for inode 730455
reset isize for dir 1924 root 256
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 167377907712 bytes used, no error found
total csum bytes: 161874964
total tree bytes: 1243725824
total fs tree bytes: 976257024
total extent tree bytes: 84213760
btree space waste bytes: 214400581
file data blocks allocated: 511281180672
 referenced 203289292800

sudo btrfs check /dev/sda3=20
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 167377907712 bytes used, no error found
total csum bytes: 161874964
total tree bytes: 1243725824
total fs tree bytes: 976257024
total extent tree bytes: 84213760
btree space waste bytes: 214400236
file data blocks allocated: 511281180672
 referenced 203289292800








