Return-Path: <linux-btrfs+bounces-17831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810CBDDE96
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D6C74F8617
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2021F31B822;
	Wed, 15 Oct 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="A/TTWGps"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02731815E;
	Wed, 15 Oct 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522867; cv=none; b=pFpZus9fCTk4EYo7CEWNmcm6zvMD+rD17BdOQg24+Mcha+O8Ic+i+lTf9JCh9ygRmWXVUuIqidli/iczA7Br2wL1nqzVWB4ELitKfjh4q7OJMbY7xiQfkhxyd6+7mkflfD50RVpeWweMVgjJppakohOjPS6c2dLc08rjVuDXf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522867; c=relaxed/simple;
	bh=TPyq3SJmD6s/JzjvOJcIgsSULStDMGM70zoQ8ZORMOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+v0FKNR3caFRkD8Zdp9N1tlnaFCR6cEUOJFP59Q1xF3hBDseZQxhgTPcdrtYLxU4VeIbnTktocTpqEciZUK24zt4U7c5x3VqQwAiVSilsyPKbYZN+LtZDtjQAuWZKaFnpIcQ/JZ8I07PfvPR2501ZqcgXAiF2OAtHX3Q4SRWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=A/TTWGps; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760522862; x=1761127662; i=quwenruo.btrfs@gmx.com;
	bh=TPyq3SJmD6s/JzjvOJcIgsSULStDMGM70zoQ8ZORMOw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A/TTWGpsIlsYhIccRcBAPB1xXmGtLJloaquiKH6VFbw1fzqSxebPVMn061lcgVSP
	 6tTFUKlMq+bRy0xYZJ/Q4R1znzoYlh0ZKwRhylHiRUzd5ag1baIupc4VXzbaK19Xx
	 kFRK5opk9atIbXX6LuGvEM6QfM9gWvKojj5McOA8OiV6TNXw2GQ3LdsgP2mIdG+Cv
	 9IUI3pxtiN2LZqxOcr3I3oH2ZbpIISpDwsxg1CE48V4gJ/p0vk+u53pvLuxBPyo8Z
	 Rok9wQuzt+8Y5ETurTwa5KAXQnJovlTV3ISrBzpoSHJLP2t5ej84ZlwLORQM+Tg2Y
	 xh3NSDvZd06oIs1KaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJlc-1uPz580ivc-00iXHi; Wed, 15
 Oct 2025 12:07:42 +0200
Message-ID: <eab56dc2-2404-44e0-b950-77342642a2a7@gmx.com>
Date: Wed, 15 Oct 2025 20:37:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix NULL pointer access in
 btrfs_check_leaked_roots()
To: Dewei Meng <mengdewei@cqsoftware.com.cn>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 josef@toxicpanda.com
References: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
 <6a2bb5c7-0aab-4662-938f-38b8e2372338@gmx.com>
 <3745f0a8-9560-4329-8f76-b827305d6bd8@cqsoftware.com.cn>
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
In-Reply-To: <3745f0a8-9560-4329-8f76-b827305d6bd8@cqsoftware.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BUTijsP+3rWh7971CC22UY7AxyL525/2qoDG6k4xRpb5Yyj8qZ7
 MCieigauCLgFYHwmBAOrzgrk43JaigcEoecb/ckuWdHGNK27bDYaZZtauQCIxpUwG61Ei1T
 PhOTwSwQwnMqd78m/OvFQGAOCwrTW5HqqLbR0SONtx2LHASLIB+EwRgD56UCbDv0VGbvMfp
 7W47kr4G/6WDhaC9ZQ4gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3YG8VwI6rPw=;V5hh72ht0hTrdKJaL/jQwITlMQr
 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
 4IaqQ==



=E5=9C=A8 2025/10/15 20:32, Dewei Meng =E5=86=99=E9=81=93:
>=20
> =E5=9C=A8 2025/10/15 16:24, Qu Wenruo =E5=86=99=E9=81=93:
>>
>>
>> =E5=9C=A8 2025/10/15 17:54, Dewei Meng =E5=86=99=E9=81=93:
>>> If fs_info->super_copy or fs_info->super_for_commit is NULL in
>>> btrfs_get_tree_subvol(),
>>
>> Please reorganize this sentence. It would be way more easier to read=20
>> by just saying something like "If memory allocation failed for=20
>> fs_info->super_copy or fs_info->super_for_commit in=20
>> btrfs_get_tree_subvol()".
> I agree, I will fix these words to make them easier to read.
>>
>>> the btrfs_check_leaked_roots() will get the
>>> btrfs_root list entry using the fs_info->allocated_roots->next
>>> which is NULL.
>>>
>>> syzkaller reported the following information:
>>> =C2=A0=C2=A0 ------------[ cut here ]------------
>>> =C2=A0=C2=A0 BUG: unable to handle page fault for address: fffffffffff=
ffbb0
>>> =C2=A0=C2=A0 #PF: supervisor read access in kernel mode
>>> =C2=A0=C2=A0 #PF: error_code(0x0000) - not-present page
>>> =C2=A0=C2=A0 PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>>> =C2=A0=C2=A0 Oops: Oops: 0000 [#1] SMP KASAN PTI
>>> =C2=A0=C2=A0 CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8=
 #4=20
>>> PREEMPT(lazy)
>>> =C2=A0=C2=A0 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (.=
..)
>>> =C2=A0=C2=A0 RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:=
23 [inline]
>>> =C2=A0=C2=A0 RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arc=
h-=20
>>> fallback.h:457 [inline]
>>> =C2=A0=C2=A0 RIP: 0010:atomic_read include/linux/atomic/atomic-=20
>>> instrumented.h:33 [inline]
>>> =C2=A0=C2=A0 RIP: 0010:refcount_read include/linux/refcount.h:170 [inl=
ine]
>>> =C2=A0=C2=A0 RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/d=
isk-=20
>>> io.c:1230
>>> =C2=A0=C2=A0 [...]
>>> =C2=A0=C2=A0 Call Trace:
>>> =C2=A0=C2=A0=C2=A0 <TASK>
>>> =C2=A0=C2=A0=C2=A0 btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1=
280
>>> =C2=A0=C2=A0=C2=A0 btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:=
2029
>>> =C2=A0=C2=A0=C2=A0 btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>>> =C2=A0=C2=A0=C2=A0 vfs_get_tree+0x98/0x320 fs/super.c:1759
>>> =C2=A0=C2=A0=C2=A0 do_new_mount+0x357/0x660 fs/namespace.c:3899
>>> =C2=A0=C2=A0=C2=A0 path_mount+0x716/0x19c0 fs/namespace.c:4226
>>> =C2=A0=C2=A0=C2=A0 do_mount fs/namespace.c:4239 [inline]
>>> =C2=A0=C2=A0=C2=A0 __do_sys_mount fs/namespace.c:4450 [inline]
>>> =C2=A0=C2=A0=C2=A0 __se_sys_mount fs/namespace.c:4427 [inline]
>>> =C2=A0=C2=A0=C2=A0 __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>>> =C2=A0=C2=A0=C2=A0 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inli=
ne]
>>> =C2=A0=C2=A0=C2=A0 do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.=
c:94
>>> =C2=A0=C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> =C2=A0=C2=A0 RIP: 0033:0x7f032eaffa8d
>>> =C2=A0=C2=A0 [...]
>>>
>>> This should check if the fs_info->allocated_roots->next is NULL before
>>> accessing it.
>>>
>>> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
>>> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
>>> ---
>>> =C2=A0 fs/btrfs/disk-io.c | 3 +++
>>> =C2=A0 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 0aa7e5d1b05f..76db7f98187a 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct=20
>>> btrfs_fs_info *fs_info)
>>> =C2=A0 #ifdef CONFIG_BTRFS_DEBUG
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root;
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (!fs_info->allocated_roots.next)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +
>>
>> The check looks too adhoc to me.
>>
>> It would be much easier to just call kvfree() in the error handling of=
=20
>> super_copy/super_for_commit allocation, we do not and should not call=
=20
>> btrfs_free_fs_info() before calling btrfs_init_fs_info().
>=20
> It is a good solution to fix this bug, or can we put the=20
> 'btrfs_init_fs_info(fs_info)' before super_copy/super_for_commit=20
> allocation?

That also sounds fine to me.

>=20
> Thanks,
>=20
> Dewei Meng
>=20
>>
>> Thanks,
>> Qu
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!list_empty(&fs_info->allocated_=
roots)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buf[BTRFS_=
ROOT_NAME_BUF_LEN];
>>
>>
>>


