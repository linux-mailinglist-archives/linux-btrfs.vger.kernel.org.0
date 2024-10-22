Return-Path: <linux-btrfs+bounces-9051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA29A9659
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 04:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD27282E1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 02:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5856A13DDAE;
	Tue, 22 Oct 2024 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Su73OBpG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F033DF;
	Tue, 22 Oct 2024 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564951; cv=none; b=qkBIhJjd7wCYVvefaD8mOLBd4XUi7wQMiWF4eMSJPgP0kS9CfgiVrYIB1heTNabXyILeY9LGt/y8R+vUVCpq6vzOiAWXguN8KR0svzVZjobok1J+0VzWHn15D79stYGiqHtv+HqDBQE8Ccl/zjLioe/gHScQ7wUb+pSG74hpU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564951; c=relaxed/simple;
	bh=vctIXWmv+y2h73SHSOtYX9njbjSEkOTAEGfaypXWRM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkAxjnTFhTokq5/vQge9nb3Zm8V7KvTxyRHiV8ZkfRorlVpCjDS8WzgTzD8nDi74OGN57iXLM6h3AeCUvSyLTxXVrGZKA1WzpHNG2LvKEWlpVje/ffR5wvm0GdLuGsB91r/BmDXGH/efUMauCWqTRgu/kWOZumG2wWubhhi/MaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Su73OBpG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729564940; x=1730169740; i=quwenruo.btrfs@gmx.com;
	bh=4mmlFlPy34tGHI0x3Rwke7i/prDVoiNlBH6XHU+Vj+A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Su73OBpGAGfsc7R6dgeYsOclD6xShA0VRxI9brgDK4EdHh7xEzGF79oAkP0qaqSM
	 NQCaNVnZQCim/QdbgQbDmrt+akyIpjm4krgk039EgQ7LSFFe70ZpHjLexzvlGp1bj
	 4RZEUvEvelBiMNra9Se1chcAO0sDRMZIpvoDb4UjlT56aHXx8JdMtcLxWEAPNL5wG
	 RLyFas0Yv6wp1OYxEietrYf9pXIDfYcB4BQusChXgFTume0WFTQhnS2YAMeoU2osD
	 xWYLLV6lTV3DTIRrK7QNnrdw9Y0Kc77U4IJeFa7EJ20Wl/yNKXET6db4pZrNl8Yrp
	 tDumb8HhBBH4L+dJ2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIx3C-1tMPDN3R86-00KT10; Tue, 22
 Oct 2024 04:42:20 +0200
Message-ID: <8f1acfa5-37f9-4deb-af9e-d2f7576e0c26@gmx.com>
Date: Tue, 22 Oct 2024 13:12:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/012: fix false alerts when SELinux is enabled
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc: Long An <lan@suse.com>
References: <5538c72ca7c1bf2eb0ff3dbaa73903869ba47e95.1729209889.git.wqu@suse.com>
 <96e09109-1b9c-4f15-a07d-26501ed891a3@oracle.com>
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
In-Reply-To: <96e09109-1b9c-4f15-a07d-26501ed891a3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sK0QMJwiEiwKTNbYb/Zz95vli7wozWnKnRGBLWmdkV/dh+JnNxV
 mnImjxpmwiDpCrclxTDAMQHKd43O0w3Pk9QhqJ3+CgiA0LD4VJAxP+2KP7B1HSVWoC2E3SP
 RL5yMP/8zcCuXHAkkKLy7x/OHMAWKyFVXHGiI1swzVhtOgZQtvvuTHt5zDUdjOhewlnjqh5
 /MoHQKzl44d9lQuwF9uLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LJ29rqD6bsU=;0RIaKX+7FTTG0NibKzffxKSep34
 ge+0kQPL9jgR/HyiGGsSkeUTBP935V7/4WjgF43dyOGq3xRvMXcQJIeVRj60rVjDDhdNBc9aa
 rR4JR7p9wa8lR669fEZlR/ymHSTwUJbVPLZWfNZ4fYSCntikBDc699wZ21fI7KhqSaktgn1Z8
 EVsCUAvKzDBYjeGrq5ODGlGEhrMTJVJ1Q+0SNf+E9NiLuzQv/YMgJV62P4i7VMXEsUHqSD25t
 CzdgXB7mK8/wXpfWi70GJhvXMKNHI1c3SejPFMFvz9QSD6oAiGHYKXSiO6z2X2WrnU20ciBQe
 +JKRMut3ZoDKaZJUxMb1ndIILKLg5vY4fkBEzyKTsAAICa9MZ9pDsofc6k3IHBRxmYYQIxM7R
 t3tnR8j+rAC2YEhoR9dq16nVmDLAfNbelbcc4GOeyPotJJs9Ejz/nsQuVsJEg+qnaEsoVdN8s
 XwiyKvKYj4OVEbAphUZY+lSUK4XNr8Xq0U2zyfXDozgjpvhLkhOQJJ32BLfjgbeinayNGDgx5
 ixrOVYaXZCKSL3mLCvf8UH2U9cTpM0e1QZ/vLBuEL5rZAjEGLW8vfYJIde1Kwm5m5fZQv/zOv
 gdN+CIbfZEv46JVQ4nKcm9e7qLm1KhQ1SSYECNDasJztiYbcHdnCia7bYlNPGSLD1MpqRnsSH
 +6bVT8T7ayd92ErTygc73AsZSLYPztY5RubJzQzr0zZ1iehb4Fck5ft/PqdqMDsO2x8DyhXBk
 e9nSH/YVDkcqQpx3s30QGjbZqJAbmXaYxgESfudjLYCtIvDkH6DLlK6S/AXSEo8WAvq6ePyt7
 OEojM7PdhUgB8k0TiTJdy1hg==



=E5=9C=A8 2024/10/19 08:45, Anand Jain =E5=86=99=E9=81=93:
> On 18/10/24 08:04, Qu Wenruo wrote:
>> [FALSE FAILURE]
>> If SELinux is enabled, the test btrfs/012 will fail due to metadata
>> mismatch:
>>
>> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs
>> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 localhost 6.4.0-=
150600.23.25-default #1
>> SMP PREEMPT_DYNAMIC Tue Oct=C2=A0 1 10:54:01 UTC 2024 (ea7c56d)
>> MKFS_OPTIONS=C2=A0 -- /dev/loop1
>> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/loop1 /
>> mnt/scratch
>>
>> btrfs/012=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch (see /h=
ome/adam/xfstests-dev/
>> results//btrfs/012.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/012.out=C2=A0=C2=A0=C2=A0 2024=
-10-18 10:15:29.132894338 +1030
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ /home/adam/xfstests-dev/results//btrfs/012=
.out.bad
>> 2024-10-18 10:25:51.834819708 +1030
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,6 +1,1390 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 012
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Checking converted btrfs against the ori=
ginal one:
>> =C2=A0=C2=A0=C2=A0=C2=A0 -OK
>> =C2=A0=C2=A0=C2=A0=C2=A0 +metadata mismatch in /p0/d2/f4
>> =C2=A0=C2=A0=C2=A0=C2=A0 +metadata mismatch in /p0/d2/f5
>> =C2=A0=C2=A0=C2=A0=C2=A0 +metadata and data mismatch in /p0/d2/
>> =C2=A0=C2=A0=C2=A0=C2=A0 +metadata and data mismatch in /p0/
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>>
>> [CAUSE]
>> All the mismatch happens in the metadata, to be more especific, it's th=
e
>> security xattrs.
>>
>> Although btrfs-convert properly convert all xattrs including the
>> security ones, at mount time we will get new SELinux labels, causing th=
e
>> mismatch between the converted and original fs.
>>
>> [FIX]
>> Override SELINUX_MOUNT_OPTIONS so that we will not touch the security
>> xattrs, and that should fix the false alert.
>>
>> Reported-by: Long An <lan@suse.com>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1231524
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 tests/btrfs/012 | 5 +++++
>> =C2=A0 1 file changed, 5 insertions(+)
>>
>> diff --git a/tests/btrfs/012 b/tests/btrfs/012
>> index b23e039f4c9f..5811b3b339cb 100755
>> --- a/tests/btrfs/012
>> +++ b/tests/btrfs/012
>> @@ -32,6 +32,11 @@ _require_extra_fs ext4
>> =C2=A0 BASENAME=3D"stressdir"
>> =C2=A0 BLOCK_SIZE=3D`_get_block_size $TEST_DIR`
>> +# Override the SELinux mount options, or it will lead to unexpected
>> +# different security.selinux between the original and converted fs,
>> +# causing false metadata mismatch during fssum.
>> +export SELINUX_MOUNT_OPTIONS=3D""
>> +
>
> SELINUX_MOUNT_OPTIONS is set only when SELinux is enabled on the system,
> so disabling SELinux will suffice.

Are you suggesting to disable SELinux just to pass the test case?

Then it doesn't sound correct to me at all.

It should be the test case to adapt to all kinds of systems, not the
other way.

Thanks,
Qu

>
> -------
> fstests/common/config:
> if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : ${SELINUX_MOUNT_OPTIONS:=
=3D"-o context=3D$(stat -c %C /)"}
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 export SELINUX_MOUNT_OPTIONS
> fi
> ----------
>
> Thanks, Anand
>
>> =C2=A0 # Create & populate an ext4 filesystem
>> =C2=A0 $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>=
&1 || \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _notrun "Could not create ext4 filesyste=
m"
>
>


