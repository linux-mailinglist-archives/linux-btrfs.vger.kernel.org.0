Return-Path: <linux-btrfs+bounces-7945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF66E975B29
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 21:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57296282D5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C11BAEE7;
	Wed, 11 Sep 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="rPsPXN/6";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="6tvdzK2t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59C17DFFC
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084562; cv=none; b=pq0vOUQK8kbzi7gGzlfuBxXARPHcoCvw7rsVeFvh26GR+sBwJQqpgj965gAozXI3TpXJPYTZrwQUfbWsQvLJM9pWFd9aNRZR01vafgQmeBO1Fy1CAUA8tBNO/xbIZwR6Nf2dxxczgPUBaM7Bc29cHHMOEwCXZcDxBgawjyS98pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084562; c=relaxed/simple;
	bh=EBnbrts9yvFpJfal6Dk97wgbAFDhUlkk8rX/XHr+3CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Et5710BUs3hpX3i+DPMhzxyuzd30/mU7/aaiG5EdYP8bPf89ML5UlQb80reUe7MMTRbXJcsKqZthZI5nO25IVdNDjBL5EA0caw29eCHfOSJTT5HwgZBDfcDSysCYHPVU3iAcElVJDfIpORqg9T0HsllJrJ/exo41bvLuEKALC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=rPsPXN/6; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=6tvdzK2t; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726084550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRCfpV7GTevHdkuEkUZEblcf1zpHa9ruWMmLK2bUx6g=;
	b=rPsPXN/6J4WxomRnXl+3wG1NBIJ7vsLgc0uX32UUDDsgy2DlRmZbKxz+l9KneujGO5tHIM
	4iQza35d3BtVfIPbfedQr8QDY6DcE2AKuH7s6oCi+NUALvpx3JVBFvqUwUoqJbsZlwsQmg
	BDjmhaYtHm+aa9geoegFAlJLFl0EKoFTZxDkh6Sp3EOMhzeVHfxZZDyDHG5JhZhqlvUueg
	jRg0nfGdmVGgKKPY83VcTH+q98qRLUOD2pqqwiUcGVRMCUTjcaEcQKAzYaP0vVDE4hkH0W
	QE6ulj9WXRAoxXzBPiMHsYtEoAWeBWS4hiUU6frjQSvTvDIJ8oUyv9HGWsJihTSY03/c2L
	1Do5WFckVMyhjBlDpwWhGqiHSY6tJbA+bwBgm8lhPrT40uKk7WjkcGlmfYuDnXQz+B7LMD
	f1+/8+ikzAkb0bwL6dbixykvbk23+6U3jyPmLr8Z8Q/1cvZzZDL5SIl84r1rSjzEAsgGkl
	PWIiTLhIvOY+6ky/vOEQDqTPTgkVl1uFhOLYGZJ2Rl6RLDX8peB/jehBxiwhyqTCV7Ao4N
	a3984i7GxpsktfIynv2FPKwIV1BZ982A1fmjP9Cdq2I0Om6w8/Rko0zosPvKBeN202CDgD
	1Yqrzn8KkOc7BcDKkBTFoBrGtweKGZGzUgS3pFJI7If9bi71aj8z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726084550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRCfpV7GTevHdkuEkUZEblcf1zpHa9ruWMmLK2bUx6g=;
	b=6tvdzK2t6IraoaNNpJfdEgaBDIzykYJW3A0PxQTUO7snsdPLjqy0dCbF9FgWN54H95ZLTo
	S2m3yLljjgk3+sAQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Wed, 11 Sep 2024 23:55:40 +0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Critical error from Tree-checker
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/09/2024 à 01:37, Qu Wenruo a écrit :
> 在 2024/9/11 06:58, Qu Wenruo 写道:
>> 在 2024/9/11 06:35, Archange 写道:
>>> Hi there,
>>>
>>> Since today, my system started randomly becoming read-only. At that
>>> point I can still run dmesg in an open terminal, so I’ve seen it was
>>> related to a btrfs error, but did not try anything since I could not
>>> open a web browser anymore. But I’ve seen the error to be “BTRFS
>>> critical” and related to a “corrupt leaf”.
>>>
>>> I’ve tried to run `btrfs scrub` on the device after rebooting, and in
>>> fact it aborted almost right away triggering the same error in dmesg
>>> (but not turning the system read-only, so I can copy paste it here):
>>>
>>> [  365.268769] BTRFS info (device dm-0): scrub: started on devid 1
>>> [  385.788000] page: refcount:3 mapcount:0 mapping:00000000d0054cae
>>> index:0x9678888 pfn:0x11ce15
>>> [  385.788015] memcg:ffff9fc94db8f000
>>> [  385.788021] aops:btree_aops [btrfs] ino:1
>>> [  385.788235] flags:
>>> 0x2ffffa000004020(lru|private|node=0|zone=2|lastcpupid=0x1ffff)
>>> [  385.788248] raw: 02ffffa000004020 ffffea9a8574ff88 ffffea9a847385c8
>>> ffff9fc95b8365b0
>>> [  385.788255] raw: 0000000009678888 ffff9fc9ae554000 00000003ffffffff
>>> ffff9fc94db8f000
>>> [  385.788259] page dumped because: eb page dump
>>> [  385.788264] BTRFS critical (device dm-0): corrupt leaf:
>>> block=646267305984 slot=92 extent bytenr=1182031872 len=106496 invalid
>>> data ref objectid value 257
>>
>> Full dmesg please.
>>
>> Normally it should dump the full content of the tree block, to help
>> debugging the problem.
>
> Nevermind, the code doesn't dump the full leaf for debug anyway.
>
> In that case please dump that corrupted leaf by:
>
>  # btrfs ins dump-tree -b 1182031872 /dev/dm-0

Sorry for the delay, in the meantime my computer went unbootable: the 
initramfs went missing, then some systemd files… Last time such things 
happened was when my btrfs went out of free space, but there is plenty 
currently, so I guess this is related to this other kind of btrfs issue 
I’m facing. Now everything seems in order and I’m back to my emails.

Here is the output of the asked command:

# btrfs ins dump-tree -b 1182031872 /dev/dm-0
btrfs-progs v6.10.1
checksum verify failed on 1182031872 wanted 0x00000000 found 0x21b9544e
ERROR: failed to read tree block 1182031872

Some additional informations:

1. I was able to save the log the next time it went read-only, it is a 
bit different:

[ 4588.750188] page: refcount:4 mapcount:0 mapping:00000000d0054cae 
index:0x967c1f0 pfn:0x35077d
[ 4588.750203] memcg:ffff9fc9400ae000
[ 4588.750208] aops:btree_aops [btrfs] ino:1
[ 4588.750407] flags: 
0x2ffff8000004000(private|node=0|zone=2|lastcpupid=0x1ffff)
[ 4588.750419] raw: 02ffff8000004000 0000000000000000 dead000000000122 
ffff9fc95b8365b0
[ 4588.750425] raw: 000000000967c1f0 ffff9fcafdcc2690 00000004ffffffff 
ffff9fc9400ae000
[ 4588.750428] page dumped because: eb page dump
[ 4588.750433] BTRFS critical (device dm-0): corrupt leaf: 
block=646327500800 slot=105 extent bytenr=11287011328 len=114688 invalid 
data ref objectid value 258
[ 4588.750451] BTRFS error (device dm-0): read time tree block 
corruption detected on logical 646327500800 mirror 1
[ 4588.750524] BTRFS error (device dm-0): failed to run delayed ref for 
logical 11285897216 num_bytes 36864 type 178 action 1 ref_mod 1: -5
[ 4588.750542] BTRFS error (device dm-0 state A): Transaction aborted 
(error -5)
[ 4588.750549] BTRFS: error (device dm-0 state A) in 
btrfs_run_delayed_refs:2207: errno=-5 IO failure
[ 4588.750559] BTRFS info (device dm-0 state EA): forced readonly

2. I’ve thus decided to run

# btrfs ins dump-tree -b 11287011328 /dev/dm-0
btrfs-progs v6.10.1
checksum verify failed on 11287011328 wanted 0x00000000 found 0x2c7de3ac
ERROR: failed to read tree block 11287011328

and

# btrfs ins dump-tree -b 11285897216 /dev/dm-0
btrfs-progs v6.10.1
checksum verify failed on 11285897216 wanted 0x28b52ffd found 0xa166b670
ERROR: failed to read tree block 11285897216

3. There is some information on kernel loading

[   12.793025] Btrfs loaded, zoned=yes, fsverity=yes
[   12.886212] BTRFS: device label root devid 1 transid 6065022 
/dev/mapper/root (254:0) scanned by mount (252)
[   12.887845] BTRFS info (device dm-0): first mount of filesystem 
e6614f01-6f56-4776-8b0a-c260089c35e7
[   12.887874] BTRFS info (device dm-0): using crc32c (crc32c-intel) 
checksum algorithm
[   12.887885] BTRFS info (device dm-0): disk space caching is enabled
[   12.907001] BTRFS warning (device dm-0): devid 1 physical 0 len 
4194304 inside the reserved space
[   12.910034] BTRFS info (device dm-0): bdev /dev/mapper/root errs: wr 
0, rd 0, flush 0, corrupt 4, gen 0

(Especially the “corrupt 4” I guess, but the warning above might also be 
relevant?)

4. I’ve run a full scrub while the disk was mounted on another system, 
which returned no error.

5. I’ve also run a check from that system while the fs was not mounted:

# btrfs check /dev/mapper/rootext
Opening filesystem to check...
Checking filesystem on /dev/mapper/rootext
UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 480039342080 bytes used, no error found
total csum bytes: 466668868
total tree bytes: 1618149376
total fs tree bytes: 898007040
total extent tree bytes: 138395648
btree space waste bytes: 331985228
file data blocks allocated: 517562126336
  referenced 492533391360

Waiting for further debugging instructions.

Thanks,
Archange


