Return-Path: <linux-btrfs+bounces-828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC580E096
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 01:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91461C216CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6A7F7;
	Tue, 12 Dec 2023 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QpGcOVlE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D26B5
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 16:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702342730; x=1702947530; i=quwenruo.btrfs@gmx.com;
	bh=KNdEr8lHKI6TfeJv9e82W0eRFuKXpNJmp1+AzRRzkEY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=QpGcOVlE8d9maybqHo9yenKMFfojluNyOMZ1yHG30EbMVCDBpB6hGDgWdsUilzyz
	 TZOSvRTkofeD417dtaaCwxH1+NRgq5m7PZR6LAavKuaqFkkk9/BT213ckmkP+BeSV
	 cOn2snCZmR8Ty2Yi2sxgtBi07B+yJPUER9FHrbsAWrElV3dg8OY7dRuDLytwD//hP
	 Mu9BchdDAig/UmRS709HPAP/Icb/tv/NzkK54V2cboGIlu3tv5Yz/faJ72s+n7Wnr
	 OqyUy6IlJR2BqDotrikBwXherUtEYEMBucFmMRgF4CRFxJYRFQsNSFeG3U/eQKRE/
	 v2xIAAgYrajdgEUNhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4QsY-1rJuPf0sT8-011Uqb; Tue, 12
 Dec 2023 01:58:49 +0100
Message-ID: <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
Date: Tue, 12 Dec 2023 11:28:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
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
In-Reply-To: <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MCDt2nj9u9fO/+kFMQqK25V7LKAMtk3kVeTI7zIXzQ8jQHJvidJ
 Zk6jMvAiwszlO+Fxmki/GnLTPsXQtExEm5W26EOGxOxIOuqOvPibMMmL7YyqFgaWeTiFLMZ
 BLUeHZ1zd/1wzcjYaUt4+yeRkQkroLA3Of5n5FB6LTEwaDZsawIuPrbGckfup3OjLD0KiMS
 H7ccFJHIKlbvIU6o203Vw==
UI-OutboundReport: notjunk:1;M01:P0:JjQssFqmG1w=;eLEUcNNZKs0pJl3oaHOyCWbdLCd
 lOY2qmlmfP1LBG8SC7F30fVgAMibtDHvaeVCRBVPpkxbL7pcwBvS+dYCbITrDdADITACMeT74
 3hRpNXZZQt1JhY4FweVWmdhsSNybRIdGc5bRcTxRNLyEQXruCFmMtFRn+UAira27uNEwwKvU3
 hDx3WBYeC8yIWthsvD8A/y9A3DoKgu9w8b0uoQcgUiW8ELMhjOmH876Gv9Pbmp5T9Ii/Ja6yg
 mhVbCqekBDuStqpo7hvbiVGwTpWTBjZJJ/9PjfWowg1ym6M72fHKZxFoUzuMktLuxuMV3LvCW
 F+MH+i+yy6OtFcbkAcFHjQ0hW9GT2Kpz6DQ37bZIaNuCepWuAlQ81cCN6GinTLx6zwGkitNMv
 R+v+2vbPRi9rMbh2HAQvHwToqweiT2BNWHfayAhp/gi7rRXJEdtAmBj6Og+KdYXMLBvxpBMM9
 eaTA/3UHZUgzPS3mWTXT0WHqTA2RcVjr92b+5eGqYCL16TJnwiqlFd4+OIg7zx7nkFm+aC97e
 7MLUkTkpOaZcoljcHqn3jgQVdIXScAZJsf0hxW/00YMJULLcWGbYS+vrCdUwYSTSA1LzyU1pH
 9PNzBIBhWyiI4Cd4oq8a6lqIKgDJRdFOTPHwzebKQMpDI2lh0jPwvpkSXZJFvGn9vDwT0y4rL
 wmw/9TIn5NAIgxeYX/NL0FL5DiDsekePIRZCSQxj0qfCNdMlohlsPqFytTDtd2OEdlz8OvfaH
 NCYVB4CWAzofCYibDmZUN4QpAkCgWN9dDlKISMoy3woxicxeV5mzB4PeK0fZWfVjg62rK7Pch
 2zqaPox4+J3PgQBL6jZqCeOqn2Ktw19R4XX9dMSr4vEpw2PxlIFivOu8VDiJfEXR3/0RFtI/u
 XhhxxqRA78XvFP8UIC9KYpJdsOmKz9ZZfyLhxafHV70j3RkBljGDVWHdKR8gDzdR2AhBEUbjT
 cZGaLa6DSCQf8siBxO7hQqkNFmE=



On 2023/12/12 10:42, Christoph Anton Mitterer wrote:
> On Tue, 2023-12-12 at 10:24 +1030, Qu Wenruo wrote:
>> Then the last thing is extent bookends.
>>
>> COW and small random writes can easily lead to extra space wasted by
>> extent bookends.
>
> Is there a way to check this? Would I just seem maaany extents when I
> look at the files with filefrag?
>
>
> I mean Prometheus, continuously collects metrics from a number of nodes
> an (sooner or later) writes them to disk.
> I don't really know their code, so I have no idea if they already write
> every tiny metric, or only large bunches thereof.
>
> Since they do maintain a WAL, I'd assume the former.
>
> Every know and then, the WAL is written to chunk files which are rather
> large, well ~160M or so in my case, but that depends on how many
> metrics one collects. I think they always write data for a period of
> 2h.
> Later on, they further compact that chunks (I think after 8 hours and
> so on), in which case some larger rewritings would be done.
> Though in my case this doesn't happen, as I run Thanos on top of
> Prometheus, and for that one needs to disable Prometheus' own
> compaction.
>
>
> I've had already previously looked at the extents for these "compacted"
> chunk files, but the worst file had only 32 extents (as reported by
> filefrag).

Filefrag doesn't work that well on btrfs AFAIK, as btrfs is emitting
merged extents to fiemap ioctl, but for fragmented one, filefrag should
be enough to detect them.
>
> Looking at the WAL files:
> /data/main/prometheus/metrics2/wal# filefrag * | grep -v ' 0 extents
> found'
> 00001030: 82 extents found
> 00001031: 81 extents found
> 00001032: 79 extents found
> 00001033: 82 extents found
> 00001034: 78 extents found
> 00001035: 78 extents found
> 00001036: 81 extents found
> 00001037: 79 extents found
> 00001038: 79 extents found
> 00001039: 89 extents found
> 00001040: 80 extents found
> 00001041: 74 extents found
> 00001042: 81 extents found
> 00001043: 97 extents found
> 00001044: 101 extents found
> 00001045: 316 extents found
> checkpoint.00001029: FIBMAP/FIEMAP unsupported
>
> (I did the grep -v, because there were a gazillion of empty wal files,
> presumably created when the fs was already full).
>
> The above numbers though still don't look to bad, do they?

Depends, in my previous 16M case. you only got 2 extents, but still
wasted 8M (33.3% space wasted).

But WAL indeeds looks like a bad patter for btrfs.

>
> And checking all:
> # find /data/main/ -type f -execdir filefrag {} \; | cut -d : -f 2 |
> sort | uniq -c | sort -V
>     3706  0 extents found
>      450  1 extent found
>       25  3 extents found
>       62  2 extents found
>        1  8 extents found
>        1  9 extents found
>        1  10 extents found
>        1  11 extents found
>        1  32 extents found
>        1  74 extents found
>        1  80 extents found
>        1  89 extents found
>        1  97 extents found
>        1  101 extents found
>        1  316 extents found
>        2  78 extents found
>        2  82 extents found
>        3  5 extents found
>        3  79 extents found
>        3  81 extents found
>        6  4 extents found
>
>
>
>> E.g. You write a 16M data extents, then over-write the tailing 8M,
>> now
>> we have two data extents, the old 16M and the new 8M, wasting 8M
>> space.
>>
>> In that case, you can try defrag, but you still need to delete some
>> data
>> first so that you can do defrag...
>
>
> Well my main concern is rather how to prevent this from happening in
> the first place... the data is already all backuped into Thanos, so I
> could also just wipe the fs.
> But this seems to occur repeatedly (well, okay only twice so far O:-)
> ).
> So that would mean we have some IO pattern that "kills" btrfs.

Thus we have "autodefrag" mount option for such use case.

Thanks,
Qu
>
>
> Cheers,
> Chris.

