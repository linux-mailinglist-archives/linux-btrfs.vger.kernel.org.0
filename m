Return-Path: <linux-btrfs+bounces-1067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A177481936D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 23:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565F41F23587
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753793C6A4;
	Tue, 19 Dec 2023 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EIVwWWoN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E93D0A7
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703024422; x=1703629222; i=quwenruo.btrfs@gmx.com;
	bh=VoG8g6A/cUgViMWbscxxZvmeE6Lt7T/Ric48DSK1SRM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=EIVwWWoNY5Qsea/ApsHNB9rQ4UY4u3q8RnEyJZ25t2d9ZaKkTLzci01/ockPRId9
	 JtbgfwK/YpbIIESIE+0TqxRmnOrrl7dHSOM/wYnRK4l/NrAu0XlzTgMp2svaUGvbL
	 UPmy4eeYkkCVBurX1NtWx+DY/PZ2o6ZdcA/csfgx5cz35NVigPG1xl2XtWaWjhPLc
	 mW4OJlHROkNbSsW/mTjv0KZKbFKpenTaVfEzCir9T1A9fjIwPMUYNnt1ALpFhV7WN
	 d9OdGNsBVJTkbIIWlAdzeViMsZaqa9w0yu3uMZtPCTAr6cOTyvZHlXtaiB1cup4Au
	 woBtqgwzF+dCGauuFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([115.64.109.135]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fmq-1r9Mlh1LZY-0121Cc; Tue, 19
 Dec 2023 23:20:22 +0100
Message-ID: <0f6ab509-2403-4ab6-af3f-d5beb559b450@gmx.com>
Date: Wed, 20 Dec 2023 08:50:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Logical to Physical Address Mapping/Translation in Btrfs
Content-Language: en-US
To: saranyag@cdac.in, linux-btrfs@vger.kernel.org
References: <000b01da326e$b054cdb0$10fe6910$@cdac.in>
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
In-Reply-To: <000b01da326e$b054cdb0$10fe6910$@cdac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y/BmMVMV4XPy7GKYyhdt8EVWq4j4t3+WdHMntr8cXBbnh7urwTz
 bqz7RyPl0YrZAGqMC/RUI61+joOovA3I8/RlAHP7SSmXfXyWt5uzAb//yge3qLTRLv1yhQj
 B5VoytiJ1/HAlmpaCEVTM+HGZ6JOI9EIA5BzI6CaDa41BUdr6Fgyo+QY7DJ7hitngXNVVll
 UijS8pWYGtHncK8MyCdnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WrmrKCxh9gQ=;2yz4wbYyCO/s+Onla1uL8Gox3NR
 CSIEJM0Ushg0JYco3JT5t2t8XcdNrEljexiBFptLyt0B/RuuV+6+IULmid8OMcv8atrMXa8NH
 IGBLS8Rc9c1V48/TYcY+5jim1009pezVOoQDK33qRu6aOZs3tsubLdUKMWq9IYJjZUbrjWHZD
 2TrheNEUWdFiblUMH/OnQunifLo/9pBhrBT6dzND7rvb1lXDDrnOQxx/PZtXsjGBi9im3jWg1
 ZNAVdppVKSBUL/JhptaUoJCFIFNNVjV6ynmlH1UTrI1ijCZuErlnGl3he6m8ctOjxXpoJj+mo
 wpKggoGcsNRA6VGfd4siYOlbWzm/eLTuqhzagMEAjS5gDm20sQ89S5UiVEI5v8Wa8bzUQSvmP
 djOwNCRDWcFg+YnfwJsXe7uuMS+mFQIgF9i6fIBTHIQkkwdWW7SvymsXWh0cxceGMmzm/BYMI
 FDxB84SIwdV/evk11qSl1NWnfyQuVaZh8qljBZq8aKL2iuYxo6uaM4vgwhI+gPO3cPmLy5dX3
 BpKNqVHKFdiBH4YkeJTUMIjVg2bmqbf45vw+qPXaBKTlxwVX05rrRDhqr4S6bO9B8JwQtN5kP
 uiT5YqiT9V6Qi9O2OQ4+452whsd/jHGxnpQWGFt86matLdehy/d0G+9WpySEphpGUvnjQVYjX
 h8L+JReODbUbGjtMdXaa8aOLV9aMzSsCQUDU1CMwgonUnHWUkHXfzV4jy9nYhSqbvItKOlrn/
 Lmd+FDkrnK3njuAXj4q8tyu/f+5YtsRcCXA8Bvs8AMaXdumNL2H4x/u41r+rhJ4hfa6BO8IHY
 wTE4G5YaTAFWsR9t3ISaLuEfIJ1QkYxgY/d7Aj167TEHOFpkaYssL3wrLVXTMGXNJP7zUdFuG
 UUVh35+ft5hf+yGRRxf+C59zMGebJ1/PLwpkvfyqZZRq92ivk93rZwZEHXigu+lS3u6zSPkzR
 GGvFv3fo5m54OPdKGt6GoEpna00=



On 2023/12/19 21:59, saranyag@cdac.in wrote:
> Hi,
>
> May I know how the logical address is translated to the physical address=
 in
> Btrfs?

This is documented in btrfs-dev-docs/chunks.txt:

https://github.com/btrfs/btrfs-dev-docs/blob/master/chunks.txt


>
> I have read the official documentation of Btrfs available here
> (https://btrfs.readthedocs.io/en/latest/Introduction.html). It is not
> covering the address translation part in detail.
>
> I have also gone through the Btrfs source code
> (https://github.com/torvalds/linux/tree/master/fs/btrfs). I could not fi=
gure
> out the address translation from the code also.
>
> After referring to the following functions, what I could understand is t=
hat
> after getting the logical address of Chunk tree root from the superblock=
, we
> need to convert it into the corresponding physical address for parsing i=
nto
> the next level.
>
> int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices
> *fs_devices, char *options)
>
> int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>
> static int read_one_chunk(struct btrfs_key *key, struct extent_buffer
> *leaf,=C2=A0 struct btrfs_chunk *chunk)
>
> Any hints or pointers to the documentation on this is greatly appreciate=
d.
> I want to know the implementation part in btrfs-progs/source code.

For the implementation, you need to check btrfs_map_block() (the same
name in both btrfs-progs and kernel), which is the core of logical ->
physical mapping.

All your mentioned functions are just reading the chunk tree into memory.

Thanks,
Qu

>
> Thanks in advance
> Saranya G
> CDAC
>
>
>
> ------------------------------------------------------------------------=
------------------------------------
> [ C-DAC is on Social-Media too. Kindly follow us at:
> Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]
>
> This e-mail is for the sole use of the intended recipient(s) and may
> contain confidential and privileged information. If you are not the
> intended recipient, please contact the sender by reply e-mail and destro=
y
> all copies and the original message. Any unauthorized review, use,
> disclosure, dissemination, forwarding, printing or copying of this email
> is strictly prohibited and appropriate legal action will be taken.
> ------------------------------------------------------------------------=
------------------------------------
>
>

