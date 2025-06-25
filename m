Return-Path: <linux-btrfs+bounces-14941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5C0AE8026
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9541217201B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00802BF009;
	Wed, 25 Jun 2025 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mHPPZjMi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF092BEFE6;
	Wed, 25 Jun 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848560; cv=none; b=M1/5aGsNZZu7eOEO0o91itfSQz2RsW/bEWPmPeBLQhEvdZm+wA9AriVo0IJZw2vE34I20B76GCETHuPDBbUdytQ+ADtBIkN7hMYBrPPWHspye3dg0k2e02wdZdNn3iLAgmI9EYXeT0+oLsqeH0kCAZKXdrcvzRyKWfyFky835Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848560; c=relaxed/simple;
	bh=8TyEPhpoZhfD6ddqPhg0fvFdIgrblHehvBy/t3x4eYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmDOvzZF1PZTwcmCYQQ/TIX6ejhqtiBhZeTwry5rEeyy3HK/WqEUyTxIg8Bz/xodzWXTwQ/Sji/yl5F27aQ5odRxHNjRRRbAIfK7G9mG4IC73PtYS15Imy+1RcihYBL6rszlpbbw5VtVFB732oaYZ4H3E3BOjMw6eeKKUNob36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mHPPZjMi; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750848553; x=1751453353; i=quwenruo.btrfs@gmx.com;
	bh=TGabQWO/K/w5k77mEM2jGieZSN0UDzuKuKU5gP2u+X0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mHPPZjMirQmNmZkHtljAlTO1Jt6FpiLD4BEaEkeoiuAzZ2K7rID4RAcmNxylkWel
	 SJM6/73Lp/XhTJYGrcHjqGxGYt3DD4pm6OlSAL3NG5cBSOFypirtDbSvbV0ynqvqc
	 IldyZGljpFJDg0jAgsxE7PLtebszZC+tn5nb14schHcTnRe4E56XsbCuEiVFD0pbi
	 DMQ3iUneAf2QLmB+U3MF56/BHbtlULnwcR/kP0U1tnX036yEiT/RZ8gNx1shQne6h
	 ebeOqSAVtkvyLk6a8wbPJgk66M6wSE83xFgX0dEOkslJa6Sjths54kFUEsQQQRglm
	 bcecSYwTcSK2Zn/PtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17UQ-1urrwg2L2g-00uimy; Wed, 25
 Jun 2025 12:49:13 +0200
Message-ID: <063b1e52-0769-403b-ae05-7b999223a1f2@gmx.com>
Date: Wed, 25 Jun 2025 20:19:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] btrfs: fix deadlock in btrfs_read_chunk_tree
To: Hillf Danton <hdanton@sina.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com, clm@fb.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <685aa401.050a0220.2303ee.0009.GAE@google.com>
 <tencent_C857B761776286CB137A836B096C03A34405@qq.com>
 <20250624235635.1661-1-hdanton@sina.com>
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
In-Reply-To: <20250624235635.1661-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7HHxQv8+/KcvF1C6w8QQA5DaoXdHhGWojPrBaPcyRGpeLSBTlRF
 wwNWmAKl0ID3k1DSemCgtfNtb2UJP9G4qdNQVwVagp3s8yo46u+0YMl/4dYbWYDpouNM9D6
 yqdmM4NvSSbvz9ACXd+ZB9eH8rGkWCsbSi8BjmLTfS6Ty1wty+vFQ2ANLJeDic0DIToM3Ol
 1vYy3B49NPR70AzhsjKdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z/Ob2j22Lb8=;ZjVVKH5xgSphmWPD3rhiOsArdEc
 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



=E5=9C=A8 2025/6/25 09:26, Hillf Danton =E5=86=99=E9=81=93:
> On Wed, 25 Jun 2025 06:00:09 +0930 Qu Wenruo wrote:
>> =3DE5=3D9C=3DA8 2025/6/25 00:00, Edward Adam Davis =3DE5=3D86=3D99=3DE9=
=3D81=3D93:
>>> Remove the lock uuid_mutex outside of sget_fc() to avoid the deadlock
>>> reported by [1].
>>> =3D20
>>> [1]
>>> -> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
>>>          lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>>>          down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
>>>          alloc_super+0x204/0x970 fs/super.c:345
>=20
> Given kzalloc [3], the syzbot report is false positive (a known lockdep
> issue) as nobody else should acquire s->s_umount lock.
>=20
> [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git/tree/fs/super.c?id=3D7aacdf6feed1#n319

Not a false alert either.

sget_fc() can return an existing super block, we can race between a=20
mount and an unmount on the same super block.

In that case it's going to cause problem.

This is already fixed in the v4 (and later v5) patchset:

https://lore.kernel.org/linux-btrfs/cover.1750724841.git.wqu@suse.com/

Thanks,
Qu

>=20
>>>          sget_fc+0x329/0xa40 fs/super.c:761
>>>          btrfs_get_tree_super fs/btrfs/super.c:1867 [inline]
>>>          btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
>>>          btrfs_get_tree+0x4c6/0x12d0 fs/btrfs/super.c:2093
>>>          vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
>>>          do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>>>          do_mount fs/namespace.c:4239 [inline]
>>>          __do_sys_mount fs/namespace.c:4450 [inline]
>>>          __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>>>          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>          do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>>>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> =3D20
>>> -> #0 (uuid_mutex){+.+.}-{4:4}:
>>>          check_prev_add kernel/locking/lockdep.c:3168 [inline]
>>>          check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>>>          validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>>>          __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>>>          lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>>>          __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>>>          __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
>>>          btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462
>>>          open_ctree+0x17f2/0x3a10 fs/btrfs/disk-io.c:3458
>>>          btrfs_fill_super fs/btrfs/super.c:984 [inline]
>>>          btrfs_get_tree_super fs/btrfs/super.c:1922 [inline]
>>>          btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
>>>          btrfs_get_tree+0xc6f/0x12d0 fs/btrfs/super.c:2093
>>>          vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
>>>          do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>>>          do_mount fs/namespace.c:4239 [inline]
>>>          __do_sys_mount fs/namespace.c:4450 [inline]
>>>          __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>>>          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>          do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>>>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> =3D20
>>> other info that might help us debug this:
>>> =3D20
>>>    Possible unsafe locking scenario:
>>> =3D20
>>>          CPU0                    CPU1
>>>          ----                    ----
>>>     lock(&type->s_umount_key#41/1);
>>>                                  lock(uuid_mutex);
>>>                                  lock(&type->s_umount_key#41/1);
>>>     lock(uuid_mutex);
>>> =3D20
>>>    *** DEADLOCK ***
>>> =3D20
>>> Fixes: 7aacdf6feed1 ("btrfs: delay btrfs_open_devices() until super bl=
oc=3D
>> k is created")
>>> Reported-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=3D3Dfa90fcaa28f5cd4b1f=
c1
>>> Tested-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
>>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>>> ---
>>>    fs/btrfs/super.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>> =3D20
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 237e60b53192..c2ce1eb53ad7 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -1864,11 +1864,10 @@ static int btrfs_get_tree_super(struct fs_cont=
ex=3D
>> t *fc)
>>>    	fs_devices =3D3D device->fs_devices;
>>>    	fs_info->fs_devices =3D3D fs_devices;
>>>   =3D20
>>> +	mutex_unlock(&uuid_mutex);
>>
>> No, you can not unlock uuid_mutex without opening the devices.
>>
>> Just run the test case generic/604.
>>
>>>    	sb =3D3D sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
>>> -	if (IS_ERR(sb)) {
>>> -		mutex_unlock(&uuid_mutex);
>>> +	if (IS_ERR(sb))
>>>    		return PTR_ERR(sb);
>>> -	}
>>>   =3D20
>>>    	set_device_specific_options(fs_info);
>>>   =3D20
>>> @@ -1887,6 +1886,7 @@ static int btrfs_get_tree_super(struct fs_contex=
t =3D
>> *fc)
>>>    		 * But the fs_info->fs_devices is not opened, we should not let
>>>    		 * btrfs_free_fs_context() to close them.
>>>    		 */
>>> +		mutex_lock(&uuid_mutex);
>>>    		fs_info->fs_devices =3D3D NULL;
>>>    		mutex_unlock(&uuid_mutex);
>>>   =3D20
>>> @@ -1906,6 +1906,7 @@ static int btrfs_get_tree_super(struct fs_contex=
t =3D
>> *fc)
>>>    		 */
>>>    		ASSERT(fc->s_fs_info =3D3D=3D3D NULL);
>>>   =3D20
>>> +		mutex_lock(&uuid_mutex);
>>>    		ret =3D3D btrfs_open_devices(fs_devices, mode, sb);
>>>    		mutex_unlock(&uuid_mutex);
>>>    		if (ret < 0) {
>=20



