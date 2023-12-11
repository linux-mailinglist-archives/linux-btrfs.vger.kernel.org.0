Return-Path: <linux-btrfs+bounces-826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B980DFBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 00:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95686282689
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2706556B7E;
	Mon, 11 Dec 2023 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TWjfqP4/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9BAB
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 15:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702338859; x=1702943659; i=quwenruo.btrfs@gmx.com;
	bh=OX28a2+ntyKahKUd3JpI1AIK30Mcx33cj0ACNaFLmx0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=TWjfqP4/7Z/sBTn/lWW8mkG6VCBm1DEbgtt5HveUvnr4bbcc8/T+nxuI0K0AG/H/
	 ndziqHH8iWgwVJUzaE1Gz8nogKufe5e1+XKcshezsc1oICYqfaOmJT51ze1ugcwQN
	 xtw51PkKgeUUn9tFaUgrm2ivTpFNYROZbKXRip60z1mdOAUxk7RJXb/cZOSQkGSl1
	 c3PzZ5ntYUNcbSC6CDYGeBMpgLHe4Vi8BCSgn/2mJ5vpEv5S8d8a7rv/hVZHH4IrE
	 Zk9wsOgPRd9X7IT5KIEQHqq0ef+R+NpkfOQf67pwhvNu/li17US6DjgrB3llc8yhb
	 4LMrgP5nodhgd1LGGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1rej7g2AR8-00kvUS; Tue, 12
 Dec 2023 00:54:19 +0100
Message-ID: <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
Date: Tue, 12 Dec 2023 10:24:14 +1030
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
In-Reply-To: <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XpsOLxYcrS8+Q3tOh403rTXyhY8IrvZ45TOI+AhpmCk1avvhXSv
 ibqLkoP692nnwGwMqN90Km8bhx6mOK26tktGQuJFUOld09qBNFZg1gWBuIDbO7wbpdXeseY
 l6JP6fcvvlP824GT+S0DLXkwRuPGtRTblRbsXSkJiY8F+XEHSISwyDw9OblPJct4phEv8LK
 IZ+voAqaD7raqesc6A7SA==
UI-OutboundReport: notjunk:1;M01:P0:7oKUKQNNgAI=;ROWW6UCKzsfEPPlOItkgs2Ml8I/
 lZ5rcxMFTrZNMSQ5dJkqUr4nqa5lJRfC8RWbCkl/QIsZvTjm2jkBso6U8K/P+KcqzVZ/5AW+2
 1fcEZOEDAy3llFVNT34IIbRWiVDRG4zA9c0kE7JhM1l9WHWD4MmjYqQ0XQYyo3QhnsXpfyAZ5
 yk6BwvPitSQowbIDeSCAujcO0Lp0c4JpTeibotk3XlRXyuvKr4rf5H2rY9aPPCy9DQCvIfiFa
 bZv4WA2GWhpFl/6VfHwhvXOXvjDeq8B1+qzKSKEkdGSS973qBgVTFjxJOk2S7WAWOVrgctum5
 C5yDJCWsiBrOVqqjMfGLOKIbPucpx/0aKMGSQ0hfXbHUmf3+u4vqOqEweb36I2UuuNWXFfxU0
 PvlniUcDj3dMZYhddoKbwjZIIUcpgQqf9oc9HLwhUV3sbVKgBt4hL8ZgD5GzzGC52K//L1uiR
 m65LkS9pUiLmgb9TBlfGnLGkS3AdHCDDykCnql9ZWVGVQCNGa0fBv1KPkQj7K4xjpro0D33Ly
 kLRtKJra2CG2FnEoPYV7bMQcqVzPvl/j604wq1ETkUAiKTEbtY3hZ+zX4JTFzLpB9Gw5+RQit
 m5H8tPxVZzgnU8EKcv006c0HwPXezrNOX9M7Nhb+1CrShN8cS+270noK41tKUJ2glr3qlB9sT
 xlOS++jbAxQuqGAw9WgCNy8xNmzYp8RvFaFg62dIS47GIdKvfL9OrdhdXfW7drA/gsdmgTctP
 NwTubzxt6kRZUTf7jMzJ5deT0zHhYq7Ych8TYFiwaM3Yjm5DyFUKAmzq7pGEBHsbxa1CIxGtx
 b0BbdSKj/7OwUXckr0FqLr5ZNMLjtO8do5y2q1gGYoX3+lD+hixteyasp2pPzj2MvxVsa59gc
 X74742MmRRP+DFWujkXR6CO3Ky6/8Nsj+qf2KIoXWxfthH2d40avT3/gvL2BWaCdMWvGt0jD2
 qTr1pBsvVMvDI7tE7Df86K3DCpY=



On 2023/12/12 10:08, Christoph Anton Mitterer wrote:
> On Tue, 2023-12-12 at 09:50 +1030, Qu Wenruo wrote:
>> Shows exactly which subvolumes uses how many bytes, including orphan
>> ones which is pending for deletion.
>
> Well... here we go:
> # btrfs qgroup show .
> Qgroupid    Referenced    Exclusive   Path
> --------    ----------    ---------   ----
> 0/5           16.00KiB     16.00KiB   <toplevel>
> 0/257         39.48GiB     39.48GiB   data
> 0/258         16.00KiB     16.00KiB   <stale>
> 0/259         16.00KiB     16.00KiB   a
> 0/260         16.00KiB     16.00KiB   b
> 1/100         32.00KiB     32.00KiB   <0 member qgroups>
> 1/101            0.00B        0.00B   <0 member qgroups>
>
> I've just created a and b to get qgroup (somehow? ^^) working.
>
>
> Nevertheless:
> I'm 100% sure, that before, there were never any subvolumes on that fs
> other than the toplevel and data, unless btrfs somehow creates/deletes
> them automatically.
>
>
> But the above output, AFAIU, still shows that "everything" is in data,
> while counting the bytes of files there, still yields a much lower
> number.

OK, then everything looks fine.

>
>
> And other ideas what I could test?

Then the last thing is extent bookends.

COW and small random writes can easily lead to extra space wasted by
extent bookends.

E.g. You write a 16M data extents, then over-write the tailing 8M, now
we have two data extents, the old 16M and the new 8M, wasting 8M space.

In that case, you can try defrag, but you still need to delete some data
first so that you can do defrag...

Thanks,
Qu
>
>
> Thanks,
> Chris.

