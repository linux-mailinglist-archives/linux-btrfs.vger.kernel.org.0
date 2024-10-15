Return-Path: <linux-btrfs+bounces-8946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D92799FAC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 00:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA8A1F228AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C451B0F11;
	Tue, 15 Oct 2024 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="btzyTYje"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0721E3C4
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029652; cv=none; b=l20EYa9y8Rv++Poj/91rdStv/oIy8T64YuAOsA1N9iUjgdP30AxDwc6bDpfwtHS6LKnclPaLY1TyM4HoNvvJIrwnoEXjUKWVCO/OnOSiIROrJSGYb25VuBR5cXObw+cvwMk8gHYpPpVbAnTDHJS5ASSZwy4og3mJhp+wApAjcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029652; c=relaxed/simple;
	bh=/nOEAoEYq6oPKZkY+Iw29T+EJXl8UFb7himILPfR0mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iAJeZirB9XTpuLA4XomTeQEKlWqTOv2J68moFcJ6tElJ7jQQCAxBWlzSiEUuZOwFZ09/PsvGIySoTZObxXs1s0mqTTprSQC9GCATcJ9ugeXuUkPJxr1BqkFsXZbthicW50FmEVXly/84lrwlW/sXI9h2EAL0ExSrzIlw/OlSxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=btzyTYje; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729029642; x=1729634442; i=quwenruo.btrfs@gmx.com;
	bh=q63yc4BMYDZCx0cqIZmNCfRZIfs5iBOwK+mwqAgnJXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=btzyTYjelRV7lf/MVktP2YaeOZZHRhKS4ZE2TLmiU4auWhQN/z9irc0B3YsNc7qV
	 vIKgx3UpQWEDO9fvTBBaQygraX10NmaZoHFKPi5uZ7tZ0c+Pw7a/pweOmmLNtzmUZ
	 RdGcAq1BkKrfYHJu4BSv7m1P3dNvZ2MmVRqlMT1J2Fw4rOyKLpn9Gjeri3UylkXdf
	 syAuNan33UwhOpznYb95yu/4wfPrQAzqMPp18Qh8x7AkfIcxB9rXXhEAfuBYIPB7p
	 id9zcR7cnM8w33VpT7kyEp78LK9t8oXUWiT6N9L3bWMlfgc92KfitZn7MWKUP75M6
	 68M40R2+jS954Vfl+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ml6mE-1tfMU11u7Y-00ZYWy; Wed, 16
 Oct 2024 00:00:42 +0200
Message-ID: <08994c44-da91-4944-8b9a-4522865e4faa@gmx.com>
Date: Wed, 16 Oct 2024 08:30:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
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
In-Reply-To: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eYll+iSq5rfwAM196CLI0cmrvKjftQMTnSsy7uB0WoVVGCpJVpc
 pSK+8qCR6sgJJ4Cj2ZImlNF6mMJRvJwM3CYuMe+sYalyv0DckDkD6/SeuNWZ7QFnI2CWL1K
 p47Ccw0oXXaZYhwBnsQrGQuzCqp/bpsmh73DO9WyMc2kuo5yndY38eFt2Cot7G6btdnVxyE
 8tDMYC8Hn3YJhddNn8rjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jXGx+neLCJw=;cX0ZxoGn2ZS0mt+Ul3h6rMck2yP
 KF8vas22+byPRG0RF9TyR//3+Q1LXNJ9DN0li3WMPjAQGNKIrYGczHuIIPi+p6GkRZMybKiko
 Q3xsS7CuZCyt/QqjqrLUD50RH+/qcUYAmD8i8fkgBcUyaKvurupS3aLWcpb4kVxLb5uSgvhby
 pqQtNRtD9/yl1I3vwqe46lk3GmJEL7XbU+MCai3v1PMQO5R99/L31Ef/Lb2Lo8fooUhpJlc3X
 Iy16m23FAgxU9fH3yqweuWX3gTAoj16qu0v5Anjh1WAM536sFdg2ZQJasNDspyzJH+tda7D3F
 K1XIxFcGPAIBknqXle8mUFjKYNHrmZe6y/8FisYiuw1IiD+o5Gdi8u83fDVL4Ybwph+EX83vH
 lPSFEA4zIB8gbdDJf/KbLTQiYavbElP0IeIq5Ygi0rWNmPjcflmFC4jehAiZtUasTMhmjGVgB
 PWI8H00tkoe2ojTi0asz766K1VuifacW2VPtW3AamU9rRK4ySfTlukatmsD/s9PKi7EF5SAL/
 XPSnNv6eSxWVsoN/i8pvs3t06hG/As/8ooQxe9EGuucJwJJuaOi2W1FIkXs2ekn4nDoPw/k1q
 lqTu6b/XouflGAiNJg/z3s9vop4Y854saZE/R1hJGkKEnL2HfLEAiVtAPZUaFq1WNel50Y1f3
 eXm8s+nUq0FfRuqby2sgH84Wg+AzNrc7wrug6oCaiyv32qzIb5vrnzzwHgrMgQsK6zaxna05j
 pnxVoH1SkD4ZMCfQ7iBpgGY8PDVJRltghJUYZ6cMfZTpTTWaxfeNZR0bI0MqlZl2W7LkpjfjI
 jnHwik69jCGrtJQ1zohN5+Wq07Mx6XSLX/1Dfgp77YOLg=



=E5=9C=A8 2024/10/16 08:08, Boris Burkov =E5=86=99=E9=81=93:
> If you follow the seed/sprout wiki, it suggests the following workflow:
>
> btrfstune -S 1 seed_dev
> mount seed_dev mnt
> btrfs device add sprout_dev
> mount -o remount,rw mnt
>
> The first mount mounts the FS readonly, which results in not setting
> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> somewhat surprisingly clears the readonly bit on the sb (though the
> mount is still practically readonly, from the users perspective...).
> Finally, the remount checks the readonly bit on the sb against the flag
> and sees no change, so it does not run the code intended to run on
> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
>
> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> does no work. This results in leaking deleted snapshots until we run out
> of space.
>
> I propose fixing it at the first departure from what feels reasonable:
> when we clear the readonly bit on the sb during device add.
>
> A new fstest I have written reproduces the bug and confirms the fix.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

The fix looks good to me, small and keeps the super block ro flag
consistent.

IIRC the old behavior of sprout is, adding device will immediately mark
the fs RW, which is a big surprise changing the RO/RW status.

So the extra Rw remount requirement looks very reasonable to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> Note that this is a resend of an old unmerged fix:
> https://lore.kernel.org/linux-btrfs/16c05d39566858bb8bc1e03bd19947cf2b60=
1b98.1647906815.git.boris@bur.io/T/#u
> Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
> were also explored but not merged around that time:
> https://lore.kernel.org/linux-btrfs/cover.1654216941.git.anand.jain@orac=
le.com/
>
> I don't have a strong preference, but I would really like to see this
> trivial bug fixed. For what it is worth, we have been carrying this
> patch internally at Meta since I first sent it with no incident.
> ---
>   fs/btrfs/volumes.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index dc9f54849f39..84e861dcb350 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2841,8 +2841,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs=
_info, const char *device_path
>   	set_blocksize(device->bdev_file, BTRFS_BDEV_BLOCKSIZE);
>
>   	if (seeding_dev) {
> -		btrfs_clear_sb_rdonly(sb);
> -
>   		/* GFP_KERNEL allocation must not be under device_list_mutex */
>   		seed_devices =3D btrfs_init_sprout(fs_info);
>   		if (IS_ERR(seed_devices)) {
> @@ -2985,8 +2983,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs=
_info, const char *device_path
>   	mutex_unlock(&fs_info->chunk_mutex);
>   	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>   error_trans:
> -	if (seeding_dev)
> -		btrfs_set_sb_rdonly(sb);
>   	if (trans)
>   		btrfs_end_transaction(trans);
>   error_free_zone:


