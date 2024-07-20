Return-Path: <linux-btrfs+bounces-6626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74742937E88
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 02:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4F2B212FE
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 00:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72E4436;
	Sat, 20 Jul 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HrqDjFNt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF223D7
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2024 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721435479; cv=none; b=hZThZPd3sx9sbUC8bfH7rZu2DENTLAvSDLwr1yo1W7jIq09Y2IH6rORgvZCFFhPACTSlIhzGC3tCGfNAAc6OrhGph2uhiYOCh+7fU0wWvNjftZRWzOnc6iuv10cl4Gin29inG2qXCg0CVC53wCHwZENkxgWh+BiD5F5mg8zzLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721435479; c=relaxed/simple;
	bh=SB+rioVI+bKmWiCWmHqQwXvp0dZ3RYZhLJImalcM9jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDYO4GdTnbzh8f9fPTgPXYq/j+MViqPemXhWESTKctVZOBx98Mm9S3dex03+Pbxfw2j5A814UJNlwdj/KzNWGbVLthRJFdm/cRrOqIdQg2Z3LISrE6id4zP8OYysh4uKig8eKi+DBkFwTFMczAIxYsnjgaFCpnhUVqC6mtEPxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HrqDjFNt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721435464; x=1722040264; i=quwenruo.btrfs@gmx.com;
	bh=cy7uqiZdV7tljOiFFd262Okce1IItZgnsy221c3/sJ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HrqDjFNtUdANkPMIPhlu96NuM+QxBtPGe9CgVRfzOIwy89bxAKlu+5rI958CUrTk
	 a/so9CPTNzfZrb/K+HIK/p5u4iBfIjOgLFsoVZ8i8iu1i6ZDc60RopDsw9gltHVKR
	 NsWV6jwqZcd2YWvTh3ZlW4rxMwbHhUDrhAA52mnQrAfXQstVjfX7+nIfQfq4b+bQ7
	 0xiFZ0PrVycCWow/yKXgXMhdES78cbY+gdT2/CYICfI9nG9M3Hajuh6xWXik2j6u0
	 zWncmUJDVCrEaB0nLC/5fXsspQDHcc34vghjqA8CD8vlqYdBC4MvRHJK9OeOxH4Wk
	 Vgi/PUlIVaGneTuQqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmfi-1ssjFy0JTO-00OPsD; Sat, 20
 Jul 2024 02:31:04 +0200
Message-ID: <05c6a4a6-5dde-48d1-8876-e625dce9ce02@gmx.com>
Date: Sat, 20 Jul 2024 10:01:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid using fixed char array size for tree names
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Sam James <sam@gentoo.org>
References: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>
 <20240719235328.GB23446@twin.jikos.cz>
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
In-Reply-To: <20240719235328.GB23446@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EG3JOo1haS2iV2JAId4OSGUb2ZlHoaZVuwgtyAgpPG50Q66KeyZ
 U5BrZCcAWD87oiAioFUjVLkzxHxe/Qg4oY/BVbiFz/yeG3ZXVqA08cFxr0z8Pqs+ZYfCuu6
 934heLlaQtRyTtxvAWtEC12LYCvHsccdoi9kFsLVC6Kv9BJ7DwBUxiWDpjjj+3VMx7lnrph
 nh3FotgySmX0HZkH6aS7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N++qoWqSOwE=;UT2SigtdsJtbt5lWVOodCZRSHl+
 n5ePvW+LS9CWnXpeq9u6MbiTwvHK+YzoK5tgq6HIA17Sz+/HsBeYMDT/IxtYUrwkFojfYlcek
 LfgQ8TPsaTvBWbvrPPiYjQGTTDkOoMnBsNzogngC7IL/KZGftx82PbjV0IPbuPckqpaLa0OjV
 N135/dZ1urVxCjgMsF+terhysZG9h5A9qAPAngnTFS37GK5dx4MbJTl++rTqSm0rfVV69Deg+
 RcJToP7CEt/TS3OBqCfSrmAuKydP/oCyln7UhW0dJTTdg5mW7EfGRV4iZl13OGZl4+Ckf76RI
 QM3fYGaxqwlO2d6F/Qyq5CUgWifKkaJup56aM68x2e/Uhsv8OW3FEt5lJhzL957jz9bUooe/d
 Q+OyAkTGZiK9yp16taRAB88oTa0WvuP8obr4AZUvBds4eUc8BtwL6nv2FdRNlnK0puunmqxy0
 k5oTpcrHkmoBXXBw6wB+qKPvp5ouKWPOTKj+sm3AqU3oPTMMkYGhfxnDOHqQZsQScP6HNQzy0
 JdZZkAj7HvzA66PRgdBhxYfRIQrnm96tVxWuCfXfYWJQSDUEKUwtRsOUp2EubGMPncNZ+8Em0
 YUHIbVZWwdwuZ6db4zvC1/0f5hdACM2fCrd7jIBfEScIIqBa4royc3a5ON7KLy98aYxoK1vxa
 Ov8IKn8Lr1t814wV+5xLv1Jb3q49A7SyILa144f3LXsIkLYxUpUzLyIxdtcYK93XTCmWdjcCX
 iTP9FedtzkKy5gUTteYUqom3w6qACnTzDEjaKa9tY4h+mXKSO/0ZRUQDPjRlvuHKkdyf9YIuR
 BZXihVgOBIh49DkrpgOTriQw==



=E5=9C=A8 2024/7/20 09:23, David Sterba =E5=86=99=E9=81=93:
> On Fri, Jul 19, 2024 at 02:20:39PM +0930, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that using the latest trunk GCC, btrfs would caus=
e
>> unterminated-string-initialization warning:
>>
>>    linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for=
 array of =E2=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-strin=
g-initialization]
>>     29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_T=
REE"      },
>>        |
>>        ^~~~~~~~~~~~~~~~~~
>>
>> [CAUSE]
>> To print tree names we have an array of root_name_map structure, which
>> uses "char name[16];" to store the name string of a tree.
>>
>> But the following trees have names exactly at 16 chars length:
>> - "BLOCK_GROUP_TREE"
>> - "RAID_STRIPE_TREE"
>>
>> This means we will have no space for the terminating '\0', and can lead
>> to unexpected access when printing the name.
>>
>> [FIX]
>> Instead of "char name[16];" use "const char *" instead.
>
> Please use a fixed size string, this avoids the indirection of one
> pointer and the actual strings.

I strongly doubt the necessary of avoiding indirection.

Just remember all of our error messages are some pointers to a ro data
section, and I see no reason why we need to bother the indirection or
whatever.

They are the cold path anyway, so is our tree names.

You can go char name[24], but without a proper macros checking the
string length, we're going to hit the same problem sooner or later.

So, I see no reason bothering extending the char size.
It's not extendable, nor safe.

> For static tables like this is a compact
> way to store it.

Nope, it's not compact at all, for shorter names we're just wasting
global ro data space.
The const char * solution is really using the minimal space.

Thanks,
Qu

> As the alignment is mandated by u64 the sizes would be
> best in multipes of 8, so 'char name[24]'.
>

