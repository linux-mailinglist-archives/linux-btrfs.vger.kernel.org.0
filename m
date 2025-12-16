Return-Path: <linux-btrfs+bounces-19767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0657CC1066
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 06:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A37F300384B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 05:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E22F1FFE;
	Tue, 16 Dec 2025 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="g/y+YDcC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0C2D9798
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765863791; cv=none; b=MuA7cCjuua3BEA2XaXk884yDUcqDx8G53BhIgiwtRr564DInKXcnuKT80o47BVM4Pe8ER8wAYexdkd0kg6TNQbfXM2NbM8+k5IUqigMe8WW70UukSvzF4TvdRc2lUOb23ySE4I7wsrn+nUM8w+en6FVJkrbO5FVu2Dna/QW8xX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765863791; c=relaxed/simple;
	bh=6TAs3GPZmgHiDjST689SsKbcgGuEMmMNRWpgYgEbDag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6cWthg4H7XdceNdOE+WLVnNBYs2k3B8VKfPjk01wuZggVKQqFKU+P1e082c8/suEwCEj7uQ+Avi5g+6j+20D3fFUYR7lmg4q2F/27v3K9KUyX7XuG3dKVbkdlGwiHolDAa4dnJua/dg0LPL/tsXKVcjYBVJPYis+iAJmrX0KXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=g/y+YDcC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765863755; x=1766468555; i=quwenruo.btrfs@gmx.com;
	bh=B7SYFkQwbKuzvRhLQnHZDJE/h82/21vYeS+vZRqaBVc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=g/y+YDcC62iiJArCKl8Ndblgh46bPws1k7l7IU5tEExqDQwIWg2faOl1iBC7t+xW
	 Cp+sgMILm1YhWeLud8xqAf2YX+nFkX8ACm2scnUTjx5/10Fa8wzE7LDaakOsuwQtK
	 YfIEaIXLF1m7Q8t7GuPSZk1kHG+F/qzRscdNNb6vdN2vd++m+LaiUTx/2kEqco+QO
	 IYUkAc81KDxNyna2tq4z8LHmPQK4U17pp3T86vIg2WK+0tIiK8eWwUIDC01Il5igq
	 p7E6BHpN4Of/BD1a8ocUpkB1MRwqTop2iem+/cj1X9o8pFOxFuwNCcU1KzEHmhhZa
	 wU2UoKwCut9pmGHr7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlKy-1w8pJr0g7s-00oSx5; Tue, 16
 Dec 2025 06:42:35 +0100
Message-ID: <5d5e344e-96be-4436-9a58-d60ba14fdb4f@gmx.com>
Date: Tue, 16 Dec 2025 16:12:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at
 fs/btrfs/inode.c:4297 __btrfs_unlink_inode, forced readonly
To: mikkel+btrfs@mikkel.cc, Qu Wenruo <wqu@suse.com>, lists@colorremedies.com
Cc: linux-btrfs@vger.kernel.org
References: <3187ffcc-bbaa-45a3-9839-bb266f188b47@app.fastmail.com>
 <acefecca-9fbb-4268-a26a-b889756019e7@mikkel.cc>
 <4960584d-eb14-40ee-a039-c1ca27f20a05@suse.com>
 <bc11ac085b08b3e55e79d1d5ffb85d7a62672b6b@mikkel.cc>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <bc11ac085b08b3e55e79d1d5ffb85d7a62672b6b@mikkel.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vOFLWQneVwZKCeObHA18cKrviQULDei0CfqYz25aSuI+kTA/+lO
 Vb+sx/70cw1W7pgkWq7op5AF+Y2zDj2u9SZlnJoOyw/2Dkjz/gG9o0SigsLowg2wpRgrkMy
 8LDu9leCS6h7Txi0Bw1Nbr2zyqo9V2JbVuqanj/lIcEUlC1YcOY42SFWBEu37QZR1WfApK/
 c+9G2KSEVjN+sWfmJNBhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LOXJabV/ci0=;kkP03ReoQhkJZf6fUfsssqZJ9ff
 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



=E5=9C=A8 2025/12/16 11:44, mikkel@mikkel.cc =E5=86=99=E9=81=93:
> On Tuesday, December 16, 2025 12:05:54 AM Central European Standard Time=
 Qu
> Wenruo wrote:
>=20
[...]
>>   Unfortunately this corruption involves filename, thus the "-s"/"-ss"
>>   option is screwing up the result.
>  =20
> There shouldn't be any issues there. I hadn't used the system for much o=
ther
> than one steam game before this happened.
> Here's the image:
> https://paste.mikkel.cc/FH3jEN9z

It's indeed a bitflip, and in a pretty bad location, making the initial=20
repair doing a bad job.


Firstly there is a DIR_ITEM that is the offending one in subvolume 256:

	item 148 key (1924 DIR_ITEM 2435677723) itemoff 5853 itemsize 70
		location key (730455 INODE_ITEM 0) type FILE
		transid 7280 data_len 0 name_len 40
		name: AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E

However there is no DIR_INDEX one for it.
I believe this is caused by the initial repair.

Then for the offending inode, it exists!

	item 10 key (730455 INODE_ITEM 0) itemoff 15456 itemsize 160
		generation 7280 transid 9794 size 13829 nbytes 16384
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 11 flags 0x0(none)
		atime 1765397443.29231914 (2025-12-11 06:40:43)
		ctime 1764798591.882909548 (2025-12-04 08:19:51)
		mtime 1764798591.882909548 (2025-12-04 08:19:51)
		otime 1764712848.413821734 (2025-12-03 08:30:48)
	item 11 key (730455 UNKNOWN.8 1924) itemoff 15406 itemsize 50

Note the item 11, which has an unknown type 8. But normally this should=20
be INODE_REF, and the size matches the namelen + 10.

bin(8)  =3D 0b1000
bin(12) =3D 0b1100

Diff is exact one bit, so it's again a bitflip.

This means there are several problems in the original mode at=20
least:(lowmem mode should be able to do better, but the metadata is too=20
large thus lowmem mode is too slow to be practical)

- Unknown key type detection
   Every time we hit an unknown key type, we should give some warning to
   help debugging at least.

- Inode nlink checks is not properly checking INODE_REF

Since this has a back INODE_REF item, I have to manually fix it, you can=
=20
fetch the following branch:

   https://github.com/adam900710/btrfs-progs/tree/dirty_fix

Then compile it, you will get "btrfs-corrupt-block" at the project top=20
directory.

Then:
   ./btrfs-corrupt-block -X <device>

Which will fix the inode ref.

Now btrfs check should report a different error:

  ...
  [5/8] checking fs roots
  	unresolved ref dir 1924 index 134016 namelen 40 name=20
AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 2, no dir index
  ERROR: errors found in fs roots
  ...

This is the indicator that the repair is done correctly (errors 2).

Then "btrfs check --repair" should be able to repair it:

  enabling repair mode
  Opening filesystem to check...
  Checking filesystem on /home/adam/test.img
  UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
  [1/8] checking log skipped (none written)
  [2/8] checking root items
  Fixed 0 roots.
  [3/8] checking extents
  super bytes used 166880690176 mismatches actual used 166880575488
  No device size related problem found
  [4/8] checking free space tree
  [5/8] checking fs roots
  repairing missing dir index item for inode 730455
  reset isize for dir 1924 root 256
  [6/8] checking only csums items (without verifying data)
  [7/8] checking root refs
  [8/8] checking quota groups skipped (not enabled on this FS)
  found 333761265664 bytes used, no error found
  total csum bytes: 322896656
  total tree bytes: 2385526784
  total fs tree bytes: 1857060864
  total extent tree bytes: 164102144
  btree space waste bytes: 411870645
  file data blocks allocated: 1029749325824
   referenced 404780113920

Thanks,
Qu

