Return-Path: <linux-btrfs+bounces-11257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B6A267B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 00:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192DF188487D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF52135A5;
	Mon,  3 Feb 2025 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DCv3rdjq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0E213250
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623984; cv=none; b=ZxBsIPqrw+2DcpCSJBMj6qrCvWankkNNco86Xn6wUjP39Is+9bOW1rIfrKj6gTlSZ3bGzSwMIwQFfWmsq13p3G/A975sBWymjmbv//FFidQjeQWXd641D1ATXwWkz44LER7iO9eRMgWDO1S/x+/05AK+01yrc6mo+BP+MlwVbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623984; c=relaxed/simple;
	bh=sJZsAHm6rhszRiUy3+RnYRhZghSi9cQOOhsPrbb1Lgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqMyYMQV6jdOB3NudZHqt+uHDC+3GCC3kmxnFkpiDVBwVgTYvswWh9laKxsfZPNQloZQbq0muJQbfCTh/w1iP/zjR13Upqgp870+4TXGCSIAfMWAAM+QD6qlgT49zCMW2gqgMRBt0zLKZOakuzxddJLzLYPSSNmD8UknXr0m+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DCv3rdjq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738623975; x=1739228775; i=quwenruo.btrfs@gmx.com;
	bh=sJZsAHm6rhszRiUy3+RnYRhZghSi9cQOOhsPrbb1Lgw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DCv3rdjqIrg+q2k7Xgpw/iXps6+KcyX4eDS+Ne1Av/FMZJIADldKeWsZP33byZQU
	 W9BO2Kn4gdIZOcvI+mTdPor0kEHmEOGhZw808nklzla/twavYsko6loMh4UVkXd/R
	 s2GahufCANMLVSh2n0VFmIODrSmQrrNLuUmGsIrSyx9Dwc2AZHdkNO+hVWLA/tPIb
	 SKpSFvC+i30jULiEmzbl4hTAG4WQpmfxfNMWLS4hGyJZiONiJJpjODofvAFduPPLU
	 wNXdy1Rclo82yuCAdKV9XGJUuWHHzFD9htbXLN+TUnaPDKV6TvdbIgbL1Mktcodfl
	 fbpzJ1P4iMugQ5Z9/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b2d-1tmWZn42sX-00D5Q6; Tue, 04
 Feb 2025 00:06:15 +0100
Message-ID: <c5f15c73-d30b-4ce5-a462-623979e1f8e7@gmx.com>
Date: Tue, 4 Feb 2025 09:36:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: always fallback to buffered IO if the inode
 requires checksum
To: kreijack@inwind.it, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: "hch@infradead.org" <hch@infradead.org>
References: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
 <a210b59e-4754-4b58-846a-2529eba0aa9b@libero.it>
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
In-Reply-To: <a210b59e-4754-4b58-846a-2529eba0aa9b@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BWHa7MY3EW2WPRiyDBuipbmTMgICaO+XfruLy2w2/l40kON4IbJ
 f+OjuLHdIWFr83vgsM0Xu+5zsbLqdT/ZXLVB3ShhwqTEyncdifNveYf3KGA9efZmV79gNQJ
 WqVjKfCtQb/EyquoJk2PxZMdsAr3q2Ip1kYUOxi1baduVD41AkNCBhthEob7rZbMWSCaRkC
 1ufD5LibrYLcbnCSaRM8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I/9xoADZTqM=;+ulqG0vrdVxsBuasx2cd5gIOX8s
 QciDaYDq4wyhXiXGGPDAToQ4nKTYb9FuB2d0DVcF2X/vzK+n+GltXqhqg1EObuDNbcCFKFsdE
 MVhmj+fxexA0vtMKHNyBBG5jclvkNaVzW+6SRDEOqRxOiYUFMK8t8DpAa4mwBlNvba+2/KIkm
 wryJKRtjOjGSpgRmPIsQav5l62UZunqrBLmODvuojYLb3PPJu9i54ss6bGlnYiSQqoJwQBTSL
 IivlkM1ZU15hnfWHdgHWmVRwbrcFUsI+C+ohstuyTgAhIhuzxU9LvtZVyUlwyLYe8gHe0kGCq
 m5oUvduhpkqZLN5ujigjsSagH2FZ7fgsQj/xJ+2SGtglz3P7uJhPTRjJ0vHuXVtJv/76oUY7V
 ze4oX4D7jg6vKeem2dMWso9uuukgAa4bYxAhk4R8qF5Vu7xPWYSlJqM7ZChb2cjkoA2FSMj0m
 qXOCUCnw01kZS5ZsMVbx8VCdaY2Oxr/XolHfwTd7uvBxmNVXSIx6INri96rCo9wpDk7elJFia
 uWicUv/a9yHpqixyDuYGalWnIhnubIS6UjdHgHEVJG+vQsHvZkZ/lnnXbfMuThZ0hL7d2rFRo
 mU58fR5E18c08b7ekfbwvkbBZiUDQ4a4S4O5S9LuwRCx2CO28eyBk9MajyqE/lVgcCjTuhfjz
 Ex/ehxLCewHpQn+aCCn+FdOCY1ooHh9927mHeXDEMUIIDX64ythmIDOSRapCuK8tXqB6usXdS
 8sx4v/rgHDvJxpmVGGEb90N4s3iZqDXmjcqnTRLD/0lqztZbxzcHrfqPWZIeP61v+TBSMtLYQ
 6BWA/rJVlJBagr4e1y6ytJkBNk4TCw+tco5etYi6Czqvseee9RH0PIdnk6elsl+z9ghxd7ITs
 QXtCR1Gc75N5SxVOfYVrrWx8/PbJkQtYIJQAsFMZeMITDvvAUutl1opQO8bQNKoHm5LzWzx65
 leWT92Wl9siArS6+7duaOx9XWipyItRl26sa+BtfQCf1/03Gewq5rBzDEBZRHzgjfSyZJ6r/W
 EIhEj7OSbLagWQqRoe6KJF2D41o+R1DST5NFQSLnbYGeLlFHIun1QaVL+ZB6wsmP4U2MEodrD
 2vp92/rxcIW5Uqxj0Y63ihj+DQDD54ebPdreQc2rkVH5CLK/3cdp2iBfwrm2TBB9vhonJMP6v
 GFHd7PYXMEqpP4B3J5jRyMHgs4Bsa9+w+8CmrIZEDozgRoRSiEweeF6dRZvucwygmGdrgO5G1
 PP8KcENuAq4bZXxWX5BIK0y8mkE+IVvO2WtH+3y5LgiwxR+mSfslekkSBmZKvWuooj60VuiPs
 mNOnXzY4pOfyoStopB7RYydaQ==



=E5=9C=A8 2025/2/4 06:49, Goffredo Baroncelli =E5=86=99=E9=81=93:
> On 03/02/2025 10.27, Qu Wenruo wrote:
>> [BUG]
>> It is a long known bug that VM image on btrfs can lead to data csum
>> mismatch, if the qemu is using direct-io for the image (this is commonl=
y
>> known as cache mode none).
>>
>> [CAUSE]
>> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
>> fs is allowed to dirty/modify the folio even the folio is under
>> writeback (as long as the address space doesn't have AS_STABLE_WRITES
>> flag inherited from the block device).
>>
>> This is a valid optimization to improve the concurrency, and since thes=
e
>> filesystems have no extra checksum on data, the content change is not a
>> problem at all.
>>
>> But the final write into the image file is handled by btrfs, which need
>> the content not to be modified during writeback, or the checksum will
>> not match the data (checksum is calculated before submitting the bio).
>>
>> So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
>> but btrfs requires no modification, this leads to the false csum
>> mismatch.
>>
>> This is only a controlled example, there are even cases where
>> multi-thread programs can submit a direct IO write, then another thread
>> modifies the direct IO buffer for whatever reason.
>>
>> For such cases, btrfs has no sane way to detect such cases and leads to
>> false data csum mismatch.
>>
>> [FIX]
>> I have considered the following ideas to solve the problem:
>>
>> - Make direct IO to always skip data checksum
>> =C2=A0=C2=A0 This not only requires a new incompatible flag, as it brea=
ks the
>> =C2=A0=C2=A0 current per-inode NODATASUM flag.
>> =C2=A0=C2=A0 But also requires extra handling for no csum found cases.
>>
>> =C2=A0=C2=A0 And this also reduces our checksum protection.
>>
>> - Let hardware to handle all the checksum
>> =C2=A0=C2=A0 AKA, just nodatasum mount option.
>> =C2=A0=C2=A0 That requires trust for hardware (which is not that trustf=
ul in a lot
>> =C2=A0=C2=A0 of cases), and it's not generic at all.
>>
>> - Always fallback to buffered IO if the inode requires checksum
>> =C2=A0=C2=A0 This is suggested by Christoph, and is the solution utiliz=
ed by this
>> =C2=A0=C2=A0 patch.
>>
>> =C2=A0=C2=A0 The cost is obvious, the extra buffer copying into page ca=
che, thus it
>> =C2=A0=C2=A0 reduce the performance.
>> =C2=A0=C2=A0 But at least it's still user configurable, if the end user=
 still wants
>> =C2=A0=C2=A0 the zero-copy performance, just set NODATASUM flag for the=
 inode
>> =C2=A0=C2=A0 (which is a common practice for VM images on btrfs).
>>
>> =C2=A0=C2=A0 Since we can not trust user space programs to keep the buf=
fer
>> =C2=A0=C2=A0 consistent during direct IO, we have no choice but always =
falling
>> =C2=A0=C2=A0 back to buffered IO.
>> =C2=A0=C2=A0 At least by this, we avoid the more deadly false data chec=
ksum
>> =C2=A0=C2=A0 mismatch error.
>
> I tried a patch few years ago [1]. I think that it is important to point
> out that
> even ZFS started to support DIRECT_IO only recently [2]. Until that, it
> ignored the
> DIRECT_IO flag.
>
> Moreover, I suggest to print a WARNING when a file is opened with
> DIRECT_IO and DATASUM. Even tough it could cause a flood of dmesg.

The warning is a little overkilled, and under a lot of cases, dmesg
warning is not enough to inform the user.

And completely not supporting is also problematic.
Direct_IO condition is already complex (all the alignment checks etc),
I'm not a huge fan to introduce another extra check.

To me, the fallback itself is a pretty good compromise to everyone.

For people who really doesn't want to waste memory on page cache (e.g.
VM has its own page cache), then the fallback still works.
The page cache is just populated, written back, then immediately
invalidated, thus no long term page cache usage.

Not to mention this solves the false data csum error.

For people really believe their own workload handles memory cache
better, sure they can still do that with NODATASUM, and that's already
the common practice for a lot of databases.

Not to mention, even regular direct IO can fallback to buffered one by a
lot of other conditions, so the fallback itself is always a valid solution=
.

Thanks,
Qu

>
>
> [1] https://patchwork.kernel.org/project/linux-btrfs/
> patch/5d52220b-177d-72d4-7825-dbe6cbf8722f@inwind.it/
> [2] https://www.phoronix.com/news/OpenZFS-Direct-IO
>
>> Suggested-by: hch@infradead.org <hch@infradead.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/direct-io.c | 13 +++++++++++++
>> =C2=A0 1 file changed, 13 insertions(+)
>>
>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>> index c99ceabcd792..d64cda76cc92 100644
>> --- a/fs/btrfs/direct-io.c
>> +++ b/fs/btrfs/direct-io.c
>> @@ -444,6 +444,19 @@ static int btrfs_dio_iomap_begin(struct inode
>> *inode, loff_t start,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto err;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * For direct IO, we have no control on the fo=
lio passed in, thus
>> the content
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * can change halfway after we calculated the =
data checksum.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * To be extra safe and avoid false data check=
sum mismatch, if
>> the inode still
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * requires data checksum, we just fall back t=
o buffered IO by
>> returning
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * -ENOTBLK, and iomap will do the fallback.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM=
)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOTBLK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If this errors out it's because =
we couldn't invalidate
>> pagecache for
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this range and we need to fallba=
ck to buffered IO, or we are
>> doing a
>
>


