Return-Path: <linux-btrfs+bounces-4656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4AE8B82AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 00:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFD21F232A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB51BF6DF;
	Tue, 30 Apr 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hgZNBwi+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538E129E72
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714516043; cv=none; b=B5EwuwjVxCHqi721UYUNmVkS9BQOy9CONzMt3bs8oXGwq/w3vgycQBmW89RpAzPSlZZ+vj32OvRT/UIqmdxU0UwV5VXYbfD/+JY72EY9fwkAVzWdeC8bhSDxi6nX0aFO5pkkYwllTwyHuP+VrAl7vmVXvbJwCvgvlCYZQPRHSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714516043; c=relaxed/simple;
	bh=/oc+9apdytnR2IICOWLKE7yOrr+f5BO7bcvGoAnBbzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4zLd380C5B8YEZNYFh/Cth3fcPA0xpdqoPC/Vd9g/R1WLE0mI2WvSpoDeNGaGEmPxXqBWsGdWlDT1oIrkdvRyEaMs8cn5GWVP2EIUe6upEHYDcREPv8yYUV3u1v55G9Wk56Ym3aQ2sO4XpJrtx64Tq7Jq+PQMotTD2dRIAdxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hgZNBwi+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714516034; x=1715120834; i=quwenruo.btrfs@gmx.com;
	bh=/oc+9apdytnR2IICOWLKE7yOrr+f5BO7bcvGoAnBbzM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hgZNBwi+CYQIF4VKyWRPn8tkSKeK3MGTA6fSM1KOs/q+xcyfnkWp4uns6bb4ql1w
	 qGgGWvC/M7rTn0fZ00FFIenQgquEBTVoMM19ynDj5HOzfxLO6AH3v4RM4Af0/MyFz
	 JmrtPk/XKTovNpoIG98NSZpen8hTH9++SjJ1uOqyJcF1RtsNW0K/FWCA54PDomkLS
	 SYZPIrd2ot8xYEXxAYDOzb2K3EqpGG51L/6W3Z7lcgM+A0hhUD3KuSHIN+17Avoi3
	 hFie5ntIFHxjijF1qj2wvN423jKYml9Mqdk351sV1w7iq05f5V25dLv+8tptW2vtI
	 12sE613iWy8DzwHrow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDbx-1svq161szt-00u0tY; Wed, 01
 May 2024 00:27:14 +0200
Message-ID: <d49e13f2-59ff-49ef-b81c-8c2c96d8284b@gmx.com>
Date: Wed, 1 May 2024 07:57:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
To: Boris Burkov <boris@bur.io>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain> <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
 <20240430105938.GM2585@suse.cz>
 <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
 <20240430221839.GA51927@zen.localdomain>
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
In-Reply-To: <20240430221839.GA51927@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KwafYg1+LNHe/gl+zQJ/ZWGDxALi1Pa2cn3feg3eNadCKn6SVvQ
 67M9CeTKVl9WEev9fgVpNHsKNL1ZtsCFZPIEfF2GeM00fPsMu/jBQAncMf8ZoVHZAofWc6A
 ap524WlQBS84lIlYedx4azTfgY9t1tMXSFIzMZgh8KG9ScQlDKN5UPgBJhHjQE90DOHa4Zh
 nW/+gI1SOtXS/Spln0ozw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NSbqUC9cpcE=;o36t+29jQv69d8DCGo/3MKBX9kN
 Kl2gWGFSwNOMTv6So/yZGeeG7r9/cIMIbfSJzsSipEYw2S3SA942xjooGlU/UBZj7u1/AxWh0
 zdV0Tyaugg7cimcoGwe5xtmV0dGl0UwKhEwihmFGZR2Xd7oCA70EpXtokVx4cgzPO+q9J8I/i
 A7UatAxdo2/cZ1XOcs9UY9DQGkoc5DFyR+2mxt6fONKzqjEWujoE1fMkEseRIEL2BhtKYwrqw
 ROGTzKPgX7U+dQJadWtyTDg+HG83PwFUhG+r9J+XW1mHnMaJQAOBJm9aAves97BRpv1LWtWDP
 L2xo0YWI+8+BKdW88bVUa0v4CaKyy+ehKd5CE84Rx4hGb0eAuRXVk1gHFxmsvjKcZF7zPvpEC
 XbWVl07ZgGX3zKtuJ7ek1UsWIxL8aRkOiYly1ASk39Mti08ZEKTmxryRhBsgEob3x1Kia/jz/
 ZlXJdq68h8t/8o+1vmMuEMTXA5Mi3Vg4VBWgFj0eAp3bxnnMIxlimOh7t+/YcvQ2hdZ2MmWgV
 dq6cu5Kk6L4GwcwUQ73s+nwEymHiMqsJuSz1FD8UNfKxENYL5ugGUTrTMnRiFeNPViEICnirU
 Z6pslNlvsr+V40CiwJEC9nPnevGF9w5jugQpYRok1IATICb5/Snu38qH5d1rYxEJVjRl9zG8U
 6oYpHqwT2r2Gn1brtIFTYC3GYs9JHsV44E2k/wkFhJvZloyW5EVO+iygZHRbe/R3NWNIJpU/E
 0ONitVDZkvzaXdaKW4uhGUZRnVCP4sWH3qN4JZJzBjENelHJ4hYhhDgdNKd7AzuqCQUsATUzK
 5U7f2ChkahXBE7WavIWB6UyNCUp8wlCpq/Naspm1xzvvc=



=E5=9C=A8 2024/5/1 07:48, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, May 01, 2024 at 07:35:09AM +0930, Qu Wenruo wrote:
[...]
>>>
>>> I don't see how a compat bit would work here, we use them for feature
>>> compatibility and for general access to data (full or read-only). What
>>> we do with individual behavioral changes are sysfs files. They're
>>> detectable by scripts and can be also used for configuration. In this
>>> case enabling/disabling autoclean of the qgroups.
>
> This was my initial thought too, but your compat bit idea is interesting
> since it persists? I vote sysfs since it has good
> infrastructure/momentum already for similar config.

Sysfs is another way which we are already utilizing for qgroups, like
drop_subtree_threshold.

The problem is as mentioned already, it's not persistent, thus it needs
a user space daemon to set it for every fs after mount.

I'm totally fine to go sysfs for now, but I really hope to a persistent
solution.
Maybe a dedicated config tree?

Thanks,
Qu

>
>>>
>>
>> I mean the compat bit, which is fully empty now.
>>
>> The new bit would be something like BTRFS_QGROUP_AUTO_REMOVAL, with tha=
t
>> set, btrfs would auto remove any stale qgroups (for regular qgroups tho=
ugh).
>>
>> Without that, it would be as usual (no auto removal).
>>
>> Since this doesn't cause any on-disk change, it does not needs compat-r=
o
>> nor incompat.
>>
>> Thanks,
>> Qu

