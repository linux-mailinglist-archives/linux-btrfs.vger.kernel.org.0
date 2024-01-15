Return-Path: <linux-btrfs+bounces-1456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B9F82E2B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 23:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A139E283B62
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 22:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C251B7E0;
	Mon, 15 Jan 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="clxxpwiF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56546FBB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705358607; x=1705963407; i=quwenruo.btrfs@gmx.com;
	bh=3iSnT+BIH/rDD/zyvqxOzLTtywPl8XrLsEVHj2Ijqgs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=clxxpwiFjfrI8F8C5tIgRIT2FrP2w80+WZODSmv5cZHNMVMA76u04ngS+cPpnPFP
	 3H9/meriGIBcQoiveI9dQHlSszWIcM6rjSr9PZR3CwF9z6uhU8TG7t3j9RdPa16qA
	 s6EaLq7ZqZU3C7q1hXVd9nMHkVG07fZZ5ld4az/BzG3TtHQM8CE/nfRJVzSHqDcd1
	 Ce6bLEI8pP0EJsFItN2LBww2J36jarNkPytg/GewAk2ipzO+LVDC371Zh2yfZIN9u
	 MtoGHpUZMz8h2LGVMnneyFc7ViQLsJnbP2dKKIfpMIMcHimSavz7DK57XCvY1DcBb
	 wAirtSEenICx/IHPTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1re6gy0Cop-00YwTE; Mon, 15
 Jan 2024 23:43:27 +0100
Message-ID: <c31f1082-82f5-4558-9795-db1b40079f91@gmx.com>
Date: Tue, 16 Jan 2024 09:13:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: tree-checker: dump the tree block when
 hitting an error
Content-Language: en-US
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <a5ab0e98ae40df23b3bb65235f7bd9296e3b0be4.1705027543.git.wqu@suse.com>
 <20240112153602.GP31555@twin.jikos.cz>
 <7e908c1f-d14f-4562-ae1e-1431c091b140@gmx.com>
 <20240115145438.GT31555@suse.cz>
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
In-Reply-To: <20240115145438.GT31555@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V2p6TFmceQUVATqL5FxvSyaiumCDqBLxyBYmgYz8UAlB/p/8IH+
 rIYmjNGYlfVIv1MYe/zhNvKhcbwFLN+ai6dhMNYgMijr0f5iuroFQlD6zJfvRK11m2vAoEt
 5X5X3+e4y2IOSGEtEdyALIrOsrHbnxHLYy9BQvONb+uCtGZ50yNaN0ppBpg/cFnYl0UTU4A
 jFwjjE6EAJZ3BPFos5EOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XzHpfMyIink=;u+T/9AVPISouApaUhfH4l1cctL5
 aIh2bma4Gk+53/QZWawKtrkIgDfrKpH3X6qfJXS0V0kqAdqjqBGfkQxkx6ErwrpRaumB94uEN
 Vn3geM7shUk09FcuKp1v4o2aGAkk9rRxhmLB89iWBbILVd2npnSA6/sqWKSrLL4gNYyYTF3k+
 ikfE1KfJnGj9Xd2oTuS1vE3yU0Q1WVjQLrGBJdbSMMPicHWiGhKixiQWfJ6bKhDmE6/xeae6/
 eoaRwT7bCz28MaWFyRA+trl7fvnvvP4giLgq9AUmby1IzNYFpdnSS/ukJHjCyueaGHSBB0G7m
 EVSmbmjf7XdL77Dmn5dT8wBJK7ttP9GKWkk3sIDci8DI78uOdZIOlod6WkC9MNIMwNh7U+EIk
 pTF7DXJDtA+BeX8vb2yoGmfLxk3+DQq0+fVWXb7pv7gih1RNvpMJ7C6qdNNA5rasDlsOCEAv3
 kiYvgry/q1+BoURyaZhXQL1Nix5p/7A1rDPfnIq3ho0Yswt91Q42IEvsfFVR8zRwUfnvPfvjB
 6GlHQ1fulMqLtVX84EspSww1dFF9iw+LsEXBmd51sxPJZ6sr3LkLDDs8yKB6BM1kjZSKC01Yi
 CqHpKRu2coszPnHM25dGFdyQtC8K1wvUgmgmbEOCI7INX7d9DYUTfPLXDgRM8vsZ0nkWdl+nH
 BSMW37iGjhlK6I7NXHqoa65upQS+aEyodn6bhJOYGcHmu7uwHlDcbsQvsF0uaHXNIyZ1JOZJZ
 Yn3PRL/hiDzE/zZ6pfdhWUp1qOdqBh+4S5h95Jk7rIynNZWCzo2JRRWwVTZQbXvwtGEdqFpIz
 T3DbeGbJXA36r11Z11C2HbnZ7f610n3jlI7d/Po3EHTD9cvfsqNVUdbyl+4UhnN9wlT+f+9h4
 9sY0IUrgTPYBN1dGcq58n2QQgijEFVcLZM6teByS1Dn+YMgMcNC74VnVUB5GDLpsPmC+bKeiE
 KO+16Aa/UHkDeNeurCX6jiIfmzg=



On 2024/1/16 01:24, David Sterba wrote:
> On Sat, Jan 13, 2024 at 07:03:18AM +1030, Qu Wenruo wrote:
>>>> +	btrfs_print_tree((struct extent_buffer *)eb, 0);
>>>
>>> Printing the eb should not require writable eb, but there are many
>>> functions that would need to be converted to 'const' so the cas is OK
>>> for now but cleaning that up would be welcome.
>>
>> I tried but failed.
>>
>> Most of the call sites are fine to be constified, but there is a specia=
l
>> trap inside bfs_print_children(), where we call extent_buffer_get(),
>> which can never be called on a const eb pointer.
>
> Oh, I see. We can't remove the ref update but what if we reset the path
> slot to NULL before releasing it?

The other solution would be, only consitfy btrfs_print_node() and
btrfs_print_leaf().

For anything that would need to traversal the tree, still allow them to
modify the eb.

I'll give it a try, and if it passed compile, that would be my next step.
Would this be a good idea?

Thanks,
Qu

