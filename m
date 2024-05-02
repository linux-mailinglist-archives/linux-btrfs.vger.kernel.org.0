Return-Path: <linux-btrfs+bounces-4686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F14DC8BA256
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 23:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B06F1F24DEF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD0181BB2;
	Thu,  2 May 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BVJEwBJV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD1181304
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685357; cv=none; b=AtYlzl5GjnjdVLxoggRYL2BB1HXijebXF+kcoVwHM0EaINHr+KgSeJKxGu2xgUQm9UvG2VR1Za7DuioK8Ep/wf7+s2z61gX2QEFhqTJ8ZoVzkyeltv8qE6NF2ErJlHPCsU9NFDBuMkcXzatUHJbseRMlo6xaBamutwcsbVhePP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685357; c=relaxed/simple;
	bh=qKLsezAb2U1r/8pZB7lhFW4+IIUnp+ISdIydRQqLHE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbIe0qtwGnWqqI7sYtFEDZRopJE8O+4N72LiNnrtTGktfjzhW4PrkqIe+1sNVg/LSbCX1TUUtvaAgsKHimMU/OO2NO1WltPunOYO+zN223qZIESLrn2++QBU9opPKf/P7AuH845mMOxxU1BNL8DhkTVRfWtTtzrkYD8ISmDyRmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BVJEwBJV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714685350; x=1715290150; i=quwenruo.btrfs@gmx.com;
	bh=qKLsezAb2U1r/8pZB7lhFW4+IIUnp+ISdIydRQqLHE0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BVJEwBJVFLoKeLxscyZZyHne1xvbhSkBr2RT32JDVmaOy8r0Mxb1Op/oAfl7EShf
	 jS8fKKu4unzIbDnVDhrdwp4lV3x7zCV4ZwOb/kgNfsEEthpCssU5oqpHY0SUS1ibq
	 g+5ZhV4HGVZfHdeKRub6Phbzor48sI7FC50USyXI9P+ey2m5wlRtoM7CwKgBHRqAt
	 jr0BMK0zRoKX2Ce9/wrkg+U7zcKoStLhT19NAvwX6TPylcRrPwBqwQWjgzxpirpk5
	 NJ+ZbYGlS+aatywxZhw3zhZSA1YCOKUIgs+1np56UNE9Btjm0+XHIl3/j9nd0xymF
	 WLJgkaPsxMYxNSD/PA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1s4quj1TyK-00402e; Thu, 02
 May 2024 23:29:10 +0200
Message-ID: <d1c91b71-8196-4ea3-943d-db30883acb8c@gmx.com>
Date: Fri, 3 May 2024 06:59:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
To: dsterba@suse.cz
Cc: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain> <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
 <20240430105938.GM2585@suse.cz>
 <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
 <20240430221839.GA51927@zen.localdomain>
 <d49e13f2-59ff-49ef-b81c-8c2c96d8284b@gmx.com>
 <20240502150332.GS2585@twin.jikos.cz>
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
In-Reply-To: <20240502150332.GS2585@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MuagGtsdrIDMs3wb3JrWINj+c41O3q1vimfLGlTNojN9xFGnhHV
 OWPtQCQy8WwkSD/vZCpvt/+m+DnTbp3HafnJSUvD0SS8s2griIXex1AFn3swVcrf/QzOmwR
 9aTtwwr5EFd9Ko2NXDswK5688k6yOnO7Guii2hPluvjNNueUC64zPZPFMGAS0FXUoOUNjv3
 wKmZvEGgmmcdj7as6WXxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mV6IOOL6FWY=;GnpqtbCceJ6erUbjrkWfXhLcOHx
 yBoP6b40k7imkxp+NEj9Z/9gTWBzQhOwPLbKbWXHhpRP+DfTQKzWeP5ihSbUB7KAsDjjABe4H
 /aa4LDPyV/3/Ze2+ESjnG7/uttgJUqEtVAyDrNbx4wuxm9sqVOijHoclfI/I3wTKu8klQ3/TB
 qzQ4vxtfsMY6eUDt5kEg8OESN07PThgB12Puj8lRTkIku0mIy9mGIVgSlFsjjJ+Qs4gWyGuat
 oRNmM766EH/H6koyTokn/8i4J4njTHXpDV04I54hTbecCmp3lQ9t9VouoTvDLpz8ybthtmf9N
 JzyzqfS+Rhvt5JOzVsiVZRaPhLwiyHxOVLMX++SQRXOhTMO+VIwAuack2PPALpcvgzkhfedsn
 rw9ZQnqxBaMllbHdwU0Thckdc+EcDu+gi86Saiz3HgFbYVEKebRRNPUhoAWd+L0qD6124Nh5K
 sXp9VztxVjtVdicBysypD7kbMO50Q1DAHUKvQTMw387qo2gvaHGkk+F6RvTSag8QVSLbmezPX
 ftnxwx87JWHt5pU9zo22rolbnqwaRH5yojlgroZZphtZZYzsGswLsCGbY8e1kIB2X4rXN+Tf5
 tpUoSb+QmXBEAyz+OsYWk76n3UY9uEe9qFB8xXAYWA0dWNfndw256EqyCZe7+jPknKM0/tgl2
 uMF8EPdkqjrMMkLgfAqoikAafcVS/ueIsSJPOXeHmzSIErDYdWeePNVavzs5JNXqCjZLDMeT7
 gF34DDQFQO7j0tDECC6BGCal+MzmXfkfD7pO3JIbOe8gETwLrVdii1HaZgdVhVlrxpA6eLb6h
 OCOXKJrNLuHzuxTI1l6lU/TcFcXZfSPX1jnsuJUAHOWCM=



=E5=9C=A8 2024/5/3 00:33, David Sterba =E5=86=99=E9=81=93:
> On Wed, May 01, 2024 at 07:57:08AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/5/1 07:48, Boris Burkov =E5=86=99=E9=81=93:
>>> On Wed, May 01, 2024 at 07:35:09AM +0930, Qu Wenruo wrote:
>> [...]
>>>>>
>>>>> I don't see how a compat bit would work here, we use them for featur=
e
>>>>> compatibility and for general access to data (full or read-only). Wh=
at
>>>>> we do with individual behavioral changes are sysfs files. They're
>>>>> detectable by scripts and can be also used for configuration. In thi=
s
>>>>> case enabling/disabling autoclean of the qgroups.
>>>
>>> This was my initial thought too, but your compat bit idea is interesti=
ng
>>> since it persists? I vote sysfs since it has good
>>> infrastructure/momentum already for similar config.
>>
>> Sysfs is another way which we are already utilizing for qgroups, like
>> drop_subtree_threshold.
>>
>> The problem is as mentioned already, it's not persistent, thus it needs
>> a user space daemon to set it for every fs after mount.
>
> My idea of using sysfs is to export the information that the
> autocleaning feature is present and if we make it on by default then
> there's no need for additional step to enable it. The feedback about
> that was that it should have been default so we're going to make that
> change, but with sysfs export also provide a fallback to disable it in
> case it breaks things for somebody.
>
>> I'm totally fine to go sysfs for now, but I really hope to a persistent
>> solution.
>> Maybe a dedicated config tree?
>
> No, we already have a way to store data in the trees or in the
> properties so no new tree.

That means a on-disk format change.
IIRC everytime we introduce a new TEMP objectid, it should at least be
compat or compat_ro bit change.

Or older kernel won't understand nor follow the new TEMP key.

Thanks,
Qu

