Return-Path: <linux-btrfs+bounces-9961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58459DBD45
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 22:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50887164A60
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 21:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A7C1C3F0D;
	Thu, 28 Nov 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iJsV4i2w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2813DDB5
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828556; cv=none; b=ppyKRJyn2cnAOfoco5IOoogg8lgQycLoX8oXnX6wM5HiRESGTNm5As/DngpK8QAKhtS4CNePEhakt+dy6VeZ3eF9OsaLyeUvahFsDwzy+MqBI1S7EBgCqfE25MTAw6eDbB1MXCC3ZbtUwfIwUfQhbzfvCN6yW0djHiQo2CN6GsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828556; c=relaxed/simple;
	bh=5X2Vs6/v75eRvNbwHvmDVDS1+4RKEs+lRbNR/+uxhn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yp+K96gJyVZCR7xzKZAjfCRTU1At0Cc2ieoUl9RSDO8fWGR5qqk0Vkr/rYCmwaMBvQx9nIR7bZ6RgfCO4Owy6OTe8mGO5KZ5rbFLrddT6hANnllNKgwmqGf5UsdRWIkJ00hKlpsHBmecTrs+1de9j9WXPUtmee9Cxu+NGVEnKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iJsV4i2w; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732828544; x=1733433344; i=quwenruo.btrfs@gmx.com;
	bh=agpJ0snBvaEQ+1sRLRF2XhKaNQ6xtvGp5BXRwUKU7Ys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iJsV4i2wFHD6CCYsGAax/L3196Pv422ss7xDF4B3EFPGEZNB2oRbHTeIGlSPvsC4
	 1HZXV4fMqqhy1UBeAHaGXVa4dc+JmjnPWQmMLp+yE/B9RCJLnhMGAmd9eh0IHhAvP
	 MaoUvdKxQnMU5UNt087ZJVb4lEAmvkR438z+l6HnsbpkP+5/tDZkkGIYQEqdUk1B4
	 G6EDwtxDgD1OkgxIeNvabTvgcUeqLN9ct/ko6cdMZtzYj3seq8J7rAnITh5zxnV2u
	 00JH2HZ5Q5YQmeQ00aKkTEQxf9AleW6E2ZzsZ6spmLZFi1kAXMMedwsgV8ef81tKS
	 CL+GcNwru+kER1pEEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1tEEzg2Xzz-00VPGF; Thu, 28
 Nov 2024 22:15:44 +0100
Message-ID: <e65899da-d180-4d83-a605-a7385d1b913f@gmx.com>
Date: Fri, 29 Nov 2024 07:45:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject out-of-band dirty folios during writeback
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <2bbe9b35968132d387379dd486da9b21d45e1889.1731399977.git.wqu@suse.com>
 <20241125161128.GC31418@twin.jikos.cz> <20241125162552.GD31418@twin.jikos.cz>
 <74048e24-dd8e-4162-ac08-2b6e799393bd@gmx.com>
 <20241128133841.GU31418@twin.jikos.cz>
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
In-Reply-To: <20241128133841.GU31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u6EP5ucqKZdBFFklLQu/0naY3OvbAJplzQsaWCJexWsEymGcOtO
 Movj8Br2C8tPy5P0FGlPk8t4ml80+TR2ehvnSnmL3MBT+fz5lY+sMQ0JEq1bP9a7YIUDLh0
 NKbqMq3N5xQbfoky7XOczdefYq5pJ89VzYQSsaVRVwJR+JHXwTIh89Z6/biLZ6jmzHTR/qA
 SkLteYcaYdGjUi0HG/MNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pUWuIRG7y1E=;b2ofEGyBr+Fcten4hJHjIvYPVjz
 zjeFpJazu6+v5pNWhNa2UexZofWLTbq5rJ4eJViHKeFLt3DB2Kdv9cUBbDV/KYVV2hZwCPrGG
 XOZReYV2cDztp+91Q6b1GGJk2iyfOc04jUMilX+fpbHgGscHpdhqVOGdsYOTF+S4oLxPIWYRW
 3SRt/DHBk7Zjfi4KPLI5w9ZJcFqRbgxRdFYVXsFa8o4UuAJvJRzBIIVCojn+i6R2aZaF+GXCX
 dt6Lddnef09pJIRScC1IKQgXKYg/WNJI7q/devy29o2dV6e0rkOdtHdr3Vn7of1JlhdvNudtN
 gTIUJbSkYxpJLtHr2JFH4dCMTXc6y2aHCvwcvOFJGmBgA5JQGONpJFbH+u2erKGzmIqTfoS6H
 /Kz7MhAUiNqh2k1ziminV4D+lTnZNgcvRDbIaHbjr9gKKKHvNdpFyoURp3NwaD2oEya8jse71
 HI5qFNsgLt3sARHoMl6vAp0s7R3Gy1AhU43PXTl4ZO0Zg7Stw1wmpvtksuIiPlRgc/UZDoZR+
 WX5BWS71p5PPlMiIz7BftIUR7txN45nb3yPl59az9/3E9tMelFqi89dFDZ/b6ZSRF2EvBVJ3n
 xJVV61UJxgJqm2VXESTK8GKVzuc4ZPeAjV7Vm+hNvXp+R4ueq0MdP/gmnDPE649xgH+k/znDu
 froi8kla8ARnoGeuVaH4i8W3QCMHChkENZCke+iVCNVxKC4zez7ZUxyo/sVlxB/HsvV3De8u+
 QSgfprDtgIrpt0rvTCENVadAbe54tjnpk8B2eJDq1y3DbGsJ1QUJiGfM9xC57j9xZOW+M9+3q
 lAB97/pBW6GDU/TwNan76QPmgWxyLaC+p6knyb5tfcQh96XwD7xC2Gx5CiPFZMDZbLTHqQUBd
 BjJVKWDpBLbz1RD6znEFRHXMf3INLrYPd0e+uSkWoWjqjoe3SbELCxrdM02y/CuozTpwOAEJq
 vRko+3pB4Ns8US5G4h15Ctze/BNxARX65nbXskXtB0YF/wtarrZf7mX1p/tcvDYZHLyhriXWK
 +Mz3IZlocIP/Ny41O/vs9fh6KRLA9UFc+J4BAG1TWF3z5AQmrajWbcqhkCF8VtJ8MceHT3TBm
 WS9qcj2fA2OulEqubsL1V7qh9MyvBW



=E5=9C=A8 2024/11/29 00:08, David Sterba =E5=86=99=E9=81=93:
> On Tue, Nov 26, 2024 at 01:03:23PM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/11/26 02:55, David Sterba =E5=86=99=E9=81=93:
>>> On Mon, Nov 25, 2024 at 05:11:28PM +0100, David Sterba wrote:
>>>> On Tue, Nov 12, 2024 at 06:56:51PM +1030, Qu Wenruo wrote:
>>>>> An out-of-band folio means the folio is marked dirty but without
>>>>> notifying the filesystem.
>>>>>
>>>>> This used to be a problem related to get_user_page(), but with the
>>>>> introduction of pin_user_pages_locked(), we should no longer hit suc=
h
>>>>> case anymore.
>>>>>
>>>>> In btrfs, we have a long history of handling such out-of-band dirty
>>>>> folios by:
>>>>>
>>>>> - Mark extent io tree EXTENT_DELALLOC during btrfs_dirty_folio()
>>>>>     So that any buffered write into the page cache will have
>>>>>     EXTENT_DEALLOC flag set for the corresponding range in btrfs' ex=
tent
>>>>>     io tree.
>>>>>
>>>>> - Marking the folio ordered during delalloc
>>>>>     This is based on EXTENT_DELALLOC flag in the extent io tree.
>>>>>
>>>>> - During folio submission for writeback check the ordered flag
>>>>>     If the folio has no ordered folio, it means it doesn't go throug=
h
>>>>>     the initial btrfs_dirty_folio(), thus it's definitely an out-of-=
band
>>>>>     one.
>>>>>
>>>>>     If we got one, we go through COW fixup, which will re-dirty the =
folio
>>>>>     with proper handling in another workqueue.
>>>>>
>>>>> Such workaround is a blockage for us to migrate to iomap (it require=
s
>>>>> extra flags to trace if a folio is dirtied by the fs or not) and I'd
>>>>> argue it's not data checksum safe, since the folio can be modified
>>>>> halfway.
>>>>>
>>>>> But with the introduction of pin_user_pages_locked() during v5.8 mer=
ge
>>>>
>>>> I don't see pin_user_pages_locked() in git, only
>>>> pin_user_pages_unlocked() but that does not seem to be the right one.
>>>> 5.8 is quite old so there could have been changes and renames but sti=
ll
>>>> the reason why we can drop the cow fixup eventually should be correct=
.
>>>
>>> Well, it got removed in 5.18 again, ad6c441266dcd5 ("mm/gup: remove
>>> unused pin_user_pages_locked()").
>>>
>>
>> My bad, the more correct term is just pin_user_pages().
>>
>> It's also mentioned inside the core-api/pin_user_pages.rst, and it look=
s
>> like the CASE 5 is exactly what caused the original out-of-band dirty
>> pages. (get_uiser_pages(), write, put_pages()).
>
> IIRC the problem was with unmap(), something unmapping last page in the
> whole range that touched page table entries rather than wrting to the
> pages.  Which would point to case 3.
>
> Unless there are more fixups like the pin_user_pages() reference, please
> add it to for-next. Thanks.
>

Well, this patch itself exposed a new bug, which results btrfs to go cow
fixup path.

The situation looks like this: (non-subpage case, just regular 4K sector
size and page size)

     0            32K          64K
     |/////////////////////////|

For the dirty range [0, 64K), we enter extent_writepage() for page 0.

And we find the delalloc range [0, 64K), call cow_file_range() for [0, 64K=
).

But due to fragmentation, we are only able to reserve OE for the range
[0, 16K):

     0            32K          64K
     |<- OE ->|//////////////////|

Then we continue to try to allocate space for range [16K, 64K).
But failed with ENOSPC.

In this case, the range [0, 16K) already has its EXTENT_DELALLOC flag
removed from the io tree.
And the OE range [0, 16k) is also marked finished.

In fact, the OE is marked finished twice, leading to the race I'm fixing
by this series:
https://lore.kernel.org/linux-btrfs/cover.1732695237.git.wqu@suse.com/

However the whole page range [0, 64K) is still marked dirty.
Later we will try to write it back again.

When such retry happens, since the range [0, 16K) has no EXTENT_DELALLOC
flag in io tree any more, no delalloc range will be ran, thus the dirty
range [0, 16K) will have no ordered extent for it.

This results we fall back to cow fixup path.


I have to fix that first, before merging this one, or we will crash all
our test environments.

Thanks,
Qu


