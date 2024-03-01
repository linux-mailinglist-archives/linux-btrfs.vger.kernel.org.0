Return-Path: <linux-btrfs+bounces-2976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A1586EA3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 21:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842511F25A4C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 20:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86453D0A8;
	Fri,  1 Mar 2024 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S62s3in4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AA3D0DF;
	Fri,  1 Mar 2024 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324528; cv=none; b=ic13MptUxqPI0uV3oOvQ4j1/UBO70oTEtT8gXJtfI2U/UhjE/tDoRt2ivDWm0UrMdtB2NBSQA9jQjz4Vt4Wzu7dDSZ9+yLDDAg3ci7bhJSX4ewhoIyuTb/3qIXdIfbTof433X8EGN5umF/f50WMJG+rXwfftoHhg2W7WMD+PocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324528; c=relaxed/simple;
	bh=vdbqnh5RNmGAKsfLX4EKIq7UzlyBosJQQrRRRXr6T3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ND2s7Gmsl2SQN9PnZxPCyjAgEn/V48u5XnI8bGrXzvPz/V6wTzV/v83RSF6tPzoapBbww/CG9v2ospAGlVJii7j8/FhFECSyKs6tlD1kx9roG/AbLy4568rUushT1oJgvJLMNGXh5XSQXNuJveZ/+zWLI0tazhp/636lqASKdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S62s3in4; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709324522; x=1709929322; i=quwenruo.btrfs@gmx.com;
	bh=vdbqnh5RNmGAKsfLX4EKIq7UzlyBosJQQrRRRXr6T3o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=S62s3in4T4UuzLASHMDyRwJWvG1IksNJXa/vFFc6KVUOEnVl2/yn/1mPmWmHjcF1
	 nkXtSOKnqLMNFZ0ZJZKc2FUyMMUkwBjkIc6ExyNpBrjjTwvw3z9q0RVhA+RtyWm4R
	 xiC/DPmfJq2vMz3I3UpqADg1nXvFTOmnCmf4R5+RZTrBXy2SgJB0w/qsW2ihgFoCh
	 +XB6aZcSVg6tP5Tly6hNyi9T3pkDnVDxQJ+1BWfyWGFwrFycpkKd7M+0cCRtyJLap
	 QpOogRdESyuzkItVhjvROi+k/bAOoOWvZZSzURTJoUo32wZSGPHwipb+f2UXeGBAC
	 /GXAaidkHmcV7HnH5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wLZ-1rmS7W3I7v-007RJY; Fri, 01
 Mar 2024 21:22:02 +0100
Message-ID: <19762dc9-2834-46fd-91ce-26a542356adb@gmx.com>
Date: Sat, 2 Mar 2024 06:51:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: verify btrfs_qgroup_inherit parameter
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <bde2887da38aaa473ca60801b37ac735b3ab2d6d.1709003728.git.wqu@suse.com>
 <20240301120138.GJ2604@twin.jikos.cz>
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
In-Reply-To: <20240301120138.GJ2604@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sIE7zMVdS7HerzU4ApwCegohYa4uGxv7m/7U1esZWBxVtJNr8OC
 p2t/WWwS2bS/rUS9M/klZgLrqJOcf7kM31FbR53T+WnctjmReTldAp9k7ouedRCIy/d4ACt
 M/ebsrjYa0OAfMrE9JV3Pcloe5Sn0MhLs+QQwLJbjGVR73NTEOrAQUdTz1ZC9HqCLt1JR/3
 71MFmgXlPBJIbLOMEwPyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NdmN/0vgahw=;tmLq5+ugDvrm1KGDTZMHHQe3BDq
 xJyox8WlHlcIz0i/3LfMPHK6Cd/cRUh4ZYmU/o2lRKn/d9xRiDMHSSdXLYjZgCh9B1r0vb85C
 zY+6IWttUo0hj9qtx4zt0eegD/0MJDkyDkU9kw9MdmW4Uil5uyCzsSjETtttbQLLc8DqSu0rQ
 6xSA1vQgTj16zNzmanK8O6Yp7PsPEHUcpRz/JTlW/N/anLQr8fpLYk+h0VUZxyb99sYOyRU1m
 vcuqsIfxNBaKbOIRnjLvOEmMCbRn5pACq+t/9NJGlzw6ejE/FYM7kcpCcV+QTNOglu9xcHg+W
 WUl/K8xjm5JbwF191hRTbQckx3M+Lo+UQq+7IxCOy1xLbQp5VsO4X2OphOfxrhFpoO9FIAWJd
 EkIK/xXoYykS2k6ufgUPVzNR7xyIB1OH5BB31OEW9mpdBQ/2usGNtgfqZiM/W7PWfcFjg5pKg
 MecU0cvRKx+jVi+4cCBhm72ihWug6sEAL9RtFH05f3WYKu8RpyFIohFYhYEUIAJokfl4YlpMv
 dtPKJS2z49OhqwsYxtjBBIjvqrryKk1ZDtsrzhDTQE8UrogSThSUSjgWYzO/aP2kyhvf082Kr
 h0gsSUHk5wDNfPpbIQaPHdUoc/AVN4o6Hkd+6hWC0Q9PGzgJsLTYmlxYi84hCJ8/4IleuZOuq
 uAy/nxqqLzm5YaoE1rGyuQjoc2JVvXCE9oO5B7d6dM90Tg1skWRbBvCfJb2pJudIVxjTwLmJv
 VbCeWeRjD6gkUCCPE8pUOonpiUbsqJDKr15NNQGPvlPw/VqoyEU986SgnPpzFD1gU1APQY0wW
 9LeLdfhMabnLox9fVtIrvOuxv8A+ylvNUVy8SmFhrTLlo=



=E5=9C=A8 2024/3/1 22:31, David Sterba =E5=86=99=E9=81=93:
> On Tue, Feb 27, 2024 at 01:45:35PM +1030, Qu Wenruo wrote:
>> [BUG]
>> Currently btrfs can create subvolume with an invalid qgroup inherit
>> without triggering any error:
>>
>>   # mkfs.btrfs -O quota -f $dev
>>   # mount $dev $mnt
>>   # btrfs subvolume create -i 2/0 $mnt/subv1
>>   # btrfs qgroup show -prce --sync $mnt
>>   Qgroupid    Referenced    Exclusive   Path
>>   --------    ----------    ---------   ----
>>   0/5           16.00KiB     16.00KiB   <toplevel>
>>   0/256         16.00KiB     16.00KiB   subv1
>>
>> [CAUSE]
>> We only do a very basic size check for btrfs_qgroup_inherit structure,
>> but never really verify if the values are correct.
>>
>> Thus in btrfs_qgroup_inherit() function, we have to skip non-existing
>> qgroups, and never return any error.
>>
>> [FIX]
>> Fix the behavior and introduce extra checks:
>>
>> - Introduce early check for btrfs_qgroup_inherit structure
>>    Not only the size, but also all the qgroup ids would be verifyed.
>>
>>    And the timing is very early, so we can return error early.
>>    This early check is very important for snapshot creation, as snapsho=
t
>>    is delayed to transaction commit.
>>
>> - Drop support for btrfs_qgroup_inherit::num_ref_copies and
>>    num_excl_copies
>>    Those two members are used to specify to copy refr/excl numbers from
>>    other qgroups.
>>    This would definitely mark qgroup inconsistent, and btrfs-progs has
>>    dropped the support for them for a long time.
>>    It's time to drop the support for kernel.
>>
>> - Verify the supported btrfs_qgroup_inherit::flags
>>    Just in case we want to add extra flags for btrfs_qgroup_inherit.
>>
>> Now above subvolume creation would fail with -ENOENT other than silentl=
y
>> ignore the non-existing qgroup.
>>
>> CC: stable@vger.kernel.org
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: David Sterba <dsterba@suse.com>
>
Just one thing to notice, this would cause certain test cases to fail,
as previously any incorrect qgroup inherit would just be ignored, but
now it would error out explicitly.

IIRC there are 2 or 3 failures, one already fixed.
I'll send out the remaining fixes for fstests.

Thanks,
Qu

