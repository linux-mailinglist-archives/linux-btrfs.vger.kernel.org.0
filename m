Return-Path: <linux-btrfs+bounces-6994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9C948582
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 00:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8431B21690
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 22:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24F016C696;
	Mon,  5 Aug 2024 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AQIJ24nv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD9149C4E
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898054; cv=none; b=qN2wFLncCyC0hJSDXVZquuEa55RVY8SSjn3CEjm8mU68nuzMy6zKFNDMWmWryqXDgdBYdzDa1WyYXimZwK9OzJ3XC9dFpfeSiIcS/p+IYlcxFAju9Qps4V28O+9fH/mx3xRclK2+4oHMiLUdrzlRq2L2U16c3M4V1CGTkXdZyGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898054; c=relaxed/simple;
	bh=YWzib869iwjkUd2bXUP6iA3RGGSqYPI8BtQJ8QxhjzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uH83axIxBB/8trSJjEHh1Kve7RxwcuAPJADE0j1pc3QgLTmZ//KYXKfjI9ZTYiKqbe5cddp84L9oTbGQqNEC8E670eXPWz0VdNe51oTNOzvzfrxYrgBe6M0TXR8iZelUJmN5uerseHdanAHyjDwcl69qy3HO0KaQe/XL7VTYjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AQIJ24nv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722898048; x=1723502848; i=quwenruo.btrfs@gmx.com;
	bh=D5DOua5ujryIWZiX21wiYbhV8litXb0iBEf0WZl3+2g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AQIJ24nvPd9i7P03GqGxhQLH1E9A6V+ijrhDaMoOsbZeYPvCOOIoGkDBhdiQ5jvw
	 QTfItd/vbtp9EoNZz/Mp5eQQnE6cxY38/6ZBf0fjGbE9OFiSjcFy/MlBqZsgwaZye
	 gZql6VhuHfzaxqsEll09+GzhZa2eYj+n17X0tEc68OOwHzvXax63JMmZr5tpmfgu1
	 mAWRasp/d794iqCQJqJUJ6W63ANVB8jgfQGaWaMlPgdc1En/AG0XOOhnzdRtAflvk
	 7fORUnTNEsq+uVD9nsF+Qp5zIlNCGM8hcmgeWg6IlS0lnO/PDoSeFRx6d+YdSj6DP
	 aFPjYWPw2wQK1ybbWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sit-1s9yAh1Z1z-00ycYk; Tue, 06
 Aug 2024 00:47:28 +0200
Message-ID: <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
Date: Tue, 6 Aug 2024 08:17:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
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
In-Reply-To: <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OPm+nWimz6pVgpcviRLU4zGd3/ViB3umKSJDpmALdXjGgC4lVwp
 6GolOs7ExdzvWk3VqGbp+iQTnq5bzZxCwgTmlRwxbevzXCJ/hQjXxRyoU03VCmZakQSBA0N
 8fRQwqefZHSu+Db+tlM4ZOJNtwdybLg0RLuq4bEBmu7SrpYtrBpIvaSsgXEwQU/rr8DxDAE
 ZT+BvK3rz2oCG1apkB+UQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t+srvu+T5qQ=;QJ/04QFe4GNFVe99OANLMD+BDY9
 tcROlomT3XqSo2cEWGaREGtJGQKW97u5fF8vhZcXErxi2EhsLDVlxACsXMJSpddrHZ6P1Hmfn
 1pAKUi44VllXAekszeIrOyZrsb3sQBmlMZ5yWlk2JCEKaqj0aH2EhfE4JpCg2dg0JvkfDNZzx
 pckDlEoapKe8GRyhYyVDC2v4m+oVPD3hgw5v36UXgUusMp8NXL+nmnG2tun4LIrxlnFhLpyCj
 qWYF9f4r0dEPfnxWze08Rpx7A8iFEkITVUpt2PwVQ7Q0htBPdhsP374bDujwMZv39MUlyNPCl
 Ji/yk1bAtQ+e9g7SqjR/NjimOAxLAJ7kQWHlGGy3vLZt1hoF5UPS1S4P6M1NG0IpiLOtLeqir
 4Nf0A/vqwYhbY+8/6/+G/fDCIPrwpQUhAcycg463yE0ZOXLeCXd+QxR0hCW7h6pFUOBtmtXyl
 CCmEo1dxxp1XchYEVXXxN0NOcPUM+EzQdzXwE/Z5qy18R5qShCxR5ApWSP08xXkngvaeWwrE4
 ChYLArSe9wEcPVdm3W2BQPMtnu7TwDO+gZmpW8ciCDurxrKOuhu0Gi1hM2NP0DHjO6xD7CJ0S
 JxJxW2afAPQeiAm/xw2VIybpK/T00tZrOwvJ4WIqTSy2Fyf4EAEPdQEnYLdUJyg0fypNCcrhU
 fMtk0dUy3q5abo+T6Cqwa2+ZpU1VhbvWuOU2ZBOVfLOrOi4sF+b+qRCVAFwuQ5olN8cXiSYiI
 DOW5z8HgdBezfmAKiU1ZsLcn7843gnSpwvaaVWTsj08S4Uz8IU1235gCNrsmeCtzbeqsWSXHh
 2c785SPd83bdaH+q+ZUVkdIA==



=E5=9C=A8 2024/8/6 03:46, Hanabishi =E5=86=99=E9=81=93:
> On 8/4/24 22:19, Qu Wenruo wrote:
>> Mind to dump the filemap output (xfs_io -c "fiemap -v") before and
>> after the defrag?
>>
>> Thanks,
>> Qu
>
> Sure.
>
> # compsize mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
> Processed 1 file, 1 regular extents (1 refs), 0 inline.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
24M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 224M=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 224M
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 224M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 224M=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 224M
>
> # xfs_io -c "fiemap -v" mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
> mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
>  =C2=A0EXT: FILE-OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK-RANGE=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TOTAL FLAGS
>  =C2=A0=C2=A0 0: [0..460303]:=C2=A0=C2=A0=C2=A0=C2=A0 545974648..5464349=
51 460304=C2=A0=C2=A0 0x1

Weird, there is no fallocated space involved at all.

>
> # btrfs filesystem defragment -t 1G

Oh you're using non-default threshold.
Unfortunately 1G makes no sense, as btrfs's largest extent size is only
128M.

(Although the above output shows an extent with 224M size, it's because
btrfs merges the fiemap result internally when possible).

It's recommended to go the default values anyway.

> mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
> mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
>
> # compsize mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
> Processed 1 file, 8 regular extents (8 refs), 0 inline.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=
20M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 420M=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 224M
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 420M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 420M=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 224M
>
> # xfs_io -c "fiemap -v" mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
> mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
>  =C2=A0EXT: FILE-OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK-RANGE=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TOTAL FLAGS
>  =C2=A0=C2=A0 0: [0..511]:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 157=
54800..15755311=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512=C2=A0=C2=A0 0x0
>  =C2=A0=C2=A0 1: [512..2559]:=C2=A0=C2=A0=C2=A0=C2=A0 22070192..22072239=
=C2=A0=C2=A0=C2=A0=C2=A0 2048=C2=A0=C2=A0 0x0
>  =C2=A0=C2=A0 2: [2560..6655]:=C2=A0=C2=A0=C2=A0 22632216..22636311=C2=
=A0=C2=A0=C2=A0=C2=A0 4096=C2=A0=C2=A0 0x0
>  =C2=A0=C2=A0 3: [6656..14335]:=C2=A0=C2=A0 22072240..22079919=C2=A0=C2=
=A0=C2=A0=C2=A0 7680=C2=A0=C2=A0 0x0
>  =C2=A0=C2=A0 4: [14336..385023]: 546434952..546805639 370688=C2=A0=C2=
=A0 0x0
>  =C2=A0=C2=A0 5: [385024..400383]: 44592672..44608031=C2=A0=C2=A0=C2=A0 =
15360=C2=A0=C2=A0 0x0

All the above extents are new extents.

>  =C2=A0=C2=A0 6: [400384..460303]: 546375032..546434951=C2=A0 59920=C2=
=A0=C2=A0 0x1
>

While this one is the old one.

This looks like a recent bug fix e42b9d8b9ea2 ("btrfs: defrag: avoid
unnecessary defrag caused by incorrect extent size"), which is merged in
v6.8 kernel.

Mind to provide the kernel version?


Furthermore, there is another problem, according to your fiemap result,
the fs seems to cause fragmented new extents by somehow.

Is there any memory pressure or the fs itself is fragmented?
Btrfs defrag is only re-dirty the data, then write them back.
This expects them to be written in a continuous extent, but both memory
pressure and fragmented fs can all break such assumption.

Thanks,
Qu

