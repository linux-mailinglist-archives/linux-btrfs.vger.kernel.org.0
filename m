Return-Path: <linux-btrfs+bounces-7676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A923D9652E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 00:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D07D1F2446C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9063B1BA86D;
	Thu, 29 Aug 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KeUQRtmZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA218B479
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970497; cv=none; b=iSKRpkbnjYtyxxds04fR7mCGqneqo+QLYDgDsfc5NZcX/OanCv/Xa6nNixtcys9czHETrR6CMynMrkSU4wG6hg309zrzQOEblTjAKhB/sjeSbLPk0cfBcqvvxhoi0QoQtxRGWDRGSn//rfyOM5eT4aurMe7c3hmUbmU5agcviME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970497; c=relaxed/simple;
	bh=bAtkPYV4LTx4qPijnGrre0vmN5ob41oDjduGG1XIiCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdoGMt4cYlkTjLkYS2Xqw790IlZHhlU4XkLEFMZA0ZmTYzIhkteH3l9Wy0+NjkUgkZ3X/OB9Yg+RTch6gi40wVaC7wlyqxlaRk7Zgwn6jQU0nyXHsJL2DH9XXoXWP+MfP4eUGmBnCg1/UK8gKECp87+tJZNN9HNPgV8DQoWinuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KeUQRtmZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724970491; x=1725575291; i=quwenruo.btrfs@gmx.com;
	bh=Jve4bl1R7KlbuGeKi4FD+NrIEDhwCoLZ31l/dUEMMxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KeUQRtmZtmQXucZPWB9/kkET8yxiXA9msrgcbeSRtulB0NK/uaQ3kI6cn0hiwsA5
	 hmdyxpZ4181fqcfR0iAa5jNADU4vF+UzDGu51AyomSp2r48yPS8ppTd/q8fOgxiKC
	 hFvS9SKpb0qLAXdLwY3n3//DPZY+GfU/grMfkHJRf9lmimfZfo7R9H198aJjjASDI
	 Utc7q5e9bdPy33/K8aHDBRS0GpnkxS4OqAsTLk6sUsMSwZYHHRBBlicAHX7XY5fj7
	 HUK2Vf5KOyO2ZtwUjOXq+KO3c3Qki8FXruBBqY6HjQlPSGCimdfk2hOLgMNr7iDqI
	 bTMusUUMAiuDxbivDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhD6W-1s6bBR0gC2-00c1PR; Fri, 30
 Aug 2024 00:28:11 +0200
Message-ID: <72fd0c93-a455-464a-9925-1ed8dc8eb6f8@gmx.com>
Date: Fri, 30 Aug 2024 07:58:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: interrupt long running operations if the
 current process is freezing
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 Rolf Wentland <R.Wentland@gmx.de>, Josef Bacik <josef@toxicpanda.com>
References: <bbcd9ebaeccb3a9e5a875a2ffc1afb498d6b75fe.1724889346.git.wqu@suse.com>
 <20240829165948.GM25962@twin.jikos.cz>
 <a7aaf78c-4417-4f3e-b551-04b4898f1ba5@gmx.com>
 <20240829222343.GQ25962@twin.jikos.cz>
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
In-Reply-To: <20240829222343.GQ25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IGmkDUQXYzd9bIbVRlfePxMOn1wCZ43vz/65jam9kcyhuDqdsw9
 hr1xkONnIJXe9XsDs+AHCVcPe5TnP0HS4eKzykeu8JEcXeaUPutCnBf/5uMeTR1mwUsyYYh
 xqukII7o8fqdWvGsqt1J0V22b0oPro/AKZfsSyzxAixbNzJ5PJnqG/Ucd6RAsWSwn5rnXXX
 TuV8K0OaDly2hIQbL8WXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kLLBsmReSCw=;iCoCjpbOBnkYqX/sgdeQK598ow9
 OIodVL+wAcdWfN5zl+sHYykKOYf7PJKdYPgKmd43tlTZwykCcn+wZneIdi1W3gLndq0AgQR3Q
 Qp+Jps9jPhEaGUWLWPCxBMI4vgLKWyCOw0hiX4XliyFxlR0wYBW3Ktdx24lD5MHtarUeQoOh9
 ku5i7hbB9rP4KRUS/iVvRlkoOtaqRkCusGO30Pkx2bg2Ofb+VNrEY/RVBkRCGdY7SPBdIzvyk
 oqC0O+SHm4lOnkzwRH55blqKcUJd6sVItdhQMU9l9nc9jD8dZnuT/EP8VTMflQgjg5LULKGn2
 eYrhSIgLkGui/bwR8NPA9KKKQ4+KXCUl3TeVwKp4V3g79PWUg6nsquNpkVRbQk2z2s4TEuVdP
 V8a0jDdpiR8Rv7ssBx/4qQ7TqKDqPOznXk7htqWisvbONKJXOVjOoAPHFnL5kuWnbzYC3iPPk
 7HVhgiN8h/Al5qvtJbbZOQZ3/ypj4Qrrv5M9e5zVhFPTUr0Fthjztno5Q4XEWGIIyEYQFOSR0
 wPjvAzLKVgVfARwahybcELmANL/BhlVRsg8Luw0RV1vTyWYJw8v2ZRWbSGdGLmpXodXmkZ9mI
 m8OUEAFj8JU5aGOYDhWbYd2thVfpsanwmWGbn/I6haxwN31FKamfAJsiBuu0wgYImSNwuOFSZ
 CI867rJl+BreS99QWMpBNbjZrDLq+HJJQXzV7edyZtOQZKQOEJBv9s/x9CggYgZycNlWnVHVW
 MCMNvvXOMhDx1uc2BQufPagMpQCfcMlUwXNFghvSR7nLL/+CjwzbK7ZvHijlCCBQg08WXKks/
 Z0A3FLfk7yleEG0vOln9mOog==



=E5=9C=A8 2024/8/30 07:53, David Sterba =E5=86=99=E9=81=93:
> On Fri, Aug 30, 2024 at 07:07:41AM +0930, Qu Wenruo wrote:
>>>> different infrastructure.
>>>>
>>>> Unfortunately btrfs only checks fatal signals but not if the current
>>>> task is being frozen.
>>>>
>>>> [FIX]
>>>> Introduce a helper, btrfs_task_interrupted(), to check both fatal sig=
nals
>>>> and freezing status, and apply to all long running operations, with
>>>> dedicated error code:
>>>>
>>>> - reflink (-EINTR)
>>>> - fstrim (-ERESTARTSYS)
>>>> - relocation (-ECANCELD)
>>>> - llseek (-EINTR)
>>>> - defrag (-EAGAIN)
>>>> - fiemap (-EINTR)
>>>
>>> Is it correct to interrupt the operations? If there's a reflink in
>>> progress and system gets hibernated what's the reason to cancel it? It
>>> should be possible to just freeze the state and continue after thaw, n=
o?
>>
>> One process trapped inside kernel can not be frozen.
>
> I don't know how freezing works but know it's very complex and handles
> lots of special cases so the above does not say much.

Well, so far it really looks like for long running operations we should
abort the operation.

At least for fstrim, and that's also what ext4 does.

>
> We have kernel threads that can do io, like the cleaner kthread and
> others.  There's no explicit point where it would check for freezing
> request, like it used to be with try_to_freeze() that got removed in
> ce63f891e1a87ae79c4. There are flags for worker queues that mark them as
> freezable and that's enough. There were series to make freezable block
> devices, added in 6.8 and btrfs support was not added (but this may not
> be relevant for the fstirm problem, I don't know).

Those kthreads are different because they can sleep by themselves, thus
no need for special handling.

But it's not the same case for ioctl or the other long running
operations that trap into the kernel.

>
>> And it's really user-space programs' job to determine if they can resum=
e
>> the work.
>
> Yes, but in this case this seems that it's suddenly changing behaviour
> depending on freeze. And with this patch you change 6 operations while
> the report was to fix fstrim.

If that's the concern I'm totally happy to only do it for fstrim.

Thanks,
Qu
>
>>> Imagine a case when a long running file copy (reflink) is going on and
>>> the system gets frozen. This is wrong from user perspective.
>
> So, if this patch changes how cp --reflink behaves I claim it's a
> usability regression. But we can skip discussing that, the fix needs to
> be done for fstrim first. Here it's either to end prematurely with
> ERESTARTSYS or to somehow make it work for freezing with some magic.
>
> The patch as it is now cannot be merged as it breaks more than it fixes.

