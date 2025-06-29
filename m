Return-Path: <linux-btrfs+bounces-15065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8BAECB3B
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 06:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C3D7A9CBE
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 04:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20091C5499;
	Sun, 29 Jun 2025 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XszsB1BX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84335959;
	Sun, 29 Jun 2025 04:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171284; cv=none; b=hjj0coWKblO1bOJot+f7/SSnRAR8laH+6++kVvvM5TOtWqDHaW/fHp/wImRMKdZXYAYqkIHOkYy9S79Lt7vAJB5x9JyNuuuDJNphk6XTUo5bZcvSfzmyf09rhuGf/9NpUxfzyNWUD4X0wPjMLUmodFPFvWWPgG/ddXjVJzlo2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171284; c=relaxed/simple;
	bh=xlu3cnujlA5I8uT1VZHLLgAKcBgDbqVlHFxE9NBmNAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwI6DBagipKEDjS5VfoBbIzOFmJHSeWB7Vqz8hxAhOZyzm2Jm2UFDqXg8CDP3KZ+k7FC+Fotm6rEGSZlRaVzZKWLoukl7Ij7zYuvldRwCulXRpfftq/uU8ixgMugVBKAl1TmDEkEEWtvDm/zqlZjqH2lBVjIPzdth+u+CDXGYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XszsB1BX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751171270; x=1751776070; i=quwenruo.btrfs@gmx.com;
	bh=tW7y9mJ3/umhJnddrynSQLOYCyDsh3iqD4iQ3oex8Zc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XszsB1BXu0nI8UB/5MRUZhB/gJ1Sg0YZuZvY8iEjYTP12RTnj/cgWY+ncz4uy0ew
	 h4SNbOCieHlOpXnDA9sXpWGskP1mPrGoWYDnqdMLK9RrWMLOlNn0GpmJTuXHipM6d
	 RJQHfEcXNojSJYimv7z23lW6yF8AQL9AE0FWiRnbO8Cg71Z0qP9Ht1RSNpkoTLt2c
	 88xPCmddyQ9wp2cG6TcvnUFCXlQ7ZT4pippDsr5iOE1IovMf+nmj7jj5FXXdnO1tD
	 XhxuCphQDH+oIJC2L55p64QYct2KZDM5hMiSfQtpmc/5yqKriwlRtkzyv921zacmU
	 yz5zWlwHeKKBA8AmAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1uYDgS1SRN-00CXuB; Sun, 29
 Jun 2025 06:27:49 +0200
Message-ID: <9e589f47-3fa2-4479-b809-5c1b91e7356f@gmx.com>
Date: Sun, 29 Jun 2025 13:57:43 +0930
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
 <20250625234420.1798-1-hdanton@sina.com>
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
In-Reply-To: <20250625234420.1798-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZskNDeUdzrHqq3xbanMrHYXgWR++lQ52xbEiDidw6Yg0SAVUXvy
 /CAqdCqHETo48aYYr2/luY1l2qShblz0XeMdsQ6q8F+8yvBA22piOYtssZ6tVeE3tLQom/i
 NeWCOI49D+6BjA0+2xY+IsC7UxwTpOGnRtIvEF1o+7SqaVOD+0XqkasPstIw3IW65YHc1zL
 xVZOIBp+9qthWST81JGDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1eZvRjvMO6Y=;ZypaJieInlyWaWznT6PMzFHlH/Z
 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



=E5=9C=A8 2025/6/26 09:14, Hillf Danton =E5=86=99=E9=81=93:
> On Thu, 26 Jun 2025 06:59:14 +0930 Qu Wenruo wrote:
>> =3DE5=3D9C=3DA8 2025/6/25 22:10, Hillf Danton =3DE5=3D86=3D99=3DE9=3D81=
=3D93:
>>> On Wed, 25 Jun 2025 20:19:06 +0930 Qu Wenruo wrote:
>>>> =3D3DE5=3D3D9C=3D3DA8 2025/6/25 09:26, Hillf Danton =3D3DE5=3D3D86=3D=
3D99=3D3DE9=3D3D81=3D
>> =3D3D93:
>>>>> On Wed, 25 Jun 2025 06:00:09 +0930 Qu Wenruo wrote:
>>>>>> =3D3D3DE5=3D3D3D9C=3D3D3DA8 2025/6/25 00:00, Edward Adam Davis =3D3=
D3DE5=3D3D3D=3D
>> 86=3D3D3D99=3D3D3DE9=3D3D
>>>> =3D3D3D81=3D3D3D93:
>>>>>>> Remove the lock uuid_mutex outside of sget_fc() to avoid the deadl=
oc=3D
>> k
>>>>>>> reported by [1].
>>>>>>> =3D3D3D20
>>>>>>> [1]
>>>>>>> -> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
>>>>>>>            lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>>>>>>>            down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:169=
3
>>>>>>>            alloc_super+0x204/0x970 fs/super.c:345
>>>>> =3D3D20
>>>>> Given kzalloc [3], the syzbot report is false positive (a known lock=
de=3D
>> p
>>>>> issue) as nobody else should acquire s->s_umount lock.
>>>>> =3D3D20
>>>>> [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-n=
ex=3D
>> t.=3D3D
>>>> git/tree/fs/super.c?id=3D3D3D7aacdf6feed1#n319
>>>>
>>>> Not a false alert either.
>>>>
>>>> sget_fc() can return an existing super block, we can race between a=
=3D3D2=3D
>> 0
>>>> mount and an unmount on the same super block.
>>>>
>>>> In that case it's going to cause problem.
>>>>
>>>> This is already fixed in the v4 (and later v5) patchset:
>>>>
>>>> https://lore.kernel.org/linux-btrfs/cover.1750724841.git.wqu@suse.com=
/
>>>>
>>> Can v5 survive the syzbot test?
>>
>> Yes, I enabled lockdep during v5 tests.
>>
> Fine, feel free to show us the Tested-by syzbot gave you.
>=20

Here you go:

https://lore.kernel.org/linux-btrfs/685d3d4c.050a0220.2303ee.01ca.GAE@goog=
le.com/

That's based on a branch with extra patches though.



