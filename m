Return-Path: <linux-btrfs+bounces-11715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87460A40BB3
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 22:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FAD3AEC40
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4192045A0;
	Sat, 22 Feb 2025 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pMj+qHpO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6651EA7D4;
	Sat, 22 Feb 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740259570; cv=none; b=YdlwEpDQ47HeVqqCxQbmEvc5F8tAyTahfLH0Ak1WXoXDJpk2C4dwFXbecEPKu23Eyv4VIJv7voSllSNF05pN+ppjvqPdpo3lQbgNs9erXdEFgIajCeh951W78Cg5ojJJ8O6Hu2zjer8g4uHXGTUZ/IHyYM8ofFu/CQYUpUqxMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740259570; c=relaxed/simple;
	bh=zkdUltSwxweKekqUvdYkYRfqXEgHX08H/otIUhb080s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRb+pBbbdgrW+8Dc9btGtjDxPXGHddqFgp3vSy8HPbiqtPRsQK+XJuMoj9MzAl9JYGga0Ad76hc7sKXmFWi5ItAFm4j/zo5NDaSfTeoYQvMldEj7/JUn7hCGJ39/Hp5bsHQmzKafoeGF+6glUx05RAKmcK+ZLhbWle3MbwASZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pMj+qHpO; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740259566; x=1740864366; i=quwenruo.btrfs@gmx.com;
	bh=B0Z+LGe6+6+wPWVA93mZwl/w1jcOE+fwYULzwdo601Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pMj+qHpOi61EuVJ8cml1WcUUfIMx0gC/7EgP37Laix6TInjjpt9FoGSI4IzpGZ8/
	 1gcMcKfZDIES0kQn81+qU03LR5+Gg6QcLyJO25fP7fcy1olJ2dN41PpbAadICR1dR
	 ncqntQ3ZKasX8l9UNbFSffVKas/jRnZOSoJ8qpUFADSJWQRSLZvo/coum20O+yn5K
	 oVdpgDwzLlJuiJBe4Lzb/tuSMS5nw6RcQOrDsFoZOrM8Fqr24wM1ySOkfYA2OckxH
	 AXuAWnIF8r6lembd1XCvIZs8JNQPCl9rGnbASKABbeHeY/UffP61ffDdtqVt423Z8
	 2w7t61yzcfdxqjO6+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQEn-1t0ZhK3DuB-00lkGG; Sat, 22
 Feb 2025 22:26:06 +0100
Message-ID: <ddc27f3b-291f-43db-abfb-0f82d8c584fb@gmx.com>
Date: Sun, 23 Feb 2025 07:56:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
To: Zorro Lang <zlang@redhat.com>, Daniel Vacek <neelx@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20250220145723.1526907-1-neelx@suse.com>
 <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iP+weV0aWo5PalCFk+6Lt5aTenytRhC8KLzcfZpp2mS96U9luKq
 5xBhAvel3/ed5fQ17h0vzfuPJr3g99uSMfs5Cnt5Vmz2hr/f/UeIulUDA0lg1wfe5iDGJUd
 h56fFc+HVfGTkYZkm+8BiL9gDnYiZbCvfXE1xbwUuvEQkXTvDKHt5/lmCF0gxFXyz2N5Pu4
 AMUJvArwaTE87QbcTur4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lcVZulCLUrk=;v7x0rmjVSqm1xi3tSGt/GSITXUF
 wLJ+sbmyZtBQYqVd5MBp13V2ObZDvHq2h8D6+ECzmNvXvOiyLdCW0tUkVlql++fAPO39XsSA8
 IAECbbu1sgXxM0Rj6qjWGvtDtYNWmhZKbzrDQr8Yu3qTqdIFPmUjDsN6A4Q8yHzZZ/GXKDIZA
 UxpyohFxa2cKsfMaRNp7ErCqatzR9AE03EPdArXlvkqEf3pm4fzDyqaXGAmp5nxuicpwMQCz3
 aWn2DU2J4yNVxHNnwag/Q3QJ++Z527SBOXnsARhdIKE0i3oOmSVXEIlcVdxLtK/GCSyN5zk4C
 4tJtR0xRPPal16V6k9L9EGD90ZwXV6bypd5rt5aClh7/J5Y/p9U3Tayx1oRzXPl4gHk69sd2f
 BUJdFc3hj9O7o3hi9ogd4txkpkVjtmtMI4VA2JQxKJgCxKM1NcTRQyM9s3kM+E9EtnIm/J281
 mcHusmcdppcb1VFRA05ulSgI9YCEV3Sv210TsF5b/PfEoWRBudfF1Zm7PdST+bmR+KpcdtqUA
 9G2OTbB1gwyFosFw+77tNKVoMGUpQSyo8+rIswoor5wJssLHrLEvOwh79bJObXToVgFLAzIkr
 29cCrg68j5602+fdAOxel1dAY8Ke443rBy/uKU0HnqQ+vGtxZS1Mpfl8lAGOTfETH38KINNNs
 rz9cye9TEhfu66M0BrtmqQJW4EVp0IZzIy8toOHDmKLUnPRhQHqvpoe0mF+OnEjraj8nLgeRv
 XNtxLYuGM1n5qqRHI6zzG45nxURUG4PeWHuvZiCvgcm0eANFa8dN1XZb4JuSb1wNQYEw/Qbta
 7zyKwPn1bHvqxzGZV4VbSMA1IAFlIKTIBnMDZ8t0SySo07IZthKz27a8GYp4BGbWIFvYlZrVv
 Bck4eRGw6aCFgKayWlyCt4PvaOgyT2mufwDL62XuwwQliqAagjFoDJDGTWfd9sBPOldLhV2Jm
 9MxBXeSPUGcuAUYgBlqiDR3QZeTIoJUBoKXaGFRhkXnzAl6BAYcaKOp8le5UkkMGaftIE+J5A
 iX9f6fY6CdaQ6kJb8t/Mna0ACce66tJYzqzaxtMtikD4YVqse0fQGmWzB87oek4ArceiqRjaB
 BjRc7t1Qhd3kLWAedMeL4hSHzfUZw1mSMlvfhKEiLVaieIL4PeWYJ23j7vjFP2OJ9Up5/usU8
 CjzY2fAuWr7eIuGZwafOx74G3cCHR/kgYgGjosUttNHtPTLxKw1CqYd0R5ndfzyoUbiuuV+eg
 kSFH+VAOO/Yfyz33cuQZOTzvi1Sgpl0c6XmHYNLBUJqRkh1pBmTccqiACIyHn0TpZpe4LjrYo
 IygF+HYe7jN6n2PLpIkMcCRY3SHRcMKJR2Pur1p2yEQFXHgov3WVh/qKKzeNCyjWBBPE57VWc
 EWdvtYb/KM9EmJTdTKwzWXKmSvssn4wdL7id5NeMTs5e4GxTsR1QZtoDnb



=E5=9C=A8 2025/2/22 19:07, Zorro Lang =E5=86=99=E9=81=93:
> On Thu, Feb 20, 2025 at 03:57:23PM +0100, Daniel Vacek wrote:
>> When SELinux is enabled this test fails unable to receive a file with
>> security label attribute:
>>
>>      --- tests/btrfs/314.out
>>      +++ results//btrfs/314.out.bad
>>      @@ -17,5 +17,6 @@
>>       At subvol TEST_DIR/314/tempfsid_mnt/snap1
>>       Receive SCRATCH_MNT
>>       At subvol snap1
>>      +ERROR: lsetxattr foo security.selinux=3Dunconfined_u:object_r:unl=
abeled_t:s0 failed: Operation not supported
>>       Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt=
/foo
>>      -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>>      +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
>>      ...
>>
>> Setting the security label file attribute fails due to the default moun=
t
>> option implied by fstests:
>>
>> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sdb /mnt=
/scratch
>>
>> See commit 3839d299 ("xfstests: mount xfs with a context when selinux i=
s on")
>>
>> fstests by default mount test and scratch devices with forced SELinux
>> context to get rid of the additional file attributes when SELinux is
>> enabled. When a test mounts additional devices from the pool, it may ne=
ed
>> to honor this option to keep on par. Otherwise failures may be expected=
.
>>
>> Moreover this test is perfectly fine labeling the files so let's just
>> disable the forced context for this one.
>>
>> Signed-off-by: Daniel Vacek <neelx@suse.com>
>> ---
>
> Take it easy, Thanks for both of you would like to help fstests to get
> better :)
>
> Firstly, SELINUX_MOUNT_OPTIONS isn't a parameter to enable or disable
> SELinux test. We just use it to avoid tons of ondisk selinux lables to
> mess up the testing. So mount with a specified SELINUX_MOUNT_OPTIONS
> to avoid new ondisk selinux labels always be created in each file's
> extended attributes field.
>
> Secondly, I don't want to attend the argument :) Just for this patch rev=
iew,
> I prefer just doing:
>
>            _scratch_mount
>    -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>    +       _mount $SELINUX_MOUNT_OPTIONS ${SCRATCH_DEV_NAME[1]} ${tempfs=
id_mnt}
>
> or if you concern MOUNT_OPTIONS and SELINUX_MOUNT_OPTIONS both, maybe:
>
>            _scratch_mount
>    -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>    +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${=
tempfsid_mnt}
>
> That's enough to help "_scratch_mount" and later "_mount" use same
> SELINUX_MOUNT_OPTIONS, and fix the test failure you hit.
>
> About resetting "SELINUX_MOUNT_OPTIONS", I think btrfs/314 isn't a test =
case
> cares about SELinux labels on-disk or not. So how about don't touch it.

Thanks for the sane final call.

Exactly what I want in the first place.

Thanks,
Qu

>
> If you'd like to talk about if xfstests cases should test with a specifi=
ed
> SELINUX_MOUNT_OPTIONS mount option or not, you can send another patch to=
 talk
> about 3839d299 ("xfstests: mount xfs with a context when selinux is on")=
.
>
> Now let's fix this failure at first :)
>
> Thanks,
> Zorro
>
>>   tests/btrfs/314 | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>> index 76dccc41..cc1a2264 100755
>> --- a/tests/btrfs/314
>> +++ b/tests/btrfs/314
>> @@ -21,6 +21,10 @@ _cleanup()
>>
>>   . ./common/filter.btrfs
>>
>> +# Disable the forced SELinux context. We are fine testing the
>> +# security labels with this test when SELinux is enabled.
>> +SELINUX_MOUNT_OPTIONS=3D
>> +
>>   _require_scratch_dev_pool 2
>>   _require_btrfs_fs_feature temp_fsid
>>
>> @@ -38,7 +42,7 @@ send_receive_tempfsid()
>>   	# Use first 2 devices from the SCRATCH_DEV_POOL
>>   	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>   	_scratch_mount
>> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>> +	_mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt=
}
>>
>>   	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>>   	_btrfs subvolume snapshot -r ${src} ${src}/snap1
>> --
>> 2.48.1
>>
>>
>
>


