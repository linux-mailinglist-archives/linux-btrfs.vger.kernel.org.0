Return-Path: <linux-btrfs+bounces-1268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB49824EEE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 08:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0072FB233E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 07:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D301EB48;
	Fri,  5 Jan 2024 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VYUM6nq+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B41D68C
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704438429; x=1705043229; i=quwenruo.btrfs@gmx.com;
	bh=7K7nwlv0yxy/AUGzQiZghHWhD4ygw/Bjh9p9y9GHKG8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=VYUM6nq+fA3uA80UUkDhlUeSQNW4oD+GZT9qfv9+AxvA+NKd6IgOCN+x693nIyTm
	 6Ek2xC7WO4Are/HSiRZPeCRA+n7a9znEaJCCi4WOusvrzgN3sN9DaTzpT2lrHOxCe
	 RB0z943KD1PVKfkkNZidU1In2ZiOnPFP4wfGOdD7ZwtbKdykPvvZ2hw21ufr8vZrF
	 ha6ORiriXPGNpmt4xBpth+URmGAFe/bA4OBtlQpZcwacrH/dD+yZUFE2uqrehTNys
	 FBkVGyUpYH+IX/2rrLGuJTBw8haijYMVRt8k5GqQaiapBybdn1B9c0CJw7f7uTWV/
	 sj5OfC6Tq6MxofakMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3mt-1rnRmy3det-00TWt1; Fri, 05
 Jan 2024 08:07:08 +0100
Message-ID: <494daef3-c180-4529-befb-325a46a3eeeb@gmx.com>
Date: Fri, 5 Jan 2024 17:37:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
 <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
 <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
 <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
 <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
 <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
 <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
 <513dfa2b00cf496e6f682508037616b6165fcc53.camel@scientia.org>
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
In-Reply-To: <513dfa2b00cf496e6f682508037616b6165fcc53.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BiMY5mKu8sw+np5+2AK7ZkJrrIW4W/6CfsB/fztgzJaLdZBR1yo
 raZ4JaJQvydHc1hhoVzZon3BSjuz326XKF2YhP/nZhKMI1MjR/CriH6YJ5706M9bphUIxex
 QerNEpengjgkSoSy7YQLmq+8MU3ncsgB4gVyHDOVEG5O+7GwRee0qDHrkAGqXkXL8WxZ4dG
 Dlw82L+eZV4507BiylONA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aOirBNgwBt0=;7jg0ISYxaqcFmi6kYOdO9K0YD9l
 wJ1/1xFA4E50BRyZuC7GOxcDctirx4hdSQ76J1bLv7ekT4l5hsawChDT52bmLOCOzuDE7+rFl
 QTbFlGB75luaV6gm+4LdaWMtbkhQzU3s/wnU93VY1o3si1FiAJBl1hVXXJOmaZ9GjqK0ONzvM
 4bg7OZRFuIeP/NHpT9JM/iP7+G6Yy0OF++qD3F/05aAzZJmGgmywWssEwWQDMoB1DognsTyLK
 TcKeqcgROHeE8s72ya5UtNjxL4CREk4e9hfDP+A17j5zPjfT+Njb44LRHsd0XAwQiCI6MJsUM
 mErzMJLw0F2XLuGwvTgViZc2iMdGOv0g0y2j3mxiyngNUlLifLPP/FNqjVi8ub/xCPnGECKqC
 QNol296DMB4fypkdqKW59XN5gNM7enzB1J/HHPImhHx9GBxlOFL/1KFar62t8cWCnyMa07PAW
 bJft8gF5koq4ifj3ItLhVlPsEc4n9mpm2i0MBOvtfltSrQUBv4E/VjOxYELS6jYrgwAmI/2LD
 gO4vjYBmFQFYnoK5xCrnxldMuUEzWhn46qz7LICbVULoPwPv+T2axEOAcuS3JtE9WsKjBvscy
 dk/KR9C2W7t+3l2nPgPN+h0R74qx5AGlkD63Wv5tEDdfWiugxPjgRH9TcIvUoEmZQ03c1S3uN
 pMin+B/nBaL/UK0UR+DgqDiAPvCV0ENtdVF1ZItWfLc0CqOEyvJSu/jBEkYRVb+6N/RER5QHr
 0mOrLO1wUQomX5b7gvKLMzSu9ITSg5XV8oNVBA9Xk+kwStBGmN0GMYHuy5jnW7JR5dv12iiUV
 /I4E3OUvBr/o4KBTViVteI1T6C20wFk/q2C47NMU2KQ4qojRKxUOsduMRiwOF2s/w7FlIa6aT
 dDQ8K0JELU1AbAzJitI5VLJLxIgm37GhfcTS0xdRb4yjkf+M8AlO43kqLi/pwgfT1wY6YB0xa
 JcB2R4fxjhUOovG2lIttRpxClnQ=



On 2024/1/5 14:00, Christoph Anton Mitterer wrote:
> Hey there.
>
> On Fri, 2023-12-22 at 11:43 +1030, Qu Wenruo wrote:
>> That's not a big deal, because before sending that reply, I have
>> already
>> reproduced the problem using 6.6 kernel, so it's a long existing
>> problem.
>> Just like the whole PREALLOC and compression problem.
>
>
> Just wondered whether there's anything new on this or whether the best
> for now would be to switch the fs?

Root cause is pinned down. It's very stupid, but pretty hard to find a
good way to improve:

   For that offending inode, it only has one extent.
   During defrag, we need to determine if we need to defrag one extent.
   For this particular case, we choose not to defrag it at all, the
   reason is:
   - The single extent can not be merged with any other extent

So even if we're only utilizing a single 4K of a 128M extent, defrag
choose not to defrag at all.

But this rule applies pretty well for really fragmented files, thus I
have no good idea how to continue.

Maybe we can add a new rule, to add very under utilized extents to
defrag target?
But I'm sure that may cause other corner cases to be unhappy though.

>
> Also, do you think that NODATACOW would also be affected by the
> underlying "issue"?

My previous guess is totally wrong, it has nothing to do with
NODATACOW/PREALLOC flags at all.

It's a defrag only problem.

Thanks,
Qu
>
> Cheers.
> Chris
>

