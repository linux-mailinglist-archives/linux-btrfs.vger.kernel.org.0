Return-Path: <linux-btrfs+bounces-1113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC48581C125
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 23:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F651F23963
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7278E64;
	Thu, 21 Dec 2023 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pb9Ao1Ns"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD2171B3
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703198511; x=1703803311; i=quwenruo.btrfs@gmx.com;
	bh=QRWHWEaKN2+OnR/TGXounzWv7dF6+Ss4vQQ1RtDRRvs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pb9Ao1NsL+mDeCpdi4YMZfLd/9Q84HOp20Js8GEhBh2xuNn8yh0Q/t/GFs4Yess+
	 YOg4wAoJKH3gIUqbtDfGxdz3NdIQpOB8o7+bkUFskHInL7TdHQpfnoVoE9SPrFbJV
	 0jHPePziEXE322s8QZOSFjD9jHkSmtZB+PDiiXBP9/qJPk5S/B1ZQahdzBq5pxcL1
	 L44Ny0Fk3ld6cHe5PwbAOQqOmKLQAQdNWbNvZnHDhCIY9mqvzGm6P3Vgp2iP7iy0f
	 rCwFvev40yY/rz8q/f7B61giWKqUVpiSgt404zXRh3IPEY8wnoJFgPyEefPJPJASx
	 9Bd0zLyKMSIZXK1q8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.114.154]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1qsLFX437B-00kgIm; Thu, 21
 Dec 2023 23:41:51 +0100
Message-ID: <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
Date: Fri, 22 Dec 2023 09:11:46 +1030
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
 Andrei Borzenkov <arvidjaar@gmail.com>
Cc: kreijack@inwind.it, linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
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
In-Reply-To: <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sIEeMGGm+vVQ+JnxEr5Hrq//LxMrlKTYh+JvC8dXAk75YqDHyoV
 9tz/U8Uw9YAed/qfJ/6z1W+uqTQ6tdDz7TlT3xbpmnals9CwoV/one6Lw8BeuKP4rkh5DZt
 joM7lBTi031I8FTJJVD7SBuqEVhpz+dhujjN0HeWkAo8qn27Abp1xP4e9csj8UkgLDgfIha
 wCJogIaiF6yS8giYBexwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cel9HRrXCi4=;4oJ/s42qtG8Wt9yE5Ss9HI8RMNY
 3lcZ9a+kLaT3/5nluCH+AwswwMYVP2eqdLr+2C8TT3C/DlI9NYDIqXsVU16CCSk72jI8O8zrF
 YFcrQko24wQRkGCIdexWqnxajkwqgFy3MEREqFHxQ52rvUXZu1hr+A73YAHvCxF4n8fuiaUQR
 5XQckzHuv2lfWjrRyCQJUSr/M9n5pDxv3eTgU5jYLcULg3G2uxSvFHJi3EMNTBfrA+YK7Ewxj
 305+bMMj0aWdtXbYDOBGdWwZiLu/J2iyTvf0KQrUE5q0L8rcJxKkzwLwP9PC8aYTFa6bx5V71
 p2uJ9D/lIr6VSTE8p9iZDdgQ9QNg8nFSbxx68+HVwCAYcvGHqOj911ENuk6scJP9Gn0VkhL34
 egZLs8TJBEU90uBPPUrUUs1pnWkNP1OgpaNOTT6p5drLXl916hqG3+uWqKWtL89o0BV6BBwjs
 LRpd1j2ahIavbdkE2n4FD/ww0p9B1A/QSvJsrlVJjYcbbxik67dWrxhDWU6QnRfchnzwfVKb+
 E4Q0gR0809p6QA1FCNOyE6j1BakjunSNyi95BQLzUSA9xD4DqbX9Kn14FCWKSdBi6tnCGOIXU
 YhlLuCAr5TNYBYWoucouH+kDPKmOFWO8jgV1iD5cq0CerG4UtusyrpqdeQxqI5CLBYJNFs7bK
 PGI0JzMeMZekxv4E1lxdmVVsioE06Lv0nHDtUh1m1QNpDkYRnqCslh7iyzgUinpl6sc25YzT3
 uYSsGTofgeDmp3e3K/ScBrUPdOhYM+70qjxAzdUVGSfnwJn0zYrIpnR/IVXkRnKoibVUYc65r
 CEbNi4hl/Zv9AFjebKq7zZAwL1UJrkdxycyYf6NjUraofOU/XhUgyMeC/CirA1KYm04A34l+4
 o24OoO1HLgU0CrwEKF4m37XYmyxuSxodRRNe+8kv4YBaeVqPxy1bxMXpEeM03V6PLnSSih6HR
 7PU9Py+qcCog76CoXWvegmuFXnI=



On 2023/12/22 08:45, Christoph Anton Mitterer wrote:
> On Fri, 2023-12-22 at 07:11 +1030, Qu Wenruo wrote:
>> Grab the INODE number of that file (`stat` is good enough).
> # stat /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/=
000001
>    File: /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunk=
s/000001
>    Size: 15781418  	Blocks: 30824      IO Block: 4096   regular file
> Device: 0,43	Inode: 642         Links: 1\

642 is your inode number.

> Access: (0664/-rw-rw-r--)  Uid: (  106/prometheus)   Gid: (  106/prometh=
eus)
> Access: 2023-12-12 17:50:26.968485936 +0100
> Modify: 2023-12-12 17:50:28.748495544 +0100
> Change: 2023-12-12 17:50:57.280649521 +0100
>   Birth: 2023-12-12 17:50:26.968485936 +0100
>
>> Know the subvolume id.
>
> # btrfs subvolume list -pagu /data/main/
> ID 257 gen 2371697 parent 5 top level 5 uuid ae3fa7ff-f5a4-cf44-8555-ad5=
79195036c path <FS_TREE>/data
>
>
>> Then `btrfs ins dump-tree -t <subvolid> <device> | grep -A7 "key (256
>> "
>
> I assume 256 should be the inode number?
> If so:
> # btrfs ins dump-tree -t 257 /dev/vdb | grep -A7 "key (642 "
> 		location key (642 INODE_ITEM 0) type FILE
> 		transid 2348290 data_len 0 name_len 6
> 		name: 000001
> 	item 128 key (638 DIR_INDEX 3) itemoff 9441 itemsize 36
> 		location key (642 INODE_ITEM 0) type FILE
> 		transid 2348290 data_len 0 name_len 6
> 		name: 000001
> 	item 129 key (639 INODE_ITEM 0) itemoff 9281 itemsize 160
> 		generation 2348289 transid 2348290 size 17788225 nbytes 17788928
> 		block group 0 mode 100664 links 1 uid 106 gid 106 rdev 0
> 		sequence 408 flags 0x0(none)
> 		atime 1702399826.500483413 (2023-12-12 17:50:26)
> --
> 	item 132 key (642 INODE_ITEM 0) itemoff 9053 itemsize 160
> 		generation 2348289 transid 2348290 size 15781418 nbytes 15781888
> 		block group 0 mode 100664 links 1 uid 106 gid 106 rdev 0
> 		sequence 3362 flags 0x10(PREALLOC)
> 		atime 1702399826.968485936 (2023-12-12 17:50:26)
> 		ctime 1702399857.280649521 (2023-12-12 17:50:57)
> 		mtime 1702399828.748495544 (2023-12-12 17:50:28)
> 		otime 1702399826.968485936 (2023-12-12 17:50:26)
> 	item 133 key (642 INODE_REF 638) itemoff 9037 itemsize 16
> 		index 3 namelen 6 name: 000001
> 	item 134 key (642 EXTENT_DATA 0) itemoff 8984 itemsize 53
> 		generation 2348290 type 1 (regular)
> 		extent data disk byte 9500291072 nr 268435456
> 		extent data offset 0 nr 15781888 ram 268435456
> 		extent compression 0 (none)
> 	item 135 key (643 INODE_ITEM 0) itemoff 8824 itemsize 160
> 		generation 2348290 transid 2363471 size 283 nbytes 283
> 		block group 0 mode 100664 links 1 uid 106 gid 106 rdev 0
>
>
> If you need the whole output of btrfs ins dump-tree -t 257 /dev/vdb,
> it's only 72k compressed, and AFAIU shouldn't contain any private data
> (well nothing on the whole fs is private ^^).

The whole one is easier for me to check. But I still strongly recommend
to go "--hide-names" just in case.

Meanwhile you may want to upload the extent tree too (which can be
pretty large though), as my final step would need to check-cross extent
tree to be sure.

Thanks,
Qu
>
>
> Cheers,
> Chris

