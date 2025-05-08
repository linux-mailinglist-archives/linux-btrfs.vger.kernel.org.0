Return-Path: <linux-btrfs+bounces-13824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 010DDAAF441
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 09:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB1D1BA3F69
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8A21CC40;
	Thu,  8 May 2025 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KZZc86NF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85121CC43;
	Thu,  8 May 2025 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746687915; cv=none; b=c/AY6m8DSCZ9g2TlVMd6PHLqf2a+2PZC/7wS88GrzNrDlU/1C46K+DLTqRtcqks8I1E4gek2cH2ZbfW6euceY5MvuKo38MlHi2e/LFWyg89X+2npdDreZxc8Sssh21kKhcHp1ailLMO5P0lQEm9WuqnTeMR31Tzm19Dcr9lU5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746687915; c=relaxed/simple;
	bh=1ZQOVDO8Jy7WOEFTdEZouHEHyehAgKUqlRlhksEYl44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tq6bGdcAA9bYSWtJdu6OXTMpqAZ4BdgfhY+aCHjMfAZkMsWYvzpiA0t0F+KpvuUUn5bONiCsKDQGLRJnjHZiVReOJipl9S1YPBk5it3E2wM7qhf5tk0Fv5HHfo020+p10UYyvUs9DkgHLvLT44z/KRfDf5hWVp9YTpWzEhZRCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KZZc86NF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1746687910; x=1747292710; i=quwenruo.btrfs@gmx.com;
	bh=OQScNflzmKe4YWTurwL/g/0cKLezqGxLWvJzacyUAu0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KZZc86NFzeDvGzCMlhXGTYZriACehdE+tSxZFhCgfgkmLAK3Tp4ZtbNgMgYidixe
	 L6lbnV+azLpMAMJRdqjAh8FRhFWNYsrsb8h5OQL7A4KTQZkZT0lwHiwEY92lmf7V1
	 Yu0PLmpAcZb6p8n/+XxfRk2G+XgcVugUWgl4jYwPM3dzG6CSVri+Y+dho/NcX65N1
	 s+nDEWn22v7Ln8v0x3Yj2uvOeIatzsMKrLRgXEs9A6uBN4QA1fSWMHgPkFFc9N7WB
	 bTS03+423oKYmL/WiUvc3AJetdhUf16ds9Xm2B762xIH9+kfRNBK9+5rBa9rxmNu+
	 28vms2irbGkU8Bb8PQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0XD2-1uyGe11WtA-017MGZ; Thu, 08
 May 2025 09:05:09 +0200
Message-ID: <d161b5ed-b405-4fce-9efd-91117ba06a1c@gmx.com>
Date: Thu, 8 May 2025 16:35:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: always fallback to buffered write if the inode
 requires checksum
To: Greg KH <gregkh@linuxfoundation.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Filipe Manana <fdmanana@suse.com>,
 David Sterba <dsterba@suse.com>
References: <54c7002136a047b7140c36478200a89e39d6bd04.1746666535.git.wqu@suse.com>
 <dcffa5400745663641e58a261e8dbccbb194b468.1746666392.git.wqu@suse.com>
 <2025050830-epilepsy-emu-5a5d@gregkh>
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
In-Reply-To: <2025050830-epilepsy-emu-5a5d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gqhDcJYqy5RDMVZ6s3MjcUyIqBI8nC/luS+LDfgCtqi4KxtF41e
 j5+Qo0pFj754OCB/JwEgDHBEfaLj4uktXm010EoLjx811wn4kJAdfvoO8L2Zt+/OPKuu7pf
 DhK5vSBy0ZHsgBzlRxh/c4XPhPUiVn9gbI/TS2RQH614JYa0uWb4wuB6yA0433y4pt4mCVT
 n7W3+bTq9zhfEwfEj20+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0BJKzQGREAs=;AvpsADMQTIPTZAOtwsuPTtmeO+x
 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
 TKwFfnMtDnVgc=



=E5=9C=A8 2025/5/8 15:00, Greg KH =E5=86=99=E9=81=93:
> On Thu, May 08, 2025 at 10:39:17AM +0930, Qu Wenruo wrote:
>> commit 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5 upstream.
>>
>> [BUG]
>> It is a long known bug that VM image on btrfs can lead to data csum
>> mismatch, if the qemu is using direct-io for the image (this is commonl=
y
>> known as cache mode 'none').
>>
>> [CAUSE]
>> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
>> fs is allowed to dirty/modify the folio even if the folio is under
>> writeback (as long as the address space doesn't have AS_STABLE_WRITES
>> flag inherited from the block device).
>>
>> This is a valid optimization to improve the concurrency, and since thes=
e
>> filesystems have no extra checksum on data, the content change is not a
>> problem at all.
>>
>> But the final write into the image file is handled by btrfs, which need=
s
>> the content not to be modified during writeback, or the checksum will
>> not match the data (checksum is calculated before submitting the bio).
>>
>> So EXT4/XFS/NTRFS assume they can modify the folio under writeback, but
>> btrfs requires no modification, this leads to the false csum mismatch.
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
>> - Let hardware handle all the checksum
>>    AKA, just nodatasum mount option.
>>    That requires trust for hardware (which is not that trustful in a lo=
t
>>    of cases), and it's not generic at all.
>>
>> - Always fallback to buffered write if the inode requires checksum
>>    This was suggested by Christoph, and is the solution utilized by thi=
s
>>    patch.
>>
>>    The cost is obvious, the extra buffer copying into page cache, thus =
it
>>    reduces the performance.
>>    But at least it's still user configurable, if the end user still wan=
ts
>>    the zero-copy performance, just set NODATASUM flag for the inode
>>    (which is a common practice for VM images on btrfs).
>>
>>    Since we cannot trust user space programs to keep the buffer
>>    consistent during direct IO, we have no choice but always falling ba=
ck
>>    to buffered IO.  At least by this, we avoid the more deadly false da=
ta
>>    checksum mismatch error.
>>
>> CC: stable@vger.kernel.org # 6.6
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> [ Fix a conflict due to the movement of the function. ]
>> ---
>>   fs/btrfs/direct-io.c | 1094 +++++++++++++++++++++++++++++++++++++++++=
+
>=20
> Did you mean to include all of this file in here?
>=20
> I see 2 versions of this patch sent, the first one looks "correct", but
> this one is very odd.

My bad, this one is incorrectly including the missing file which doesn't=
=20
yet exists in 6.6.y branch.

I'll send out an updated version.

Thanks,
Qu>
> thanks,
>=20
> greg k-h
>=20


