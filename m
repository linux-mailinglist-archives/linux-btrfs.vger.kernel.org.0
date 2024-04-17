Return-Path: <linux-btrfs+bounces-4327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80ED8A800D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C08FB22D45
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA60A1332A1;
	Wed, 17 Apr 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mQsN3bbb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2413A3EF
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347040; cv=none; b=TZPoeOcb0N3CO/0P5xLx8QrEWgZT6hneiRje+2djHB26kOvBP7Cc6/yRTB2TH1wphesFZzbamvnDpc4TMRDtIOClruR18zZgJ35pGoa8WeZmduEGt9eTcQZwW1FeFeJjXyC9aODGF6mAduCyNN/OZWxT/owJb3iSZq17GduFA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347040; c=relaxed/simple;
	bh=+brg5eNBeAJM8UAZfj98XJby18uWEBA92pBQUK755ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhfbwT3pFeqweZkTSLUjsY4mUajIzO1V2uauhnvNMfW5ByIpHlOIRoGERT+8zBxsi8V2KPxMLab7Dk7HOCaSFPm3K5XVNAk9gJVj/dZpugZVUURjVku1z3JAgP0JgPlpxNC8LmbXarHRoVT7ul9kmWykTDbipeq9pGjusJnM/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mQsN3bbb; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713347027; x=1713951827; i=quwenruo.btrfs@gmx.com;
	bh=MZGP6odIcmUc121lPFSN8NzideOo0HhzE2KO4zGZvCk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mQsN3bbbjunfzUHdFjSUpEvSt04HapjhLbwXHU4GDIBcQ94/2QV+EDQGFqDDvkgx
	 Z6mvFI5oum1nPHV1q5I4JTlhtL3CcQQJOuGYUnYLEXKnZ5JNAUAtSXH+qalIsUDla
	 cnLafYEsFQrEAzxfokanibNOGBhV1OcvutmxOJZItd/9BbxznOEvE8CUCpkEEJ7R7
	 bPQoiV3mYNGFF/62Vz8WfY4fF7/a8bcsRLsTVeP9iX7F6B287d+3W/yHgcEmuuFUs
	 v/PDQ4vC0syW9Y0/ElNhv6e+Jbl8svhVwoLhP9Jw5Oouv+3T/kO/gYt6BmXVs90NH
	 YWo6mCvsPKVSAErMzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXXyP-1sEz7t48tj-00Z2dC; Wed, 17
 Apr 2024 11:43:47 +0200
Message-ID: <6b117d3d-4a0b-4701-8e36-fe1e3c682805@gmx.com>
Date: Wed, 17 Apr 2024 19:13:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix information leak in
 btrfs_ioctl_logical_to_ino()
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: josef@toxicpanda.com, dsterba@suse.com,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com
References: <93ee5e5a0e35342480860317b1c3d4f5680f7e54.1713344114.git.jth@kernel.org>
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
In-Reply-To: <93ee5e5a0e35342480860317b1c3d4f5680f7e54.1713344114.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I1xgZDVBtQGEyAbSwP2UFDEhmVSgPWm5MX3rgwouNs9IJRLrPP1
 RVH1OHNZ3KmIqWqf0GVBU2MmAHWWmNWr+zG4nwkhqs9Z87Lfc0od2tSE62pGvSqwX/frM9k
 xWm4I8oJ+7CEX/Voyqn0VR9QEVP5FdWElDqpvVhSZzTWhlIm4qaFjI9hTxCEveYKXlh/Jif
 drNK86Dh4f0CawbetZDCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zmLAhM+EcgQ=;+DSj/97b08arGCRZlSFzwCE7wvR
 apaivf+FgkMbDZp4JBP2Ogw21IKP28BsNx+8gPDPlx8gXK0A7fXwLlMlDOlRzdLignIDdbmbG
 2cL55Cva44S+EWVc4ZrHMmAJUqcERcOBrUwAe/1t9N+m+h/+GPTsIavbFiSyZntsrTbL1A0nE
 KRntR45fMJ2p0GW4l0E1rKdROfDKRtfBHd3MR4mTp5G8cyZ49umppiFWlmv3BxBnIQbu8Bqiu
 VW47T5K9Aws+YgJmMT+8ETX7n3D5HBdtfTmMCr1OYof0ES6khd2wMLDdYrYz5Bq/6x9cxGrA1
 C+BW2HF57x1SAVGR0rYNisBVIAnlqG6VrzwgsaeMcLD02QpojM5STo3j1myksj5DxiooXQTbf
 Z2L5I5P5xs7p9wADqpJZZwRKxS7MvP0seyWN6Vtfdv1TFpMCXL+ESeV5mCAyf/nelMGiGqzkN
 6WJWgjJvHQAew+5besGCLkcrU0upHKJ1PY59RfsThqVpR4uoBscKCUkefyiUoeVpI3h/gEOGG
 k55YWF5g6DNQSkkIOSU9N7gkCFRUNvFUTxSK74nsIW7q0ll8fJWVOhw3yQE0BK2Q2fkD81XJV
 OkSmhSVPAT3vOiM4KgsiwvFqKuSmDn/HHgDUs7gA+jgX5facGgI6xiZ7TFF+ztcSNGfvVruMX
 K/T8zOlIGhXnHcSkQrlApLK+d0oD8cAMEQmsguvF7olY69el+uZ8Bs2cTH4IdEhNR8FLq3msz
 4nz8b3R2LO7pPRS4l8sv8GqpBl7J/jHQhX0mjDdFscrA/FPug8dZwpUrBP0QPd2DBgCosbw7/
 yqytfJZZoE97poWA2WuY3/Y4SgLxcHQ066WMVZhc5aRw8=



=E5=9C=A8 2024/4/17 18:25, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Syzbot reported the information leak for in btrfs_ioctl_logical_to_ino()=
:
>
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/ins=
trumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:4=
0
>   instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>   _copy_to_user+0xbc/0x110 lib/usercopy.c:40
>   copy_to_user include/linux/uaccess.h:191 [inline]
>   btrfs_ioctl_logical_to_ino+0x440/0x750 fs/btrfs/ioctl.c:3499
>   btrfs_ioctl+0x714/0x1260
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:904 [inline]
>   __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>   __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>   x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.=
h:17
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>   __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
>   __do_kmalloc_node mm/slub.c:3954 [inline]
>   __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
>   kmalloc_node include/linux/slab.h:648 [inline]
>   kvmalloc_node+0xc0/0x2d0 mm/util.c:634
>   kvmalloc include/linux/slab.h:766 [inline]
>   init_data_container+0x49/0x1e0 fs/btrfs/backref.c:2779
>   btrfs_ioctl_logical_to_ino+0x17c/0x750 fs/btrfs/ioctl.c:3480
>   btrfs_ioctl+0x714/0x1260
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:904 [inline]
>   __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>   __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>   x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.=
h:17
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Bytes 40-65535 of 65536 are uninitialized
> Memory access of size 65536 starts at ffff888045a40000
>
> This happens, because we're copying a 'struct btrfs_data_container' back
> to user-space. This btrfs_data_container is allocated in
> 'init_data_container()' via kvmalloc(), which does not zero-fill the
> memory.
>
> Fix this by using kvzalloc() which zeroes out the memory on allocation.
>
> Reported-by: syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com
> Signed-off-by: Johannes Thumshirn <Johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/backref.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index c1e6a5bbeeaf..4b993c7104fe 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2776,7 +2776,7 @@ struct btrfs_data_container *init_data_container(u=
32 total_bytes)
>   	size_t alloc_bytes;
>
>   	alloc_bytes =3D max_t(size_t, total_bytes, sizeof(*data));
> -	data =3D kvmalloc(alloc_bytes, GFP_KERNEL);
> +	data =3D kvzalloc(alloc_bytes, GFP_KERNEL);
>   	if (!data)
>   		return ERR_PTR(-ENOMEM);
>

