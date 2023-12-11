Return-Path: <linux-btrfs+bounces-821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F780DC2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 21:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A608A1C2165A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F665467D;
	Mon, 11 Dec 2023 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Zj2gAmpH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B2C9F
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 12:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702328248; x=1702933048; i=quwenruo.btrfs@gmx.com;
	bh=B7cxpup76UJMwFmthutMUcvJGk3rrSn/iywb7BLfcuU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Zj2gAmpHlLyo5lfNvsKaMte7/iooldj73G6hIrOQuP1Qb93L2cXjztIwqAfeds2Y
	 7SqryathBu116CH+P1ynVsIQfdSEstoxFnbA68PXf8sj3D3idHqouWtrAzC+MJTZJ
	 2ToBuARuzyiPbTDQFrkFryUpXNNaDeGGrkxJrioGvL4c8PAN5JAEyE7M/a+xmShbc
	 jJaGd6aXBxwIbFBRpXWT01w/GgHVVhDeNWltCxn/CNCxhr00vX2aSo8ht6EGeSvkj
	 Bo9CRxhmsWuq+XfKrdXi4JYNArU2BMe/j6TlfrWGc6XYeiEen4vFOzKQLeodaVLkF
	 Y/EQG3WgHQRs1nJ5rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oG5-1rOfHm3KJ3-00wo2E; Mon, 11
 Dec 2023 21:57:28 +0100
Message-ID: <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
Date: Tue, 12 Dec 2023 07:27:23 +1030
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
In-Reply-To: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KmD69yLNK6FEFBVRL3dhRwrdKxl5YmtZ1zzoSsQ14aa+jgtrW/C
 H6p1Pp7Imslxp7AWLS7Yyze81zW1KFZHKlsr1ScOTa3CGrtDmfRIPzK92kpuPmO/95ndpDy
 IiAGhXblT+yIz0LyIKx3oixRe7SprzcFgsxm9k31znsvg8ksZtc1RHEC/xfkab8FbX0M91X
 xbvD83caoYtOH6QceEWJg==
UI-OutboundReport: notjunk:1;M01:P0:5ZGEgSJ4e3c=;ToRqP8h0NqgMg3FM7kz/ZLIgG5s
 q7Xojw7r1ggp+MFRMccUgSwh35Bx/0I1sp0CEZ3G4rBYxgnQ+ri5CbQoog1/oRcgThhafh64r
 n8T6tiBFG3lX79Mc07OgoHIsMx5CYSxQxXDZJN7qTSuCdp3nxSTnNXefpzvs8/Imm2VS4xqXS
 k0TTnk99TpWmsIijx6/pSXyF0FhFQdKc+y0/a1G79rWwYTS3BlFC/ciRHHUiZKudh22oZGUD0
 k+kYd1PJdOFrAwbNIOdUUR186Bx0KvaCtQS55DMJA3+0nvMsLl+uCOY6qUBNqWBgUujVSRScd
 JJcnhg+vO2X8K0D5si9nyrCKfQqgvYwEwX6i7RZl37/SMqTdvKjkP6DH1o4iX08bTEhRZGhhc
 /HYkKMgDYOhSYgAFVTj5VbjsVOnRLynWMfoiTxlALqXCVeJjeismLLRuuG/BsDBpvS3+4pGLs
 5iVyHZaeaPe70xrgTWpPutBh4MYrHQOo2Nf9FEKiil/cTNg6mQbZugrGrjYWoll1di9HzXYI1
 6beRGAKJjNRMY4L2fBqulT8lxr0PjjVu16GvWHXwzhDpAACrnOTJFVMHcTANWGOALy2bxM4jL
 abkuRAk1wvd0YRgLMYxbi7Bgaw/HB+quCCv49C3obvL2iARTfoWQm/rtqxtOEOFYWWaRbl6fD
 vFWs0ZMW/fOuh91Gq/yBmf/enbm445dJqlSt4KxA0yzkWrE1nflmtioaram3tgGSikmXdyr6E
 cwN6m5XYCYWqQFQJf2GVK0SMRazLIQpowQ/mzUAj1BOpFk/dTA0qdJSrzR+DGxNCNRvabD3PO
 xoCNK0LWtVHXm5Kfqsfj8pasLdUkI/Ru7IbZ/LdRGf0pdl01hwPGL6U2c1rTXST0fYMcGx9UX
 d+dxw5hSuw3Y3W2Z3aKXwH4axNo58+3f+RvChelt7PSvzBQA1yP/Q10naIC0An72d1NM5DloP
 dIRftA==



On 2023/12/12 06:56, Christoph Anton Mitterer wrote:
> Hey.
>
> I think the following might have already happened the 2nd time. I have
> a Debian stable with kernel 6.1.55 running Prometheus.
>
> There's one separate btrfs, just for Prometheus time series database.
>
>
> # btrfs check /dev/vdb
> Opening filesystem to check...
> Checking filesystem on /dev/vdb
> UUID: decdc81d-7cc4-431c-ab84-e03771f6de5d
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 42427637760 bytes used, no error found
> total csum bytes: 27362284
> total tree bytes: 32686080
> total fs tree bytes: 1982464
> total extent tree bytes: 360448
> btree space waste bytes: 2839648
> file data blocks allocated: 54877196288
>   referenced 28014796800

That's pretty good.

> # mount /data/main/
>
>
> # df | grep main
> /dev/vdb       btrfs      43G   43G   25k 100% /data/main
>
> =3D> df thinks it's full
>
>
> # btrfs filesystem usage /data/main/
> Overall:
>      Device size:		  40.00GiB
>      Device allocated:		  40.00GiB
>      Device unallocated:		   1.00MiB

Already full from the perspective of chunk space.

No new chunk can be allocated.

>      Device missing:		     0.00B
>      Device slack:		     0.00B
>      Used:			  39.54GiB
>      Free (estimated):		  24.00KiB	(min: 24.00KiB)
>      Free (statfs, df):		  24.00KiB
>      Data ratio:			      1.00
>      Metadata ratio:		      2.00
>      Global reserve:		  29.22MiB	(used: 0.00B)
>      Multiple profiles:		        no
>
> Data,single: Size:39.48GiB, Used:39.48GiB (100.00%)

Data chunks are already exhausted.

>     /dev/vdb	  39.48GiB
>
> Metadata,DUP: Size:256.00MiB, Used:31.16MiB (12.17%)

A single metadata chunk, which is not full.


>     /dev/vdb	 512.00MiB
>
> System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
>     /dev/vdb	  16.00MiB
>
> Unallocated:
>     /dev/vdb	   1.00MiB
>
> =3D> btrfs does so, too
>
> # btrfs subvolume list -pagu /data/main/
> ID 257 gen 2347947 parent 5 top level 5 uuid ae3fa7ff-f5a4-cf44-8555-ad5=
79195036c path <FS_TREE>/data

Is your current mounted subvolume the fs tree? Or already the data
subvolume?

If the latter case, there are some files you can not access from your
current mount point.

Thus it's recommended to use qgroup to show a correct full view of the
used space by each subvolume.

Thanks,
Qu

>
> =3D> no snapshots involved
>
> # du --apparent-size --total -s --si /data/main/
> 29G	/data/main/
> 29G	total
>
> =3D> but when actually counting the file sizes, there should be 11G left=
.
>
>
> :/data/main/prometheus# dd if=3D/dev/zero of=3Dfoo bs=3D1M count=3D1
> dd: error writing 'foo': No space left on device
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0,0876783 s, 0,0 kB/s
>
>
> And it really is full.
>
>
> Any ideas how this can happen?
>
>
> Thanks,
> Chris.
>

