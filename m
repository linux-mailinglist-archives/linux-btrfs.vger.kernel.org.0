Return-Path: <linux-btrfs+bounces-1446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278082D6FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E721C2179F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35269F9D7;
	Mon, 15 Jan 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jp/n16HK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780DEAFD
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705313815; x=1705918615; i=quwenruo.btrfs@gmx.com;
	bh=xMrcaoZsVJpl0RNKKm3lSkejwLRg0ncpXdTj6cVk5MI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=jp/n16HKy3VfOsqyQNOAKZi3Ace9E+f/X1FZhqVMUcIEwTQYF6cCrM6q4hD5bq1e
	 ayO52p8Tr8Z88Hb2HZlaejqgVvqMkjsvUWvkfRA6HrZRpPk3VQ7Ui/aMYMrQf5ZV3
	 EhLcd3B+JJDf/hyldYbFQ2DFPzf3GQBs1m5XiYgsgCyiuu+c7zvxKxoLRB0qcpnVa
	 6JNHOnheSmNjvihvYi1fg8De3JcYf8Y7gkt0pZdSX0i0kFr9059SqLNt+TqP92cP3
	 Z55P8sH3gH4BsuhkqCvwH846tI6tzGJRsXuIpakw36qkkQRg56mQyAQ9xtpxpCPT5
	 EYDtiVsmf8113itUCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1qsCGV3dKj-00but7; Mon, 15
 Jan 2024 11:16:55 +0100
Message-ID: <2bbb7f9c-a8bc-4dd0-9947-f499560e5d23@gmx.com>
Date: Mon, 15 Jan 2024 20:46:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
Content-Language: en-US
To: Rongrong <i@rong.moe>, Qu Wenruo <wqu@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
 <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
 <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
 <794c3085-c5ee-417f-aeaf-d6c0ebd7d96f@gmx.com>
 <f8999f0745b2cddb42d3fbc16fdaf346b530c848.camel@outlook.com>
 <1b4f45c0-da2b-4817-8cdf-a07fd405ce9c@gmx.com>
 <50e1a0a0cf29f361426c0eb7005d389e4dd2833c.camel@rong.moe>
 <2e275902-dc1c-41b1-b1fb-998f7fd16de3@gmx.com>
 <0de1265ff914ff0fa772fad548c329c6d7f280b3.camel@rong.moe>
 <31a6c044-1540-4345-9504-2234f93aa150@suse.com>
 <3e0ba2b7-bbe6-448f-b4d2-2e7dde291735@gmx.com>
 <8a89a5cf-8d10-4737-bebf-f60f89dacf9b@gmx.com>
 <faa3ef680b68bc8facb1f0c4714f4722162bd691.camel@rong.moe>
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
In-Reply-To: <faa3ef680b68bc8facb1f0c4714f4722162bd691.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bJgalULlDlM8O+ex1O4iA5IHBtW/b1b/0w4bgS+drN8z02+XiS9
 aJRRrdJGbI6D4Wwx0dwuuKaAH9qx9xpPCUe1RQ1bToffm5h5/YxrGZQflyRVD3bxWFvA7Q1
 RbyoR4zq1MJ24IOxUF8APAMlonmCTLVmpEXVbqop3TF5KOtKgP8Vg8xjPK6Bz8LnWA+MDgE
 BoARsuJRQHoOmQsuLRguA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XdpFiapNjhg=;yfZop4NK1ZKaJxpWNx9u+6BrgKN
 GcY0oXevZVTjpZJQp2DyHRAOnDKQGnL4N0uzj7kceGqTO9YtKWxWEa2Z3tje4hKlqXvjp2CH3
 3yJ1kOoz3M6rmpnoQ1T9JLOX93rFZxj4nLSU3SQJ7y8qjhrtPFT+2K5nPbvHzvzU0c+1Labzj
 ger5ad3n/ls8pw0W5ysF3zatbfS6IqxX9yftsqOEskRJmqv5dniBeKKEaOKLrHmv+yMdSl7rT
 kP4QNxybu+Jfl7dBIuezxOUyQtxBkhwGmqD953RxUvxzwxqq9Gx5DqRhzG8hUraEaTIOxDmHm
 h4d5SDs/xQK+rN9Nj5cVJKBONoTwHrO0tEkbLLNzDt+Wov1LCV3FZscy4MY53i1dT9utUz/BZ
 NfOTk8e7xRs7Uwv6cKsYGGaEHoL3kacnBvRLCGmPNIX1qV/F3bmy4A4YnB8tWr3T0BmE2Snqg
 IhcXofpEX32abst+ZJjTxLgRYWkOsW4rNgYt3lqn6Ltrh+DDNyTNtC6NMKVD12Zias64dR1HD
 GOl5b2RHz1SDU/EMClIQ0ccSW1kCBS0UTR5axEQaH41zVV/IwwClqD6rpvgkh+l56wmy3JzKf
 eHD7zEXZXvWuEQ94EZZK4lcuYknpQ4TybXjogjeHV31JeHKGOG8wk5a8m33xxaZLC5NE7Ooh3
 8q4XhqEtdVR5a/JMbgPFqxOb8lpGtOIB/hwOkr5jsLhVqr4HF7zaSHDTnQYRVsNlp1IKj+8lC
 NT76fiqG24AkbdRNwKtW4YhO8NNx7jGcMp5m7iwqortdMKLgMLcyZ8y13ZK9tXTyUD1wfEjo5
 CSXFgJM8bJn85o36xRjwg8phjJgOWhcW3kZEd4Wqq/o0wZMY1PMdbFAoolsoaZqdb/rZYmlk0
 XP9jjZLw7cgigc5XmDwC63bBwIjlBPkHZG9pETOwQ0oFEA4lfjaPY1XBIcn1NenIuReDIqs3e
 JAfZkhFSHJdTFPxoHTdyESDaBAg=



On 2024/1/15 20:33, Rongrong wrote:
> On Sun, 2024-01-14 at 12:34 +1030, Qu Wenruo wrote:
>> Hi Rongrong,
>>
>> Mind to test this branch against your image dump?
>> https://github.com/adam900710/linux/tree/scrub_beyond_chunk_fixes
>>
>> For this branch, you do not need to apply to patch to disable blk plug.
>> As the crash is caused by bad scrub read endio (which can not handle an=
y
>> unexpected bio split, thus leads to use-after-free).
>
> Scrub errors, oops, kernel bugs and slab-UAF all vanished without
> disabling blk plug. Cheers!
>
>     Scrub device /dev/vdb (id 1) done
>     Scrub started:    Sun Jan 14 21:57:30 2024
>     Status:           finished
>     Duration:         0:43:59
>             data_extents_scrubbed: 21561913
>             tree_extents_scrubbed: 313432
>             data_bytes_scrubbed: 1128612171776
>             tree_bytes_scrubbed: 5135269888
>             read_errors: 0
>             csum_errors: 0
>             verify_errors: 0
>             no_csum: 0
>             csum_discards: 0
>             super_errors: 0
>             malloc_errors: 0
>             uncorrectable_errors: 0
>             unverified_errors: 0
>             corrected_errors: 0
>             last_physical: 1994106359808
>
>     [    0.000000] Linux version 6.7.0-rc5-x64v3-dbg+ (icenowy@edelgard)=
 (gcc (GCC) 13.2.0 20230727 (AOSC OS, Core), GNU ld (GNU Binutils) 2.41) #=
13 SMP PREEMPT_DYNAMIC Sun Jan 14 17:42:36 CST 2024
>     [    0.386759] kasan: KernelAddressSanitizer initialized
>     [  311.624759] BTRFS info (device vdb): scrub: started on devid 1
>     [ 2950.646598] BTRFS info (device vdb): scrub: finished on devid 1 w=
ith status: 0
>
> So,
> Tested-by: Rongrong <i@rong.moe>
>
>> Thanks,
>> Qu
>
> On Sun, 2024-01-14 at 07:53 +1030, Qu Wenruo wrote:
> [...]
>> Although I believe the root cause is the same for the uncorrectable err=
ors.
>>
>> And IMHO, even with the patch, as long as you enable KASAN, KASAN would
>> still warn about the use-after-free.
>
> That was what I had believed until I ran scrub (which blk plug disabled
> and KASAN enabled) twice on the original dump image without seeing any
> KASAN warning, kernel bug, or oops.
>
> It's confusing, but I think we can just look ahead as the
> scrub_beyond_chunk_fixes branch has been proven to fix the bug :)
>
> [...]
>> Thanks,
>> Qu
>
> I have some questions that may or may not be off-topic:
>
> - Is there any other disadvantage of having a converted btrfs with data
> never balanced?

 From what I know, the ext*'s on-disk layout is not super btrfs
friendly, it would lead to a lot of fragmented data/metadata chunks.

The ext* uses block groups (or AG? I'm not sure about the naming though)
to store their metadata, part of the bg is reserved for their free inode
bitmaps, and uses some tree structure to record dir entries and file datas=
.

This means, for each bg (some features may create fully empty bg?),
there would always be some reserved space at the head of a bg (thus
those range must be a data chunk), thus leaving fragmented space usage.
Which may lead to bad metadata read performance (metadata has to be fit
into the unused space of each metadata chunk, but you can always easily
balance the metadata chunks)

Otherwise I didn't see much problem other than fragmented chunk space.

>
> - Furthermore, the fact that the bug was introduced in v6.4-rc1 and
> reported only after v6.7 had been released hints that a converted btrfs
> with data never balanced has the risk of running into edge cases.
> Should we recommend users to run a full balance (currently only
> metadata balance is recommended) after the conversion, if they would
> like to make their fs "more stable"?

It's my fault not fully looking into the corner cases, but the proper
way to fix is just as usual, fix the kernel and backport the fix.
Then fix the btrfs-convert properly, really nothing special.

I'd say such corner cases should always be taking into consideration, to
improve the robustness of btrfs, even if in the future we would never
hit such corner cases.

Personally speaking I would recommend to delete the image, do a full fs
defrag, and full fs balance.
But I don't have any evidence to prove my recommendation.

Thanks,
Qu
>
> Thanks again for all your detailed explanations, helpful suggestions
> and the fix.
>
> Thanks,
> Rongrong

