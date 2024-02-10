Return-Path: <linux-btrfs+bounces-2300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B185036A
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 08:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E35C1C2302F
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8DB37706;
	Sat, 10 Feb 2024 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="d02Cpp3E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578D376F3
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551405; cv=none; b=LM1Wz16LmrkVA1EpD9HUEog906AS48vhv9Odi7uZmA2Ir+AEE12vf18VXcZojPZm5W0kLuZVLxxnhrpnR9bqVE1yAPi7ZveJJ0oJATSbunvTS8pUyg8vg8fRuJF4OSFr184/+h+VffJXPPEo15bRmYK9AT6lHPgKgLz/9gSKdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551405; c=relaxed/simple;
	bh=YhRxChoLZ6LkhPCC84Oc9gNTQhEkXoVNPi6HH4VYol8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VDgFnrsfTnRgeelf0rYgK8mBpovdhsLw8XQbDgAvklst+0wr1291poowk5JNDkDjGpIm8SdBx1uklezquv5k/tdtxHgjzORjfqCJqxb191zXXAhqppXIhKqmL+HzyKs6mZC6dS5PVSlL+Hx3AynfqchX3gVqpPE73H05GOSmwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=d02Cpp3E; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707551397; x=1708156197; i=quwenruo.btrfs@gmx.com;
	bh=YhRxChoLZ6LkhPCC84Oc9gNTQhEkXoVNPi6HH4VYol8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=d02Cpp3EkbJoqhfgqeG+Fc86Y76U+CT1FrtaMO09n+ayhI3lKEs7kHO4T0sxOfT7
	 CKaSAFznSAEw1RD1Rea4UHx7G3QWnHVKepRUWbEL4QJvvzsPJlXZvYr8ZHNueDLLq
	 SVhER7PQTK9CdVmi5mbhmyy77Qt2Ip3YiWHLlWN4Wq96bh6UOY1kngd5QL9CmUJSK
	 X8RRmv84NMSGBoOGlcbC3HuYqgo7dQTmJCqodwtGoN/Pr6d9YdYX7EdZZQVrC5ZGH
	 f3ijQSTTL16+GYSw2JM5T8J048Bo2oJb4lDE/0ZgzHJ6+A5mDH9RRLkAL9ZY6Bz3S
	 cCCQYJxl/O5M8uBCEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1rWHQT3a8H-00XLqb; Sat, 10
 Feb 2024 08:49:57 +0100
Message-ID: <475562bb-a26d-4214-bbfd-feb9aa77645d@gmx.com>
Date: Sat, 10 Feb 2024 18:19:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] btrfs: remove do_list variable at
 btrfs_set_delalloc_extent()
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707491248.git.fdmanana@suse.com>
 <f8cf816e7c4d397c41bb2872ef75cd1fa7bdfd44.1707491248.git.fdmanana@suse.com>
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
In-Reply-To: <f8cf816e7c4d397c41bb2872ef75cd1fa7bdfd44.1707491248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3DM1YXi1WYeCEkhJRBeiJcjmevWTkazsjILR7qrRVSaHz7iOS8c
 OQJAqS7oTQViXJbclmsw0OykZJQvQAeK1Fr4LGj/oApUcxAYJXL2hLOiSC4KrvL1IOwqLOE
 3jsqUf/FFrcTMmbh2+7z+/p3jwnBkysNTYT7KE1Q4W59hdW0/cFB/2PWPVZxnqAX6bdD6tD
 I8Rf1jGWDi34JFB9EgWYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oKQjVZc6N7Y=;sxkr/uIRuo7qN48VMdTLl/iUwfD
 GwAiq/+BYKurd0CTLnj4sXjacz+Fzc31l3sBYRCCzp58am+bLcd1k97lHTwLU5z2YcUi6Iv/M
 2i2JV3M39kTZGDHKr+j+MrNACKmTafZOTmpnE/6NOcwMQKgENqq3Ym11uY1QJoCv3pF1iDRMM
 oJ1TnL/lWcAzbW3wrRDnlBknftYgkJU3kL6eW6AvaSrVNBXBi531GHm/3xtKhPZina+vZLAsF
 C8+nK3UVWaKqnMlVqVeZvgIq5QC76r3Fz/f9rlh4+bUfLeUb7tH6J1wJFaTKU0OstzHgImv/d
 rZ0xJoB8MfbcnoFNubfDq2Ff93KpN8G/czXde1ldy+8nIs0qDQS4wb7u2zfawA96e/r+0YDJQ
 41PF/aT1BGw52GDPLV/FBs4u64zLcdIF407PuJuf2AoFPB4E/5DbGZUixSPKlZfhzvodCVSfc
 chJQrN3KjrLOXwCunvWyRd7gMHY39qjA7J9w2N1ggLwUIMarGnvBhWVHiDJNrc2QG8TKkc4b1
 pFZn4/zd8yP6mxswOy3jf6cRu1pQTMlTBGRs2yjAGzGdZubzrwziRQCnpMNekwYDr0fgGGmAm
 DgY7TTEaAqB++IpylT8KP1Wfct1onsdpBCzZ0uAILwmvE9P6RYnE9f/LRzxIdbgcdfZbw6wMF
 Uel45c/NwZcWVwlfwBGegxUs50NYUadpmoovR+SeP0GtUG6t7ye6ZSI7FW4/8Q6EZonJ9clsm
 PbRx/AwMPy2SkuRtSAJA5tSDcFEHsSyLeNuMsfM8yTIee61Gr/UAvTtacsk5VBtPbOZE2CW7L
 ENHIPLa/NN7OOcVOK7bHiFK8YNDfHvXIIkXASAdLTPASk=



On 2024/2/10 04:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The "do_list" variable is only used once, plus its name/meaning is a bit
> confusing, so remove it and directory use btrfs_is_free_space_inode().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fe962a6045fd..17b6ab71584a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2462,7 +2462,6 @@ void btrfs_set_delalloc_extent(struct btrfs_inode =
*inode, struct extent_state *s
>   		u64 len =3D state->end + 1 - state->start;
>   		u64 prev_delalloc_bytes;
>   		u32 num_extents =3D count_max_extents(fs_info, len);
> -		bool do_list =3D !btrfs_is_free_space_inode(inode);
>
>   		spin_lock(&inode->lock);
>   		btrfs_mod_outstanding_extents(inode, num_extents);
> @@ -2487,7 +2486,7 @@ void btrfs_set_delalloc_extent(struct btrfs_inode =
*inode, struct extent_state *s
>   		 * and are therefore protected against concurrent calls of this
>   		 * function and btrfs_clear_delalloc_extent().
>   		 */
> -		if (do_list && prev_delalloc_bytes =3D=3D 0)
> +		if (!btrfs_is_free_space_inode(inode) && prev_delalloc_bytes =3D=3D 0=
)
>   			btrfs_add_delalloc_inode(inode);
>   	}
>

