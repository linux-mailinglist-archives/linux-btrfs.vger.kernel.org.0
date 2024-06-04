Return-Path: <linux-btrfs+bounces-5452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4178FBEB4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 00:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AADD1F25C47
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 22:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BA414B092;
	Tue,  4 Jun 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hrB4SN9J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FE2AEEC
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539419; cv=none; b=gZHcWRH2lM0rW+LiQpPXwFpj/IMQUlompgANnTVKjqgsfU/BZ8HuXuGiMKk1P9psvK4UAAFXKBtsZocOXGgjT7LOTtfcoJivzpa49K/9aIiyn98gCHvgK20+D0nLCuuwKfuFxJuq5+gsQt+WW+/YT5t+gTBnyUNTOH67Fd0oWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539419; c=relaxed/simple;
	bh=WxqhxVV+Qziz2Thhe+S1GVP0obdMXC1Ff8U974uuNgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJO/7mcMlaOrddYgDq8IQt6vvBigKVPz6X7EGdO7Lpb/grroNMQHbK3XK834LmqfpVGun41W0x0L2KEFzZKWYRUgpCs6/p7oOpbT0z+wF+wv+uSfmTgLA5c2X0R6hL6x8o0+L/Noj7PNm4Aa5JnUJ8YOPVHr8tH72gc2pp8pZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hrB4SN9J; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717539414; x=1718144214; i=quwenruo.btrfs@gmx.com;
	bh=tnaWmrdJvaLJzYrFjmDlf3Ot735RnoqZJlCcSrUl9xM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hrB4SN9JrU4qR1c60ITF9xrpvk0ZRmmY9TDQ3H6qL1rNH0XnpgAXBkZ67eZsNtc5
	 C5Wo33fNUuujjjdQy8KOWA8kKHcRWWy+wBxU4l0ssVrgN2ZdwdACH04ju3K1qSV4A
	 G7v4LjeCjCKglbvzd0lOxD32a9cM7zJffnJ/IlxP0Z3ftaN/LQOjmhFyWEWyrIepe
	 WImCMnpa9HYlY/Ntr3T/Yw9D5rHKNLfNxk2EI12P9QTGPAcoSaKO+fo5DU44IwRc9
	 JmoxxQpYGGaY6sJ3n4CyfMxVVemoVIQal19BJ4jk/NP8+tbAy0vA7/7r/K47maOmc
	 8PUZfqF56T44n3T5UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOA3F-1rqCsu18sj-00NDCW; Wed, 05
 Jun 2024 00:16:53 +0200
Message-ID: <c53aad22-ed68-433b-9dcc-c52f1c2fc73f@gmx.com>
Date: Wed, 5 Jun 2024 07:46:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: print-tree: do sanity checks for dir items
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <0279bccaf02bbc09d6ac685b37e36aacb60bf9b0.1717476533.git.wqu@suse.com>
 <20240604155813.GC3413@localhost.localdomain>
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
In-Reply-To: <20240604155813.GC3413@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sjdgt5V/tvVxzW+HqThfEEC0+O+SJYlv5BLHntb/vaI5y6ZS+5i
 uxsj4XdJipFpBduOx5n91jzRFW4n6Y0yh8PxH6BSGV+XRNsbJ25FAFPqrPTuMZ79qjmnWEO
 iGdHgDRDIJtHpLG0EtsjJX0d91z5I4KTXfP8exO9vxBQJZYpX1HlpVf/MrLw/vkNxvW1vP6
 XeIU8yBtVv6o+G8LHI1Tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:79ATUGJmvKM=;O3U9cVwQ8Fg7hU/e5Jt9vg8C9KG
 R0toa5I761XwH+E4DDKzvPvXOD1rczwqPAGzYMLxtLLZzORD8VJIpEnWaskEPCddM3TTDDOum
 4iOE4HPBY1LeAB8Fz2n0hJIag4Un+LkbXiv5offPp6WN3cmr0VuWC5LpNo+MVwaOjyEeWnb16
 rjw7fMv5cAUrI3yHLFa7FPQruAGB1VslnFC2S6SM4kYiQ/Ce5yXems4kXMwPeNw7DaDVJHYBl
 6uaeNP3vOMm2y8l2tr3j9t4wPvXasSgkpr+1Iw2g+/g9m+dhC7fMuELD0hIqg5KsKnRYJwrC+
 X5teF0Ee8Mm1oosgiOmmdJdKzgXR10fWNmerlAhDk9bUs6Z0OJBNCYqfWQqekWSvI/q2uvRyz
 SclvWbwNRLEbbCJHq3W5HTGd6lVe8aQYW39bPpaBJgdp70FRPhQ6guISu7skAF7sg1Gnx7KC+
 yHdGE4w3qH9hNuDN1jvSZ4HZ/AsBiqhwnJXh5897Ntjy7WBe0dMApk5cHvXoKRS6rPYrva8gB
 Xs8/6byxBi6LpeUBXD0qLPzTp5To4J7y02ayVLNQ5thPouF1AiAjCrmbKYniOAP69EO3WiWdw
 5M2xMs7z8NnxX1tumSFMM9B4S4JKH/wIVn5zARw2fEX+69i1V+Si7C4iegpt0QAa6l8K2K4yc
 OZt0Ez0FBN/SQqO1uEGBqb7QknROSFwEX6Qny0zOp1vWcVyfbe135eUa53nNdgUeiaa6K01nJ
 BIj15xTVwT3UZ8iTtLRd14SSJjqgr5Y+BIMjblNUS1YhgvBhqWzvg2ZvszjMdA4YAiCRDjKYT
 BTfTYEAummTUvXMLY/WWOg6r3C8a2q8MKLvN98ezBiS2Q=



=E5=9C=A8 2024/6/5 01:28, Josef Bacik =E5=86=99=E9=81=93:
> On Tue, Jun 04, 2024 at 02:19:08PM +0930, Qu Wenruo wrote:
>> There is a bug report that with UBSAN enabled, fuzz/006 test case would
>> crash.
>>
>> It turns out that the image bko-154021-invalid-drop-level.raw has
>> invalid dir items, that the name/data len is beyond the item.
>>
>> And if we try to read beyond the eb boundary, UBSAN got triggered.
>>
>> Normally in kernel tree-checker would reject such metadata in the first
>> place, but in btrfs-progs we can not go that strict or we can not do a
>> lot of repair.
>>
>> So here just enhance print_dir_item() to do extra sanity checks for
>> data/name len before reading the contents.
>>
>> Issue: #805
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I'd rather not duplicate this check.
>
> Is the print-tree coming from repair?

Nope, it's "inspect tree-stats" subcommand, it's just really printing
the root of each tree.

Remember we still need to call "btrfs ins dump-tree" to analyze fuzzed
images, if the print-tree is as strict as tree-checker, just image how
miserable the life would be.

Thanks,
Qu

>  If that's the case then I'd manually call
> check_leaf to make sure the pointers are all correct before calling prin=
t tree,
> otherwise if it's from a different tool we need to make sure the strict =
checking
> is happening for that tool, we should only be bypassing the strict check=
ing for
> repair.  Thanks,
>
> Josef
>

