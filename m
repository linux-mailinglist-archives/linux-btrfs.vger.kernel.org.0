Return-Path: <linux-btrfs+bounces-19438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D4DC991B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 21:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C9064E3894
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8B274FEF;
	Mon,  1 Dec 2025 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KFKX6Xui"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49027816C;
	Mon,  1 Dec 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622652; cv=none; b=HKR22Csx5zCPm1q/E2FY8O3PcInMOIVAomygAYoka5OZ715vQvS2vReNo4JF3WsrVoJ4QPS+USd95ET9WoMovDZt38CxpgL0oUuU1HDHvcYOepr8NXktmGuPYX2FN+Ne0pQ7xsIY4Ym+sQ/NEVTgbhoGsFVd849gx4o6KWt0Hpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622652; c=relaxed/simple;
	bh=8tYxuiI8lyhumXyW1bThb7lSvIQohrCkg/QsBQ9Ubbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9OED76SF6l6pOAVVo1lDypXvqcImn6+s3yAvdlHYj6IItVh8tYAeJuuAkSF09B5qIBgbu08H31jD7sWuuoBP82w+guXa9belw+MUbYrUrVoHfS20TZFpFlJ83q4yVfjAPYewFiYIWWNB8/RTRQsUZq7N0/I8UMkw2kA4nxLXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KFKX6Xui; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764622648; x=1765227448; i=quwenruo.btrfs@gmx.com;
	bh=+Ap8zSinjX1TDQEScHMMaRta1erY/pCmcMyP6rgNpeY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KFKX6XuiyNEicegUClkMMfQOOz+D4JER9dsk9cV5SEgEYM9QDDvNrgPWXw5X8zNX
	 plZaPlep9IiKdjIDLPpsuNpLxq2Encv4ve2/7GxZfTzNN52xrmvTgfmQ2DAH0lGdO
	 TT64/6jZnogSIHL1Fx7Q+gQ5VFh4nUjYGMoDqhKM3NPmF1nO2A7nokvOZ5Y3oNoTM
	 5WFoBGifY21eXxM4dSZth/lbjkILY4pOt67A0xio7S8LNFGe/Qe2Gfe6btbfzsTfS
	 RxG4FZ5PjmjFlB35QyC92zRlc4dNp8/bqXpfauC05mx7zLbByykDNNYp0qZbuBngM
	 +1SSHPZi7A1bp/nqbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNJq-1vcwo11aew-00Mk5X; Mon, 01
 Dec 2025 21:57:27 +0100
Message-ID: <453951a9-0c8d-4e1a-be4f-2617c6a51fbe@gmx.com>
Date: Tue, 2 Dec 2025 07:27:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, dsterba@suse.com,
 herbert@gondor.apana.org.au
Cc: Qu Wenruo <wqu@suse.com>, clm@fb.com, terrelln@fb.com,
 linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
 qat-linux@intel.com, cyan@meta.com, brian.will@intel.com,
 weigang.li@intel.com, senozhatsky@chromium.org
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
 <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
 <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
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
In-Reply-To: <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mXI7IyJ051/tKTLpTGfFLhjg7BwTGVJ+aB0m+kHghHnw6Lm/uGu
 ISLkGR4QTVTFj6bvKtuvbpox3KXoipbbOKzgNOqtaYQvRXdbWyJgQV7Sd2gElT3X3QnR5eS
 t3lfQD0dgXKRCGyGXeRalkDUptY9MamA168X/tUsXmMrBD2o4xGUBZjabE3Cdt05bFipEsk
 EuKpFNc5zneAZWupSClZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JtZPp9yWm4A=;kIY9aDkDipikFbOA/mXserOQQIm
 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



=E5=9C=A8 2025/12/2 01:40, Giovanni Cabiddu =E5=86=99=E9=81=93:
> On Mon, Dec 01, 2025 at 02:32:35PM +0000, Giovanni Cabiddu wrote:
>> On Sat, Nov 29, 2025 at 10:53:02AM +1030, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2025/11/29 10:29, Qu Wenruo =E5=86=99=E9=81=93:
>>>>
>>>>
>>>> =E5=9C=A8 2025/11/29 09:10, Giovanni Cabiddu =E5=86=99=E9=81=93:
>>>>> Thanks for your feedback, Qu Wenruo.
>>>>>
>>>>> On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
>>>> [...]
>>>>>> Not an compression/crypto expert, thus just comment on the btrfs pa=
rt.
>>>>>>
>>>>>> sysfs is not a good long-term solution. Since it's already behind
>>>>>> experiemental flags, you can just enable it unconditionally (with p=
roper
>>>>>> checks of-course).
>>>>> The reason for introducing a sysfs attribute is to allow disabling t=
he
>>>>> feature to be able to unload the QAT driver or to assign a QAT devic=
e to
>>>>> user space for example to QATlib or DPDK.
>>>>>
>>>>> In the initial implementation, there was no sysfs switch because the
>>>>> acomp tfm was allocated in the data path. With the current design,
>>>>> where the tfm is allocated in the workspace, the driver remains
>>>>> permanently in use.
>>>>>
>>>>> Is there any other alternative to a sysfs attribute to dynamically
>>>>> enable/disable this feature?
>>>>
>>>> For all needed compression algorithm modules are loaded at btrfs modu=
le
>>>> load time (not mount time), thus I was expecting the driver being the=
re
>>>> until the btrfs module is removed from kernel.
>>>>
>>>> This is a completely new use case. Have no good idea on this at all.
>>>> Never expected an accelerated algorithm would even get removed halfwa=
y.
>> To clarify, the sysfs switch does not disable the algorithms themselves=
,
>> it only controls whether acceleration of that algorithm is used, if
>> supported.  If enabled, the filesystem can offload operations to the
>> accelerator. If disabled, it performs them in software. The
>> implementation also handles the case where acceleration is disabled or
>> enabled while the filesystem is in use.
>>
>> BTW, currently, the feature is disabled by default. If that is
>> not preferable, we can enable it by default.
>>
>>> Personally speaking, I'd prefer the acomp API/internals to handle thos=
e
>>> hardware acceleration algorithms selection.
>>>
>>> If every fs type utilizes this new accelerated path needs an interface=
 to
>>> disable QAT acceleration, it doesn't look sane that one has to toggle =
every
>>> involved fs type to disable QAT acceleration.
>>>
>>> Thus hiding the accelerated details behind common acomp API looks more=
 sane.
>> Even if we hide these details behind the acomp API, we would still face
>> a similar issue with the current acomp algorithms. If we need to disabl=
e
>> compression acceleration, for example, to assign a QAT device to user
>> space, we would have to unmount the filesystem.
>>
>> What's needed is an `acomp_alg` implementation that is independent of t=
he
>> QAT driver (or any specific accelerator) and can transparently fall bac=
k
>> to software. We already have a software fallback in the QAT driver, but
>> as explained, that does not prevent unloading the driver or re-purposin=
g
>> the device. @David and @Herbert, any thoughts?
> Perhaps I should clarify the use case to remove ambiguity.
>=20
> I added the `enable/disable` switch to allow disabling acceleration on
> the QAT device so it can be reassigned to user space.  In the current
> design, the acomp tfm is allocated in the workspace and persists for the
> lifetime of the filesystem (unlike the previous preliminary version of
> this series where the acomp tfm was allocated in the datapath).
> This change was introduced after a review comment.
>=20
> Here is what happens:
> 1. The acomp tfm is allocated as part of the compression workspace.

Not an expert on crypto, but I guess acomp is not able to really=20
dynamically queue the workload into different implementations, but has=20
to determine it at workspace allocation time due to the differences in=20
tfm/buffersize/scatter list size?


This may be unrealistic, but is it even feasible to hide QAT behind=20
generic acomp decompress/compress algorithm names.
Then only queue the workload to QAT devices when it's available?

Just like that we have several different implementation for RAID6 and=20
can select at module load time, but more dynamically in this case.

With runtime workload delivery, the removal of QAT device can be pretty=20
generic and transparent. Just mark the QAT device unavailable for new=20
workload, and wait for any existing workload to finish.

And this also makes btrfs part easier to implement, just add acomp=20
interface support, no special handling for QAT and acomp will select the=
=20
best implementation for us.

But for sure, this is just some wild idea from an uneducated non-crypto gu=
y.

Thanks,
Qu

> 2. The selected compression implementation is chosen by the acomp
>     framework.
> 3. The driver (in this case, the QAT driver) increments its reference
>     count.
>=20
> At this point, if we try to remove the QAT driver, that operation is
> blocked (as expected) because the driver is in use.
>=20
> Without a switch to disable the feature, the only way to free the device
> is to unmount the filesystem, perform the required operation on the QAT
> driver/device (e.g., assign it to user space), and then re-mount the
> filesystem (which will now use sw compression).
>=20
> This becomes a real problem for root filesystems with compression
> enabled (e.g., Fedora). If the QAT device is automatically used and
> there is no way to disable its usage in BTRFS, how can we repurpose it
> for something else?
> [BTW, for context, QAT is currently used in user space via VFIO, which
> requires disabling all kernel users and enabling VFs. There is no
> hardware mechanism to partition resources between VFs and kernel usage.]
>=20
> Regards,
>=20


