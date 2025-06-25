Return-Path: <linux-btrfs+bounces-14961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2BDAE9031
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 23:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976601C259E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D56216392;
	Wed, 25 Jun 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kldshr1W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4420F098;
	Wed, 25 Jun 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886970; cv=none; b=h9rfv7JMdN6R0hpd8riA3gtmNAVnk5W/Rhs73X+kW5Lnui9kuTdDZjkiRPhmeGzC3REYyO5k2/V+AiclK+9fk/j8JwVi08PBs+lhFjImThyorWC5O98HSv7J03m0J5xROtTCGinIvWwIAaXBIGTtmpufdi7CjXHEfujVtWWdH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886970; c=relaxed/simple;
	bh=wTXo9tMudXa93WSIRW+Xz2EJ2P7pRbYzyI6gQJQEPyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNnflJQgPyUnyY/IJYgmcrtnQXSbhWQS7uxr5DXQsWGO2jjXsLrixzL51VpbnHAbalkIy24KGMeZwJIufBLlo6GRb2kEMpBK5hkeO0MmqUSsK+yuXudZu0w6s27s95lIX2oZcB51QJF35CEMRZQl8iskcFnWLEN+/8fn92qeXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kldshr1W; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750886960; x=1751491760; i=quwenruo.btrfs@gmx.com;
	bh=OAMHyI553J+EZn8j9qznP6SW6dApO3tpRnZfvaO6tEI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kldshr1WWyg6LZ4YEUkrxBtdnNbwj6+1XPxrFhz+yv/ux05SI0DJwKb2PkSscgOw
	 GtpRoI6gc+Sjkkol50O7sC7Y4OJH/D3bs/VNlPziTgn3Ujuorlx/W9pggG8Bxq2Bv
	 DK2F76C1tUQJOPpqJ29CKyUvLubwfbiGuAPFgnrkjM19Yp3TPtQu41XUatRIgQwVb
	 1rk0aUNzJHr/CJAmwkirHQhGwQVZPgdK3o0iu809XnWNw7Ux8ZktPNlT18bqaGaDU
	 slazAJ8NOGnLFlumHy6n+v/hex3CDaQH0EDJFgBW7JShECnxTC/rmMhdLRS84Ifu7
	 zymQvvIH32s/meLxSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1uI5643ivD-00OTkg; Wed, 25
 Jun 2025 23:29:20 +0200
Message-ID: <1d765fc0-e971-4c8b-95ab-4cdfcea183c8@gmx.com>
Date: Thu, 26 Jun 2025 06:59:14 +0930
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
 <20250625124052.1778-1-hdanton@sina.com>
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
In-Reply-To: <20250625124052.1778-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qz5aZ0ppy4Ka2eHrZusZ+Gy7g+NnrQuV7iknxUg/3jGO7o0Ix00
 Rp3zCgOzrBI5ii2711sFsqug398UBt0D+26kyHfvOJQ84QWeO/GEYAprSGfP/tAeRT0KcrA
 E9uMT1eF2ZeVKMF9prxxRVG8FNwE+aadJyhVl7KlEARKB0mSTFaPFOoguKJU4fe+Ov/bfnJ
 gfMSFcht+hhiw73Apvx2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EjURbuOFJ+c=;1Acu9o0kv2JMWnh3E7Mi4rHHqtC
 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
 nVOOqTtVKn+9muEfKbBcZTeYICsl71ss=



=E5=9C=A8 2025/6/25 22:10, Hillf Danton =E5=86=99=E9=81=93:
> On Wed, 25 Jun 2025 20:19:06 +0930 Qu Wenruo wrote:
>> =3DE5=3D9C=3DA8 2025/6/25 09:26, Hillf Danton =3DE5=3D86=3D99=3DE9=3D81=
=3D93:
>>> On Wed, 25 Jun 2025 06:00:09 +0930 Qu Wenruo wrote:
>>>> =3D3DE5=3D3D9C=3D3DA8 2025/6/25 00:00, Edward Adam Davis =3D3DE5=3D3D=
86=3D3D99=3D3DE9=3D
>> =3D3D81=3D3D93:
>>>>> Remove the lock uuid_mutex outside of sget_fc() to avoid the deadloc=
k
>>>>> reported by [1].
>>>>> =3D3D20
>>>>> [1]
>>>>> -> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
>>>>>           lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>>>>>           down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
>>>>>           alloc_super+0x204/0x970 fs/super.c:345
>>> =3D20
>>> Given kzalloc [3], the syzbot report is false positive (a known lockde=
p
>>> issue) as nobody else should acquire s->s_umount lock.
>>> =3D20
>>> [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.=3D
>> git/tree/fs/super.c?id=3D3D7aacdf6feed1#n319
>>
>> Not a false alert either.
>>
>> sget_fc() can return an existing super block, we can race between a=3D2=
0
>> mount and an unmount on the same super block.
>>
>> In that case it's going to cause problem.
>>
>> This is already fixed in the v4 (and later v5) patchset:
>>
>> https://lore.kernel.org/linux-btrfs/cover.1750724841.git.wqu@suse.com/
>>
> Can v5 survive the syzbot test?

Yes, I enabled lockdep during v5 tests.

