Return-Path: <linux-btrfs+bounces-11256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E186A26734
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 23:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD31F188310A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 22:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39280211283;
	Mon,  3 Feb 2025 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="J7WMdtai"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4561D5CD4
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623512; cv=none; b=b+2OOxqAnCQxaTrZrU4gG+WZt5P0eloeXMS8IW/BP+qNIxuoHVazHr450Vx06WmLD550vutCEM46DmZmAq2+dKKK63Ty3ZDtKWrJw8p/fzXbtpUnpHUT3uccbm858CEgWzXhWlrD59X+mdPmxJR3MLFnpgoChGgxZhUIn+JPZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623512; c=relaxed/simple;
	bh=kDi1Qi2nEvG4vRNGutMutsBT6/LeS9zHHlxFq3/+yL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXHoSc4eAjcaFtdtbef0a6hwn1+7WAA6FeybvDat1U/2yq6d6Q2uUaTszLGn8g0LCol6RXeeHBoHOeNSeC6RoWZYEME+l5+q6ylsn0iyba/Lj/munAcExyHECS7RWzpGf4XTQSk7BRNpkvI5PE67i5OYcdk0Mikb4z0oPJMSKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=J7WMdtai; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738623504; x=1739228304; i=quwenruo.btrfs@gmx.com;
	bh=L9m/bkJXw9maarR/h9YGCebtaCl0Esn4kQX9+ms09to=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J7WMdtaiVccPkZu5DhVEXClyhXWf++lOEIyM72E+9vCOOGcLYNJEBuoY+bwGfrCK
	 P1l0nyyC6VTQ1HSUKoFM/8edFPoQX54nNnuSoIrZvPh2vosSdMDBvTcxYdbChc6G1
	 k+tFbtaWA9SpQSaGjIBin2+1geFIw/yVY0bkY0BJMuGLt3tC2UVSmMREZjy1wlZEm
	 agR/9FlnyFo2vAffMa7AD0TXp99Y1VqYnT8FYea44ZztS1xmq9Q8t0OOdOF5BeWc1
	 tVXit/6puvuPDy8R0+zvpTHFxzteXL/QtAy1B7yPqc8mnv3VmNcsRxkFU6DEYhVnx
	 +Yxz8DtyhHDc9lynKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4s0j-1tgSqF1Aal-00EiBw; Mon, 03
 Feb 2025 23:58:24 +0100
Message-ID: <e07c2208-640b-4e0f-b977-a77e95a8531a@gmx.com>
Date: Tue, 4 Feb 2025 09:28:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: always fallback to buffered IO if the inode
 requires checksum
To: Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
References: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
 <20250203182238.E5E7.409509F4@e16-tech.com>
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
In-Reply-To: <20250203182238.E5E7.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K0TNCitNowDnpcuViH0DxJswnRsW3L/xZ5UbAyhT4bt5QUMHUXs
 LgxIdH3lYhNAd8nTLRyIXdgfUPDcV2NzzoTkopRuqddqZ32QTif8korFegjORU9ItUMoBtq
 /EcnVsQxLK6LClnV+8F+ZNSEZbgqRmTH8rqeGgPyK9k3e1ky6ORXZu6ToSHbZ2MHaMfeu+G
 T8pQoI55acwQphCn1fTrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dzFnycarxY8=;YAwbBcjakMeRr0IJoQTdNCgF12t
 vMicFJyjAMezAPjf5riEVMLYn/9VafJVYvtgGIgIdD5PAdsRdGZtOTRBbmm4usopdN9Wm8gs7
 uJAuOKFaAW/4igA2uSNN2NKqZtLwdqYqz0Tf9gwU7J1wWxKBce8HzIyo85cCH5O+swDE/oilC
 1DovUtIaf24BHVLOuFzt5UUfFsQRyBskuAcV73ylAPK35HMkdwWP7FTEsyTFzOl2wkASJS2na
 1XZdCrRqz+50hNrvjXlj4NKzse/n3rYO3eQxBV8wFib7XXp6p8rQ+jdpZkRGuq/ZlaVKhXrGI
 KpS9ZYrRi+bcIP7Edl5/G/y/U5E3VwcMefSkvOkQKiqiHDKbfawYmZC4iVMMpj9RK90hdKwsJ
 /B67oJaaMD8wAFGb3qSVmLKSxYhjXBQvOStSY3BheoJqiGhHos0fVv5Zm9K5aOq/5ShQA32GD
 XGgTbUfJgY2iHANck2yEUaw3i4677AjFxGwX1HlfGFFdX2X6Bc0T3Lb2nsMDz3fqwRWdLlzjO
 hQi1+w5hUt67UbqVpdwIH2aGlatgb/LwOkR55vx0KqxbgFpxdKpT5Se1WdzTqHwP0GIR6UKpv
 Mu4X7tvIoG6XwKLZytCc4F5bVPc8gJz3+GPFTn4+vaG6pkqIFB/luxm0A/nlnn0SveDThDkhi
 KKjoEjqb1b/HuL/1wUg0Xx/aWvKd9Cf6p5eUcEqlTCw7B2dnLP5SiZiDchuepBcNJgqw/tDcu
 GaxaztXYn+ZBgI+n2TFWhNIW6jYrOKcc3hZu9eD1S0/vJYLL9TOKPL+pux3ryXlGpWqfuCu36
 teF6cBZDK8Q5xFstxxV8ZRT05sjcu96AAmuVjzi3+gRyFQrsdRfgmge1S7ALGF1MM+wlbGAN2
 xJ40ezeFhRet4uDm92tTi135A35YbdjYqG69TR+cQCjXe9c1UT9XSt/QU+VRc8qb1/91/3pt8
 kJoyCKPSm3EQKaFdd0rJIk1+yEvuWS7mMEVi3NFlfja96kZwn0UGGCnBF8LpXZ0alaQd1qifw
 dWJP4RBjUmD1rlJrPQKNfb2P6HZS+q4sJ6/QoK6tAAcavKcUG0VczBOnNYrObZJMXCRY3wZyp
 5JiIY3Me+WzfazKUbA3lqdheuAEqcgUU7b1Mlgxy8pwDY3tJu/3TErs99o8SzmSGZ7qKUqvOw
 Ur5cMyLGb5XJj0Z/0DLsz2+LqsykFsvGBmPNm58We2lljXH8I44aCTHcHvN9F87JQdzX9KJRy
 4eo+Cr0yEAsqxWsrGI9YD4OK2ltodou1r0iZM5rsIXR0qwL4WkXnkrY4EmGXks+nggjFi+jBv
 IFTqCDlqLpV2rGGMinxTqLo0w==



=E5=9C=A8 2025/2/3 20:52, Wang Yugui =E5=86=99=E9=81=93:
> Hi,
>
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
>>    This not only requires a new incompatible flag, as it breaks the
>>    current per-inode NODATASUM flag.
>>    But also requires extra handling for no csum found cases.
>>
>>    And this also reduces our checksum protection.
>>
>> - Let hardware to handle all the checksum
>>    AKA, just nodatasum mount option.
>>    That requires trust for hardware (which is not that trustful in a lo=
t
>>    of cases), and it's not generic at all.
>>
>> - Always fallback to buffered IO if the inode requires checksum
>>    This is suggested by Christoph, and is the solution utilized by this
>>    patch.
>>
>>    The cost is obvious, the extra buffer copying into page cache, thus =
it
>>    reduce the performance.
>>    But at least it's still user configurable, if the end user still wan=
ts
>>    the zero-copy performance, just set NODATASUM flag for the inode
>>    (which is a common practice for VM images on btrfs).
>>
>>    Since we can not trust user space programs to keep the buffer
>>    consistent during direct IO, we have no choice but always falling
>>    back to buffered IO.
>>    At least by this, we avoid the more deadly false data checksum
>>    mismatch error.
>
> Could we mark the page for direct write to READ-only
> when ! BTRFS_INODE_NODATASUM?

We have no control on the source page.
It can be user page or even some weird mmapped ones.

Thanks,
QU
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/02/03
>
>
>
>> Suggested-by: hch@infradead.org <hch@infradead.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/direct-io.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>> index c99ceabcd792..d64cda76cc92 100644
>> --- a/fs/btrfs/direct-io.c
>> +++ b/fs/btrfs/direct-io.c
>> @@ -444,6 +444,19 @@ static int btrfs_dio_iomap_begin(struct inode *ino=
de, loff_t start,
>>   			goto err;
>>   	}
>>
>> +	/*
>> +	 * For direct IO, we have no control on the folio passed in, thus the=
 content
>> +	 * can change halfway after we calculated the data checksum.
>> +	 *
>> +	 * To be extra safe and avoid false data checksum mismatch, if the in=
ode still
>> +	 * requires data checksum, we just fall back to buffered IO by return=
ing
>> +	 * -ENOTBLK, and iomap will do the fallback.
>> +	 */
>> +	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>> +		ret =3D -ENOTBLK;
>> +		goto err;
>> +	}
>> +
>>   	/*
>>   	 * If this errors out it's because we couldn't invalidate pagecache =
for
>>   	 * this range and we need to fallback to buffered IO, or we are doin=
g a
>> --
>> 2.48.1
>>
>
>
>


