Return-Path: <linux-btrfs+bounces-3389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543B87FAB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 10:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E7C1F223A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA57CF27;
	Tue, 19 Mar 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LTxIYTDU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825AE51C28
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840647; cv=none; b=kH2ZgdP4KbhBRC73WgR7vj/4oWysxbHp3+SBazxZnq+pYHvQSwrVnhhjb+2sPyt2ku3HfgYvlRC0JoOkDHDN64DGpgH5LOYkaIa9v/eyFgoAyQX35wuwtTjCcoTl4BvLiUdS0Tdo7emj05jFF+/wpQ3aaIGyogLk9NTkyI8OFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840647; c=relaxed/simple;
	bh=DJTYBSfpnoN/37ZEi4F/ZYD3e29e436eNsu2WwjB/n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GXWzeCV3RW7qKR/KbNOWmOEz5S/V8t+BoA9yLJBGrHFxlZ+n7mFaaaHvQN8r3FS8KVPs63X6ISi6gfzRNsWkUro/d6kUN2/eP2J+o5OmJ56YrIzqf6Qw4COmDKFD0sNFaNrjpjWb3gW3vdqGdTY4wQiJmCeXMec3b6MlFd1+4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LTxIYTDU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710840635; x=1711445435; i=quwenruo.btrfs@gmx.com;
	bh=yqV0VyhIeGLWO9Oq8Pb5aC4MUUK52I4q0hUBALGBIP0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=LTxIYTDUmKX+d3aBunYfLOgtgGDnnUblTUP5RK8wMWaQU5hdhH3dWdLlpjQAMC7y
	 EpeRw36cUnYyno26zTE8qwYZs4c/R+rfDBL0jf3cR5ZZdYW0Pr3lGHrZYjy1TrUkj
	 lDC+6Yggy1TINDmlqcqwMt/kh5f/N9vGmu7WX6ABXE+Me3CK+nW4SVDR+Tj1qGfQi
	 GUX9ACcMK+zOJJLX23EqnQLDR+7zmmNYK6bnhMYWtvAjBRNK61aexIC8bTFmQiUDK
	 QtNt81ltTUJFrqNZ9xjeHpG+N96FsX1R0McW58Je/7PpB7pRoSM1cWbsOUHm2mGdT
	 xOPoD/IU7ZuP6dKMrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1rQ9SU0NGL-00MJg7; Tue, 19
 Mar 2024 10:30:35 +0100
Message-ID: <24749be2-64fb-4b1a-9fd5-9d27437dd47c@gmx.com>
Date: Tue, 19 Mar 2024 20:00:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: parent transid verify failed after SATA cable partially unplugged
Content-Language: en-US
To: Robert Munteanu <rombert@apache.org>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <f3ec0b8237094b06375dc1b82a70964c2a8c10db.camel@apache.org>
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
In-Reply-To: <f3ec0b8237094b06375dc1b82a70964c2a8c10db.camel@apache.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ehupjStrXFXkD0WFh40B12iKR48Mg1139LLngIQvOci8iAEgXdU
 A9YGCpRrLDGpUouQQ1/UkcNt27axAF2nWkHCDBnd9Z3L9RPlOuJxbtwyrNdI3sY1sDsyWiS
 Bu5hHEE/UGVsb7uLH04gVRXfXVVTi/SaSNPsMg6HYmowkvtB3r5muKrsd49j5r5gdcPn/iq
 wp0YUzxJx1ZMxfsDwvvKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x2w8IAZbWZY=;UZWCeEmru/IjXQClAgfGLzWvDgO
 rRkg9spdVZrAapFMiNUKigNcBVQweeWLAMvLq3hUANwE4CXmY/cFEfJQwA6PpBA8z5D7sJBIa
 8kmlcrKB/UVHFMTsN/zLbC4TNoVythscjVBqdyLta5LNHR7GyvNdhEnXWeM4Cfxf8FMcdVp5i
 qc7zJ6eTnLkgCRKjs0DF9MGeWD+qFL9oWSN8cURxLyc8If4mUNbWAQ2vVn6pIskwf791+IFAd
 iC5gh84ZRSjYKwpDDYfgoLj3EoZ6I6hRjkfTpZpGB6Yg6syz300+Z5dtm5QmSAC4lvnaEk7oB
 qZoqpw5MphJzhWGX1X/qnCOyq/33bs4AJGDoBErZjm+tHUBvofNb51gT6FhTNa/8WSy9jbWWx
 pVghJjJopcXN6xrY7bTucmmoeBX9UlSBJwCU3vOU6Y8mbFBtXNB2pmJVsKR0LJEQA1B6rXKFg
 A30VNhILMP3A2iMJxett73Zwm7tsUkkBRw0YW3jPCmycEkPbZTh0hfazgYqoKGHXF4Jgs1uIT
 3MgoT9e2kV93eE3FpPcNBErsF9oFRU9R9TK8KCtjEPj4oDVkQw0ABXKAnYTAXoipI8zCbvGRV
 DCoC3p9NavFXEza0Z9zi++D8OvdFxvN9A5kW7fYox/P/gwWq9KizWWHRWkVoIKU6WA/vZhgUW
 8qmOoR7sEEfaA3Y5Vfrv2yb2z/Zb4ZbuIi7KhgM9mx+QRvwDPt1np82HhV+P4WMHnn9muUlKE
 k6mOwNNJTGIzLeXqrUuek2g4QJBb8yB4Q1im48FVC0n5vONhhtu83PyN+ElNC1FPoBanVYZhQ
 rhMqFBI9LUCCh9Zv7fIKqogPR7WJbAqcvUBnDrSL69smg=



=E5=9C=A8 2024/3/19 19:22, Robert Munteanu =E5=86=99=E9=81=93:
> Hi,
>
> (I am not subscribed to the list, please CC me on replies)
>
> After a bit of hardware maintenance I have very likely unseated one of
> the SATA cables. The machine still booted, but I noticed various errors
> related to SATA communications (did not save them unfortunately).
>
> After reseating the cables these are gone but BTRFS complains in
> various forms, mostly
>
> [   10.771222] BTRFS error (device sdb1): parent transid verify failed
> on 407076864 wanted 888537 found 887627

If you're doing all the things live, then those error are more or less
expecccted.

>
> [   98.418587] BTRFS error (device sdb1): space cache generation
> (887711) does not match inode (888531)

But this means you're still using v1 space cache, which is no longer
enabled by default.

>
> [   98.484961] BTRFS error (device sdb1): csum mismatch on free space
> cache
>
> [   98.489141] BTRFS error (device sdb1): csum mismatch on free space
> cache
>
> All errors indicate device sdb1, which is
>
> $ btrfs filesystem show /dev/sdb1
> Label: none  uuid: d0e910df-7a34-4cc9-a67f-f28ceb455022
> 	Total devices 2 FS bytes used 47.82GiB
> 	devid    1 size 512.00GiB used 49.01GiB path /dev/sdb1
> 	devid    2 size 512.00GiB used 49.01GiB path /dev/sdd1
>
> That device is mounted at /mnt/fast001, in a RAID 1 setup
>
> $ btrfs filesystem usage /mnt/fast001
> Overall:
>      Device size:		   1.00TiB
>      Device allocated:		  98.02GiB
>      Device unallocated:		 925.98GiB
>      Device missing:		     0.00B
>      Used:			  95.64GiB
>      Free (estimated):		 463.21GiB	(min: 463.21GiB)
>      Free (statfs, df):		 463.20GiB
>      Data ratio:			      2.00
>      Metadata ratio:		      2.00
>      Global reserve:		  17.89MiB	(used: 0.00B)
>      Multiple profiles:		        no
>
> Data,RAID1: Size:48.00GiB, Used:47.79GiB (99.56%)
>     /dev/sdb1	  48.00GiB
>     /dev/sdd1	  48.00GiB
>
> Metadata,RAID1: Size:1.00GiB, Used:33.31MiB (3.25%)
>     /dev/sdb1	   1.00GiB
>     /dev/sdd1	   1.00GiB
>
> System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
>     /dev/sdb1	   8.00MiB
>     /dev/sdd1	   8.00MiB
>
> Unallocated:
>     /dev/sdb1	 462.99GiB
>     /dev/sdd1	 462.99GiB
>
> What is the recommended way of repairing the device? This is not a root
> device so I can play around with it.

Just scrub that device, and everything should be fine.

After one scrub, check if there is any unrecovered errors. If all errors
are recoverable, you're totally fine.

And after everything is fine, it's recommended to migrated to v2 space
cache.

Thanks,
Qu
>
> Thanks,
> Robert
>

