Return-Path: <linux-btrfs+bounces-8753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF609977FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 23:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD5D1F21E6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 21:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4861E25F6;
	Wed,  9 Oct 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N5PHsJP7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF719308C
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511103; cv=none; b=h4sFENr1P1ZASe4eZ5EwyyRfoArH74IaqCoTgZepvJX31UfF209S7814BtnJKz5ON2xfImHN8Ly/1uXyHmTn3VnADXp7kCwlnM0HSKNvh1H5rwqBEZ1XiSGTOCUX+h9NyZuNIrNxLUjd/KLrU9Lw1eTv9QtMwvXN5LYndhzeS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511103; c=relaxed/simple;
	bh=kA5vCJVt6k6TQbQE5MIYGoxHnzJ+Q2AyJBLzD/vsVq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkFOrPEPuhfQOnzGk2p7hPgTyOEYP+psuoYnKpZp2MoRAgMRT/nZj+5J2iFOj9FABl42aO32tIDAh9dNd7PF710oXBqnxkmvJ3CinqX3J1SO/I1UfLEe4mNBTZhH3iKrYwPrtvEQf31nRrRfo2RqcKD7IFyOUWto2rl8HNXG0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=N5PHsJP7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728511092; x=1729115892; i=quwenruo.btrfs@gmx.com;
	bh=zy098IuFzWxx7eqCeN46dqb6gpB0Jnt2fR1jBPFdGrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N5PHsJP7Jb4zNayfJPiOvkvpMvhTR6MrdNtrv2cSY2za9RjM/xTVoMjEQQSxFNJS
	 KJ92p0s7couWiZSLbqSYf/EaabFYYoBpRFqJtmZ6hxGP4tRZ1F4W571gXwQ2JH8dP
	 70b6gv8mVBrN1CSRmVLbh5JTTR+8ibjkQV9YdDaUYwYZ3+AKEgdenYw1LdH5O/slt
	 dINsQEAY/SrUt3cvpo7gcyd+b+HAzE7hRQhlLEA+E8815i3QUoNB1QEEOAT8GLlxh
	 FmoH7Eo5G2HP5AV8AVShnhuFkXqbH0Ouh3Ci7wIqsDRuRWJZZhZ5QNDyPS44okcxm
	 Px08X9MWkpSQJBsxtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDp4-1tvot92lbs-00teMq; Wed, 09
 Oct 2024 23:58:12 +0200
Message-ID: <5c363f14-c3d3-4d5d-bc46-8b38d2bcd08e@gmx.com>
Date: Thu, 10 Oct 2024 08:28:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, hch@lst.de
References: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
 <1865ebe2-ab9b-4db0-84bd-9f4f6309eb7a@gmx.com>
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
In-Reply-To: <1865ebe2-ab9b-4db0-84bd-9f4f6309eb7a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0nq1pgWtoOvKFHrUqzkR9hxY8B5/1fTbXtUu+4vf8aBuKdS+u6I
 tQ43Y6Fpgui7WGhYOIxgR9C/7sNurQ0rBLN/HI1N+udWHyoMKU788GY/qgu3zKPdQsOGnDU
 CzCtgLl4eHdzV38QLRacTDljE9cMB45qYNRgOTGNUCEetJqPltiakRpMbiI10azvs4ud+Jp
 /5heAh4TFiu9j1scpOLLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GhSRWzjTL8o=;r8x7i5DH/sFf/HtbC3SJ8ZdhSS5
 eC+APc09Uh7q943qw5zYo2J53SD6htk4QP/4XPGO/PuT8bhbRR2gI4HjVkKk9aVGXGeiZJzr1
 ZaSlFuLAkp4eugvgbWqtHsNPT5HsirpHA+tYoDRkgK3cVffK43BTH9CyoU2ajqsVcJWrOsp3C
 wBP8BRwG7TTHPdEIKUxU3lGtI7hZKuGFm+IjgsPKk3o/iv0XNzwKx2CyE4U0aZUzjD5httjV8
 1EgEeEKyojclAyiDpLHmGayyp4Z47/dwfwyClwyL9+/mRPqopaOinouiGZ1E+5ihuSHXITLnQ
 7no2ijuH85csveYoObgMa9m1u/J+SAaXyeg8v/Xprs2bwge/gniv29eoQOXeG2A1TFOO4S0zH
 xZ3OD0fOqN+sKNMEQ3lCNauuXkFYgsu47MpxDABre3BCrg8GdwiJdnf1Mt6/YPGoVf6nLH8Yq
 qOvFiwWduxx6KH/g7og8gHHqygGTxEMT93OGA2dCVX1DIi1LaqHGP1/HYm6N7QsxSa2q7oC/B
 iq5vqqToidTX+XTMdCOBAi1fj5RG0xLK+rEFxEyghF/WuBZwYLb2OPTZ0RtMpyq+yQ5UrZKPZ
 KQpvkolr5seYUsEDV8qkebieJc6yBbKE2Ect8LmEX9DIEqPv7oxmrJfSBt/Fibtv9XX3WW/zX
 22OAQqTKgHj5ER7NLdYUN3FllvZNZAGwZHnkLn9JnwriSP03M4zy8yFsZHegO+nr51PqBiyJx
 P9l4p84ZZuspzCbnlbYJugPCSJAXJkff0Sl9y/JKFHq1nxe/xfF4i1v7EcIN/ET+wb+/z7Ja9
 +BLYptZYoHkcXRLc3L6e/3CzSKBM2lLZMk0XhybREIrq4=



=E5=9C=A8 2024/10/10 08:08, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/10/10 02:27, Naohiro Aota =E5=86=99=E9=81=93:
>> The purpose of btrfs_bbio_propagate_error() shall be propagating an err=
or
>> of split bio to its original btrfs_bio, and tell the error to the upper
>> layer. However, it's not working well on some cases.
>>
>> * Case 1. Immediate (or quick) end_bio with an error
>>
>> When btrfs sends btrfs_bio to mirrored devices, btrfs calls
>> btrfs_bio_end_io() when all the mirroring bios are completed. If that
>> btrfs_bio was split, it is from btrfs_clone_bioset and its end_io
>> function
>> is btrfs_orig_write_end_io. For this case, btrfs_bbio_propagate_error()
>> accesses the orig_bbio's bio context to increase the error count.
>>
>> That works well in most cases. However, if the end_io is called enough
>> fast, orig_bbio's bio context may not be properly set at that time. Sin=
ce
>> the bio context is set when the orig_bbio (the last btrfs_bio) is sent =
to
>> devices, that might be too late for earlier split btrfs_bio's completio=
n.
>> That will result in NULL pointer dereference.
>
> Mind to share more info on how the NULL pointer dereference happened?
>
> btrfs_split_bio() should always initialize the private pointer of the
> new bio to point to the original one.
>
> Thus I didn't see an immediate problem with this.
>
>
>>
>> That bug is easily reproducible by running btrfs/146 on zoned devices a=
nd
>> it shows the following trace.
>
> Furthermore, IIRC zoned device only supports SINGLE/DUP/RAID1 for data
> without RST.
>
> Then there should be split happening, but only mirrored writes.
> Thus it looks like the description doesn't really match the symptom.
>
>
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.923980][=C2=A0=C2=A0 T13] BUG=
: kernel NULL pointer dereference,
>> address: 0000000000000020
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.925234][=C2=A0=C2=A0 T13] #PF=
: supervisor read access in kernel mode
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.926122][=C2=A0=C2=A0 T13] #PF=
: error_code(0x0000) - not-present page
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.927118][=C2=A0=C2=A0 T13] PGD=
 0 P4D 0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.927607][=C2=A0=C2=A0 T13] Oop=
s: Oops: 0000 [#1] PREEMPT SMP PTI
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.928424][=C2=A0=C2=A0 T13] CPU=
: 1 UID: 0 PID: 13 Comm: kworker/u32:1
>> Not tainted 6.11.0-rc7-BTRFS-ZNS+ #474
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.929740][=C2=A0=C2=A0 T13] Har=
dware name: Bochs Bochs, BIOS Bochs
>> 01/01/2011
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.930697][=C2=A0=C2=A0 T13] Wor=
kqueue: writeback wb_workfn (flush-
>> btrfs-5)
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.931643][=C2=A0=C2=A0 T13] RIP=
: 0010:btrfs_bio_end_io+0xae/0xc0 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.932573][ T1415] BTRFS error (=
device dm-0): bdev /dev/
>> mapper/error-test errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.932871][=C2=A0=C2=A0 T13] Cod=
e: ba e1 48 8b 7b 10 e8 f1 f5 f6 ff eb
>> da 48 81 bf 10 01 00 00 40 0c 33 a0 74 09 40 88 b5 f1 00 00 00 eb b8
>> 48 8b 85 18 01 00 00 <48> 8b 40 20 0f b7 50 24 f0 01 50 20 eb a3 0f 1f
>> 40 00 90 90 90 90
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.936623][=C2=A0=C2=A0 T13] RSP=
: 0018:ffffc9000006f248 EFLAGS: 00010246
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.937543][=C2=A0=C2=A0 T13] RAX=
: 0000000000000000 RBX:
>> ffff888005a7f080 RCX: ffffc9000006f1dc
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.938788][=C2=A0=C2=A0 T13] RDX=
: 0000000000000000 RSI:
>> 000000000000000a RDI: ffff888005a7f080
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.940016][=C2=A0=C2=A0 T13] RBP=
: ffff888011dfc540 R08:
>> 0000000000000000 R09: 0000000000000001
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.941227][=C2=A0=C2=A0 T13] R10=
: ffffffff82e508e0 R11:
>> 0000000000000005 R12: ffff88800ddfbe58
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.942375][=C2=A0=C2=A0 T13] R13=
: ffff888005a7f080 R14:
>> ffff888005a7f158 R15: ffff888005a7f158
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.943531][=C2=A0=C2=A0 T13] FS:=
=C2=A0 0000000000000000(0000)
>> GS:ffff88803ea80000(0000) knlGS:0000000000000000
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.944838][=C2=A0=C2=A0 T13] CS:=
=C2=A0 0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.945811][=C2=A0=C2=A0 T13] CR2=
: 0000000000000020 CR3:
>> 0000000002e22006 CR4: 0000000000370ef0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.946984][=C2=A0=C2=A0 T13] DR0=
: 0000000000000000 DR1:
>> 0000000000000000 DR2: 0000000000000000
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.948150][=C2=A0=C2=A0 T13] DR3=
: 0000000000000000 DR6:
>> 00000000fffe0ff0 DR7: 0000000000000400
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.949327][=C2=A0=C2=A0 T13] Cal=
l Trace:
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.949949][=C2=A0=C2=A0 T13]=C2=
=A0 <TASK>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.950374][=C2=A0=C2=A0 T13]=C2=
=A0 ? __die_body.cold+0x19/0x26
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.951066][=C2=A0=C2=A0 T13]=C2=
=A0 ? page_fault_oops+0x13e/0x2b0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.951766][=C2=A0=C2=A0 T13]=C2=
=A0 ? _printk+0x58/0x73
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.952358][=C2=A0=C2=A0 T13]=C2=
=A0 ? do_user_addr_fault+0x5f/0x750
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.953120][=C2=A0=C2=A0 T13]=C2=
=A0 ? exc_page_fault+0x76/0x240
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.953827][=C2=A0=C2=A0 T13]=C2=
=A0 ? asm_exc_page_fault+0x22/0x30
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.954606][=C2=A0=C2=A0 T13]=C2=
=A0 ? btrfs_bio_end_io+0xae/0xc0 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.955616][=C2=A0=C2=A0 T13]=C2=
=A0 ? btrfs_log_dev_io_error+0x7f/0x90 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.956682][=C2=A0=C2=A0 T13]=C2=
=A0 btrfs_orig_write_end_io+0x51/0x90 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.957769][=C2=A0=C2=A0 T13]=C2=
=A0 dm_submit_bio+0x5c2/0xa50 [dm_mod]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.958623][=C2=A0=C2=A0 T13]=C2=
=A0 ? find_held_lock+0x2b/0x80
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.959339][=C2=A0=C2=A0 T13]=C2=
=A0 ? blk_try_enter_queue+0x90/0x1e0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.960228][=C2=A0=C2=A0 T13]=C2=
=A0 __submit_bio+0xe0/0x130
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.960879][=C2=A0=C2=A0 T13]=C2=
=A0 ? ktime_get+0x10a/0x160
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.961546][=C2=A0=C2=A0 T13]=C2=
=A0 ? lockdep_hardirqs_on+0x74/0x100
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.962310][=C2=A0=C2=A0 T13]=C2=
=A0 submit_bio_noacct_nocheck+0x199/0x410
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.963140][=C2=A0=C2=A0 T13]=C2=
=A0 btrfs_submit_bio+0x7d/0x150 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.964089][=C2=A0=C2=A0 T13]=C2=
=A0 btrfs_submit_chunk+0x1a1/0x6d0 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.965066][=C2=A0=C2=A0 T13]=C2=
=A0 ? lockdep_hardirqs_on+0x74/0x100
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.965824][=C2=A0=C2=A0 T13]=C2=
=A0 ? __folio_start_writeback+0x10/0x2c0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.966659][=C2=A0=C2=A0 T13]=C2=
=A0 btrfs_submit_bbio+0x1c/0x40 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.967617][=C2=A0=C2=A0 T13]=C2=
=A0 submit_one_bio+0x44/0x60 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.968536][=C2=A0=C2=A0 T13]=C2=
=A0 submit_extent_folio+0x13f/0x330 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.969552][=C2=A0=C2=A0 T13]=C2=
=A0 ? btrfs_set_range_writeback+0xa3/0xd0
>> [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.970625][=C2=A0=C2=A0 T13]=C2=
=A0 extent_writepage_io+0x18b/0x360 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.971632][=C2=A0=C2=A0 T13]=C2=
=A0 extent_write_locked_range+0x17c/0x340
>> [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.972702][=C2=A0=C2=A0 T13]=C2=
=A0 ? __pfx_end_bbio_data_write+0x10/0x10
>> [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.973857][=C2=A0=C2=A0 T13]=C2=
=A0 run_delalloc_cow+0x71/0xd0 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.974841][=C2=A0=C2=A0 T13]=C2=
=A0 btrfs_run_delalloc_range+0x176/0x500 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.975870][=C2=A0=C2=A0 T13]=C2=
=A0 ? find_lock_delalloc_range+0x119/0x260
>> [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.976911][=C2=A0=C2=A0 T13]=C2=
=A0 writepage_delalloc+0x2ab/0x480 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.977792][=C2=A0=C2=A0 T13]=C2=
=A0 extent_write_cache_pages+0x236/0x7d0 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.978728][=C2=A0=C2=A0 T13]=C2=
=A0 btrfs_writepages+0x72/0x130 [btrfs]
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.979531][=C2=A0=C2=A0 T13]=C2=
=A0 do_writepages+0xd4/0x240
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.980111][=C2=A0=C2=A0 T13]=C2=
=A0 ? find_held_lock+0x2b/0x80
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.980695][=C2=A0=C2=A0 T13]=C2=
=A0 ? wbc_attach_and_unlock_inode+0x12c/0x290
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.981461][=C2=A0=C2=A0 T13]=C2=
=A0 ? wbc_attach_and_unlock_inode+0x12c/0x290
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.982213][=C2=A0=C2=A0 T13]=C2=
=A0 __writeback_single_inode+0x5c/0x4c0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.982859][=C2=A0=C2=A0 T13]=C2=
=A0 ? do_raw_spin_unlock+0x49/0xb0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.983439][=C2=A0=C2=A0 T13]=C2=
=A0 writeback_sb_inodes+0x22c/0x560
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.984079][=C2=A0=C2=A0 T13]=C2=
=A0 __writeback_inodes_wb+0x4c/0xe0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.984886][=C2=A0=C2=A0 T13]=C2=
=A0 wb_writeback+0x1d6/0x3f0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.985536][=C2=A0=C2=A0 T13]=C2=
=A0 wb_workfn+0x334/0x520
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.986044][=C2=A0=C2=A0 T13]=C2=
=A0 process_one_work+0x1ee/0x570
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.986580][=C2=A0=C2=A0 T13]=C2=
=A0 ? lock_is_held_type+0xc6/0x130
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.987142][=C2=A0=C2=A0 T13]=C2=
=A0 worker_thread+0x1d1/0x3b0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.987918][=C2=A0=C2=A0 T13]=C2=
=A0 ? __pfx_worker_thread+0x10/0x10
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.988690][=C2=A0=C2=A0 T13]=C2=
=A0 kthread+0xee/0x120
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.989180][=C2=A0=C2=A0 T13]=C2=
=A0 ? __pfx_kthread+0x10/0x10
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.989915][=C2=A0=C2=A0 T13]=C2=
=A0 ret_from_fork+0x30/0x50
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.990615][=C2=A0=C2=A0 T13]=C2=
=A0 ? __pfx_kthread+0x10/0x10
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.991336][=C2=A0=C2=A0 T13]=C2=
=A0 ret_from_fork_asm+0x1a/0x30
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.992106][=C2=A0=C2=A0 T13]=C2=
=A0 </TASK>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.992482][=C2=A0=C2=A0 T13] Mod=
ules linked in: dm_mod btrfs
>> blake2b_generic xor raid6_pq rapl
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.993406][=C2=A0=C2=A0 T13] CR2=
: 0000000000000020
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.993884][=C2=A0=C2=A0 T13] ---=
[ end trace 0000000000000000 ]---
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 20.993954][ T1415] BUG: kernel N=
ULL pointer dereference,
>> address: 0000000000000020
>>
>> * Case 2. Earlier completion of orig_bbio for mirrored btrfs_bios
>>
>> btrfs_bbio_propagate_error() assumes the end_io function for orig_bbio =
is
>> called last among split bios. In that case, btrfs_orig_write_end_io()
>> sets
>> the bio->bi_status to BLK_STS_IOERR by seeing the bioc->error [1].
>> Otherwise, the increased orig_bio's bioc->error is not checked by anyon=
e
>> and return BLK_STS_OK to the upper layer.
>
> That doesn't sound correct to me.
>
> The original bio always got its bio->__bi_remaining increased when it
> get cloned.
>
> And __bi_remaining is only decreased when the cloned or the original bio
> get its endio function called (bio_endio()).
>
> For cloned bios, it's mostly the same chained bio behavior, with extra
> btrfs write tolerance added.

OK, I see the point. For the cloned ones we can have the following case:

The profile is DUP/RAID1.

For stripe 0, we cloned the original bio, increased
orig_bio->__bi_remaining.

Then submitted the cloned bio.

But before submitting the original one, cloned one get finished first,
it call the cloned endio function, which calls back to the endio of the
original bio.

Then the endio function decrease the __bi_remaining to 0 of the original
bio, thus it continue to call the endio of the original bio, which freed
the original bio.

If it's really the case, please add some trace output to explain the
situation better.

>
> So the explanation doesn't look correct to me.
>
>>
>> [1] Actually, this is not true. Because we only increases orig_bioc-
>> >errors
>> by max_errors, the condition "atomic_read(&bioc->error) > bioc-
>> >max_errors"
>> is still not met if only one split btrfs_bio fails.
>>
>> * Case 3. Later completion of orig_bbio for un-mirrored btrfs_bios
>>
>> In contrast to the above case, btrfs_bbio_propagate_error() is not
>> working
>> well if un-mirrored orig_bbio is completed last. It sets
>> orig_bbio->bio.bi_status to the btrfs_bio's error. But, that is easily
>> over-written by orig_bbio's completion status. If the status is
>> BLK_STS_OK,
>> the upper layer would not know the failure.
>>
>> * Solution
>>
>> Considering the above cases, we can only save the error status in the
>> orig_bbio itself as it is always available. Also, the saved error statu=
s
>> should be propagated when all the split btrfs_bios are finished (i.e,
>> bbio->pending_ios =3D=3D 0).
>
> This looks like it will not handle the write error tolerance at all.
>
> If there is really some timing related problem, I'd recommend to queue
> all the split bios into a bio_list, and submit them all when all splits
> is done.

Talking about the solution, may be we can go this diff instead?

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5d3f8bd406d9..a13f055fec4c 100644
=2D-- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -515,8 +515,10 @@ static void btrfs_submit_bio(struct bio *bio,
struct btrfs_io_context *bioc,
                 int total_devs =3D bioc->num_stripes;

                 bioc->orig_bio =3D bio;
+               bio_inc_remaining(bio);
                 for (int dev_nr =3D 0; dev_nr < total_devs; dev_nr++)
                         btrfs_submit_mirrored_bio(bioc, dev_nr);
+               bio_endio(bio);
         }
  }

The idea is to increase the remaining so that any early finished bio
will not trigger the endio of the original bio.

Or you can also go the old bio_list way, which alsoo should be fine.

Thanks,
Qu
>
> Otherwise we will not tolerate any write failures.
>
>>
>> This commit introduces "status" to btrfs_bbio and uses the last saved
>> error
>> status for bbio->bio.bi_status.
>>
>> With this commit, btrfs/146 on zoned devices does not hit the NULL
>> pointer
>> dereference.
>>
>> Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
>> CC: stable@vger.kernel.org # 6.6+
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>> =C2=A0 fs/btrfs/bio.c | 33 +++++++++------------------------
>> =C2=A0 fs/btrfs/bio.h |=C2=A0 3 +++
>> =C2=A0 2 files changed, 12 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 056f8a171bba..a43d88bdcae7 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -49,6 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct
>> btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbio->end_io =3D end_io;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbio->private =3D private;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&bbio->pending_ios, 1);
>> +=C2=A0=C2=A0=C2=A0 atomic_set(&bbio->status, BLK_STS_OK);
>> =C2=A0 }
>>
>> =C2=A0 /*
>> @@ -120,41 +121,25 @@ static void __btrfs_bio_end_io(struct btrfs_bio
>> *bbio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> -static void btrfs_orig_write_end_io(struct bio *bio);
>> -
>> -static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btr=
fs_bio *orig_bbio)
>> -{
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * For writes we tolerate nr_mirrors - 1 write=
 failures, so we can't
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * just blindly propagate a write failure here=
.=C2=A0 Instead
>> increment the
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * error count in the original I/O context so =
that it is
>> guaranteed to
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * be larger than the error tolerance.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (bbio->bio.bi_end_io =3D=3D &btrfs_orig_write_en=
d_io) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_io_stripe *ori=
g_stripe =3D orig_bbio->bio.bi_private;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_io_context *or=
ig_bioc =3D orig_stripe->bioc;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_add(orig_bioc->max_e=
rrors, &orig_bioc->error);
>> -=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 orig_bbio->bio.bi_status =
=3D bbio->bio.bi_status;
>> -=C2=A0=C2=A0=C2=A0 }
>> -}
>> -
>> =C2=A0 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t statu=
s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbio->bio.bi_status =3D status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bbio->bio.bi_pool =3D=3D &btrfs_clon=
e_bioset) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_bio=
 *orig_bbio =3D bbio->private;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bbio->bio.bi_status)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btr=
fs_bbio_propagate_error(bbio, orig_bbio);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Save the last error. */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bbio->bio.bi_status !=
=3D BLK_STS_OK)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ato=
mic_set(&orig_bbio->status, bbio->bio.bi_status);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_cleanup_bi=
o(bbio);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbio =3D orig_bb=
io;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0 if (atomic_dec_and_test(&bbio->pending_ios))
>> +=C2=A0=C2=A0=C2=A0 if (atomic_dec_and_test(&bbio->pending_ios)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Load split bio's error w=
hich might be set above. */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status =3D=3D BLK_STS_O=
K)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbi=
o->bio.bi_status =3D atomic_read(&bbio->status);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __btrfs_bio_end_=
io(bbio);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 static int next_repair_mirror(struct btrfs_failed_bio *fbio, int
>> cur_mirror)
>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>> index e48612340745..b8f7f6071bc2 100644
>> --- a/fs/btrfs/bio.h
>> +++ b/fs/btrfs/bio.h
>> @@ -79,6 +79,9 @@ struct btrfs_bio {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* File system that this I/O operates on=
. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info;
>>
>> +=C2=A0=C2=A0=C2=A0 /* Set the error status of split bio. */
>> +=C2=A0=C2=A0=C2=A0 atomic_t status;
>> +
>
> The same as David, please do not abuse atomic_t for this purpose.
>
> Thanks,
> Qu
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This member must come last, bio_=
alloc_bioset will allocate
>> enough
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bytes for entire btrfs_bio but r=
elies on bio being last.
>
>


