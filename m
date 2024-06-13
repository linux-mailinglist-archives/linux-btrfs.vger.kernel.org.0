Return-Path: <linux-btrfs+bounces-5685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A175E905F99
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F9CB227D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0057FD;
	Thu, 13 Jun 2024 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pRHQbfC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0438F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237477; cv=none; b=scu36Z46r5G2Xj1sR/fmbEzS3+hkagS6vgxkJ2dqswKGtz3Ln3dxlhKIwYey1izE2mlYJ9ebjjQZf/QlCWT5GgFkjxO/LpZmS0KqGsKkSdhAAGVfcRwviQsrrLTaYkrM0iHPETHb5MiqNV1UPmzZU83gCdQ+Xsem5cB5aZyWY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237477; c=relaxed/simple;
	bh=RjslK5gAGxjo9BkzvlPvG8EwijqCF/45PwXy0O4GCB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1uYoTxckcLVfBqCdlP6jHmXPtT1X4aL+WtuNCZcqs7YgRGpAvtapwE9jgj2allU0gtrHwbXt9EYHJKral4qeAZrTCDgFT8xj2bxosXfBoCIl/kK0MTP2HZ9sT5++ShCQ6OlDmCOcA1dW8WrpG1AANd00nRq7UjgykOL93VsjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pRHQbfC0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718237465; x=1718842265; i=quwenruo.btrfs@gmx.com;
	bh=1k9cI0fJoq5Lec1xTLRWjj3g75+Gm/5FDkFowYXl3pE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pRHQbfC0wqmNwnXuOpWEFNUHf/w89TTbpbfmPMxG0SIlm0jzLk6fRzoAmjj3lhJ/
	 J3rD/no3R9h1fJnML0cyQCStgLDcVu47YqPjPVQEV6TQsy5AwbUvsiZBugYPRaHVg
	 Litg6RgK2wb/OnmSAuxKvTuzpDM2aLnsbkBcm+qG+DLmiCksAvyBPeZ5fwU54ClEp
	 Kh6Pe00TdPqXRarFbj2+Qi+8/iilf4od7TWpBM4BtMsQct4x3hdnwSckTx1ymsVBC
	 wYGRTxU9BWiwDSLw9WdaqbaFrW2ygFevgABUY96jBwPPYzNc1h/LqOi/7Bcosi2/w
	 bdoyY7NBVtQQtWvV2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHMP-1sg7F30rzF-00faHL; Thu, 13
 Jun 2024 02:11:05 +0200
Message-ID: <cd0fca3a-94bf-4913-882f-ee433a61e06f@gmx.com>
Date: Thu, 13 Jun 2024 09:40:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
To: dsterba@suse.cz
Cc: Srivathsa Dara <srivathsa.d.dara@oracle.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "dsterba@suse.com" <dsterba@suse.com>
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240612203743.GQ18508@twin.jikos.cz> <20240613000200.GS18508@twin.jikos.cz>
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
In-Reply-To: <20240613000200.GS18508@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u9HPxqa/Grw4wUh2OzHAIuKmDfCHEljLJ7K+0IrAsYJ03FW4Ka8
 yjmQhfAq8NdmvnSCakklDP52H0gVfW0KXJUdBgaKLEz9TpJDOuiwTLSwjN99AINjwoOqq0J
 VswXCyaLQsdGpPxBQI3IAwIdQzf+SyKH0xOCgrRiKVCkqnvUlOCo3+hBu9nea/T58mRfLeX
 p7yVjWhD/8/xcHWEvFsDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p1hkogNhhEM=;FmETSP7TCbvt+TLlImwScU6q1x0
 KVei+EQ6rA1fpsuPX/+daZdtTK1K/eETZC6Hev2MGNi9rOpMePpXjRowIR/9fBsDPcv3RJf8w
 M+dirn3JLxrhNhQWMX4hcUaQSYb6Jb2Dl2fg84NU5ugvtRqxyV8MmCIF4DsRCKt/FvcAL9Vom
 06X/p+JtVrD0YwQoLSHN2lBcYyILOrkcMU1tyacD5NML4N6/UKUUo7A9gU8XMXAYImC10qjTr
 8sNa2o/CZvsN+tzKMbGe3nH5ZWIfxD6HNBpe5r3h0kBLYI6kmxK8my8p+NemALQILzjq5gpbj
 3TA4LwLdDBSEVjB+1+phk+97gdysGkl9Cn/gAo2WhI1OtCexRWnrFrTKR7afMzYKe2PhUrkyj
 F5evEYXJVqGydYnRjxHssq1TPFIRSb/6+474/UaOc3iLls1cluY/6CW14i0dB1wnuo1XNJjxO
 1Bi8o2klg4rIgm/xOmUzSWXYTKzRGvpZwoCdbbUvxpK6uGHkhQZNdQoi1DK0sbn4xwz0udk+C
 2HiV6693sAPsMp3gET023KOgK7lc6K6A8h7qzN6EORaqJ/G1KgIqQsB2TxTBJJ7ZjLZhVi9sA
 BHRo9TDmRyQaB9mLW8BN14BKHhFdm7ZzmbeIomuCU2KZBHbK1FcIvMsmvsJdD27VmMO8XeD/4
 rGZAD3z6gGwI2hQ2M5FOGv1oYzhvbpwgTXByylhMt4nXfOfXR7+wgSZjvJmueGP+nHJIPWqL5
 GKWY/9eYTmwIckGKoDHUhKz8utWalL5APoLnJ2Cq7VV7dAium/0VAUL37xNdEqMX3QPJFGjEu
 UBrj2g5m5/hOy6UtPNnPTHzkjtfviydp959Kfqh9qPDao=



=E5=9C=A8 2024/6/13 09:32, David Sterba =E5=86=99=E9=81=93:
> On Wed, Jun 12, 2024 at 10:37:43PM +0200, David Sterba wrote:
>> On Tue, Jun 11, 2024 at 06:03:30AM +0000, Srivathsa Dara wrote:
>>>> =E5=9C=A8 2024/6/6 19:52, Srivathsa Dara =E5=86=99=E9=81=93:
>>>>>    	if (err)
>>>>>    		goto error;
>>>>> diff --git a/convert/source-ext2.h b/convert/source-ext2.h index
>>>>> d204aac5..62c9b1fa 100644
>>>>> --- a/convert/source-ext2.h
>>>>> +++ b/convert/source-ext2.h
>>>>> @@ -46,7 +46,7 @@ struct btrfs_trans_handle;
>>>>>    #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_ra=
nge
>>>>>    #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
>>>>>    #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
>>>>> -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
>>>>> +#define ext2fs_blocks_count(s)		(((s)->s_blocks_count_hi << 32) | (=
s)->s_blocks_count)
>>>>
>>>> This is definitely needed, or it would trigger the ASSERT().
>>>>
>>>> But again, the newer btrfs-progs no longer go with internally defined=
 ext2fs_blocks_count(), but using the one from e2fsprogs headers, and the =
library version is already returning blk64_t.
>>>
>>> Okay, got it.
>>>
>>> Tested the code base with the commit c23e068aaf91, it does handle 64 b=
it block numbers.
>>
>> So, is this patch still needed? I'm not sure after Qu fixed the
>> iteration, the tests pass without the patch too.
>
> Locally the test succeeds (e2fsprogs 1.47.0), however in the github CI
> it fails with:
>
> mke2fs -t ext4 -b 4096 -F /home/runner/work/btrfs-progs/btrfs-progs/test=
s/test.img
> mke2fs 1.46.5 (30-Dec-2021)
> mke2fs: Device size reported to be zero.  Invalid partition specified, o=
r
> 	partition table wasn't reread after running fdisk, due to
> 	a modified partition being busy and in use.  You may need to reboot
> 	to re-read your partition table.

The error is from mke2fs, and considering how old the version is in CI,
it may be e2fsprogs itself unable to properly detect the 16T file.

If we begin to start add checks on e2fsprogs, it's going to end up ugly...

Any good idea to go forward?
Update CI (which seems impossible) or make the mke2fs part as mayfail
and skip it?

Thanks,
Qu
>
> This is the updated test case 018-fs-size-overflow and in the code the c=
hange
> is the updated definition of ext2fs_blocks_count.
>
> I'll put the test case to a topic branch and remove it from devel so the
> CI can be used. You can open a pull request to verify if things work.
>

