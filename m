Return-Path: <linux-btrfs+bounces-2170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B084584BEBF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684B42896A2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A031B81C;
	Tue,  6 Feb 2024 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VgOM74A2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C51B957
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251658; cv=none; b=OaGTAWTQxXpV0mJlM0vSSbP0W5JJ2jCx0naM1ccJrXNm6KvpzIPNhj/0yna/sXqtMRsXuH6xS5dVZJOZ+Xr9hrL79WozNDWFI7N7Yu/92QFE5cEyGiCNtilbCROibDo549SRjh5GBsX+kp0Y9sbuioYP1p+Cy0ya59PP+CaLc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251658; c=relaxed/simple;
	bh=HeakIbOoSBejVNuIqJvJbZuU+Nd7ZBcOzDQICMkJKJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZSdji7+UOKrIM2R12aimNMSpPBKBPWOj2HFdqwRXEt8KqgL0050zwVHMbcIAsINIQGOQgCbsGA3QorTorrxKrPTRhUuOKnhujs5BWZhSz/vzS7/B+8qWqHFhReZOxfUExsGm7TV8ZDxmnfcKdm9Cic5hbcghc3MNwuN0zbeu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VgOM74A2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707251649; x=1707856449; i=quwenruo.btrfs@gmx.com;
	bh=HeakIbOoSBejVNuIqJvJbZuU+Nd7ZBcOzDQICMkJKJs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=VgOM74A2FovGFZSuBk5jkBV9XsUqXhBfV/YgF0H8ZzM04qcR+9prToI+A9Pm7TpR
	 aKoMnbJ75MjsirUMULwasIkYAt0WpB9Frss0gmpyRdWXZfW9Y4JaqU6KxuVxJNZm1
	 pz21dFiB5XWXd2av8D+Pd6R4j6gqwrpHWOLMOJKJ22fWAleQZ/pTWJxGZj/zuEpQE
	 Ug4wRFrFfboFepmwd0AX+75JR7PtvESSF/srHOpJi/fGzDD4GPYrqvSwHyGdFI1rx
	 j2HEJX2ThWS2IUhvZTqQPYXTnvLyfYV9LaRGgr3cFQhd6UKvmTGVxQySYKx4Jh1v1
	 rYychsPoi0KJla9pdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWici-1rVLbt1EHg-00X1OY; Tue, 06
 Feb 2024 21:34:09 +0100
Message-ID: <f7338589-046b-42ec-8b1d-c6f247a482d8@gmx.com>
Date: Wed, 7 Feb 2024 07:04:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
 <20240206124642.GM355@twin.jikos.cz>
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
In-Reply-To: <20240206124642.GM355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VACjwo4aBb2CK4K6ITM6j9g/VkwFJdeK7LiiHo+CtGNXz+WGIv8
 XWgZKyOh7QMiP6jCMij5OyPRvQKOzBPl27akXsoudT6XkM3u3nOLqcjbz4gAJ03zhHC6EN1
 ZtpGBJPD2CWBvvuE/Y8RAwwhVm2EIAtV6BNtUXTUBhB9mHij9FJCeTbTIO9CfDhleh+iBzd
 HOrzs0LDoDi9Nz8fWWbxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aQIzL3Ql9pk=;EXfPOESPtg4iN37ZU5bjG7ECoMl
 hKfoa+RjgrW89xr5pZvf5wuGLhOOup9FCUPPE3z3SMh54IE43PwjG6Mqub4FYdW/dlhmMIh9X
 8aEjdJoV+IdDq3Ea7bdkEm6x2Bgvc3TjujZ9B0cHlhPP8Ygtyh9yECTdbuCoCPiNNhjEeDJQf
 dC4osrT0wmXhzyOKNy+CscGS5fcuJcQnCafwbKzMWiqmeb6E/k0zpbR5OrV0WhgBVXFY1x71N
 7Kzd+SaJRjvLiXdu4mn7l8puGFT4NuPRJo4ulnmqWkehUnMVvwK3AeDkW82J2eWFjcc1NFvGX
 qSBnFujMB2CRwE1toiBA7y4MaRMWrcqG0Riid8/Rh1OQ8X2Nd3QdQxjGylVN9rT3puenfcIrd
 +yHTYbhJcPuiGtHDjuo0cwHEH641TFS+nn7ml0FbOkb4OqNXQ3Q82PVeXVdBeWUX2aWiF3kaz
 9y/H0oLsDAHTD0vBCDiT+aj5XpnRqvfIwCPAOjwWbk76cYi7bdvSgMCAoKFKi3VdQ3hEH6ejo
 nPk/ERTg9Dp+sNKidPydp3tqw+cIf9QZ8+PpILLiWo3vsVkjzGMpXap5PJEgX2WeJks6HzA3i
 emjrYscvfmD3aJjc7xhhk0pkoqGA9iwWTlYPB9LAW5nJLXPFSSU1wXu44rVgRuy24oPbJaSZd
 HVlDZRkTEszq77HEYo58jNfpWVfrjNw0iC60ft4+qJ+ncvOIKDC+JLjIPm5847f2T6lu1IJEx
 Qo2pDnBFuQZII45WSREyChC0rD4r1xNAvTljr+D5VCon43U6BCmNUDu5wTN8Wi0hMWxXMfcuY
 znS8gYG8PeJCu9q3n3s1ZDZvlT5h55CrWHs31Wxvfui04=



On 2024/2/6 23:16, David Sterba wrote:
> On Sat, Jan 27, 2024 at 10:18:36AM +1030, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report about very suspicious tree-checker got triggered:
>>
>>    BTRFS critical (device dm-0): corrupted node, root=3D256
>> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
>> expect [256, 18446744073709551360]
>>    BTRFS critical (device dm-0): corrupted node, root=3D256
>> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
>> expect [256, 18446744073709551360]
>>    BTRFS critical (device dm-0): corrupted node, root=3D256
>> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
>> expect [256, 18446744073709551360]
>>    SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=3Ddm=
-0
>> ino=3D5737268
>>
>> [ANALYZE]
>> The root cause is still unclear, but there are some clues already:
>>
>> - Unaligned eb bytenr
>>    The block bytenr is 8550954455682405139, which is not even aligned t=
o
>>    2.
>>    This bytenr is fetched from extent buffer header, not from eb->start=
.
>>
>>    This means, at the initial time of read, eb header bytenr is still
>>    correct (the very basis check to continue read), but later something
>>    wrong happened, got at least the first page corrupted.
>>    Thus we got such obviously incorrect value.
>>
>> - Invalid extent buffer header owner
>>    The read itself is triggered for subvolume 256, but the eb header
>>    owner is 11858205567642294356, which is not really possible.
>>    The problem here is, subovlume id is limited to (1 << 48 - 1),
>>    and this one definitely goes beyond that limit.
>>
>>    So this value is another garbage.
>>
>> We already got two garbage from an extent buffer, which passed the
>> initial bytenr and csum checks, but later the contents become garbage a=
t
>> some point.
>>
>> This looks like a page lifespan problem (e.g. we didn't proper hold the
>> page).
>>
>> [ENHANCEMENT]
>> The current tree-checker only output things from the extent buffer,
>> nothing with the page status.
>>
>> So this patch would enhance the tree-checker output by also dumpping th=
e
>> first page, which would look like this:
>>
>>   page:00000000aa9f3ce8 refcount:4 mapcount:0 mapping:00000000169aa6b6 =
index:0x1d0c pfn:0x1022e5
>>   memcg:ffff888103456000
>>   aops:btree_aops [btrfs] ino:1
>>   flags: 0x2ffff0000008000(private|node=3D0|zone=3D2|lastcpupid=3D0xfff=
f)
>>   page_type: 0xffffffff()
>>   raw: 02ffff0000008000 0000000000000000 dead000000000122 ffff88811e06e=
220
>>   raw: 0000000000001d0c ffff888102fdb1d8 00000004ffffffff ffff888103456=
000
>>   page dumped because: eb page dump
>>   BTRFS critical (device dm-3): corrupt leaf: root=3D5 block=3D30457856=
 slot=3D6 ino=3D257 file_offset=3D0, invalid disk_bytenr for file extent, =
have 10617606235235216665, should be aligned to 4096
>>   BTRFS error (device dm-3): read time tree block corruption detected o=
n logical 30457856 mirror 1
>>
>> >From the dump we can see some extra info, something can help us to do
>> extra cross-checks:
>>
>> - Page refcount
>>    if it's too low, it definitely means something bad.
>>
>> - Page aops
>>    Any mapped eb page should have btree_aops with inode number 1.
>>
>> - Page index
>>    Since a mapped eb page should has its bytenr matching the page
>>    position, (index << PAGE_SHIFT) should match the bytenr of the
>>    bytenr from the critical line.
>>
>> - Page Private flags
>>    A mapped eb page should have Private flag set to indicate it's manag=
ed
>>    by btrfs.
>>
>> Link: https://marc.info/?l=3Dlinux-btrfs&m=3D170629708724284&w=3D2
>
> Please use a link to lore.kernel.org, this keeps the threading and the
> message id is in the url so it's possible to look it up elsewhere.

The problem is, at the time of writing, lore.kernel.org is down...
That's why I have to go marc.info for it.

Just hope the infrastructure would be a little more stable than vger.

Thanks,
Qu
>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> For debugging the patch is useful, I'd say go on and add it.
>
> Reviewed-by: David Sterba <dsterba@suse.com>
>

