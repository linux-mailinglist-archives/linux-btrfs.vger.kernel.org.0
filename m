Return-Path: <linux-btrfs+bounces-13198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1884A95702
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 22:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FB7189327A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906501EFFA5;
	Mon, 21 Apr 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="U2JcM9mQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C41EF37C
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Apr 2025 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745266203; cv=none; b=b7rCogPb5vSkDR2ARs9squPXGCixUU9DE+UYnzlyeYDHkJf+oof5q1fRWE4hd9c+IHISJydDdI+ZCeRUXZprWhWlJDSp/EDRT/DJ9hkNEiKEdzvUyKvTGxVqFH180v2zOgGQJ5WwVpmadagJcHyyhGMySv9dpy2iWs0oWaMvq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745266203; c=relaxed/simple;
	bh=kDjDGz9QkXGmwlsTo5EqvNzV2ih1ZV6XJSjl4/JwitQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tC9/+xlNJnM1L7WZyX4TiZp2ihHM0suKtlZ+canQh57j2s9cqrZuowRSfjrILn305Euts5Z6gXzqzACkXms6Nj3pKSD9vvkhiBPW0DVRYO9RYmezCvAr7IPuaKxxUraah2SW/U+d/K1HzsGMEhl5/ui39vhWzMwo5DywsZ/+Yuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=U2JcM9mQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745266198; x=1745870998; i=quwenruo.btrfs@gmx.com;
	bh=c2ysJKvMYXh3n9lguqLFRHjFe5iq9ZVwWkZ53S6B164=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U2JcM9mQScpI2YeKNmBeiITeyFIlge3qhRHCVMpaVAsvefnIsM8Qj5/4Q6NW8QcP
	 L6kTVbI5KyJBH1dJV98OdaHgnGubpXLoLe8J5nQcwEaX0pTS33syuztyfWnq4NKCJ
	 YXWMaBqkxw4Ns2E8Mcrfx9uitjm+K0W3j8o4CDk97RGhCk/6zYiFNmAnQt4IbeDGG
	 Gcy9iXuM+QFoIopZ5vxWYxfNJKIi0l85jpq3vwWBENWeQz3h8hSkntTIqnCygxZC5
	 /ceeWLg21/aPWDp8k6I+MN40z1BUZiHHP87IImrW7FTkeK0m/lrhV9Kom/JKpDq/a
	 tE0Pf9itkz3R49XdAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6m4-1upt8b3I68-00iY5M; Mon, 21
 Apr 2025 22:09:58 +0200
Message-ID: <c1c4d0a9-05bb-4c60-ae64-8c1ee9223cc0@gmx.com>
Date: Tue, 22 Apr 2025 05:39:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sleep inside atomic for aarch64, triggered by generic/482
To: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <d6c22895-b3b5-454e-b889-9d0bd148e2fb@suse.com>
 <20250421172906.GA25651@frogsfrogsfrogs>
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
In-Reply-To: <20250421172906.GA25651@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M9ZrvY9oRvkaA+b9yNu6x2zqqVz558bw90L9tLkUrDH9jPk3PTO
 +/2S1T22WYY+NcwgYL48L0xvfnJP9yQNKkJSJv20zxtPluZlhgy5GOjQP9UOgrjqlEEJTJz
 1jDOQYwU1lxXlkf2A1C8LfXn0cF1qpvUZFlh4LMDKrDHP8+p1XGqud0jovy0Bi9dOPmWN9Q
 iVcMC36tmsh6VcVyQd4Fw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A8s+4SayVyk=;q0ZlivBuMzGeczdDQ/DzVsewMf8
 cSmRB7FQVGo+i+pGcwPo0RBhZq77a8c4Df4LWo2+y+nv5oyp2I9ZNpaGsl9F1mjQTldBVPFdY
 PnmNXpKbebv42Vos+uvcCrFpj2cclJ3kzgJPuZkXVwzalifU6Q3T+BNBLeQXJqpnwt6zv5wID
 Q6n9DgJlB1RMwetvPtAhNwzjqlawH4LxPNlYQd0W5NsCqZ8th6bZaVwqYvu/WbBCHMzma7NWr
 oCbeWg8UDTlMLhlVFQeSn9EXX8x7x0nsK8nFtKzad4BjiPUwf/9kc87GeO1X3J7lS2tTjoCQD
 dcTCFB38njsSLQYIJE2Es/TbElL4psFhAybEvLAAwGJZ72ZLWXkFcLQ5Cv1EVK8sjX5sXX8hb
 E2dYh73UUAWIKhXFSQYWX23kiyVrE559o2mZbYIkRQHL5DITz3S+DYCLybE6wSOss3Q+BmQhE
 gyPq5vDxlfNNJZIKondK8582Y1D3I9Mq+wUQ1WnTIgMaHxHBr+3k0//ceigt0TmBe98UBNxlk
 PYethfWazTLMe8Bjdez8VdTHMgJ0eYFsWi6cMqfv/cei0iSUxpr0eV3GqcxHid/+nIRlaDtsq
 DPmVB52450f1tPpIjdBc+3eVB1EI6vn9LXKfZd6IRjcJfrLLDT+YA5xZOf+JGiMYOZx4YGHf5
 ZTl2hqU3eBJC6KnxV5/ul78SReQEKLvZQreDNKJn+h2lDrGO4xClUNy6UmjxkLEVm9Te28NOM
 isUOSFOgc9id8ubodF+hcJ2c/O6UPAy/QsJoy5EOPYSUiMnBb+/jmGWvZRQIgiJSfeUG8qWMu
 PpieDrgnZDdQDwV3MSROGs907/GQhBJt5toj+vPSJ+1zymDeBH1QyhdjY8ilFPNJ2PD1KDDNI
 KvC0rsEYCYRjM+5zPh91AAP185g6cPoWkaJdXx2C3uHFombRcS0xvR2aLOm20gAChTE2GxPRK
 hz9gFFzX4xdUx1mgKabFkgRVYeumHfboWx6IXPVF1xs/HyM09G8I0rsfXAl0M6xxCG+I4s52Z
 HYvp7JqyAy74EsKuFWLp+D/mk2ao3jlJGZ6UVmFe3/LbHBSda4V7BkrBzrUFWXp+YgLb6nKlu
 t1aUIZTI75GirkiE301CTfoKxjzZP4X9xJpVyPIvosdqAGw0djTZ89N9bjxY+j0SXmRcYd8hh
 0OtqpqmVXIMn7OAKE5oEEX3Tutvn/oU/79VXfWG77egr6rCvhUC4OI4Ge1Ro/EU6FqZjQ1OEU
 xuV2De6p6hq2I2sQbe8sq3H7twHI4qusAENRi0A3vAXMTon3SrRCDCvF6DjIuBQfn9pO3pbOd
 BdL4TfCP+NdxvoUvWJHIhHgA2UmiXFCc69puTex4SHdWAU1GCrZWxLJzdgK2Rn/tjMhomkw4u
 s3Fq/JpZcFnj62sO/0b90o0A+n2Rrynb+Gp7hTnAQTa3w+2r50MoXocUc8TUWwQU1F7kYySe/
 3rOO6kBx8jcbiWg9xVSrtvFd/6mXduvYvWPxe43Ebn0RYHO2pxL6q1Pwp19z092GtedUFSDx8
 VRPGk+XRbwMeytl+HdD9zfkYm80dOZmIr4FEEcTTDEwPbcQtsGEHR8V3S0INvcw8wh+Qt+DZ7
 rcNt9SCmQqaFyA+w9OGOWYR0IdG5ZJC8SUImgKJ1ZzgpOhFfOOgVBZ3IVFrw0ywKghezZ4MwT
 jsc1W8chYAVvMba/e+AX+CX7J83AqExyXFsmmudgMc8WlykZ/X2prfxJuBsfc4Qrcz7EoL+nI
 n1z10KnOGkZ75ZMcxOxcO04Jkx98mX/FccEROEXu965A/M+Vtirs7/31mmmUXcPJcsJGCNg4o
 lxf9I+GlDjdXl0rj0KdtCCLku/SqVlDTUDE9jGKZ3xb71e0BtWVO1c9iLGg8DM7Lwmo9/Rv2/
 4F7ShRxsUdSO6TJFfay/rXZADc22c/3eZuxkwU7wvSM49ZseYc2osqNOekK9GlbQxWTZe8+ty
 ukwBwwdlYk06JZ+C8D/jaRQq2ZK876EgdUKaKf3T1kjJ7wydjoR6H9U+z/nF/8nlN+nAzVtI1
 V/9LQcW3HOVrM4O2B49h4RvafvxLdekX3I4DLr/jLyxRWz70UJq14t5Tc70InjAe3gVWiY0n9
 M9PoZmyW6DW32TvM2MiMemKHhTun6lnX6OC8lqdBS90Hrbv+KavIS+FOSq1yLx8TckNwgZbft
 DdUnVtrNpRlgveoQ5PsMnVRAkiakBHTjQ+BE6Yh1va2RksVkc7pUtuKgAyKDXzgHjprKHJNSq
 BBKMfzlrngh1XJbjTCvJIfbMtrlnstPL4qFfZgRr8Z8ZopSGA+/KbgfgFxbAcWVzbcSPYhnfS
 5RaMkja9RGxNwCYYyMjrtWnCxqUF/PgP4UG7t6+d3rKA0MmWTdKFS1/sTA9+99YJubhujDbyu
 1FNxTqmLRLLNd/Rn+9nbYmS6+grGfxNhO218GGI0Uw71s4n7FM0tlXBNfuqF97Ual6WvHW5Vs
 33rJPVqECdlhjx3TbkNse9w4fwUfEAUPXwmtn3BH89VpkPse7c/Ooqq32jVrXLiH4TddnpyRC
 ID7tH8ZSaWFSeYykcDlUADDAb713nQyGEAlrVDOZceoi5WkcgoEafq7SW2RKXB8tiT4EhsTg6
 3iENZcYKrllGsPw9nKe8TAgPhUaYetReAUQB26FCVfpVuYgDfCyk0H9d5uHfJrXDwxzi2lE3E
 pSGDecCakXqXPv4tk89NMQRDf9DZkPQbGt5AWcV0HGCA0bt0Fw6Iqa376y02Cfxy6pkWvLPh4
 lzbrJWtIG+XYJTO7LCyPxCYjsrnfv/X4qZR4d3nQXydC5KYK/FCeUdND/jz5sQQboYZYqCC3n
 dyde+ytfKosmeTXwdKa5hGfkJ61B/VpUvmwGFvNq2E/AaWgTbv4IM6ifruoOEQOZJbD5PxqGG
 1dveCcpvPgJqJm4DmSDYzdKYM7nJEDUZlTH2EpYkS0E4cbh+sosflZ4PN6g5cMWngt802oTQp
 UWgQsggu8hDzKo8q/kDjTwpPQjEaiWGv5/FDZZaMm5SU7Yqf9ntUuvuZa9RtSkv7hxL5iBUf1
 LKYebxeAfBlVlaGvDFrpKkTH61DH7kPYwWm7UJg3P6U



=E5=9C=A8 2025/4/22 02:59, Darrick J. Wong =E5=86=99=E9=81=93:
> On Sun, Apr 20, 2025 at 08:24:12PM +0930, Qu Wenruo wrote:
>> Hi,
>>
>> Recently I hit two dmesg reports from generic/482, on aarch64 64K page =
size
>> with 4K fs block size.
>>
>> The involved warning looks like this:
>>
>> 117645.139610] BTRFS info (device dm-13): using free-space-tree
>> [117645.146707] BTRFS info (device dm-13): start tree-log replay
>> [117645.158598] BTRFS info (device dm-13): last unmount of filesystem
>> 214efad4-5c63-49b6-ad29-f09c4966de33
>> [117645.322288] BUG: sleeping function called from invalid context at
>> mm/util.c:743
>> [117645.322312] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: =
46,
>> name: kcompactd0
>> [117645.322325] preempt_count: 1, expected: 0
>> [117645.322329] RCU nest depth: 0, expected: 0
>> [117645.322338] CPU: 3 UID: 0 PID: 46 Comm: kcompactd0 Tainted: G W  OE
>> 6.15.0-rc2-custom+ #116 PREEMPT(voluntary)
>> [117645.322343] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_M=
ODULE
>> [117645.322345] Hardware name: QEMU KVM Virtual Machine, BIOS unknown
>> 2/2/2022
>> [117645.322347] Call trace:
>> [117645.322349]  show_stack+0x34/0x98 (C)
>> [117645.322360]  dump_stack_lvl+0x60/0x80
>> [117645.322366]  dump_stack+0x18/0x24
>> [117645.322370]  __might_resched+0x130/0x168
>> [117645.322375]  folio_mc_copy+0x54/0xa8
>> [117645.322382]  __migrate_folio.isra.0+0x5c/0x1f8
>> [117645.322387]  __buffer_migrate_folio+0x28c/0x2a0
>> [117645.322391]  buffer_migrate_folio_norefs+0x1c/0x30
>> [117645.322395]  move_to_new_folio+0x94/0x2c0
>> [117645.322398]  migrate_pages_batch+0x7e4/0xd10
>> [117645.322402]  migrate_pages_sync+0x88/0x240
>> [117645.322405]  migrate_pages+0x4d0/0x660
>> [117645.322409]  compact_zone+0x454/0x718
>> [117645.322414]  compact_node+0xa4/0x1b8
>> [117645.322418]  kcompactd+0x300/0x458
>> [117645.322421]  kthread+0x11c/0x140
>> [117645.322426]  ret_from_fork+0x10/0x20
>> [117645.400370] BTRFS: device fsid 214efad4-5c63-49b6-ad29-f09c4966de33
>> devid 1 transid 31 /dev/mapper/thin-vol.482 (253:13) scanned by mount
>> (924470)
>> [117645.404282] BTRFS info (device dm-13): first mount of filesystem
>> 214efad4-5c63-49b6-ad29-f09c4966de33
>>
>> Again this has no btrfs involved in the call trace.
>>
>> This looks exactly like the report here:
>>
>> https://lore.kernel.org/linux-mm/67f6e11f.050a0220.25d1c8.000b.GAE@goog=
le.com/
>>
>> However there are something new here:
>>
>> - The target fs is btrfs, no large folio support yet
>>    At least the branch I'm testing (based on v6.15-rc2) doesn't support
>>    folio.
>>
>>    Furthermore since it's btrfs, there is no buffer_head usage involved=
.
>>    (But the rootfs is indeed ext4)
>=20
> Doesn't matter; the block device can create large folios in its page
> cache and blkid reading the bdev can create buffer heads.
>=20
> willy's workaround in:
> https://lore.kernel.org/linux-fsdevel/Z_VwF1MA-R7MgDVG@casper.infradead.=
org/

Thanks a lot for the info.

However this also makes me wonder, what if the block size of the block=20
device eventually go larger than page size?

E.g. I know some vendors (samsumg?) are pushing for larger block size,=20
with that the minimal order will still be larger than page size.

Thus I guess we can not avoid it anyway?

Thanks,
Qu

>=20
> works enough to make this go away.
>=20
> --D
>=20
>>
>> - Arm64 64K page size with 4K block size
>>    It's less common than x86_64.
>>
>> Fortunately I can reproduce the bug reliable, it takes around 3~10 runs=
 to
>> hit it.
>>
>> Hope this report would help a little.
>> Thanks,
>> Qu
>>
>=20


