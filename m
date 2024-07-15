Return-Path: <linux-btrfs+bounces-6486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1666C931D05
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 00:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322751C216D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5413D244;
	Mon, 15 Jul 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Zfc3P9MG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6D20EB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081527; cv=none; b=LVI/blxwyohBNZnWZg5MYWf71Nxye3WEYPJTwVxsJuxn+grLnjx+g4UOBCZT6iiwXBY7BOj/y1oz7Z0MTrQM+PVeyq0fT+pEUjbHm1rB5VBGv81WtUsxJyMHF006uNbqfkncnPb1siBMhDtBRjLMZeCz03+g9fo6xkO9Mz9gWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081527; c=relaxed/simple;
	bh=mP4NNQv9fl2QTDG8ye6VN4qUnJkG7M82HSB2Pbbiu9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgEjBtZ7mOVYX+epkge7BBgmlHbJgzqV0udmy1jcfd9ksQEKE9oXDxfNDidFJel0yKIi/H4zyMN4u8uNd+nFFtfPOg2rRz1Y+R2YmgMKpWOJszuwTdtx4iKWR2umWM0OA0yifSfTZ0Oo78H7kkvyuDtUMxEy6KlDSjLzX9p7Q8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Zfc3P9MG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721081520; x=1721686320; i=quwenruo.btrfs@gmx.com;
	bh=6A8EaJ/ZINEuyo59fNZkBiLZEK45lTPvSKfafMGU1yI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zfc3P9MG3ofP0/Ey3WNSYLdHfbo0vksGF5zGqTXkYAzn4DKDunuKLiR2V6bWLaok
	 AsGK4B5Enl9qvr2Ppl8zIsi5Rp/1QK53QGl8QxQgc0VtLOrtjDZ8zJWlM1Exf2Clz
	 tnRJbyrGLDYc1zzS3JlAoN6iFDaLlEFFNEv8t/bpR2TrD4aoNICPEbXyaFFQV8JBX
	 ZSfqo5AxgkRHbtTWGYCcsNl8IaY7htGpLMyoEs/D60NfqMHu3CPc8ZSU0LtnsXGcK
	 tduFylfyzA/ME642nKWp5DU/ViL0kJRqvXtL6gUN4E4xT6+6LO7g6b1vd3ODgRzSl
	 czDKGgTNfoIbtUId7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeMG-1sssYm1F92-00JmH2; Tue, 16
 Jul 2024 00:12:00 +0200
Message-ID: <b3c459ff-d168-48a1-bff5-95bcb983f8fe@gmx.com>
Date: Tue, 16 Jul 2024 07:41:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: change BTRFS_MOUNT_* flags to 64bits
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <0955d2c5675a7fe3146292aaa766755f22bcd94b.1720865683.git.wqu@suse.com>
 <20240715123155.GD8022@twin.jikos.cz>
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
In-Reply-To: <20240715123155.GD8022@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K/dM1U3iYS9c+XVxvUh83p7Wowz89A++C59mY/5MlvIFHaW9bTx
 zIYU4LTRsQxzOk75rD4P60Otd6tVd8O65upjMXccw+D5T7fHlJHf8+vIQ+YiGAtNLpsU/F5
 FndhVF8mXMBxSm/Wj98MK68ZLTmJ4f1UNhAeKN0kXwdCPzO5xRekvJkQTDK6PeYfG9/vcwe
 7S5iQfsQsLTgRzuRr921A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4fBTk33ezrs=;GQqId5ziLBpgcwc20WgoJ8O+iHk
 U/JCdCXUN8MQr6sqQQqM6J+hPObFDhW9O3Nuq+3zNHlbiDpuCMB1LHhop4reyuT644KiRrmcs
 AsEQRW3MXPVxuVybjJK+WVTw1R/huoE+fo86L7lYxZdVjazp6Ou65kBIF43mFic1p0WliQWwW
 PXvaHrlOEZql3paIIucjre0vudbB8Bae1JrxgyywE+hdgdRoaCG1FDMlwpMEqFI2pAprDX+a0
 U2mwz65m8P70rXxHx5uEesq/ex3vrFFli8N1ffEyPIqAgsGfai+QPeK2raPBjefWHJopCAviM
 vNUYdHGXOKx7OKRGUNWvEsFxiP934zZzFv3ry3W8AKOYFxHHNxqJ1kCbDTA8TEpZpu3Q2Ch9V
 51nKxxy/EzpKaOM4QDQF6VohnlRkmvRdg3PoJ6Ll4Zb0D2n9NjXAdts3MS1xGNz1NZpSp87Zo
 4tQtauq6q8db2f/QZVFOAPgwaX5sDpMw9nYPIqwcWfzF8PgytD3J0pjMEnPW+eDxwD4SnHPGC
 31VlZYB28Qq+fyG7x14I+iyF9J4H9Fd2/QH8FAJpDE0RE0S9Uw+vIhHkOLeNRzdByZVjLZEc0
 sx3tNXUMmjtr8Ujy4e6T+3L5IJhIC6i9yNtNCrEeoDM83+AERWwjnBEFEQbzZw61KFBMwADdy
 HirJaokKW52CufYOziGckyP9wE4dHVkyPfS2WkqiLl9gTWJjur0oNciOlrWDV0rkSKufLpBrz
 wOIQvklGjBdz00rA5G72uq5vZKD+nfEj80/nG/oX8lNm8hPTmO21G/ZJfANSVP0maony5nmRm
 ZyGxlnG5p+RCc7kLm+8MDt9FqWtfcAcL2D3f1ZgvqVUis=



=E5=9C=A8 2024/7/15 22:01, David Sterba =E5=86=99=E9=81=93:
> On Sat, Jul 13, 2024 at 07:45:08PM +0930, Qu Wenruo wrote:
>> Currently the BTRFS_MOUNT_* flags is already reaching 32 bits, and with
>> the incoming new rescue options, we're going beyond the width of 32
>> bits.
>>
>> This is going to cause problems as for quite some 32 bit systems,
>> 1ULL << 32 would overflow the width of unsigned long.
>>
>> Fix the problem by:
>>
>> - Migrate all existing BTRFS_MOUNT_* flags to unsigned long long
>> - Migrate all mount option related variables to unsigned long long
>>    * btrfs_fs_info::mount_opt
>>    * btrfs_fs_context::mount_opt
>>    * mount_opt parameter of btrfs_check_options()
>>    * old_opts parameter of btrfs_remount_begin()
>>    * old_opts parameter of btrfs_remount_cleanup()
>>    * mount_opt parameter of btrfs_check_mountopts_zoned()
>>    * mount_opt and opt parameters of check_ro_option()
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> The current patch is still based on the latest for-next branch.
>>
>> But during merge time I will move this before the new rescue options.
>
> You konw you can't do that right? The branch for 6.11 can't be changed
> anymore and it was late last week already. I've forked the changes at
> 8e7860543a94784d744c7ce34b7 so far it's still subset of for-next if you
> change anything below that then it'll cause merge conflicts or would
> need manual resolution in another way. Until rc1 it's probably safest to
> just append to our for-next.
>

I guess it's impossible to drop all the new rescue mount option patches
from 6.11 queue?

If still possible, I'd prefer to drop them first instead of hugely
breaking 32bit systems.

Thanks,
Qu

