Return-Path: <linux-btrfs+bounces-2044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DD0846224
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 21:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C071C23DE1
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53F3CF4F;
	Thu,  1 Feb 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YsnGfeph"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30A3BB4C
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820672; cv=none; b=GfFh+fddliD6lK2Fwo3nYCdTzP/H+wPuC49p1LRRIfbQ24OO5uHIKGbm6a69a/skXT1tv4i5N9Oma9dQBTp5H/uaKmcGo81BUi9W67yzFZ9XZsxQwlQXKngmpoCFzUo/yqroExCtimT36Rm7oTgtcl0ZdwWaqHkeF1PSTgORc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820672; c=relaxed/simple;
	bh=OcVkqS0ZOdNJNygmCki63flY1iBf/oo5lNuAmyN+CRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBFTW/76FVWs6Rh+D7+rXxkrjPUHuHcf7Cy8u6PWIMIJ24ZnlSU4mXLXE5cOoYv5ZqB6Iaxzjy0B5yBPWdBtOai72c32LnTZ5R0yeaYHGKjNUjQnlIFlbWtkZ6TdOt3Vvx/78FXe54dyOb6Uq/7h+Evm+1FLzJptU6IFWtunT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YsnGfeph; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706820662; x=1707425462; i=quwenruo.btrfs@gmx.com;
	bh=OcVkqS0ZOdNJNygmCki63flY1iBf/oo5lNuAmyN+CRw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YsnGfeph15PcYIjhj67ttpRtmNV9N0GI+NJullXmftUCyzk7xjir4sNynDXRr+rD
	 VjEG15vZP1HJmfzJ1hSvZhTln/IIHjQFEFD7v5ua/ueVlmpcgUdD5QrUeurPp8JpK
	 GJhyEf0Y46Hy/HIa8eV0tRUmnla5S1z+8+x/03TK+QK0eXoQIztV7SMqODHXo6xiH
	 QcILLSh2e13mdJUYRofwqk41ACoer/R3I2lm65G3PdRQqjHkeA3a84A/zlRGFrV6S
	 irm2quIJGF7nPnv9g5q7zDpqUuj2XKXk025hlSqvOsWMengtwfhJZoGxCya8Gozjs
	 UV3aiK9MPl4Vlhu9Mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1rQ9q611nw-005XKt; Thu, 01
 Feb 2024 21:51:02 +0100
Message-ID: <b0f17f2e-5993-42a0-9a57-e93a2a90c020@gmx.com>
Date: Fri, 2 Feb 2024 07:20:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
 mkfs.btrfs
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Anand Jain <anand.jain@oracle.com>,
 linux-btrfs@vger.kernel.org
References: <06b40e351b544a314178909772281994bb9de259.1706714983.git.anand.jain@oracle.com>
 <20240131204800.GB3203388@perftesting>
 <04a9a9cf-0c77-4f1e-b9f3-12cceeb7ef57@gmx.com>
 <20240201190712.GW31555@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240201190712.GW31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VWSbskWjHr1FXN/6VgV1tIa/D26FLK6nHEUcmiKIPKN6BtVK9md
 lg3Lkole/wjIhNkBDb8zlM5rNLV7Nf/cAc1/p36yH3ThtUmPrmbO4vo6tAsJht9LNB8dyk5
 CUSBSkep8pmBBbZEghW88RJXKEZe5Zp15u0/qTNzeNoQuawERPpBNt5pHN3O6U0DYZ0+2Zs
 0qvb38UDZ9p+fVMDW+/RA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gCW2ViVVOxY=;TrrQl6AbMjzxoo7p5j0m0lbSOjP
 0cPD1kW/1yILgLbPP2fquzSxTaWCtfeFK4QXeq1TXVB5wRtMLTbSdvFZuLXlB/tmReimD2FAj
 Z+4r2uu3khfNvxKlkLMu8JU67ge+4gUjxD/0zNLArNVIsxLA+aYG0eyUFqMULzmuqKXsFTTOn
 5LmRUxmfD3VqicJPz0N0SZ5Bv+W3shOwKGjZwv7W2CBu2rVmPEhVmf/MOgbQ2966P6ZVwu8Vs
 5t5ElFByY3QmBkwtRxkHZkvEW5NwyBDDlGTkcrnMlp0hI4wntS0Nt/aL2ExwvSGsUq0bKAQWc
 x4X5eb160odSkxCKVXEyWMLj7hFk2zkVWU06OP/KU7bC1NrN5I2k6Hvq9am8tZH/Vjf0gcQZA
 wxrFUwGKnZi0Bg+xN6OlPRll/zh1/cQN6E7wCXIT7gtm/i9SmTOFqARM2whjutyuGE/3E+wrY
 nVnpn2i+Sr+EaNCCiLmROAUXna6QutrthusTjcwC61H4uqhKUNrzZOfz5ZKlrxiwBKaOC8MsZ
 2EefELjQpqhJJlD1djnjjXXTsw1vqe+202LIEiSWc9osYM4y49RMrh6Fz8+mwUYm36uzUgWak
 Az5WGy2WGLFyxpFuqn98W6tIqBLP6YK/73CKMDYrryQ4ysdhp+X59pyybbQGawZGXLuz90Woe
 4ceKyBdxy2SSOYeoRgdDovp59CeEPrMemcUpd8Dn8Wnw1xuYJxNlArPCEPigdC8HbDvjMSuy7
 WCO6f96L8rm1CdG7xsE/ZcDvTBAvziMcDo8DWky6M7r0Sz+KoWTulCAzLFE+cFLdpi3gmpmTv
 y/8+ba6fwJOHpG3IptLxdOD35wyHuPpGy7Wf7HY/5lKEw=



On 2024/2/2 05:37, David Sterba wrote:
> On Thu, Feb 01, 2024 at 07:19:15PM +1030, Qu Wenruo wrote:
>> The problem is, even if we change the sequence, it doesn't make much
>> difference.
>>
>> There are several things involved, and most of them are out of our cont=
rol:
>>
>> - The udev scan is triggered on writable fd close().
>> - The udev scan is always executed on the parent block device
>>     Not the partition device.
>> - The udev scan the whole disk, not just the partition
>>
>> With those involved, changing the nested behavior would not change anyt=
hing.
>>
>> The write in another partition of the same parent block device can stil=
l
>> triggered a scan meanwhile we're making fs on our partition.
>
> So this means that creating ext4 on /dev/sda1 and btrfs on /dev/sda2 can
> trigger the udev events? And when both mkfs utilities would lock the
> device then running them concurrently will fail, right? This could
> happen in installation tools that can create different filesystems at
> the same time.

For ext4, I didn't see any direct flock call, maybe they are using some
helpers to do the same work but I'm not 100% sure.

>
> I wonder if we should add options to assert, skip locking or wait until
> it's free.
> The "udevadm lock" has various options to do that.
I'm pretty sure we can add options like --wait to implement the same
deadline behavior for mkfs.btrfs.

Thanks,
Qu

