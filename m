Return-Path: <linux-btrfs+bounces-18266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF3C05283
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5ED4071F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62B30AAD4;
	Fri, 24 Oct 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="r8aJ9Cot"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132530B515;
	Fri, 24 Oct 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295049; cv=none; b=kQ5eMcpK+2FC15drL3F4t83Kvho5Hna50Imki5dlvXIavmliGfAyuGAh+I5kdIyXh3jxiYKiu7M/1CQ/D+l3ubiFH/LqHvei+4wvz29b8MfINiQm7FoLjESoPUiEmXl2nnwX0V3pxfZsOsGoJgJnGMpzs/++eUR/AW7U50ovfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295049; c=relaxed/simple;
	bh=2ytzQm5QqodPWxO8NOrG8Q5DymFtfF2NVAdQP3zEAmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIrnjQS6jQFC7sOhPPs3c3x8RC9ANcBZfFlZBVMJGBlkjSVuErnsL0UBMLg0YeBWSxqXBT00c+L32436tVePL8Urs7gM6due7mSpHGlHkpcNxZrl/NubYAgWcNusLUifp3wREjY0RqV07hd5QvxxnDAJQviA8sXSu3K9zZWtKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=r8aJ9Cot; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761295044; x=1761899844; i=quwenruo.btrfs@gmx.com;
	bh=h3OkTvhiowkaYe4zOP7zQh7n5tOc/6yJjaZA+tpPzKE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r8aJ9CotHB0SPlC4aLbSy41GiLMcV11ZJrMeQf/xJIOs91cwofPkCA0bvAY1/0ke
	 7SSgz0cMZwb6W6OcGuef7OQ/piF+JZ3UetadqOsrU7KQ7MyrdVTdsgoUtUrKrasJq
	 782JrqjcKNgC9VcmI3rN/7VcbuvFSK80jyspX+n6LmuMKBVHtYNkzWFtOQfrIIRbQ
	 4n0DitOBoWc97WnnepT/8qKGlB9j6azbi37mq+WqIV8TvpLnCy/T8vYzNHjU3XEdy
	 t/p9zL3FVJeE40lEu/D3RNCrQGW23o5vflHy75CEZ8Js/C/cWeX/lJjzj58XqM3pv
	 CniKtWhaNZaOnPPXUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU0q-1ueFzb3CxY-00pRgI; Fri, 24
 Oct 2025 10:37:24 +0200
Message-ID: <63aac204-5ea5-45b1-854e-6b3d78db99fd@gmx.com>
Date: Fri, 24 Oct 2025 19:07:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make sure no dirty metadata write is submitted
 after btrfs_stop_all_workers()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
 <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com>
 <6f36e8d0-630b-4cc3-a780-11be4aa0a65f@suse.com>
 <CAL3q7H4TcJNY7cYeYWoByOW0ek6BBEbtgSSFFOvc7aagarfFXQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4TcJNY7cYeYWoByOW0ek6BBEbtgSSFFOvc7aagarfFXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b84orSoodlsePuOQDlKDFKLce/hNDqMGTH97ES8gmrjL8KQVr9v
 TGfvXcZeclJx+dVVcP2m6B5j0iQ9/wBypjeOwPpo7P7YXkIB4V2Rbim0+MbJuAsK8U7unDC
 k15WO4ZWmrNkcvzyft4sf8gKRyeZkU37CcSQvuMRgaHofqpD5PRHacpZmlqVHrTDeEEQbRe
 1Juekx4Jx21hPlavxOdTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V0YcS3MA3mA=;/HwqRpkPHucUp241uIRjTRBHXvA
 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
 7f0UZPAZsCFLQA1Jt77GXMqs+Y=



=E5=9C=A8 2025/10/24 18:37, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Oct 23, 2025 at 9:44=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/10/24 01:56, Filipe Manana =E5=86=99=E9=81=93:
>>> On Thu, Oct 23, 2025 at 10:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrot=
e:
>> [...]
>>> So two suggestions:
>>>
>>> 1) Move this into btrfs_error_commit_super(), to have all code related
>>> to fs in error state in one single place.
>>>
>>> 2) Instead of of calling filemap_write_and_wait(), make this simpler
>>> by doing the iput() of the btree inode right before calling
>>> btrfs_stop_all_workers() and removing the call to
>>> invalidate_inode_pages2() which is irrelevant since the final iput()
>>> removes everything from the page cache except dirty pages (but the
>>> iput() already triggered writeback of them).
>>>
>>> In fact for this scenario the call to invalidate_inode_pages2() must
>>> be returning -EBUSY due to the dirty pages, but we have always ignored
>>> its return value.
>>>
>>>   From a quick glance, it seems to me that suggestion 2 should work.
>>
>> Yes, that's the original workaround I went with, the problem is we're
>> still submitting metadata writes after a trans abort.
>>
>> I don't feel that comfort writing back metadata in that situation.
>> Maybe the trans abort is triggered because a corrupted extent/free spac=
e
>> tree which allows us to allocate new tree blocks where we shouldn't
>> (aka, metadata COW is already broken).
>=20
> Metadata COW is broken why??

Consider this situation, no free space cache, and extent tree by somehow=
=20
lacks the backref item for tree block A.

Then a new transaction is started, allocator choose the bytenr of tree=20
block A for a new tree block B.

At this stage, tree block B will overwrite tree block A, but no=20
writeback yet. And at this time transaction is not yet aborted.

Then by somehoe the tree block A got its reference dropped by one (e.g.=20
subvolume deletion), but extent tree is corrupted and failed to find the=
=20
backref item, and transaction is aborted.

>=20
> Even after a transaction aborts, it's ok, but pointless, to allocate
> extents and trigger writeback for them.

Writeback can be triggered by a lot of other reasons, e.g. memory=20
pressure, and in that case if we try to writeback tree block B, it will=20
overwrite tree block A even if it's after transaction abort.

Not to mention the final iput() in close_ctree().

Thanks,
Qu
> As long as we don't allow the transaction to be committed and new
> transactions to be started, we are safe - in fact that's the only
> thing a transaction abort guarantees.
>=20
> We may have many places that could check if a transaction was aborted
> and avoid extent allocation and writeback, but that's ok, as long as
> we don't allow transaction commits.
>=20
>>
>> Thus I consider delaying btrfs_stop_all_workers() until iput() is only =
a
>> workaround, it still allows us to submit unnecessary writes.
>>
>> I'd prefer the solution 1) in this case, still with the extra handling
>> in write_one_eb().
>>
>> Thanks for the review and suggestion, will follow the advice of the
>> remaining part.
>>
>> Thanks,
>> Qu
>>
>=20


