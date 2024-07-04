Return-Path: <linux-btrfs+bounces-6189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80E926CB5
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CD1F239E1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49DF3234;
	Thu,  4 Jul 2024 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lCWga7Xf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC911870
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052401; cv=none; b=nCopati2hA9xDA3rwkVhmN2Y+0qDcp/x3AxGATSuH7emIZz0o3uVCIx7YD4qydmNJd8vIXifL+7X4norpPm5XB91zty/v8FQO9+wUW7bmszLbpwL47x8N1qovB438TtnViDSbylO/jsmwKcGhDE6tNMihngZ7bQ32QxBx4UjYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052401; c=relaxed/simple;
	bh=OzLDFrIo8eAmAz5Yn0VMMuTLsgzNxMXF+E+YzhVL37s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jL7SF+WJH6Fx/7rg+RUq2qVcxaRHDDaiRGwry6938gh0Kg7s/7CUEvyzLiHd2W/nmA+IwLqzTlgXA4KpHwcurh6WOo53sWCaZu9xCCut3vLPOOtPG6r2YeJW19yO7xFg+ZWJ3qUdGfpXtyHsI9PACVla8mkEBVIz3hflyx4pCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lCWga7Xf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720052395; x=1720657195; i=quwenruo.btrfs@gmx.com;
	bh=C5BjfbSgRR3S1o8pw0rb6FziKWPlCfNbrRWz4jCLaK8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lCWga7XfktNmlCzvMLWBrpHmK8K5k7y6Vmhd3wxpfhfU0S44LJw8l0n6T5m7jr40
	 XTVuOsshorMzIR1dlCQbwxkz55ddHqk0GzHRsR8BGAZrwFhyk5Y6yEWgVNgoPMgCj
	 0BdYtiWUDRadLFRCY9fhHT8CSEmw06KyOs4ya+rNGnJDGuo2sDNkaFWrX6R0kJvXj
	 KAIdEbPqB3vmDwesxSElN/SEISPoAYBVThVQbidS3VmpGuROqyFsnC4zN7ccJc/J8
	 m2slalA7qDvp5SHLVBhodNuDFU2qs95wsEQNJDj7y9vBPtfM5kviY8v99bG2m5oBc
	 bfujksfzhZvJbhU6zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdefD-1rpYOw13EP-00bEBe; Thu, 04
 Jul 2024 02:19:55 +0200
Message-ID: <d7e06214-0166-4db2-836c-36b2abde054b@gmx.com>
Date: Thu, 4 Jul 2024 09:49:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-prog: scrub: print message when scrubbing a
 read-only filesystem without r option
To: dsterba@suse.cz
Cc: Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1720028821-3094-1-git-send-email-zhanglikernel@gmail.com>
 <af92c238-a5d0-4023-8001-042f17085198@gmx.com>
 <20240704001309.GV21023@twin.jikos.cz>
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
In-Reply-To: <20240704001309.GV21023@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7X0lfkNZYpw/k/5Q8bpD0oYlRSqP5s/jCOLF/ZyLhI7GrfKAY0u
 U/OAjsxHOO/Pt/QCQudGq27A+2KxvoEKk0DcUU8jGst4hhnLGC+9Nj6yBgIXjVaswsBkAcV
 jp86jugr9GDXy4qWoqUQquRzeK9RzCMjxvFdAwYqLJyygOeD5U+X/WYsxunRcoTdxevHCkB
 n1tg6TUOToA0GYxiHoJ3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oGw7dua7khw=;gpbV0rex05FnCYesNsET41wAuVG
 Q2fJgU0Pbza2mNnKLemQTXf1O0hIhwEcJmLdhL8IvoA2thHtRHo6h/hm+YPvUbsdeRirmQaEY
 Ye2UJId4IMjxb4dw2hwv8zZDz/xO26uAT0zWmiiY5KBSfyUS96/pf/baNsHZGTH0bQByGI/ur
 jNE7RkW7hSfUmNsYF7WtQIBK3f+QDZizLBPL6Pa/yLuLdAE693Eu8zK8pewdP963iFjCp33AW
 AXnZY5/DErtRMlgWePVd/T3l8/IDbvfIe4DkdVi5YnRJ+vCZcy8NF8ciTZ+KaFEyjSvHqZ75r
 78Or/ot7jck8L734NJXqsejefP3cpRUVLugtrnBx0kWB1ize13c4cdomePx0yirxz+6JsdECu
 ClQEQX0Y3TRCYhOERSFrKBlRrgEVNbcvfgrtVm7Epg74eiRM5RV5OlqkMokOYBB8B/GaVK7LS
 LWVYSntKiSyOeCBdlE9GPZdloin5rQ19v8fB9R0+cQopiaCXvL8NT7rZzZgPItVlZ9Ga5wMTC
 3mDWiueZhmU1WgNfia5W7u1ou3Emr9Z+mheoBXN7gi6pFQqp9dxGid44OVnQQq3d1SyX8a2TV
 hqxjiM0LB3z6bOHsAHsN84vxAvUUshIDkegq6IaX88UyiHseSBV+W74YTXA+ivq7RweL4A4Mr
 3oYJycNOQPHqDoevLDjf1AAtc7aNAUDAnlLMAkWkRqXtDyAv8Tm1f1RpjIroqb3cahltvn6So
 LTesomskwdkP9UWInLLiXWYLi3Ci2PGYNXQIOwT9WN949KwfXFGmeYmZTeF6wDcE3TneU1Tnf
 EV5k0l+i4Q64ArHhSLp3vGsqObEdN7PoInLeeVzupFqns=



=E5=9C=A8 2024/7/4 09:43, David Sterba =E5=86=99=E9=81=93:
> On Thu, Jul 04, 2024 at 08:56:47AM +0930, Qu Wenruo wrote:
>>> --- a/cmds/scrub.c
>>> +++ b/cmds/scrub.c
>>> @@ -957,7 +957,10 @@ static void *scrub_one_dev(void *ctx)
>>>    		warning("setting ioprio failed: %m (ignored)");
>>>
>>>    	ret =3D ioctl(sp->fd, BTRFS_IOC_SCRUB, &sp->scrub_args);
>>> -        pr_verbose(LOG_DEFAULT, "scrub ioctl devid:%llu ret:%d errno:=
%d\n",sp->scrub_args.devid, ret, errno);
>>> +	if (ret){
>>> +		pr_verbose(LOG_DEFAULT, "scrub on devid %llu failed ret=3D%d errno=
=3D%d (%m)\n",
>>> +			sp->scrub_args.devid, ret, errno);
>>> +	}
>>
>> Doing direct output inside a thread can lead to race of the output.
>
> We'd have to communicate the ioctl start errors back to the main thread,
> or rely on internal locking of printf, that it can race is possible but
> as long as the string is printed in one go we'll get only lines
> reordered.
>
>> And we do not know if the scrub ioctl would return error early or run
>> for a long long time, that's the dilemma.
>>
>> I'm wondering if it's possible to do a blkid/mountinfo based probe.
>> Then it would avoid the possible output race and error out earilier.
>
> We can detet read/write status of the block devices. I'm not sure about
> the mount info, what function can we use for that?
>

E.g, setmntent() and getmntent() used inside check_mounted_where()?

Since mntent structure provides mnt_opts, it should not be that hard to
find if the destination mount point is mounted ro?

Thanks,
Qu

