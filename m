Return-Path: <linux-btrfs+bounces-11456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65317A34F69
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 21:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6483ADCCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 20:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA382661B1;
	Thu, 13 Feb 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ho8UY7lg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FE2010EB
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478744; cv=none; b=tQ6IjasYR/wrgjkMcSKpfEsTMh5LBeJxUjIoBVdbEfKzbZoxwuAjERI5EpxH6r6qgPU4M+J5CCOc2I8JdQ/ol/iF7tuLSbgh9bAP6y4AGkEyHVENCa5+CiwEBWEG0Wo7Ejy0TGSsvepb/LEkzibq9/e5qxtO9emZJpwwtAvGo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478744; c=relaxed/simple;
	bh=yTzgT8FDwGFqc8D4TXqM5lzywWmqVgMUIMEGcNxVcHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgo8lBzEblNvGc+nk9OCMcQvdKC1DbfpKFG+S5YAKz18OnoX9htLFR0CSmsRIW9zOaxulEmshCb1pbg26PUrGpVvU7xIw8a9lEI3BqI79GpUeoHUoA94uSTYbeBjmb9u4X9FaYMq2BAzGMfKo2rY+IKPfulmIrIbLsXBipA6K28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ho8UY7lg; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739478733; x=1740083533; i=quwenruo.btrfs@gmx.com;
	bh=tiVvErjoXJAq/4MSJw/Qx+AlGIUs8TU1LnqqCVE87T4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ho8UY7lgUFUJXfVCw8oZSLWmZgTqZzR4dc7rnYQ0V8s0VdW7aRITTSD7ZMH6TDd5
	 OHPqCY5bjKycxpwcTj8f/Oo3arnfvc59+09QbrCQcBgBQrS1vgaFNdP78/9GdCtZE
	 FGBVkDP9EzxO3W8tZHPR5Md6nMi6terOlkCXOUjfzWAwOob/4HYIsBGVzpGvStQNt
	 4dozLz+m+vQtHZ8AsGlL1s+UsE0FPQq5KSyVcrOWFTqihUBSECAI7UtaP3mHFzRLi
	 JDzky5gD5vm22tLqcAUtIXf+L6airZcC76zI3ssvmNpwxDeIXzVh0T6+IB7AXM2v3
	 Ynoy3jYcB0Cz0QFHxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McpNo-1t93sd0dOM-00fxDT; Thu, 13
 Feb 2025 21:32:13 +0100
Message-ID: <4f75f3d1-3ca4-405c-bf8b-0f07e8a890fa@gmx.com>
Date: Fri, 14 Feb 2025 07:02:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: always fallback to buffered write if the inode
 requires checksum
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
References: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
 <20250213202302.GD5777@twin.jikos.cz>
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
In-Reply-To: <20250213202302.GD5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N+IcGnXSmZ8DxQ2UrpY2vAC1N7LbdDzXoaTuIaJcZVewwrnQaM3
 eKYdp8fe+uof8kL5uK5zM/xtHFOa1bHiMDjzjtidjddAzbc8FZvnr5bcOAt/pLoC7bIlqvb
 OhnqApk232AY/v8GoXD/EWDPvV6zqOhwMRY0zrB2Z6x9j7IUsCSPVZbCbtYoa6xYyDXPzSd
 q60KszSQoDFYXsrvIE7sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:132eHTk7Qv4=;b1WDh5XVYplmseu4eKrelc9XNsa
 OlxYPHc288kkMXAOZqMuDJimQaTTnc3uA//QwwUj2TKrMu/7doaAIDs/kHtmdikFu2km+IKtk
 lcbwG5H9QQn14jRFGlzlLz3ZchokeKwVKUxqY0jCltlbyuW+pFqoh73DKleO9NHZK3viTowmZ
 /MBzPKHtodz0EMoLb73LSVOiAdJ5FCGokDYSZPnz9Tccb20ZWTrxnFmw8xfy/AGRB9QwsRY+r
 Y+kc1COUW3GCtwc6aceC0YAZM1WDW+ux6JX++RtFDtXRwySFMMEiAeB52RBAzLHTYMtsdoRF7
 KOsa2r8MIjEEUgtAiQamBE7EwKRLs4120QVKzu3YkS7D25EvRKxtgoZjHTOp438xKUAfTQ1Bf
 nW/2gi+1fGeqtgE7KYZzhojiCPKIH7C6q0TaqSGONmE8jMpgOP27dnHaa8K/atNgrpuRz9pH0
 fHdhX/BdTbpyzobryK1N+0Z4NIsPumxUtBIUHYG490yiVwAffDyCMyANNzQAUl/uaPMJxYknX
 UaLATNcuKkmbbbzHwHbM3PqVx5PdZxF+BhP0zWXFzzNh5aqIcxGEjzEFm4RMHrJTHzaQMciEL
 1jVwnG7PjLTJR8HZlwYgwUr2CuZ6dMvNh/jWN9Wm0Hr9DKYhQyRuBoz9gLmtZDJV7BkLGCqgM
 1m1ABi+y1xQqEx09aJN1s3IDRjvESN87eD8K/60x2eSRovYwlnF5FcM8NlHDQL3vI+mTiLVx+
 XS5AtPaCxS+d+8XY3S+7kJnwlBKpjavIPQ+K83S7EWFsfGZx8rMExztpHPg+R34Mr6k6v7GgI
 pm8qNO3zmtxK1/QOxAbr0DQfxVPadp6HzeDFuvrgTBA9O6SJ7Da/lZDd9j+1BVsUpKww7MiWb
 N7i6nqe6kfhIRNpgjh/Qu2RtV7pwAmkxSrjMilJc2rbDOgH47/KM62j9UhNnwEO1Ie3BQDzkW
 gaf8oY3OIqgwYcYUdb9CHZV3vHRHNlOJAiXzJG+U6CyyCG4VcKDqtKhuYfPejoJih5q8aqtN8
 77Yu9hzc4jsh7Rtciz1gzwI0t2d8cR9BPVmg5B0wVBL4ihEyOL3js2DiBMMnNZSvojJkUgaoJ
 LvfqxNLWUL+Gq+qQP3rdUj2GP3JUyyzUPKjF0h+F3p1rmoOBN2o3maA9lPB4/534UGm/py3Tt
 7xIiYB4XhxS/W5cvBngbucSD1jbCybWSWUzCcSrlnUKzthVbdQMGqn6tbK29INRkzrbHtmX2y
 PCfZ8f5sRskuRdhFq4Lixeju/lmln72d/yDHTePq5nzPabP5vRekXpjzb7zrr5CnvrSV4jJIZ
 WKtkGzowzdWj1NNPd2lm2SGFC44RW2Xu55t9wBOSDgORW5h/21bgLE/5irvZit4YyUYeM8Vg8
 xvTI9nYicmJwmv48S1CwXqWA2w0UwTxq6V9zPFX3tftCIlaS9UzGvmuHt3



=E5=9C=A8 2025/2/14 06:53, David Sterba =E5=86=99=E9=81=93:
> On Tue, Feb 04, 2025 at 02:00:23PM +1030, Qu Wenruo wrote:
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
>> - Always fallback to buffered write if the inode requires checksum
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
>>
>> Suggested-by: hch@infradead.org <hch@infradead.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I had this patch in the -rc queue but I think this is a significant
> change in the semantics of DIO so the target is 6.14. A backport to
> older stable tree is possible but we may need a bit longer period before
> this happens. DIO is used for speed in the VMs so falling back to the
> buffered write will likely be noticed.
>

I can prepare a doc update in btrfs-progs, and I totally understand your
concern about the fallback.

However I'd argue that, for VM useage, the root reason for using direct
IO is not really for performance, but to avoid double page cache as the
VM also manage its own page cache, there is no need to double page caching=
.

Furthermore there are more common cases where btrfs falls back to
buffered IO. The most common one is when the DIO is only 512 aligned but
not btrfs block aligned (normally 4K).
Considering not every DIO users do the proper fs block size detection, I
believe for a lot of cases, DIO of VMs are already falling back to buffere=
d.

Thus I'm still optimistic about the behavior change, especially
considering the extra overhead is just a memcpy, it should not be that
obvious to end users anyway.

Thanks,
Qu

